#!/usr/bin/env ruby

# 
# == Synopsis
#
# Classes for creating/managing tsung xml elements
#
# Author:: Kyle Campos (mailto:kcampos@rsmart.com)
#

require 'rubygems'

# Need class variables for elements to check whether they've been written
# These elements map to xmlelements that can only be written once
#@@tsung_xml_written       = false
@@session_element         = {}
@@transaction_element     = {}

# Flag controlling if latest request pointed to an external server
# Need to give FQ reuest next to get it back
@@last_req_external = false
# Force https write if config.ssl == true and last request wasn't FQ'd
@@last_req_fq = false

# Main Sessions class, most often called from creating Session object
# This will write the 'sessions' xml elements
class TsungSessions

  attr_accessor :config
  attr_reader   :xml, :log, :tsung_element, :sessions_element
  
  def initialize(config)
    config.log.debug_msg("TsungSessions-> entering initialize...")
    @config           = config
    self.config.log.debug_msg("Created TsungSessions: #{self.to_s}")
  end
  
  def to_s
    "TsungSessions-> Config: #{@config} xml_writer: #{@xml_writer} log: #{@log} tsung_element: #{@tsung_element} sessions_elements: #{@sessions_element}"
  end
end


# Individual session object. Writes the '<session>' xml element
class Session < TsungSessions
  
  attr_accessor :name, :probability, :type, :last_req_external
  attr_reader :session_element, :transactions
  
  def initialize(config, session_name, probability='100%', type='ts_http')
    config.log.debug_msg("Session-> entering initialize...")
    super(config)
    @name = session_name
    @probability = probability
    @type = type
    @@session_element[@name] = {} if(!@@session_element[@name])
    
    # Check if this specific session element has been written
    if(!@@session_element[@name][:written])
      config.log.debug_msg("Session-> entering write_xml_elements...")
      @@session_element[@name][:element] = self.config.sessions_element.add_element('session', {"name" => @name, "probability" => @probability, "type" => @type})
      @@session_element[@name][:written] = true

      # Add elements for each import file
      config.import_files.each_key do |import_file|
        
        dynvars = @@session_element[@name][:element].add_element('setdynvars', 
          {"sourcetype" => "file", "fileid" => config.import_files[import_file][:id], "delimiter" => ",", "order" => config.import_files[import_file][:order]})
        
        config.import_files[import_file][:vars].each { |var| dynvars.add_element('var', {"name" => var}) }
        
      end
      
      # Add random string generators
      config.dynvar_random_strings.each_key do |var_id|
        config.log.debug_msg("Adding random variable #{var_id} with length #{config.dynvar_random_strings[var_id]['length']}")
        dynvars = @@session_element[@name][:element].add_element('setdynvars', {
          'sourcetype' => 'random_string',
          'length' => config.dynvar_random_strings[var_id]['length']
        })
        
        dynvars.add_element('var', { 'name' => var_id })
      end
    end

    @transactions = []
    
    config.log.debug_msg("Created session: #{self.to_s}")
  end
  
  # Add a transaction object to this session object
  def add_transaction(txn_name)
    txn = Transaction.new(txn_name, @config, @name, @probability, @type)
    @transactions << txn
    return txn
  end
  
  def to_s
    "Session-> Name: #{@name} Probability: #{@probability} Type: #{@type} session_element: #{@session_element}"
  end
end

# Individual transaction with many requests. Writes '<transaction>' xml element
class Transaction < Session
  
  attr_accessor :txn_name
  attr_reader :transaction_element, :request
  
  def initialize(txn_name, config, session_name, probability='100%', type='ts_http')
    config.log.debug_msg("Transaction-> entering initialize...")
    super(config, session_name, probability, type)
    @txn_name    = txn_name # Need to verify it's valid format - lowercase alpha + underscores
    @@transaction_element[@txn_name] = {} if(!@@transaction_element[@txn_name])
    
    # Check if transaction element has been written yet
    if(!@@transaction_element[@txn_name][:written])
      config.log.debug_msg("Transaction-> entering write_xml_elements...")
      @@transaction_element[@txn_name][:element] = @@session_element[session_name][:element].add_element('transaction', {"name" => @txn_name})
      @@transaction_element[@txn_name][:written] = true
    end
    
    config.log.debug_msg("Created Transaction: #{@txn_name}")
  end
  
  # Creates Requests object that contains all requests
  def add_requests
    @request = Requests.new(@txn_name, self.config, self.name, self.probability, self.type)
  end

  # Returns all requests contained in this transaction
  def requests
    @requests_obj.list
  end
  
end


# Object container for all requests inside the transaction
class Requests < Transaction
  
  attr_accessor :list, :http_mode
  attr_reader :xml_element
  
  def initialize(txn_name, config, session_name, probability='100%', type='ts_http')
    config.log.debug_msg("Requests-> entering initialize...")
    super(txn_name, config, session_name, probability, type)
    @list = [] # request list
    @xml_element = @@transaction_element[txn_name][:element]
    
    # Create request URL for rpc hack
    # Only works with 1 server BUG
    @http_mode = (config.ssl ? 'https' : 'http')
    #@url = "#{http_mode}://#{config.servers[0]}"
    #@url << "/#{config.context}" if(!config.context.empty?)
    #config.log.debug_msg("Request base URL: #{@url}")
    config.log.debug_msg("Created Request container")
  end
  
  # Custom accessor so we pull in the new http_mode value on every request
  # This allows for mixed http/https sessions
  def url
    @url = "#{@http_mode}://#{self.config.servers[0]}"
    @url << "/#{self.config.context}" if(!self.config.context.empty?)
    self.config.log.debug_msg("Request base URL: #{@url}")
    @url
  end
  
  # Add a request to the container
  #
  # Option: DEFAULT_VALUE
  # * 'method': 'GET'
  # * 'version': '1.1'
  #
  # Other options that are valid
  # * 'subst': 'true'
  def add(url, opts={}, req_opts={})
    
    defaults = {
      "method" => 'GET',
      "version" => '1.1',
      "url" => url,
      :auth => {} #accepts {:username => 'user_id', :password => 'pass'} hash
    }
    
    # This is used to tell Tsung if we want a dynamic substitution
    req_defaults = {
      "subst" => 'false',
      :ssl => self.config.ssl,
      :dyn_variables => {
        # "name"
        # "re"
      },
      :custom_headers => {},
      :secondary_server_req => nil,
      :external => false
    }

    opts = defaults.merge(opts)
    req_opts = req_defaults.merge(req_opts)
    @http_mode = (req_opts[:ssl] ? 'https' : 'http')
        
    # Split the hashes to take our dyn_variable
    #dyn_variables = req_opts.reject{|k,v| k == "subst"}[:dyn_variables]
    auth_opt = opts.select{|k,v| k == :auth}
    opts.reject!{|k,v| k == :auth}
    dyn_variables = req_opts[:dyn_variables]
    custom_headers = req_opts[:custom_headers]
    secondary_server_req = req_opts[:secondary_server_req]
    external = req_opts[:external]
    req_opts.delete_if{|k,v| k != "subst"}
    
    
    # Make sure we have a proper URL format
    base_url = ''
    self.config.log.debug_msg("URL: #{url}\nLast Req External - Beg: #{@@last_req_external}")
    
    # Secondary server request
    if(!secondary_server_req.nil?)
      # Secondary server, just set it to fully qualified hostname
      base_url = "#{@http_mode}://#{secondary_server_req}"
      base_url << "/#{self.config.secondary_context}" if(!self.config.secondary_context.empty?)
      base_url << '/' if(url !~ /^\//)
      @@last_req_fq = true
    
    elsif(url !~ /^#{http_mode}/)
      
      # Take care of last request external
      if(@@last_req_external or (self.config.ssl and !@@last_req_fq))
        # We need to make the request fully qualified
        base_url = self.url
        @@last_req_fq = true
      else
        base_url << "/#{self.config.context}" if(url !~ /^\/#{self.config.context}/ and !self.config.context.empty?)
      end
      
      base_url << '/' if(url !~ /^\//)
      
    end
    
    url = base_url + url
    opts["url"] = url
    
    self.config.log.debug_msg("New URL: #{url}")
        
    # Building request string soley for list method
    req_str = "<http url='#{url}' version='#{opts[:version]}' method='#{opts[:method]}'"
    req_str << " content_type='#{opts[:content_type]}'" if(opts[:content_type])
    req_str << " contents='#{opts[:contents]}'" if(opts[:contents])
    req_str << ">"

    req = @xml_element.add_element('request', req_opts)
    dyn_variables.each do |dyn_var|
      req.add_element('dyn_variable', dyn_var)
    end
    http = req.add_element('http', opts)
    
    # Write basic authentication for request if necessary
    if(self.config.request_filters[:auth])
      http.add_element('www_authenticate', {'userid' => self.config.request_filters[:auth][:username], 'passwd' => self.config.request_filters[:auth][:password]})
    elsif(!auth_opt[:auth].empty?)
      http.add_element('www_authenticate', {'userid' => auth_opt[:auth][:username], 'passwd' => auth_opt[:auth][:password]})
    end
    
    # BUG - need a way to dynamically ingest custome headers per product
    # BUG - hardcoded to first app server
    custom_headers['Referer'] = self.url if(self.config.product == 'oae' and !custom_headers['Referer'])
        
    if(!custom_headers.empty?)
      custom_headers.each_pair do |key, value|
        http.add_element('http_header', {'name' => key, 'value' => value})
      end
    end
    
    # Set external flag if necessary
    @@last_req_external = (external ? true : false)
    external ? self.config.log.debug_msg("EXTERNAL: true") : self.config.log.debug_msg("EXTERNAL: false")
    self.config.log.debug_msg("Last Req External - End: #{@@last_req_external}")
    
    @list << req_str
  end
  
  # Add thinktime
  #
  # Option: DEFAULT_VALUE
  # * 'random': 'true'
  def add_thinktime(value=5, opts={})
    
    defaults = {
      "random" => "true",
      "value" => value
    }
    
    opts = defaults.merge(opts)
     
    @xml_element.add_element('thinktime', opts) if(self.config.thinktime)
  end
  
end


# Class meant to handle all output IO
class Writer

  attr_accessor :file_path
  
  def initialize(file_path)
    @file_path = file_path
  end
  
end

# XML Writer
class XmlWriter < Writer
  
  attr_reader :xml, :file
  
  def initialize(config)
    super(config.output)
    @file = File.open(file_path, 'w')
    @xml = config.xml_obj
  end
  
end

# Log writer
class LogWriter < Writer
  
  attr_reader :file
  
  def initialize(config)
    super(config.log_path)
    @file = File.open(config.log_path, 'w')
    @config = config
  end
  
  # Message sent to stdout as well as log file
  def info_msg(msg="")
    puts(msg)
    @file.puts(msg)
  end
  
  # Message sent to stdout and log file only if debug flag is on
  def debug_msg(msg="")
    if(@config.debug)
      puts("Debug: #{msg}")
      @file.puts("Debug: #{msg}")
    end
  end
  
end


private

def validate_url(url)
  
  new_url = ''
  
  if(!secondary_server_req.nil?)
    new_url = "http://#{secondary_server_req}/#{self.config.secondary_context}"
    new_url << '/' if(url !~ /^\//)
  elsif(url !~ /^\/self.config.context/ and url !~ /^http/)   
    new_url = (@@last_req_external ? self.url : '/' + self.config.context)
    new_url << '/' if(url !~ /^\//)
  end
  
  
end

