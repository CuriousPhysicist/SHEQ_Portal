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
            target_dummy = $('#author-dummy').attr("value", newauthor_name)
            console.log(target_dummy)
            target = $('#approval_routes_author_name').attr("value", newauthor_name)
            console.log(target)

        $('#choose-reviewer').change ->
            
            newreviewer_val = $('#choose-reviewer :selected').val()
            console.log(newreviewer_val)
            newreviewer = gon.users[newreviewer_val-1]
            newreviewer_name = newreviewer.first_name+" "+newreviewer.last_name
            console.log(newreviewer)
            console.log(newreviewer_name)
            target_dummy = $('#reviewer-dummy').attr("value", newreviewer_name)
            console.log(target_dummy)
            target = $('#approval_routes_reviewer_name').attr("value", newreviewer_name)
            console.log(target)

        $('#choose-approver').change ->
            
            newapprover_val = $('#choose-approver :selected').val()
            console.log(newapprover_val)
            newapprover = gon.users[newapprover_val-1]
            newapprover_name = newapprover.first_name+" "+newapprover.last_name
            console.log(newapprover)
            console.log(newapprover_name)
            target_dummy = $('#approver-dummy').attr("value", newapprover_name)
            console.log(target_dummy)
            target = $('#approval_routes_approver_name').attr("value", newapprover_name)
            console.log(target)
            