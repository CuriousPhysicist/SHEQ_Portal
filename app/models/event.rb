## Double hash comments are to be retained, single hash commenting dissables code (consider removing from final version)

class Event < ApplicationRecord
    
    ## Set the relationships between models

    belongs_to :user, optional: true ## optional: true added to allow instance of Event without associated user (consider removal)
    has_many :actions

    ## Tells rails to use this uploader for this model using the report_form attribute to store file information

    mount_uploader :report_form, ReportFormUploader 
    
    ## Validations put requirements on a submission before allowing it to be saved to the database
    ## JavaScript logic in events.coffee only allow submission button to appear if validations will be met
    
    validates :what_happened, presence: true ## Make sure a description of what happened is present.
    validates :immediate_actions, presence: true ## Make sure description of actions taken is present.
    validates :reference_number, presence: true ## Make sure the reference number is present

    ## method below builds a .csv file or an xls file depending on options provided
    ## This method requires the 'CSV' library (see config/application.rb)
    
    def self.to_csv(options={})
    	CSV.generate(options) do |csv|
    		csv << column_names
    		all.each do |event|
    			csv << event.attributes.values_at(*column_names)
    		end
    	end
    end

    ## These two methods allow for the importing and creation of Event records using a .csv, .xls or .xlsx file

    def self.import(file)
    	spreadsheet = open_spreadsheet(file)   ## calls the method below to open the file
    	header = spreadsheet.row(1)            ## Assumes that first row is the column headers

        ## loop through each remaining row

    	(2..spreadsheet.last_row).each do |i|
    	    row = Hash[[header, spreadsheet.row(i)].transpose] ## creates key => value pairs in a Hash  each column is a pair
	        event = find_by_id(row["id"])||new ## searches for exiting record and selects, or creates new Event instance
	    
            ## assigns/updates attributes of Event using the row Hash
            ## only listed keys are inserted, only whitelisted attributes are accepted (see app/controllers/events_controller.rb)
		    event.attributes = row.to_hash.slice(*['reference_number', 'date_raised', 'date_closed', 'location', 'building', 'area', 
        									'what_happened', 'immediate_actions', 'classification', 'root_cause', 'bc_number', 
        										'injury_flag', 'safety_flag', 'environmental_flag', 'security_flag', 'quality_flag', 
        											'closed_flag', 'user_id', 'guest_name','follow_up', 'file_location'])

            event.save! ## saves new information into the database

            ## This section allows the uploading of a single associated file

            path = event.file_location ## sets path variable to string in file_location attribute
            #debugger 
            event.update(:report_form =>  open(path))   ## uploads file through mounted uploader
	    end
    end

    ## reading of the file depends on the Roo gem (see Gemfile)
    ## Method requires 'roo' library (see config/application.rb)

    def self.open_spreadsheet(file)
    	case File.extname(file.original_filename)
    	when ".csv" then Roo::CSV.new(file.path, csv_options: {encoding: "iso-8859-1:utf-8"})
    	when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    	when ".xlsx" then Roo::Excelx.new(file.path)
    	else raise "Unknown file type: #{file.original_filename}"
    	end
    end

end
