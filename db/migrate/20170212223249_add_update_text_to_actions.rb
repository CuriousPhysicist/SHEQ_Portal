class AddUpdateTextToActions < ActiveRecord::Migration[5.0]
  def change
    add_column :actions, :updatetext, :text
  end
end
