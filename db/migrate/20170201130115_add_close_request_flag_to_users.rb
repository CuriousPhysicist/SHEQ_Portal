class AddCloseRequestFlagToUsers < ActiveRecord::Migration[5.0]
  def up
    change_table :actions do |t|
      t.boolean :close_request_flag, :default => false
    end
  end
  
  def down
    remove_column :actions, :close_request_flag
  end
end
