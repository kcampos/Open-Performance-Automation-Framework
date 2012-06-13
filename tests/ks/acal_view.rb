#!/usr/bin/env ruby

#
# == Description
#
# Login as a member and browse and view programs (drill in REQUISITES)
#
# === Issues
#
# Jira 1234 - Fake jira issue

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
#auth.acal_login({:user => username, :password => password})
auth.acal_login({:user => "admin", :password => "admin"})


# View Academic Calendar
vac_req = sesh.add_transaction("acal_view").add_requests
acal_view_obj = Acal.new(vac_req)

testname = "acalView"


config.log.info_msg("#{test}: View Academic Calendar '#{testname}'")
acal_view_obj.acal_view(
  testname,
  {
    :nav_homepage => false,
#    :view_person => username
    :view_person => "admin"
  }
)
# Logout
config.log.info_msg("#{test}: Logging out")
lo_txn = sesh.add_transaction("logout")
lo_req = lo_txn.add_requests
lo_auth = Authentication.new(lo_req)
lo_auth.acal_logout
