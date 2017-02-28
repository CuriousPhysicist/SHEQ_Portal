class ApprovalRouteController < ApplicationController

  def create
  end

  def edit
    @approval_routes = ApprovalRoute.find(params[:format]) ## pulls requested Approval Route record from database
    @document = Document.where('id = ?', @approval_routes.document_id).first ## selects the document associated with the approval route
    
    debugger
    
    @author = Author.where('approval_route_id = ?', @approval_routes.id).first ## author associated with this approval route
    @reviewer = Reviewer.where('approval_route_id = ?', @approval_routes.id).first ## reviewer associated with this approval route
    @approver = Approver.where('approval_route_id = ?', @approval_routes.id).first ## aprover associated with this approval route
    
    if @author
      @author_user = User.where('author_id = ?', @author.id).first ## selects the user associated with the author id
    end
    if @reviewer
      @reviewer_user = User.where('reviewer_id = ?', @reviewer.id).first ## selects the user associated with the reviewer id
    end
    if @approver
      @approver_user = User.where('approver_id = ?', @approver.id).first ## selects the user associated with the approver id
    end
    
  end

  def update
  end

  def show
    @approval_routes = ApprovalRoute.find(params[:format]) ## pulls requested Approval Route record from database
    @document = Document.where('id - ?', @approval_routes.document_id).first ## selects the document associated with the approval route
    
    @author = Author.where('approval_route_id = ?', @approval_routes.id).first ## author associated with this approval route
    @reviewer = Reviewer.where('approval_route_id = ?', @approval_routes.id).first ## reviewer associated with this approval route
    @approver = Approver.where('approval_route_id = ?', @approval_routes.id).first ## aprover associated with this approval route
    
    @author_user = User.where('author_id = ?', @author.id).first ## selects the user associated with the author id
    @reviewer_user = User.where('reviewer_id = ?', @reviewer.id).first ## selects the user associated with the reviewer id
    @approver_user = User.where('approver_id = ?', @approver.id).first ## selects the user associated with the approver id
    
  end

  def close_route
  end
end
