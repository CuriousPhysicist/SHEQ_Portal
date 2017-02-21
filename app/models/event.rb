class Event < ApplicationRecord
    
    belongs_to :user, optional: true
    has_many :actions

    mount_uploader :report_form, ReportFormUploader # Tells rails to use this uploader for this model
    
    # Validations put requirements on a submission before allowing it to be saved to the database
    
    validates :what_happened, presence: true # Make sure a description of what happened is present.
    validates :immediate_actions, presence: true # Make sure description of actions taken is present.
    validates :reference_number, presence: true
    
    def self.to_csv(options={})
    	CSV.generate(options) do |csv|
    		csv << column_names
    		all.each do |event|
    			csv << event.attributes.values_at(*column_names)
    		end
    	end
    end

    def self.import(file)
    	spreadsheet = open_spreadsheet(file)
    	header = spreadsheet.row(1)
    	(2..spreadsheet.last_row).each do |i|
    	    row = Hash[[header, spreadsheet.row(i)].transpose]
	        event = find_by_id(row["id"])||new
	    
		    event.attributes = row.to_hash.slice(*['reference_number', 'date_raised', 'date_closed', 'location', 'building', 'area', 
        									'what_happened', 'immediate_actions', 'classification', 'root_cause', 'bc_number', 
        										'injury_flag', 'safety_flag', 'environmental_flag', 'security_flag', 'quality_flag', 
        											'closed_flag', 'user_id', 'guest_name','follow_up', 'file_location'])

            event.save!

            path = event.file_location
            debugger
            event.update(:report_form =>  open(path))   
	    end
    end

    def self.open_spreadsheet(file)
    	case File.extname(file.original_filename)
    	when ".csv" then Roo::CSV.new(file.path, csv_options: {encoding: "iso-8859-1:utf-8"})
    	when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    	when ".xlsx" then Roo::Excelx.new(file.path)
    	else raise "Unknown file type: #{file.original_filename}"
    	end
    end

end
