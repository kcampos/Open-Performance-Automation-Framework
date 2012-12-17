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
      :thinktime => 3,
      :primary_context => 'primary context',
      :secondary_context => 'secondary context',
      :X_GWT_Permutation_var_name => 'X_GWT_Permutation_var_name'
    }
    
    opts = defaults.merge(opts)

    @request.add('/')
    
    if(@request.config.sso == false)
      
      @request.add("/j_spring_security_check",
        {
          'method' => 'POST',
          'content_type' => 'application/x-www-form-urlencoded',
          'contents' => "j_username=#{opts[:user]}&j_password=#{opts[:password]}"
          }, 
          {'subst' => 'true'}
        )

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/LUMMain.jsp')
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/org.kuali.student.lum.lu.ui.main.LUMMain.nocache.js')


      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ServerPropertiesRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' =>          "7|0|4|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|F4EA0BDE7B7A072764CEEAA8D3DD87E0|org.kuali.student.common.ui.client.service.ServerPropertiesRpcService|getContextPath|1|2|3|4|0|"
        },
        {
          :custom_headers => {
            'X-GWT-Permutation' => "HostedMode"},
          'subst' => 'true'
        }
      )

      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SecurityRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "7|0|4|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|9509131F618790C2E81D1739D6743235|org.kuali.student.common.ui.client.service.SecurityRpcService|getPrincipalUsername|1|2|3|4|0|"
        },
        { 
          :custom_headers => {
            'X-GWT-Permutation' => "HostedMode"},
            'subst' => 'true'
        }
      )
   
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/MetadataRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "7|0|6|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|31C2BC82E6293AA3C6E9D05409B2AC8B|org.kuali.student.common.ui.client.service.MetadataRpcService|getMetadata|java.lang.String/2004016611|search|1|2|3|4|3|5|5|5|6|0|0|"
        },
        { 
          :custom_headers => {
            'X-GWT-Permutation' => "HostedMode"},
            'subst' => 'true'
        }
      )
     
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ServerPropertiesRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "7|0|14|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|F4EA0BDE7B7A072764CEEAA8D3DD87E0|org.kuali.student.common.ui.client.service.ServerPropertiesRpcService|get|java.util.List|java.util.Arrays$ArrayList/2507071751|[Ljava.lang.String;/2600011424|application.url|ks.rice.docSearch.serviceAddress|lum.application.url|ks.rice.url|ks.rice.label|ks.application.version|ks.gwt.codeServer|1|2|3|4|1|5|6|7|7|8|9|10|11|12|13|14|"
        },
        { 
          :custom_headers => {
            'X-GWT-Permutation' => "HostedMode"},
            'subst' => 'true'
        }
      )
      
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/ServerPropertiesRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "7|0|8|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|F4EA0BDE7B7A072764CEEAA8D3DD87E0|org.kuali.student.common.ui.client.service.ServerPropertiesRpcService|get|java.util.List|java.util.Arrays$ArrayList/2507071751|[Ljava.lang.String;/2600011424|ks.rice.actionList.serviceAddress|1|2|3|4|1|5|6|7|1|8|"
        },
        { 
          :custom_headers => {
            'X-GWT-Permutation' => "HostedMode"},
            'subst' => 'true'
        }
      )
      
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SecurityRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "7|0|5|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|9509131F618790C2E81D1739D6743235|org.kuali.student.common.ui.client.service.SecurityRpcService|getPermissionsByType|org.kuali.student.r1.common.rice.authorization.PermissionType/3661700771|1|2|3|4|1|5|5|0|"
        },
        { 
          :custom_headers => {
            'X-GWT-Permutation' => "HostedMode"},
            'subst' => 'true'
        }
      )
      
      @request.add('/org.kuali.student.lum.lu.ui.main.LUMMain/rpcservices/SecurityRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "7|0|20|#{@request.url}/org.kuali.student.lum.lu.ui.main.LUMMain/|9509131F618790C2E81D1739D6743235|org.kuali.student.common.ui.client.service.SecurityRpcService|getScreenPermissions|java.util.ArrayList/4159755760|java.lang.String/2004016611|useCreateCourseByProposal|useCreateCourseByAdminProposal|useCreateProgramByProposal|useBrowseCatalog|useFindCourse|useFindCourseProposal|useBrowseProgram|useFindProgramScreen|useFindProgramProposalScreen|useViewCoreProgramsScreen|useViewCredentialProgramsScreen|useViewCourseSetManagement|useLOCategory|useDependencyAnalysis|1|2|3|4|1|5|5|14|6|7|6|8|6|9|6|10|6|11|6|12|6|13|6|14|6|15|6|16|6|17|6|18|6|19|6|20|"
        },
        { 
          :custom_headers => {
            'X-GWT-Permutation' => "HostedMode"},
            'subst' => 'true'
        }
      )

      if !(opts[:secondary_context].length == 0)
      # Rice
        @request.add('/kew/ActionList.do', {}, {:secondary_server_req => @request.config.secondary_servers['rice'], :external => true})
        @request.add("/j_spring_security_check?j_username=#{opts[:user]}&amp;j_password=#{opts[:password]}", 
          {}, {'subst' => 'true', :secondary_server_req => @request.config.secondary_servers['rice'], :external => true})

          # this may be a dupe since it redirects here...check the logs
        @request.add('/kew/ActionList.do', {}, {:secondary_server_req => @request.config.secondary_servers['rice'], :external => true})
      end
    else
      ks_url_escaped = URI.escape("#{@request.url}/j_spring_cas_security_check", Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
      @request.add("#{@request.config.sso}/login?service=#{ks_url_escaped}")
      
    end
   
  end

  def acal_login(opts={})
    defaults = {
      :user => 'admin',
      :password => 'admin',
      :thinktime => 3
    }
    
    opts = defaults.merge(opts)

    @request.add("/j_spring_security_check",
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded',
        'contents' => "j_username=#{opts[:user]}&j_password=#{opts[:password]}"
      }, 
        {'subst' => 'true'}
    )

    @request.add("/")
    @request.add("/portal.do")

  end

  def acal_logout
    @request.add('/backdoorlogin.do')
    @request.add('/j_spring_security_logout')
    @request.add('/portal.do')
    @request.add('/login.jsp')    
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