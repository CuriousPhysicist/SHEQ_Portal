class ApprovalRouteController < ApplicationController

  def create
  end

  def edit
    @approval_routes = ApprovalRoute.find(params[:format]) ## pulls requested Approval Route record from database
    @document = Document.where('id = ?', @approval_routes.document_id).first ## selects the document associated with the approval route
    
    gon.users = User.all

    @author = Author.where('approval_route_id = ?', @approval_routes.id).first ## author associated with this approval route
    @reviewer = Reviewer.where('approval_route_id = ?', @approval_routes.id).first ## reviewer associated with this approval route
    @approver = Approver.where('approval_route_id = ?', @approval_routes.id).first ## aprover associated with this approval route
    
    if @author
      @author_user = User.where('id = ?', @author.user_id).first ## selects the user associated with the author id
    else
      @user = User.where('id = ?', current_user.id).first
      @author = Author.create(
          approval_route_id: @approval_routes.id,
          user_id: 1
        )
      @author_user = User.where('id = ?', @author.user_id).first
    end
    if @reviewer
      @reviewer_user = User.where('id = ?', @reviewer.user_id).first ## selects the user associated with the reviewer id
    else
      @reviewer_user = User.where('team = ?', current_user.team).where('level = ?', 2).first
      debugger
      @reviewer = Reviewer.create(
          approval_route_id: @approval_routes.id,
          user_id: @reviewer_user.id
        )
    end
    if @approver
      @approver_user = User.where('id = ?', @approver.user_id).first ## selects the user associated with the approver id
    else
      @approver_user = User.where('team = ?', "SHEQ").where('level = ?', 3).first
      @approver = Approver.create(
          approval_route_id: @approval_routes.id,
          user_id: @approver_user.id
        )
    end
    #debugger
  end

  def update
  end

  def show
    @approval_routes = ApprovalRoute.find(params[:format]) ## pulls requested Approval Route record from database
    @document = Document.where('id - ?', @approval_routes.document_id).first ## selects the document associated with the approval route
    
    @author = Author.where('approval_route_id = ?', @approval_routes.id).first ## author associated with this approval route
    @reviewer = Reviewer.where('approval_route_id = ?', @approval_routes.id).first ## reviewer associated with this approval route
    @approver = Approver.where('approval_route_id = ?', @approval_routes.id).first ## aprover associated with this approval route
    
    @author_user = User.where('id = ?', @author.user_id).first ## selects the user associated with the author id
    @reviewer_user = User.where('id = ?', @reviewer.user_id).first ## selects the user associated with the reviewer id
    @approver_user = User.where('id = ?', @approver.user_id).first ## selects the user associated with the approver id
    
  end

  def close_route
  end
end
