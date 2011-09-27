#!/usr/bin/env ruby

#
# == Description
#
# Simple authentication test that logs in and back out
#
# === Issues
#
# Jira 1234 - Fake jira issue

require File.dirname(__FILE__) + '/../lib/tsung-api.rb'
require File.dirname(__FILE__) + '/../lib/utility/authentication.rb'
require 'drb'

# Test info - default test case setup
test = File.basename(__FILE__)
tconfig = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"
probability = tconfig.tests[test]
tconfig.log.info_msg("Test: #{test}")
tconfig.log.info_msg("Probability: #{tconfig.tests[test]}")

# Create session, transation and request container objects
sesh = Session.new(tconfig, 'basic_auth', probability)
txn = sesh.add_transaction("login")
req = txn.add_requests

# Login
tconfig.log.info_msg("#{test}: Logging in as admin")
auth = Authentication.new(req)
auth.login

# Logout
tconfig.log.info_msg("#{test}: Logging out")
txn2 = sesh.add_transaction("logout")
req2 = txn2.add_requests
auth2 = Authentication.new(req2)
auth2.logout


