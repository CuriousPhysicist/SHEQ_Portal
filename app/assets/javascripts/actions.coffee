# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

    $(this).on "turbolinks:load", ->
    
        $('#choose-owner').change ->
            
            newowner_val = $('#choose-owner :selected').val()
            console.log(newowner_val)
            newowner = gon.users[newowner_val-1]
            newowner_name = newowner.first_name+" "+newowner.last_name
            console.log(newowner)
            console.log(newowner_name)
            target_dummy = $('#owner_dummy').attr("placeholder", newowner_name)
            console.log(target_dummy)
            target_dummy = $('#owner_dummy').attr("value", newowner_name)
            console.log(target_dummy)
            target = $('#actions_owner').attr("value", newowner_name)
            console.log(target)
        
        $('#choose-source').change ->
            
            newsource = $('#choose-source :selected').val()
            console.log(newsource)
            target_dummy = $('#source_dummy').attr("placeholder", newsource)
            console.log(target_dummy)
            
        $('#choose-event').change ->
            
            newevent = $('#choose-event :selected').val()
            console.log(newevent)
            target_dummy = $('#event_dummy').attr("value", newevent)
            console.log(target_dummy)

        $('#action-number').keyup ->
            
            actionnumber = $(this).val()
            console.log(actionnumber)
            url1 = $('#update-button').attr("href", "/actions/#{actionnumber}/edit")
            console.log(url1)
            url4 = $('#remove-button').attr("href", "/actions/#{actionnumber}")
            console.log(url4)
