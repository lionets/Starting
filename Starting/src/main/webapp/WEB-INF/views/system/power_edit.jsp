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
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/facebox.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery.datePicker.js"></script>
<SCRIPT src="<%=basePath %>static/js/jQselect.js" type=text/javascript></SCRIPT>
<SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></SCRIPT>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<SCRIPT type=text/javascript>
	$(document).ready(function() {
		//表单提交
		$("#submitButton").on("click",function(){
				if(tatongMethod.isChecked()){
					tatongMethod.confirm("修改","确定要修改吗?",function(){
						$("#form").submit();
					})
				}
			}) 
		//$("#homepage").selectbox();
	});
	</SCRIPT>
</head><body>
<jsp:include page="../header-bar.jsp"/>
<div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>修改权限信息</h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab">
        <form id="form" action="<%=basePath %>power/update" method="post">
        <input type="hidden" name="tab" value="${tab}">
        <input type="hidden" name="tab6PageNum" value="${tab6PageNum}">
        <input type="hidden" name="tab6PerPage" value="${tab6PerPage}">
       	<input type="hidden" name="id" value="${comPower.id}">
       	<input type="hidden" name="status" value="1">
       	       <table border="0" class="edit-table">
            <tr>
              <th><label ><b>*</b>权限名称</label></th>
              <td><input name="powerName" required="true" type="text"  value="${comPower.powerName }"/></td>
              <td class="zhushi">&nbsp;</td>
            </tr>
            <tr>
              <th scope="row"><label ><b>*</b>权限类型</label></th>
              <td><input name="powerType" required="true" type="text"  value="${comPower.powerType }"/></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <th scope="row"><label ><b>*</b>权限url</label></th>
              <td><input name="powerUrl" required="true" type="text"  value="${comPower.powerUrl }"/></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <th scope="row"><label ><b>*</b>权限所属</label></th>
              <td><input name="powerOwn" required="true" type="text"  value="${comPower.powerOwn }"/></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <th scope="row">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</th>
              <td><textarea name="memo" cols="" rows="" >${comPower.memo }</textarea>
               </td>
              <td>&nbsp;</td>
            </tr>
          </table>
        </form>
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