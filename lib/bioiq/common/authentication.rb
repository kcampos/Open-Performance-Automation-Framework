#!/usr/bin/env ruby

# 
# == Synopsis
#
# Authentication class containing all operations around app authentication
#
# Author:: Kyle Campos (mailto:kyle.campos@gmail.com)
#

class Authentication
  
  attr_accessor :request
  
  def initialize(request_obj)
    @request = request_obj
  end
  
  
  # Load homepage
  def homepage
    @request.add('/')
    @request.add('/stylesheets/marketing.css?1337924356')
    @request.add('/javascripts/application.js?1257243198')
  end
  
  # Screening programs tab
  def screening_programs
    @request.add('/employee-wellness-screening-programs')
    @request.add('/stylesheets/marketing.css?1337924356')
    @request.add('/javascripts/application.js?1257243198')
  end
  
  # How BioIQ works tab
  def how_bioiq_works
    @request.add('/how-bioiq-health-screenings-work')
    @request.add('/stylesheets/marketing.css?1337924356')
    @request.add('/javascripts/application.js?1257243198')
  end
  
  # What's included
  def whats_included
    @request.add('/employee-wellness-screening-program-features')
    @request.add('/stylesheets/marketing.css?1337924356')
    @request.add('/javascripts/application.js?1257243198')
  end
  
  # Test kits tab
  def test_kits
    @request.add('GET /employee-health-wellness-tests HTTP/1.1')
    @request.add('GET /themes/bioiq/stylesheets/partner.css?1337967627 HTTP/1.1')
    @request.add('GET /javascripts/application.js?1337924356 HTTP/1.1')
  end
  
  # Register a new user
  def register(username, opts={})
    
    defaults = {
      :load_homepage => true,
    }
    
    opts = defaults.merge(opts)
    
    self.homepage if(opts[:load_homepage])
    
    @request.add_thinktime(5)
    
    @request.add('GET /signup/path HTTP/1.1')
    @request.add('GET /themes/bioiq/stylesheets/partner.css?1337967627 HTTP/1.1')
    @request.add('GET /javascripts/application.js?1337924356 HTTP/1.1')
    
    
  end
  
end