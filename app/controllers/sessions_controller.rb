class SessionsController < ApplicationController
    
    include SessionsHelper
    
    # routes actions for separate function dashboards

    def dashboard_actions
      @actions = Action.where('closed_flag = ?', false)
      
      @over = @actions.where('date_target < ?', Time.now).count
      @due = @actions.where('date_target >= ?', Time.now).count
      @year_count = Action.where('date_time_created >= ?', Time.now - 1.year).count
      
      @typeA_num = @actions.where('type_ABC = ?', "A").count
      @typeB_num = @actions.where('type_ABC = ?', "B").count
      @typeC_num = @actions.where('type_ABC = ?', "C").count
      
      @series1 = @actions.where('date_target >= ?', Time.now).group(:owner).count
      @series2 = @actions.where('date_target < ?', Time.now).group(:owner).count
      @series3 = @actions.where('date_target >= ?', Time.now).group(:type_ABC).count
      @series4 = @actions.where('date_target < ?', Time.now).group(:type_ABC).count
      
    end
    
    def dashboard_events
      @events = Event.where('closed_flag = ?', false)
      
      @open = @events.count
      @due = @events.count
      @year_count = Event.where('date_raised >= ?', Time.now - 1.year).count
      
      @nearmiss_num = @events.where('classification = ?', "Near Miss").count
      @occurance_num = @events.where('classification = ?', "Occurance").count
      @total_open = Event.where('closed_flag = ?', false).count
      
      @series1 = @due
      @series2 = @over
      @series3 = @nearmiss_num
      @series4 = @occurance_num
      
    end
    
    # routes actions for login and logout
    
    def new
    end
    
    def landing_page
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

    # route action for uploader options page

    def uploader_options
    end

end
