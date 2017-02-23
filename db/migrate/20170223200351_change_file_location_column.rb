class ChangeFileLocationColumn < ActiveRecord::Migration[5.0]
  def up
  	remove_column :documents, :file_location
  	add_column :documents, :file_location_doc, :string
  end

  def down
  	remove_column :documents, :file_location_doc
  	add_column :documents, :file_location, :string
  end
end
