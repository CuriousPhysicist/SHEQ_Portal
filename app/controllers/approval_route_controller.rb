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
  end

  def update
    @approval_route = ApprovalRoute.find(params[:format]) ## pulls requested Approval Route record from database
    
    author_name_arr = params[:approval_routes][:author_name].split(" ")
    reviewer_name_arr = params[:approval_routes][:reviewer_name].split(" ")
    approver_name_arr = params[:approval_routes][:approver_name].split(" ")
    
    author = Author.where('approval_route_id = ?', @approval_route.id).first
    reviewer = Reviewer.where('approval_route_id = ?', @approval_route.id).first
    approver = Approver.where('approval_route_id = ?', @approval_route.id).first
    
    newauthor = User.where('first_name = ?', author_name_arr[0]).where('last_name = ?', author_name_arr[1]).first
    newreviewer = User.where('first_name = ?', reviewer_name_arr[0]).where('last_name = ?', reviewer_name_arr[1]).first
    newapprover = User.where('first_name = ?', approver_name_arr[0]).where('last_name = ?', approver_name_arr[1]).first
    
    author.update(:user_id => newauthor.id)
    reviewer.update(:user_id => newreviewer.id)
    approver.update(:user_id => newapprover.id)
    
        if @approval_route.update(approval_route_params)
            flash[:success] = "Approval Route successfully updated"
            ## email action owner warning of action placing, indicate if action is associated with an Event report
            ## cc line management superior, cc SHEQ team for information.
            #UserMailer.new_action_email(@owner, @action).deliver
            redirect_to approval_route_show_path(@approval_route.id)
        else
            flash[:danger] = "Approval Route failed to save"
            render 'edit'
        end
    
    #debugger
    
    
  end

  def show
    @approval_routes = ApprovalRoute.find(params[:format]) ## pulls requested Approval Route record from database
    @document = Document.where('id = ?', @approval_routes.document_id).first ## selects the document associated with the approval route
    
    @author = Author.where('approval_route_id = ?', @approval_routes.id).first ## author associated with this approval route
    @reviewer = Reviewer.where('approval_route_id = ?', @approval_routes.id).first ## reviewer associated with this approval route
    @approver = Approver.where('approval_route_id = ?', @approval_routes.id).first ## aprover associated with this approval route
    
    @author_user = User.where('id = ?', @author.user_id).first ## selects the user associated with the author id
    @reviewer_user = User.where('id = ?', @reviewer.user_id).first ## selects the user associated with the reviewer id
    @approver_user = User.where('id = ?', @approver.user_id).first ## selects the user associated with the approver id
    
  end

  def close_route
  end
  
   # Private actions below (including strong parameters white-list)
    
  private
    
  def approval_route_params
      params.require(:approval_routes).permit(:author_name, :reviewer_name, :approver_name)
  end
end
