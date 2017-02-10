User.create!(first_name:  "Andrew",
             last_name: "Hampson",
             email: "andrewhampson6@gmail.com",
             password:              "Password",
             password_confirmation: "Password",
             team: "SHEQ",
             role: "Senior Manager",
             approval_type: "All Types",
             level: 3,
             admin: true
             )
              
User.create!(first_name:  "Bob",
             last_name: "Builder",
             email: "example@email.com",
             password:              "Password",
             password_confirmation: "Password",
             team: "Engineering",
             role: "Senior Manager",
             level: 3
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
            team: teams[rnd1],
            role: roles[level_num-1],
            level: level_num
      )
 end

30.times do |i| 
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
 
 30.times do |i| 
      rnd1 = rand(1..12)
      rnd2 = rand(0..1)
      
      
      closedflag_setter = rand(0..1)

      raised = Faker::Date.between(1.years.ago,(Time.now))
      
      closed_array = [(raised + 3.months), nil]
      flag_array = [true, false]
      
      classification_array = ["Near Miss","Occurance"]
      
      
      Event.create(
            reference_number: i+1,
            what_happened: Faker::Lorem.paragraph,
            immediate_actions: Faker::Lorem.paragraph,
            date_raised: raised,
            date_closed: closed_array[closedflag_setter],
            classification: classification_array[rnd2],
            safety_flag: flag_array[rnd2],
            environmental_flag: flag_array[rnd2],
            quality_flag: flag_array[rnd2],
            security_flag: flag_array[rnd2],
            closed_flag: flag_array[closedflag_setter],
            user_id: rnd1,
            )
 end