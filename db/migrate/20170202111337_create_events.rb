class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.integer :reference_number
      t.datetime :date_raised
      t.datetime :date_closed
      t.string :location
      t.string :building
      t.string :area
      t.text :what_happened
      t.text :immediate_actions
      t.string :classification
      t.string :root_cause
      t.decimal :bc_number
      t.boolean :injury_flag
      t.boolean :safety_flag
      t.boolean :environmental_flag
      t.boolean :security_flag
      t.boolean :quality_flag
      t.boolean :closed_flag, default: false
      
      t.references :user

      t.timestamps
    end
  end
end
