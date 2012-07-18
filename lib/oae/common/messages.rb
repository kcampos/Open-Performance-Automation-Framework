#!/usr/bin/env ruby

# 
# == Synopsis
#
# Contacts class containing all operations around my messages
#
# Author:: Lance Speelmon (mailto:lance@rsmart.com)
#

class Messages

  attr_accessor :request

  def initialize(request_obj)
    @request = request_obj
  end

  # Load inbox
  def my_inbox(username)

    @request.add('/system/staticfiles?_charset_=utf-8&f=%2Fdevwidgets%2Finbox%2Finbox.html&f=%2Fdevwidgets%2Finbox%2Fbundles%2Fdefault.properties')
    @request.add('/devwidgets/inbox/css/inbox.css')
    @request.add('/devwidgets/inbox/javascript/inbox.js')
    @request.add('/dev/images/Infinite_Scrolling_Loader_v01.gif')
    @request.add('/var/message/boxcategory-all.json?box=inbox&items=18&page=0&sortOn=_created&sortOrder=desc&category=message&_charset_=utf-8&_=1342651323360')
    @request.add("/~#{username}/message.count.json?filters=sakai:messagebox,sakai:read&values=inbox,false&groupedby=sakai:category&_charset_=utf-8&_=1342651323407")
    @request.add('/dev/images/person_icon_55x55.png')
    @request.add_thinktime(5)

  end

  # Load my invitations
  def my_invitations(username)

    @request.add('/system/staticfiles?_charset_=utf-8&f=%2Fdevwidgets%2Finbox%2Finbox.html&f=%2Fdevwidgets%2Finbox%2Fbundles%2Fdefault.properties')
    @request.add('/devwidgets/inbox/javascript/inbox.js')
    @request.add('/var/message/boxcategory-all.json?box=inbox&items=18&page=0&sortOn=_created&sortOrder=desc&category=invitation&_charset_=utf-8&_=1342651660506')
    @request.add("/~#{username}/message.count.json?filters=sakai:messagebox,sakai:read&values=inbox,false&groupedby=sakai:category&_charset_=utf-8&_=1342651660558")
    @request.add('/dev/images/contacts_icon_60x55.png')
    @request.add_thinktime(5)

  end

  # Load my sent items
  def my_sent(username)

    @request.add('/system/staticfiles?_charset_=utf-8&f=%2Fdevwidgets%2Finbox%2Finbox.html&f=%2Fdevwidgets%2Finbox%2Fbundles%2Fdefault.properties')
    @request.add('/devwidgets/inbox/javascript/inbox.js')
    @request.add('/var/message/boxcategory-all.json?box=outbox&items=18&page=0&sortOn=_created&sortOrder=desc&category=*&_charset_=utf-8&_=1342651891757')
    @request.add('/dev/images/replied_icon_55x55.png')
    @request.add_thinktime(5)

  end

  # Load trash
  def my_trash(username)

    @request.add('/system/staticfiles?_charset_=utf-8&f=%2Fdevwidgets%2Finbox%2Finbox.html&f=%2Fdevwidgets%2Finbox%2Fbundles%2Fdefault.properties')
    @request.add('/devwidgets/inbox/javascript/inbox.js')
    @request.add('/var/message/boxcategory-all.json?box=trash&items=18&page=0&sortOn=_created&sortOrder=desc&category=*&_charset_=utf-8&_=1342652016515')
    @request.add('/dev/images/trash_icon_55x55.png')
    @request.add_thinktime(5)

  end

end
