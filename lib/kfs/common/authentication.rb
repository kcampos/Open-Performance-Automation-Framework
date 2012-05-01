#!/usr/bin/env ruby

# 
# == Synopsis
#
# Authentication class containing all operations around app authentication
#
# Author:: Leo Przybylsk (mailto:leo@rsmart.com)

#require File.dirname(__FILE__) + '/../organization/organization.rb'
require 'uri'

class Authentication
  
  attr_accessor :request
  
  def initialize(request_obj)
    @request = request_obj
  end
  
  # Login to ks
  def login(opts={})
    
    defaults = {
      :user => 'admin',
      :password => 'admin',
      :thinktime => 3
    }
    
    opts = defaults.merge(opts)
    
    @request.add('/')
    
    if(@request.config.sso == false)
      
      @request.add('/index.jsp')
      
      # Rice
      @request.add('/kew/ActionList.do', {}, {:secondary_server_req => @request.config.secondary_servers['rice'], :external => true})

      # this may be a dupe since it redirects here...check the logs
      @request.add('/kew/ActionList.do', {}, {:secondary_server_req => @request.config.secondary_servers['rice'], :external => true})
      
    else
      ks_url_escaped = URI.escape("#{@request.url}/j_spring_cas_security_check", Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
      @request.add("#{@request.config.sso}/login?service=#{ks_url_escaped}")
    end
    
  end
  
  # Logout of KFS (Not all versions support this)
  def logout
  end
  
  # Bring up homepage
  def load_homepage
    
  end
  
end
