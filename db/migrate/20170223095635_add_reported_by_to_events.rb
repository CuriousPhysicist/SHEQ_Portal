class AddReportedByToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :reported_by, :string
  end
end
