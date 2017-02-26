class DocumentsController < ApplicationController

  def index
    if params[:search]
      ## If a search has been carried out this collates the results 
      @documents_result = Document.search(params[:search]).order("created_at DESC")

      if params[:doc_type]

        ## If a doc_type is selected then filter for this type and apply subsequent filters to the sub-set

        @documents_type = @documents_result.search(params[:doc_type])
        @documents_result = @documents_type ## sets @documents_result to doc_type subset for status filtering

        ## build sub-sets based on status filters
        if params[:status1]
          @documents_status1 = @documents_result.search(params[:status1])
        end
        if params[:status2]
          @documents_status2 = @documents_result.search(params[:status2])
        end
        if params[:status3]
          @documents_status3 = @documents_result.search(params[:status3])
        end
        if params[:status4]
          @documents_status4 = @documents_result.search(params[:status4])
        end
        if params[:status5]
          @documents_status5 = @documents_result.search(params[:status5])
        end

        ## re-initialise the instance variable with an empty ActiveRecords relation 'hash'
        ## The if statement prevents re-initialisation if no status filters applied
        if params[:status1] || params[:status2] || params[:status3] || params[:status4] || params[:status5]
          @documents_result = Document.none
        end

        ## Creates a union of all subsets not nil
        
        ## case with doc type and status filters
        if @documents_status1
          @documents_result = @documents_result.or(@documents_status1)
        end
        if @documents_status2
          @documents_result = @documents_result.or(@documents_status2)
        end
        if @documents_status3
          @documents_result = @documents_result.or(@documents_status3)
        end
        if @documents_status4
          @documents_result = @documents_result.or(@documents_status4)
        end
        if @documents_status5
          @documents_result = @documents_result.or(@documents_status5)
        end
        
      else 

        ## case with no doc_type filter

        ## build sub-sets based on status filters
        if params[:status1]
          @documents_status1 = @documents_result.search(params[:status1])
        end
        if params[:status2]
          @documents_status2 = @documents_result.search(params[:status2])
        end
        if params[:status3]
          @documents_status3 = @documents_result.search(params[:status3])
        end
        if params[:status4]
          @documents_status4 = @documents_result.search(params[:status4])
        end
        if params[:status5]
          @documents_status5 = @documents_result.search(params[:status5])
        end

        ## re-initialise the instance variable with an empty ActiveRecords relation 'hash'
        ## the if statement prevents re-initialisation if no filters applied
        if params[:status1] || params[:status2] || params[:status3] || params[:status4] || params[:status5]
          @documents_result = Document.none
        end

        ## Creates a union of all subsets not nil
        if @documents_status1
          @documents_result = @documents_result.or(@documents_status1)
        end
        if @documents_status2
          @documents_result = @documents_result.or(@documents_status2)
        end
        if @documents_status3
          @documents_result = @documents_result.or(@documents_status3)
        end
        if @documents_status4
          @documents_result = @documents_result.or(@documents_status4)
        end
        if @documents_status5
          @documents_result = @documents_result.or(@documents_status5)
        end
      end

    else
      ## No search initiated ... SQL query to provide all documents to the view, ordered by doc_type
      @documents = Document.all.order(:doc_type)
      
      if params[:doc_type]

        ## If a doc_type is selected then filter for this type and apply subsequent filters to the sub-set

        @documents_type = @documents.search(params[:doc_type])
        @documents = @documents_type ## sets @documents to doc_type subset for status filtering

        ## build sub-sets based on status filters
        if params[:status1]
          @documents_status1 = @documents.search(params[:status1])
        end
        if params[:status2]
          @documents_status2 = @documents.search(params[:status2])
        end
        if params[:status3]
          @documents_status3 = @documents.search(params[:status3])
        end
        if params[:status4]
          @documents_status4 = @documents.search(params[:status4])
        end
        if params[:status5]
          @documents_status5 = @documents.search(params[:status5])
        end

        ## re-initialise the instance variable with an empty ActiveRecords relation 'hash'
        ## The if statement prevents re-initialisation if no status filters applied
        if params[:status1] || params[:status2] || params[:status3] || params[:status4] || params[:status5]
          @documents = Document.none
        end

        ## Creates a union of all subsets not nil
        
        ## case with doc type and status filters
        if @documents_status1
          @documents = @documents.or(@documents_status1)
        end
        if @documents_status2
          @documents = @documents.or(@documents_status2)
        end
        if @documents_status3
          @documents = @documents.or(@documents_status3)
        end
        if @documents_status4
          @documents = @documents.or(@documents_status4)
        end
        if @documents_status5
          @documents = @documents.or(@documents_status5)
        end

      else 

        ## case with no doc_type filter

        ## build sub-sets based on status filters
        if params[:status1]
          @documents_status1 = @documents.search(params[:status1])
        end
        if params[:status2]
          @documents_status2 = @documents.search(params[:status2])
        end
        if params[:status3]
          @documents_status3 = @documents.search(params[:status3])
        end
        if params[:status4]
          @documents_status4 = @documents.search(params[:status4])
        end
        if params[:status5]
          @documents_status5 = @documents.search(params[:status5])
        end

        ## re-initialise the instance variable with an empty ActiveRecords relation 'hash'
        ## the if statement prevents re-initialisation if no filters applied
        if params[:status1] || params[:status2] || params[:status3] || params[:status4] || params[:status5]
          @documents = Document.none
        end

        ## Creates a union of all subsets not nil
        if @documents_status1
          @documents = @documents.or(@documents_status1)
        end
        if @documents_status2
          @documents = @documents.or(@documents_status2)
        end
        if @documents_status3
          @documents = @documents.or(@documents_status3)
        end
        if @documents_status4
          @documents = @documents.or(@documents_status4)
        end
        if @documents_status5
          @documents = @documents.or(@documents_status5)
        end
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
      params.require(:documents).permit(:doc_number, :doc_type, :status, :issue_number, :title, :comments, :stored_doc, :stored_pdf)
  end
end
