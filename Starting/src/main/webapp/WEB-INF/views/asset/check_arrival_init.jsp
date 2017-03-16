<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath =  path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资产到货审核</title>
<!--                       CSS                       -->
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
<SCRIPT src="<%=basePath %>static/js/jQselect.js" type=text/javascript></SCRIPT>

<script src="<%=basePath %>static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<script type="text/javascript" src='<%=basePath %>static/js/UTIL.js'></script>
<script type="text/javascript">
	function openwin(contractTowerId){
		
		var url = "<%=basePath %>purchase/queryArrivePart?contractTowerId="+contractTowerId;
		if(isEmpty('${find}') == true){
			url = '<%=basePath %>purchase/checkArrivalDetailInit?contractTowerId='+contractTowerId;
		}
		var resultValue =  window.showModalDialog(url,'',"dialogWidth=1200px;dialogHeight=550px");
	}
	function checkArrivalSave(){
		$.messager.confirm('到货资产审核', '您正在审核资产到货，是否确认并继续操作？', function (yes) {
			if(yes == true){
				$.ajax({
					async : false,
					cache : false,
					type : 'POST',
					data :{"contractId":'${info.id }'},
					url :'<%=basePath %>purchase/checkArrivalSave',
					error : function() {// 请求失败处理函数
						$.messager.alert('错误','保存请求提交失败!','error');
					},
					success : function(data){
						if('n' == data){
							$.messager.alert('失败','资产信息审核失败!','error');
						}else{
							$.messager.alert('成功','资产信息审核成功!','info',function(){
								window.location.href = '<%=basePath %>purchase/init/3';
							});
						}
					}
				});
			}
		});
	}
 </script>
</head>
<body>
<jsp:include page="../header-bar.jsp"/>
<div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>
      <c:choose>
      <c:when test="${find != null }">资产信息明细</c:when>
      <c:otherwise>资产到货审核</c:otherwise>
      </c:choose>
      </h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form action="" method="post">
          <table border="0" class="edit-table">
            <tr>
              <th><label ><b>*</b>合同编号</label></th>
              <td width="250px">${info.contractNo }</td>
              <th >合同类型</th>
              <td >
              <c:choose>
              <c:when test="${info.contractType == 1}">采购合同</c:when>
              <c:otherwise>外租合同</c:otherwise>
              </c:choose>
              </td>
            </tr>
            <tr>
              <th >备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</th>
              <td colspan="3">${info.memo }</td>
            </tr>
          </table>
          <p>
            <label> <b> 资产信息</b></label>
          </p>
          <table>
            <thead>
              <tr>
                <th scope="col" class="chebox"></th>
                <th  scope="col">资产名称</th>
                <th  scope="col">生产厂家</th>
                <th  scope="col">规格型号</th>
                <th  scope="col">塔机样式</th>
                <th  scope="col">到货地点</th>
                <th  scope="col">功能</th>
              </tr>
            </thead>
            <tbody>
            <c:forEach items="${towerList }" var="tower" varStatus="num">
              <tr>
                <td>${num.index+1 }</td>
                <td>${tower.productName }</td>
                <td>${tower.createFactryName }</td>
                <td>${tower.specification }</td>
                <td>${tower.towerType }</td>
                <td>${tower.arrivalPlace }</td>
                <td>
                <a onclick="openwin(${tower.id });" class="edit"><img src="<%=basePath %>static/images/icons/view.png" title="审核"/></a>
                </td>
              </tr>
            </c:forEach>
            <tr>
            <td></td>
            <td colspan="6">
            	<a class="button_new" href="<%=basePath %>purchase/init/3" target="_parent" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a>
                <c:if test="${find == null && towerSize > 0}">
                <a onclick="checkArrivalSave();" class="button_new" title="保存"><img src="<%=basePath %>static/images/icons/check_icons.png" class="px18"/></a>
                </c:if>
            </td>
            </tr>
            </tbody>
          </table>
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