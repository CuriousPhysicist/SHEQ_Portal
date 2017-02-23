class Action < ApplicationRecord
    
    belongs_to :user, optional: true
    belongs_to :event, optional: true
    
    validates :reference_number, presence: true
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
		
		
		## code below inspects owner field and associated to existing user if available
		name = row['owner'].split(", ")
		created = row['date_time_created'].to_date
		
		is_user = nil
		user_id = nil
		is_user ||= User.where('last_name = ?', name[0]).where('first_name = ?', name[1])

		if is_user.empty? == false 
			user_id = is_user[0].id
		end
		owner_name = name.reverse.join(" ")
	    action.attributes = row.to_hash.slice(*['reference_number', 'initiator', 'source', 'date_target', 'type_ABC',
                                                                      'description', 'progress', 'closeout', 'accepted_flag', 'closed_flag'])
		action.update("owner" => owner_name)
		action.update("user_id" => user_id)
		action.update("date_time_created" => created)
		
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
    
    ## This method enables searching of action fields
    
    def self.search(search)
        where("reference_number LIKE ? OR description LIKE ? OR progress LIKE ? OR closeout LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
    end


end
