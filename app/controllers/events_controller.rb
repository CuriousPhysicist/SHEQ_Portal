class EventsController < ApplicationController
	
	before_action :require_user, only: [:index, :show, :edit] # Sets before filters limiting actions for users

    #RESTful resources
    
    def index
        @events = Event.all
    end

    def new
    	@events = Event.new
    	@last_event = Event.last
    	@user = current_user
    end
    
    def edit
        @events = Event.find(params[:id])
    end
    
    def show
        @events = Event.find(params[:id])
    end
    
    def create
        @event = Event.new(event_params)
        
        if @event.save!
            flash[:success] = "Report successfully submitted"
            redirect_to events_path
        else
            flash[:warning] = "Report failed to submit"
            render 'edit'
        end
    end
    
    def update
        @event = Event.find(params[:id])
        
        if @event.update(event_params)
            flash[:success] = "Report successfully updated"
            redirect_to @event
        else
            flash[:warning] = "Report failed to update"
            redirect_to edit_event_path
        end
    end
    
    def destroy
        @event = Event.find(params[:id])
        @event.destroy
        flash[:info] = "Report deleted"
        redirect_to events_path
    end

    # Private actions below (including strong parameters white-list)
    
    private
    
    def event_params
        params.require(:events).permit(:reference_number, :date_raised, :date_closed, :location, :building, :area, 
        									:what_happened, :immediate_actions, :classification, :root_cause, :bc_number, 
        										:injury_flag, :safety_flag, :environmental_flag, :security_flag, :quality_flag, 
        											:closed_flag, :user_id, :report_form)
    end
    

end
