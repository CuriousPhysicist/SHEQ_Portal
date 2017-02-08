# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

	$(this).on "turbolinks:load", ->

	    $('#event-number').keyup ->
	        
	        eventnumber = $(this).val()
	        console.log(eventnumber)
	        url1 = $('#update-button').attr("href", "/events/#{eventnumber}/edit")
	        console.log(url1)
	        url4 = $('#remove-button').attr("href", "/events/#{eventnumber}")
	        console.log(url4)
