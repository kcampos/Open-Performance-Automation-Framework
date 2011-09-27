#!/usr/bin/env ruby

#
# == Description
#
# Simple authentication test that navigates to org and does a search
#
# === Issues
#
# Jira 1234 - Fake jira issue

require File.dirname(__FILE__) + '/../lib/tsung-api.rb'
require File.dirname(__FILE__) + '/../lib/utility/authentication.rb'
require File.dirname(__FILE__) + '/../lib/organization/organization.rb'
require 'drb'

# Test info - default test case setup
test = File.basename(__FILE__)
tconfig = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"
probability = tconfig.tests[test]
tconfig.log.info_msg("Test: #{test}")
tconfig.log.info_msg("Probability: #{tconfig.tests[test]}")

# Create session
sesh = Session.new(tconfig, 'org_search', probability)

# Login
txn = sesh.add_transaction("login")
req = txn.add_requests
tconfig.log.info_msg("#{test}: Logging in as admin")
auth = Authentication.new(req)
auth.login

# Navigate to org
tconfig.log.info_msg("#{test}: Navigating to org")
org_txn = sesh.add_transaction("org_search")
org_req = org_txn.add_requests
org_obj = Organization.new(org_req)
org_obj.homepage
org_obj.search("Fisheries Department")

# Logout
tconfig.log.info_msg("#{test}: Logging out")
lo_txn = sesh.add_transaction("logout")
lo_req = lo_txn.add_requests
lo_auth = Authentication.new(lo_req)
lo_auth.logout


