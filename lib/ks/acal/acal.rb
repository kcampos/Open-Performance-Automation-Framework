#!/usr/bin/env ruby

# 
# == Description
#
# Tests for Academic Calendar
#
# Author:: Ken Girvan (mailto:kgirvan@rsmart.com)
#

class Acal
  
  attr_accessor :request
  
  def initialize(request_obj)
    @request = request_obj
  end
    
  # Main Menu homepage
  def homepage
            
  end
  
  
  # View an Academic Calendar
  #
  # calendarName is the name of the calendar to view
  # calendarType is the type of calendar; e.g., AcacemicCalendar
  # testButton is the link that the user clicks on the Calendar Search results page; options are view, edit, copy, and delete
  #
  # This method simulates a user viewing an Academic Calendar
  # The user has logged in and clicks the "Enrollment Home" link and then enters the name of the calendar to search for and clicks Search and then clicks the "view" button
  # 
  # The user's input and default values are submitted as a form for the "search" for the calendar and also for the "view" of the calendar.
  # The following method is called to create the file that contains the form:
  # createContentsFile filepath, filename, contents_str
  # where
  # filepath is the path containing the file
  # filename is the name of the file that contains the form
  # contents_str is the text string containing the entire contents of the file
  #
  def acal_view(calendarName, calendarType, testButton, opts={})
    
    defaults = {
      :type => 'text',
      :directory => 'common',
      :data_dir => @request.config.data_dir,
      :view_person => '%%_username%%', #user is the dynvar from users.csv
      :nav_homepage => true,
      :kr_name => @request.config.directory["kr"]["name"],
      :search_viewId_dyn_var_name => "viewId",
      :search_viewId_dyn_var_regexp => 'name=\"viewId\" type=\"hidden\" value=\"([^\"]+)',
      :search_formKey_dyn_var_name => "search_formKey",
      :search_formKey_dyn_var_regexp => 'name=\"formKey\" type=\"hidden\" value=\"([^\"]+)',
      :search_validateDirty_dyn_var_name => "validateDirty",
      :search_validateDirty_dyn_var_regexp => 'name=\"validateDirty\" type=\"hidden\" value=\"([^\"]+)',
      :search_year_dyn_var_name => "year",
      :search_year_dyn_var_regexp => 'name=\"year\" class=\"uif-control uif-textControl\" tabindex=\"0\" type=\"text\" value=\"([^\"]+)',
      :search_pageId_dyn_var_name => "pageId",
      :search_pageId_dyn_var_regexp => 'name=\"pageId\" type=\"hidden\" value=\"([^\"]+)',
      :search_jumpToName_dyn_var_name => "jumpToName",
      :search_jumpToName_dyn_var_regexp => 'name=\"jumpToName\" type=\"hidden\" value=\"([^\"]+)',
      :search_formHistoryHistoryParamString_dyn_var_name => "formHistoryHistoryParamString",
      :search_formHistoryHistoryParamString_dyn_var_regexp => 'value=\"(null[^\"]+)',
      :search_methodToCall_dyn_var_name => "methodToCall",
      :search_methodToCall_dyn_var_regexp => 'methodToCall&#039; , &#039;([^&]+)',      
      :search_actionParameters_showHistory_dyn_var_name => "actionParmsShowHist",
      :search_actionParameters_showHistory_dyn_var_regexp => 'actionParameters\[showHistory\]&#039; , &#039;([^&]+)',
      :search_actionParameters_showHome_dyn_var_name => "actionParmsShowHome",
      :search_actionParameters_showHome_dyn_var_regexp => 'actionParameters\[showHome\]&#039; , &#039;([^&]+)',
      :search_showHistory_dyn_var_name => "showHistory",
      :search_showHistory_dyn_var_regexp => 'showHistory&#039;, &#039;([^&]+)',
      :search_showHome_dyn_var_name => "showHome",
      :search_showHome_dyn_var_regexp => 'showHome&#039; , &#039;([^&]+)',
      :search_focusId_dyn_var_name => "focusId",
      :search_focusId_dyn_var_regexp => 'focusId&#039; , &#039;([^&]+)',
      :search_jumpToId_dyn_var_name => "jumpToId",
      :search_jumpToId_dyn_var_regexp => 'jumpToId&#039; , &#039;([^&]+)',
      :search_renderFullView_dyn_var_name => "renderFullView",
      :search_renderFullView_dyn_var_regexp => 'renderFullView&#039; , &#039;([^&]+)',
      :view_viewId_dyn_var_name => "viewId",
      :view_viewId_dyn_var_regexp => 'name=\"viewId\" type=\"hidden\" value=\"([^\"]+)',
      :view_formKey_dyn_var_name => "view_formKey",
      :view_formKey_dyn_var_regexp => 'name=\"formKey\" type=\"hidden\" value=\"([^\"]+)',
      :view_validateDirty_dyn_var_name => "validateDirty",
      :view_validateDirty_dyn_var_regexp => 'name=\"validateDirty\" type=\"hidden\" value=\"([^\"]+)',
      :view_year_dyn_var_name => "year",
      :view_year_dyn_var_regexp => 'name=\"year\" class=\"uif-control uif-textControl\" tabindex=\"0\" type=\"text\" value=\"([^\"]+)',
      :view_pageId_dyn_var_name => "pageId",
      :view_pageId_dyn_var_regexp => 'name=\"pageId\" type=\"hidden\" value=\"([^\"]+)',
      :view_jumpToName_dyn_var_name => "jumpToName",
      :view_jumpToName_dyn_var_regexp => 'name=\"jumpToName\" type=\"hidden\" value=\"([^\"]+)',
      :view_formHistoryHistoryParamString_dyn_var_name => "formHistoryHistoryParamString",
      :view_formHistoryHistoryParamString_dyn_var_regexp => 'value=\"(null[^\"]+)',
      :view_methodToCall_dyn_var_name => "methodToCall",
      :view_methodToCall_dyn_var_regexp => 'methodToCall&#039; , &#039;([^&]+)',
      :view_actionParameters_selectedLineIndex_dyn_var_name => "actionParmsSelectedLineIndex",
      :view_actionParameters_selectedLineIndex_dyn_var_regexp => testButton + '[\S\s]+actionParameters\[selectedLineIndex\]&#039; , &#039;([^&]+)',
      :view_actionParameters_showHistory_dyn_var_name => "actionParmsShowHist",
      :view_actionParameters_showHistory_dyn_var_regexp => 'actionParameters\[showHistory\]&#039; , &#039;([^&]+)',
      :view_actionParameters_selectedCollectionPath_dyn_var_name => "actionParmsSelectedCollectionPath",
      :view_actionParameters_selectedCollectionPath_dyn_var_regexp => 'actionParameters\[selectedCollectionPath\]&#039; , &#039;([^&]+)',
      :view_actionParameters_showHome_dyn_var_name => "actionParmsShowHome",
      :view_actionParameters_showHome_dyn_var_regexp => 'actionParameters\[showHome\]&#039; , &#039;([^&]+)',
      :view_showHistory_dyn_var_name => "showHistory",
      :view_showHistory_dyn_var_regexp => 'showHistory&#039;, &#039;([^&]+)',
      :view_showHome_dyn_var_name => "showHome",
      :view_showHome_dyn_var_regexp => 'showHome&#039; , &#039;([^&]+)',
      :view_focusId_dyn_var_name => "focusId",
      :view_focusId_dyn_var_regexp => testButton + '[\S\s]+focusId&#039; , &#039;([^&]+)',
      :view_jumpToId_dyn_var_name => "jumpToId",
      :view_jumpToId_dyn_var_regexp => testButton + '[\S\s]+jumpToId&#039; , &#039;([^&]+)',
      :kr_name => @request.config.directory["kr"]["name"]
    }
    
    opts = defaults.merge(opts)

    # Navigate to Main Menu
    self.homepage() unless(!opts[:nav_homepage])
    
    puts "viewing academic calendar as: #{opts[:view_person]}"

    puts "context = #{@request.config.context}"
    
    # click "Enrollment Home"
    @request.add("/?channelTitle=Enrollment%20Home&channelUrl=#{@request.url}/#{opts[:kr_name]}/launch?viewId=enrollmentHomeView&methodToCall=start")
    @request.add("/#{opts[:kr_name]}/launch?viewId=enrollmentHomeView&methodToCall=start")  

    @request.add_thinktime(10)

    # click "Search for Calendar or Term"
      @request.add("/#{opts[:kr_name]}/calendarSearch?viewId=calendarSearchView&methodToCall=start&returnLocation=#{@request.url}/#{opts[:kr_name]}/launch?viewId=enrollmentHomeView&",
      {},
      {
        :dyn_variables => [
          {"name" => opts[:search_viewId_dyn_var_name], "re" => opts[:search_viewId_dyn_var_regexp]},
          {"name" => opts[:search_formKey_dyn_var_name], "re" => opts[:search_formKey_dyn_var_regexp]},
          {"name" => opts[:search_validateDirty_dyn_var_name], "re" => opts[:search_validateDirty_dyn_var_regexp]},
          {"name" => opts[:search_year_dyn_var_name], "re" => opts[:search_year_dyn_var_regexp]},
          {"name" => opts[:search_pageId_dyn_var_name], "re" => opts[:search_pageId_dyn_var_regexp]},
          {"name" => opts[:search_jumpToName_dyn_var_name], "re" => opts[:search_jumpToName_dyn_var_regexp]},
          {"name" => opts[:search_formHistoryHistoryParamString_dyn_var_name], "re" => opts[:search_formHistoryHistoryParamString_dyn_var_regexp]},
          {"name" => opts[:search_methodToCall_dyn_var_name], "re" => opts[:search_methodToCall_dyn_var_regexp]},
          {"name" => opts[:search_actionParameters_showHistory_dyn_var_name], "re" => opts[:search_actionParameters_showHistory_dyn_var_regexp]},
          {"name" => opts[:search_actionParameters_showHome_dyn_var_name], "re" => opts[:search_actionParameters_showHome_dyn_var_regexp]},
          {"name" => opts[:search_showHistory_dyn_var_name], "re" => opts[:search_showHistory_dyn_var_regexp]},
          {"name" => opts[:search_showHome_dyn_var_name], "re" => opts[:search_showHome_dyn_var_regexp]},
          {"name" => opts[:search_focusId_dyn_var_name], "re" => opts[:search_focusId_dyn_var_regexp]},
          {"name" => opts[:search_jumpToId_dyn_var_name], "re" => opts[:search_jumpToId_dyn_var_regexp]},
          {"name" => opts[:search_renderFullView_dyn_var_name], "re" => opts[:search_renderFullView_dyn_var_regexp]}
        ]
      }
    )

    # header boundary has 2 less characters than the body boundary
    bodyBoundarySearch = "-----------------------------" + Time.new.to_s.gsub(/\s+/, "") + "0000001"
    headerBoundarySearch = bodyBoundarySearch[2..(bodyBoundarySearch.length-1)]

contents_search ="#{bodyBoundarySearch}
Content-Disposition: form-data; name=\"viewId\"

%%_#{opts[:search_viewId_dyn_var_name]}%%
#{bodyBoundarySearch}
Content-Disposition: form-data; name=\"formKey\"

%%_#{opts[:search_formKey_dyn_var_name]}%%
#{bodyBoundarySearch}
Content-Disposition: form-data; name=\"validateDirty\"

%%_#{opts[:search_validateDirty_dyn_var_name]}%%
#{bodyBoundarySearch}
Content-Disposition: form-data; name=\"calendarType\"

#{calendarType}
#{bodyBoundarySearch}
Content-Disposition: form-data; name=\"name\"

#{calendarName}
#{bodyBoundarySearch}
Content-Disposition: form-data; name=\"year\"

%%_#{opts[:search_year_dyn_var_name]}%%
#{bodyBoundarySearch}
Content-Disposition: form-data; name=\"pageId\"

%%_#{opts[:search_pageId_dyn_var_name]}%%
#{bodyBoundarySearch}
Content-Disposition: form-data; name=\"view.currentPage.header.headerText\"

&nbsp;
#{bodyBoundarySearch}
Content-Disposition: form-data; name=\"jumpToName\"

%%_#{opts[:search_jumpToName_dyn_var_name]}%%
#{bodyBoundarySearch}
Content-Disposition: form-data; name=\"formHistory.historyParameterString\"

%%_#{opts[:search_formHistoryHistoryParamString_dyn_var_name]}%%
#{bodyBoundarySearch}
Content-Disposition: form-data; name=\"methodToCall\"

%%_#{opts[:search_methodToCall_dyn_var_name]}%%
#{bodyBoundarySearch}
Content-Disposition: form-data; name=\"actionParameters[showHistory]\"

%%_#{opts[:search_actionParameters_showHistory_dyn_var_name]}%%
#{bodyBoundarySearch}
Content-Disposition: form-data; name=\"actionParameters[showHome]\"

%%_#{opts[:search_actionParameters_showHome_dyn_var_name]}%%
#{bodyBoundarySearch}
Content-Disposition: form-data; name=\"showHistory\"

%%_#{opts[:search_showHistory_dyn_var_name]}%%
#{bodyBoundarySearch}
Content-Disposition: form-data; name=\"showHome\"

%%_#{opts[:search_showHome_dyn_var_name]}%%
#{bodyBoundarySearch}
Content-Disposition: form-data; name=\"focusId\"

%%_#{opts[:search_focusId_dyn_var_name]}%%
#{bodyBoundarySearch}
Content-Disposition: form-data; name=\"jumpToId\"

%%_#{opts[:search_jumpToId_dyn_var_name]}%%
#{bodyBoundarySearch}
Content-Disposition: form-data; name=\"renderFullView\"

%%_#{opts[:search_renderFullView_dyn_var_name]}%%
#{bodyBoundarySearch}--
"

    # the following is necessary to ensure that a CRLF happens at the end of each line
    contents_search.gsub!("\n","\r\n")

    @request.add_thinktime(10)

    opts[:file_path] = "#{opts[:data_dir]}/#{opts[:directory]}/#{opts[:type]}/"

    searchFileName= "searchPost.txt"
    createContentsFile(opts[:file_path], searchFileName, contents_search)
    searchPathAndFileName = opts[:file_path] +  searchFileName


    # Do not modify the default value of "Academic Calendar" in the "Search" selection box, and enter "2012" in the Year text box and click "Search"
    @request.add("/#{opts[:kr_name]}/calendarSearch",
    {
      'method' => 'POST',
      'content_type' => "multipart/form-data; boundary=#{headerBoundarySearch}",
      'contents_from_file' => "#{searchPathAndFileName}"
      },
      {
        'subst' => 'true',
        :dyn_variables => [
          {"name" => opts[:view_viewId_dyn_var_name], "re" => opts[:view_viewId_dyn_var_regexp]},
          {"name" => opts[:view_formKey_dyn_var_name], "re" => opts[:view_formKey_dyn_var_regexp]},
          {"name" => opts[:view_validateDirty_dyn_var_name], "re" => opts[:view_validateDirty_dyn_var_regexp]},
          {"name" => opts[:view_year_dyn_var_name], "re" => opts[:view_name_dyn_var_regexp]},
          {"name" => opts[:view_pageId_dyn_var_name], "re" => opts[:view_pageId_dyn_var_regexp]},
          {"name" => opts[:view_jumpToName_dyn_var_name], "re" => opts[:view_jumpToName_dyn_var_regexp]},
          {"name" => opts[:view_formHistoryHistoryParamString_dyn_var_name], "re" => opts[:view_formHistoryHistoryParamString_dyn_var_regexp]},
          {"name" => opts[:view_actionParameters_selectedLineIndex_dyn_var_name], "re" => opts[:view_actionParameters_selectedLineIndex_dyn_var_regexp]},          
          {"name" => opts[:view_actionParameters_showHistory_dyn_var_name], "re" => opts[:view_actionParameters_showHistory_dyn_var_regexp]},
          {"name" => opts[:view_actionParameters_selectedCollectionPath_dyn_var_name], "re" => opts[:view_actionParameters_selectedCollectionPath_dyn_var_regexp]},
          {"name" => opts[:view_actionParameters_showHome_dyn_var_name], "re" => opts[:view_actionParameters_showHome_dyn_var_regexp]},
          {"name" => opts[:view_showHistory_dyn_var_name], "re" => opts[:view_showHistory_dyn_var_regexp]},
          {"name" => opts[:view_showHome_dyn_var_name], "re" => opts[:view_showHome_dyn_var_regexp]},
          {"name" => opts[:view_focusId_dyn_var_name], "re" => opts[:view_focusId_dyn_var_regexp]},
          {"name" => opts[:view_jumpToId_dyn_var_name], "re" => opts[:view_jumpToId_dyn_var_regexp]},
        ]
      }
      )

    @request.add_thinktime(10)

    # header boundary has 2 less characters than the body boundary
    bodyBoundaryView = "-----------------------------" + Time.new.to_s.gsub(/\s+/, "") + "1111110"
    headerBoundaryView = bodyBoundaryView[2..(bodyBoundaryView.length-1)]

contents_view ="#{bodyBoundaryView}
Content-Disposition: form-data; name=\"viewId\"

%%_#{opts[:view_viewId_dyn_var_name]}%%
#{bodyBoundaryView}
Content-Disposition: form-data; name=\"formKey\"

%%_#{opts[:view_formKey_dyn_var_name]}%%
#{bodyBoundaryView}
Content-Disposition: form-data; name=\"validateDirty\"

%%_#{opts[:view_validateDirty_dyn_var_name]}%%
#{bodyBoundaryView}
Content-Disposition: form-data; name=\"calendarType\"

#{calendarType}
#{bodyBoundaryView}
Content-Disposition: form-data; name=\"name\"

#{calendarName}
#{bodyBoundaryView}
Content-Disposition: form-data; name=\"year\"

%%_#{opts[:view_year_dyn_var_name]}%%
#{bodyBoundaryView}
Content-Disposition: form-data; name=\"pageId\"

%%_#{opts[:view_pageId_dyn_var_name]}%%
#{bodyBoundaryView}
Content-Disposition: form-data; name=\"view.currentPage.header.headerText\"

&nbsp;
#{bodyBoundaryView}
Content-Disposition: form-data; name=\"jumpToName\"

%%_#{opts[:view_jumpToName_dyn_var_name]}%%
#{bodyBoundaryView}
Content-Disposition: form-data; name=\"formHistory.historyParameterString\"

%%_#{opts[:view_formHistoryHistoryParamString_dyn_var_name]}%%
#{bodyBoundaryView}
Content-Disposition: form-data; name=\"methodToCall\"

#{testButton}
#{bodyBoundaryView}
Content-Disposition: form-data; name=\"actionParameters[selectedLineIndex]\"

%%_#{opts[:view_actionParameters_selectedLineIndex_dyn_var_name]}%%
#{bodyBoundaryView}
Content-Disposition: form-data; name=\"actionParameters[showHistory]\"

%%_#{opts[:view_actionParameters_showHistory_dyn_var_name]}%%
#{bodyBoundaryView}
Content-Disposition: form-data; name=\"actionParameters[selectedCollectionPath]\"

%%_#{opts[:view_actionParameters_selectedCollectionPath_dyn_var_name]}%%
#{bodyBoundaryView}
Content-Disposition: form-data; name=\"actionParameters[showHome]\"

%%_#{opts[:view_actionParameters_showHome_dyn_var_name]}%%
#{bodyBoundaryView}
Content-Disposition: form-data; name=\"showHistory\"

%%_#{opts[:view_showHistory_dyn_var_name]}%%
#{bodyBoundaryView}
Content-Disposition: form-data; name=\"showHome\"

%%_#{opts[:view_showHome_dyn_var_name]}%%
#{bodyBoundaryView}
Content-Disposition: form-data; name=\"focusId\"

%%_#{opts[:view_focusId_dyn_var_name]}%%
#{bodyBoundaryView}
Content-Disposition: form-data; name=\"jumpToId\"

%%_#{opts[:view_jumpToId_dyn_var_name]}%%
#{bodyBoundaryView}--
"
    # the following is necessary to ensure that a CRLF happens at the end of each line
    contents_view.gsub!("\n","\r\n")

    viewFileName= "viewPost.txt"
    createContentsFile(opts[:file_path], viewFileName, contents_view)
    viewPathAndFileName = opts[:file_path] +  viewFileName

    @request.add_thinktime(20)

    # click "View"
    @request.add("/#{opts[:kr_name]}/calendarSearch",
      {
        'method' => 'POST',
        'content_type' => "multipart/form-data; boundary=#{headerBoundaryView}",
        'contents_from_file' => "#{viewPathAndFileName}"
      }, 'subst' => 'true'
      )

                @request.add("/#{opts[:kr_name]}/academicCalendar?readOnlyView=true&viewId=academicCalendarFlowView&pageId=academicCalendarEditPage&methodToCall=start&history=null%252Cnull%252CHome%252Chttp%253A%252F%252F#{@request.url}%252Fportal.do%252Cnull%2524calendarSearchView%252Cnull%252CCalendar%2BSearch%252Chttp%253A%252F%252F#{@request.url}%252F#{opts[:kr_name]}%252FcalendarSearch%253FviewId%253DcalendarSearchView%2526returnLocation%253Dhttp%253A%252F%252F#{@request.url}%252F#{opts[:kr_name]}%252Flaunch%253FviewId%253DenrollmentHomeView%2526methodToCall%253Dstart%2526formKey%253D%%_#{@view_form_key}%%%2526showHome%253Dfalse%252C%%_#{@view_form_key}%%&id=20112012ACADEMICCALENDAR", {}, {'subst' => 'true'})


    @request.add_thinktime(10)

  end


  private


  def createContentsFile(filepath,filename,contents_str)
  # ==synopsis
  # createContentsFile creates the file that is to be used in the HTTP POST for the search form and the view form.
  #
  # filepath is the path containing the file
  # filename is the name of the file that contains the form
  # contents_str is the text string containing the entire contents of the file

    path_and_filename = filepath + filename

    aFile = File.new(path_and_filename, "w")
    aFile.write(contents_str)
    aFile.close      
  
  end

  def scratch
    
    
  end
  

end