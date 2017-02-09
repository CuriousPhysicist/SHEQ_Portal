# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

    $(this).on "turbolinks:load", ->
    
        $('#choose-data').change ->
            
            newdata_val = $('#choose-data :selected').val()
            console.log(newdata_val)
            url1 = $('#data-button').attr("href", "/#{newdata_val}/upload")
            console.log(url1)
