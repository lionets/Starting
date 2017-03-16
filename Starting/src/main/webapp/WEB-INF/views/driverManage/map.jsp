<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = path + "/";
%>
<!DOCTYPE HTML>
<html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>塔机动态管理系统</title>
<!--                       CSS                       -->
<!-- Reset Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
<!-- Main Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen" />
<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
<link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/css/select.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
    <SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></SCRIPT>
    <script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
    
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=kOTXraW2Ff9FPlYxLkqPsyX2"></script>
	<script type="text/javascript" src="http://developer.baidu.com/map/jsdemo/demo/convertor.js"></script>
<style type="text/css">
#main-content .edit-table th {
text-align: right;
width: 60px;
}
</style>
<SCRIPT type=text/javascript>
$(function(){
	if("${show}" == "true"){
		$("#hiddenDiv").show();
		//单击获取点击的经纬度
		map.addEventListener("click",function(e){
			map.clearOverlays(); 
			var new_point = new BMap.Point(e.point.lng,e.point.lat);
			var marker = new BMap.Marker(new_point);  // 创建标注
			map.addOverlay(marker);              // 将标注添加到地图中
			map.panTo(new_point);
			$("#langitude").val(e.point.lng);
			$("#latitude").val(e.point.lat);
			//添加备注信息
			addTips(new_point,marker);
		});
	}
	$("#submitButton").on("click",function(){
		tatongMethod.confirm("提示","确定要提交吗!",function(){
			$("form").submit();
		});
	})
	
})
	</SCRIPT>
</head>
<body>
<jsp:include page="../header-bar.jsp"/>
<div id="main-content">
  <div class="clear"></div>
  <!-- End .clear -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>设备位置</h3>
    </div>
    <div class="content-box-content" style="padding:0px;">
    <div style="float:right;overflow:auto; width:21%;">
        <p>
          <label> <b> 设备信息</b></label>
        </p><form action="<%=basePath %>driverManage/updateGpsLastTime" method="post">
        <table border="0" class="edit-table">
          <tr >
            <th scope="row" >编　　号:</th>
            <td>${tower.tower_no }</td>
          </tr>
          <tr>
            <th scope="row">型　　号:</th>
            <td>${tower.tower_model }</td>
          </tr>
          <tr>
            <th scope="row">类　　别:</th>
            <td>${tower.tower_class }</td>
          </tr>
          <tr>
            <th scope="row">状　　态:</th>
            <td>
            <script type="text/javascript">
			 	var state =  "${tower.tower_state }";
			 	var stateStr = "";
	               switch (state) {
	                   case "1":
	                       stateStr = "闲置"
	                       break;
	                   case "2":
	                       stateStr = "未启用"
	                       break;
	                   case "3":
	                       stateStr = "在使用"
	                       break;
	                   case "4":
	                       stateStr = "冬停"
	                       break;
	                   case "5":
	                       stateStr = "托管"
	                       break;
	               }
			 	document.write(stateStr);
			 </script>
			</td>
          </tr>
          <tr>
            <th scope="row">项目名称:</th>
            <td>${tower.pro_name }</td>
          </tr>
          <c:if test='${show=="true" }'>
         <tr>
		<th scope="row">经&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;度:</th>
      	<td ><input id="langitude" name="langitude" type="text"   value="${langitude }"/></td>
      </tr>
		<tr>
		<th scope="row">维&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;度:</th>
      	<td ><input id="latitude" name="latitude" type="text"   value="${latitude }"/></td>
      </tr>
      <tr>
      <td>&nbsp;</td>
      <td>
      <a class="button_new" id="submitButton" href="javascript:void(0)" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a>
      </td></tr>
      </c:if>
      
        </table>
       <div id="hiddenDiv"  style="display: none" >
			<input type="hidden" name="id" value="${id}">
			<input type="hidden" name="towerid" value="${towerid}">
			<input type="hidden" name="towerNo" value="${towerNo}">
			<input type="hidden" name="province" id="province" value="">
			<input type="hidden" name="area" id="area" value="">
			<input type="hidden" name="simNumber"  value="${simNumber }">
			<input type="hidden" name="towerManagerId"  value="${towerManagerId }">
			<input type="hidden" name="show" value="true">
			<input type="hidden" name="method" value="update">
			<input type="hidden" name="sqlId" value="cn.com.newglobe.tathong.common.dao.write.ComTowerInfoWriteDao.updateGpsLastTimeById">
		</form>
	</div>
	</div>
        
      </div>
      <div  id="allmap" style="margin: 0 0 0 0px; height:700px; width:78%;">
       </div>
      <br class="clearfloat" />
    </div>
  </div>
</body>
</html>
<script type="text/javascript">
//"${langitude}","${latitude}"
	// 百度地图API功能
	var map = new BMap.Map("allmap");
	// 用经纬度设置地图中心点
	function theLocation(){
		//alert("${langitude}");
		map.centerAndZoom(new BMap.Point(116.404269,39.916042),11);
		map.addControl(new BMap.NavigationControl());        // 添加平移缩放控件
		map.addControl(new BMap.ScaleControl());             // 添加比例尺控件
		map.addControl(new BMap.OverviewMapControl());       //添加缩略地图控件
		map.enableScrollWheelZoom(true);
 		if("${langitude}" != "" && "${latitude}" != ""){
			map.clearOverlays(); 
			var gpsPoint = new BMap.Point("${langitude}","${latitude}");
			
			BMap.Convertor.translate(gpsPoint,0,function(baiduPoint){
				var myIcon = new BMap.Icon("<%=basePath %>static/images/towerpic.gif",new BMap.Size(155,90),{
					anchor:new BMap.Size(23,48)
				});
				var marker = new BMap.Marker(baiduPoint,{icon:myIcon});  // 创建标注
				map.addOverlay(marker);              // 将标注添加到地图中
				map.centerAndZoom(baiduPoint);
				map.panTo(baiduPoint);
				addTips(baiduPoint,marker);
			});

		}else{
			tatongMethod.alert("提示","该设备无有效经纬度！");
		} 
	}
	theLocation();
	
	
	function addTips(point,marker){
		//添加提示信息
		var geoc = new BMap.Geocoder();  
		geoc.getLocation(point, function(rs){
		var addComp = rs.addressComponents;
		var address = addComp.province+addComp.city +  addComp.district + addComp.street + addComp.streetNumber;
		alterAreaProvince(addComp.province);
		var opts = {
				  width : 200,     // 信息窗口宽度
				  height: 40,     // 信息窗口高度
				  title : "塔机${towerNo}位置" // 信息窗口标题
				}
		var infoWindow = new BMap.InfoWindow(address, opts);
		marker.addEventListener("mouseover", function(){map.openInfoWindow(infoWindow,point)});
		})
	}
	
	
	function alterAreaProvince(province){
		var area = "";
		if("北京市、天津市、河北省、山西省、内蒙古自治区".indexOf(province) !=-1){
	        area="华北区";
         }
         else if("辽宁省、吉林省、黑龙江省".indexOf(province) !=-1){
        	area="东北区";
         }
         else if("上海市、江苏省、浙江省、山东省、安徽省、台湾省".indexOf(province) !=-1){
        	 area="华东区";
         }
         else if("广东省、广西壮族自治区、海南省、香港特别行政区、澳门特别行政区".indexOf(province) !=-1){
        	 area="华南区";
         }
         else if("陕西省、甘肃省、青海省、宁夏回族自治区、新疆维吾尔自治区".indexOf(province) !=-1){
        	 area="西北区";
         }
         else if("四川省、云南省、贵州省、重庆市、西藏自治区、广西壮族自治区".indexOf(province) !=-1){
        	 area="西南区";
         }else{
        	 area="华中区";
         }
		$("#province").val(province);
		$("#area").val(area);
	}
	
</script>
