<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
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
<link rel="stylesheet" href="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/default/easyui.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/icon.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery.datePicker.js"></script>
<script src="<%=basePath %>static/js/jQselect.js" type="text/javascript"></script>
<script src="<%=basePath %>static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src='<%=basePath %>static/js/UTIL.js'></script>
<style type="text/css">
#puPagination table{width: auto;height:0px;}
#puPagination tr td th{height:auto;padding: 0px;border:0px;text-align:center;}
</style>
<SCRIPT type=text/javascript>
	function openwin(id,model) {
		model = encodeURI(encodeURI(model));
		var url = "<%=basePath %>purchase/queryPartInit?towerId="+id;
		var resultValue =  window.showModalDialog(url,'',"dialogWidth=1200px;dialogHeight=550px");
	}
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
      <h3>
      <c:choose>
      <c:when test="${info.contractType == 1}">查看资产采购合同</c:when>
      <c:otherwise>查看资产外租合同</c:otherwise>
      </c:choose>
      </h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <div class="search-actions">
            <div class="search-condition-show">
              <table class="edit-table">
                <tr>
                  <th>合同编号</th>
                  <td ><label>${info.contractNo }</label></td>
                  <th >签订日期</th>
                  <td ><label><fmt:formatDate pattern="yyyy-MM-dd" value="${info.signTime}" type="both" /></label></td>
                </tr>
                <c:if test="${info.contractType == 2}">
                <tr>
                  <th >资产来源</th>
                  <td ><label>${info.customerName }</label></td>
                  <td></td>
                  <td></td>
                </tr>
                </c:if>
                <tr>
                  <th>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</th>
                  <td colspan="3">${info.memo }</td>
                </tr>
              </table>
            </div>
        <p>  <b> 资产信息</b></p>
          <table>
            <thead>
              <tr>
                <th scope="col" class="chebox"></th>
                <th  scope="col">资产名称</th>
                <th  scope="col">厂家</th>
                <th  scope="col">规格型号</th>
                <th  scope="col">塔机样式</th>
                <th  scope="col">到货地点</th>
                <th  scope="col">功能</th>
              </tr>
            </thead>
            <tbody>
            <c:forEach items="${towerList }" var="info" varStatus="num">
              <tr>
                <td>${num.index+1 }</td>
                <td>${info.productName }</td>
                <td>${info.createFactryName }</td>
                <td>${info.specification }</td>
                <td>${info.towerType }</td>
                <td>${info.arrivalPlace }</td>
                <td>
                <a onclick="openwin(${info.id },'${info.specification }');" class="edit"><img src="<%=basePath %>static/images/icons/view.png" title="审核"/></a>
                </td>
              </tr>
            </c:forEach>
            <tr>
                <td ></td> 
                <td colspan="6">
                <a class="button_new" href="<%=basePath %>purchase/init/${flag}" title="close"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        
      </div>
    </div>
  </div>
</div>
</body>
</html>