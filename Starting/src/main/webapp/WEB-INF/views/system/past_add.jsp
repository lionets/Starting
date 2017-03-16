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
<link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
<!-- Main Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen" />
<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
<link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/css/select.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/facebox.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery.datePicker.js"></script>
<SCRIPT src="<%=basePath %>static/js/jQselect.js" type=text/javascript></SCRIPT>
<SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></SCRIPT>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<SCRIPT type=text/javascript>
	using(['window']);//加载window插件
	using(['combobox']);//加载window插件
	$(document).ready(function() {
		//表单提交
		$("#submitButton").on("click",function(){
				if(tatongMethod.isChecked()){
					tatongMethod.confirm("修改","确定要修改吗?",function(){
						$("#form").submit();
					})
				}
			}) 
			
	});
	</SCRIPT>
</head><body>
<jsp:include page="../header-bar.jsp"/>
<div id="main-content">
  <form id="form" action="addDuty" method="post" >
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>编辑职务信息</h3>
      <ul class="content-box-tabs" style=" float: right;">
        <li><a href="#tab1" class="default-tab"><h5>基本信息</h5></a></li>
        <!-- href must be unique and match the id of target div -->
        <li><a href="#tab2"><h5>角色信息</h5></a></li>
      </ul>
      <div class="clear"></div>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <input type="hidden" name="tab" value="${tab}">
        <input type="hidden" name="status" value="1">
        <input type="hidden" name="tab3PageNum" value="${tab3PageNum}">
        <input type="hidden" name="tab3PerPage" value="${tab3PerPage}">
       	<table border="0" class="edit-table">
            <tr>
              <th><label ><b>*</b>职务名称</label></th>
              <td><input name="dutyName" required="true" type="text"  value="${duty.dutyName }"/></td>
              <td class="zhushi">&nbsp;</td>
            </tr>
            <tr>
              <th scope="row"><label ><b>*</b>职务代码</label></th>
              <td><input name="dutyCode" required="true" type="text"  value="${duty.dutyCode }"/></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <th scope="row"><label ><b>*</b>薪资</label></th>
              <td><input name="dutySalary" vtype="integer"  required="true" type="text"  value="${duty.dutySalary }"/></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <th scope="row">主页类型</th>
              <td>
 				<select id="homepage" class="easyui-combobox"  name="homepage" value="${duty.homepage }">
 					<option value="经理">经理</option>
 					<option value="项目">项目</option>
 					<option value="调度">调度</option>
 				</select>
                  </td>
              <td>&nbsp;</td>
            </tr>
             <tr>
              <th scope="row">所属公司</th>
              <td>
 				<select id="companyid" class="easyui-combobox" name="companyid">
 					<c:forEach var="company" items="${companys }">
 					<option value="${company.id }">${company.shortName }</option>
 					</c:forEach>
 				</select>
 				 <script type="text/javascript">
 					$("#companyid").val("${duty.companyid }");
 				</script>
                  </td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <th scope="row">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</th>
              <td><textarea name="memo" cols="" rows="" >${duty.memo }</textarea>
               </td>
              <td>&nbsp;</td>
            </tr>
          </table>
      </div>
      <!-- End #tab1 -->
      <div class="tab-content" id="tab2">
        <table>
          <thead>
            <tr>
              <th scope="col" class="chebox">项次</th>
              <th  scope="col" >角色名称</th>
              <th  scope="col" >角色类型</th>
              <th  scope="col" >角色描述</th>
              <th  scope="col" >添加角色</th>
            </tr>
          </thead>
          <tbody>
	      <c:forEach var="role"  items="${roleList}" varStatus="status" >
	           <tr>
	           <c:choose>
	           	<c:when test="${status.index < size}">
           		 <td>
						<script type="text/javascript">
				          	var num =	${status.index+1};
				          	document.write(num);
				          </script>
		           </td>
				  <td>${role.roleName }</td>
				  <td>${role.roleType }</td>
				  <td>${role.roleDesc }</td>
				  <td><input type="checkbox" checked="checked" name="roleId" value="${role.id }"></td>
	           	</c:when>
	           	<c:otherwise>
	           		 <td>
						<script type="text/javascript">
				          	var num =	${status.index+1};
				          	document.write(num);
				          </script>
		           </td>
				  <td>${role.roleName }</td>
				  <td>${role.roleType }</td>
				  <td>${role.roleDesc }</td>
				  <td><input type="checkbox" name="roleId" value="${role.id }"></td>
	           	</c:otherwise>
	           </c:choose>
		  </tr>	
	       </c:forEach>
          </tbody>
        </table>
        <div class="clear"></div>
      </div>
    </div> 
     <table>
        <tr>
          <td>&nbsp;</td>
          <td colspan="2"><a class="button_new" href="javascript:void(0)" id="submitButton" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a> <a class="button_new" href="javascript:history.go(-1)" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a> </td>
       </tr>
      </table>
    <!-- End .content-box-content -->
  </div>
</form>
  
  
  
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