class ActionsController < ApplicationController
    
    before_action :require_user, only: [:options, :index]
    before_action :require_admin, only: [:destroy, :transfer, :all]
    
    #RESTful resources
    
    def index
        @actions_owned = Action.where(owner: "#{current_user.first_name} #{current_user.last_name}").order('date_target')
        @actions_created = Action.where(initiator: "#{current_user.first_name} #{current_user.last_name}")
    end
    
    def new
      @actions = Action.new
      @last_action = Action.last
      @users = User.all
      gon.users = User.all
      gon.events = Event.all
    end
    
    def edit
        @actions = Action.find(params[:id])
        @user = current_user
        gon.users = User.all
    end
    
    def show
        @actions = Action.find(params[:id])
    end
    
    def create
        @action = Action.new(action_params)
        
        if @action.save!
            redirect_to actions_path(current_user[:id])
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
    
    def all
        @actions = Action.all
        
        respond_to do |format|
            format.html
            format.csv { send_data @actions.to_csv }
            format.xls { send_data @actions.to_csv(col_sep: "\t") }
        end
    end
    
    def owned
        @actions_owned = Action.where(owner: "#{current_user.first_name} #{current_user.last_name}")

        respond_to do |format|
            format.html
            format.csv { send_data @actions_owned.to_csv }
            format.xls { send_data @actions_owned.to_csv(col_sep: "\t") }
        end
    end
    
    def created
        @actions_created = Action.where(initiator: "#{current_user.first_name} #{current_user.last_name}")

        respond_to do |format|
            format.html
            format.csv { send_data @actions_created.to_csv }
            format.xls { send_data @actions_created.to_csv(col_sep: "\t") }
        end
    end
    
    def import
        Action.import(params[:file])
        redirect_to root_url, notice: "Products imported."
    end
    
    def closeplease
       @action =  Action.find(params[:format])
    
       if @action.close_request_flag == false
           @action.update(:close_request_flag => true)
           redirect_to action_path(@action.id)
       end
    end
    
    def close
       @action =  Action.find(params[:format])
    
       if @action.close_request_flag == true
           @action.update(:close_request_flag => false)
           @action.update(:closed_flag => true)
           redirect_to action_path(@action.id)
       end
    end
    
    def reject
       @action = Action.find(params[:format])
       
    end
    
    def tasks
        @actions_for_closeout = Action.where('close_request_flag = ?', true)
        @actions_for_extension = Action.where('extend_request_flag = ?', true)
    end

    # Private actions below (including strong parameters white-list)
    
    private
    
    def action_params
        
        params.require(:actions).permit(:reference_number, :initiator, :owner, :source, :date_target, :type_ABC, :date_time_created, :description, :progress, :closeout, :closed_flag)
    end
    
end
   