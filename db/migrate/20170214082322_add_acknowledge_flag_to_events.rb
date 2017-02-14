class AddAcknowledgeFlagToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :acknowledged_flag, :boolean
  end
end
