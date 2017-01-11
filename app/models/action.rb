class Action < ApplicationRecord
    
    belongs_to :user, optional: true
    
    validates :initiator, presence: true, length: { maximum: 255 }
    validates :description, presence: true, length: { maximum: 255 }
    
    
end
