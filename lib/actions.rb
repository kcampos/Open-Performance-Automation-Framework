#!/usr/bin/env ruby

class Actions < Transaction
  
  attr_accessor :config, :list
  
  def initialize(config)
    @config = config
    @list = [] # request list
  end
  
  def write
    # Write the XML
  end
  
  # Add a request to the list
  def add(url, opts={})
    
    # Default the options
    opts.reverse_merge!(
      :method => 'GET',
      :version => '1.1',
      :content_type => nil,
      :contents => nil
    )
    req = "<request><http url='#{url}' version='#{opts[:version]}' method='#{opts[:method]}'"
    req << " content_type='#{opts[:content_type]}'" if(opts[:content_type])
    req << " contents='#{opts[:contents]}'" if(opts[:contents])
    req << "></request>"
    
    @list << req
  end
  
end