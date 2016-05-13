# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# lat = $('#lat').val()
# lng = $('#lng').val()

lat = lng = null

pos = map = marker = infowin = null

$(document).on 'ready page:load', () ->
  lat = $('#lat').val()
  lng = $('#lng').val()

  pos = new google.maps.LatLng lat, lng
  map = new google.maps.Map $('#map')[0],
              center: pos,
              zoom: 17,
              disableDefaultUI: true,
              disableDoubleClickZoom: true,
              mapTypeId: google.maps.MapTypeId.ROADMAP

  marker = new google.maps.Marker
                position: pos, map: map, title: $('#name').val(),
                draggable: true,
                animation: google.maps.Animation.DROP
  infowin = new google.maps.InfoWindow content: """
                    <address>
                      <strong>#{ $('#name').val() }</strong><br />
                      #{ $('#address').val() }<br />
                      #{ $('#city').val() }<br />
                      #{ $('#tel').val() }<br />
                    </address>
                  """

  $('#lat').on 'keypress', () =>
    lat = $('#lat').val()
    marker.setPosition new google.maps.LatLng(lat, lng)
    map.panTo new google.maps.LatLng(lat, lng)
  
  $('#lng').on 'keypress', () =>
    lng = $('#lng').val()
    marker.setPosition new google.maps.LatLng(lat, lng)
    map.panTo new google.maps.LatLng(lat, lng)

  google.maps.event.addListener marker, 'click', ()-> infowin.open(map, marker)

  google.maps.event.addListener marker, 'dragend', ()=>
    console.log 'dragged to: ',
      { lat: marker.getPosition().lat(), lng: marker.getPosition().lng() }
    $('#lat').val marker.getPosition().lat()
    $('#lng').val marker.getPosition().lng()
