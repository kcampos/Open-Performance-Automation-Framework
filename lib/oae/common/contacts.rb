#!/usr/bin/env ruby

# 
# == Synopsis
#
# Contacts class containing all operations around my contacts
#
# Author:: Lance Speelmon (mailto:lance@rsmart.com)
#

class Contacts

  attr_accessor :request

  def initialize(request_obj)
    @request = request_obj
  end

  # Load my contacts
  def my_contacts(username)

    @request.add('/system/staticfiles?_charset_=utf-8&f=%2Fdevwidgets%2Fcontacts%2Fcontacts.html&f=%2Fdevwidgets%2Fcontacts%2Fbundles%2Fdefault.properties')
    @request.add('/devwidgets/contacts/css/contacts.css')
    @request.add('/devwidgets/contacts/javascript/contacts.js')
    @request.add('/dev/images/Infinite_Scrolling_Loader_v01.gif')
    @request.add('/var/contacts/findstate.json?state=INVITED&page=0&items=18&_charset_=utf-8&_=1342647335681')
    @request.add("/var/contacts/findstate.infinity.json?q=*&sortOn=lastName&sortOrder=asc&state=ACCEPTED&userid=#{username}&page=0&items=18&_charset_=utf-8&_=1342647335687")
    @request.add('/dev/images/search_grid_16x16.png')
    @request.add('/dev/images/search_list_16x16_hover.png')
    @request.add('/dev/images/contacts_icon_60x55.png')

  end

end
