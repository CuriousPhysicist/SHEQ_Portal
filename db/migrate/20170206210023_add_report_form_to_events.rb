class AddReportFormToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :report_form, :string
  end
end
