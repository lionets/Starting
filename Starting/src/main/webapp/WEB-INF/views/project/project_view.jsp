<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath =  path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
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
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/facebox.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery.wysiwyg.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery.datePicker.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery.date.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/calendar.js"></script>
<SCRIPT src="<%=basePath %>static/js/jquery.js" type=text/javascript></SCRIPT>
<SCRIPT src="<%=basePath %>static/js/jQselect.js" type=text/javascript></SCRIPT>
<SCRIPT type=text/javascript>
	$(document).ready(function() {
		$("#a").selectbox();
		$("#b").selectbox();
		$("#c").selectbox();
		$("#d").selectbox();
		$("#e").selectbox();
		$("#f").selectbox();
	});
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
  <h3>项目调度信息</h3></div> 
  <div class="content-box-content">
<div class="tab-content default-tab" id="tab1">

     <p><b>塔机信息</b></p>
<table >
<thead>
          <tr>
            <th class="chebox" scope="col">项次</th>
            <th>塔机型号 </th>
            <th  scope="col" >合同需求塔机数量</th>
            <th  scope="col" >已到达现场塔机数量</th>
            <th  scope="col" >待调度塔机数量</th>
          </tr>
      </thead>
          <tbody>
		<tr>
		  <td>1</td>
		  <td >STT293</td>
		  <td>4</td>
		  <td>3</td>
		  <td>1</td>
	    </tr>
        <tr>
          <td>2</td>
          <td >ST70/30</td>
          <td>1</td>
          <td>1</td>
          <td>0</td>
        </tr>
        <tr>
          <td>3</td>
          <td >M125</td>
          <td>1</td>
          <td>1</td>
          <td>0</td>
        </tr></tbody>				
    </table>
    <p><b>已到达现场塔机信息</b></p>
   <table>
   <thead>
          <tr>
            <th class="chebox" scope="col">项次</th>
            <th>合同编号</th>
            <th>项目名称</th>
            <th>塔机编号</th>
            <th>塔机型号 </th>
            <th  scope="col" >起租日期</th>
            <th  scope="col" >停租日期</th>
          </tr>
      </thead>
         <tbody> 
		<tr>
		  <td>1</td>
		  <td >41301</td>
		  <td >项目HXTHtest2</td>
		  <td >41301001</td>
		  <td >STT293</td>
		  <td>2011-03-31</td>
		  <td>2011-06-31</td>
	    </tr>	
	    <tr>
        <th></th>
        <td colspan="6"><div class="caozuobc"> <a class="button_new" href="#" onclick="window.close()" title="close"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a></div></td>
        </tr>
        </tbody>	
    </table>
      </div>
    </div>
  </div>
</div>
</body>
</html>