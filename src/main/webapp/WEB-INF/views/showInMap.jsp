<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=qSpCZZRSvwNt7Wm4ykHFN499"></script>
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
	<div id="r-result">
		<input type="button"  onclick="openHeatmap();" value="显示热力图"/><input type="button"  onclick="closeHeatmap();" value="关闭热力图"/>
	</div>
</body>
</html>
<script type="text/javascript">
    var map = new BMap.Map("container");          // 创建地图实例

    var point = new BMap.Point(104.09, 30.67);//chengdu center
    map.centerAndZoom(point, 13);             // 初始化地图，设置中心点坐标和地图级别
    map.enableScrollWheelZoom(); // 允许滚轮缩放

    var points =[

    {"lng":103.999741,"lat":30.698275,"count":50.0},

    {"lng":103.999428,"lat":30.697388,"count":40.0},

    {"lng":103.999252,"lat":30.696634,"count":50.0},

    {"lng":103.998924,"lat":30.695679,"count":67.0},

    {"lng":103.998505,"lat":30.694296,"count":70.0},

    {"lng":103.997978,"lat":30.69281,"count":95.0},

    {"lng":103.997269,"lat":30.691292,"count":97.0},

    {"lng":103.996483,"lat":30.690046,"count":90.0},

    {"lng":103.99572,"lat":30.688803,"count":98.0},

    {"lng":103.994873,"lat":30.687422,"count":95.0},

    {"lng":103.993637,"lat":30.685429,"count":87.0},

    {"lng":103.993034,"lat":30.684456,"count":56.0},

    {"lng":103.992332,"lat":30.683338,"count":35.0},

    {"lng":103.991989,"lat":30.682793,"count":28.0},

    {"lng":103.990547,"lat":30.680492,"count":12.0},

    {"lng":103.982018,"lat":30.660627,"count":40.0},

    {"lng":103.981888,"lat":30.659704,"count":50.0},

    {"lng":103.981773,"lat":30.658918,"count":60.0},

    {"lng":103.981689,"lat":30.65826,"count":60.0},

    {"lng":103.981544,"lat":30.657227,"count":70.0},

    {"lng":103.981491,"lat":30.656694,"count":70.0},

    {"lng":103.981491,"lat":30.655745,"count":80.0},

    {"lng":103.981575,"lat":30.655012,"count":90.0},

    {"lng":103.98172,"lat":30.654289,"count":100.0},

    {"lng":103.98185,"lat":30.653849,"count":99.0},

    {"lng":103.982018,"lat":30.653389,"count":98.0},

    {"lng":103.982063,"lat":30.653231,"count":90.0},

    {"lng":103.982277,"lat":30.65275,"count":90.0},

    {"lng":103.982536,"lat":30.652262,"count":80.0},

    {"lng":103.982941,"lat":30.651611,"count":55.0},

    {"lng":103.98317,"lat":30.651289,"count":48.0},

    {"lng":103.983414,"lat":30.650969,"count":38.0},

    {"lng":103.983643,"lat":30.650635,"count":28.0},

    {"lng":103.984016,"lat":30.650129,"count":38.0},

    {"lng":103.983902,"lat":30.650297,"count":48.0},

    {"lng":103.984261,"lat":30.649797,"count":38.0},

    {"lng":103.984489,"lat":30.649483,"count":28.0},

    {"lng":103.984718,"lat":30.64917,"count":28.0},

    {"lng":103.984932,"lat":30.648865,"count":23.0},

    {"lng":103.985138,"lat":30.648571,"count":40.0},

    ];

    if(!isSupportCanvas()){
    	alert('热力图目前只支持有canvas支持的浏览器,您所使用的浏览器不能使用热力图功能~')
    }
	//详细的参数,可以查看heatmap.js的文档 https://github.com/pa7/heatmap.js/blob/master/README.md
	//参数说明如下:
	/* visible 热力图是否显示,默认为true
     * opacity 热力的透明度,1-100
     * radius 势力图的每个点的半径大小
     * gradient  {JSON} 热力图的渐变区间 . gradient如下所示
     *	{
			.2:'rgb(0, 255, 255)',
			.5:'rgb(0, 110, 255)',
			.8:'rgb(100, 0, 255)'
		}
		其中 key 表示插值的位置, 0~1.
		    value 为颜色值.
     */
	//heatmapOverlay = new BMapLib.HeatmapOverlay({"radius":20});


		heatmapOverlay = new BMapLib.HeatmapOverlay({"radius":20, "opacity":0, "gradient":{
//			.2:'rgb(0, 255, 255)',	.5:'rgb(0, 110, 255)', .8:'rgb(100, 0, 255)'
	  		//1:'rgb(102, 255, 0)', 	 	.5:'rgb(255, 170, 0)',	  	0:'rgb(255, 0, 0)'
		  		0.45: "rgb(0,0,255)", 0.55: "rgb(0,255,255)", 0.65: "rgb(0,255,0)", 0.9: "yellow", 1.0: "rgb(255,0,0)" //from https://github.com/pa7/heatmap.js/blob/master/README.md

			  //		 0: "rgb(255,0,0)", 0.95: "yellow",  1.0: "rgb(0,255,0)"
		}
		});
	map.addOverlay(heatmapOverlay);
	heatmapOverlay.setDataSet({data:points,max:100});
	//是否显示热力图
    function openHeatmap(){
        heatmapOverlay.show();
    }
	function closeHeatmap(){
        heatmapOverlay.hide();
    }
//	closeHeatmap();
    function setGradient(){
     	/*格式如下所示:
		{
	  		0:'rgb(102, 255, 0)',
	 	 	.5:'rgb(255, 170, 0)',
		  	1:'rgb(255, 0, 0)'
		}*/
     	var gradient = {};
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