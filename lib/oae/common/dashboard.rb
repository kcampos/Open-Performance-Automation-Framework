#!/usr/bin/env ruby

# 
# == Synopsis
#
# Dashboard class containing all operations around dashboard functionality
#
# Author:: Kyle Campos (mailto:kcampos@rsmart.com)
#

class Dashboard
  
  attr_accessor :request
  
  def initialize(request_obj)
    @request = request_obj
  end
  
  def load(username_var)
		@request.add("/~#{username_var}/message.count.json?filters=sakai:messagebox,sakai:read&values=inbox,false&groupedby=sakai:category&_charset_=utf-8&_=1342701136675",
				{}, { 'subst' => 'true' })
		@request.add('/var/templates/worlds.2.json?_charset_=utf-8')
		
		# TODO: probably a way to get this avatar URL from a JSON request:
		#	@request.add('/~batch0-devin-sonnek-651/public/profile/256x256_Eket%20Mask.gif')
		# Is it worth it?
		
		@request.add("/~#{username_var}/public/pubspace.infinity.json?_charset_=utf-8&_=1342701137858",
				{}, { 'subst' => 'true' })
		@request.add("/~#{username_var}/private/privspace.infinity.json?_charset_=utf-8&_=1342701138403",
				{}, { 'subst' => 'true' })
		@request.add("/~#{username_var}/private/privspace/id84508350/id2506067/dashboardactivity.infinity.json?_charset_=utf-8&_=1342701139163",
				{}, { 'subst' => 'true' })
  end
  
  def edit_layout
    
  end

end