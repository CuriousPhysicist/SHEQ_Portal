class AddUserRefsToApprovers < ActiveRecord::Migration[5.0]
  def up
  	#remove_reference(:approvers, :approval_route)
  	add_reference(:approvers, :user, index: true)
  end

  def down
  	remove_reference(:approvers, :user)
  	#add_reference(:approvers, :approval_route, index: true)
  end
end
