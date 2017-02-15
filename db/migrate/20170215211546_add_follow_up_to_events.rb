class AddFollowUpToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :follow_up, :text
  end
end
