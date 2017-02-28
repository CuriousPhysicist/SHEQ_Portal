class AddAuthorReviewerApproverNamesToApprovalRoutes < ActiveRecord::Migration[5.0]
  def change
  	add_column :approval_routes, :author_name, :string
  	add_column :approval_routes, :reviewer_name, :string
  	add_column :approval_routes, :approver_name, :string
  end
end
