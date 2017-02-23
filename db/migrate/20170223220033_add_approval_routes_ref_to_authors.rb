class AddApprovalRoutesRefToAuthors < ActiveRecord::Migration[5.0]
  def change
  	add_reference(:authors, :approval_route, index: true)
  end
end
