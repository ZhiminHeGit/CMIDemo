<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
  		<button onclick="hongkong()">香港</button>
  		<button onclick="macau()">澳门</button>
  		<button onclick="taiwan()">台湾</button>
  		<button onclick="china()">中国大陆</button>
  	</div>
    <div id="map"></div>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.0/jquery.min.js"></script>
    <script>

      // This example requires the Visualization library. Include the libraries=visualization
      // parameter when you first load the API. For example:
      // <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=visualization">

      var map, heatmap;
      var markers = [];

        function hongkong() {
          var url = "GetHeatMapData.jsp?mcc=454";
        }
        function macau() {
          var url = "GetHeatMapData.jsp?mcc=455";
        }
        function taiwan() {
          var url = "GetHeatMapData.jsp?mcc=466";
        }
        function china() {
          var url = "GetHeatMapData.jsp?mcc=460";
        }
        // Adds a marker to the map and push to the array.
        function addMarker(location) {
          var marker = new google.maps.Marker({
            position: location,
            map: map
          });
          markers.push(marker);
        }

        // Sets the map on all markers in the array.
        function setMapOnAll(map) {
          for (var i = 0; i < markers.length; i++) {
            markers[i].setMap(map);
          }
        }

        // Removes the markers from the map, but keeps them in the array.
        function clearMarkers() {
          setMapOnAll(null);
        }

        // Shows any markers currently in the array.
        function showMarkers() {
          setMapOnAll(map);
        }

        // Deletes all markers in the array by removing references to them.
        function deleteMarkers() {
          clearMarkers();
          markers = [];
        }
      function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
          zoom: 13,
          center: {lat: 22.272157, lng: 114.181587},
          mapTypeId: google.maps.MapTypeId.ROADMAP
        });

        showHeatMap();

        var html = "Radius: <input id='radius' name='radius' placeholder='Radius' type='text'> Miles" + "<input type='button' value='Find Users' onclick='getSummary()'/>";
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
                       markers.push(marker);
                     });
                 });

      }

    function getSummary() {
        //  var radius = escape(document.getElementById("radius").value);
        //  var latlng = marker.getPosition();
        // var url = "SearchBaseStations.jsp?radius=" + radius + "&lat=" + latlng.lat() + "&lng=" + latlng.lng();
    }

    function showHeatMap() {

     var url = "GetHeatMapData.jsp" ;
     // infowindow.close();
      if(heatmap != null)
        heatmap.setMap(null);
        deleteMarkers();
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

    </script>
    <script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB_GOOW6aZsUtDxaJ3yyUPis8M1QG6WqXk&libraries=visualization&callback=initMap">
    </script>
  </body>
</html>
