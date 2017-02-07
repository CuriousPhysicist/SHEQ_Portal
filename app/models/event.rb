class Event < ApplicationRecord
    
    belongs_to :user, optional: true
    has_many :actions

    mount_uploader :report_form, ReportFormUploader
    
end
