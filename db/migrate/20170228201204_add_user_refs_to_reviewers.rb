class AddUserRefsToReviewers < ActiveRecord::Migration[5.0]
  def up
  	#remove_reference(:reviewers, :approval_route)
  	add_reference(:reviewers, :user, index: true)
  end

  def down
  	remove_reference(:reviewers, :user)
  	#add_reference(:reviewers, :approval_route, index: true)
  end
end
