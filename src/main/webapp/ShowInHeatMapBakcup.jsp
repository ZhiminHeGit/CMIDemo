<%@ page language="java" contentType="text/html; charset=EUC-CN"
    pageEncoding="EUC-CN"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Heatmaps</title>
    <style>
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #map {
        height: 100%;
      }
      #floating-panel {
        position: absolute;
        top: 10px;
        left: 25%;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        padding-left: 10px;
      }
      #floating-panel {
        background-color: #fff;
        border: 1px solid #999;
        left: 25%;
        padding: 5px;
        position: absolute;
        top: 10px;
        z-index: 5;
      }
    </style>
  </head>

  <body>
    <div id="floating-panel">
      <button onclick="toggleHeatmap()">Toggle Heatmap</button>
      <button onclick="changeGradient()">Change gradient</button>
      <button onclick="changeRadius()">Change radius</button>
      <button onclick="changeOpacity()">Change opacity</button>
    </div>
    <div id="map"></div>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.0/jquery.min.js"></script>
    <script>

      // This example requires the Visualization library. Include the libraries=visualization
      // parameter when you first load the API. For example:
      // <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=visualization">

      var map, heatmap;

      function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
          zoom: 13,
          center: {lat: 22.272157, lng: 114.181587},
          mapTypeId: google.maps.MapTypeId.ROADMAP
        });
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
     // var url = "SearchBaseStations.jsp?radius=" + radius + "&lat=" + latlng.lat() + "&lng=" + latlng.lng();
     var url = "GetHeatMapData.jsp" ;
      infowindow.close();
      if(heatmap != null)
        heatmap.setMap(null);
$.ajax({ url: url,
         type: 'GET',
         success: loadDataToHeatMap,
         error: function(){window.alert("Error calling " + url);}
        });
    }

    function loadDataToHeatMap(data) {
    //window.alert("Successfully retrieved heatmap data from server. Click OK to display heatmap");
        var temp = new Array();
        temp = data.split(",");
        var tempLen = temp.length;
        var pointsArray = new Array();
        var bounds = new google.maps.LatLngBounds();
        for(i = 0; i < tempLen; i+=3){
            var lan = parseFloat(temp[i]);
            var lng = parseFloat(temp[i+1]);
            var weight = parseInt(temp[i+2]);
            console.log("lan:" + lan + " lng:" + lng + " wt:" + weight + "\n");
            // pointsArray.push({location: new google.maps.LatLng(lan, lng), weight: weight});
            pointsArray.push(new google.maps.LatLng(lan, lng));
            bounds.extend(new google.maps.LatLng(lan, lng));
        }

        map.fitBounds(bounds);
        console.log("pointsArray size: " + pointsArray.length);
                heatmap = new google.maps.visualization.HeatmapLayer({
                  data: pointsArray,
                  map: map
                });
    }

    function findUsers2() {
      var radius = escape(document.getElementById("radius").value);
      var latlng = marker.getPosition();

      var url = "SearchBaseStations.jsp?radius=" + radius + "&lat=" + latlng.lat() + "&lng=" + latlng.lng();
        pointsArray = new Array();
        pointsArray.push(latlng);
        infowindow.close();
        $.get(url, function(data) {
        var temp = new Array();
        temp = data.split(",");
        var tempLen = temp.length;
        var j = 0;
        for(i = 0; i < tempLen; i+=2){
            var lan = parseFloat(temp[i]);
            var lng = parseFloat(temp[i+1]);
            pointsArray.push(new google.maps.LatLng(lan, lng));
        }
            }, false);
        heatmap = new google.maps.visualization.HeatmapLayer({
          data: pointsArray,
          map: map
        });
    }
      function toggleHeatmap() {
        heatmap.setMap(heatmap.getMap() ? null : map);
      }

      function changeGradient() {
        var gradient = [
          'rgba(0, 255, 255, 0)',
          'rgba(0, 255, 255, 1)',
          'rgba(0, 191, 255, 1)',
          'rgba(0, 127, 255, 1)',
          'rgba(0, 63, 255, 1)',
          'rgba(0, 0, 255, 1)',
          'rgba(0, 0, 223, 1)',
          'rgba(0, 0, 191, 1)',
          'rgba(0, 0, 159, 1)',
          'rgba(0, 0, 127, 1)',
          'rgba(63, 0, 91, 1)',
          'rgba(127, 0, 63, 1)',
          'rgba(191, 0, 31, 1)',
          'rgba(255, 0, 0, 1)'
        ]
        heatmap.set('gradient', heatmap.get('gradient') ? null : gradient);
      }

      function changeRadius() {
        heatmap.set('radius', heatmap.get('radius') ? null : 20);
      }

      function changeOpacity() {
        heatmap.set('opacity', heatmap.get('opacity') ? null : 0.2);
      }

      // Heatmap data
      function getPoints() {
        return [
new google.maps.LatLng(22.278295,114.183452),
new google.maps.LatLng(22.278759,114.183406),
new google.maps.LatLng(22.285109,114.190538),
new google.maps.LatLng(22.27931,114.184053),
new google.maps.LatLng(22.281668,114.20087),
new google.maps.LatLng(22.281478,114.162984),
new google.maps.LatLng(22.279461,114.162718),
new google.maps.LatLng(22.279549,114.162165),
new google.maps.LatLng(22.283317,114.158451),
new google.maps.LatLng(22.283348,114.158288),
new google.maps.LatLng(22.283803,114.158544)
        ];
      }
    </script>
    <script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB_GOOW6aZsUtDxaJ3yyUPis8M1QG6WqXk&libraries=visualization&callback=initMap">
    </script>
  </body>
</html>
