class SessionsController < ApplicationController
    
    include SessionsHelper

    def dashboard
      @actions = Action.where('closed_flag = ?', false)
      
      @over = @actions.where('date_target < ?', Time.now).count
      @due = @actions.where('date_target >= ?', Time.now).count
      @year_count = Action.all.count
      
      @typeA_num = @actions.where('type_ABC = ?', "A").count
      @typeB_num = @actions.where('type_ABC = ?', "B").count
      @typeC_num = @actions.where('type_ABC = ?', "C").count
      
      @series1 = @actions.where('date_target >= ?', Time.now).group(:owner).count
      @series2 = @actions.where('date_target < ?', Time.now).group(:owner).count
      @series3 = @actions.where('date_target >= ?', Time.now).group(:type_ABC).count
      @series4 = @actions.where('date_target < ?', Time.now).group(:type_ABC).count
      
    end
    
    def new
    end
        
    def create
    
       @user = User.find_by_email(params[:session][:email].downcase)

       if @user && @user.authenticate(params[:session][:password])
           log_in(@user)
           remember(@user)
           redirect_to actions_path
       else
          flash[:warning] = "Incorrect email or password."
           redirect_to login_path
       end
    end
    
    def destroy
        log_out if logged_in?
        redirect_to root_url
    end

end
