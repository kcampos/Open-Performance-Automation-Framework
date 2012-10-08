#!/usr/bin/env ruby

# 
# == Synopsis
#
# Search class containing all operations around search
#
# Author:: Branden Visser (mailto:mrvisser@gmail.com)
#

class Search
  
  attr_accessor :request
  
  def initialize(request_obj)
    @request = request_obj
  end
  
  #
  # Performs a general search.
  # 
  # * query: The general search term to search on (default: *)
  # * opts[:search_category]: The category to search (default: all)
  # ** Available options: all, content, people, groups, courses, research_projects
  # * opts[:load_search_page]: Whether or not to load the search page. Useful to simply switch context (e.g., from all to courses)
  #
  def search(query='*', opts={})

    defaults = {
      :search_category => 'all',
      :load_search_page => true
    }
    
    opts = defaults.merge(opts)

    if (opts[:load_search_page])
      @request.add('/var/widgets.json?callback=define')
      @request.add('/system/me?_charset_=utf-8')
      @request.add('/var/templates/worlds.2.json?_charset_=utf-8')
    end
    
    case opts[:search_category]
    when 'all'
      @request.add("/var/search/general.json?q=#{query}&tags=&sortOn=_lastModified&sortOrder=desc&page=0&items=18&_charset_=utf-8&_=1342558141063",
          {}, { 'subst' => 'true' })
    when 'content'
      @request.add("/var/search/pool/all.infinity.json?q=#{query}&tags=&sortOn=_lastModified&sortOrder=desc&page=0&items=18&_charset_=utf-8&_=1342558155346",
          {}, { 'subst' => 'true' })
    when 'people'
      @request.add("/var/search/users.infinity.json?q=#{query}&tags=&sortOn=_lastModified&sortOrder=desc&page=0&items=18&_charset_=utf-8&_=1342558158607",
          {}, { 'subst' => 'true' })
    when 'groups'
      @request.add("/var/search/groups.infinity.json?q=#{query}&tags=&sortOn=_lastModified&sortOrder=desc&category=group&page=0&items=18&_charset_=utf-8&_=1342558161747",
          {}, { 'subst' => 'true' })
    when 'courses'
      @request.add("/var/search/groups.infinity.json?q=#{query}&tags=&sortOn=_lastModified&sortOrder=desc&category=course&page=0&items=18&_charset_=utf-8&_=1342558164687",
          {}, { 'subst' => 'true' })
    when 'research_projects'
      @request.add("/var/search/groups.infinity.json?q=#{query}&tags=&sortOn=_lastModified&sortOrder=desc&category=research&page=0&items=18&_charset_=utf-8&_=1342558167607",
          {}, { 'subst' => 'true' })
    end
    
    if (opts[:load_search_page])
      @request.add('/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Fdisplayprofilesection%2Fdisplayprofilesection.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fdisplayprofilesection%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D&_=1324426870134')
      @request.add('/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Fprofilesection%2Fprofilesection.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fprofilesection%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D&_=1324426870481')
    end
    
  end

end