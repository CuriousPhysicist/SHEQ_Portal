class ActionsController < ApplicationController
    
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
      @actions = Action.new  
    end
    
    def edit
        @action = Action.find(params[:id])
    end
    
    def show
        @action = Action.find(params[:id])
    end
    
    def update
        @action = Action.new(params[:id])
        
        if @action.update(action_params)
            redirect_to @action
        else
            render 'edit'
        end
    end
    
    def destroy
        @action = Action.find(params[:id])
        @action.destroy
    end
    
    private
    
    def action_params
        params.require(:reference_number).permit(:description, :progress, :closeout)
    end
    
end
