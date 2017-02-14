class UserMailer < ApplicationMailer

	# The mailer is structured like the controller. 
	# The mailer creates messages based on html.erb and text.erb views.

	default from: 'SHEQ_NoReply@tradebe.com' #to: User.new { Admin.pluck(:email) }
	@@host_root = "sheq.inutec.localhost:3000"

	# Action controller emails...

	def new_action_email(user, action)
	    @user = user
	    @url = "#{@@host_root}/actions/#{action.id}"
	    mail(to: user.try(:email), subject: 'You have recieved a new action')
	end

	def accepted_action_email(user, action)
		@user = user
	    @action = action
	    @url = "#{@@host_root}/actions/#{action.id}"
	    mail(to: user.try(:email), subject: "Action #{action.id} - Accepted")
	end

	def change_action_email(user, action, owner)
		@user = user
	    @action = action
	    @url = "#{@@host_root}/actions/#{action.id}"
	    mail(to: owner.try(:email), subject: "Action #{action.id} - Updated")
	end

	def close_request_action_email(user, action)
		@user = user
	    @action = action
	    @url = "#{@@host_root}/actions/#{action.id}"
	    mail(to: user.try(:email), subject: "Action #{action.id} - Close-out Request")
	end

	def close_action_email(user, action, owner)
		@user = user
	    @action = action
	    @url = "#{@@host_root}/actions/#{action.id}"
	    mail(to: owner.try(:email), subject: "Action #{action.id} - Close-out Approved")
	end

	def extend_request_action_email(user, action)
		@user = user
	    @action = action
	    @url = "#{@@host_root}/actions/#{action.id}"
	    mail(to: user.try(:email), subject: "Action #{action.id} - Extension Request")
	end

	def extend_action_email(user, action, owner)
		@user = user
	    @action = action
	    @url = "#{@@host_root}/actions/#{action.id}"
	    mail(to: owner.try(:email), subject: "Action #{action.id} - Extension Approved")
	end

	def reject_closeout_email(user, action, owner)
		@user = user
	    @action = action
	    @owner = owner
	    @url = "#{@@host_root}/actions/#{action.id}"
	    mail(to: owner.try(:email), subject: "Action #{action.id} - Close-out Request Rejected")
	end

	def reject_extension_email(user, action, owner)
		@user = user
	    @action = action
	    @owner = owner
	    @url = "#{@@host_root}/actions/#{action.id}"
	    mail(to: owner.try(:email), subject: "Action #{action.id} - Extension Request Rejected")
	end

	# Event controller emails...
	
	@@yr = Date.parse(Time.now.to_s).year

	def new_event_email(user, event)
		@user = user
	    @url = "#{@@host_root}/events/#{event.id}"
	    mail(to: user.try(:email), subject: "Inutec-UNOR-#{@@yr}-#{event.reference_number} - New event reported.")
	end

	def change_event_email(user, event)
		
		yr = Date.parse(event.date_time_created.to_s).year
		
		@user = user
	    @event = event
	    @url = "#{@@host_root}/events/#{event.id}"
	    mail(to: owner.try(:email), subject: "Inutec-UNOR-#{yr}-#{event.reference_number} - Updated")
	end

	def guest_event_email(event)
		@event = event
	    @url = "#{@@host_root}/events/#{event.id}"
	    mail(to: user.try(:email), subject: "Inutec-UNOR-#{@@yr}-#{event.reference_number} - New event reported.")
	end

	# User controller emails...

	def new_user_email(user)
		@user = user
	    @url = "#{@@host_root}/users/#{user.id}"
	    mail(to: user.try(:email), subject: "New user signed-up.")
	end

	def change_user_email(user)
		@user = user
	    @url = "#{@@host_root}/users/#{user.id}"
	    mail(to: user.try(:email), subject: "User details updated.")
	end
	
	def activated_user_email(user)
		@user = user
	    @url = "#{@@host_root}/users/#{user.id}"
	    mail(to: user.try(:email), subject: "User profile activated.")
	end
	
	def deactivated_user_email(user)
		@user = user
	    @url = "#{@@host_root}/users/#{user.id}"
	    mail(to: user.try(:email), subject: "User profile deactivated.")
	end

end
