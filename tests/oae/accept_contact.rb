#!/usr/bin/env ruby

#
# == Description
#
# Login as existing user and accept a pending contact
#
# == Prerequisites
#
# This needs to know preloaded with some known pending contact invitations in the data-set.
# There should be a CSV file that provides the following variables:
#
# * _accept_inviter_username: The username of the user to initiated the contact request
# * _accept_invitee_username: The username of the user who will accept the contact request
# * _accept_invitee_password: The password of the user who will accept the contact request
#
require 'drb'
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"

require config.lib_base_dir + "/tsung-api.rb"
require config.lib_base_dir + "/#{config.product}/common/explore.rb"
require config.lib_base_dir + "/#{config.product}/common/authentication.rb"
require config.lib_base_dir + "/#{config.product}/common/dashboard.rb"
require config.lib_base_dir + "/#{config.product}/common/messages.rb"
require config.lib_base_dir + "/#{config.product}/common/contacts.rb"

# Test info - default test case setup
test = File.basename(__FILE__)
probability = config.tests[test]
config.log.info_msg("Test: #{test}")
config.log.info_msg("Probability: #{config.tests[test]}")

# Login User
invitee_username = '%%_accept_invitee_username%%'
invitee_password = '%%_accept_invitee_password%%'

# Whose contact request to accept
inviter_username = '%%_accept_inviter_username%%'

# Create session
sesh = Session.new(config, 'accept_contact', probability)

# Navigate to the home page
explore_txn = sesh.add_transaction("explore")
explore_req = explore_txn.add_requests
config.log.info_msg("#{test}: Loading the home page")
explore = Explore.new(explore_req)
explore.splash

explore_req.add_thinktime(5)

login_txn = sesh.add_transaction("login")
login_req = login_txn.add_requests
config.log.info_msg("#{test}: Logging in as: #{invitee_username}")
auth = Authentication.new(login_req)
auth.login(invitee_username, invitee_password, {
		:load_homepage => false,
		:thinktime => false
	})

# Directly to dashboard with no thinktime
dashboard_txn = sesh.add_transaction("my_dashboard")
dashboard_req = dashboard_txn.add_requests
config.log.info_msg("#{test}: View my dashboard")
dashboard = Dashboard.new(dashboard_req)
dashboard.load(invitee_username)
dashboard_req.add_thinktime(3)

# View my messages
my_messages_txn = sesh.add_transaction("my_messages_inbox")
my_messages_req = my_messages_txn.add_requests
config.log.info_msg("#{test}: Viewing My Messages as: #{invitee_username}")
my_messages = Messages.new(my_messages_req)
my_messages.my_inbox(invitee_username)

# Accept the invitation
accept_txn = sesh.add_transaction("accept_contact_request")
accept_req = accept_txn.add_requests
config.log.info_msg("#{test}: Accept contact request from #{inviter_username} to #{invitee_username}")
contacts = Contacts.new(accept_req)
contacts.accept(inviter_username, invitee_username)

# Logout
logout_txn = sesh.add_transaction("logout")
logout_req = logout_txn.add_requests
config.log.info_msg("#{test}: Logging out")
auth = Authentication.new(logout_req)
auth.logout

