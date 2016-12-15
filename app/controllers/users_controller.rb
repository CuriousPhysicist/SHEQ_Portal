class UsersController < ApplicationController
    
    before_action :require_user, only: [:index, :show]
    before_action :require_admin, only: [:new, :create, :edit, :destroy]
    
    # Standard RESTful actions
    
    def index
        @users = User.all
    end
    
    def create
        @user = User.new(user_params)
        
        if @user.save
            redirect_to @user
        else
            render 'edit'
        end
    end
    
    def new
      @user = User.new  
    end
    
    def edit
        @user = User.find(paras[:id])
    end
    
    def show
        @user = User.find(paras[:id])
    end
    
    def update
        @user = User.new(params[:id])
        
        if @user.update(user_params)
            redirect_to @user
        else
            render 'edit'
        end
    end
    
    def destroy
        @user = User.find(paras[:id])
        @user.destroy
    end
    
    # Role specific actions
    
    def admin?
       self.role == 'admin'
    end
    
    private
    
    def user_params
        params.require(:password).permit(:first_name, :last_name, :email)
    end
    
end
