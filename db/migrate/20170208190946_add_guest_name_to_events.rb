class AddGuestNameToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :guest_name, :string
  end
end
