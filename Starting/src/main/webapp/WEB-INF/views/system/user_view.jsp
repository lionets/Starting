<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<link rel="stylesheet" type="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/default/easyui.css">
<link rel="stylesheet" type="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/icon.css">
<link rel="stylesheet" href="<%=basePath %>static/js/paging/pagination.css" />
<link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
<!-- Main Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen" />
<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
<link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/css/select.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery.datePicker.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/paging/jquery.pagination.js"></script>
<SCRIPT src="<%=basePath %>static/js/jQselect.js" type=text/javascript></SCRIPT>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></SCRIPT>
<script src="<%=basePath %>static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<SCRIPT type=text/javascript>
//加载window插件
using(['window'],function(){});

	$(document).ready(function() {
		$("input").attr("readonly","readonly");
	});
	</SCRIPT>
</head><body>
<jsp:include page="../header-bar.jsp"/>
 <div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>查看用户信息</h3>
     
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
       <form action="<%=basePath %>users/update" id="form" method="post">
       	<input type="hidden" name="dutyids" id="dutyids">
       	<input type="hidden" name="tab" value="${tab}">
        <input type="hidden" name="tab2PageNum" value="${tab2PageNum}">
        <input type="hidden" name="status" value="1">
        <input type="hidden" name="tab2PerPage" value="${tab2PerPage}">
        <input type="hidden" name="id" value="${comuserinfo.id }">
          <table border="0" class="edit-table">
            <tr>
              <th scope="row"><label><b>*</b>登录名</label></th>
              <td><input required="true"  name="accountName" value="${comuserinfo.accountName }" type="text" /></td>
              <th scope="row"><label><b>*</b>用户姓名</label></th>
              <td><input required="true"    name="realName" value="${comuserinfo.realName }" type="text" /></td>
            </tr>
            <tr>
              <th scope="row"><label><b>*</b>密码</label></th>
              <td><input type="text"  vtype="limit" minLength="6" maxLength="14" required="true" id="accountPassword"  name="accountPassword" value=""/></td>
               <th scope="row"><label><b>*</b>确认密码</label></th>
              <td><input  type="text" vtype='passwordAgain' name="accountPasswordAgain" id="accountPasswordAgain" value=""/></td>
            </tr>
            <tr>
             <th scope="row">手机</th>
              <td><input type="text" vtype='phone'  name="phone" value="${comuserinfo.phone }"/></td>
              <th scope="row">电话</th>
              <td><input type="text" vtype="telpone" name="telphone" value="${comuserinfo.telphone }"/></td>
            </tr>
            <tr>
              <th scope="row">所属公司</th>
              <td>
              		<select   name="companyid"  id="companyid" class="easyui-combobox" data-options="readonly:'readonly'">
              		 <c:forEach var="company"  items="${companyList}" varStatus="status" >
					    <c:choose>
						    <c:when test="${company.id==comuserinfo.companyid }">
										<option value="${company.id }" selected="selected">${company.companyShortName }</option>
						    </c:when>
						    <c:otherwise>
										<option value="${company.id }">${company.companyShortName }</option>
						    </c:otherwise>
					    </c:choose>
				   </c:forEach>
					   </select></td>
             <th scope="row">所在部门</th>
              <td>
              	<select name="departmentId"  id="departmentId" class="easyui-combobox" data-options="readonly:'readonly'">
				    <c:forEach var="department"  items="${departmentList}" varStatus="status" >
					    <c:choose>
						    <c:when test="${department.id==comuserinfo.department_id }">
										<option value="${department.id }" selected="selected">${department.department_name }</option>
						    </c:when>
						    <c:otherwise>
										<option value="${department.id }">${department.department_name }</option>
						    </c:otherwise>
					    </c:choose>
				   </c:forEach>
			   </select>
              </td>
            </tr>
            <tr>
              <th scope="row">身份证号码</th>
              <td><input  type="text"  class="address" vtype="cardNum"  name="cardnum" value="${comuserinfo.cardnum }"/></td>
             <th scope="row">电子邮箱</th>
              <td><input type="text"  class="address" vtype="email"  name="email" value="${comuserinfo.email }"/></td>
            </tr>
            
            <tr>
              <th scope="row">目前住址</th>
              <td colspan="3"><input type="text" class="address" name="address" value="${comuserinfo.address }"/></td>
            </tr>
            </table>
            <input type="hidden" name="dutyIds" id="dutyIds">
      </form>
              <p>
              <label> <b> 职务信息</b></label>
          </p>
        <br/>
        <table style="width:800px">
          <thead>
            <tr>
              <th scope="col" class="chebox">项次</th>
              <th  scope="col" >职务名称</th>
              <th  scope="col" >职务类型</th>
            </tr>
          </thead>
          <tbody id="dynamicTbody">
          <c:forEach items="${hasDutyLists}" var="myDuty" varStatus="status" >
              <tr  dutyid="${myDuty.id }">
	              <td><div align="center">
	              <script type="text/javascript">
	              var num = ${status.index+1};
	              document.write(num);
	              </script>
	              </div>
	              </td>
	              <td><div align="center">${myDuty.duty_name }</div></td>
	              <td><div align="center">${myDuty.memo }</div></td>
	            </tr>
          </c:forEach>
          </tbody>
        </table>
  </div>
            <table>
            <tr>
              <td>&nbsp;</td>
              <td colspan="3"><a class="button_new" href="javascript:history.go(-1)" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a> </td>
            </tr>
          </table>

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