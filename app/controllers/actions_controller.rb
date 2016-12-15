class ActionsController < ApplicationController
    
    before_action :require_user, only: [:index, :show]
    before_action :require_admin, only: [:destroy]
    
    def index
        @actions = Action.all
    end
    
    def create
        @action = Action.new(action_params)
        
        if @action.save
            redirect_to @action
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
