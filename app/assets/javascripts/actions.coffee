# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    
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
    
    $('#action-number').keyup ->
        
        actionnumber = $(this).val()
        console.log(actionnumber)
        url1 = $('#update-button').attr("href", "/actions/#{actionnumber}/edit")
        console.log(url1)
        url4 = $('#remove-button').attr("href", "/actions/#{actionnumber}")
        console.log(url4)
