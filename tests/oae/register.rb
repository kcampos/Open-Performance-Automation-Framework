#!/usr/bin/env ruby

#
# == Description
#
# Register a new user on OAE
#
# === Issues
#
# Jira 1234 - Fake jira issue

require 'drb'
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"

require config.lib_base_dir + "/tsung-api.rb"
require config.lib_base_dir + "/#{config.product}/common/authentication.rb"


# Test info - default test case setup
test = File.basename(__FILE__)
probability = config.tests[test]
config.log.info_msg("Test: #{test}")
config.log.info_msg("Probability: #{config.tests[test]}")

# Create session
sesh = Session.new(config, 'register', probability)

# Register
username = 'load_user_%%ts_user_server:get_unique_id%%' #unique id

reg_txn = sesh.add_transaction("register")
reg_req = reg_txn.add_requests
config.log.info_msg("#{test}: Registering as: #{username}")
auth = Authentication.new(reg_req)
auth.register(username)


# Logout
logout_txn = sesh.add_transaction("logout")
logout_req = logout_txn.add_requests
config.log.info_msg("#{test}: Logging out")
auth = Authentication.new(logout_req)
auth.logout