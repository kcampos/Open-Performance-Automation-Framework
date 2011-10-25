#!/usr/bin/env ruby

#
# == Description
#
# Login as a member and do various course searches
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
probability = config.tests[test]
config.log.info_msg("Test: #{test}")
config.log.info_msg("Probability: #{config.tests[test]}")

# Create session
sesh = Session.new(config, 'course_search', probability)

# Login
username = '%%_username%%'
password = '%%_user_password%%'

li_txn = sesh.add_transaction("login")
li_req = li_txn.add_requests
config.log.info_msg("#{test}: Logging in as: #{username}/#{password}")
auth = Authentication.new(li_req)
auth.login({:user => username, :password => password})

# Search for various courses
cs_req = sesh.add_transaction("course_search").add_requests
curr_obj = Curriculum.new(cs_req)

course_code = "BSCI"
course_name = "Insects"
curr_obj.homepage

config.log.info_msg("#{test}: Search for course '#{course_code}'")
curr_obj.find('course', course_code, course_name, username, {:nav_homepage => false})

# Logout
config.log.info_msg("#{test}: Logging out")
lo_txn = sesh.add_transaction("logout")
lo_req = lo_txn.add_requests
lo_auth = Authentication.new(lo_req)
lo_auth.logout
