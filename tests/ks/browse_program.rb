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
sesh = Session.new(config, 'browse_program', probability)

# Login
username = '%%_username%%'
password = '%%_user_password%%'

li_txn = sesh.add_transaction("login")
li_req = li_txn.add_requests
config.log.info_msg("#{test}: Logging in as: #{username}/#{password}")
auth = Authentication.new(li_req)
auth.login({:user => username, :password => password})

# Browse for program
bp_req = sesh.add_transaction("browse_program").add_requests
curr_obj = Curriculum.new(bp_req)

program_name = "Biological Sciences"
program_specialization = "General Biology"
requisite1 = "BSCI106"
requisite2 = "BSCI222"
curr_obj.homepage

config.log.info_msg("#{test}: Browse for program '#{program_name}'")
#req_obj = sesh.add_transaction(transaction).add_requests
curr_obj.browse(
  program_name,
  program_specialization,
  requisite1,
  requisite2,
  {
    :nav_homepage => false,
    :browse_person => username
  }
)
# Logout
config.log.info_msg("#{test}: Logging out")
lo_txn = sesh.add_transaction("logout")
lo_req = lo_txn.add_requests
lo_auth = Authentication.new(lo_req)
lo_auth.logout
