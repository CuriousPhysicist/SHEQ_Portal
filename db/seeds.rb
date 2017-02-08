User.create!(first_name:  "Andrew",
             last_name: "Hampson",
             email: "andrewhampson6@gmail.com",
             password:              "Password",
             password_confirmation: "Password",
             team: "SHEQ",
             role: "Senior Manager",
             approval_type: "All Types",
             admin: true
             )
              
User.create!(first_name:  "Bob",
             last_name: "Builder",
             email: "example@email.com",
             password:              "Password",
             password_confirmation: "Password",
             team: "Engineering",
             role: "Senior Manager"
             )

10.times do |i|
    rnd1 = rand(0..6)
    teams = ["SHEQ","Operations","Analytical","Maintenance","Projects","Engineering","Management"]
    
      User.create(
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            email: "example#{i}@email.com",
            password:              "Password",
            password_confirmation: "Password",
            team: teams[rnd1]
      )
 end

30.times do |i| 
      rnd1 = rand(1..11)
      rnd2 = rand(1..11)
      rnd3 = rand(0..2)
      rnd4 = rand(1..30)
      
      target = Faker::Date.between(2.years.ago,(Time.now + 6.months))
      
      type = ["A","B","C"]
      
      Action.create(
            reference_number: i+1,
            initiator:"#{User.find(rnd1).first_name} #{User.find(rnd1).last_name}",
            owner: "#{User.find(rnd2).first_name} #{User.find(rnd2).last_name}",
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
      rnd1 = rand(1..11)
      rnd2 = rand(0..1)
      
      
      raised = Faker::Date.between(1.years.ago,(Time.now))
      
      closed_array = [(raised + 3.months), nil]
      
      classification_array = ["Near Miss","Occurance"]
      
      
      Event.create(
            reference_number: i+1,
            what_happened: Faker::Lorem.paragraph,
            immediate_actions: Faker::Lorem.paragraph,
            date_raised: raised,
            date_closed: closed_array[rnd2],
            classification: classification_array[rnd2],
            closed_flag: false,
            user_id: rnd1,
            )
 end