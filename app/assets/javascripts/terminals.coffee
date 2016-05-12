# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'ready page:load', () ->
  print_lat_lng()

  $('#lat').on 'change', () ->
    print_lat_lng()
  
  $('#lng').on 'change', () ->
    print_lat_lng()

print_lat_lng = () ->
  $('#map')
    .html "<p>Latitude: #{ $('#lat').val() }, <br />Longitude: #{ $('#lng').val() } </p>"

