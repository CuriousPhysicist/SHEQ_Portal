class SessionsController < ApplicationController
    
    def new
    end
        
    def create
    
       @user = User.find_by_email(params[:session][:email])
       
       if @user && @user.authenticate(params[:session][:password])
           session[:user_id] = @user.id
           redirect_to actions_path
       else
           redirect_to '/login'
       end
    end
    
    def destroy
        log_out if logged_in?
        redirect_to root_url
    end

end
