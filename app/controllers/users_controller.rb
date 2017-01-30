class UsersController < ApplicationController
    
    #before_action :require_user, only: [:index, :show]
    #before_action :require_admin, only: [:new, :create, :edit, :destroy]
    
    # Standard RESTful actions
    
    def index
        @users = User.all
    end
    
    def create
        
        @user = User.new(user_params)
    
        if @user.save
            
            redirect_to actions_path(session[:user_id])
        else
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
            redirect_to @user
        else
            render 'edit'
        end
    end
    
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to users_path
    end
    
    def error
    end
    
    # Role specific actions
    
    def admin?
       self.role == 'admin'
    end
    
    private
    
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :team, :role, :approval_type)
    end
    
end
