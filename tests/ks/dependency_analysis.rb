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
require config.lib_base_dir + "/#{config.product}/curriculum/curriculum.rb"

# Test info - default test case setup
test = File.basename(__FILE__)
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"
probability = config.tests[test]
config.log.info_msg("Test: #{test}")
config.log.info_msg("Probability: #{config.tests[test]}")

# Create session
sesh = Session.new(config, 'dependency_analysis', probability)

# Login
username = '%%_username%%'
password = '%%_user_password%%'

li_txn = sesh.add_transaction("login")
li_req = li_txn.add_requests
config.log.info_msg("#{test}: Logging in as: #{username}/#{password}")
auth = Authentication.new(li_req)
auth.login({:user => username, :password => password})

# Browse for program
da_req = sesh.add_transaction("dependency_analysis").add_requests
curr_obj = Curriculum.new(da_req)

coursename = "BSCI222"
curr_obj.homepage

config.log.info_msg("#{test}: Dependency analysis '#{coursename}'")
curr_obj.dependency(
  coursename,
  {
    :nav_homepage => false,
    :dependency_person => username
  }
)
# Logout
config.log.info_msg("#{test}: Logging out")
lo_txn = sesh.add_transaction("logout")
lo_req = lo_txn.add_requests
lo_auth = Authentication.new(lo_req)
lo_auth.logout
