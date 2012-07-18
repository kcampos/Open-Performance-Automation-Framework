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
      @request.add('/system/staticfiles?_charset_=utf-8&f=%2Fdev%2Fbundle%2Fdefault.properties&f=%2Fdev%2Fconfiguration%2Fcustom.properties&f=%2Fdev%2Fbundle%2Fen_US.properties')
      @request.add('/system/staticfiles?_charset_=utf-8&f=%2Fdevwidgets%2Fbranding%2Fbranding.html&f=%2Fdevwidgets%2Ftopnavigation%2Ftopnavigation.html&f=%2Fdevwidgets%2Fentity%2Fentity.html&f=%2Fdevwidgets%2Flhnavigation%2Flhnavigation.html&f=%2Fdevwidgets%2Fcontentauthoring%2Fcontentauthoring.html&f=%2Fdevwidgets%2Ffooter%2Ffooter.html&f=%2Fdevwidgets%2Fbranding%2Fbundles%2Fdefault.properties&f=%2Fdevwidgets%2Ftopnavigation%2Fbundles%2Fdefault.properties&f=%2Fdevwidgets%2Ftopnavigation%2Fbundles%2Fen_US.properties&f=%2Fdevwidgets%2Fentity%2Fbundles%2Fdefault.properties&f=%2Fdevwidgets%2Flhnavigation%2Fbundles%2Fdefault.properties&f=%2Fdevwidgets%2Fcontentauthoring%2Fbundles%2Fdefault.properties&f=%2Fdevwidgets%2Ffooter%2Fbundles%2Fdefault.properties&f=%2Fdevwidgets%2Ffooter%2Fbundles%2Fen_US.properties')
      @request.add('/var/templates/worlds.2.json?_charset_=utf-8')
      @request.add('/system/staticfiles?_charset_=utf-8&f=%2Fdevwidgets%2Fversions%2Fversions.html&f=%2Fdevwidgets%2Fversions%2Fbundles%2Fdefault.properties')
    end
    
    case opts[:search_category]
    when 'all'
      @request.add('/system/staticfiles?_charset_=utf-8&f=%2Fdevwidgets%2Fsearchall%2Fsearchall.html&f=%2Fdevwidgets%2Fsearchall%2Fbundles%2Fdefault.properties')
      @request.add('/var/search/general.json?q=*&tags=&sortOn=_lastModified&sortOrder=desc&page=0&items=18&_charset_=utf-8&_=1342558141063')
    when 'content'
      @request.add('/system/staticfiles?_charset_=utf-8&f=%2Fdevwidgets%2Fsearchcontent%2Fsearchcontent.html&f=%2Fdevwidgets%2Fsearchcontent%2Fbundles%2Fdefault.properties')
      @request.add('/devwidgets/searchcontent/javascript/searchcontent.js')
      @request.add('/system/staticfiles?_charset_=utf-8&f=%2Fdevwidgets%2Ffaceted%2Ffaceted.html&f=%2Fdevwidgets%2Ffaceted%2Fbundles%2Fdefault.properties')
      @request.add('/var/search/pool/all.infinity.json?q=My+AND+Search&tags=&sortOn=_lastModified&sortOrder=desc&page=0&items=18&_charset_=utf-8&_=1342558155346')
      @request.add('/devwidgets/faceted/css/faceted.css')
      @request.add('/devwidgets/faceted/javascript/faceted.js')
      @request.add('/dev/images/content_search_icon_55x55.png')
    when 'people'
      @request.add('/system/staticfiles?_charset_=utf-8&f=%2Fdevwidgets%2Fsearchpeople%2Fsearchpeople.html&f=%2Fdevwidgets%2Fsearchpeople%2Fbundles%2Fdefault.properties')
      @request.add('/devwidgets/searchpeople/javascript/searchpeople.js')
      @request.add('/system/staticfiles?_charset_=utf-8&f=%2Fdevwidgets%2Ffaceted%2Ffaceted.html&f=%2Fdevwidgets%2Ffaceted%2Fbundles%2Fdefault.properties')
      @request.add('/var/search/users.infinity.json?q=My+AND+Search&tags=&sortOn=_lastModified&sortOrder=desc&page=0&items=18&_charset_=utf-8&_=1342558158607')
      @request.add('/devwidgets/faceted/css/faceted.css')
      @request.add('/devwidgets/faceted/javascript/faceted.js')
      @request.add('/dev/images/people_search_icon_55x55.png')
    when 'groups'
      @request.add('/system/staticfiles?_charset_=utf-8&f=%2Fdevwidgets%2Fsearchgroups%2Fsearchgroups.html&f=%2Fdevwidgets%2Fsearchgroups%2Fbundles%2Fdefault.properties')
      @request.add('/devwidgets/searchgroups/javascript/searchgroups.js')
      @request.add('/system/staticfiles?_charset_=utf-8&f=%2Fdevwidgets%2Ffaceted%2Ffaceted.html&f=%2Fdevwidgets%2Ffaceted%2Fbundles%2Fdefault.properties')
      @request.add('/var/search/groups.infinity.json?q=My+AND+Search&tags=&sortOn=_lastModified&sortOrder=desc&category=group&page=0&items=18&_charset_=utf-8&_=1342558161747')
      @request.add('/devwidgets/faceted/css/faceted.css')
      @request.add('/devwidgets/faceted/javascript/faceted.js')
      @request.add('/dev/images/world_search_icon_55x55.png')
    when 'courses'
      @request.add('/system/staticfiles?_charset_=utf-8&f=%2Fdevwidgets%2Fsearchgroups%2Fsearchgroups.html&f=%2Fdevwidgets%2Fsearchgroups%2Fbundles%2Fdefault.properties')
      @request.add('/devwidgets/searchgroups/javascript/searchgroups.js')
      @request.add('/system/staticfiles?_charset_=utf-8&f=%2Fdevwidgets%2Ffaceted%2Ffaceted.html&f=%2Fdevwidgets%2Ffaceted%2Fbundles%2Fdefault.properties')
      @request.add('/var/search/groups.infinity.json?q=My+AND+Search&tags=&sortOn=_lastModified&sortOrder=desc&category=course&page=0&items=18&_charset_=utf-8&_=1342558164687')
      @request.add('/devwidgets/faceted/css/faceted.css')
      @request.add('/devwidgets/faceted/javascript/faceted.js')
      @request.add('/dev/images/world_search_icon_55x55.png')
    when 'research_projects'
      @request.add('/system/staticfiles?_charset_=utf-8&f=%2Fdevwidgets%2Fsearchgroups%2Fsearchgroups.html&f=%2Fdevwidgets%2Fsearchgroups%2Fbundles%2Fdefault.properties')
      @request.add('/devwidgets/searchgroups/javascript/searchgroups.js')
      @request.add('/system/staticfiles?_charset_=utf-8&f=%2Fdevwidgets%2Ffaceted%2Ffaceted.html&f=%2Fdevwidgets%2Ffaceted%2Fbundles%2Fdefault.properties')
      @request.add('/var/search/groups.infinity.json?q=My+AND+Search&tags=&sortOn=_lastModified&sortOrder=desc&category=research&page=0&items=18&_charset_=utf-8&_=1342558167607')
      @request.add('/devwidgets/faceted/css/faceted.css')
      @request.add('/devwidgets/faceted/javascript/faceted.js')
      @request.add('/dev/images/world_search_icon_55x55.png')    
    end
    
    if (opts[:load_search_page])
      @request.add('/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Fdisplayprofilesection%2Fdisplayprofilesection.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fdisplayprofilesection%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D&_=1324426870134')
      @request.add('/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Fprofilesection%2Fprofilesection.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fprofilesection%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D&_=1324426870481')
    end
    
  end

end