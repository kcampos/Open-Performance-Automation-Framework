#!/usr/bin/env ruby

# 
# == Synopsis
#
# Content class containing all operations around the library content
#
# Author:: Kyle Campos (mailto:kcampos@rsmart.com)
#

#require 'base64'

class Content
  
  attr_accessor :request
  
  def initialize(request_obj)
    @request = request_obj
  end
  
  # add content
  def add(user, opts = {})
    
    defaults = {
      :type => 'text',
      :directory => 'common',
      :data_dir => @request.config.data_dir,
      :filename => 'default.txt',
      :unique_filename => false,
      :description => "uploaded from load test",
      :tag => "load-test", # only support single tag for now
      :path_var_name => 'content_add_path_uid',
      :path_var_regex => '\"_path\":\"\([^\"]+\)',
      #:encode => nil
    }
    
    opts = defaults.merge(opts)
    
    #opts[:encode] = ((opts[:type] == 'text' and opts[:encode] != nil) ? false : true)
    opts[:file_fullpath] = "#{opts[:data_dir]}/#{opts[:directory]}/#{opts[:type]}/#{opts[:filename]}"
    
    boundary, content = read_file(opts[:file_fullpath])
    
    # Think time for browsing for file, description, etc...
    @request.add_thinktime(10)
    
    @request.add('/system/pool/createfile',
      {
        'method' => 'POST',
        'content_type' => "multipart/form-data; boundary=#{boundary}",
        #'contents' => content
        'contents_from_file' => opts[:file_fullpath]
      },
      {
        :dyn_variables => [
          {"name" => opts[:path_var_name], "re" => opts[:path_var_regex]}
        ],
        :custom_headers => {
          'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
          'Accept-Language' => 'en-us,en;q=0.5',
          'Accept-Encoding' => 'gzip, deflate',
          'Accept-Charset' => 'ISO-8859-1,utf-8;q=0.7,*;q=0.7',
          'Referer' => "#{@request.url}/me",
          'Connection' => 'keep-alive'
        }
      }
    )
    
    #@request.add("/DEBUG/path_var_name/%%_#{opts[:path_var_name]}%%", {}, {'subst' => 'true'})
    
    @request.add('/system/batch',
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "requests=%5B%7B%22url%22%3A%22%2Fp%2F%%_#{opts[:path_var_name]}%%.members.html%22%2C%22method%22%3A%22POST%22%2C%22parameters%22%3A%7B%22%3Aviewer%22%3A%5B%22everyone%22%2C%22anonymous%22%5D%7D%7D%2C%7B%22url%22%3A%22%2Fp%2F%%_#{opts[:path_var_name]}%%.modifyAce.html%22%2C%22method%22%3A%22POST%22%2C%22parameters%22%3A%7B%22principalId%22%3A%5B%22everyone%22%5D%2C%22privilege%40jcr%3Aread%22%3A%22granted%22%7D%7D%2C%7B%22url%22%3A%22%2Fp%2F%%_#{opts[:path_var_name]}%%.modifyAce.html%22%2C%22method%22%3A%22POST%22%2C%22parameters%22%3A%7B%22principalId%22%3A%5B%22anonymous%22%5D%2C%22privilege%40jcr%3Aread%22%3A%22granted%22%7D%7D%5D&_charset_=utf-8"
      }, {'subst' => 'true'}
    )
    
    @request.add('/system/batch',
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fp%2F%%_#{opts[:path_var_name]}%%%22%2C%22method%22%3A%22POST%22%2C%22parameters%22%3A%7B%22sakai%3Adescription%22%3A%22#{opts[:description]}%22%2C%22sakai%3Afileextension%22%3A%22#{opts[:file_extension]}%22%2C%22sakai%3Apooled-content-file-name%22%3A%22#{opts[:filename]}%22%2C%22sakai%3Apermissions%22%3A%22public%22%2C%22sakai%3Acopyright%22%3A%22creativecommons%22%2C%22sakai%3Aallowcomments%22%3A%22true%22%2C%22sakai%3Ashowcomments%22%3A%22true%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fp%2F%%_#{opts[:path_var_name]}%%.save.json%22%2C%22method%22%3A%22POST%22%2C%22parameters%22%3A%7B%22_charset_%22%3A%22utf-8%22%7D%2C%22_charset_%22%3A%22utf-8%22%7D%5D"
      }, {'subst' => 'true'}
    )
    
    @request.add("/p/%%_#{opts[:path_var_name]}%%",
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "key=%2Ftags%2F#{opts[:tag]}&%3Aoperation=tag&_charset_=utf-8"
      }, {'subst' => 'true'}
    )
    
    @request.add("/var/search/pool/all.infinity.json?items=2&q=#{opts[:filename]}+OR+#{user}+&_charset_=utf-8", {},
      {'subst' => 'true'}
    )
    
    @request.add("/var/search/pool/manager-viewer.json?userid=#{user}&page=0&items=8&sortOn=_lastModified&sortOrder=desc&q=*&_charset_=utf-8&_=1324063075702",
      {}, {'subst' => 'true'}
    )
    
    @request.add("/~#{user}/public/authprofile.profile.json?_charset_=utf-8&_=1324063076061", {},
      {'subst' => 'true'}
    )
    
    @request.add("/~#{user}/public/authprofile.profile.json?_charset_=utf-8", {},
      {'subst' => 'true'}
    )
    
  end

  def createFileFromMyLibrary(user, opts = {})

    defaults = {
      :type => 'text',
      :directory => 'common',
      :data_dir => @request.config.data_dir,
      :filename => 'default.txt',
      :unique_filename => false,
      :description => "uploaded from load test",
      :tag => "load-test", # only support single tag for now
      :path_var_name => 'pooledcontent_add_path_uid',
      :path_jsonpath => "$._contentItem.item._path"
      #:encode => nil
    }

    opts = defaults.merge(opts)

    opts[:file_fullpath] = "#{opts[:data_dir]}/#{opts[:directory]}/#{opts[:type]}/#{opts[:filename]}"

    boundary, content = read_file(opts[:file_fullpath])

    @request.add("/system/pool/createfile",
      {
        'method' => 'POST',
        'content_type' => "multipart/form-data; boundary=#{boundary}",
        #'contents' => content
        'contents_from_file' => opts[:file_fullpath]
      },
      {
        :dyn_variables => [
          {"name" => opts[:path_var_name], "jsonpath" => opts[:path_jsonpath]}
        ],
        :custom_headers => {
          'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
          'Accept-Language' => 'en-us,en;q=0.5',
          'Accept-Encoding' => 'gzip, deflate',
          'Accept-Charset' => 'ISO-8859-1,utf-8;q=0.7,*;q=0.7',
          'Referer' => "#{@request.url}/me",
          'Connection' => 'keep-alive'
        }
      }
    )

    @request.add('/system/batch',
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "requests=%5B%7B%22url%22%3A%22%2Fp%2F%%_#{opts[:path_var_name]}%%.members.html%22%2C%22method%22%3A%22POST%22%2C%22parameters%22%3A%7B%22%3Aviewer%22%3A%5B%22everyone%22%2C%22anonymous%22%5D%7D%7D%2C%7B%22url%22%3A%22%2Fp%2F%%_#{opts[:path_var_name]}%%.modifyAce.html%22%2C%22method%22%3A%22POST%22%2C%22parameters%22%3A%7B%22principalId%22%3A%5B%22everyone%22%5D%2C%22privilege%40jcr%3Aread%22%3A%22granted%22%7D%7D%2C%7B%22url%22%3A%22%2Fp%2F%%_#{opts[:path_var_name]}%%.modifyAce.html%22%2C%22method%22%3A%22POST%22%2C%22parameters%22%3A%7B%22principalId%22%3A%5B%22anonymous%22%5D%2C%22privilege%40jcr%3Aread%22%3A%22granted%22%7D%7D%5D&_charset_=utf-8"
      },
      {'subst' => 'true'}
    )

    @request.add('/system/batch',
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fp%2F%%_#{opts[:path_var_name]}%%%22%2C%22method%22%3A%22POST%22%2C%22parameters%22%3A%7B%22sakai%3Adescription%22%3A%22#{opts[:description]}%22%2C%22sakai%3Afileextension%22%3A%22#{opts[:file_extension]}%22%2C%22sakai%3Apooled-content-file-name%22%3A%22#{opts[:filename]}%22%2C%22sakai%3Apermissions%22%3A%22public%22%2C%22sakai%3Acopyright%22%3A%22creativecommons%22%2C%22sakai%3Aallowcomments%22%3A%22true%22%2C%22sakai%3Ashowcomments%22%3A%22true%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fp%2F%%_#{opts[:path_var_name]}%%.save.json%22%2C%22method%22%3A%22POST%22%2C%22parameters%22%3A%7B%22_charset_%22%3A%22utf-8%22%7D%2C%22_charset_%22%3A%22utf-8%22%7D%5D"
      }, {'subst' => 'true'}
    )
    @request.add("/var/search/pool/all.0.json?items=2&q=%%_#{opts[:filename]}%%&_charset_=utf-8", {},
      {'subst' => 'true'}
    )

    @request.add("/~#{user}/public/authprofile.profile.json?_charset_=utf-8", {},
      {'subst' => 'true'})

    @request.add("/var/search/pool/auth-all.json?userid=#{user}&sortOn=_lastModified&sortOrder=desc&q=&page=1&items=18&_charset_=utf-8&_=1344463001923", {},
      {'subst' => 'true'}
    )

  end

  def addComment(opts = {})

    defaults = {
      :pooledcontent_var_name => "pooledcontent_add_path_uid",
      :comment_var_name => "comment_uid",
      :comment_regex => "\"commentId\":\".*comments\/\([^\"]+\)"
    }

    opts = defaults.merge(opts);

    @request.add("/p/%%_#{opts[:pooledcontent_var_name]}%%.comments",
      {
        'method'        =>  "POST",
        'content_type'  =>  "application/x-www-form-urlencoded",
        'contents'      =>  "_charset_=utf-8&comment=This+is+a+comment%0A"
      },
      {
        :dyn_variables => [
          {"name" => opts[:comment_var_name], "re" => opts[:comment_regex]}],
        'subst' => 'true'
      }
    )

    @request.add("/p/%%_#{opts[:pooledcontent_var_name]}%%.comments?sortOn=_created&sortOrder=desc&page=0&items=10&_charset_=utf-8&_=1344526376741",
      {},
      {'subst' => 'true'}
    )

    @request.add("/p/%%_#{opts[:pooledcontent_var_name]}%%.activity.json",
      {
        'method'        =>  "POST",
        'content_type'  =>  "application/x-www-form-urlencoded",
        'contents'      =>  "sakai%3Aactivity-appid=content&sakai%3Aactivity-templateid=default&sakai%3AactivityMessage=CONTENT_ADDED_COMMENT&_charset_=utf-8"
      },
      {'subst' => 'true'}
    )

    return {
      :commentSubst => "%%_#{opts[:comment_var_name]}%%"
    }

  end

  def deleteComment(opts = {})
    defaults = {
      :pooledContentSubst => "%%_pooledcontent_add_path_uid%%",
      :commentSubst => "%%_comment_uid%%"
    }

    opts = defaults.merge(opts)

#    <request><http url='http://localhost:8080/p/mAQEMW75ec.comments' version='1.1' method='DELETE'></http></request>
    @request.add("/p/#{opts[:pooledContentSubst]}.comments?commentId=#{opts[:commentSubst]}&_charset_=utf-8",
      {
        'method'        =>  "DELETE"
      },
      {'subst' => 'true'}
    )
#    <request><http url='/p/mAQEMW75ec.comments?sortOn=_created&amp;sortOrder=desc&amp;page=0&amp;items=10&amp;_charset_=utf-8&amp;_=1344526391649' version='1.1' method='GET'></http></request>
    @request.add("/p/#{opts[:pooledContentSubst]}.comments?sortOn=_created&sortOrder=desc&page=0&items=10&_charset_=utf-8&_=1344526376741",
      {},
      {'subst' => true}
    )

  end

  def loadPooledContentItem()

  end

  def addFileToPool()

  end

  def tag()
#    CLICK TAG AREA
#
#    <request><http url='/dev/lib/jquery/plugins/jquery.autoSuggest.sakai-edited.js' version='1.1' if_modified_since='Tue, 07 Aug 2012 15:31:27 GMT' method='GET'></http></request>
#    <request><http url='/system/staticfiles?_charset_=utf-8&amp;f=%2Fdevwidgets%2Fassignlocation%2Fassignlocation.html&amp;f=%2Fdevwidgets%2Fassignlocation%2Fbundles%2Fdefault.properties' version='1.1' method='GET'></http></request>
#    <request><http url='/devwidgets/assignlocation/css/assignlocation.css' version='1.1' if_modified_since='Tue, 07 Aug 2012 15:31:27 GMT' method='GET'></http></request>
#    <request><http url='/devwidgets/assignlocation/javascript/assignlocation.js' version='1.1' if_modified_since='Tue, 07 Aug 2012 15:31:27 GMT' method='GET'></http></request>
#    <request><http url='/dev/lib/jquery/plugins/jsTree/jquery.jstree.sakai-edit.js' version='1.1' if_modified_since='Tue, 07 Aug 2012 15:31:27 GMT' method='GET'></http></request>
#
#    TAG
#
#    <request><http url='/p/mAQEMW75ec' version='1.1'  contents='%3Aoperation=tag&amp;key=%2Ftags%2Ftag2&amp;_charset_=utf-8' content_type='application/x-www-form-urlencoded' method='POST'></http></request>
#    <request><http url='/p/mAQEMW75ec.activity.json' version='1.1'  contents='sakai%3Aactivity-appid=content&amp;sakai%3Aactivity-templateid=default&amp;sakai%3AactivityMessage=UPDATED_TAGS&amp;_charset_=utf-8' content_type='application/x-www-form-urlencoded' method='POST'></http></request>
  end

  def deleteTag()
#    <request><http url='/p/mAQEMW75ec' version='1.1'  contents='key=%2Ftags%2Ftesting&amp;%3Aoperation=deletetag&amp;_charset_=utf-8' content_type='application/x-www-form-urlencoded' method='POST'></http></request>
#    <request><http url='/p/mAQEMW75ec.activity.json' version='1.1'  contents='sakai%3Aactivity-appid=content&amp;sakai%3Aactivity-templateid=default&amp;sakai%3AactivityMessage=UPDATED_TAGS&amp;_charset_=utf-8' content_type='application/x-www-form-urlencoded' method='POST'></http></request>
  end

  # Load My Library
  def my_library(username)
    @request.add("/var/search/pool/auth-all.json?userid=#{username}&sortOn=_lastModified&sortOrder=desc&q=&page=0&items=18&_charset_=utf-8&_=1342652534274",
    		{}, { 'subst' => 'true' })
  end
  
  private
  
  def read_file(file)
    
    contents = File.read(file)
    boundary = contents.split(/\n/).first
    
    [boundary, contents]
    
  end
  
  #def encode_file(file, output=nil)
    
  #  dest_file = (output.nil? ? "#{file}.encoded" : output)
  #  enc = Base64.encode64()
  
  #end

  
end
