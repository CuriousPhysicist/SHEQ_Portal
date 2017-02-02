class ActionsController < ApplicationController
    
    before_action :require_user, only: [:options, :index]
    before_action :require_admin, only: [:destroy, :transfer, :all]
    
    #RESTful resources
    
    def index
        @actions_owned = Action.where(owner: "#{current_user.first_name} #{current_user.last_name}")
        @actions_created = Action.where(initiator: "#{current_user.first_name} #{current_user.last_name}")
        @actions = Action.all

        respond_to do |format|
            format.html
            format.csv { send_data @actions.to_csv }
            format.xls { send_data @actions.to_csv(col_sep: "\t") }
        end
    end
    
    def new
      @actions = Action.new
      @last_action = Action.last
      @users = User.all
      gon.users = User.all
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
    
    def all
        @actions = Action.all
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

    def extendplease
       @action =  Action.find(params[:format])
    
       if @action.extend_request_flag == false
           @action.update(:extend_request_flag => true)
           redirect_to action_path(@action.id)
       end
    end
    
    def extend
       @action =  Action.find(params[:format])

       extensions = @action.extensions_number
    
       if @action.extend_request_flag == true
            
            extensions += 1
            @action.update(:extensions_number => extensions)
            @action.update(:extend_request_flag => false)
           
            redirect_to action_path(@action.id)
       end
    end
    
    def reject
       @actions = Action.find(params[:format])
       
    end

    def return
        @action =  Action.find(params[:id])
        

        if @action.closeout != nil
            closeout_update = @action.closeout + " | " + params[:updatetext]
        else
            closeout_update = params[:updatetext]
        end

        if @action.progress != nil
            progress_update = @action.progress + " | " + params[:updatetext]
        else
            progress_update = params[:updatetext]
        end

        if @action.close_request_flag == true
           @action.update(:closeout => closeout_update)
           redirect_to action_path(@action.id)
        end

        if @action.extend_request_flag == true
           @action.update(:progress => progress_update)
           redirect_to action_path(@action.id)
        end
    end
    
    def tasks
        @actions_for_closeout = Action.where('close_request_flag = ?', true)
        @actions_for_extention = Action.where('extend_request_flag = ?', true)
    end
    
    private
    
    def action_params
        params.require(:actions).permit(:refernce_number, :initiator, :owner, :source, :date_target, :type_ABC, :date_time_created, :description, :progress, :closeout, :closed_flag)
    end
    
end
   