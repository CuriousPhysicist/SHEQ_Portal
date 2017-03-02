## Double hash comments are to be retained, single hash commenting dissables code (consider removing from final version)
## This seeds in the super-user capable of uploading all records through .csv or .xlsx files

User.create!(first_name:  "Andrew",
             last_name: "Hampson",
             email: "andrewhampson6@gmail.com",
             password:              "Password",
             password_confirmation: "Password",
             team: "SHEQ",
             role: "Senior Manager",
             approval_type: "All Types",
             level: 3,
             active_flag: true,
             admin: true
             )
              
## Retain commented code below, allows seeding of test data using the faker gem

User.create!(first_name:  "Bob",
            last_name: "Builder",
            email: "example@email.com",
            password:              "Password",
            password_confirmation: "Password",
            team: "Engineering",
            department: "Projects",
            role: "Senior Manager",
            level: 3,
            active_flag: true
            )

10.times do |i|
    rnd1 = rand(0..6)
    rnd2 = rand(1..4)

    level_num = rnd2

    teams = ["SHEQ","Operations","Analytical","Maintenance","Projects","Engineering","Management"]
    roles = ["Staff","Line Manager","Senior Manager","Site Manager"]
    
     User.create(
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            email: "example#{i}@email.com",
            password:              "Password",
            password_confirmation: "Password",
            active_flag: true,
            team: teams[rnd1],
            department: "SHEQ",
            role: roles[level_num-1],
            level: level_num
     )
 end

10.times do |i| 
     rnd1 = rand(1..12)
     rnd2 = rand(1..12)
     rnd3 = rand(0..2)
     rnd4 = rand(1..30)
     rnd5 = rand(0..1)
      
      target = Faker::Date.between(2.years.ago,(Time.now + 6.months))
      
     type = ["A","B","C"]
     source = ["QA","SHE"]
      
     Action.create(
            reference_number: i+1,
            initiator:"#{User.find(rnd1).first_name} #{User.find(rnd1).last_name}",
            owner: "#{User.find(rnd2).first_name} #{User.find(rnd2).last_name}",
            source: source[rnd5],
            date_target: target,
            date_time_created: target - 3.months,
            type_ABC: type[rnd3],
            description: Faker::Lorem.paragraph,
            closed_flag: false,
            user_id: rnd2,
            event_id: rnd4
            )
end
 
10.times do |i| 
     rnd1 = rand(1..12)
     rnd2 = rand(0..1)
     #rnd3 = rand(1..5)
      
      
     closedflag_setter = rand(0..1)

     raised = Faker::Date.between(1.years.ago,(Time.now))
      
     closed_array = [(raised + 3.months), nil]
     flag_array = [true, false]
      
     classification_array = ["Near Miss","Occurance"]
      
      
     Event.create(
            reference_number: i+1,
            what_happened: Faker::Lorem.paragraph,
            immediate_actions: Faker::Lorem.paragraph,
            follow_up: Faker::Lorem.paragraph,
            date_raised: raised,
            date_closed: closed_array[closedflag_setter],
            classification: classification_array[rnd2],
            safety_flag: flag_array[rnd2],
            environmental_flag: flag_array[rnd2],
            quality_flag: flag_array[rnd2],
            security_flag: flag_array[rnd2],
            closed_flag: flag_array[closedflag_setter],
            #report_form: open("/Users/sian_ma_jones/Documents/Andrew/Websites/Test-Doc-#{rnd3}.docx"),
            user_id: rnd1,
            )
end

20.times do |i|

    type_arr = ["INUTEC/P","INUTEC/WI","INUTEC/AI","INUTEC/MI"]
    status_arr = ["Issued","Suspended","Withdrawn","In Prep","Awaiting Review","Awaiting Approval","Approved"]

    rnd1 = rand(0..type_arr.length-1)
    rnd2 = rand(0..status_arr.length-1)
    rnd3 = rand(1..12)

    Document.create(
            doc_type: type_arr[rnd1],
            doc_number: i*48,
            issue_number: 6,
            title: Faker::Name.title,
            status: status_arr[rnd2],
            issued_on: Time.now - rnd2.months,
            comments: Faker::Lorem.paragraph,
            #stored_doc: open("/Users/sian_ma_jones/Documents/Andrew/Websites/Test-Doc-1.docx"),
            #stored_pdf: open("/Users/sian_ma_jones/Documents/Andrew/Websites/Test-Pdf-1.pdf"),
            stored_doc: open(File.join(Rails.root, "app/assets/images/Test-Doc-1.docx")),
            stored_pdf: open(File.join(Rails.root, "app/assets/images/Test-Pdf-1.pdf"))
            )

    ApprovalRoute.create(
            document_id: i+1,
            closed_flag: false
        )
        
    Author.create(
            approval_route_id: i+1,
            user_id: rnd3
        )
        
    Reviewer.create(
            approval_route_id: i+1,
            user_id: rnd3
        )
        
    Approver.create(
            approval_route_id: i+1,
            user_id: rnd3
        )
    
end

