#!/usr/bin/env ruby

# 
# == Synopsis
#
# Creates an AutoConfig object that contains all configuration information for testing.
#
# Author:: Kyle Campos (mailto:kcampos@rsmart.com)
#

require File.dirname(__FILE__) + '/tsung-api.rb'
require File.dirname(__FILE__) + '/common.rb'
require 'yaml'
require "rexml/document"
include REXML
include Common

class AutoConfig

  attr_accessor :log_dir, :products, :output, :clients, :servers, :secondary_servers, 
    :phases, :agents, :debug, :execute, :intro_xml, :tests, :drb_port, :log, :log_path, :xml_writer, :xml_obj, :context, :verbose,
    :tsung_log_level, :secondary_context, :tsung_element, :sessions_element, :sso, :thinktime, :import_files
    
  attr_reader :product, :suite, :directory, :config_setup, :config_dir, :suite_base_dir, :suite_dir, :test_base_dir, :test_dir, :lib_base_dir

  
  def initialize
    
    @config_setup   = YAML.load_file(File.expand_path(File.dirname(__FILE__)) + '/../config/config.yaml')
    @products       = @config_setup[:products].keys
    @lib_base_dir   = Common.dir_simplify(File.expand_path(File.dirname(__FILE__)))
    @config_dir     = Common.dir_simplify(@lib_base_dir + '/../config')
    @suite_base_dir = Common.dir_simplify(@lib_base_dir + '/../suites')
    @test_base_dir  = Common.dir_simplify(@lib_base_dir + '/../tests')
    @log_dir        = Common.dir_simplify(@lib_base_dir + '/../log')
    @debug          = false
    @execute        = false
    
  end

  # interactive prompt to capture all the config settings
  def setup
    puts "Let's setup your test run config..."
    
    # Product
    if(self.product.nil?)
      print "What product are we testing? #{self.products} "
      self.product = gets.strip.downcase
      
      while(self.product.nil?) # Catch if improper value given
        puts "Please choose a product to test that we currently support."
        print "Choices are: #{self.products} "
        self.product = gets.strip.downcase
      end
    end
      
    self.log.debug_msg "We are testing product: #{self.product}"
    
    
    # Suite
    if(self.suite.nil?)
      print "What suite are we testing? "
      self.suite = gets.strip.downcase
      
      while(self.suite.nil?) # Catch if improper value given
        print "Please choose a suite to test: "
        self.suite = gets.strip.downcase
      end
    end
      
    self.log.debug_msg "We are using suite: #{self.suite}"
    self.parse_suite
    
    
    # Output file
    if(!self.output)
      print "What do you want to name your output xml file? "
      xml_name = gets.strip
      # If they specify a path then store that, otherwise stick it in config dir
      self.output = (xml_name =~ /^(\.|\/)/ ? xml_name : "#{self.config_dir}/tests/#{xml_name}")
    end
      
    self.log.info_msg "Your xml file will be here: #{self.output}"
    
    
    #
    # Clients
    #
    print "What clients are you driving your tests from? [hostname1,hostname2,...] "
    clients = gets.chomp!
    while(clients !~ /^([^\,]+)(\,[^\,]+)*?$/) # validate format
      print "Please use correct csv format [hostname1,hostname2,...] "
      clients = gets.chomp!
    end
  
    self.clients = clients.split(/,/)
  
  
    #
    # Primary servers
    #
    print "What primary servers do you want to test? [hostname1:port,hostname2:port,...] "
    servers = gets.chomp!
    while(servers !~ /^([^:]+:\d+)(\,[^:]+:\d+)*?$/) # validate format
      print "Please use correct format [hostname1:port,hostname2:port,...] "
      servers = gets.chomp!
    end
  
    self.servers = servers.split(/,/)
    
    
    #
    # Secondary servers
    #
    print "Secondary servers? [reference_name1:hostname1:port,reference_name2:hostname2:port,...] "
    secondary_servers = gets.chomp!
    while(!secondary_servers.empty? and secondary_servers !~ /^([^:]+:[^:]+:\d+)$/) # validate format
      print "Please use correct format [reference_name1:hostname1:port,reference_name2:hostname2:port,...] "
      secondary_servers = gets.chomp!
    end
    
    self.secondary_servers = {}
    secondary_servers.split(/,/).each do |secondary_serv|
      (ref_name, host, port) = secondary_serv.split(/:/)
      self.secondary_servers[ref_name] = "#{host}:#{port}"
    end
    
    
    #
    # Contexts
    # 
    
    # Primary
    if(self.context.nil?)
      print "What is the primary server context? "
      self.context = gets.strip
    end
    
    self.log.debug_msg "Your primary server context is: #{self.context}"
      
    # Secondary
    if(self.secondary_context.nil?)
      print "What is the secondary server context? "
      self.secondary_context = gets.strip
    end
    
    self.log.debug_msg "Your secondary server context is: #{self.secondary_context}"
    
    
    #
    # Phases
    #
    self.phases = {}
    puts "Let's setup your test scenario or phases, you can define multiple phases"
    phase = 0
    begin
      phase += 1
      self.phases[phase] = {}
    
      print "Phase #{phase}: How many minutes? "
      min_duration = gets.chomp!
      while(min_duration =~ /\D/) # validate only digits
        print "Please specify only numeric entry: "
        min_duration = gets.chomp!
      end
    
      self.phases[phase][:duration] = min_duration
      self.phases[phase][:unit] = 'minute' # hardcoded for now for simplicity
      
      print "At what interval should users be created at this phase? (x seconds per user) "
      users = gets.chomp!
      while(users !~ /^\d+(\.\d+)?$/)
        print "Please user correct float or numeric value. 1 or 1.0 for example: "
        users = gets.chomp!
      end
      
      self.phases[phase][:user_interval] = users
      self.phases[phase][:user_unit] = "second" # hardcoded now for simplicity
    
      print "Do you want to add another phase? [y/n] "
      add_phase = gets.chomp!
    end while (add_phase == 'y')
  
  
    #
    # User Agent
    #
    puts "Let's setup what user agents you'd like to test with"
    probability_total = 0
    self.agents = {}
    agent_list = @config_setup[:agents]
  
    puts "Here are the agents you can specify..."
    option = 0
    agent_list.each {|agent| puts "#{option+=1}: #{agent}"}
    available_perc = 100
  
    # Loop over collecting agents until we have 100%
    begin
      print "Specify the number of the agent you'd like to use: "
      agent_num = gets.chomp
      while(agent_num =~ /\D/) # validate only digits
        print "Please specify only numeric entry: "
        agent_num = gets.chomp
      end
    
      print "Specify the probability that this agent will be used: [1-100] "
      agent_prob = gets.chomp
    
      # validate only digits and doesn't exceed available probability
      while(agent_prob =~ /\D/ || agent_prob.to_i > available_perc) 
        print "Please specify only numeric entry that doesn't exceed #{available_perc}: "
        agent_prob = gets.chomp
      end
    
      # Subtract specified probability from remaining available
      available_perc-=agent_prob.to_i
      self.agents[agent_list[agent_num.to_i - 1]] = agent_prob
  
      # See if we need another agent
      if(available_perc > 0)
        puts "You have #{available_perc}% remaining in agent probability. Please add another agent."
        add_agent = 'y'
      else
        add_agent = 'n'
      end
    
    end while (add_agent == 'y')
    
    #
    # Thinktime
    #
    if(self.thinktime.nil?)
      print "Do you want to insert user thinktime? [y/n] "
      self.thinktime = (gets.chomp == 'y' ? true : false)
    end
    
    #
    # Execute
    #
    if(self.execute.nil?)
      print "Do you want to execute tsung now? [y/n] "
      self.execute = (gets.chomp == 'y' ? true : false)
    end
    
    if(self.verbose.nil?)
      print "Do you want to dump http traffic from tsung? [y/n] "
      self.verbose = (gets.chomp == 'y' ? true : false)
    end
    
    #
    # SSO - Not supported yet so turn it off
    #
    
    self.sso = false
  end
  
  # Set product for this particular run as well as the dependent instance variables
  def product=(name)
    @product = (self.products.index(name).nil? ? nil : name)  
    self.directory = @product
    self.suite_dir = @product
    self.test_dir  = @product
    @product
  end
  
  # Set suite for this particular run
  def suite=(name)
    @suite = (validate_suite(name) ? name : nil)
  end
  
  # Set directory data based on product
  def directory=(product)
    @directory = @config_setup[:directory][product]
  end
  
  # Set suite dir based on product
  def suite_dir=(product)
    @suite_dir = "#{self.suite_base_dir}/#{product}"
  end
  
  # Set test dir based on product
  def test_dir=(product)
    @test_dir = "#{self.test_base_dir}/#{product}"
  end

  # Validate the suite exists and has proper format
  def validate_suite(suite=self.suite)
    
    errors = ""
    prob_total = 0
    
    # Parse file for proper format
    begin
      File.open("#{self.suite_dir}/#{suite}", "r") do |suite_file|
        while(line = suite_file.gets)
          if(line !~ /^\w+\.rb\,(\d+)$/) #should be in format: testname.rb,100
            next if(line =~ /^\#/) # skip if it's a comment
            errors << "Incorrect format here: #{line}"
          end
          prob_total+=$1.to_i
        end
      end
    rescue
      puts "#{suite} suite does not exist"
      return false
    end
    
    errors << "Probability does not add up to 100" if(prob_total != 100)
    puts errors if(errors)
    
    return errors.empty?    
  end
  
  # Parses the test suite and initializes tests
  def parse_suite(suite=self.suite)
    
    self.tests = {}
    
    File.open("#{self.suite_dir}/#{suite}", "r") do |suite_file|
      while(line = suite_file.gets)
        next if(line =~ /^\#/) # skip if it's a comment
        line =~ /^(\w+\.rb)\,(\d+)$/
        self.tests[$1] = $2
      end
    end
    
  end
  
  # Setup log 
  def initialize_logs
    
    # Output path
    self.log_path = "#{self.log_dir}/#{Time.now.to_i}.log" if(!self.log_path)
    self.log        = LogWriter.new(self)
    self.log.info_msg("Your log file is here: #{self.log_path}")
    
  end

  # Used to create initial xml output
  def initialize_output_xml
    
    self.output = "#{self.log_dir}/#{Time.now.to_i}_#{self.suite}.xml" if(!self.output)
    
    if(!self.intro_xml.nil?)
      # We have a template for initial xml settings
      parse_intro_xml 
      `cp #{self.intro_xml} #{self.output}`
    else
      write_config_xml 
    end
    
    self.xml_writer = XmlWriter.new(self)
  end
  
  # This will load config object with data from xml file
  def parse_intro_xml
    
    xml_doc = Document.new File.open(self.intro_xml, 'r')
    self.xml_obj = xml_doc
    
    # Grab clients
    self.clients = []
    xml_doc.elements.each("tsung/clients/client") { |element| self.clients << element.attributes["host"] }
    self.log.debug_msg "Clients: #{self.clients}"
    
    # Grab servers
    self.servers = []
    xml_doc.elements.each("tsung/servers/server") { |element| self.servers << element.attributes.values_at("host", "port").join(':') }
    self.log.debug_msg "Servers: #{self.servers}"
    
    # Grab phases
    self.phases = {}
    xml_doc.elements.each("tsung/load/arrivalphase") do |element|
      (phase, duration, unit) = element.attributes.values_at("phase", "duration", "unit").collect{|arr| arr.to_s}

      self.phases[phase] = {}
      self.phases[phase][:duration] = duration
      self.phases[phase][:unit]     = unit
      
      xml_doc.elements.each("tsung/load/arrivalphase[@phase=#{phase}]/users") { |element| (self.phases[phase][:user_interval], self.phases[phase][:user_unit]) = element.attributes.values_at("interarrival", "unit").collect{|arr| arr.to_s}}
    end
    self.log.debug_msg "Phases: #{self.phases.inspect}"
    
    # User agent
    self.agents = {}
    xml_doc.elements.each("tsung/options/option[@name='user_agent']/user_agent") do |element|
      # Only way I've found to strip tags from the element, no get_value
      agent = element.to_s.gsub(/\<[^\>]+\>/, '')
      probability = element.attributes.values_at("probability").to_s
      self.agents[agent] = probability
    end
    self.log.debug_msg "Agents: #{self.agents.inspect}"
    
      
  end
  
  # This will parse config object and write the xml for it
  def write_config_xml

    self.log.debug_msg "Entering write_config_xml..."
    # FIX: don't hardcode dtd path
    dtd = get_dtd_path
    xml_doc = Document.new("<?xml version='1.0?><!DOCTYPE tsung SYSTEM '#{dtd}'>")
    # Store xml doc object in config 
    self.xml_obj = xml_doc
    
    tsung_opts = {
      "loglevel" => "#{self.tsung_log_level}",
      "version" => "1.0"
    }
    tsung_opts["dumptraffic"] = "true" if(self.verbose)
    
    self.tsung_element = xml_doc.add_element('tsung', tsung_opts)
    
    # Clients
    clients = self.tsung_element.add_element('clients')
    self.clients.each { |client| clients.add_element('client', {"host" => client, "use_controller_vm" => "true"})}
    
    # Servers
    servers = self.tsung_element.add_element('servers')
    self.servers.each do |server|
      (host, port) = server.split(':')
      servers.add_element('server', {"host" => host, "port" => port, "type" => "tcp"})
    end
    
    # Monitoring
    # TODO: we have no option in setup to configure monitoring
    
    # Load
    load = self.tsung_element.add_element('load')
    self.phases.each_pair do |phase, detail|
      arrival_phase = load.add_element('arrivalphase', {"phase" => phase, "duration" => detail[:duration], "unit" => detail[:unit]})
      arrival_phase.add_element('users', {"interarrival" => detail[:user_interval], "unit" => detail[:user_unit]})
    end
    
    # Options - user agent
    options = self.tsung_element.add_element('options')
    option = options.add_element('option', {"type" => "ts_http", "name" => "user_agent"})
    self.agents.each_pair do |agent, probability| 
      ua = option.add_element('user_agent', {"probability" => probability})
      ua.add_text(agent)
    end
    
    # BUG -HARDCODED
    #options.add_element('option', {"name" => "file_server", "id" => "userdb", "value" => "#{@config_dir}/import/users.csv"})
    parse_import_files
    self.import_files.each_key do |import_file|
      options.add_element('option', {"name" => "file_server", "id" => self.import_files[import_file][:id], "value" => "#{@config_dir}/import/#{import_file}"})
    end
    
    # DEBUG
    #self.log.debug_msg "XML doc"
    #xml_doc.write($stdout, 2)
    #tsung.document.write($stdout, 2)
    puts ""
    self.log.debug_msg "Exiting write_config_xml..."
    
  end
  
  # Initialize sessions in xml
  def init_sessions
    
    self.sessions_element = self.tsung_element.add_element('sessions')
    
  end
  
  # Dump out config object
  #def to_s
    #self.inspect
  #end

  private
  
  def get_dtd_path
    
    dtd_path = '/opt/local/share/tsung/tsung-1.0.dtd' #default
    #locate = `locate tsung-1.0.dtd`
    #locate.split('\n').each do |line|
    #  if(line =~ /share/)
    #    dtd_path = line
    #  end
    #end
    
    dtd_path
  end
  
  
  # Gather all import files and store in hash with properties
  def parse_import_files
    
    self.import_files = {}
    
    Dir.foreach("#{@config_dir}/import") do |file|
      next if (file !~ /.+\.format$/) #skip if anything other than a format file
      
      csv_file = file.sub('.format', '.csv')
      self.import_files[csv_file] = {}
      file =~ /([^\.]+)/ # Get filename ahead of extension
      self.import_files[csv_file][:id] = $1
      
      # Read/store format of file, which should be first 2 lines of .format file
      # variables
      # 
      file_info = `head -n 2 #{@config_dir}/import/#{file}`
      file_info =~ /(.+)\n(.+)/
      format = $1
      self.import_files[csv_file][:order] = $2.gsub(' ','')
      self.import_files[csv_file][:vars] = format.gsub(' ','').split(',')
      
      
    end
    
    self.import_files
    
  end

end
