class EventsController < ApplicationController
    
	before_action :require_user, only: [:index, :show, :edit]
    
    def index
        @events = Event.all
    end
    

end
