2<%@ page language="java" contentType="text/html; charset=EUC-CN"
    pageEncoding="EUC-CN"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-CN">
<title>Query Based On User Location</title>
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
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB_GOOW6aZsUtDxaJ3yyUPis8M1QG6WqXk">
</script>

<script>
var marker;
var infowindow;
function initialize() {
  var myLatlng = {lat: 22.272157, lng: 114.181587};

  var mapOptions = {
    zoom: 14,
    center: myLatlng
  };
  var map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);

var html = "Radius: <input id='radius' name='radius' placeholder='Radius' type='text'> Miles" + "<input type='button' value='Find Users' onclick='findUsers()'/>";
    infowindow = new google.maps.InfoWindow({
     content: html
    });

        google.maps.event.addListener(map, "click", function(event) {
            marker = new google.maps.Marker({
              position: event.latLng,
              map: map
            });
            google.maps.event.addListener(marker, "click", function() {
              infowindow.open(map, marker);
            });
        });
}

    function findUsers() {
      var radius = escape(document.getElementById("radius").value);
      var latlng = marker.getPosition();

      var url = "ShowResult.jsp?radius=" + radius + "&lat=" + latlng.lat() + "&lng=" + latlng.lng();
      document.location = url;
    }

google.maps.event.addDomListener(window, 'load', initialize);
</script>
</head>
<body id="body" style="overflow:hidden;">
 <div id="map-canvas"></div>
</body>
</html>