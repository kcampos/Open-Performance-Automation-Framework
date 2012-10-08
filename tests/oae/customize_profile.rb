#!/usr/bin/env ruby

#
# == Description
#
# Login as existing user and customize profile
#
# === Issues
#
# Jira 1234 - Fake jira issue

require 'drb'
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"

require config.lib_base_dir + "/tsung-api.rb"
require config.lib_base_dir + "/#{config.product}/common/explore.rb"
require config.lib_base_dir + "/#{config.product}/common/authentication.rb"
require config.lib_base_dir + "/#{config.product}/common/dashboard.rb"
require config.lib_base_dir + "/#{config.product}/common/profile.rb"

# Test info - default test case setup
test = File.basename(__FILE__)
probability = config.tests[test]
config.log.info_msg("Test: #{test}")
config.log.info_msg("Probability: #{config.tests[test]}")

# Create session
sesh = Session.new(config, 'customize_profile', probability)

# Login
username = '%%_username%%'
password = '%%_user_password%%'

# Data
new_first_name = '%%_rnd_first_name%%'
new_last_name = '%%_rnd_last_name%%'
tag_name = '%%_rnd_tag%%'

# Navigate to the home page
explore_txn = sesh.add_transaction("explore")
explore_req = explore_txn.add_requests
config.log.info_msg("#{test}: Loading the home page")
explore = Explore.new(explore_req)
explore.splash

explore_req.add_thinktime(5)

login_txn = sesh.add_transaction("login")
login_req = login_txn.add_requests
config.log.info_msg("#{test}: Logging in as: #{username}")
auth = Authentication.new(login_req)
user_data = auth.login(username, password, {
		:load_homepage => false,
		:thinktime => false
	})

# Directly to dashboard with no thinktime
dashboard_txn = sesh.add_transaction("my_dashboard")
dashboard_req = dashboard_txn.add_requests
config.log.info_msg("#{test}: View my dashboard")
dashboard = Dashboard.new(dashboard_req)
dashboard.load(username)
dashboard_req.add_thinktime(3)

# Customize Profile
profile_txn = sesh.add_transaction("customize_profile")
profile_req = profile_txn.add_requests
config.log.info_msg("#{test}: Customizing profile")
profile = Profile.new(profile_req)
profile.edit(username, new_first_name, new_last_name, user_data[:email],
  {
    :load_homepage => false,
    :sections => {
      :basic_information => {
          :tags => [tag_name]
      }
    }
  }
)

# Logout
logout_txn = sesh.add_transaction("logout")
logout_req = logout_txn.add_requests
config.log.info_msg("#{test}: Logging out")
auth = Authentication.new(logout_req)
auth.logout