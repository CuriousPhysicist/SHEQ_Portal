class ApprovalRoute < ApplicationRecord

## Set the relationships between models

belongs_to :documents
has_one :authors
has_one :reviewers
has_one :approvers

end
