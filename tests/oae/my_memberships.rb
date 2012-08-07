#!/usr/bin/env ruby

#
# == Description
#
# Login as existing user and view my memberships
#

require 'drb'
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"

require config.lib_base_dir + "/tsung-api.rb"
require config.lib_base_dir + "/#{config.product}/common/authentication.rb"
require config.lib_base_dir + "/#{config.product}/common/memberships.rb"

# Test info - default test case setup
test = File.basename(__FILE__)
probability = config.tests[test]
config.log.info_msg("Test: #{test}")
config.log.info_msg("Probability: #{config.tests[test]}")

# Create session
sesh = Session.new(config, 'my_memberships', probability)

# Login
username = '%%_username%%'
password = '%%_user_password%%'

login_txn = sesh.add_transaction("login")
login_req = login_txn.add_requests
config.log.info_msg("#{test}: Loggin in as: #{username}")
auth = Authentication.new(login_req)
auth.login(username, password)

# view my memberships
my_memberships_txn = sesh.add_transaction("my_memberships")
my_memberships_req = my_memberships_txn.add_requests
config.log.info_msg("#{test}: Viewing My Memberships as: #{username}")
memberships = Memberships.new(my_memberships_req)
memberships.my_memberships(username)

# Logout
logout_txn = sesh.add_transaction("logout")
logout_req = logout_txn.add_requests
config.log.info_msg("#{test}: Logging out")
auth = Authentication.new(logout_req)
auth.logout
