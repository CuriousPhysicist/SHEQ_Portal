class AddExtendRequestFlagToUsers < ActiveRecord::Migration[5.0]
  def up
    change_table :actions do |t|
      t.boolean :extend_request_flag, :default => false
    end
  end
  
  def down
    remove_column :actions, :extend_request_flag
  end
end
