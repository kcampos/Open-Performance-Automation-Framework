#!/usr/bin/env ruby

# 
# == Synopsis
#
# Explore class containing all operations around exploring
#
# Author:: Branden Visser (mailto:mrvisser@gmail.com)
#

class Explore
  
  attr_accessor :request
  
  def initialize(request_obj)
    @request = request_obj
  end
  
  #
  # Loads the splash page of OAE
  #
  def splash()
		@request.add('/')
		@request.add('/var/widgets.json?callback=define')
		@request.add('/system/me?_charset_=utf-8')
		@request.add('/tags/directory.tagged.json?_charset_=utf-8&_=1342651726188')
		@request.add('/var/search/activity/all.json?items=12&_charset_=utf-8&_=1342651726197')
		@request.add('/var/search/public/random-content.json?page=0&items=10&tag=&type=c&_charset_=utf-8&_=1342651726201')
		@request.add('/var/templates/worlds.2.json?_charset_=utf-8')
  end
  
end