#!/usr/bin/env ruby

#
# == Description
#
# Login as a member and modify 
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
sesh = Session.new(config, 'course_modification', probability)

# Login
username = '%%_username%%'
password = '%%_user_password%%'

li_txn = sesh.add_transaction("login")
li_req = li_txn.add_requests
config.log.info_msg("#{test}: Logging in as: #{username}/#{password}")
auth = Authentication.new(li_req)
auth.login({:user => username, :password => password})

# Search for various courses
cm_req = sesh.add_transaction("course_modification").add_requests
curr_obj = Curriculum.new(cm_req)

course_title = "insects"
course_name = "Insects"
course_number = "BSCI120"
new_course_title = "Insects for fun!"
new_description_addition = " \nIt will be fun!"
new_proposal_rationale = "because there is not enuff fun"
new_credit_value = "5"

config.log.info_msg("#{test}: Modify course '#{course_title}'")

curr_obj.propose_course_modification(
  course_title,
  course_name,
  course_number,
  new_course_title,
  new_description_addition,
  new_proposal_rationale,
  new_credit_value,
  {
    :nav_homepage => false,
    :modification_person => username
  }
)

# Logout
config.log.info_msg("#{test}: Logging out")
lo_txn = sesh.add_transaction("logout")
lo_req = lo_txn.add_requests
lo_auth = Authentication.new(lo_req)
lo_auth.logout
