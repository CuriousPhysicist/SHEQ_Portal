class CreateApprovalRoutes < ActiveRecord::Migration[5.0]
  def change
    create_table :approval_routes do |t|

      t.timestamps
    end
  end
end
