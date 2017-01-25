class SessionsController < ApplicationController
    
    include SessionsHelper
    
    def new
    end
        
    def create
    
       @user = User.find_by_email(params[:session][:email].downcase)

       if @user && @user.authenticate(params[:session][:password])
           log_in(@user)
           remember(@user)
           redirect_to actions_path(session[:user_id])
       else
           redirect_to '/error'
       end
    end
    
    def destroy
        log_out if logged_in?
        redirect_to root_url
    end

end
