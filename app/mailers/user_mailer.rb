class UserMailer < ApplicationMailer

	# The mailer is structured like the controller. 
	# The mailer creates messages based on html.erb and text.erb views.

	default from: 'SHEQ_Portal@tradebe.com' #to: User.new { Admin.pluck(:email) }

	# Action controller emails...

	def new_action_email(user, action)
	    @user = user
	    @url = "/actions/#{action.id}"
	    mail(to: user.try(:email), subject: 'You have recieved a new action')
	end

	def accepted_action_email(user, action)
		@user = user
	    @action = action
	    @url = "/actions/#{action.id}"
	    mail(to: user.try(:email), subject: "Action #{action.id} - Accepted")
	end

	def change_action_email(user, action, owner)
		@user = user
	    @action = action
	    @url = "/actions/#{action.id}"
	    mail(to: owner.try(:email), subject: "Action #{action.id} - Updated")
	end

	def close_request_action_email(user, action)
		@user = user
	    @action = action
	    @url = "/actions/#{action.id}"
	    mail(to: user.try(:email), subject: "Action #{action.id} - Close-out Request")
	end

	def close_action_email(user, action, owner)
		@user = user
	    @action = action
	    @url = "/actions/#{action.id}"
	    mail(to: owner.try(:email), subject: "Action #{action.id} - Close-out Approved")
	end

	def extend_request_action_email(user, action)
		@user = user
	    @action = action
	    @url = "/actions/#{action.id}"
	    mail(to: user.try(:email), subject: "Action #{action.id} - Extension Request")
	end

	def extend_action_email(user, action, owner)
		@user = user
	    @action = action
	    @url = "/actions/#{action.id}"
	    mail(to: owner.try(:email), subject: "Action #{action.id} - Extension Approved")
	end

	def reject_closeout_email(user, action, owner)
		@user = user
	    @action = action
	    @owner = owner
	    @url = "/actions/#{action.id}"
	    mail(to: owner.try(:email), subject: "Action #{action.id} - Close-out Request Rejected")
	end

	def reject_extension_email(user, action, owner)
		@user = user
	    @action = action
	    @owner = owner
	    @url = "/actions/#{action.id}"
	    mail(to: owner.try(:email), subject: "Action #{action.id} - Extension Request Rejected")
	end

	# Event controller emails...

	def new_event_email(user, event)
	end

	def change_event_email(user, event)
	end

	#def remove_event_email(user, event)
	#end

	def guest_event_email(user, event)
	end

	# User controller emails...

	def new_user_email(user)
	end

	def change_user_email(user)
	end

end
