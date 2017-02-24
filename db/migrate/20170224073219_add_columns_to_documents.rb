class AddColumnsToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :status, :string
    add_column :documents, :doc_number, :integer
    add_column :documents, :comments, :text
    add_column :documents, :sub_type, :string
  end
end
