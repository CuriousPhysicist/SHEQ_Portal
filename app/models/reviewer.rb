class Reviewer < ApplicationRecord

## Set the relationships between models

belongs_to :approval_routes
has_one :users

end
