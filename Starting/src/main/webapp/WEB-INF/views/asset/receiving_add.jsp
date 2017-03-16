<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%
	String path = request.getContextPath();
	String basePath =  path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>leap系统</title>
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
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>资产到货确认</h3>
  </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form action="" method="post">
          <table border="0" class="edit-table">
            <tr>
              <th><label ><b>*</b>合同编号</label></th>
        <td ><input name="contractNo" type="text" readonly value="${info.contractNo }"></td>
      </tr>
      <tr>
        <th >合同类型</th>
        <td >
        <c:if test="${info.contractType == 1 }">
        <input name="Input2" type="text" readonly value="采购合同">
        </c:if>
        <c:if test="${info.contractType == 2 }">
        <input name="Input2" type="text" readonly value="外租合同">
        </c:if>
        </td>
      </tr>
      <tr>
        <th >所属公司</th>
        <td ><input name="Input2" type="text" readonly value="${info.createFactryName }" ></td>
      </tr>
      <tr>
        <th >备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</th>
        <td >
        <textarea readonly="readonly" >${info.memo }</textarea>
        </td>
      </tr>
    </table>
    <div id="search_result2">
       <p>  <label> <b> 资产信息</b></label></p>
      <table>
            <thead>
        <tr>
          <th scope="col" class="chebox"></th>
          <th  scope="col">资产名称</th>
          <th  scope="col">生产厂家</th>
          <th  scope="col">塔机编号</th>
          <th  scope="col">出厂编号</th>
          <th  scope="col">规格型号</th>
          <th  scope="col">合同数量</th>
          <th  scope="col">已到货数量</th>
          <th  scope="col">未到货数量</th>
          <th  scope="col">到货地点</th>
          <th  scope="col">资产信息确认</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list }" var="asset" varStatus="num">
        <tr>
          <td>${num.index }</td>
          <td>${asset.assetsName }</td>
          <td>${asset.createFactryName }</td>
          <td>${asset.towerNo }</td>
          <td>${asset.outFactryNo }</td>
          <td>${asset.towerModel }</td>
          <td>${asset.contractNum }</td>
          <td>${asset.arrivalNum }</td>
          <td>${asset.contractNum - asset.arrivalNum }</td>
          <td>${asset.arriveAddress }</td>
          <td><a onClick="openwin1(${asset.assetsNo })">资产确认</a></td>
        </tr>
        </c:forEach>
		</tbody>
            <tfoot>
              <tr>
                <td colspan="16"><div class="bulk-actions align-left">
                    <label>共有塔机：<b>${listSize}</b>台</label>
                  </div>
                  <!-- <div class="pagination"> <a href="#" title="First Page">|&lt;</a><a href="#" title="Previous Page">&lt;</a> <a href="#" class="number current" title="1">1</a> <a href="#" class="number" title="2">2</a> <a href="#" class="number" title="3">3</a> <a href="#" class="number" title="4">4</a> <a href="#" title="Next Page">&gt;</a><a href="#" title="Last Page">&gt;|</a> </div> -->
                </td>
              </tr>
            </tfoot>
          <tr>
               <td colspan="2">&nbsp;</td>
              <td colspan="9"><a class="button_new" href="#" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a> <a class="button_new" href="receiving_query.html" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a> </td>
            </tr>
          </table>
          </div>
        </form>
      </div>
      <!-- End #tab1 -->
    </div>
    <!-- End .content-box-content -->
  </div>
  <!-- End .content-box -->
  <div class="clear"></div>
</div>
<!-- End #main-content -->
<div id="footer">
<small>達豐中國 地址：上海市长宁区天山西路1068号联强国际D栋4楼 电话:+86 21 60825373 </small><br /><br />
 <small>系统开发 Copyright © 2015 上海乔罗网络科技有限公司 </small> </div>
<!-- End #footer -->
</body>

<script type="text/javascript">
function openwin1(agreementNo){
	window.open('<%=basePath %>purchase/truckInit?agreementNo='+agreementNo,'newwindow','height=900,width=1000,top=10,left=100,toolbar=0,menubar=0,scrollbar=yes,resizable=no,location=no,status=no')
}
 </script>
</html>