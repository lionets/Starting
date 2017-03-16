<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath =  path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
<SCRIPT type=text/javascript>
	using(['window'],function(){});//加载window插件
	$(document).ready(function() {
		//表单提交
		$("#submitButton").on("click",function(){
				//塔机编号必输项
				if($("[name='towerNo']").val()==""){
					$("#showspan").text("该项为必输项");
					return;
				}
				else{
					$("#showspan").text("");
				}	
				if(tatongMethod.isChecked()){
					tatongMethod.confirm("修改","确定要修改吗?",function(){
						$("form").submit();
					})
				}
			}) 
		$("#companyPid").selectbox();
		$("#organizationId").selectbox();
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
      <h3>编辑GPS维修</h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form action="<%=basePath %>driverManage/updateMaintain" method="post">
        	<input type="hidden" name="id" value="${id}">
        	<input type="hidden" name="tab4PageNum" value='${tab4PageNum==""?0:tab4PageNum}'>
        	<input type="hidden" name="tab4PerPage" value='${tab4PerPage==""?10:tab4PerPage}'>
        	<input type="hidden" name="status" value="1">
        	<input type="hidden" name="tab" value="tab4">
          <table border="0" class="edit-table">
            <tr>
              <th><label ><b>*</b>塔机编号</label></th>
        	<td><input  readonly="readonly" readonly="readonly" type="text" name="tower_no" value="${maintain.tower_no }"></td>
     </tr>

     <tr>
       <th scope="row">GPS防水盒号</th>
       <td><input name="waterproof"  readonly="readonly"  type="text" value="${maintain.waterproof }"></td>
     </tr>
     <tr>
       <th scope="row">维修情况</th>
       <td>
       		<select  class="easyui-combobox"  name="maintain_status" id="maintain_status" style="width:154px;">
		         <option value="维修中">维修中</option>
		          <option value="维修完成">维修完成</option>
		       </select>
		       <script type="text/javascript">
		       	$("#maintain_status").val("${maintain.maintain_status }");
		       </script>
       </td>
     </tr>
     <tr>
       <th scope="row">机具编号</th>
       <td><input name="gps_no" readonly="readonly" type="text" value="${maintain.gps_no }"></td>
     </tr>
     <tr>
       <th scope="row">Sim卡号</th>
       <td><input name="sim_number" readonly="readonly" vtype="phone" type="text" value="${maintain.sim_number }"></td>
     </tr>
     <tr>
       <th scope="row">GPS运行状况</th>
       	<td><select  class="easyui-combobox"  name="gps_state" style="width:154px;">
		         <option value="正常">正常</option>
		          <option value="异常">异常</option>
		       </select>
		       <script type="text/javascript">
		       	 $("[name='gps_state']").val("${maintain.gps_state }");
		       </script>
       	</td>
     </tr>
     <tr>
       <th scope="row">异常原因</th>
       <td>
       			<select  class="easyui-combobox"  name="cause" style="width:154px;">
					<option value="1">GPS 维修后待安装</option>
				    <option value="2">GPS邮件损坏，待维修</option>
				    <option value="3">GPS硬件损坏，维修中</option>
				    <option value="4">GPS整机丢失</option>
				   <option value="5">仓库堆放，未完成充电</option>
				   <option value="6">塔机现场闲置未使用</option>
				   <option value="7">需要现场查看</option>
		       </select>
		       <script type="text/javascript">
		       	 $("[name='cause']").val("${maintain.cause }");
		       </script>
       </td>
     </tr>
     <tr>
       <th scope="row">拆除部件</th>
       	<td>
              <select  class="easyui-combobox"  name="dismantle_part" style="width:154px;">
					<option value="主机">主机</option>
			         <option value="电源">电源</option>
			         <option value="主机+电源">主机+电源</option>
			         <option value="整套拆除">整套拆除</option>
		       </select>
		       	<script type="text/javascript">
		       	 $("[name='dismantle_part']").val("${maintain.dismantle_part }");
		       </script>
		</td>
     </tr>
     <tr>
       <th scope="row">返修时间</th>
       <td><input name="send_time" value="${maintain.send_time }" type="text"  readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});"></td>
     </tr>
     <tr>
       <th scope="row">寄出时间</th>
       <td><input name="renturn_time" value="${maintain.renturn_time }" type="text"  readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});"></td>
     </tr>
    <tr>
              <td>&nbsp;</td>
              <td colspan="2"><a class="button_new" href='<%=basePath %>driverManage/init/tab4?tab4PageNum=${tab4PageNum==""?0: tab4PageNum}&tab4PerPage=${tab4PerPage==""?0:tab4PerPage}' title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a><a class="button_new" id="submitButton" href="javascript:void(0)" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a> <a class="button_new" href="<%=basePath %>driverManage/GPSmanage_edit?&tab6PageNum=0&tab6PerPage=10&tower_no=${maintain.tower_no }" title="取消返修"><img src="<%=basePath %>static/images/icons/logout_icon.png" class="px18"/></a> </td>
            </tr>
            </tfoot>
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

