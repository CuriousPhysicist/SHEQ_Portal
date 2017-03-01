class AddCheckOutByColumnToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :checked_out_by, :integer
  end
end
