#!/usr/bin/env ruby

# 
# == Synopsis
#
# Contacts class containing all operations around my contacts
#
# Author:: Lance Speelmon (mailto:lance@rsmart.com)
#

class Contacts

  attr_accessor :request

  def initialize(request_obj)
    @request = request_obj
  end

  # Load my contacts
  def my_contacts(username)
    @request.add('/var/contacts/findstate.json?state=INVITED&page=0&items=18&_charset_=utf-8&_=1342647335681')
    @request.add("/var/contacts/findstate.infinity.json?q=*&sortOn=lastName&sortOrder=asc&state=ACCEPTED&userid=#{username}&page=0&items=18&_charset_=utf-8&_=1342647335687",
        {}, { 'subst' => 'true' })
  end

	# Invite contact to be a connection
	def invite(inviter_username, invitee_username)
	
	  @request.add("/~#{inviter_username}/contacts.invite.html",
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "fromRelationships=__MSG__CLASSMATE__&toRelationships=__MSG__CLASSMATE__&targetUserId=#{invitee_username}&_charset_=utf-8"
      }, { 'subst' => 'true' })
    
		@request.add("/~#{invitee_username}/public/authprofile.profile.json?_charset_=utf-8", {},
				{ 'subst' => 'true' })
		
		@request.add("/~#{inviter_username}/message.create.html",
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "sakai%3Atype=internal&sakai%3Asendstate=pending&sakai%3Amessagebox=outbox&sakai%3Ato=internal%3A#{invitee_username}&sakai%3Afrom=#{inviter_username}&sakai%3Asubject=Devin+Sonnek+has+invited+you+to+become+a+connection&sakai%3Abody=Devin+Sonnek+has+invited+you+to+become+a+contact%3A+%0A%0AI+would+like+to+invite+you+to+become+a+member+of+my+network+on+Sakai.%0D%0A%0D%0A-+Devin&_charset_=utf-8&sakai%3Acategory=invitation"
      }, { 'subst' => 'true' })
	
		@request.add("/~#{inviter_username}/message.create.html",
      {
        'method' => 'POST',
        'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "sakai%3Atype=smtp&sakai%3Asendstate=pending&sakai%3Amessagebox=pending&sakai%3Ato=internal%3A#{invitee_username}&sakai%3Afrom=#{inviter_username}&sakai%3Asubject=Devin+Sonnek+has+invited+you+to+become+a+connection&sakai%3Abody=Devin+Sonnek+has+invited+you+to+become+a+contact%3A+%0A%0AI+would+like+to+invite+you+to+become+a+member+of+my+network+on+Sakai.%0D%0A%0D%0A-+Devin&sakai%3Acategory=message&_charset_=utf-8&sakai%3AtemplatePath=%2Fvar%2Ftemplates%2Femail%2Fcontact_invitation&sakai%3AtemplateParams=sender%3DDevin+Sonnek%7Csystem%3DSakai%7Cbody%3DDevin+Sonnek+has+invited+you+to+become+a+contact%3A+%0A%0AI+would+like+to+invite+you+to+become+a+member+of+my+network+on+Sakai.%0D%0A%0D%0A-+Devin%7Clink%3Dhttp%3A%2F%2Flocalhost%3A8080%2Fme%23l%3Dmessages%2Finvitations"
      }, { 'subst' => 'true' })
    
	end
	
	# Accept a pending invitation
	def accept(inviter_username, invitee_username)
	
		# keep in mind that it is the "invitee" accepting the connection request that was sent by the "inviter"
		@request.add("/~#{invitee_username}/contacts.accept.html",
			{
				'method' => 'POST',
				'content_type' => 'application/x-www-form-urlencoded; charset=UTF-8',
        'contents' => "targetUserId=#{inviter_username}&_charset_=utf-8"
      }, { 'subst' => 'true' })
      
			@request.add("/var/contacts/find.json?q=*&sortOn=lastName&sortOrder=asc&state=ACCEPTED&userid=#{invitee_username}&page=0&items=18&_charset_=utf-8&_=1342710471950",
					{}, { 'subst' => 'true' })
	end
	
end
