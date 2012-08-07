#!/usr/bin/env ruby

#
# == Description
#
# Login as existing user and invite a contact
#
require 'drb'
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"

require config.lib_base_dir + "/tsung-api.rb"
require config.lib_base_dir + "/#{config.product}/common/explore.rb"
require config.lib_base_dir + "/#{config.product}/common/authentication.rb"
require config.lib_base_dir + "/#{config.product}/common/dashboard.rb"
require config.lib_base_dir + "/#{config.product}/common/search.rb"
require config.lib_base_dir + "/#{config.product}/common/profile.rb"
require config.lib_base_dir + "/#{config.product}/common/contacts.rb"

# Test info - default test case setup
test = File.basename(__FILE__)
probability = config.tests[test]
config.log.info_msg("Test: #{test}")
config.log.info_msg("Probability: #{config.tests[test]}")

# Create session
sesh = Session.new(config, 'invite_contact', probability)

# Navigate to the home page
explore_txn = sesh.add_transaction("explore")
explore_req = explore_txn.add_requests
config.log.info_msg("#{test}: Loading the home page")
explore = Explore.new(explore_req)
explore.splash

explore_req.add_thinktime(5)

# Login
inviter_username = '%%_invite_inviter_username%%'
inviter_password = '%%_invite_inviter_password%%'

# Who to invite
invitee_username = '%%_invite_invitee_username%%'
invitee_password = '%%_invite_invitee_password%%'

login_txn = sesh.add_transaction("login")
login_req = login_txn.add_requests
config.log.info_msg("#{test}: Logging in as: #{inviter_username}")
auth = Authentication.new(login_req)
auth.login(inviter_username, inviter_password, {
		:load_homepage => false,
		:thinktime => false
	})

# Directly to dashboard with no thinktime
dashboard_txn = sesh.add_transaction("my_dashboard")
dashboard_req = dashboard_txn.add_requests
config.log.info_msg("#{test}: View my dashboard")
dashboard = Dashboard.new(dashboard_req)
dashboard.load(inviter_username)
dashboard_req.add_thinktime(3)

# Search for the user to add
search_txn = sesh.add_transaction("search_people")
search_req = search_txn.add_requests
config.log.info_msg("#{test}: Searching for user #{invitee_username}")
search = Search.new(search_req)
search.search(invitee_username)
search_req.add_thinktime(1)

# Click user
profile_txn = sesh.add_transaction("view_profile")
profile_req = profile_txn.add_requests
config.log.info_msg("#{test}: Viewing profile for #{invitee_username}")
profile = Profile.new(profile_req)
profile.view(invitee_username)

# Invite the invitee
invite_txn = sesh.add_transaction("invite_user")
invite_req = invite_txn.add_requests
config.log.info_msg("#{test}: Invite user #{invitee_username}")
contacts = Contacts.new(invite_req)
contacts.invite(inviter_username, invitee_username)

# Logout
logout_txn = sesh.add_transaction("logout")
logout_req = logout_txn.add_requests
config.log.info_msg("#{test}: Logging out")
auth = Authentication.new(logout_req)
auth.logout

