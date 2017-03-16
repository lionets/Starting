<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%
	String path = request.getContextPath();
	String basePath =  path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>合同调度信息</title>
<link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
<!-- Main Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen" />
<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
<link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/css/select.css" type="text/css" media="screen" />

<script type="text/javascript">
	function openwin1(goodsId){
		var resultValue = window.showModalDialog('<%=basePath %>contractPro/findPartScheme?goodsId='+goodsId+'&flag=${flag}','',"dialogWidth=1200px;dialogHeight=550px");
	}
</script>
</head>
<body>
<jsp:include page="../header-bar.jsp"/>
<div id="main-content">
<div class="clear"></div>
<!-- End .clear -->
<div class="content-box">
<!-- Start Content Box -->
<div class="content-box-header">
  <h3>合同调度信息</h3>
</div> 
  <div class="content-box-content">
<div class="tab-content default-tab" id="tab1">
     <table border="0" class="edit-table">
            <tr>
              <th width="200px"><label>合同编号 </label></th>
              <td width="200px">${proInfo.contractNo }</td>
              <th><label>项目名称 </label></th>
              <td>${proInfo.proName }</td>
          </tr>
        </table>
<table >
<thead>
          <tr>
            <th class="chebox" scope="col">&nbsp;</th>
            <th>塔机型号 </th>
            <th  scope="col" >合同需求</th>
            <th  scope="col" >已调度</th>
            <th  scope="col" >待调度</th>
            <th></th>
          </tr>
      </thead>
          <tbody>
          <c:forEach items="${list }" var="pro" varStatus="num">
          <tr>
		  <td><div align="center">${num.index+1 }</div></td>
		  <td ><div align="center">${pro.towerModel }</div></td>
		  <td><div align="center">1</div></td>
		  <td>
		  <c:choose>
		  <c:when test="${pro.dispatchStatus == '1'}">
		  <div align="center">1</div>
		  </c:when>
		  <c:otherwise><div align="center">0</div></c:otherwise>
		  </c:choose>
		  </td>
		  <td>
		  <c:choose>
		  <c:when test="${pro.dispatchStatus == '1'}">
		  <div align="center">0</div>
		  </c:when>
		  <c:otherwise><div align="center">1</div></c:otherwise>
		  </c:choose>
		  </td>
		  <td><div align="center"><a onclick="openwin1(${pro.id })" class="edit"><img src="<%=basePath %>static/images/icons/view.png" alt="View" /></a></div></td>
	      </tr>
          </c:forEach>
        </tbody>				
    </table>
    <p><b>已调度</b></p>
   <table>
   <thead>
          <tr>
            <th class="chebox" scope="col">&nbsp;</th>
            <th>塔机型号</th>
            <th>塔机编号</th>
            <th>出厂编号</th>
            <th  scope="col" >起租日期</th>
            <th  scope="col" >进度</th>
            <th  scope="col" >停租日期</th>
            <th  scope="col" >&nbsp;</th>
          </tr>
      </thead>
         <tbody> 
         <c:forEach items="${list }" var="pro" varStatus="num">
         <c:if test="${pro.createNo != null}">
         <tr>
		  <td><div align="center">${num.index+1 }</div></td>
		  <td ><div align="center">${pro.towerModel }</div></td>
		  <td ><div align="center">${pro.towerNo }</div></td>
		  <td ><div align="center">${pro.createNo }</div></td>
		  <td><div align="center"><fmt:formatDate pattern="yyyy-MM-dd" value="${pro.rentTime}" type="both" /></div></td>
		  <td><div align="center"></div></td>
		  <td><div align="center"><fmt:formatDate pattern="yyyy-MM-dd" value="${pro.stopRentTime}" type="both" /></div></td>
		  <td></td>
	     </tr>
	     </c:if>
         </c:forEach>
        </tbody>
        <tr>
        <td></td>
        <td colspan="7"><a class="button_new" href="<%=basePath %>contractPro/init/${flag}" title="close"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a></td></tr>
        			
    </table>

      </div>
    </div>
  </div>
</div>
</body>
</html>