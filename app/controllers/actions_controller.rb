class ActionsController < ApplicationController
    
    #before_action :require_user, only: [:index, :show]
    #before_action :require_admin, only: [:destroy]
    
    def options
    end
    
    def index
        @actions = Action.all
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
    
    def create
        @action = Action.new(action_params)
        
        if @action.save!
            redirect_to user_actions_path
        else
            render 'edit'
        end
    end
    
    def update
        @action = Action.new(params[:id])
        
        if @action.update(action_params)
            redirect_to @action
        else
            redirect_to edit_action_path
        end
    end
    
    def destroy
        @action = Action.find(params[:id])
        @action.destroy
    end
    
    private
    
    def action_params
        params.require(:actions).permit(:refernce_number, :initiator, :owner, :source, :date_target, :type_ABC, :description, :progress, :closeout)
    end
    
end
   