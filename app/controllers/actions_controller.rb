class ActionsController < ApplicationController
    
    before_action :require_user, only: [:options, :index] # [ :show]
    #before_action :require_admin, only: 
    
    #RESTful resources
    
    def index
            @actions_owned = Action.where(owner: "#{current_user.first_name} #{current_user.last_name}")
            @actions_created = Action.where(initiator: "#{current_user.first_name} #{current_user.last_name}")
    end
    
    def new
      @actions = Action.new
      @last_action = Action.last
      @users = User.all
      gon.users = User.all
    end
    
    def edit
        @actions = Action.find(params[:id])
        gon.users = User.all
    end
    
    def show
        @actions = Action.find(params[:id])
    end
    
    def create
        @action = Action.new(action_params)
        
        if @action.save!
            redirect_to actions_path
        else
            render 'edit'
        end
    end
    
    def update
        @action = Action.find(params[:id])
        
        if @action.update(action_params)
            redirect_to @action
        else
            redirect_to edit_action_path
        end
    end
    
    def destroy
        @action = Action.find(params[:id])
        @action.destroy
        redirect_to actions_path
    end
    
    #additional routes
    
    def options
    end
    
    def transfer
    end
    
    def import
        #Action.import(params[:file])
        redirect_to root_url, notice: "Products imported."
    end
    
    private
    
    def action_params
        params.require(:actions).permit(:refernce_number, :initiator, :owner, :source, :date_target, :type_ABC, :date_time_created, :description, :progress, :closeout, :closed_flag)
    end
    
end
   