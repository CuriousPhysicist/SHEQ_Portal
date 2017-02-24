class DocumentsController < ApplicationController

  def index
    if params[:search]
      ## If a search has been carried out this collates the results 
      @documents_result = Document.search(params[:search]).order("created_at DESC")
    else
      ## SQL query to provide all documents to the view, grouped by doc_type
      @documents = Document.all.group(doc_type)       
    end
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
      params.require(:documents).permit(:doc_number, :doc_type, :status, :issue_number, :title, :comments)
  end
end
