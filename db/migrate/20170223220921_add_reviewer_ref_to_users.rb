class AddReviewerRefToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_reference(:users, :reviewer, index: true)
  end
end
