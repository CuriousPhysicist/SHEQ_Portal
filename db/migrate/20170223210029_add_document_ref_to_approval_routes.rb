class AddDocumentRefToApprovalRoutes < ActiveRecord::Migration[5.0]
  def change
  	add_reference(:approval_routes, :document, index: true)
  end
end
