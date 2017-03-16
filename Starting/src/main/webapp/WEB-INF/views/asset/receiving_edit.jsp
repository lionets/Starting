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
<link rel="stylesheet" href="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/default/easyui.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/icon.css" type="text/css" media="screen" />
<!-- Reset Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
<!-- Main Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen" />
<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
<link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/css/select.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<SCRIPT type=text/javascript>
	
	function openwin1(assetsNo,contractTowerId,productName){
		assetsNo = encodeURI(encodeURI(assetsNo));
		//productName 塔式起重机=1,零部件=2
		productName = productName == '零部件'?'2':'1';
		var url = '<%=basePath %>purchase/truckInit?type=${info.contractType}&agreementNo='+assetsNo+'&contractTowerId='+contractTowerId+'&productName='+productName;
		var resultValue =  window.showModalDialog(url,'',"dialogWidth=1200px;dialogHeight=550px");
		/** if(resultValue == 'y'){
			window.location.href = '<%=basePath %>purchase/init/3';
		}else{
			window.location.reload(true);
		} **/
		window.location.reload(true);
	}
	function openwin(contractTowerId){
		var url = "<%=basePath %>purchase/queryArrivePart?contractTowerId="+contractTowerId;
		var resultValue =  window.showModalDialog(url,'',"dialogWidth=1200px;dialogHeight=550px");
	}
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
        <td >${info.contractNo }</td>
      </tr>
      <tr>
        <th >合同类型</th>
        <td >
        <c:if test="${info.contractType == 1 }">
       	 采购合同
        </c:if>
        <c:if test="${info.contractType == 2 }">
        	外租合同
        </c:if>
        </td>
      </tr>
      <c:if test="${info.contractType == 2}">
                <tr>
                  <th >资产来源</th>
                  <td ><label>${info.customerName }</label></td>
                </tr>
                </c:if>
      <tr>
        <th >备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</th>
        <td >${info.memo }</td>
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
          <th  scope="col">到货地点</th>
          <th  scope="col"></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${list }" var="asset" varStatus="num">
        <tr>
          <td>${num.index +1}</td>
          <td>${asset.productName }</td>
          <td>${asset.createFactryName }</td>
          <td>${asset.towerNo }</td>
          <td>${asset.outFactryNo }</td>
          <td>${asset.towerModel }</td>
          <td>${asset.arrivalPlace } </td>
          <td><div align="center">
          <c:choose>
          <c:when test="${asset.arrivalState == 2 }">
          <a onclick="openwin(${asset.id })">已全部到货</a>
          </c:when>
          <c:otherwise>
          <a onclick="openwin1('${info.contractNo }',${asset.id },'${asset.productName }')">资产到货</a>
          </c:otherwise>
          </c:choose>
          </div>
          </td>
        </tr>
        </c:forEach>
        <tr>
        <td></td>
        <td colspan="10">
        <a class="button_new" href="<%=basePath %>purchase/init/3" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a>
        </td>
        </tr>
		</tbody>
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

</html>