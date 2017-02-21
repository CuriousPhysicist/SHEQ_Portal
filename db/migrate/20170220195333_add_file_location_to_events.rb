class AddFileLocationToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :file_location, :string
  end
end
