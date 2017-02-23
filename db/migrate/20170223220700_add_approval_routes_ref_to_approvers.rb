class AddApprovalRoutesRefToApprovers < ActiveRecord::Migration[5.0]
  def change
  	add_reference(:approvers, :approval_route, index: true)
  end
end
