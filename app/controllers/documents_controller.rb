class DocumentsController < ApplicationController

  def index
    if params[:search]
      ## If a search has been carried out this collates the results 
      @documents_result = Document.search(params[:search]).order("created_at DESC")

    else
      ## SQL query to provide all documents to the view, grouped by doc_type
      @documents = Document.all.order(:doc_type)

      if params.length > 3
        #debugger
        @documents_type = @documents.search(params[:doc_type])
        @documents_status1 = @documents.search(params[:status1])
        @documents_status2 = @documents.search(params[:status2])
        @documents_status3 = @documents.search(params[:status3])
        @documents_status4 = @documents.search(params[:status4])
        @documents_status5 = @documents.search(params[:status5])

        #@documents = merge(@documents_type, @documents_status1, @documents_status2, @documents_status3, @documents_status4, @documents_status5)
      end

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
    @documents = Document.find(params[:id]) ## pulls requested Document record from database
  end

  # actions for data importing

  def import
      Document.import(params[:file])
      redirect_to documents_path
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
