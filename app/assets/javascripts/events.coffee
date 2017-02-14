# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

	$(this).on "turbolinks:load", ->
		
		$('#events_guest_name').keyup ->
	       
	       guestname = ""
	       whathappend = ""
	       immediateactions = ""
	       
	       guestname = $('#events_guest_name').val()
	       immediateactions = $('#events_immediate_actions').val()
	       whathappend = $('#events_what_happened').val()
	       if whathappend != "" && immediateactions != "" && guestname != ""
	           $('#submit-button').attr("style", "")
	       else
	           $('#submit-button').attr("style", "display: none")
	    
	   $('#events_what_happened').keyup ->
	       
	       whathappend = ""
	       immediateactions = ""
	       
	       guestname = $('#events_guest_name').val()
	       immediateactions = $('#events_immediate_actions').val()
	       whathappend = $('#events_what_happened').val()
	       if whathappend != "" && immediateactions != "" && guestname != ""
	           $('#submit-button').attr("style", "")
	       else
	           $('#submit-button').attr("style", "display: none")
	            
	   $('#events_immediate_actions').keyup ->
	       
	       whathappend = ""
	       immediateactions = ""
	        
	       guestname = $('#events_guest_name').val()
	       immediateactions = $('#events_immediate_actions').val()
	       whathappend = $('#events_what_happened').val()
	       if immediateactions != "" && whathappend != "" && guestname != ""
	           $('#submit-button').attr("style", "")
	       else
	           $('#submit-button').attr("style", "display: none")

	    $('#event-number').keyup ->
	        
	        eventnumber = $(this).val()
	        console.log(eventnumber)
	        if eventnumber > gon.lastevent.id
                $(this).val('')
                url1 = $('#update-button').attr("href", "/events//edit")
                console.log(url1)
                url4 = $('#remove-button').attr("href", "/events/")
                console.log(url4)
            else
                url1 = $('#update-button').attr("href", "/events/#{eventnumber}/edit")
                console.log(url1)
                url4 = $('#remove-button').attr("href", "/events/#{eventnumber}")
                console.log(url4)
                
        