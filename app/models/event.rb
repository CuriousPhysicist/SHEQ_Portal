class Event < ApplicationRecord
    
    belongs_to :user, optional: true
    has_many :actions

    mount_uploader :report_form, ReportFormUploader # Tells rails to use this uploader for this model
    
    # Validations put requirements on a submission before allowing it to be saved to the database
    
    validates :what_happened, presence: true # Make sure a description of what happened is present.
    validates :immediate_actions, presence: true # Make sure description of actions taken is present.
    validates :reference_number, presence: true
    
end
