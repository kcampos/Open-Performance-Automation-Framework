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
require config.lib_base_dir + "/#{config.product}/common/authentication.rb"
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

login_txn = sesh.add_transaction("login")
login_req = login_txn.add_requests
config.log.info_msg("#{test}: Loggin in as: #{username}")
auth = Authentication.new(login_req)

user_data = auth.login(username, password)


# Customize Profile
profile_txn = sesh.add_transaction("customize_profile")
profile_req = profile_txn.add_requests
config.log.info_msg("#{test}: Customizing profile")
profile = Profile.new(profile_req)

profile.edit(username, user_data[:first_name], user_data[:last_name], user_data[:email],
  {
    :sections => {
      :basic_information => {
          :tags => ['winner']
      },
      :about_me => {
        
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