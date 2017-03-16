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
<script type="text/javascript" src="<%=basePath %>static/js/jquery.json.js"></script>
<SCRIPT type=text/javascript>
using(['window']);//加载window插件
using(['combobox']);//加载window插件  
var iscz="0";
	$(document).ready(function() {
		//表单提交
		$("#submitButton").on("click",function(){
			if(tatongMethod.isChecked()){
				//验证唯一
				var obj = {};
				obj.name=$("#dictValue").val();
				obj.iscz=iscz;
				var objjson = $.toJSON(obj);
				$.ajax({
				    type: "POST",
				    url:"<%=basePath %>common/dicOnlyCheck",
				    contentType:"application/json",
				    dataType:"json",
				    data:objjson,
				    success: function(data) {
				    	if(data==1){
				    		$("#dictValue").after("<span class='apendhtml' style='color: red;margin-left: 5px;'>该名称已存在</span>");
				    	}else{
				    		tatongMethod.confirm("添加","确定要添加吗?",function(){
								$("form").submit();
							})
				    	}
				    }
				});
			}
		}) 
		//$("#wordClass").selectbox();
		
		$(":radio").click(function(){
			if($(this).val()==1){
				$("#cztr").hide();
				iscz="1";
			}else{
				$("#cztr").show();
				iscz="0";
			}
		});
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
      <h3>新增公共资料</h3>
  </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form action="addOne" id="form" method="post">
		<input type="hidden" name="tab" value="${tab}">
        <input type="hidden" name="status" value="1">
        <input type="hidden" name="tab4PageNum" value="${tab4PageNum}">
        <input type="hidden" name="tab4PerPage" value="${tab4PerPage}">        
         <table border="0" class="edit-table">
         	<tr>
              <th><label ><b>*</b>词组类别</label></th>
		      <td>
		      	<input type="radio" name="iscz" value="0" checked="checked">否<input type="radio" name="iscz" value="1">是
		      </td>
		      <td class="zhushi">&nbsp;</td>
		    </tr>
            <tr id="cztr">
              <th><label ><b>*</b>词组类别</label></th>
    <td>
				<select name="czlb" id="wordClass" class="easyui-combobox">
					<!-- <option value="塔机型号">塔机型号</option>
					<option value="资产名称">塔机来源</option>
					<option value="标准节">生产厂家</option>
					<option value="标准节">设备形式</option>
					<option value="标准节">资产名称</option>
					<option value="标准节">零部件型号</option>
					<option value="标准节">检查类型</option>
					<option value="标准节">GPS运行状况</option>
					<option value="标准节">GPS异常原因</option>
					<option value="标准节">GPS拆除部件</option>
					<option value="标准节">自有处置类型</option>
					<option value="标准节">标准节</option>
					<option value="标准节">过渡节</option>
					<option value="标准节">零部件单位</option>
					<option value="标准节">提升机构</option>
					<option value="标准节">变幅机构</option>
					<option value="标准节">回转机构</option>
					<option value="标准节">起重臂</option>
					<option value="标准节">配重</option>
					<option value="标准节">塔机样式</option> -->
					<c:forEach var="cz"  items="${czlist}" varStatus="status" >
             			<option value="${cz.id }">${cz.dictValue }</option>
             		</c:forEach>
			   </select>        
     </td>
    <td class="zhushi">&nbsp;</td>
  </tr>
  <tr>
    <th scope="row">
      <label><b>*</b>词组中文名称</label></th>
    <td><input id="dictValue" name="dictValue" required="true" type="text"/></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <th scope="row">
      <label><b>*</b>词组繁体中文名称</label></th>
    <td><input name="dictValueT" required="true" type="text"/></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <th scope="row"><label><b>*</b>词组英文名称</label></th>
    <td><input name="dictValueE" required="true" type="text"/></td>
    <td>&nbsp;</td>
  </tr>
  <%-- 
  <tr>
    <th scope="row">最后修改时间
      <label></label></th>
    <td><input type="text" readonly="readonly"  value="<fmt:formatDate  value='${publicInfo.create_time }'   pattern='yyyy-MM-dd HH:mm:ss'/>"/></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <th scope="row">最后修改人</th>
    <td><input name="modifyByName" type="text" readonly="readonly" value="${publicInfo.real_name }"/></td>
    <td>&nbsp;</td>
  </tr> --%>
  <tr>
    <th scope="row">描述</th>
    <td><textarea name="dictMemo" cols="" rows="" ></textarea>
      &nbsp;</td>
    <td>&nbsp;</td>
  </tr>
<tr>
              <td>&nbsp;</td>
              <td colspan="2"><a class="button_new" href="javascript:void(0)" id="submitButton" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a> <a class="button_new" href="javascript:history.go(-1)" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a> </td>
            </tr>
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