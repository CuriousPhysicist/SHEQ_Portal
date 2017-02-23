class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :title
      t.string :type
      t.integer :issue_number
      t.boolean :checked_out_flag
      t.string :author
      t.string :reviewer
      t.string :approver
      t.boolean :reviewed_flag
      t.boolean :approved_flag
      t.boolean :issued_flag
      t.datetime :issued_on
      t.datetime :review_period
      t.datetime :due_date
      t.datetime :review_duration
      t.datetime :reviewed_on
      t.datetime :approved_on
      t.string :file_location
      t.string :stored_doc
      t.string :stored_pdf
      t.boolean :review_request_flag
      t.boolean :approve_request_flag

      t.timestamps
    end
  end
end
