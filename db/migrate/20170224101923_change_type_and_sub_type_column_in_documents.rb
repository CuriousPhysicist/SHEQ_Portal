class ChangeTypeAndSubTypeColumnInDocuments < ActiveRecord::Migration[5.0]
  def up
    remove_column :documents, :type
  	add_column :documents, :doc_type, :string
  	remove_column :documents, :sub_type
  	add_column :documents, :doc_sub_type, :string
  end
  
  def down
    remove_column :documents, :doc_type
  	add_column :documents, :type, :string
  	remove_column :documents, :doc_sub_type
  	add_column :documents, :sub_type, :string
  end
end
