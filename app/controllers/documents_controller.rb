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
        if params[:status6]
          @documents_status6 = @documents_result.search(params[:status6])
        end

        ## re-initialise the instance variable with an empty ActiveRecords relation 'hash'
        ## The if statement prevents re-initialisation if no status filters applied
        if params[:status1] || params[:status2] || params[:status3] || params[:status4] || params[:status5] || params[:status6]
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
        if @documents_status6
          @documents_result = @documents_result.or(@documents_status6)
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
        if params[:status6]
          @documents_status6 = @documents_result.search(params[:status6])
        end

        ## re-initialise the instance variable with an empty ActiveRecords relation 'hash'
        ## the if statement prevents re-initialisation if no filters applied
        if params[:status1] || params[:status2] || params[:status3] || params[:status4] || params[:status5] || params[:status6]
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
        if @documents_status6
          @documents_result = @documents_result.or(@documents_status6)
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
        if params[:status6]
          @documents_status6 = @documents.search(params[:status6])
        end

        ## re-initialise the instance variable with an empty ActiveRecords relation 'hash'
        ## The if statement prevents re-initialisation if no status filters applied
        if params[:status1] || params[:status2] || params[:status3] || params[:status4] || params[:status5] || params[:status6]
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
        if @documents_status6
          @documents = @documents.or(@documents_status6)
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
        if params[:status6]
          @documents_status6 = @documents.search(params[:status6])
        end

        ## re-initialise the instance variable with an empty ActiveRecords relation 'hash'
        ## the if statement prevents re-initialisation if no filters applied
        if params[:status1] || params[:status2] || params[:status3] || params[:status4] || params[:status5] || params[:status6]
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
        if @documents_status6
          @documents = @documents.or(@documents_status6)
        end
      end
    end
  end

  def new
    @documents = Document.new
  end

  def create
    @document = Document.new(document_params)
    
    if @document.save!
            flash[:success] = "Document successfully created"
            @approval_route = ApprovalRoute.create(
                      document_id: @document.id
              )
            @author = Author.create(
                      approval_route_id: @approval_route.id,
                      user_id: current_user.id
              )
            review_users = User.where('team = ?', current_user.team)
            review_user = review_users.where('level = ?', 2).first
            @reviewer = Reviewer.create(
                      approval_route_id: @approval_route.id,
                      user_id: 2
              )
            approve_user = User.where('team = ?', "SHEQ").where('level = ?', 3).first
            @approver = Approver.create(
                      approval_route_id: @approval_route.id,
                      user_id: 3
              )
            ## email action owner warning of action placing, indicate if action is associated with an Event report
            ## cc line management superior, cc SHEQ team for information.
            #UserMailer.new_action_email(@owner, @action).deliver
            redirect_to document_path(@document.id)
        else
            flash[:danger] = "Document failed to save"
            render 'new'
        end
    
  end

  def edit
    @documents = Document.find(params[:id]) ## pulls requested Document record from database

    @approval_route = ApprovalRoute.where('document_id = ?', @documents.id).first ## selects the open approval route with the matching document id

  end

  def update
    @document = Document.find(params[:id]) ## pulls requested Document record from database
    
    if @document.update(document_params)
            flash[:success] = "Document successfully updated"
            ## email action owner warning of action placing, indicate if action is associated with an Event report
            ## cc line management superior, cc SHEQ team for information.
            #UserMailer.new_action_email(@owner, @action).deliver
            redirect_to document_path(@document.id)
        else
            flash[:danger] = "Document failed to save"
            render 'edit'
        end
  end

  def show
    @documents = Document.find(params[:id]) ## pulls requested Document record from database
    @approval_route = ApprovalRoute.where('document_id - ?', @documents.id).first ## selects the open approval route with the matching document id

    #MiniMagick.configure do |config|
      #config.validate_on_create = false
      #config.validate_on_write = false
    #end

    # pdf_path = @documents.stored_pdf_url
    # page_index_path = File.join(Rails.root, pdf_path + "[0]")
    # pdf_page = MiniMagick::Image.read(page_index_path)
    # pdf_page.write("app/assets/images/thumb#{current_user.id}.png")

  end
  
  def upissue
    @olddocument = Document.where('id = ?', params[:id]).first
    @oldapprovalroute = ApprovalRoute.where('document_id = ?', @olddocument.id).first
    @oldreviewer = Reviewer.where('approval_route_id = ?', @oldapprovalroute.id).first
    @oldapprover = Approver.where('approval_route_id = ?', @oldapprovalroute.id).first
    doc_filepath = File.join(Rails.root, "public" + @olddocument.stored_doc_url)
    @documents = Document.create(
                      title: @olddocument.title,
                      doc_type: @olddocument.doc_type,
                      doc_number: @olddocument.doc_number,
                      status: "In Prep",
                      issue_number: @olddocument.issue_number+1,
                      stored_doc: open(doc_filepath)
              )
    @approval_route = ApprovalRoute.create(
                      document_id: @documents.id
              )
    @author = Author.create(
                      approval_route_id: @approval_route.id,
                      user_id: current_user.id
              )
    @reviewer = Reviewer.create(
                      approval_route_id: @approval_route.id,
                      user_id: @oldreviewer.user_id
              )
    @approver = Approver.create(
                      approval_route_id: @approval_route.id,
                      user_id: @oldapprover.user_id
              )
  end

  # actions for data importing

  def import
      Document.import(params[:file])
      redirect_to documents_path
  end

  def search
  end

  def tasks
    
    ## The code below selects the documents which are 'live' and which the current_user is the assigned Author
    approute_arr = []
    k = 0
    
    author_hsh = Author.where('user_id = ?', current_user.id).index_by(&:approval_route_id).to_a
    (0..author_hsh.length-1).each do |i| 
      approute_arr[k] = author_hsh[i][0]
      k += 1
    end
    
    document_arr = []
    k = 0
    approvalroutes_hsh = ApprovalRoute.where('id IN(?)', approute_arr).index_by(&:document_id).to_a
    
    (0..approvalroutes_hsh.length-1).each do |i| 
      document_arr[k] = author_hsh[i][0]
      k += 1
    end
    
    @documents_in_prep = Document.where('issued_flag = ?', false).where('id IN(?)', document_arr)
    
    
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
    @document = Document.find(params[:format])
    
    @document.update(:checked_out_flag => true, :checked_out_by => current_user.id)
    #@document.send(stored_doc_url)
    redirect_to document_path(@document.id)
    
    #@documents.stored_doc_url
  end

  def checkin
    @document = Document.find(params[:format])
    
    @document.update(:checked_out_flag => false, :checked_out_by => nil)
    #@document.send(stored_doc_url)
    redirect_to document_path(@document.id)
  end
  
  # Private actions below (including strong parameters white-list)
    
  private
    
  def document_params
      params.require(:documents).permit(:doc_number, :doc_type, :status, :issue_number, :title, :comments, :stored_doc, :stored_pdf)
  end
end
