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
using(['window'],function(){});//加载window插件
	$(document).ready(function() {
		$("#submitButton").on("click",function(){
			if(tatongMethod.isChecked()){
				var maintain_date_start = $("[name='maintain_date_start']").val();
				var maintain_date_end = $("[name='maintain_date_end']").val();
				maintain_date_start = maintain_date_start.replace(/-/g,"/");
				maintain_date_end = maintain_date_end.replace(/-/g,"/");
				var start = new Date(maintain_date_start);
				var end = new Date(maintain_date_end);
				if(start>end){
					tatongMethod.alert("提示","修理时间填写错误！")
					return;
				}
				
				tatongMethod.confirm("提示","确定要修改吗?",function(){
					$("form").submit();
				})
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
      <h3>编辑维修记录</h3>
  </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form action="<%=basePath %>maintain/updateMaintain" method="post">
        <input type="hidden" name="tab2PageNum" value="${tab2PageNum }">
        <input type="hidden" name="id" value="${id }">
          <table border="0" class="edit-table">
            <tr>
              <th><label ><b>*</b>维修单编号</th>
        <td><input name="maintain_no" type="text" readonly="readonly" value="${maintainList.maintain_no }"/></td>
        <td class="zhushi">&nbsp;</td>
      </tr>
      <tr >
        <th>维修类别
          <label></label></th>
        <td><input name="maintain_type" type="radio" value="1"  <c:if test="${maintainList.maintain_type==1 }">checked="checked"</c:if>/>
          大修
          <input name="maintain_type" type="radio" value="2" <c:if test="${maintainList.maintain_type==2 }">checked="checked"</c:if>/>
          项修</td>
        <td>&nbsp;</td>
      </tr>
      <tr >
      
        <th>修理日期</th>
        <td><input name="maintain_date_start"  required="true"  type="text" value="<fmt:formatDate value="${maintainList.maintain_date_start }" pattern="yyyy-MM-dd HH:mm:ss"/>" readonly="ture"  style="width:150px;"  class="picture5"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});"/>
          ~
          <input name="maintain_date_end"  required="true"  type="text" readonly="ture"  value="<fmt:formatDate value="${maintainList.maintain_date_end }" pattern="yyyy-MM-dd HH:mm:ss"/>" style="width:150px;"  class="picture5"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});"/></td>
        <td>&nbsp;</td>
      </tr>
      <tr >
        <th>维修部门</th>
        <td><input name="maintain_dept" type="text" value="${maintainList.maintain_dept}"/></td>
        <td>&nbsp;</td>
      </tr>
      <tr >
        <th>塔机编号</th>
        <td>
           <select id="tower_no" class="easyui-combobox" name="tower_no" style="width:200px;"> 
           <c:forEach var="oneTowerNo" items="${towerNoList }">
           <option value="${oneTowerNo.tower_no }" <c:if test="${oneTowerNo.tower_no==maintainList.tower_no }">selected="selected"</c:if>>${oneTowerNo.tower_no }</option>
           </c:forEach>
			</select>
           </td>
        <td></td>
      </tr>
      <tr >
        <th>管理公司</th>
        <td>
           <select id="manage_company" class="easyui-combobox" name="manage_company" style="width:200px;"> 
		           <c:forEach var="company" items="${companyList }">
		           <option value="${company.id }" <c:if test="${company.id==maintainList.manage_company }">selected="selected"</c:if>>${company.shortName }</option>
		           </c:forEach>
			</select>
         </td>
        <td>&nbsp; </td>
      </tr>
    <tr >
        <th>维修资产数量</th>
        <td><input name="number" vtype='integer' value="${maintainList.number }" type="text" /></td>
        <td>&nbsp;</td>
      </tr>
      <tr >
        <th>维修内容</th>
        <td><input name="maintain_content" value="${maintainList.maintain_content }" type="text" /></td>
        <td>&nbsp;</td>
      </tr>
      <tr >
        <th>主修人员</th>
        <td><input name="major_man" value="${maintainList.major_man }" type="text" /></td>
        <td>&nbsp;</td>
      </tr>
      <tr >
        <th>自检人员</th>
        <td><input name="check_man" value="${maintainList.check_man }"  type="text" /></td>
        <td>&nbsp;</td>
      </tr>
      <tr >
        <th>检查结果</th>
        <td>
        <select id="check_result" class="easyui-combobox" name="check_result" style="width:200px;"> 
		         	<option  value="合格" <c:if test='${maintainList.check_result=="合格" }'>selected="selected"</c:if>>合格</option>
                  	<option  value="不合格" <c:if test='${maintainList.check_result=="不合格" }'>selected="selected"</c:if>>不合格</option>
			</select>
                </td>
        <td>&nbsp;</td>
      </tr>
      <tr >
        <th>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</th>
        <td><textarea name="memo" cols=""  rows="">${maintainList.memo }</textarea>
          &nbsp;</td>
        <td>&nbsp;</td>
        </tr>
<tr>
              <td>&nbsp;</td>
              <td colspan="2"><a class="button_new" href="javascript:history.go(-1)" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a><a class="button_new" href="javascript:void(0)" id="submitButton" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a>  </td>
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