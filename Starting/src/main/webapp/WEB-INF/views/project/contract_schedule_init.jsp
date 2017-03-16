<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath =  path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>合同信息编辑</title>
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
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<script type="text/javascript" src='<%=basePath %>static/js/UTIL.js'></script>
<SCRIPT type=text/javascript>
	function onGoodsScheme(){
		$.messager.confirm('合同设备需求方案审核', '合同设备需求方案审核之后不能再编辑方案内容，你确定继续吗？', function (yes) {
			if(yes == true){
				$.ajax({
					async : false,
					cache : false,
					type : 'POST',
					data :{"contractId":'${con.id }'},
					url :'<%=basePath %>contractPro/checkScheme',
					error : function() {// 请求失败处理函数
						$.messager.alert('错误','保存请求提交失败!','error');
					},
					success : function(data){
						if('n' == data){
							$.messager.alert('失败','合同设备需求方案审核失败!','error');
						}else{
							$.messager.alert('成功','合同设备需求方案审核成功!','info',function(){
								window.location.href = '<%=basePath %>contractPro/init/4';
							});
						}
					}
				});
			}
		});
	}
	
	function openwin1(goodsId){
		var resultValue = window.showModalDialog('<%=basePath %>contractPro/findPartScheme?goodsId='+goodsId,'',"dialogWidth=1200px;dialogHeight=550px");
	}
	function openwinToSchedule(goodsId){
		var resultValue = window.showModalDialog('<%=basePath %>contractPro/queryGoodsScheduleInit?goodsId='+goodsId,'',"dialogWidth=1200px;dialogHeight=550px");
	}
	</SCRIPT>
</head><body>
<jsp:include page="../header-bar.jsp"/>
<div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>合同信息编辑</h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form id="conProForm" method="post">
          <p>
            <label> <b>客户信息</b></label> 
          </p>
          <table border="0" class="edit-table">
            <tr>
              <th scope="row">承租单位</th>
              <td width="300px">
              ${cust.customerCnName}
               </td>
              <th>客户编号</th>
              <td>${cust.customerCode}</td>
              <th></th>
              <td></td>
            </tr>
            <tr >
              <th>联系人</th>
              <td>${cust.cpCnName}</td>
              <th>联系人手机</th>
              <td>${cust.phone}</td>
              <th>邮箱</th>
              <td>${cust.email}</td>
            </tr>
          </table>
          <p>
            <label> <b>合同信息</b></label> 
          </p>
          <table border="0" class="edit-table">
            <tr>
              <th scope="row"><label><b>*</b>合同编号 </label></th>
              <td width="300px">
              <input id="id" name="id" type="hidden" value="${con.id }"/>
              ${con.contractNo}
              </td>
              <th>合同状态</th>
              <td>
              <c:choose>
              <c:when test="${con.contractStatus == 0 }">待签核</c:when>
              <c:when test="${con.contractStatus == 1 }">待启动</c:when>
              <c:when test="${con.contractStatus == 2 }">已启动</c:when>
              <c:when test="${con.contractStatus == 3 }">已关闭</c:when>
              <c:otherwise>未知状态</c:otherwise>
              </c:choose>
              </td>
            </tr>
            <tr>
              <th>所属公司</th>
              <td>
              ${con.proCompanyName}
              </td>
              <th>管理单位</th>
              <td>
              ${con.proManagedeptName}
              </td>
            </tr>
            <tr >
              <th>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</th>
              <td colspan="5">${con.remark}</td>
            </tr>
          </table>
          <p>
            <label> <b>项目信息</b></label> 
          </p>
          <table border="0" class="edit-table">
            <tr>
              <th scope="row"><label><b>*</b>项目名称 </label></th>
              <td width="300px">
              ${pro.proName}
              </td>
              <th><label><b>*</b>项目简称</label></th>
              <td>
              ${pro.proShortName}
              </td>
              <th></th>
              <td></td>
            </tr>
            <tr >
              <th><label><b>*</b>项目地点</label></th>
              <td colspan="5">
              ${pro.proArea}
              &nbsp;&nbsp;&nbsp;
              ${pro.proProvince}
              &nbsp;&nbsp;&nbsp;
              ${pro.proCity}
              &nbsp;&nbsp;&nbsp;
              ${pro.proAddress}
              </td>
            </tr>
            <tr>
              <th>项目类型</th>
              <td>
              ${pro.proType}
              </td>
              <th>项目状态</th>
              <td>
              <c:choose>
              <c:when test="${pro.proStatus == 0 }">待启动</c:when>
              <c:when test="${pro.proStatus == 0 }">已启动</c:when>
              <c:when test="${pro.proStatus == 0 }">已关闭</c:when>
              <c:otherwise>未知状态</c:otherwise>
              </c:choose>
              </td>
            </tr>
          </table>
          
          <p>
            <label> <b> 设备需求信息</b></label>
          </p>
            <div style="overflow: auto;HEIGHT: 150px;">
          <table>
            <thead>
              <tr>
                <th scope="col" class="chebox">项次</th>
                <th  scope="col">资产名称</th>
                <th  scope="col">塔机型号</th>
                <th  scope="col">塔机编号</th>
                <th  scope="col">出厂编号</th>
                <th  scope="col">安装方式</th>
                <th  scope="col">大臂长度(米)</th>
                <th  scope="col">方案高度(米)</th>
                <th  scope="col" class="picture1" style="width: 50px;">操作</th>
              </tr>
            </thead>
            <tbody id="cloneNodeTbody">
              <c:forEach items="${list }" var="device" varStatus="num">
              <tr>
              <td>${num.index+1 }<input type="hidden" value="${device.id }"/></td>
              <td>${device.productName }</td>
              <td>${device.towerModel }</td>
              <td>${device.towerNo }</td>
              <td>${device.createNo }</td>
              <td>${device.setupType}</td>
              <td>${device.dbcd }</td>
              <td>${device.fagd }</td>
              <td>
              <!-- 现在新增的单独零部件需求，无法实现设备日程功能 -->
              <c:if test="${device.createNo != null }">
              <a onclick="openwinToSchedule(${device.id})" class="edit"><img src="<%=basePath %>static/images/icons/Calendar-icon.png" alt="Edit" /></a>
              </c:if>
              </td>
              </tr>
              </c:forEach>
            </tbody>
            <tfoot>
            <tr>
              <td>&nbsp;</td>
              <td colspan="5">
              <a class="button_new" href="<%=basePath %>contractPro/init/2" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a>
              <%-- <a onclick="onGoodsScheme();" class="button_new" title="保存"><img src="<%=basePath %>static/images/icons/check_icons.png" class="px18"/></a> --%>
              </td>
            </tr>
            </tfoot>
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