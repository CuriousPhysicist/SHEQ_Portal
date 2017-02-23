class AddAuthorRefToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_reference(:users, :author, index: true)
  end
end
