class AddApprovalRoutesRefToReviewers < ActiveRecord::Migration[5.0]
  def change
  	add_reference(:reviewers, :approval_route, index: true)
  end
end
