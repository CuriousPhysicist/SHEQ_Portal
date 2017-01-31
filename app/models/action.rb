class Action < ApplicationRecord
    
    belongs_to :user, optional: true
    
    validates :initiator, presence: true, length: { maximum: 255 }
    validates :description, presence: true, length: { maximum: 255 }
    
    def self.to_csv(options={})
    	CSV.generate(options) do |csv|
    		csv << column_names
    		all.each do |action|
    			csv << action.attributes.values_at(*column_names)
    		end
    	end
    end

    def self.import(file)
    	spreadsheet = open_speadsheet(file)
    	header = spreadsheet.row(1)
    	(2..spreadsheet.last.row).each do |i|
    		row = Hash[[header, spreadsheet.row(i)].transpose]
	    	action = find_by_id(row["id"])||new
	    	action.attributes = row.to_hash.slice(*accessible_attributes)
	    	action.save!
	    end
    end

    def self.open_spreadsheet(file)
    	case File.extname(file.original_filename)
    	when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
    	when ".xls" then Excel.new(file.path, nil, :ignore)
    	when "xlsx" then Exelx.new(file.path, nil, :ignore)
    	else raise "Unknown file type: #{file.original_filename}"
    	end
    end


end
