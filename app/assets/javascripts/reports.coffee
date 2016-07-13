# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#

$(document).on 'ready page:load', () ->
  # $('#res').append '<p>this should be our JSON data</p>'
  $.ajax(url: '/annually-per-month-per-game/2010', type: 'GET', dataType: 'json').done (data)->
    $('#res').append JSON.stringify(data)
