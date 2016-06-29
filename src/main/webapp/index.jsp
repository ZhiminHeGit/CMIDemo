<%@ page language="java" contentType="text/html; charset=EUC-CN"
    pageEncoding="EUC-CN"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-CN">
<title>Hong Kong Jockey Club Happy Valley Racecourse</title>
    <style>
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #map-canvas {
        height: 100%;
        width: 100%;
      }
    </style>
<script
    src="https://maps.googleapis.com/maps/api/js?key=YOUR-KEY-HERE"></script>
<script>
var map;
function initialize() {
  var myLatlng = {lat: 22.272157, lng: 114.181587};

  var mapOptions = {
    zoom: 14,
    center: new google.maps.LatLng(22.272157, 114.181587)
  };
  var map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);

      map.addListener('click', function(e) {
                placeMarkerAndPanTo(e.latLng, map);
              });
}

      function placeMarkerAndPanTo(latLng, map) {
        var marker = new google.maps.Marker({
          position: latLng,
          map: map
        });
        map.panTo(latLng);

        var infowindow = new google.maps.InfoWindow({
                  content: 'Use this as the new center. Lat: ' + latLng.lat() + ' Lng: ' + latLng.lng(),
                  position: latLng
                });
        infowindow.open(map);

        setTimeout( function() {document.location = "ShowResult.jsp";}, 1500);
      }

function sleep(milliseconds) {
  var start = new Date().getTime();
  for (var i = 0; i < 1e7; i++) {
    if ((new Date().getTime() - start) > milliseconds){
      break;
    }
  }
}
google.maps.event.addDomListener(window, 'load', initialize);
</script>
</head>
<body>
 <div id="map-canvas"></div>
</body>
</html>