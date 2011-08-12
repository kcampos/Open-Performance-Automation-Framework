#!/usr/bin/env ruby

#
# == Description
#
# Login and search for docs
#
# === Issues
#
# Jira 1234 - Fake jira issue

require File.dirname(__FILE__) + '/../lib/tsung-api.rb'
require File.dirname(__FILE__) + '/../lib/utility/authentication.rb'
require File.dirname(__FILE__) + '/../lib/utility/utility.rb'
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
li_txn = sesh.add_transaction("login")
li_req = li_txn.add_requests
tconfig.log.info_msg("#{test}: Logging in as admin")
auth = Authentication.new(li_req)
auth.login

# Do a doc search
ds_txn = sesh.add_transaction("doc_search")
ds_req = ds_txn.add_requests
tconfig.log.info_msg("#{test}: Searching for docs")
ds_util = Utility.new(ds_req)
ds_util.doc_search