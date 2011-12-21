#!/usr/bin/env ruby

# 
# == Synopsis
#
# Authentication class containing all operations around app authentication
#
# Author:: Kyle Campos (mailto:kcampos@rsmart.com)
#

class Authentication
  
  attr_accessor :request
  
  def initialize(request_obj)
    @request = request_obj
  end
  
  
  # Load homepage
  def homepage
    
    @request.add('/')
    @request.add('/system/me?_charset_=utf-8&_=1323808984919')
    @request.add('/dev/lib/misc/l10n/cultures/globalize.culture.en-US.js?_charset_=utf-8&_=1323808985304')
    
    @request.add('/system/batch',
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Ftopnavigation%2Ftopnavigation.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Finstitutionalskinning%2Finstitutionalskinning.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fcategories%2Fcategories.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Frecentactivity%2Frecentactivity.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fwelcome%2Fwelcome.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffeaturedcontent%2Ffeaturedcontent.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffooter%2Ffooter.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ftopnavigation%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Finstitutionalskinning%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fcategories%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Frecentactivity%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fwelcome%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffeaturedcontent%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffooter%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D"
      }
    )
    
    @request.add('/system/batch',
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Facceptterms%2Facceptterms.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffileupload%2Ffileupload.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fnewaddcontent%2Fnewaddcontent.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fsendmessage%2Fsendmessage.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Faddtocontacts%2Faddtocontacts.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fjoingroup%2Fjoingroup.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fjoinrequestbuttons%2Fjoinrequestbuttons.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ftooltip%2Ftooltip.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Faccountpreferences%2Faccountpreferences.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fchangepic%2Fchangepic.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fsavecontent%2Fsavecontent.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fnewsharecontent%2Fnewsharecontent.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fpersoninfo%2Fpersoninfo.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Facceptterms%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffileupload%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fnewaddcontent%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fsendmessage%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Faddtocontacts%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fjoingroup%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fjoinrequestbuttons%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ftooltip%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Faccountpreferences%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fchangepic%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fsavecontent%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fnewsharecontent%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fpersoninfo%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D"
      }
    )
    
    # 400 error -> See https://jira.rsmart.com/browse/ACAD-294
    @request.add('/tags/directory.tagged.json?_charset_=utf-8&_=1323808986805')
    
    @request.add('/var/search/activity/all.json?items=12&_charset_=utf-8&_=1323808986874')
    @request.add('/var/search/public/random-content.json?page=0&items=10&tag=&type=c&_charset_=utf-8&_=1323808986936')
    
    #304
    @request.add('https://s7.addthis.com/js/250/addthis_widget.js?%23pubid=xa-4db72a071927628b&domready=1&_charset_=utf-8', {},
      {:external => true})
    
    @request.add('https://l.addthiscdn.com/live/t00/250lo.gif?1fkxwf3&uid=4cddb2a5139dd3ee&rev=107104&jsl=1&si=4ee7b8ddb2fa1fee&ln=en&pc=men&of=0&uf=0&md=0&ct=1&lt=757&pi=1&dp=', {},
      {:external => true})
      
    @request.add('/var/search/activity/all.json?items=12&_charset_=utf-8&_=1323808995587')
    
  end
  
  # Register a new user
  def register(username, opts={})
    
    defaults = {
      :load_homepage => true,
      :password => "password",
      :password_confirm => "password",
      :first_name => "Test",
      :last_name => "User",
      :email => "#{username}%40test.com",
      :title => "Mr.",
      :institution => "rSmart",
      :role => "Administrator",
      :phone => "555-555-5555",
      :lms => "Blackboard"
    }
    
    opts = defaults.merge(opts)
    
    @request.add('/') if(opts[:load_homepage])
    
    @request.add_thinktime(5)
    
    @request.add('/register')
    
    @request.add("http://rsmart.app11.hubspot.com/salog.js.aspx",
      {}, {:external => true})
    
    @request.add('/system/me?_charset_=utf-8&_=1317932031489')  #302
    @request.add('/dev/lib/misc/l10n/cultures/globalize.culture.en-US.js?_charset_=utf-8&_=1317932031688') #404
    # 302
    @request.add('/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Fcaptcha%2Fcaptcha.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fcaptcha%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D&_=1317932031860')
    # 302
    @request.add('/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Ftopnavigation%2Ftopnavigation.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffooter%2Ffooter.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ftopnavigation%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffooter%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D&_=1317932031889')
    @request.add('/system/captcha?_charset_=utf-8')
    
    @request.add('/system/batch',
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Facceptterms%2Facceptterms.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffileupload%2Ffileupload.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fnewaddcontent%2Fnewaddcontent.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fsendmessage%2Fsendmessage.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Faddtocontacts%2Faddtocontacts.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fjoingroup%2Fjoingroup.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fjoinrequestbuttons%2Fjoinrequestbuttons.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ftooltip%2Ftooltip.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Faccountpreferences%2Faccountpreferences.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fchangepic%2Fchangepic.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fsavecontent%2Fsavecontent.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fnewsharecontent%2Fnewsharecontent.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fpersoninfo%2Fpersoninfo.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Facceptterms%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffileupload%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fnewaddcontent%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fsendmessage%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Faddtocontacts%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fjoingroup%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fjoinrequestbuttons%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ftooltip%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Faccountpreferences%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fchangepic%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fsavecontent%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fnewsharecontent%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fpersoninfo%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D"
      }
    )
    
    @request.add_thinktime(5)
    
    # Filling out - forward lookup
    #giving 404 - if using dyn variable substitution we have to parse out the part of user ID that's not dynamic
    lookup = username.match('^([^%%]+)').to_s
    for i in 1..lookup.length
      itr = i-1
      @request.add("/system/userManager/user.exists.html?userid=#{lookup[0..itr]}&_charset_=utf-8&_=1317945057343", 
        {}, { 'subst' => 'true' }
      )    
    end
    
    @request.add_thinktime(25)
    
    # Submit form
    @request.add('/system/userManager/user.create.html',
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "_charset_=utf-8&locale=en_US&timezone=America%2FPhoenix&pwd=#{opts[:password]}&pwdConfirm=#{opts[:password_confirm]}&firstName=#{opts[:first_name]}&lastName=#{opts[:last_name]}&email=#{opts[:email]}&%3Aname=#{username}&%3Asakai%3Aprofile-import=%7B%22basic%22%3A%7B%22elements%22%3A%7B%22firstName%22%3A%7B%22value%22%3A%22#{opts[:first_name]}%22%7D%2C%22lastName%22%3A%7B%22value%22%3A%22#{opts[:last_name]}%22%7D%2C%22email%22%3A%7B%22value%22%3A%22#{opts[:email]}%22%7D%7D%2C%22access%22%3A%22everybody%22%7D%2C%22email%22%3A%22#{opts[:email]}%22%7D&%3Acreate-auth=reCAPTCHA.net&%3Arecaptcha-challenge=03AHJ_Vuvbk6sMH8HixXQkpvZ39wx-6hYbl5ZHFcpkxJh3_ZRBiSYxXOQWPdLPKb9F3FSpnYfZyo4huD37kHg8z3E3IsOfjotxlOh7tv4wnlVxzOtSe-7SOiNWHRmt00t7ah01jFYNczwj98zBooVQmkLL-RNsd8Axmg&%3Arecaptcha-response=tiaprw+For&%3Aregistration=%7B%22hubspotutk%22%3A%22d2374244454e4d6f8c00c49801db7495%22%2C%22title%22%3A%22#{opts[:title]}%22%2C%22institution%22%3A%22#{opts[:institution]}%22%2C%22role%22%3A%22#{opts[:role]}%22%2C%22phone%22%3A%22#{opts[:phone]}%22%2C%22currentLms%22%3A%22#{opts[:lms]}%22%2C%22contactPreferences%22%3A%7B%7D%7D",
        :auth => {:username => 'admin', :password => 'admin'}
      }, { 'subst' => 'true' }
    )
    
    @request.add("http://rsmart.app11.hubspot.com/salog.js.aspx",
      {}, {:external => true})
    @request.add("http://rsmart.app11.hubspot.com/salog20.js?v=2.12",
      {}, {:external => true})
      
    @request.add('/system/me?_charset_=utf-8&_=1317945061655')
    @request.add('/dev/lib/misc/l10n/cultures/globalize.culture.en-US.js?_charset_=utf-8&_=1317945061901')
    @request.add('/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdev%2Fbundle%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdev%2Fbundle%2Fen_US.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D')
    @request.add("/~#{username}/message.count.json?filters=sakai:messagebox,sakai:read&values=inbox,false&groupedby=sakai:category&_charset_=utf-8&_=1317945062224",
      {}, { 'subst' => 'true' }
    )
    
    @request.add('/system/batch',
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Ftopnavigation%2Ftopnavigation.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fentity%2Fentity.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Flhnavigation%2Flhnavigation.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fuserpermissions%2Fuserpermissions.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fassignlocation%2Fassignlocation.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffooter%2Ffooter.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ftopnavigation%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ftopnavigation%2Fbundles%2Fen_US.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fentity%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Flhnavigation%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fuserpermissions%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fassignlocation%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffooter%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffooter%2Fbundles%2Fen_US.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D"
      }
    )
    
    # Giving 404 - Jira: https://jira.rsmart.com/browse/OAE-80
    @request.add("/~#{username}/public/pubspace.infinity.json?_charset_=utf-8&_=1317945062920",
      {}, { 'subst' => 'true' }
    )
    
    @request.add('/system/batch',
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Facceptterms%2Facceptterms.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffileupload%2Ffileupload.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fnewaddcontent%2Fnewaddcontent.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fsendmessage%2Fsendmessage.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Faddtocontacts%2Faddtocontacts.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fjoingroup%2Fjoingroup.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fjoinrequestbuttons%2Fjoinrequestbuttons.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ftooltip%2Ftooltip.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Faccountpreferences%2Faccountpreferences.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fchangepic%2Fchangepic.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fsavecontent%2Fsavecontent.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fnewsharecontent%2Fnewsharecontent.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fpersoninfo%2Fpersoninfo.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Facceptterms%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffileupload%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffileupload%2Fbundles%2Fen_US.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fnewaddcontent%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fsendmessage%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Faddtocontacts%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fjoingroup%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fjoinrequestbuttons%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ftooltip%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Faccountpreferences%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fchangepic%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fchangepic%2Fbundles%2Fen_US.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fsavecontent%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fnewsharecontent%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fpersoninfo%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D"
      }
    )
    
    @request.add('/system/batch',
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2F~#{username}%2Fpublic%2Fauthprofile%2Fbasic%22%2C%22method%22%3A%22POST%22%2C%22parameters%22%3A%7B%22init%22%3Atrue%2C%22_charset_%22%3A%22utf-8%22%7D%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2F~#{username}%2Fpublic%2Fauthprofile%2Faboutme%22%2C%22method%22%3A%22POST%22%2C%22parameters%22%3A%7B%22init%22%3Atrue%2C%22_charset_%22%3A%22utf-8%22%7D%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2F~#{username}%2Fpublic%2Fauthprofile%2Flocations%22%2C%22method%22%3A%22POST%22%2C%22parameters%22%3A%7B%22init%22%3Atrue%2C%22_charset_%22%3A%22utf-8%22%7D%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2F~#{username}%2Fpublic%2Fauthprofile%2Fpublications%22%2C%22method%22%3A%22POST%22%2C%22parameters%22%3A%7B%22init%22%3Atrue%2C%22_charset_%22%3A%22utf-8%22%7D%2C%22_charset_%22%3A%22utf-8%22%7D%5D"
      }, { 'subst' => 'true' }
    )
    
    # Giving 404 - Jira: https://jira.rsmart.com/browse/OAE-80
    @request.add("/~#{username}/private/privspace.infinity.json?_charset_=utf-8&_=1317945063417",
      {}, { 'subst' => 'true' }
    )

    @request.add("/~#{username}/public/pubspace",
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "%3Aoperation=import&%3AcontentType=json&%3Areplace=true&%3AreplaceProperties=true&_charset_=utf-8&%3Acontent=%7B%22structure0%22%3A%22%7B%5C%22profile%5C%22%3A%7B%5C%22_title%5C%22%3A%5C%22My+Profile%5C%22%2C%5C%22_altTitle%5C%22%3A%5C%22%24%7Buser%7D's+Profile%5C%22%2C%5C%22_order%5C%22%3A0%2C%5C%22_canEdit%5C%22%3Atrue%2C%5C%22_nonEditable%5C%22%3Atrue%2C%5C%22_reorderOnly%5C%22%3Atrue%2C%5C%22_canSubedit%5C%22%3Atrue%2C%5C%22basic%5C%22%3A%7B%5C%22_ref%5C%22%3A%5C%22id7906764%5C%22%2C%5C%22_order%5C%22%3A0%2C%5C%22_altTitle%5C%22%3A%5C%22__MSG__PROFILE_BASIC_LABEL__%5C%22%2C%5C%22_title%5C%22%3A%5C%22__MSG__PROFILE_BASIC_LABEL__%5C%22%2C%5C%22_nonEditable%5C%22%3Atrue%2C%5C%22_view%5C%22%3A%5C%22anonymous%5C%22%2C%5C%22_reorderOnly%5C%22%3Atrue%7D%2C%5C%22aboutme%5C%22%3A%7B%5C%22_ref%5C%22%3A%5C%22id4242982%5C%22%2C%5C%22_order%5C%22%3A1%2C%5C%22_altTitle%5C%22%3A%5C%22__MSG__PROFILE_ABOUTME_LABEL__%5C%22%2C%5C%22_title%5C%22%3A%5C%22__MSG__PROFILE_ABOUTME_LABEL__%5C%22%2C%5C%22_nonEditable%5C%22%3Atrue%2C%5C%22_view%5C%22%3A%5C%22anonymous%5C%22%2C%5C%22_reorderOnly%5C%22%3Afalse%7D%2C%5C%22locations%5C%22%3A%7B%5C%22_ref%5C%22%3A%5C%22id2238799%5C%22%2C%5C%22_order%5C%22%3A2%2C%5C%22_altTitle%5C%22%3A%5C%22__MSG__PROFILE_LOCATIONS_LABEL__%5C%22%2C%5C%22_title%5C%22%3A%5C%22__MSG__PROFILE_LOCATIONS_LABEL__%5C%22%2C%5C%22_nonEditable%5C%22%3Atrue%2C%5C%22_view%5C%22%3A%5C%22anonymous%5C%22%2C%5C%22_reorderOnly%5C%22%3Atrue%7D%2C%5C%22publications%5C%22%3A%7B%5C%22_ref%5C%22%3A%5C%22id2222891%5C%22%2C%5C%22_order%5C%22%3A3%2C%5C%22_altTitle%5C%22%3A%5C%22__MSG__PROFILE_PUBLICATIONS_LABEL__%5C%22%2C%5C%22_title%5C%22%3A%5C%22__MSG__PROFILE_PUBLICATIONS_LABEL__%5C%22%2C%5C%22_nonEditable%5C%22%3Atrue%2C%5C%22_view%5C%22%3A%5C%22anonymous%5C%22%2C%5C%22_reorderOnly%5C%22%3Afalse%7D%2C%5C%22_ref%5C%22%3A%5C%22id7906764%5C%22%7D%2C%5C%22library%5C%22%3A%7B%5C%22_ref%5C%22%3A%5C%22id30047470%5C%22%2C%5C%22_order%5C%22%3A1%2C%5C%22_title%5C%22%3A%5C%22My+Library%5C%22%2C%5C%22_altTitle%5C%22%3A%5C%22%24%7Buser%7D's+Library%5C%22%2C%5C%22_reorderOnly%5C%22%3Atrue%2C%5C%22_nonEditable%5C%22%3Atrue%2C%5C%22_view%5C%22%3A%5C%22anonymous%5C%22%2C%5C%22main%5C%22%3A%7B%5C%22_ref%5C%22%3A%5C%22id30047470%5C%22%2C%5C%22_order%5C%22%3A0%2C%5C%22_title%5C%22%3A%5C%22Content%5C%22%7D%7D%2C%5C%22memberships%5C%22%3A%7B%5C%22_title%5C%22%3A%5C%22My+Memberships%5C%22%2C%5C%22_order%5C%22%3A2%2C%5C%22_ref%5C%22%3A%5C%22id30047471%5C%22%2C%5C%22_altTitle%5C%22%3A%5C%22%24%7Buser%7D's+Memberships%5C%22%2C%5C%22_reorderOnly%5C%22%3Atrue%2C%5C%22_nonEditable%5C%22%3Atrue%2C%5C%22_view%5C%22%3A%5C%22anonymous%5C%22%2C%5C%22main%5C%22%3A%7B%5C%22_ref%5C%22%3A%5C%22id30047471%5C%22%2C%5C%22_order%5C%22%3A0%2C%5C%22_title%5C%22%3A%5C%22Memberships%5C%22%7D%7D%2C%5C%22contacts%5C%22%3A%7B%5C%22_title%5C%22%3A%5C%22My+Contacts%5C%22%2C%5C%22_order%5C%22%3A3%2C%5C%22_ref%5C%22%3A%5C%22id30047472%5C%22%2C%5C%22_altTitle%5C%22%3A%5C%22%24%7Buser%7D's+Contacts%5C%22%2C%5C%22_reorderOnly%5C%22%3Atrue%2C%5C%22_nonEditable%5C%22%3Atrue%2C%5C%22_view%5C%22%3A%5C%22anonymous%5C%22%2C%5C%22main%5C%22%3A%7B%5C%22_ref%5C%22%3A%5C%22id30047472%5C%22%2C%5C%22_order%5C%22%3A0%2C%5C%22_title%5C%22%3A%5C%22Contacts%5C%22%7D%7D%7D%22%2C%22id30047470%22%3A%7B%22page%22%3A%22%3Cdiv+id%3D'widget_mylibrary'+class%3D'widget_inline'%3E%3C%2Fdiv%3E%22%7D%2C%22id30047471%22%3A%7B%22page%22%3A%22%3Cdiv+id%3D'widget_joinrequestbuttons'+class%3D'widget_inline'%3E%3C%2Fdiv%3E+%3Cdiv+id%3D'widget_tooltip'+class%3D'widget_inline'%3E%3C%2Fdiv%3E+%3Cdiv+id%3D'widget_mymemberships'+class%3D'widget_inline'%3E%3C%2Fdiv%3E%22%7D%2C%22id30047472%22%3A%7B%22page%22%3A%22%3Cdiv+id%3D'widget_contacts'+class%3D'widget_inline'%3E%3C%2Fdiv%3E%22%7D%2C%22id7906764%22%3A%7B%22page%22%3A%22%3Cdiv+id%3D'widget_displayprofilesection_id7335828'+class%3D'widget_inline'%2F%3E%22%7D%2C%22id7335828%22%3A%7B%22sectionid%22%3A%22basic%22%7D%2C%22id4242982%22%3A%7B%22page%22%3A%22%3Cdiv+id%3D'widget_displayprofilesection_id6886086'+class%3D'widget_inline'%2F%3E%22%7D%2C%22id6886086%22%3A%7B%22sectionid%22%3A%22aboutme%22%7D%2C%22id2238799%22%3A%7B%22page%22%3A%22%3Cdiv+id%3D'widget_displayprofilesection_id7166832'+class%3D'widget_inline'%2F%3E%22%7D%2C%22id7166832%22%3A%7B%22sectionid%22%3A%22locations%22%7D%2C%22id2222891%22%3A%7B%22page%22%3A%22%3Cdiv+id%3D'widget_displayprofilesection_id641595'+class%3D'widget_inline'%2F%3E%22%7D%2C%22id641595%22%3A%7B%22sectionid%22%3A%22publications%22%7D%7D"
      }, { 'subst' => 'true' }
    )
    
    # Giving 404 - Jira: https://jira.rsmart.com/browse/OAE-80
    @request.add("/~#{username}/public/privspace",
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "%3Aoperation=import&%3AcontentType=json&%3Areplace=true&%3AreplaceProperties=true&_charset_=utf-8&%3Acontent=%7B%22structure0%22%3A%22%7B%5C%22dashboard%5C%22%3A%7B%5C%22_ref%5C%22%3A%5C%22id49248040%5C%22%2C%5C%22_title%5C%22%3A%5C%22My+Dashboard%5C%22%2C%5C%22_order%5C%22%3A0%2C%5C%22_canEdit%5C%22%3Atrue%2C%5C%22_reorderOnly%5C%22%3Atrue%2C%5C%22_nonEditable%5C%22%3Atrue%2C%5C%22main%5C%22%3A%7B%5C%22_ref%5C%22%3A%5C%22id49248040%5C%22%2C%5C%22_order%5C%22%3A0%2C%5C%22_title%5C%22%3A%5C%22Dashboard%5C%22%7D%7D%2C%5C%22messages%5C%22%3A%7B%5C%22_title%5C%22%3A%5C%22My+Messages%5C%22%2C%5C%22_ref%5C%22%3A%5C%22id49248041%5C%22%2C%5C%22_order%5C%22%3A1%2C%5C%22_canEdit%5C%22%3Atrue%2C%5C%22_reorderOnly%5C%22%3Atrue%2C%5C%22_canSubedit%5C%22%3Atrue%2C%5C%22_nonEditable%5C%22%3Atrue%2C%5C%22inbox%5C%22%3A%7B%5C%22_ref%5C%22%3A%5C%22id49248041%5C%22%2C%5C%22_order%5C%22%3A0%2C%5C%22_title%5C%22%3A%5C%22Inbox%5C%22%2C%5C%22_nonEditable%5C%22%3Atrue%7D%2C%5C%22invitations%5C%22%3A%7B%5C%22_ref%5C%22%3A%5C%22id49248042%5C%22%2C%5C%22_order%5C%22%3A1%2C%5C%22_title%5C%22%3A%5C%22Invitations%5C%22%2C%5C%22_nonEditable%5C%22%3Atrue%7D%2C%5C%22sent%5C%22%3A%7B%5C%22_ref%5C%22%3A%5C%22id49248043%5C%22%2C%5C%22_order%5C%22%3A2%2C%5C%22_title%5C%22%3A%5C%22Sent%5C%22%2C%5C%22_nonEditable%5C%22%3Atrue%7D%2C%5C%22trash%5C%22%3A%7B%5C%22_ref%5C%22%3A%5C%22id49248044%5C%22%2C%5C%22_order%5C%22%3A3%2C%5C%22_title%5C%22%3A%5C%22Trash%5C%22%2C%5C%22_nonEditable%5C%22%3Atrue%7D%7D%7D%22%2C%22id49248040%22%3A%7B%22page%22%3A%22%3Cdiv+class%3D'fl-force-right'%3E%3Cbutton+type%3D'button'+class%3D's3d-button+s3d-margin-top-5+s3d-header-button+s3d-header-smaller-button+dashboard_change_layout'+data-tuid%3D'id49248045'%3EEdit+Layout%3C%2Fbutton%3E%3Cbutton+type%3D'button'+class%3D's3d-button+s3d-margin-top-5+s3d-header-button+s3d-header-smaller-button+dashboard_global_add_widget'+data-tuid%3D'id49248045'%3EAdd+Widget%3C%2Fbutton%3E%3C%2Fdiv%3E%3Cdiv+class%3D's3d-contentpage-title'%3EMy+Dashboard%3C%2Fdiv%3E%3Cdiv+id%3D'widget_carousel'+class%3D'widget_inline'%3E%3C%2Fdiv%3E%3Cbr%2F%3E%3Cdiv+id%3D'widget_dashboard_id49248045'+class%3D'widget_inline'%3E%3C%2Fdiv%3E%22%7D%2C%22id49248041%22%3A%7B%22page%22%3A%22%3Cdiv+id%3D'widget_inbox_id49248046'+class%3D'widget_inline'%2F%3E%22%7D%2C%22id49248042%22%3A%7B%22page%22%3A%22%3Cdiv+id%3D'widget_inbox_id49248047'+class%3D'widget_inline'%2F%3E%22%7D%2C%22id49248043%22%3A%7B%22page%22%3A%22%3Cdiv+id%3D'widget_inbox_id49248048'+class%3D'widget_inline'%2F%3E%22%7D%2C%22id49248044%22%3A%7B%22page%22%3A%22%3Cdiv+id%3D'widget_inbox_id49248049'+class%3D'widget_inline'%2F%3E%22%7D%2C%22id49248045%22%3A%7B%22dashboard%22%3A%7B%22layout%22%3A%22threecolumn%22%2C%22columns%22%3A%7B%22column1%22%3A%7B%22__array__0__%22%3A%7B%22uid%22%3A%22id492480410%22%2C%22visible%22%3A%22block%22%2C%22name%22%3A%22recentchangedcontent%22%7D%7D%2C%22column2%22%3A%7B%22__array__0__%22%3A%7B%22uid%22%3A%22id492480411%22%2C%22visible%22%3A%22block%22%2C%22name%22%3A%22recentmemberships%22%7D%7D%2C%22column3%22%3A%7B%22__array__0__%22%3A%7B%22uid%22%3A%22id492480412%22%2C%22visible%22%3A%22block%22%2C%22name%22%3A%22recentcontactsnew%22%7D%7D%7D%7D%7D%2C%22id49248046%22%3A%7B%22box%22%3A%22inbox%22%2C%22category%22%3A%22message%22%2C%22title%22%3A%22INBOX%22%7D%2C%22id49248047%22%3A%7B%22box%22%3A%22inbox%22%2C%22category%22%3A%22invitation%22%2C%22title%22%3A%22INVITATIONS%22%7D%2C%22id49248048%22%3A%7B%22box%22%3A%22outbox%22%2C%22category%22%3A%22*%22%2C%22title%22%3A%22SENT%22%7D%2C%22id49248049%22%3A%7B%22box%22%3A%22trash%22%2C%22category%22%3A%22*%22%2C%22title%22%3A%22TRASH%22%7D%7D"
      }, { 'subst' => 'true' }
    )
    
    @request.add('/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Fsakaidocs%2Fsakaidocs.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fsakaidocs%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D&_=1317945063686')
    
    @request.add('/system/batch',
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "requests=%5B%7B%22url%22%3A%22%2F~#{username}%2Fpublic%2Fauthprofile%2Faboutme.modifyAce.html%22%2C%22method%22%3A%22POST%22%2C%22parameters%22%3A%7B%22principalId%22%3A%22everyone%22%2C%22privilege%40jcr%3Aread%22%3A%22granted%22%7D%7D%2C%7B%22url%22%3A%22%2F~#{username}%2Fpublic%2Fauthprofile%2Faboutme.modifyAce.html%22%2C%22method%22%3A%22POST%22%2C%22parameters%22%3A%7B%22principalId%22%3A%22anonymous%22%2C%22privilege%40jcr%3Aread%22%3A%22granted%22%7D%7D%2C%7B%22url%22%3A%22%2F~#{username}%2Fpublic%2Fauthprofile%2Faboutme.modifyAce.html%22%2C%22method%22%3A%22POST%22%2C%22parameters%22%3A%7B%22principalId%22%3A%22g-contacts-#{username}%22%2C%22privilege%40jcr%3Aread%22%3A%22granted%22%7D%7D%2C%7B%22url%22%3A%22%2F~#{username}%2Fpublic%2Fauthprofile%2Fpublications.modifyAce.html%22%2C%22method%22%3A%22POST%22%2C%22parameters%22%3A%7B%22principalId%22%3A%22everyone%22%2C%22privilege%40jcr%3Aread%22%3A%22granted%22%7D%7D%2C%7B%22url%22%3A%22%2F~#{username}%2Fpublic%2Fauthprofile%2Fpublications.modifyAce.html%22%2C%22method%22%3A%22POST%22%2C%22parameters%22%3A%7B%22principalId%22%3A%22anonymous%22%2C%22privilege%40jcr%3Aread%22%3A%22granted%22%7D%7D%2C%7B%22url%22%3A%22%2F~#{username}%2Fpublic%2Fauthprofile%2Fpublications.modifyAce.html%22%2C%22method%22%3A%22POST%22%2C%22parameters%22%3A%7B%22principalId%22%3A%22g-contacts-#{username}%22%2C%22privilege%40jcr%3Aread%22%3A%22granted%22%7D%7D%5D&_charset_=utf-8"
      }, 
      { 'subst' => 'true' }
    )
    
    @request.add("/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Fversions%2Fversions.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fversions%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D&_=1317945065761")
    @request.add("/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Fcarousel%2Fcarousel.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fdashboard%2Fdashboard.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fcarousel%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fdashboard%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D&_=1317945065825")
    @request.add("/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fvar%2Fsearch%2Fpool%2Fme%2Frelated-content.json%22%2C%22method%22%3A%22GET%22%2C%22parameters%22%3A%7B%22items%22%3A11%2C%22_charset_%22%3A%22utf-8%22%7D%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fvar%2Fcontacts%2Frelated-contacts.json%22%2C%22method%22%3A%22GET%22%2C%22parameters%22%3A%7B%22items%22%3A11%2C%22_charset_%22%3A%22utf-8%22%7D%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fvar%2Fsearch%2Fmyrelatedgroups.json%22%2C%22method%22%3A%22GET%22%2C%22parameters%22%3A%7B%22items%22%3A11%2C%22_charset_%22%3A%22utf-8%22%7D%2C%22_charset_%22%3A%22utf-8%22%7D%5D&_=1317945066635")
    @request.add("/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Frecentchangedcontent%2Frecentchangedcontent.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Frecentmemberships%2Frecentmemberships.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Frecentcontactsnew%2Frecentcontactsnew.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Frecentchangedcontent%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Frecentmemberships%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Frecentcontactsnew%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D&_=1317945066739")
    
    @request.add('/system/ucam/acceptterms?unchanged&_charset_=utf-8',
      {
        'method' => 'POST',
        'content_type' => '',
        'contents' => ""
      }
    )
    
    @request.add('/var/contacts/find-all.json?page=0&items=100&_charset_=utf-8')
    @request.add("/var/search/pool/manager-viewer.json?userid=#{username}&page=0&items=1&sortOn=_lastModified&sortOrder=desc&_charset_=utf-8&_=1317945067351",
      {}, { 'subst' => 'true' }
    )
    # Duplicate
    @request.add('/var/contacts/find-all.json?page=0&items=100&_charset_=utf-8')
    
  end
  
  # Login to OAE
  def login(username='admin', password='admin', opts ={})
    
    defaults = {
      :load_homepage => true,
      :uid_var_name => 'auth_login_uid',
      :uid_var_regex => '\"uid\":\"\([^\"]+\)',
      :dashboard_id_var_name => 'dashboard_id',
      :dashboard_id_var_regex => '<div id=\'widget_dashboard_\([^\']+\)',
      # Separating email into local and domain for URL escaping purposes
      # Can't escapse dynamic variable values and need to escape the @
      :email_local_var_name => 'auth_login_email_local',
      :email_local_var_regex => '\"email\":\"\([^\@]+\)',
      :email_domain_var_name => 'auth_login_email_domain',
      :email_domain_var_regex => '\"email\":\"[^\@]+\@\([^\"]+\)',
      :first_name_var_name => 'auth_login_first_name',
      :first_name_var_regex => '\"firstName\":\"\([^\"]+\)',
      :last_name_var_name => 'auth_login_last_name',
      :last_name_var_regex => '\"lastName\":\"\([^\"]+\)'  
    }
    
    opts = defaults.merge(opts)
    
    self.homepage if(opts[:load_homepage])
    
    @request.add_thinktime(5)
    
    @request.add('/system/sling/formlogin',
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "sakaiauth%3Alogin=1&sakaiauth%3Aun=#{username}&sakaiauth%3Apw=#{password}&_charset_=utf-8"
      }, {'subst' => 'true'}
    )
    
    @request.add('https://rsmart.app11.hubspot.com/salog.js.aspx', {},
      {:external => true})
      
    @request.add('/system/me?_charset_=utf-8&_=1323968258852', {},
      {
        :dyn_variables => [
          {"name" => opts[:email_local_var_name], "regexp" => opts[:email_local_var_regex]},
          {"name" => opts[:email_domain_var_name], "regexp" => opts[:email_domain_var_regex]},
          {"name" => opts[:first_name_var_name], "regexp" => opts[:first_name_var_regex]},
          {"name" => opts[:last_name_var_name], "regexp" => opts[:last_name_var_regex]}
        ]
      }
    )
    
    #@request.add("/DEBUG/email_local_var_name/%%_#{opts[:email_local_var_name]}%%", {}, {'subst' => 'true'})
    #@request.add("/DEBUG/email_domain_var_name/%%_#{opts[:email_domain_var_name]}%%", {}, {'subst' => 'true'})
    #@request.add("/DEBUG/first_name_var_name/%%_#{opts[:first_name_var_name]}%%", {}, {'subst' => 'true'})
    #@request.add("/DEBUG/last_name_var_name/%%_#{opts[:last_name_var_name]}%%", {}, {'subst' => 'true'})
    
    
    @request.add('/dev/lib/misc/l10n/cultures/globalize.culture.en-US.js?_charset_=utf-8&_=1323968259153')
    @request.add('/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdev%2Fbundle%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdev%2Fbundle%2Fen_US.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D')
    
    # User specific
    @request.add("/~#{username}/message.count.json?filters=sakai:messagebox,sakai:read&values=inbox,false&groupedby=sakai:category&_charset_=utf-8&_=1323968259638",
      {}, {'subst' => 'true'})
    
    @request.add('/system/batch',
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Ftopnavigation%2Ftopnavigation.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fentity%2Fentity.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Flhnavigation%2Flhnavigation.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fuserpermissions%2Fuserpermissions.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fassignlocation%2Fassignlocation.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffooter%2Ffooter.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ftopnavigation%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ftopnavigation%2Fbundles%2Fen_US.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fentity%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Flhnavigation%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fuserpermissions%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fassignlocation%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffooter%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffooter%2Fbundles%2Fen_US.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D"
      }
    )
    
    # User specific
    @request.add("/~#{username}/public/pubspace.infinity.json?_charset_=utf-8&_=1323968259894", {}, {'subst' => 'true'})
    
    @request.add('/system/batch',
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Facceptterms%2Facceptterms.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffileupload%2Ffileupload.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fnewaddcontent%2Fnewaddcontent.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fsendmessage%2Fsendmessage.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Faddtocontacts%2Faddtocontacts.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fjoingroup%2Fjoingroup.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fjoinrequestbuttons%2Fjoinrequestbuttons.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ftooltip%2Ftooltip.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Faccountpreferences%2Faccountpreferences.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fchangepic%2Fchangepic.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fsavecontent%2Fsavecontent.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fnewsharecontent%2Fnewsharecontent.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fpersoninfo%2Fpersoninfo.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Facceptterms%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffileupload%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ffileupload%2Fbundles%2Fen_US.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fnewaddcontent%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fsendmessage%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Faddtocontacts%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fjoingroup%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fjoinrequestbuttons%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Ftooltip%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Faccountpreferences%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fchangepic%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fchangepic%2Fbundles%2Fen_US.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fsavecontent%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fnewsharecontent%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fpersoninfo%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D"
      }
    )
    
    # User specific
    @request.add("/~#{username}/private/privspace.infinity.json?_charset_=utf-8&_=1323968260714", {}, 
      {
        'subst' => 'true',
        :dyn_variables => [
          {"name" => opts[:uid_var_name], "regexp" => opts[:uid_var_regex]},
          {"name" => opts[:dashboard_id_var_name], "regexp" => opts[:dashboard_id_var_regex]}
        ]
      }
    )
    
    #@request.add("/DEBUG/uid_var_name/%%_#{opts[:uid_var_name]}%%", {}, {'subst' => 'true'})
    #@request.add("/DEBUG/dashboard_id_var_name/%%_#{opts[:dashboard_id_var_name]}%%", {}, {'subst' => 'true'})
    
    @request.add('/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Fsakaidocs%2Fsakaidocs.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fsakaidocs%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D&_=1323968262490')
    @request.add('/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Fversions%2Fversions.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fversions%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D&_=1323968262934')
    @request.add('/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Fcarousel%2Fcarousel.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fdashboard%2Fdashboard.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fcarousel%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Fdashboard%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D&_=1323968263015')
    @request.add('/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fvar%2Fsearch%2Fpool%2Fme%2Frelated-content.json%22%2C%22method%22%3A%22GET%22%2C%22parameters%22%3A%7B%22items%22%3A11%2C%22_charset_%22%3A%22utf-8%22%7D%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fvar%2Fcontacts%2Frelated-contacts.json%22%2C%22method%22%3A%22GET%22%2C%22parameters%22%3A%7B%22items%22%3A11%2C%22_charset_%22%3A%22utf-8%22%7D%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fvar%2Fsearch%2Fmyrelatedgroups.json%22%2C%22method%22%3A%22GET%22%2C%22parameters%22%3A%7B%22items%22%3A11%2C%22_charset_%22%3A%22utf-8%22%7D%2C%22_charset_%22%3A%22utf-8%22%7D%5D&_=1323968263453')
    @request.add('/system/batch?_charset_=utf-8&requests=%5B%7B%22url%22%3A%22%2Fdevwidgets%2Frecentchangedcontent%2Frecentchangedcontent.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Frecentmemberships%2Frecentmemberships.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Frecentcontactsnew%2Frecentcontactsnew.html%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Frecentchangedcontent%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Frecentmemberships%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%2C%7B%22url%22%3A%22%2Fdevwidgets%2Frecentcontactsnew%2Fbundles%2Fdefault.properties%22%2C%22method%22%3A%22GET%22%2C%22_charset_%22%3A%22utf-8%22%7D%5D&_=1323968263556')
    
    # Dupe below
    @request.add('/var/contacts/find-all.json?page=0&items=100&_charset_=utf-8')
    
    # User specific
    @request.add("/var/search/pool/manager-viewer.json?userid=#{username}&page=0&items=1&sortOn=_lastModified&sortOrder=desc&_charset_=utf-8&_=1323968264029",
      {}, {'subst' => 'true'})
    
    # Dupe from above
    @request.add('/var/contacts/find-all.json?page=0&items=100&_charset_=utf-8')
    
    # Return dynamic content that other methods in test may need
    return {
      :uid => "%%_#{opts[:uid_var_name]}%%",
      :dashboard_id => "%%_#{opts[:dashboard_id_var_name]}%%",
      :email => "%%_#{opts[:email_local_var_name]}%%@%%_#{opts[:email_domain_var_name]}%%",
      :first_name => "%%_#{opts[:first_name_var_name]}%%",
      :last_name => "%%_#{opts[:last_name_var_name]}%%"
    }
    
  end
  
  # Logout
  def logout
    
    @request.add('/logout')
    
    @request.add('/var/presence.json',
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "sakai%3Astatus=offline&_charset_=utf-8"
      }
    )
    
    @request.add('/system/me?_charset_=utf-8&_=1323971191834')
    @request.add('/system/sling/logout?resource=/dev/index.html&_charset_=utf-8')
    
    self.homepage
    
  end
  
end