class EventsController < ApplicationController
    
	before_action :require_user, only: [:index, :show, :edit]
    
    

    #RESTful resources
    
    def index
        @events = Event.all
    end

    def new
    	@event = Event.new
    end
    
    def edit
        @events = Event.find(params[:id])
        @user = current_user
        gon.users = User.all
    end
    
    def show
        @events = Event.find(params[:id])
    end
    
    def create
        @event = Event.new(event_params)
        
        if @event.save!
            redirect_to events_path
        else
            render 'edit'
        end
    end
    
    def update
        @event = Event.find(params[:id])
        
        if @event.update(event_params)
            redirect_to @event
        else
            redirect_to edit_event_path
        end
    end
    
    def destroy
        @event = Event.find(params[:id])
        @event.destroy
        redirect_to events_path
    end

    # Private actions below (including strong parameters white-list)
    
    private
    
    def event_params
        params.require(:events).permit(:refernce_number, :date_raised, :date_closed, :location, :building, :area, 
        									:what_happened, :immediate_actions, :classification, :root_cause, :bc_number, 
        										:injury_flag, :safety_flag, :environmental_flag, :security_flag, :quality_flag, 
        											:closed_flag, :user_id, :report_form)
    end
    

end
