class DocumentsController < ApplicationController

  def index
    @documents = Document.all
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
  end

  def import
  end

  def search
  end

  def tasks
  end

  def reviewplease
  end

  def reviewed
  end

  def approveplease
  end

  def approved
  end

  def checkout
  end

  def checkin
  end
  
  # Private actions below (including strong parameters white-list)
    
  private
    
  def event_params
      params.require(:documents).permit(:reference_number, :type, :status, :issue_number, :title, :comments)
  end
end
