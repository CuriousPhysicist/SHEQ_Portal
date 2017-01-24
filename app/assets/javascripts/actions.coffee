# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
    owners = $('#choose-owner').html()
    console.log(owners)
    
    $('#choose-owner').change ->
        alert("Owner changed!")
        newowner_val = $('#choose-owner :selected').val()
        console.log(newowner_val)
        newowner = gon.users[newowner_val-1]
        newowner_name = newowner.first_name+" "+newowner.last_name
        console.log(newowner)
        console.log(newowner_name)
        alert("Change diplayed owner on form?")
        target_dummy = $('#owner_dummy').attr("placeholder", newowner_name)
        console.log(target_dummy)
        alert("Change actual owner on form?")
        target = $('#actions_owner').attr("value", newowner_name)
        console.log(target)