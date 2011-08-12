#!/usr/bin/env ruby

#
# == Description
#
# Login as a member and do various course searches
#
# === Issues
#
# Jira 1234 - Fake jira issue

require File.dirname(__FILE__) + '/../lib/tsung-api.rb'
require File.dirname(__FILE__) + '/../lib/utility/authentication.rb'
require File.dirname(__FILE__) + '/../lib/curriculum/curriculum.rb'
require 'drb'

# Test info - default test case setup
test = File.basename(__FILE__)
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"
probability = config.tests[test]
config.log.info_msg("Test: #{test}")
config.log.info_msg("Probability: #{config.tests[test]}")

# Create session
sesh = Session.new(config, 'course_search', probability)

# Login is department COC
username = config.directory["department_coc"]["member"]["username"]
password = config.directory["department_coc"]["member"]["password"]

li_txn = sesh.add_transaction("login")
li_req = li_txn.add_requests
config.log.info_msg("#{test}: Logging in as: #{username}/#{password}")
auth = Authentication.new(li_req)
auth.login({:user => username, :password => password})

# Search for various courses
cp_req = sesh.add_transaction("course_nav").add_requests
curr_obj = Curriculum.new(cp_req)
curr_obj.homepage

searches = {
  "wilcard" => '',
  "partial_match" => 'AM',
  "full_match" => 'Film Analysis',
  "no_match" => 'Never find this madeup course'
}

searches.each_pair do |transaction, search|
  config.log.info_msg("#{test}: Search for course '#{search}'")
  req_obj = sesh.add_transaction(transaction).add_requests
  Curriculum.new(req_obj).find('course', search, {:nav_homepage => false})
end

# Logout
config.log.info_msg("#{test}: Logging out")
lo_txn = sesh.add_transaction("logout")
lo_req = lo_txn.add_requests
lo_auth = Authentication.new(lo_req)
lo_auth.logout
