#!/usr/bin/env ruby

# 
# == Synopsis
#
# Authentication class containing all operations around app authentication
#
# Author:: Kyle Campos (mailto:kcampos@rsmart.com)
#

require File.dirname(__FILE__) + '/../organization/organization.rb'
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
      
      @request.add("/j_spring_security_check?j_username=#{opts[:user]}&amp;j_password=#{opts[:password]}",
        {}, {'subst' => 'true'})
            
      @request.add('/index.html')
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/LUMMain.jsp')
      @request.add('org.kuali.student.lum.lu.ui.main.LUMMain/org.kuali.student.lum.lu.ui.main.LUMMain.nocache.js')
      
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ServerPropertiesRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|4|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5002099C37B5D013EC8762ACCBD03E69|org.kuali.student.common.ui.client.service.ServerPropertiesRpcService|getContextPath|1|2|3|4|0|"
        }
      )
      
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SecurityRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|4|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|13BFCB3640903B473D12816447D1469D|org.kuali.student.common.ui.client.service.SecurityRpcService|getPrincipalUsername|1|2|3|4|0|"
        }
      )
      
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/MetadataRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|3C721122BF64327C2BB379CD5224A091|org.kuali.student.common.ui.client.service.MetadataRpcService|getMetadata|java.lang.String/2004016611|search|1|2|3|4|3|5|5|5|6|0|0|"
        }
      )
      
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ServerPropertiesRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|14|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5002099C37B5D013EC8762ACCBD03E69|org.kuali.student.common.ui.client.service.ServerPropertiesRpcService|get|java.util.List|java.util.Arrays$ArrayList/1243019747|[Ljava.lang.String;/2600011424|application.url|ks.rice.docSearch.serviceAddress|lum.application.url|ks.rice.url|ks.rice.label|ks.application.version|ks.gwt.codeServer|1|2|3|4|1|5|6|7|7|8|9|10|11|12|13|14|"
        }
      )
      
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ServerPropertiesRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|5002099C37B5D013EC8762ACCBD03E69|org.kuali.student.common.ui.client.service.ServerPropertiesRpcService|get|java.util.List|java.util.Arrays$ArrayList/1243019747|[Ljava.lang.String;/2600011424|ks.rice.actionList.serviceAddress|1|2|3|4|1|5|6|7|1|8|"
        }
      )
      
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SecurityRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|7|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|13BFCB3640903B473D12816447D1469D|org.kuali.student.common.ui.client.service.SecurityRpcService|checkAdminPermission|java.lang.String/2004016611|#{opts[:user]}|useCurriculumReview|1|2|3|4|2|5|5|6|7|"
        }, 
          {'subst' => 'true'}
      )
      
      
      # Rice
      @request.add('/kew/ActionList.do', {}, {:secondary_server_req => @request.config.secondary_servers['rice'], :external => true})
      @request.add("/j_spring_security_check?j_username=#{opts[:user]}&amp;j_password=#{opts[:password]}", 
        {}, {'subst' => 'true', :secondary_server_req => @request.config.secondary_servers['rice'], :external => true})

      # this may be a dupe since it redirects here...check the logs
      @request.add('/kew/ActionList.do', {}, {:secondary_server_req => @request.config.secondary_servers['rice'], :external => true})
      
    else
      ks_url_escaped = URI.escape("#{@request.url}/j_spring_cas_security_check", Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
      @request.add("#{@request.config.sso}/login?service=#{ks_url_escaped}")
    end
    
  end
  
  # Logout of KS
  def logout
    
    @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/j_spring_security_logout')
    @request.add('/login.jsp')
    
  end
  
  # Bring up homepage
  def load_homepage
    
  end
  
end