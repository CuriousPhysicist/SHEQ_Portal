class Document < ApplicationRecord

## Set the relationships between models

has_one :approval_routes

## Tells rails to use these uploaders for this model using the stored_doc and stored_pdf attribute to store file information

mount_uploaders :stored_doc, DocFileUploader
mount_uploaders :stored_pdf, PdfFileUploader

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
		    event.attributes = row.to_hash.slice(*['doc_number', 'doc_type', 'status', 'issue_number', 'title', 'comments',
		    													'file_location_doc'])

	        ## This section allows the uploading of a .doc and .pdf associated files
		    
		    if document.file_location_doc?
			    event.remote_stored_doc_url = document.file_location_doc ## uploads .doc remote file through mounted uploader
		    end

		    if document.file_location_pdf?
			    event.remote_stored_pdf_url = document.file_location_pdf ## uploads .pdf remote file through mounted uploader
		    end

		    document.save! ## saves new information into the database
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
        #debugger
        where("doc_number LIKE ? OR title LIKE ? OR comments LIKE ? OR doc_type LIKE ? OR status LIKE ? ", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
    end

end
