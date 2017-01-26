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
            user_id: 1
             )