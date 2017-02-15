class UserMailer < ApplicationMailer

	# The mailer is structured like the controller. 
	# The mailer creates messages based on html.erb and text.erb views.

	default from: 'SHEQ_NoReply@tradebe.com' #to: User.new { Admin.pluck(:email) }
	@@host_root = "http://sheq.inutec.local:3000"

	# methods for collecting user groups and other cc: options

	def email_group(team)
	    receiver_group = User.where('team = ?', team)
	    @@recipients_arr = []
	    i = 0
	    receiver_group.each do |recipient|
			@@recipients_arr[i] = recipient.try(:email)
			i += 1
	    end
	end
	
	def email_line_manager(user)
		#if user.level == 1
	    	user_team = User.where('team = ?', user.team)
	    	line_manager = user_team.where('level = ?', 2)
	    	@@line_management = line_manager.try(:email)
	    # elsif user.level == 2
	    # 	if user.team == ["Operations", "Maintenance", "Analytical"]
	    # 		line_manager = User.where('level = ?', 3).where('team = ?', "Operations")
	    # 		@@line_management = line_manager.try(:email)
	    # 	elsif user.team == ["Engineering", "Projects"]
	    # 		line_manager = User.where('level = ?', 3).where('team = ?', "Projects")
	    # 		@@line_management = line_manager.try(:email)
	    # 	else
	    # 		line_manager = User.where('level = ?', 3).where('team = ?', "SHEQ")
	    # 		@@line_management = line_manager.try(:email)
	    # 	end
	    # else
	    # 	line_manager = User.where('level = ?', 4)
	    # 	@@line_management = line_manager.try(:email)
	    # end
	    debugger
	end

	# Action controller emails...

	def new_action_email(user, action)
	    @user = user
	    @url = "#{@@host_root}/actions/#{action.id}"
	    #email_line_manager(user)
	    email_group("SHEQ")
	    mail(to: user.try(:email), cc: @@recipients_arr,  subject: 'You have recieved a new action')
	end

	def accepted_action_email(user, action)
		@user = user
	    @action = action
	    @url = "#{@@host_root}/actions/#{action.id}"
	    #email_line_manager(user)
	    email_group("SHEQ")
	    mail(to: user.try(:email), cc: @@recipients_arr, subject: "Action #{action.id} - Accepted")
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
	    email_group("SHEQ")
	    #email_line_manager(user) # needs debugging
	    mail(to: user.try(:email), cc: @@recipients_arr, subject: "Action #{action.id} - Close-out Request")
	end

	def close_action_email(user, action, owner)
		@user = user
	    @action = action
	    @url = "#{@@host_root}/actions/#{action.id}"
	    mail(to: owner.try(:email), cc: email_group("SHEQ"), subject: "Action #{action.id} - Close-out Approved")
	end

	def extend_request_action_email(user, action)
		@user = user
	    @action = action
	    @url = "#{@@host_root}/actions/#{action.id}"
	    mail(to: user.try(:email), cc: email_group("SHEQ"), subject: "Action #{action.id} - Extension Request")
	end

	def extend_action_email(user, action, owner)
		@user = user
	    @action = action
	    @url = "#{@@host_root}/actions/#{action.id}"
	    mail(to: owner.try(:email), cc: email_group("SHEQ"), subject: "Action #{action.id} - Extension Approved")
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
	
	def acknowledged_event_email(user, event)
		
		yr = Date.parse(event.date_time_created.to_s).year
		@user = user
		@yr = yr
		@event = event
	    @url = "#{@@host_root}/events/#{event.id}"
	    mail(to: user.try(:email), subject: "Inutec-UNOR-#{yr}-#{event.reference_number} - Event report acknowledged.")
	end

	def change_event_email(user, event, raised_by)
		
		yr = Date.parse(event.date_time_created.to_s).year
		
		@user = user
	    @event = event
	    @yr = yr
	    @url = "#{@@host_root}/events/#{event.id}"
	    mail(to: raised_by.try(:email), subject: "Inutec-UNOR-#{yr}-#{event.reference_number} - Updated")
	end

	def guest_event_email(user, event)
		
		@event = event
	    @url = "#{@@host_root}/events/#{event.id}"
	    mail(to: user.try(:email), subject: "Inutec-UNOR-#{@@yr}-#{event.reference_number} - New event reported.")
	end
	
	def close_request_event_email(user, event)
		
		yr = Date.parse(event.date_time_created.to_s).year
		
		@user = user
	    @event = event
	    @yr = yr
	    @url = "#{@@host_root}/events/#{event.id}"
	    email_group("SHEQ")
	    #email_line_manager(user) # needs debugging
	    mail(to: user.try(:email), cc: @@recipients_arr, subject: "Inutec-UNOR-#{yr}-#{event.reference_number} - Close-out Request")
	end
	
	def close_event_email(user, event, raised_by)
		
		yr = Date.parse(event.date_time_created.to_s).year
		
		@user = user
	    @event = event
	    @yr = yr
	    @url = "#{@@host_root}/events/#{event.id}"
	    mail(to: raised_by.try(:email), cc: email_group("SHEQ"), subject: "Inutec-UNOR-#{yr}-#{event.reference_number} - Close-out Approved")
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
