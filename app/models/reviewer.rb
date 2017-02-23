class Reviewer < ApplicationRecord

## Set the relationships between models

belongs_to_many :approval_routes
has_many :users

end
