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
<link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
<!-- Main Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen" />
<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
<link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/css/select.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
<SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></SCRIPT>
<SCRIPT src="<%=basePath %>static/js/jQselect.js" type=text/javascript></SCRIPT>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<SCRIPT type=text/javascript>
using(['window']);//加载window插件
	$(document).ready(function() {
		//表单提交
		$("#submitButton").on("click",function(){
				if(tatongMethod.isChecked()){
					//验证公司代码是否重复
				    $.ajax( {
				        dataType : "JSON",
				        type : "POST",
				        url : "<%=basePath%>ajax",
				        data : "method=selectList&sqlId=cn.com.newglobe.common.dao.read.ComCompanyInfoReadDao.selectCompanyListByCode&company_code="+$("#companyCode").val(),
				        success : function(json) {
				        	var count = json[0].count;
				        	if(count ==0){
								tatongMethod.confirm("添加","确定要添加吗?",function(){
									$("form").submit();
								})
				        	}else{
				        		var temp = '<span class="apendhtml" style="color: red;margin-left: 5px;">公司代码重复</span>';
				        		$("#companyCode").after(temp);
				        	}
				        },
				        error : function() {
				        	tatongMethod.alert("错误","验证公司代码失败！");
				        }
				    });
				}
			}) 
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
      <h3>新增公司信息</h3>
  </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form action="<%=basePath %>company/addCompany?tab=tab1&tab1PageNum=${tab1PageNum}&tab1PerPage=${tab1PerPage}" id="form" method="post">
          <table border="0" class="edit-table">
            <tr>
              <th><label ><b>*</b>公司简称</label></th>
    <td><input required="true"  name="companyShortName" type="text" value="${comCompanyInfo.companyShortName}"/></td>
    <th scope="row"><label ><b>*</b>公司代码</label></th>
     <td><input required="true"  name="companyCode" id="companyCode" type="text"  value="${comCompanyInfo.companyCode}"/></td>
  </tr>
  
  <tr>
    <th scope="row">上级公司</th>
    <td>
    <select name="companyPid" class="easyui-combobox"  id="companyPid" >
   		 <option value="">无上级公司</option>
	    <c:forEach var="company"  items="${plist}" varStatus="status" >
			<option value="${company.id }">${company.companyShortName }</option>
	   </c:forEach>
   </select>
    </td>
 <th scope="row">机构类型</th>
    <td>
        <select name="organizationId" class="easyui-combobox"  id="organizationId">
	      <c:forEach var="organization"  items="${organizationList}" varStatus="status" >
	    	<c:choose>
			       <c:when test="${organization.id==comCompanyInfo.organizationId}">
			              <option value="${organization.id }" selected="selected">${organization.organizationName }</option>
			       </c:when>
			       <c:otherwise>
			              <option value="${organization.id }">${organization.organizationName }</option>
			       </c:otherwise>
			</c:choose>
	   </c:forEach>
	   </select>
    </td>
  </tr>

  <tr>
    <th scope="row"><label ><b>*</b>公司中文名</label></th>
    <td><input required="true"  name="companyName"  vtype="chinese" type="text" value="${comCompanyInfo.companyName}" /></td>
    <th scope="row"><label ><b>*</b>公司英文名</label></th>
    <td><input required="true" vtype="english" name="companyEngName" type="text"  value="${comCompanyInfo.companyEngName}"/></td>
  </tr>

  <tr>
    <th scope="row"><label ><b>*</b>公司英文简称</label></th>
    <td><input required="true" vtype='english'  name="companyEngShortName" type="text"  value="${comCompanyInfo.companyEngShortName}"/></td>
    <th scope="row"><label ><b>*</b>公司注册名称</label></th>
    <td><input required="true"  name="companyRegisterName" type="text"  value="${comCompanyInfo.companyRegisterName}"/></td>
  </tr>

  <tr>
    <th scope="row">法人名称</th>
    <td><input name="companyCorporation" type="text"  value="${comCompanyInfo.companyCorporation}"/></td>
    <th scope="row">营业执照号</th>
    <td><input name="companyLicence" type="text"  value="${comCompanyInfo.companyLicence}"/></td>
  </tr>

  <tr>
    <th scope="row">手机</th>
    <td><input vtype="phone" name="companyPhone" type="text" value="${comCompanyInfo.companyPhone}" /></td>
    <th scope="row"><label ><b>*</b>电话</label></th>
    <td><input  vtype="telPhone"   required="true"  name="companyTel" type="text" value="${comCompanyInfo.companyTel}"/>
</td>
  </tr>
  <tr><th scope="row">网址</th>
    <td><input name="companyWebsite"  vtype="site"  type="text" value="${comCompanyInfo.companyWebsite}"/></td>
    <th scope="row">传真</th>
    <td><input vtype="fax" name="companyFax" type="text" value="${comCompanyInfo.companyFax}"/>
</td>

           
  </tr>
  <tr>
 <th scope="row">电子邮箱</th>
    <td><input vtype="email" name="companyEmail" type="text" value="${comCompanyInfo.companyEmail}"/></td>
             <th scope="row">地址</th>
    <td><input name="companyAddress" type="text" value="${comCompanyInfo.companyAddress}"/></td>
  </tr>
  <tr>
    <th scope="row">备注</th>
    <td colspan="3"><textarea name="memo" cols="" rows="" >${comCompanyInfo.memo}</textarea>
      &nbsp;</td>
  </tr>
<tr>
            <td>&nbsp;</td>
              <td colspan="2"><a class="button_new" id="submitButton"  href="javascript:void(0)" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a> <a class="button_new" href="javascript:history.go(-1)" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a> </td>   </tr>
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