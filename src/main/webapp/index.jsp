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
    #summary {
          position: absolute;
          top: 10%;
          left: 85%;
          z-index: 5;
          background-color: #fff;
          padding: 5px;
          border: 1px solid #999;
          text-align: center;
          font-family: 'Roboto','sans-serif';
          font-size: xx-small;
          line-height: 30px;
          padding-left: 10px;
          background-color: #fff;
        }
      #map-chooser {
        position: absolute;
        top:  50%;
        left: 5px;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
        text-align: center;
        font-family: 'Roboto','sans-serif';
        line-height: 30px;
        background-color: #fff;
       }

       #hour-slider {
        position: absolute;
        top:  5px;
        left: 10%;
        z-index: 5;


       }

       #radius-slider {
           position: absolute;
           top:  5px;
           left: 50%;
           z-index: 5;
        }

        #chartdiv {
            position: absolute;
            //top: 10%;
            // left: 85%;
            z-index: 6;
            background-color: #fff;
            padding: 5px;
            border: 1px solid #999;
            text-align: center;
            font-family: 'Roboto','sans-serif';
            font-size: xx-small;
            line-height: 30px;
            padding-left: 10px;
            background-color: rgba(0,0,0,0.5);
        }

    </style>
  </head>

  <body>
    <div id = "summary"> </div>
  	<div id="map-chooser">
  		<button onclick="updateLocation(454)">香港</button><br>
  		<button onclick="updateLocation(455)">澳门</button><br>
  		<button onclick="updateLocation(466)">台湾</button><br>
  		<button onclick="updateLocation(460)">中国大陆</button><br>
  		<button onclick="updateLocation(502)">马来西亚</button><br>
        <button onclick="updateLocation(525)">新加坡</button><br>
    </div>
    <div id = "hour-slider" >
        <span id = "time">时间10月1日0时</span>
        <input  type="range" min="0" max="167" value="0" step="1" onchange="updateHour(this.value)" />
    </div>
    <div id = "radius-slider" >
         <span id = "radius">1公里</span>
         <input  type="range" min="1" max="50" value="0" step="1" value = "1" onchange="updateRadius(this.value)" />
    </div>


    <script type="text/javascript">
    var map, heatmap, marker, circle, mcc = 454, absolute_hour = 0, radius =1;
    var SummaryElement = document.getElementById("summary");

    function updateRadius(newRadius) {
        document.getElementById("radius").innerHTML = newRadius + "公里";
        radius = newRadius;
        if (circle) {
            createCircle();
        }
    }

    function updateHour(newHour)
    {
    	absolute_hour = newHour;
    	hour = newHour % 24;
    	document.getElementById("time").innerHTML = "时间10月"
    	    + Math.floor(newHour / 24 + 1) + "日" + hour + "时";
    	showHeatMap();
        getSummary();

    }
    </script>
    <div id="map"></div>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.0/jquery.min.js"></script>
    <script>
      function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
          zoom: 13,
          center: {lat: 22.272157, lng: 114.181587},
          mapTypeId: google.maps.MapTypeId.ROADMAP
        });

        showHeatMap();
        clearSummary();

         google.maps.event.addListener(map, "click", function(event) {
            if (marker) {
                marker.setMap(null);
            }
             marker = new google.maps.Marker({
               position: event.latLng,
               map: map
             });
             createCircle();

         });
    }


    function createCircle() {
    if (circle) {
                    circle.setMap(null);
                 }

       // Add circle overlay and bind to marker
                 circle = new google.maps.Circle({
                   map: map,
                   radius: radius * 1000,    // 10 km
                   fillColor: '#0000FF',
                   strokeOpacity: 0,
                   fillOpacity: 0.2
                 });
                 circle.bindTo('center', marker, 'position');
                 google.maps.event.addListener(circle, "click", function(event) {
                    clearSummary();
                    marker.setMap(null);
                    circle.setMap(null);
                    circle = null;
                    marker = null;
                  })
                 getSummary();
        }

    function clearSummary() {
       SummaryElement.style.visibility = 'hidden';
     }
    function getSummary() {
        if (marker) {
            var latlng = marker.getPosition();
            var url = "GetSummary.jsp?radius=" + radius + "&lat=" + latlng.lat() + "&lng=" + latlng.lng() +
            "&absolute_hour=" + absolute_hour;

            clearSummary();
            $.ajax({ url: url,
                 type: 'GET',
                 success: showSummary,
                 error: function(){window.alert("Error calling " + url);}
            });
       }

    }

    function showSummary(data) {
    // data.split("=")[0] 人数
    // e.g
    // 人数:1497
    //
    // data.split("=") holds three JSON strings.
    // use JSON.parse() to convert to var
    // e.g var1 regionData = JSON.parse(data.split("=")[1])
    // data.split("=")[1]
    // e.g
    // [
    //   {"Item": "广东","Count":590},
    //   {"Item": "福建","Count":152},
    //   {"Item": "浙江","Count":144},
    //   {"Item": "上海","Count":135},
    //   {"Item": "江苏","Count":88},
    //   {"Item": "Other","Count":388}
    //   ]
    //
    //  data.split("=")[2]
    // [
    // {"Item": "苹果","Count":892},
    // {"Item": "三星","Count":100},
    // {"Item": "华为","Count":49},
    // {"Item": "小米","Count":31},
    // {"Item": "荣耀","Count":21},
    // {"Item": "Other","Count":67}
    // ]
    // data.split("=")[3]
    // [
    // {"Item": "微信","Count":1022},
    // {"Item": "苹果推送","Count":399},
    // {"Item": "腾讯图片","Count":363},
    // {"Item": "手机QQ","Count":229},
    // {"Item": "淘宝","Count":202},
    // {"Item": "Other","Count":3522}
    // ]


        SummaryElement.innerHTML = data.split("=")[1];
        SummaryElement.style.visibility = 'visible';
    }

    function updateLocation(newMcc) {

        mcc = newMcc;
        if (circle) {
            circle.setMap(null);
            circle = null;
        }
        if (marker) {
           marker.setMap(null);
           marker = null;
        }
        clearSummary();
        showHeatMap();
    }
    function showHeatMap() {

        var url = "GetHeatMapData.jsp?mcc=" + mcc + "&absolute_hour=" + absolute_hour;
        if(heatmap) {
            heatmap.setMap(null);
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

    <!-- Styles -->
    <style>
    #chartdiv {
      width: 100%;
      height: 500px;
    }
    </style>

    </body>
</html>
