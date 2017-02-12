class AddAcceptedFlagToActions < ActiveRecord::Migration[5.0]
  def change
    add_column :actions, :accepted_flag, :boolean, :default => false
  end
end
