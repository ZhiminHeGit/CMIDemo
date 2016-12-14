<%@ page language="java" contentType="text/html; charset=EUC-CN"
    pageEncoding="EUC-CN"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=345fedc51231c3e7a91f433bee1cf276"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/library/Heatmap/2.0/src/Heatmap_min.js"></script>
    <title>热力图功能示例</title>
    <style type="text/css">
		ul,li{list-style: none;margin:0;padding:0;float:left;}
		html{height:100%}
		body{height:100%;margin:0px;padding:0px;font-family:"微软雅黑";}
		#container{height:100%;width:100%;}
		#r-result{width:100%;}
    </style>
  </head>

  <body>
    <div id="container"></div>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.0/jquery.min.js"></script>
    <script type="text/javascript">
    var map = new BMap.Map("container");          // 创建地图实例

    var point = new BMap.Point(114.1, 22.4);
    map.centerAndZoom(point, 12);             // 初始化地图，设置中心点坐标和地图级别
    map.enableScrollWheelZoom(); // 允许滚轮缩放
    map.addEventListener('click', function (e) {getUserFootprints();});
	var heatmapOverlay = new BMapLib.HeatmapOverlay({"radius":20});
	map.addOverlay(heatmapOverlay);
	var dataPoints = [];
	heatmapOverlay.setDataSet({data:dataPoints,max:1});
	heatmapOverlay.hide();
    function getUserFootprints() {
    //window.alert("Please wait until all data is loaded");
    //var imsi = escape(document.getElementById("imsi").value);
      var url = "GetUserFootprints.jsp?imsi=460001405210214";
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

        var points = [];
        for(i = 0; i < tempLen; i+=2){
            var lng = parseFloat(temp[i]);
            var lat = parseFloat(temp[i+1]);
            points.push( {"lng":lng,"lat":lat,"count":Math.random()*500});
        }

	heatmapOverlay = new BMapLib.HeatmapOverlay({"radius":20, "opacity":0, "gradient":{0.15: "rgb(144,209,212)", 0.45: "rgb(144,186,212)", 0.65: "rgb(144,160,212)", 0.85: "rgb(144,149,212)", 1.0: "rgb(212,144,161)"}});
	//heatmapOverlay = new BMapLib.HeatmapOverlay({"radius":20, "opacity":0, "gradient":{0.15: "rgb(255,255,32)", 0.45: "rgb(255,255,16)", 0.65: "rgb(255,255,8)", 0.85: "rgb(255,255,4)", 1.0: "rgb(255,255,2)"}});
	map.addOverlay(heatmapOverlay);
	heatmapOverlay.setDataSet({data:points,max:1000});
	setGradient();
	heatmapOverlay.show();
    }

	//是否显示热力图
    function openHeatmap(){
        heatmapOverlay.show();
    }
	function closeHeatmap(){
        heatmapOverlay.hide();
    }
    function setGradient(){

     	var gradient = {
                       	  		0:'rgb(0, 0, 2)',
                       	 	 	.5:'rgb(0, 0, 16)',
                       		  	1:'rgb(0, 0, 32)'
                       		};
     	var colors = document.querySelectorAll("input[type='color']");
     	colors = [].slice.call(colors,0);
     	colors.forEach(function(ele){
			gradient[ele.getAttribute("data-key")] = ele.value;
     	});
        heatmapOverlay.setOptions({"gradient":gradient});
    }
	//判断浏览区是否支持canvas
    function isSupportCanvas(){
        var elem = document.createElement('canvas');
        return !!(elem.getContext && elem.getContext('2d'));
    }
    </script>
  </body>
</html>