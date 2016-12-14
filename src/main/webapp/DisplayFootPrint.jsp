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
    <div id="map"></div>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.0/jquery.min.js"></script>
    <script>
      var map, heatmap;
      function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
          zoom: 13,
          center: {lat: 22.272157, lng: 114.181587},
          mapTypeId: google.maps.MapTypeId.ROADMAP
        });
        getUserFootprints();
      }
    function getUserFootprints() {
    //window.alert("Please wait until all data is loaded");
    var imsi = getParameterByName("imsi", window.location.href);
      var url = "GetUserFootprints.jsp?imsi=" + imsi;
      if(heatmap != null)
        heatmap.setMap(null);
$.ajax({ url: url,
         type: 'GET',
         success: loadDataToHeatMap,
         error: function(){window.alert("Error calling " + url);}
        });
    }
    function loadDataToHeatMap(data) {
        var temp = new Array();
        temp = data.split(",");
        var tempLen = temp.length;
        //window.alert("Successfully retrieved heatmap data from server. Received " + tempLen + " records. Click OK to display heatmap");
        var pointsArray = new Array();
        var bounds = new google.maps.LatLngBounds();
        for(i = 0; i < tempLen; i+=2){
            var lng = parseFloat(temp[i]);
            var lan = parseFloat(temp[i+1]);
            pointsArray.push(new google.maps.LatLng(lan, lng));
            bounds.extend(new google.maps.LatLng(lan, lng));
        }

        map.fitBounds(bounds);

        console.log("pointsArray size: " + pointsArray.length);
                heatmap = new google.maps.visualization.HeatmapLayer({
                  data: pointsArray,
                  map: map
                });
                heatmap.set('radius', 20);
                heatmap.set('gradient', null);
    }
    function getParameterByName(name, url) {
        if (!url) url = window.location.href;
        name = name.replace(/[\[\]]/g, "\\$&");
        var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
            results = regex.exec(url);
        if (!results) return null;
        if (!results[2]) return '';
        return decodeURIComponent(results[2].replace(/\+/g, " "));
    }
    </script>
    <script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB_GOOW6aZsUtDxaJ3yyUPis8M1QG6WqXk&libraries=visualization&callback=initMap">
    </script>
  </body>
</html>