class Event < ApplicationRecord
    
    belongs_to :user, optional: true
    has_many :actions
    
end
