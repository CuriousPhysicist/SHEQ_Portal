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
      @year_count = Event.where('date_raised >= ?', Time.now - 1.year).count
      
      @safety_num = @events.where('safety_flag = ?', true).count
      @environment_num = @events.where('environmental_flag = ?', true).count
      @quality_num = @events.where('quality_flag = ?', true).count
      @security_num = @events.where('security_flag = ?', true).count

      @injury_num = @events.where('injury_flag = ?', true).count

      @series1 = @events.where('date_raised >= ?', Time.now - 1.month ).count
      @series2 = @events.where('date_raised >= ?', Time.now - 3.month ).count - @events.where('date_raised >= ?', Time.now - 1.month ).count
      @series3 = @events.where('date_raised >= ?', Time.now - 6.month ).count - @events.where('date_raised >= ?', Time.now - 3.month ).count
      @series4 = @events.where('date_raised >= ?', Time.now - 12.month ).count - @events.where('date_raised >= ?', Time.now - 6.month ).count
      @series5 = @events.where('date_raised < ?', Time.now - 12.month ).count

      
    end
    
    # routes actions for login and logout
    
    def landing_page
      if current_user
        redirect_to actions_path(current_user[:id])
      end
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

    # route action for uploader options page

    def uploader_options
    end

end
