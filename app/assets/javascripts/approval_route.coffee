# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

    $(this).on "turbolinks:load", ->

    	$('#choose-author').change ->
            
            newauthor_val = $('#choose-author :selected').val()
            console.log(newauthor_val)
            newauthor = gon.users[newauthor_val-1]
            newauthor_name = newauthor.first_name+" "+newauthor.last_name
            console.log(newauthor)
            console.log(newauthor_name)
            target_dummy = $('#author_dummy').attr("placeholder", newauthor_name)
            console.log(target_dummy)
            