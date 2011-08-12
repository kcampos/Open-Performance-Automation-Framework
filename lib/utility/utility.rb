#!/usr/bin/env ruby

# 
# == Synopsis
#
# Authentication class containing all operations around app authentication
#
# Author:: Kyle Campos (mailto:kcampos@rsmart.com)
#

class Utility
  
  attr_accessor :request
  
  def initialize(request_obj)
    @request = request_obj
  end
  
  
  def doc_search(opts={})
    
    defaults = {
      :initiator => "",
      :doc_id => "",
      :date_created_from => "", # Format 04%2F02%2F2010,
      :date_created_to => "",
      :saved_search_name => ""
    }
    
    opts = defaults.merge(opts)
  
    # Doc search link
    @request.add('/kew/DocumentSearch.do', {}, {:rice_req => true})
    
    # Login as admin
    @request.add('/kew/DocumentSearch.do', 
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded',
        'contents' => "__login_user=admin"
      }, 
      {:rice_req => true}
    )
    
    @request.add('/dwr/interface/DocumentTypeService.js', {}, {:rice_req => true})
    @request.add('/dwr/interface/PersonService.js', {}, {:rice_req => true})
    
    # Criteria
    
    # Submit
    @request.add('/kr/lookup.do', 
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded',
        'contents' => "backLocation=&amp;formKey=&amp;lookupableImplServiceName=docSearchCriteriaDTOLookupable&amp;businessObjectClassName=org.kuali.rice.kew.docsearch.DocSearchCriteriaDTO&amp;conversionFields=&amp;hideReturnLink=No&amp;suppressActions=No&amp;multipleValues=No&amp;lookupAnchor=&amp;readOnlyFields=&amp;referencesToRefresh=&amp;hasReturnableRow=No&amp;docNum=#{opts[:doc_id]}&amp;showMaintenanceLinks=No&amp;savedSearchName=#{opts[:saved_search_name]}&amp;docTypeFullName=&amp;initiator=#{opts[:initiator]}&amp;routeHeaderId=&amp;fromDateCreated=#{opts[:date_created_from]}&amp;toDateCreated=#{opts[:date_created_to]}&amp;namedSearch=&amp;isAdvancedSearch=NO&amp;superUserSearch=NO&amp;methodToCall.search.x=39&amp;methodToCall.search.y=8&amp;methodToCall.search=search&amp;tabStatesSize=-1&amp;oldDocTypeFieldName="
      }, 
      {:rice_req => true}
    )
    
    @request.add('/dwr/interface/PersonService.js', {}, {:rice_req => true})
    @request.add('/dwr/interface/DocumentTypeService.js', {}, {:rice_req => true})
    
      
  end
  
  
end