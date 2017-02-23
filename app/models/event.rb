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
	        
	        ## Code below inspects reported-by field and assigns user if available
	        if row['reported_by'] != nil
			name = row['reported_by'].split(" ")
    		
	    		is_user = nil
    			user_id = nil
    			is_user ||= User.where('last_name = ?', name[0]).where('first_name = ?', name[1])
    
	    		if is_user.empty? == false 
    				user_id = is_user[0].id
    			end
	    		owner_name = name.reverse.join(" ")
	        
		end
            ## assigns/updates attributes of Event using the row Hash
            ## only listed keys are inserted, only whitelisted attributes are accepted (see app/controllers/events_controller.rb)
		    event.attributes = row.to_hash.slice(*['reference_number', 'date_raised', 'date_closed', 'location', 'building', 'area', 
        									'what_happened', 'immediate_actions', 'classification', 'root_cause', 'bc_number', 
        										'injury_flag', 'safety_flag', 'environmental_flag', 'security_flag', 'quality_flag', 
        											'closed_flag', 'user_id', 'guest_name','follow_up', 'file_location'])

            event.update("reported_by" => owner_name)
		    event.update("user_id" => user_id)

            ## This section allows the uploading of a single associated file
	    
	    if event.file_location?
		    #path = File.join(Rails.root, event.file_location) ## this path works as is on same local host
	        #event.update(:report_form =>  open(path))   ## uploads file through mounted uploader if on the local server
		    event.remote_report_form_url = event.file_location ## uploads remote file through mounted uploader
		    
	    end
	    event.save! ## saves new information into the database
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
    
    ## This method enables searching of event fields
    
    def self.search(search)
        where("reference_number LIKE ? OR reported_by LIKE ? OR what_happened LIKE ? OR immediate_actions LIKE ? OR follow_up LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
    end

end
