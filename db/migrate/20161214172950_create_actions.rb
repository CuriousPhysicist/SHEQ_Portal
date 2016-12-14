class CreateActions < ActiveRecord::Migration[5.0]
  def change
    create_table :actions do |t|
      t.integer :refernce_number
      t.datetime :date_time_created
      t.string :initiator
      t.string :owner
      t.string :type_ABC
      t.date :date_target
      t.integer :extentions_number
      t.text :description
      t.text :progress
      t.text :closeout
      t.string :source
      t.boolean :open_flag
      
      t.references :user

      t.timestamps
    end
  end
end
