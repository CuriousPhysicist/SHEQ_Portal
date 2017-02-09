# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

	def new_action_email
    	user = User.first
    	action = Action.first
    	UserMailer.new_action_email(user, action)
  	end

end
