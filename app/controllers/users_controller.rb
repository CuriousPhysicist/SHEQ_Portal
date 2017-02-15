class UsersController < ApplicationController
    
    include SessionsHelper

    before_action :logged_in_user, only: [:index, :show, :edit]
    before_action :require_user, only: [:index, :show, :edit]
    before_action :require_admin, only: [:destroy]
    
    # Standard RESTful actions
    
    def index
        if current_user.team == "SHEQ" || current_user.try(:admin)
            @users = User.all
        elsif current_user.level == 2
            @users = User.where('active_flag = ?', true).where('team = ?', current_user.team)
        elsif current_user.level == 1
            @users = User.where('id = ?', current_user.id)
        end
        
        gon.user_number = User.all.count

	respond_to do |format|
            format.html
            format.csv { send_data @users.to_csv }
            format.xls { send_data @users.to_csv(col_sep: "\t") }
        end
    end
    
    def create
        
        @user = User.new(user_params)
    
        if @user.save
            flash[:success] = "User successfully created"
            ## send email to SHEQ group to review user information and rights
            ## UserMailer.new_user_email(@user).deliver
            redirect_to actions_path(session[:user_id])
        else
            flash[:warning] = "User failed to save."
            render 'edit'
        end
    end
    
    def new
      @user = User.new
    end
    
    def edit
        @user = User.find(params[:id])
    end
    
    def show
        @user = User.find(params[:id])
    end
    
    def update
        @user = User.find(params[:id])
        
        if @user.update(user_params)
            flash[:success] = "User successfully updated"
            ## send email to user, SHEQ and line manager confirming change to user information
            ## UserMailer.change_user_email(@user).deliver
            redirect_to @user
        else
            flash[:warning] = "User failed to update"
            render 'edit'
        end
    end
    
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:info] = "User deleted"
        redirect_to users_path
    end
    
    # methods for importing data

    def import
        User.import(params[:file])
        redirect_to users_path
    end
    
    # other routes and methods
    
    def activate
        @user = User.find(params[:format])
        @user.update(:active_flag => true)
        flash[:info] = "User Activated"
        ## email user and line management to indicate the profile has been activated
        UserMailer.activated_user_email(@user).deliver
        redirect_to users_path
    end
    
    def comment
        @users = User.find(params[:format])
    end
    
    def comment_submitted
        @user =  User.find(params[:id])

        update_text = @user.comment.to_s + " | #{current_user.first_name} #{current_user.last_name} | " + params[:comment] # can this be implemented using action_params? would this be more secure?
        @user.update(:comment => update_text)
        @user.update(:active_flag => false)
        flash[:info] = "User account deactivated"
        ## email user and line management to indicate the profile has been deactivated
        UserMailer.deactivated_user_email(@user).deliver
 
        redirect_to user_path(@user.id)
        
    end
	    
    # filter methods

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Private actions including strong parameters
    
    private
    
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :team, :role, :level, :approval_type, :active_flag, :comment)
    end
    
end
