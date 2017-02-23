class ActionsController < ApplicationController
    
    before_action :require_user, only: [:options, :index]
    before_action :require_admin, only: [:destroy, :transfer, :all]
    
    #RESTful resources
    
    def index
        
        if params[:search]
            ## If a search has been carried out this collates the results 
            @actions_result = Action.search(params[:search]).order("created_at DESC")
        else
            
            ## limits SQL query to open Actions (search function required to inspect closed actions)
            @actions_open = Action.where(closed_flag: false)
            
            ## takes a cut of open actions belonging to current user (current_user is a method in app/controllers/application_controller.rb )
            @actions_owned = @actions_open.where(owner: "#{current_user.first_name} #{current_user.last_name}").order('date_target')
            @actions_created = @actions_open.where(initiator: "#{current_user.first_name} #{current_user.last_name}")
            
            ## code below fileters open actions for users belonging to same team as current user
    
            ## initialise variables
            action_ids = []
            k = 0
            
            ## set variables according to result of SQL queries
            team_count = User.where('team = ?', current_user.team).count
            team_hash = User.where('team = ?', current_user.team)  ## NB: actually an ActiveRecord relation, but treating it like a Hash
            
            ## loop through each member of the team building list of actions raised by each member in action_ids array
            
            (0..team_count-1).each do |i|
                ## filter open Actions for those owned by team member
                ## create hash of actions using id as key and event record as value in key => value pair
                ## convert hash into array
                team_member_actions_arr = @actions_open.where('user_id = ?', team_hash[i].id).index_by(&:id).to_a
                
                ## loop through new array selecting action id and appending to action_ids array
                ## team_member_actions_arr is an array of arrays i.e. ... [[a,b],[c,d],[e,f] ...]
                
                (0..team_member_actions_arr.length-1).each do |j|
                    action_ids[k] = team_member_actions_arr[j][0]
                    k += 1
                end
                
            end
            
            ## filter open Actions for those owned by team members
            
            @team_actions = @actions_open.where('id IN(?)', action_ids)        
        end
    end
    
    def new
    
    @actions = Action.new
    @last_action = Action.last ## if existing events present take last one
    @users = User.all
    
    gon.users = User.all
    gon.events = Event.all
    end
    
    def edit
        @actions = Action.find( params[:id])
        @user = current_user
        if current_user.team == "SHEQ"
            gon.users = User.all
        elsif current_user.level == 2
            gon.users = User.where('team = ?', current_user.team)
        elsif current_user.level >= 3
            gon.users = User.all
        else
        end
    end
    
    def show
        @actions = Action.find(params[:id])
    end
    
    def create
        @action = Action.new(action_params)
        ownername = @action.owner.split(" ")
        @owner = User.where('last_name = ?', ownername[1]).where('first_name = ?', ownername[0]).first

        if @action.save!
            flash[:success] = "Action successfully created"
            ## email action owner warning of action placing, indicate if action is associated with an Event report
            ## cc line management superior, cc SHEQ team for information.
            UserMailer.new_action_email(@owner, @action).deliver
            redirect_to actions_path(current_user[:id])
        else
            flash[:danger] = "Action failed to save"
            render 'edit'
        end
    end
    
    def update
        @action = Action.find(params[:id])
        ownername = @action.owner.split(" ")
        @owner = User.where('last_name = ?', ownername[1]).first
        
        if @action.update(action_params)
            flash[:success] = "Action successfully updated"
            ## email the action owner, cc line management and SHEQ for information.
            UserMailer.change_action_email(current_user, @action, @owner).deliver
            redirect_to @action
        else
            flash[:danger] = "Action failed to update"
            redirect_to edit_action_path
        end
    end
    
    def destroy
        @action = Action.find(params[:id])
        @action.destroy
        flash[:info] = "Action successfully deleted"
        redirect_to actions_path
    end
    
    #additional routes
    
    def options
        gon.lastaction = Action.last
    end
    
    def find
       action = Action.where('reference_number = ?', params[:reference_number]).first
       redirect_to edit_action_path(action.id)
    end
    
    def all
        @actions = Action.all
        
        respond_to do |format|
            format.html
            format.csv { send_data @actions.to_csv, :filename => "All_Open_Actions.csv" }
            format.xls { send_data @actions.to_csv(col_sep: "\t", :filename => "All_Open_Actions.xls") }
        end
    end
    
    def owned
        @actions_owned = Action.where(owner: "#{current_user.first_name} #{current_user.last_name}")

        respond_to do |format|
            format.html
            format.csv { send_data @actions_owned.to_csv, :filename => "Actions_Owned_By_#{current_user.first_name}_#{current_user.last_name}.csv" }
            format.xls { send_data @actions_owned.to_csv(col_sep: "\t", :filename => "Actions_Owned_By_#{current_user.first_name}_#{current_user.last_name}.xls") }
        end
    end
    
    def team
        
        @actions_open = Action.where(closed_flag: false)
        
        ## initialise variables
            action_ids = []
            k = 0
            
            ## set variables according to result of SQL queries
            team_count = User.where('team = ?', current_user.team).count
            team_hash = User.where('team = ?', current_user.team)  ## NB: actually an ActiveRecord relation, but treating it like a Hash
            
            ## loop through each member of the team building list of actions raised by each member in action_ids array
            
            (0..team_count-1).each do |i|
                ## filter open Actions for those owned by team member
                ## create hash of actions using id as key and event record as value in key => value pair
                ## convert hash into array
                team_member_actions_arr = @actions_open.where('user_id = ?', team_hash[i].id).index_by(&:id).to_a
                
                ## loop through new array selecting action id and appending to action_ids array
                ## team_member_actions_arr is an array of arrays i.e. ... [[a,b],[c,d],[e,f] ...]
                
                (0..team_member_actions_arr.length-1).each do |j|
                    action_ids[k] = team_member_actions_arr[j][0]
                    k += 1
                end
                
            end
            
            ## filter open Actions for those owned by team members
            
            @team_actions = @actions_open.where('id IN(?)', action_ids)

        respond_to do |format|
            format.html
            format.csv { send_data @team_actions.to_csv, :filename => "Actions_Owned_By_#{current_user.team}.csv" }
            format.xls { send_data @team_actions.to_csv(col_sep: "\t"), :filename => "Actions_Owned_By_#{current_user.team}.xls" }
        end
    end
    
    def search
    	@actions_result = Action.search(params[:search]).order("created_at DESC")
    	respond_to do |format|
                format.html
                format.csv { send_data @actions_result.to_csv, :filename => "Actions_Matching_Search_#{params[:search]}.csv" }
                format.xls { send_data @actions_result.to_csv(col_sep: "\t"), :filename => "Actions_Matching_Search_#{params[:search]}.xls"  }
        end
    end
    
    def import
        Action.import(params[:file])
        redirect_to actions_path
    end

    # actions associated with workflow...

    def accepted
      @action = Action.find(params[:format])
      @action.update(:accepted_flag => true)
      flash[:info] = "Action Accepted"
      ## email SHEQ and line management to indicate action has been updated
      UserMailer.accepted_action_email(current_user, @action).deliver
      redirect_to actions_path
    end
    
    def closeplease
       @action =  Action.find(params[:format])
    
       if @action.close_request_flag == false
          @action.update(:close_request_flag => true)
          flash[:info] = "Action closeout requested"
          ## email SHEQ and group with suitable approval rights to inform them that a close request has been made.
          UserMailer.close_request_action_email(current_user, @action).deliver
          redirect_to action_path(@action.id)
       end
    end
    
    def close
      @action =  Action.find(params[:format])
      ownername = @action.owner.split(" ")
      @owner = User.where('last_name = ?', ownername[1]).first
      #debugger
       if @action.close_request_flag == true
           #debugger
          @action.update(:close_request_flag => false)
          #debugger
          @action.update(:closed_flag => true)
          #debugger
          flash[:success] = "Action closed"
            #debugger
          ## email action owner to confirm closure of the action, cc SHEQ for records
          UserMailer.close_action_email(current_user, @action, @owner).deliver
          redirect_to action_path(@action.id)
       end
    end
    
    def extendplease
       @action =  Action.find(params[:format])
    
       if @action.extend_request_flag == false
          @action.update(:extend_request_flag => true)
          flash[:info] = "Action extension requested"
          ## email SHEQ and group with suitable approval rights to inform them that an extension request has been made.
          ## cc the next level of approval up for information, inform in email the number of extensions the action has recieved
          UserMailer.extend_request_action_email(current_user, @action).deliver
          redirect_to action_path(@action.id)
       end
    end
    
    def extend
      @action =  Action.find(params[:format])
      ownername = @action.owner.split(" ")
      @owner = User.where('last_name = ?', ownername[1]).first
    
       if @action.extend_request_flag == true
          @action.update(:extend_request_flag => false)
          @action.increment!(:extensions_number, 1)
          flash[:success] = "Action extended"
          ## email action owner to confirm target date extension, 
          ## cc line management, Senior Managers and Site manager as appropriate for action Type
          UserMailer.extend_action_email(current_user, @action, @owner).deliver
          redirect_to action_path(@action.id)
       end
    end
    
    def reject
       @actions = Action.find(params[:format])
    end
    
    def reject_submitted 
        @action =  Action.find(params[:id])
        ownername = @action.owner.split(" ")
        @owner = User.where('last_name = ?', ownername[1]).first

        
        if @action.close_request_flag
          update_text = @action.closeout.to_s + " | #{current_user.first_name} #{current_user.last_name} | " + params[:updatetext] # can this be implemented using action_params? would this be more secure?
          @action.update(:closeout => update_text)
          @action.update(:updatetext => params[:updatetext])
          @action.update(:close_request_flag => false)
          flash[:info] = "Close-out request rejected"
          ## email owner with reason for close out rejection, cc line management
          UserMailer.reject_closeout_email(current_user, @action, @owner).deliver
        elsif @action.extend_request_flag
          update_text = @action.progress.to_s  + " | #{current_user.first_name} #{current_user.last_name} | " + params[:updatetext]
          @action.update(:progress => update_text)
          @action.update(:updatetext => params[:updatetext])
          @action.update(:extend_request_flag => false)
          flash[:info] = "Extension request rejected"
          ## email owner with reason for extension rejection, cc line management
          UserMailer.reject_extension_email(current_user, @action, @owner).deliver
        end
 
        redirect_to action_path(@action.id)
        
    end
    
    def tasks
        @actions_for_closeout = Action.where('close_request_flag = ?', true)
        @actions_for_extension = Action.where('extend_request_flag = ?', true)
        @actions_for_acceptance = Action.where('owner = ?', "#{current_user.first_name} #{current_user.last_name}").where('accepted_flag = ?', false)
    end

    # Private actions below (including strong parameters white-list)
    
    private
    
    def action_params
        
        params.require(:actions).permit(:reference_number, :initiator, :owner, :source, :date_target, 
                          :type_ABC, :date_time_created, :description, :progress, :closeout, :updatetext, :closed_flag, :event_id)
    end
    
end
   
