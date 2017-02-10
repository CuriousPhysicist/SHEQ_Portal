# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    
    $(this).on "turbolinks:load", ->

        $('#user_role').change ->
            
            newrole = $('#user_role :selected').val()
            console.log(newrole)
            roles = []
            roles[0] = "Staff"
            roles[1] ="Line Manager"
            roles[2] ="Senior Manager"
            roles[3] ="Site Manager"
            for i in [1..4] by 1
                if newrole == roles[i-1]
                    level_val = i
                    console.log(roles[i-1])
            target_level = $('#level').attr("value", level_val)
            console.log(target_level)
    
        $('#team').change ->
        
            num_users = gon.user_number
        
            for i in [1..num_users] by 1
                console.log(i)
                $(".user#{i}").attr("style", "")
        
            newteam_val = $('#team :selected').val()
            console.log(newteam_val)
        
            if newteam_val != ""
                for i in [1..num_users] by 1
                    console.log(i)
                    value = $(".user#{i}").attr("value")
                    console.log(value)
                    if value != newteam_val
                        new_attr = $(".user#{i}").attr("style", "display: none")
                        console.log(new_attr)