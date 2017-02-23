class AddApproverRefToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_reference(:users, :approver, index: true)
  end
end
