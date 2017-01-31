class SessionsController < ApplicationController
    
    include SessionsHelper

    def dashboard
      @actions = Action.where('open_flag = ?', true)
      
      @over = @actions.where('date_target < ?', Time.now).count
      @due = @actions.where('date_target >= ?', Time.now).count
      @year_count = Action.all.count
      
      @series1 = @actions.where('date_target >= ?', Time.now).group(:owner).count
      @series2 = @actions.where('date_target < ?', Time.now).group(:owner).count
    end
    
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
