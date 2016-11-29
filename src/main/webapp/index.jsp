<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>国际漫游大数据</title>
    <style>
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }

      #topmenu{
         position: absolute;
         width:100%;
        left: 0px;
        top: 0px;
        z-index: 5;
        padding: 10px;
        background-color:rgba(10,102,200,0.6);
      }

      .logo{
        display:inline-block;
      }


      .title{
        display:inline-block;
        font-size:30px;
        font-weight:100;
        color:#ffffff;
        vertical-align: top;
        margin:5px 0px 0px 20px;
      }

      #map {
        height: 100%;
      }

        #piechart_1 {
                position: absolute;
                top: 25%;
                right : 5%;
                width: 25%;

                height: 25%;
                z-index: 6;
                background-color: #fff;
                padding: 5px;
                border: 1px solid #999;
                text-align: center;
                font-family: 'Roboto','sans-serif';
                font-size: xx-small;
                line-height: 30px;
                padding-left: 10px;
                background-color: rgba(255,255,255,0.5);
              }

         #piechart_2 {
                 position: absolute;
                 top: 50%;
                 right : 5%;
                 width: 25%;

                 height: 25%;
                 z-index: 6;
                 padding: 5px;
                 border: 1px solid #999;
                 text-align: center;
                 font-family: 'Roboto','sans-serif';
                 font-size: xx-small;
                 line-height: 30px;
                 padding-left: 10px;
                  background-color: rgba(255,255,255,0.5);

          }

         #piechart_3 {
                 position: absolute;
                 width: 25%;
                 height: 25%;
                 top: 75%;
                 right : 5%;
                 z-index: 6;
                 padding: 5px;
                 border: 1px solid #999;
                 text-align: center;
                 font-family: 'Roboto','sans-serif';
                 font-size: xx-small;
                 line-height: 30px;
                 padding-left: 10px;
                  background-color: rgba(255,255,255,0.5);

         }
    #summary {
          position: absolute;
          bottom: 75%;
          right : 5%;
          z-index: 5;
          padding: 5px;
          border: 1px solid #999;
          text-align: center;
          font-family: 'Roboto','sans-serif';
          line-height: 30px;
          padding-left: 10px;
           background-color: rgba(255,255,255,0.5);

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
        right: 5%;
        z-index: 5;
       }

       #radius-slider {
           position: absolute;
           top:  40px;
           right: 5%;
           z-index: 5;
        }
        #bottombox{
        background-color:rgba(255,255,255,0.8);
        position: absolute;
        bottom:0px;
        left:0px;
        padding:4px;
        font-size:12px;
        padding:2px 10px;

        }
    </style>

   <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
   <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.0/jquery.min.js"></script>

   <script type="text/javascript">


      var map, heatmap, marker, circle, mcc = 454, old_mcc , absolute_hour = 0, radius =1;
      var chartReady = 0;
      google.charts.load("current", {packages:["corechart"]});
        google.charts.setOnLoadCallback(setChartReady);


        function setChartReady() {
            chartReady = 1;
        }

        function drawChart(chartid, title, dataString) {
         if (chartReady == 1) {
            console.log(dataString);
            var data = google.visualization.arrayToDataTable(JSON.parse(dataString));

            var options = {
                title: title,
                backgroundColor: 'transparent',
                is3D: true,
            };

            var chart = new google.visualization.PieChart(document.getElementById(chartid));
            chart.draw(data, options);
            document.getElementById(chartid).style.visibility = 'visible';
          }
        }

    function updateRadius(newRadius) {
        if (newRadius <10) newRadius = "0" + newRadius;
        document.getElementById("radius").innerHTML = "覆盖半径:" + newRadius + "公里  ";
        radius = newRadius;
        if (circle) {
            createCircle();
        }
    }

    function updateHour(newHour)
    {
    	absolute_hour = newHour;
    	hour = newHour % 24;
    	if (hour < 10) hour = "0" + hour;
    	document.getElementById("time").innerHTML = "时间:10月"
    	    + Math.floor(newHour / 24 + 1) + "日" + hour + "时";
    	showHeatMap();
        getSummary();

    }
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
        document.getElementById('summary').style.visibility = 'hidden';
        document.getElementById('piechart_1').style.visibility = 'hidden';
        document.getElementById('piechart_2').style.visibility = 'hidden';
        document.getElementById('piechart_3').style.visibility = 'hidden';
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
        document.getElementById("summary").innerHTML = data.split("=")[0];
        document.getElementById("summary").style.visibility = 'visible';
        drawChart("piechart_1", "来源省市/地区Home Province/Regions", data.split("=")[1]);
        drawChart("piechart_2", "手机型号Device Model", data.split("=")[2]);
        drawChart("piechart_3", "用户行为User Behavior", data.split("=")[3]);
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
        if ( mcc != old_mcc) {
            old_mcc = mcc;
            map.fitBounds(bounds);
        }
        console.log("pointsArray size: " + pointsArray.length);
                heatmap = new google.maps.visualization.HeatmapLayer({
                  data: pointsArray,
                  map: map,
                });
    }

    </script>
    <script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB_GOOW6aZsUtDxaJ3yyUPis8M1QG6WqXk&libraries=visualization&callback=initMap">
    </script>
     </head>
      <body>
       <div id="topmenu" class="ui-front ui-widget- content ">
         <img class="logo" src="img/cmlogo-white.png" width="150" >
         <div class="title">国际漫游大数据</div>
       </div>

       <div id = "hour-slider" >
                    <span id = "time" style="color:white">时间:10月1日00时</span>
                    <input  type="range" min="0" max="167" value="0" step="1" onchange="updateHour(this.value)" />
                </div>
                <div id = "radius-slider" >
                     <span id = "radius" style="color:white">覆盖半径:01公里</span>
                     <input  type="range" min="1" max="50" value="0" step="1" value = "1" onchange="updateRadius(this.value)" />
                </div>
       <div id="piechart_1" ></div>
       <div id="piechart_2" ></div>
       <div id="piechart_3" ></div>


         <div id = "summary"> </div>
       	<div id="map-chooser">
       		<button onclick="updateLocation(454)">香港</button><br>
       		<button onclick="updateLocation(455)">澳门</button><br>
       		<button onclick="updateLocation(466)">台湾</button><br>
       		<button onclick="updateLocation(460)">中国大陆</button><br>
       		<button onclick="updateLocation(502)">马来西亚</button><br>
             <button onclick="updateLocation(525)">新加坡</button><br>
         </div>


          <div id="map"></div>
          <div id="bottombox" class="ui-front ui-widget-content">
             中国移动国际公司大数据团队出品<BR>中移研究院美研所专家支持
          </div>
    </body>
</html>
