class AddFileLocationPdfToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :file_location_pdf, :string
  end
end
