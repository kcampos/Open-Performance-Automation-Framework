#!/usr/bin/env ruby

# 
# == Synopsis
#
# Profile class containing all operations around profile functionality
#
# Author:: Kyle Campos (mailto:kcampos@rsmart.com)
#

require 'uri'

class Profile
  
  attr_accessor :request
  
  def initialize(request_obj)
    @request = request_obj
  end
  
  def homepage
    
    @request.add('/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Fdisplayprofilesection%2Fdisplayprofilesection.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fdisplayprofilesection%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D&_=1324426870134')
    @request.add('/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Fprofilesection%2Fprofilesection.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fprofilesection%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D&_=1324426870481')

  end
  
  
  # Edit profile
  # username, first_name, last_name, and email should all be dynamic variables
  def edit(username, first_name, last_name, email, opts = {})
    
    defaults = {
      :load_homepage => true,
      :sections => nil
    }
    
    opts = defaults.merge(opts)
    
    # Substitute @ for url encode
    email.sub!(/\@/, '%40')
    
    self.homepage if(opts[:load_homepage])
    
    # Iterate through each section we are updating
    opts[:sections].each_key do |section|
      
      @request.add_thinktime(5)
      
      if(section == :basic_information)
        # Basic Information
        if(opts[:sections][:basic_information][:tags])
                    
          # Editing tags
          # Bug only support 1 right now
          @request.add("/~#{username}/public/authprofile",
            {
              'method' => 'POST',
              'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
              'contents' => "key=%2Ftags%2F#{opts[:sections][:basic_information][:tags].first}&%3Aoperation=tag&_charset_=utf-8"
            }, {'subst' => 'true'}
          )
          
          @request.add("/~#{username}/public/authprofile/basic.profile.json",
            {
              'method' => 'POST',
              'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
              'contents' => "%3Aoperation=import&%3AcontentType=json&%3Areplace=true&%3AreplaceProperties=true&_charset_=utf-8&%3AremoveTree=true&%3Acontent=%7B%22access%22%3A%22everybody%22%2C%22elements%22%3A%7B%22lastName%22%3A%7B%22value%22%3A%22#{last_name}%22%7D%2C%22email%22%3A%7B%22value%22%3A%22#{email}%22%7D%2C%22firstName%22%3A%7B%22value%22%3A%22#{first_name}%22%7D%2C%22preferredName%22%3A%7B%22value%22%3A%22%22%7D%7D%7D"
            }, {'subst' => 'true'}
          )
          
          @request.add("/~#{username}/public/authprofile/userprogress",
            {
              'method' => 'POST',
              'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
              'contents' => "%3Aoperation=import&%3AcontentType=json&%3Areplace=true&%3AreplaceProperties=true&_charset_=utf-8&%3AremoveTree=true&%3Acontent=%7B%22access%22%3A%22everybody%22%2C%22elements%22%3A%7B%22lastName%22%3A%7B%22value%22%3A%22#{last_name}%22%7D%2C%22email%22%3A%7B%22value%22%3A%22#{email}%22%7D%2C%22firstName%22%3A%7B%22value%22%3A%22#{first_name}%22%7D%2C%22preferredName%22%3A%7B%22value%22%3A%22%22%7D%7D%7D"
            }, {'subst' => 'true'}
          )
        end
      end
      
    end
    
  end

end