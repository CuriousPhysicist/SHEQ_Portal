User.create!(first_name:  "Andrew",
             last_name: "Hampson",
             email: "andrewhampson6@gmail.com",
             password:              "Password",
             password_confirmation: "Password",
             team: "SHEQ",
             role: "Senior Manager",
             admin: true
             )
              
User.create!(first_name:  "Bob",
             last_name: "Builder",
             email: "example@email.com",
             password:              "Password",
             password_confirmation: "Password"
             )
             
Action.create!(refernce_number: 1,
            initiator: "Andrew Hampson",
            owner: "Andrew Hampson",
            type_ABC: "B",
            description: "Test action - do something",
            open_flag: true,
            user_id: 1
             )

10.times do |i|
      User.create(
            first_name: Faker::Name.first_name,
            last_name: Faker::Name.last_name,
            email: "example#{i}@email.com",
            password:              "Password",
            password_confirmation: "Password",
      )
 end

30.times do |i| 
      j = rand(1..11)
      Action.create(
            refernce_number: i+1,
            initiator: "Andrew Hampson",
            owner: "#{User.find(j).first_name} #{User.find(j).last_name}",
            description: Faker::Lorem.paragraph,
            open_flag: Faker::Boolean,
            user_id: j
            )
 end