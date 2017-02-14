class AddActiveFlagAndCommentToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :active_flag, :boolean
    add_column :users, :comment, :text
  end
end
