class AddClosedFlagToApprovalRoutes < ActiveRecord::Migration[5.0]
  def change
  	add_column :approval_routes, :closed_flag, :boolean
  end

end
