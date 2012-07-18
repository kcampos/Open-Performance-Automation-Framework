#!/usr/bin/env ruby

#
# == Description
#
# Login as existing user and view my messages
#

require 'drb'
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"

require config.lib_base_dir + "/tsung-api.rb"
require config.lib_base_dir + "/#{config.product}/common/authentication.rb"
require config.lib_base_dir + "/#{config.product}/common/messages.rb"

# Test info - default test case setup
test = File.basename(__FILE__)
probability = config.tests[test]
config.log.info_msg("Test: #{test}")
config.log.info_msg("Probability: #{config.tests[test]}")

# Create session
sess = Session.new(config, 'my_messages', probability)

# Login
username = '%%_username%%'
password = '%%_user_password%%'

login_txn = sesh.add_transaction("login")
login_req = login_txn.add_requests
config.log.info_msg("#{test}: Loggin in as: #{username}")
auth = Authentication.new(login_req)
auth.login(username, password)

# view my messages
my_messages_txn = sess.add_transaction("my_messages")
my_messages_req = my_messages_txn.add_requests
config.log.info_msg("#{test}: Viewing My Messages as: #{username}")
memberships = Memberships.new(my_messages_req)
memberships.my_inbox(username)
memberships.my_invitations(username)
memberships.my_sent(username)
memberships.my_trash(username)

# Logout
logout_txn = sesh.add_transaction("logout")
logout_req = logout_txn.add_requests
config.log.info_msg("#{test}: Logging out")
auth = Authentication.new(logout_req)
auth.logout
