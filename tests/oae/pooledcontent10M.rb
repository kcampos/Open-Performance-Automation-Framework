#!/usr/bin/env ruby

#
# == Description
#
# Login as existing user and view my memberships
#

require 'drb'
config = DRbObject.new nil, "druby://localhost:#{ENV['DRB_PORT']}"

require config.lib_base_dir + "/tsung-api.rb"
require config.lib_base_dir + "/#{config.product}/common/authentication.rb"
require config.lib_base_dir + "/#{config.product}/library/content.rb"

# Test info - default test case setup
test = File.basename(__FILE__)
probability = config.tests[test]
config.log.info_msg("Test: #{test}")
config.log.info_msg("Probability: #{config.tests[test]}")

# Create session
sesh = Session.new(config, 'pooledcontent', probability)

# Login
# username = '%%_username%%'
password = '%%_user_password%%'

# Register
username = 'load_user_%%ts_user_server:get_unique_id%%' #unique id

reg_txn = sesh.add_transaction("register")
reg_req = reg_txn.add_requests
config.log.info_msg("#{test}: Registering as: #{username}")
auth = Authentication.new(reg_req)
auth.register(username)

login_txn = sesh.add_transaction("login")
login_req = login_txn.add_requests
config.log.info_msg("#{test}: Loggin in as: #{username}")
auth = Authentication.new(login_req)
userinfo = auth.login(username, password)

opts = {
    :filename => "lipsum-10Mchars.txt"
  }

config.log.info_msg("logged in with user id: #{userinfo[:uid]}")
create_pooledcontent_txn = sesh.add_transaction("pooledcontent")
create_pooledcontent_req = create_pooledcontent_txn.add_requests
config.log.info_msg("#{test}: creating pooled content item")
content = Content.new(create_pooledcontent_req)
content.createFileFromMyLibrary(username, opts)
content.addComment()
content.deleteComment()
content.tag()
content.deleteTag()

config.log.info_msg("#{test}: subst string for content id - #{opts[:content_id_subst]}")

# Logout
logout_txn = sesh.add_transaction("logout")
logout_req = logout_txn.add_requests
config.log.info_msg("#{test}: Logging out")
auth = Authentication.new(logout_req)
auth.logout