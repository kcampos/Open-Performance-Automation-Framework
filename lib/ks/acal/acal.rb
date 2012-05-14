#!/usr/bin/env ruby

# 
# == Synopsis
#
# Organization class containing all operations around curriculum objects
#
# Author:: Ken Girvan (mailto:kgirvan@rsmart.com)
#

class Acal
  
  attr_accessor :request
  
  def initialize(request_obj)
    @request = request_obj
  end
    
  # Load academic calendar homepage
  def homepage
            
  end
  
  
  # View an Academic Calendar
  # TODO:
  #
  # Option: DEFAULT_VALUE
  # * 'mode': 'blank'
  def acal_view(testname, opts={})
    
    lo_cat = "Scientific method"
    lo_cat_text = "LO Cat Text"
    
    defaults = {
      :view_person => '%%_username%%', #user is the dynvar from users.csv
      :nav_homepage => true
    }
    
    # Version for the doc at each step. We'll increment on each usage
    # So first usage should eval to 0
    version_indicator = -1
    
    opts = defaults.merge(opts)
    
    title << '_%%ts_user_server:get_unique_id%%' if(opts[:append_unique_id])
    
    if(opts[:mode] != "blank")

    end
    
    # Navigate to Enrollment Home
    self.homepage() unless(!opts[:nav_homepage])
    
    puts "viewing academic calendar as: #{opts[:view_person]}"
    puts "test name #{testname}"

    enrollment_home
    search_for_calendar
    view_acal
    

  end
  def enrollment_home(opts={})

    @request.add("/portal.do?channelTitle=Enrollment%20Home&channelUrl=#{@request.url}/kr-rad/launch?viewId=enrollmentHomeView&methodToCall=start")
    @request.add('/kr-krad/launch?viewId=enrollmentHomeView&methodToCall=start')  

  end
  
  def search_for_calendar(opts={})
    defaults = {
      :type => 'text',
      :directory => 'common',
      :data_dir => @request.config.data_dir,
      :filename => 'acal_search.txt'
    }
    
    opts = defaults.merge(opts)
    
    @request.add("/kr-krad/calendarSearch?viewId=calendarSearchView&methodToCall=start&returnLocation=#{@request.url}/kr-rad/launch?viewId=enrollmentHomeView&")

    opts[:file_fullpath] = "#{opts[:data_dir]}/#{opts[:directory]}/#{opts[:type]}/#{opts[:filename]}"
    
    boundary, content = read_file(opts[:file_fullpath])

    @request.add('/kr-krad/calendarSearch',
      {
        'method' => 'POST',
        'content_type' => "multipart/form-data; boundary=#{boundary}",
        #'contents' => content
        'contents_from_file' => opts[:file_fullpath]
      },
      { 'subst' => 'true',
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
 
  end
  
  def view_acal(opts={})
    
    defaults = {
      :type => 'text',
      :directory => 'common',
      :data_dir => @request.config.data_dir,
      :filename => 'acal_view.txt',
      :id_dyn_var_name => 'id_dyn_var_name',
      :id_dyn_var_regexp => 'formKey%3D([^%]+)'
    }
    
    opts = defaults.merge(opts)
    
    @request.add("/kr-krad/calendarSearch?viewId=calendarSearchView&methodToCall=start&returnLocation=#{@request.url}/kr-rad/launch?viewId=enrollmentHomeView&")

    opts[:file_fullpath] = "#{opts[:data_dir]}/#{opts[:directory]}/#{opts[:type]}/#{opts[:filename]}"
    
    boundary, content = read_file(opts[:file_fullpath])

    @request.add('/kr-krad/calendarSearch',
      {
        'method' => 'POST',
        'content_type' => "multipart/form-data; boundary=#{boundary}",
        #'contents' => content
        'contents_from_file' => opts[:file_fullpath]
      },
      {
        'subst' => 'true',
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

=begin
    query = 'ohn'
    names = File.readlines('names.txt')
    matches = names.select { |name| name[/#{query}/i] }
    #=> ["John Smith"]
=end



    opts[:id_dyn_var_name] = File.read(opts[:file_fullpath])
    opts[:id_dyn_var_name] = opts[:id_dyn_var_name].scan(/formKey%3D([^%]+)/)[0][0]

#    @request.add("/DEBUG/path_var_name/#{opts[:id_dyn_var_name]}", {}, {'subst' => 'true'})
      @request.add("/kr-krad/academicCalendar?readOnlyView=true&viewId=academicCalendarFlowView&pageId=academicCalendarEditPage&methodToCall=start&history=null%252Cnull%252CHome%252Chttp%253A%252F%252F#{@request.url}%252Fportal.do%252Cnull%2524calendarSearchView%252Cnull%252CCalendar%2BSearch%252Chttp%253A%252F%252F#{@request.url}%252Fkr-krad%252FcalendarSearch%253FviewId%253DcalendarSearchView%2526returnLocation%253Dhttp%253A%252F%252F#{@request.url}%252Fkr-krad%252Flaunch%253FviewId%253DenrollmentHomeView%2526methodToCall%253Dstart%2526formKey%253D#{opts[:id_dyn_var_name]}%2526showHome%253Dfalse%252C#{opts[:id_dyn_var_name]}&id=20112012ACADEMICCALENDAR", {}, {'subst' => 'true'})

  end
  
  
  

  private
  
  def read_file(file)
    contents = File.read(file)
    boundary = contents.split(/\n/).first
    
    [boundary, contents]
    
  end  
  
  def scratch
    
    
  end
  

end