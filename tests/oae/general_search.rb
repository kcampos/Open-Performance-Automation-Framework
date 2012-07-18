#!/usr/bin/env ruby

#
# == Description
#
# Login as existing user and perform a general search
#
require 'drb'
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"

require config.lib_base_dir + "/tsung-api.rb"
require config.lib_base_dir + "/#{config.product}/common/explore.rb"
require config.lib_base_dir + "/#{config.product}/common/search.rb"

# Test info - default test case setup
test = File.basename(__FILE__)
probability = config.tests[test]
config.log.info_msg("Test: #{test}")
config.log.info_msg("Probability: #{config.tests[test]}")

# Create session
sesh = Session.new(config, 'general_search', probability)

# Search term
search_term = 'ere'

# Navigate to the home page
explore_txn = sesh.add_transaction("explore")
explore_req = explore_txn.add_requests
config.log.info_msg("#{test}: Loading the home page")
explore = Explore.new(explore_req)
explore.splash

# Type search into top bar and hit enter
search_txn = sesh.add_transaction("search")
search_req = search_txn.add_requests
config.log.info_msg("#{test}: Searching for #{search_term}")
search = Search.new(search_req)
search.search(search_term)

# Switch context to the "Content" search
content_search_txn = sesh.add_transaction("content_search")
content_search_req = content_search_txn.add_requests
config.log.info_msg("#{test}: Switching context to Content search")
content_search = Search.new(content_search_req)
content_search.search(search_term, {
		:load_search_page => false,
		:search_category => 'content'
	})
