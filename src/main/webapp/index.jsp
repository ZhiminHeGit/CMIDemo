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
  		<button onclick="showHeatMap(454)">香港</button>
  		<button onclick="showHeatMap(455)">澳门</button>
  		<button onclick="showHeatMap(466)">台湾</button>
  		<button onclick="showHeatMap(460)">中国大陆</button>
  		<button onclick="showHeatMap(502)">马来西亚</button>
        <button onclick="showHeatMap(525)">新加坡</button>
        <button onclick="showHeatMap(262)">德国</button>
  	</div>
    <div id="map"></div>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.0/jquery.min.js"></script>
    <script>

      var map, heatmap,marker, circle;;

      function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
          zoom: 13,
          center: {lat: 22.272157, lng: 114.181587},
          mapTypeId: google.maps.MapTypeId.ROADMAP
        });

        showHeatMap(454);

         google.maps.event.addListener(map, "click", function(event) {
            if (marker) {
                marker.setMap(null);
            }
             marker = new google.maps.Marker({
               position: event.latLng,
               map: map
             });
             if (circle) {
                circle.setMap(null);
              }
             // Add circle overlay and bind to marker
             circle = new google.maps.Circle({
               map: map,
               radius: 16093,    // 10 miles in metres
               fillColor: '#AA0000'
             });
             circle.bindTo('center', marker, 'position');
             getSummary();

         });
    }

    function getSummary() {
        var radius = 10;
        var latlng = marker.getPosition();
        var url = "GetSummary.jsp?radius=" + radius + "&lat=" + latlng.lat() + "&lng=" + latlng.lng();
        $.ajax({ url: url,
                 type: 'GET',
                 success: showSummary,
                 error: function(){window.alert("Error calling " + url);}
                });

    }

    function showSummary(data) {
       window.alert(data.trim());
    }

    function showHeatMap(mcc) {

        var url = "GetHeatMapData.jsp?mcc=" + mcc;
        if(heatmap) {
            heatmap.setMap(null);
        }
        if (marker) {
            marker.setMap(null);
        }
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
            // console.log("lan:" + lan + " lng:" + lng + " wt:" + weight + "\n");
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
