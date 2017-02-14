class AddCloseRequestFlagToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :close_request_flag, :boolean
  end
end
