#!/usr/bin/env ruby

#
# == Description
#
# Login as a member and create a proposal
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
sesh = Session.new(config, 'create_proposal', probability)

# Login
username = '%%_username%%'
password = '%%_user_password%%'

li_txn = sesh.add_transaction("login")
li_req = li_txn.add_requests
config.log.info_msg("#{test}: Logging in as: #{username}/#{password}")
auth = Authentication.new(li_req)
auth.login({:user => username, :password => password, :primary_context => config.context, :secondary_context => config.secondary_context} )

# Create blank proposal
cp_txn = sesh.add_transaction("create_proposal")
cp_req = cp_txn.add_requests
config.log.info_msg("#{test}: Creating proposal")
Curriculum.new(cp_req).create_proposal(
  "Performance Proposal",  
  # COC dep isn't in my DB right now for some reason
  #config.directory["department_coc"]["name"],
  #config.directory["department"]["name"],
  #config.directory["department"]["name"],,
  'Biology Dept',
  'Botany Dept',
  {
    :submit => true,
    :propose_person => username
  }
)

# Logout
config.log.info_msg("#{test}: Logging out")
lo_txn = sesh.add_transaction("logout")
lo_req = lo_txn.add_requests
lo_auth = Authentication.new(lo_req)
lo_auth.logout
