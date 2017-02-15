class EventsController < ApplicationController
	
	before_action :require_user, only: [:index, :show, :edit, :update] # Sets before filters limiting actions for users

    #RESTful resources
    
    def index
        @events = Event.where('closed_flag = ?', false)
        @own_events = @events.where('user_id = ?', current_user.id)
        
        event_ids = []
        k = 0
        team_count = User.where('team = ?', current_user.team).count
        team_hash = User.where('team = ?', current_user.team)
        (0..team_count-1).each do |i|
            team_member_events_arr = @events.where('user_id = ?', team_hash[i].id).index_by(&:id).to_a
            (0..team_member_events_arr.length-1).each do |j|
                event_ids[k] = team_member_events_arr[j][0]
                k += 1
            end
            
        end
        
        @team_events = @events.where('id IN(?)', event_ids)        
        
    end

    def new
    	@events = Event.new
    	@last_event = Event.last
    	@user = current_user
    end
    
    def edit
        @events = Event.find(params[:id])
        
        event_actions = Action.where('event_id = ?', @events.id)
        
        @all_events_closed_flag = true
        
        event_actions.each do |event|
            if event.closed_flag == true
                @all_events_closed_flag = true
            else
                @all_events_closed_flag = false
            end
        end
        
    end
    
    def show
        @events = Event.find(params[:id])
    end
    
    def create
        @event = Event.new(event_params)
        
        if @event.save!
            flash[:success] = "Report successfully submitted"
            ## send email to line management and SHEQ cc: user raising the report
            ## cc: Senior managers for Type B and Site Manager for Type A
            UserMailer.new_event_email(current_user, @event).deliver
            redirect_to events_path
        else
            flash[:danger] = "Report failed to submit"
            render 'edit'
        end
    end
    
    def update
        @event = Event.find(params[:id])
        
        raised_by = User.where('id = ?', @events.user_id)
        
        if @event.update(event_params)
            flash[:success] = "Report successfully updated"
            ## email SHEQ and cc event raiser on changes
            change_event_email(current_user, @events, raised_by).deliver
            redirect_to @event
        else
            flash[:danger] = "Report failed to update"
            redirect_to edit_event_path
        end
    end
    
    def destroy
        @event = Event.find(params[:id])
        @event.destroy
        flash[:info] = "Report deleted"
        ## email report raiser
        ## remove_event_email(user, event)
        redirect_to events_path
    end

    # Guest event reporting actions

    def create_guest
        @event = Event.new(event_params)
        
        proxy_user = User.where('id = ?', @event.user_id)
        
        if @event.save!
            flash[:success] = "Report successfully submitted"
            ## email SHEQ to review report and assign owner if possible, apply cc routes based on event Type
            UserMailer.guest_event_email(proxy_user, @event).deliver
            redirect_to root_path
        else
            flash[:warning] = "Report failed to submit"
            render 'guest'
        end
    end

    def guest
       @events = Event.new
       @last_event = Event.last
       @user = User.first # Change this to admin user group in production, this sets the proxy user for guest event reporting
    end
    
    # actions for exporting information
    
    def raised
        @events_raised = Event.where('user_id = ?', current_user.id)

        respond_to do |format|
            format.html
            format.csv { send_data @events_raised.to_csv }
            format.xls { send_data @events_raised.to_csv(col_sep: "\t") }
        end
    end
    
    def all
        @events_open = Event.where('closed_flag = ?', false)

        respond_to do |format|
            format.html
            format.csv { send_data @events_open.to_csv }
            format.xls { send_data @events_open.to_csv(col_sep: "\t") }
        end
    end

    def team
        @events = Event.where('closed_flag = ?', false)
        
        event_ids = []
        k = 0
        team_count = User.where('team = ?', current_user.team).count
        team_hash = User.where('team = ?', current_user.team)
        (0..team_count-1).each do |i|
            team_member_events_arr = @events.where('user_id = ?', team_hash[i].id).index_by(&:id).to_a
            (0..team_member_events_arr.length-1).each do |j|
                event_ids[k] = team_member_events_arr[j][0]
                k += 1
            end
            
        end
        
        @team_events = @events.where('id IN(?)', event_ids)

        respond_to do |format|
            format.html
            format.csv { send_data @team_events.to_csv }
            format.xls { send_data @team_events.to_csv(col_sep: "\t") }
        end
    end

    # actions for data importing

    def import
        Event.import(params[:file])
        redirect_to events_path
    end
    
    # other routes
    
    def options
        gon.lastevent = Event.last
    end
    
    def tasks
        @events_for_acknlodgement = Event.where('acknowledged_flag = ?', false)
        @events_for_closeout = Event.where('closed_flag = ?', false)
    end
    
    def acknowledged
      
      @event = Event.find(params[:format])
      raised_by = User.where('id = ?', @event.user_id)
      
      @event.update(:acknowledged_flag => true)
      flash[:info] = "UNOR Acknowledged"
      ## email event owner and line management to indicate event has been acknowledged
      UserMailer.acknowledged_event_email(raised_by, @event).deliver
      redirect_to events_path
    end
    
    def closeplease
       @event =  Event.find(params[:format])

       if @event.close_request_flag == false
          @event.update(:close_request_flag => true)
          flash[:info] = "UNOR closeout requested"
          ## email SHEQ and group with suitable approval rights to inform them that a close request has been made.
          UserMailer.close_request_event_email(current_user, @event).deliver
          redirect_to event_path(@event.id)
       end
    end
    
    def close
      @event =  Event.find(params[:format])
      raised_by = User.where('id = ?', @event.user_id)
    
       if @event.close_request_flag == true
          @event.update(:close_request_flag => false)
          @event.update(:closed_flag => true)
          flash[:success] = "UNOR closed"
          ## email event owner to confirm closure of the event, cc SHEQ for records
          UserMailer.close_event_email(current_user, @event, raised_by).deliver
          redirect_to event_path(@event.id)
       end
    end

    # Private actions below (including strong parameters white-list)
    
    private
    
    def event_params
        params.require(:events).permit(:reference_number, :date_raised, :date_closed, :location, :building, :area, 
        									:what_happened, :immediate_actions, :classification, :root_cause, :bc_number, 
        										:injury_flag, :safety_flag, :environmental_flag, :security_flag, :quality_flag, 
        											:acknowledged_flag, :closed_flag, :user_id, :guest_name, :report_form)
    end
    

end
