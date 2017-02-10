class UserMailer < ApplicationMailer

	# The mailer is structured like the controller. 
	# The mailer creates messages based on html.erb and text.erb views.

	default from: 'SHEQ_Portal@tradebe.com' #to: User.new { Admin.pluck(:email) }

	# Action controller emails...

	def new_action_email(user, action)
	    @user = user
	    @url = "/actions/#{action.id}"
	    mail(to: @user.try(:email), subject: 'You have recieved a new action')
	end

	def change_action_email(user, action)
	end

end
