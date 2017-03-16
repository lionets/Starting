<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>塔机动态管理系统</title>
<!--                       CSS                       -->
<!-- Reset Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
<!-- Main Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/js/paging/pagination.css" />
<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
<link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/css/select.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery.datePicker.js"></script>
<SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></SCRIPT>
<script type="text/javascript" src="<%=basePath %>static/js/paging/jquery.pagination.js"></script>
<script src="<%=basePath %>static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<SCRIPT type=text/javascript>
using(['window']);//加载window插件
	$(document).ready(function() {
		$("#submitButton").on("click",function(){
			if(tatongMethod.isChecked()){
				//验证重复
				var checklisst_no = $('[name="checklisst_no"]').val();
			    $.ajax( {
			        dataType : "JSON",
			        type : "POST",
			        url : "<%=basePath%>/maintain/checkCheckListRp",
			        data : "checklisst_no="+checklisst_no,
			        success : function(countStr) {
			        	var count = countStr[0].count
			        	if(count == 0){
							tatongMethod.confirm("提示","确定要添加吗?",function(){
								$("form").submit();
							})
			        	}else{
			        		var html = '<span class="apendhtml" style="color: red;margin-left: 5px;">检查单编号重复</span>';
			        		$('[name="checklisst_no"]').after(html);
			        	}
			        },
			        error : function(html) {
			        	tatongMethod.alert("错误","验证检查单编号遇到问题！");
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
      <h3>新增设备安全检查</h3>
  </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form action="<%=basePath %>maintain/addCheckList" method="post">
        <input type="hidden" name="tab1PageNum" value="${tab1PageNum }">
        <input type="hidden" name="id" value="${id }">
          <table border="0" class="edit-table">
            <tr>
              <th><label ><b>*</b>检查单编号
          </label></th>
        <td><input name="checklisst_no" required="true" type="text"  value="${checkList.checklisst_no }"/></td>
        <td class="zhushi">(输入不能超过20个字)</td>
      </tr>
      <tr>
        <th scope="row">项目名称
          <label></label></th>
        <td><input name="project_name" type="text" value="${checkList.project_name }"></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <th scope="row">塔机编号
          <label></label></th>
        <td>
           <select id="tower_no" class="easyui-combobox" name="tower_no" style="width:200px;"> 
           <c:forEach var="oneTowerNo" items="${towerNoList }">
           <option value="${oneTowerNo.tower_no }" <c:if test="${oneTowerNo.tower_no==checkList.tower_no }">selected="selected"</c:if>>${oneTowerNo.tower_no }</option>
           </c:forEach>
			</select>
        </td>
        <td></td>
      </tr>
      <tr>
        <th scope="row">检查类别</th>
        <td>
                 <select id="check_type" class="easyui-combobox" name="check_type" style="width:200px;"> 
                      		<option></option>
                          <option  value="月度检查" <c:if test='${checkList.check_type=="月度检查" }'>selected="selected"</c:if>>月度检查</option>
                          <option value="年度检查"  <c:if test='${checkList.check_type=="年度检查" }'>selected="selected"</c:if>>年度检查</option>
				</select>  
        </td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <th scope="row">检查人</th>
        <td><input name="check_by" type="text" value="${checkList.check_by }"></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <th scope="row">检查日期</th>
        <td><input name="check_date" value="<fmt:formatDate value="${checkList.check_date }" pattern="yyyy-MM-dd HH:mm:ss"/>" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});"></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <th scope="row">整改单</th>
        <td><input name="recttification_no" type="radio" checked="checked" value="1"  <c:if test='${checkList.recttification_no ==1 }'>checked="checked"</c:if>/>
          有
          <input name="recttification_no" type="radio" value="0"  <c:if test='${checkList.recttification_no ==0 }'>checked="checked"</c:if>/>
          无</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <th scope="row">填表人</th>
        <td><input name="guidance_by" type="text"  value="${checkList.guidance_by}"/></td>
        <td>&nbsp;</td>
      </tr>
      <tr>
      
        <th scope="row">填表日期</th>
        <td><input name="guidance_date" type="text" readonly="readonly"  value='<fmt:formatDate value="${checkList.guidance_date}" pattern="yyyy-MM-dd HH:mm:ss"/>' onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});"/></td>
        <td>&nbsp;</td>
      </tr>
<tr>
              <td>&nbsp;</td>
              <td colspan="2"> <a class="button_new" href="javascript:history.go(-1)" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a> <a class="button_new" href="javascript:void(0)" id="submitButton" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a></td>
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