#!/usr/bin/env ruby

#
# == Description
#
# Test for View Academic Calendar
#
# Author:: Ken Girvan (mailto:kgirvan@rsmart.com)
#

require 'drb'
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"

require config.lib_base_dir + "/tsung-api.rb"
require config.lib_base_dir + "/#{config.product}/utility/authentication.rb"
require config.lib_base_dir + "/#{config.product}/acal/acal.rb"

# Test info - default test case setup
test = File.basename(__FILE__)
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"
probability = config.tests[test]
config.log.info_msg("Test: #{test}")
config.log.info_msg("Probability: #{config.tests[test]}")

# Create session
sesh = Session.new(config, 'acal_view', probability)

# Login
username = '%%_username%%'
password = '%%_user_password%%'

li_txn = sesh.add_transaction("login")
li_req = li_txn.add_requests
config.log.info_msg("#{test}: Logging in as: #{username}/#{password}")
auth = Authentication.new(li_req)
auth.acal_login({:user => "admin", :password => "admin"})

# View Academic Calendar
vac_txn = sesh.add_transaction("acal_view")
vac_req = vac_txn.add_requests

testname = "acalView"
calendarName = "2011-2012 Academic Calendar"
calendarType = "AcademicCalendar"
testButton = "view"

config.log.info_msg("#{test}: View Academic Calendar")

Acal.new(vac_req).acal_view(calendarName, calendarType, testButton, 
  {
    :nav_homepage => false,
    :view_person => "admin"
  }
)
# Logout
config.log.info_msg("#{test}: Logging out")
lo_txn = sesh.add_transaction("logout")
lo_req = lo_txn.add_requests
lo_auth = Authentication.new(lo_req)
lo_auth.acal_logout