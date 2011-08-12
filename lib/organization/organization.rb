#!/usr/bin/env ruby

# 
# == Synopsis
#
# Organization class containing all operations around organization objects
#
# Author:: Kyle Campos (mailto:kcampos@rsmart.com)
#

class Organization

  attr_accessor :request
  
  def initialize(request_obj)
    @request = request_obj
  end  
  
  # Load the Organizations homepage
  def homepage
    
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/OrgEntry.jsp')
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/images/corner3.png')
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/images/transparent.gif')
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/OrgRpcService', 
      {
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'method' => 'POST',
        'contents' => "5|0|4|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|AE88E9E993C2C04C4BAC534CC092D550|org.kuali.student.core.organization.ui.client.service.OrgRpcService|getOrgTypes|1|2|3|4|0|"
      }
    )
    
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/OrgRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|4|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|AE88E9E993C2C04C4BAC534CC092D550|org.kuali.student.core.organization.ui.client.service.OrgRpcService|getOrgOrgRelationTypes|1|2|3|4|0|"
      }
    )
    
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/OrgRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|4|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|AE88E9E993C2C04C4BAC534CC092D550|org.kuali.student.core.organization.ui.client.service.OrgRpcService|getOrgPersonRelationTypes|1|2|3|4|0|"
      }
    )
    
    # Dupe request - BUG?
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/OrgRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|4|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|AE88E9E993C2C04C4BAC534CC092D550|org.kuali.student.core.organization.ui.client.service.OrgRpcService|getOrgPersonRelationTypes|1|2|3|4|0|"
      }
    )
    
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/SecurityRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|4|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|29F4EA1240F157649C12466F01F46F60|org.kuali.student.common.ui.client.service.SecurityRpcService|getPrincipalUsername|1|2|3|4|0|"
      }
    )

    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/ServerPropertiesRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|3DDEE7B5823674CCFB876EDB821C7743|org.kuali.student.common.ui.client.service.ServerPropertiesRpcService|get|java.lang.String|ks.rice.docSearch.serviceAddress|1|2|3|4|1|5|6|"
      }
    )
    
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/ServerPropertiesRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|3DDEE7B5823674CCFB876EDB821C7743|org.kuali.student.common.ui.client.service.ServerPropertiesRpcService|get|java.lang.String|ks.rice.actionList.serviceAddress|1|2|3|4|1|5|6|"
      }
    )
    
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/ServerPropertiesRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|3DDEE7B5823674CCFB876EDB821C7743|org.kuali.student.common.ui.client.service.ServerPropertiesRpcService|get|java.lang.String|lum.application.url|1|2|3|4|1|5|6|"
      }
    )
    
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/OrgRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|4|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|AE88E9E993C2C04C4BAC534CC092D550|org.kuali.student.core.organization.ui.client.service.OrgRpcService|getOrgMetaData|1|2|3|4|0|"
      }
    )
    
    # Dupe request - BUG?
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/OrgRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|4|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|AE88E9E993C2C04C4BAC534CC092D550|org.kuali.student.core.organization.ui.client.service.OrgRpcService|getOrgMetaData|1|2|3|4|0|"
      }
    )
    
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/ServerPropertiesRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|3DDEE7B5823674CCFB876EDB821C7743|org.kuali.student.common.ui.client.service.ServerPropertiesRpcService|get|java.lang.String|application.url|1|2|3|4|1|5|6|"
      }
    )
    
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/OrgRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|4|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|AE88E9E993C2C04C4BAC534CC092D550|org.kuali.student.core.organization.ui.client.service.OrgRpcService|getSectionConfig|1|2|3|4|0|"
      }
    )
    
    # Dupe request - BUG?
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/OrgRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|4|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|AE88E9E993C2C04C4BAC534CC092D550|org.kuali.student.core.organization.ui.client.service.OrgRpcService|getSectionConfig|1|2|3|4|0|"
      }
    )
    
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/OrgRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|4|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|AE88E9E993C2C04C4BAC534CC092D550|org.kuali.student.core.organization.ui.client.service.OrgRpcService|getOrgTypes|1|2|3|4|0|"
      }
    )
    
  end
  
  # Organization Search
  def search(name, opts={})
    
    defaults = {
      :ajax_num_char => name.length #number of chars to type before selecting org from popup
    }
    
    opts = defaults.merge(opts)
    
    # AJAX popup while typing in org name
    for i in 1..opts[:ajax_num_char]
      itr = i-1
      @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/SearchRpcService',
        {
          'method' => 'POST',
          'content_type' => 'text/x-gwt-rpc; charset=utf-8',
          'contents' => "5|0|12|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|9C6F936F4CEB3E5CBB16043EFF7A3F6A|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|org.queryParam.orgOptionalLongName|#{name[0..itr]}|org.search.generic|1|2|3|4|1|5|6|0|7|0|8|1|9|10|0|11|12|0|0|0|"
        }
      )
    end
    
    # Search committed
    
    # Not sure if these requests have hardcoded ID info about a specific org "Fisheries Dept" -- FIX
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/OrgRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|AE88E9E993C2C04C4BAC534CC092D550|org.kuali.student.core.organization.ui.client.service.OrgRpcService|fetchOrg|java.lang.String|deea07ad-7219-4ecf-966d-1bbbcc05242d|1|2|3|4|1|5|6|"
      }
    )
    
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/OrgRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|6|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|AE88E9E993C2C04C4BAC534CC092D550|org.kuali.student.core.organization.ui.client.service.OrgRpcService|getOrgPositionPersonRelation|java.lang.String|deea07ad-7219-4ecf-966d-1bbbcc05242d|1|2|3|4|1|5|6|"
      }
    )
    
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/OrgRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|4|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|AE88E9E993C2C04C4BAC534CC092D550|org.kuali.student.core.organization.ui.client.service.OrgRpcService|getOrgTypes|1|2|3|4|0|"
      }
    )
    
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|12|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|9C6F936F4CEB3E5CBB16043EFF7A3F6A|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|org.queryParam.orgOptionalId|abcd4670-ba9f-42ac-b4ed-35409a68e35a|org.search.generic|1|2|3|4|1|5|6|0|7|0|8|1|9|10|0|11|12|0|0|0|"
      }
    )
    
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/OrgRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|4|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|AE88E9E993C2C04C4BAC534CC092D550|org.kuali.student.core.organization.ui.client.service.OrgRpcService|getOrgOrgRelationTypes|1|2|3|4|0|"
      }
    )
    
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|12|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|9C6F936F4CEB3E5CBB16043EFF7A3F6A|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|org.queryParam.orgOptionalId|abcd4670-ba9f-42ac-b4ed-35409a68e35a|org.search.generic|1|2|3|4|1|5|6|0|7|0|8|1|9|10|0|11|12|0|0|0|"
      }
    )
    
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/OrgRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|4|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|AE88E9E993C2C04C4BAC534CC092D550|org.kuali.student.core.organization.ui.client.service.OrgRpcService|getOrgOrgRelationTypes|1|2|3|4|0|"
      }
    )
    
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|12|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|9C6F936F4CEB3E5CBB16043EFF7A3F6A|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|org.queryParam.orgOptionalId|ed6c5aad-9388-4c5a-bfe9-fe53ee0c6d0c|org.search.generic|1|2|3|4|1|5|6|0|7|0|8|1|9|10|0|11|12|0|0|0|"
      }
    )
    
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/OrgRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|4|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|AE88E9E993C2C04C4BAC534CC092D550|org.kuali.student.core.organization.ui.client.service.OrgRpcService|getOrgOrgRelationTypes|1|2|3|4|0|"
      }
    )
    
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/SearchRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|12|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|9C6F936F4CEB3E5CBB16043EFF7A3F6A|org.kuali.student.common.ui.client.service.SearchRpcService|search|org.kuali.student.core.search.dto.SearchRequest|org.kuali.student.core.search.dto.SearchRequest/3917446114|java.lang.Boolean/476441737|java.util.ArrayList/3821976829|org.kuali.student.core.search.dto.SearchParam/3876231949|org.queryParam.orgOptionalId|ed6c5aad-9388-4c5a-bfe9-fe53ee0c6d0c|org.search.generic|1|2|3|4|1|5|6|0|7|0|8|1|9|10|0|11|12|0|0|0|"
      }
    )
    
    @request.add('/org.kuali.student.core.organization.ui.OrgEntry/rpcservices/OrgRpcService',
      {
        'method' => 'POST',
        'content_type' => 'text/x-gwt-rpc; charset=utf-8',
        'contents' => "5|0|4|#{@request.url}/org.kuali.student.core.organization.ui.OrgEntry/|AE88E9E993C2C04C4BAC534CC092D550|org.kuali.student.core.organization.ui.client.service.OrgRpcService|getOrgOrgRelationTypes|1|2|3|4|0|"
      }
    )
    
  end
  
end
