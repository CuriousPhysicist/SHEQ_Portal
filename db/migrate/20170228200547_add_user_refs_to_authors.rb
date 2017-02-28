class AddUserRefsToAuthors < ActiveRecord::Migration[5.0]
  def up
  	#remove_reference(:authors, :approval_route)
  	add_reference(:authors, :user, index: true)
  end

  def down
  	remove_reference(:authors, :user)
  	#add_reference(:authors, :approval_route, index: true)
  end
end
