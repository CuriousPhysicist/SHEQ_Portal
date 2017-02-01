class AddClosedFlagColumnToActions < ActiveRecord::Migration[5.0]
  def up
    change_table :actions do |t|
      t.boolean :closed_flag
    end
  end
  
  def down
    remove_column :actions, :closed_flag
  end
  
end
