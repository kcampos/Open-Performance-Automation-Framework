#!/usr/bin/env ruby

# 
# == Synopsis
#
# Contacts class containing all operations around my contacts
#
# Author:: Lance Speelmon (mailto:lance@rsmart.com)
#

class Memberships

  attr_accessor :request

  def initialize(request_obj)
    @request = request_obj
  end

  # Load my memberships
  def my_memberships(username)

    @request.add('/system/staticfiles?_charset_=utf-8&f=%2Fdevwidgets%2Fmymemberships%2Fmymemberships.html&f=%2Fdevwidgets%2Fmymemberships%2Fbundles%2Fdefault.properties')
    @request.add('/devwidgets/mymemberships/css/mymemberships.css')
    @request.add('/devwidgets/mymemberships/javascript/mymemberships.js')
    @request.add('/dev/images/memberships_icon_60x55.png')

  end

end
