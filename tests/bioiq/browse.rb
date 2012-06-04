#!/usr/bin/env ruby

#
# == Description
#
# Browse around the website unauthenticated
#
# === Issues
#
# 

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
sesh = Session.new(config, 'customize_dashbaord', probability)

# Login
username = '%%_username%%'
password = '%%_user_password%%'

browse_txn = sesh.add_transaction("home_browse")
browse_req = browse_txn.add_requests
config.log.info_msg("#{test}: Browsing website")
browse = Authentication.new(browse_req)

browse.homepage
browse.screening_programs
browse.how_bioiq_works
browse.whats_included
browse.test_kits
browse.register('fakeuser', {:load_homepage => false})