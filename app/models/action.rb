class Action < ApplicationRecord
    
    belongs_to :user, optional: true
    
    validates :initiator, presence: true, length: { maximum: 255 }
    validates :description, presence: true
    
    def self.to_csv(options={})
    	CSV.generate(options) do |csv|
    		csv << column_names
    		all.each do |action|
    			csv << action.attributes.values_at(*column_names)
    		end
    	end
    end

    def self.import(file)
    	spreadsheet = open_spreadsheet(file)
    	header = spreadsheet.row(1)
    	(2..spreadsheet.last_row).each do |i|
    		row = Hash[[header, spreadsheet.row(i)].transpose]
	    	action = find_by_id(row["id"])||new
	    	action.attributes = row.to_hash.slice(*['refernce_number', 'initiator', 'owner', 'source', 'date_target', 'type_ABC',
                                                                     'date_time_created', 'description', 'progress', 'closeout', 'closed_flag'])
	    	action.save!
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
