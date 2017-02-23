# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

    $(this).on "turbolinks:load", ->
        
        $('#actions_description').keyup ->
            
	        description = $('#actions_description').val()
	        console.log(description)
	        owner = $('#actions_owner').val()
	        console.log(owner)
	        date = $('#actions_date_target').val()
	        console.log(date)
	        if description != "" && owner != "" && date != ""
	            $('#submit-action-button').attr("style", "")
	        else
	            $('#submit-action-button').attr("style", "display: none")
	   
	    $('#actions_date_target').change ->
            
	        description = $('#actions_description').val()
	        console.log(description)
	        owner = $('#actions_owner').val()
	        console.log(owner)
	        date = $('#actions_date_target').val()
	        console.log(date)
	        if description != "" && owner != "" && date != ""
	            $('#submit-action-button').attr("style", "")
	        else
	            $('#submit-action-button').attr("style", "display: none")
	   
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
            # check if action can be submitted
            
        
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
            if actionnumber > gon.lastaction.reference_number
                $(this).val('')
                url1 = $('#update-button').attr("href", "/actions//edit")
                console.log(url1)
                url4 = $('#remove-button').attr("href", "/actions/")
                console.log(url4)
            else
		action_id = gon.actions.where('reference_number = ?', actionnumber)
                url1 = $('#update-button').attr("href", "/actions/#{action_id}/edit")
                console.log(url1)
                url4 = $('#remove-button').attr("href", "/actions/#{action_id}")
                console.log(url4)

        $('#updatetext').keyup ->
            
            updatetext = $(this).val()
            console.log(updatetext)
            text = $('#updatetext').attr("value", updatetext)
            console.log(text)
