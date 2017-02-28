class RemoveRefsFromUsers < ActiveRecord::Migration[5.0]
  def change
  	remove_reference(:users, :author)
  	remove_reference(:users, :reviewer)
  	remove_reference(:users, :approver)
  end
end
