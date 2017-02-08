class UsersController < ApplicationController
    
    before_action :require_user, only: [:index, :show, :edit]
    before_action :require_admin, only: [:destroy]
    
    # Standard RESTful actions
    
    def index
        @users = User.all
        gon.user_number = User.all.count
    end
    
    def create
        
        @user = User.new(user_params)
    
        if @user.save
            flash[:success] = "User successfully created"
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
    
    def error
    end
    
    # Role specific actions
    
    def admin?
       self.admin == true
    end
    
    private
    
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :team, :role, :approval_type)
    end
    
end
