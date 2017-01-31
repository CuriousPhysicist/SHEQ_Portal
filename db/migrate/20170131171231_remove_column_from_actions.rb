class RemoveColumnFromActions < ActiveRecord::Migration[5.0]
  def up
    remove_column :actions, :open_flag
  end
  
  def down
    change_table :actions do |t|
      t.boolean :open_flag
    end
  end
  
end
