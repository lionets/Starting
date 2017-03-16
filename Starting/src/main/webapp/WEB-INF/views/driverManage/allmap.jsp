<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath =  path + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=kOTXraW2Ff9FPlYxLkqPsyX2"></script>
<%-- 		<link rel="stylesheet" type="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/default/easyui.css">
		<link rel="stylesheet" type="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/icon.css">
		<link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
		<!-- Main Stylesheet -->
		<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
		<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
		<SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></SCRIPT>
		<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script> --%>
		
		
<link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
<!-- Main Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/css/top.css" type="text/css" media="screen" />
<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
<link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/facebox.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery.wysiwyg.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery.datePicker.js"></script>
<script type="text/javascript"src="http://code.jquery.com/jquery-1.8.1.min.js"></script>
		
		
		
	<style type="text/css">
		body, html{width:100%;height: 100%;margin:0;}
		#allmap{width: 100%;height: 100%;margin:0;display:inline-block;}
		#r-result{width:100%; font-size:14px;}
	</style>
	<script type="text/javascript">
	var jsonString = '<%=request.getAttribute("jsonString")%>';
	var json = $.parseJSON(jsonString);
		$(function(){
			if("${show}" == "true"){
				$("#hiddenDiv").show();
				//单击获取点击的经纬度
				map.addEventListener("click",function(e){
					map.clearOverlays(); 
					var gpsPoint = new BMap.Point(e.point.lng,e.point.lat);
					BMap.Convertor.translate(gpsPoint,0,function(new_point){
						var marker = new BMap.Marker(new_point);  // 创建标注
						map.addOverlay(marker);              // 将标注添加到地图中
						map.panTo(new_point);
						$("#langitude").val(e.point.lng);
						$("#latitude").val(e.point.lat);
						//添加备注信息
						addTips(new_point,marker);
					})

				});
			}
		})
	</script>
	<title>塔机位置</title>
</head>
<body>
<jsp:include page="../header-bar.jsp"/>
	<div id="allmap"></div>
</body>
</html>
<script type="text/javascript">
//"${langitude}","${latitude}"
	// 百度地图API功能
	var map = new BMap.Map("allmap");
	for(var i=0; i<json.length; i++){
		var tower = json[i];
		var new_point = new BMap.Point(tower.latitude,tower.longitude);
		var myIcon = new BMap.Icon("<%=basePath %>static/images/towerpic.gif",new BMap.Size(155,90),{
			anchor:new BMap.Size(23,48)
		});
		var marker = new BMap.Marker(new_point,{icon:myIcon});  // 创建标注
		map.addOverlay(marker); 
		addTips(new_point,marker,tower.tower_no);
	}
	
	// 用经纬度设置地图中心点
	function theLocation(){
		map.centerAndZoom(new BMap.Point(116.404269,39.916042),7);
		map.addControl(new BMap.NavigationControl());        // 添加平移缩放控件
		map.addControl(new BMap.ScaleControl());             // 添加比例尺控件
		map.addControl(new BMap.OverviewMapControl());       //添加缩略地图控件
		map.enableScrollWheelZoom(true);
	}
	theLocation();
	
	
	function addTips(point,marker,towerNo){
		//添加提示信息
		var geoc = new BMap.Geocoder();  
		geoc.getLocation(point, function(rs){
		var addComp = rs.addressComponents;
		var address = addComp.province+addComp.city +  addComp.district + addComp.street + addComp.streetNumber;
		var opts = {
				  width : 200,     // 信息窗口宽度
				  height: 40,     // 信息窗口高度
				  title : "塔机"+towerNo+"位置" // 信息窗口标题
				}
		var infoWindow = new BMap.InfoWindow(address, opts);
		marker.addEventListener("mouseover", function(){map.openInfoWindow(infoWindow,point)});
		})
	}
	
/* 	// 百度地图API功能
	var map = new BMap.Map("allmap");
	var point = new BMap.Point(116.404, 39.915);
	map.centerAndZoom(point, 15);
	
	//创建小狐狸
	var pt = new BMap.Point(116.417, 39.909);
	var myIcon = new BMap.Icon("http://developer.baidu.com/map/jsdemo/img/fox.gif", new BMap.Size(300,157));
	var marker2 = new BMap.Marker(pt,{icon:myIcon});  // 创建标注
	map.addOverlay(marker2);  */
	
	
	
</script>
