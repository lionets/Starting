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
//刷新索引
function refreshIndex(trs){
	var i = 1;
	trs.each(function(){
		$(this).children(":first").children(":first").text(i++);
	})
}

//数组中是否包含
function iscontains(array,value){
	var flag = false;
	for(var i=0; i<array.length; i++){
		if(array[i] == value){
			flag = true;
		}
	}
	return flag;
}

function showdelete(){
	$(".showdelete").unbind("click");
	//添加删除事件
	$(".showdelete").on("click",function(){
		var thisTr = $(this).parent().parent().parent();
		var siblings = thisTr.siblings();
		thisTr.remove();
		refreshIndex(siblings);
	})
}

//得到所属公司列表方法
function companyListView(selectid, param){
	var parameter="method=selectList&sqlId=cn.com.newglobe.common.dao.read.ComCompanyInfoReadDao.selectPlist&"+param;
    $.ajax( {
        dataType : "json",
        type : "POST",
        url : "<%=basePath %>ajax",
        data : parameter,
        success : function(json) {
    		var html ="<option value=''>不限</option>";
        	for(var i=0; i<json.length; i++){
        		html += "<option value='"+json[i].id+"'>"+json[i].companyShortName+"</option>";
        	}
        	$("#"+selectid).append(html);
        	$("#"+selectid).val("${comuserinfo.companyid }");
        	//$("#"+selectid).selectbox();
        },
        error : function(json) {
			tatongMethod.alert("错误","公司信息加载出错！");
        }
    });
}

	$(document).ready(function() {
		//ajax加载数据
/* 		companyListView("companyid"); */
		
		$(".addOneDuty").on("click",function(){
			var id = $("#dutyid").combobox("getValue");
			if(id == ""){
				tatongMethod.alert("提示","空数据不能添加！");
				return;
			}
			var duty_name = $("#dutyid").combobox("getText");
			var memo = $( "option[value='"+id+"']").attr("memo");
			//已经存在的不容许再添加
			var tempTrs = $("#dynamicTbody").children();
			var dutyids = [];
			for(var i=0; i<tempTrs.length; i++){
				var tempDutyid = $(tempTrs[i]).attr("dutyid");
				dutyids[i] = tempDutyid;
			}
			if(iscontains(dutyids,id)){
				tatongMethod.alert("提示","已添加的职务！");
				return
			}
			var html = "<tr dutyid='"+id+"' class='alt-row'>"+
            "<td><div align='center'>"+
            "</div>"+
            "</td>"+
            "<td><div align='center'>"+duty_name+"</div></td>"+
            "<td><div align='center'>"+memo+"</div></td>"+
            "<td><div align='center'>"+
              "<a href='javascript:void(0)' class='showdelete'><img src='/leap/static/images/icons/cross.png' title='删除'></a></div></td>"+
          "</tr>"
          $("#dynamicTbody").append(html);
          var trs =  $("#dynamicTbody").children();
		  refreshIndex(trs);
		  showdelete();
		})

		//表单提交
		$("#submitButton").on("click",function(){
			companyListView("companyid");
			var tempTrs = $("#dynamicTbody").children();
			var dutyids = [];
			for(var i=0; i<tempTrs.length; i++){
				var tempDutyid = $(tempTrs[i]).attr("dutyid");
				dutyids[i] = tempDutyid;
			}
			var dutyids = dutyids.join(",");
			$("#dutyids").val(dutyids);			
				if(tatongMethod.isChecked()){
					var accountName = $('[name="accountName"]').val();
					var companyid = "";
			        using(['combobox'],function(){
			        	companyid = $("#companyid").combobox('getValue');
			        });  
				    $.ajax( {
				        dataType : "json",
				        type : "POST",
				        url : "<%=basePath%>users/queryUserByAccount",
				        data : "accountName="+accountName+"&companyid="+companyid,
				        success : function(countJson) {
				        	var count = countJson[0].count;
				        	if(count != 0){
				        		var html = '<span class="apendhtml" style="color: red;margin-left: 5px;">已经存在的账号</span>';
				        		$('[name="accountName"]').after(html);
				        	}
				        	else{
								tatongMethod.confirm("修改","确定要增加吗?",function(){
									$("form").submit();
								})
				        	}
				        },
				        error : function(html) {
				        	tatongMethod.alert("提示","验证用户名重复失败！");
				        }
				    });
				}
			}) 
		showdelete();
		
	});
	</SCRIPT>
</head><body>
<jsp:include page="../header-bar.jsp"/>
 <div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>新增用户信息</h3>
     
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
       <form action="<%=basePath %>users/addOne" id="form" method="post">
       	<input type="hidden" name="dutyids" id="dutyids">
       	<input type="hidden" name="tab" value="${tab}">
        <input type="hidden" name="tab2PageNum" value="0">
        <input type="hidden" name="status" value="1">
        <input type="hidden" name="tab2PerPage" value="10">
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
              <td><input type="password"  vtype="limit" minLength="6" maxLength="14" required="true" id="accountPassword"  name="accountPassword" value=""/></td>
               <th scope="row"><label><b>*</b>确认密码</label></th>
              <td><input  type="password" vtype='passwordAgain' name="accountPasswordAgain" id="accountPasswordAgain" value=""/></td>
            </tr>
            <tr>
             <th scope="row">手机</th>
              <td><input type="text" vtype='phone'  name="phone" value="${comuserinfo.phone }"/></td>
              <th scope="row">电话</th>
              <td><input type="text" vtype="telPhone" name="telphone" value="${comuserinfo.telphone }"/></td>
            </tr>
            <tr>
              <th scope="row">所属公司</th>
              <td>
              		<select   name="companyid"  id="companyid" class="easyui-combobox">
              		 <c:forEach var="company"  items="${companyList}" varStatus="status" >
										<option value="${company.id }">${company.shortName }</option>
				   </c:forEach>
					   </select></td>
             <th scope="row">所在部门</th>
              <td>
              	<select name="departmentId"  id="departmentId" class="easyui-combobox" >
				    <c:forEach var="department"  items="${departmentList}" varStatus="status" >
					    <c:choose>
						    <c:when test="${department.id==comuserinfo.id }">
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
              <td colspan="1"><input type="text" class="address" name="address" value="${comuserinfo.address }"/></td>
              <th scope="row">工资卡号</th>
              <td colspan="1"><input type="text" class="address" name="bankcard" value="${comuserinfo.bankcard }"/></td>
            </tr>
            <tr>
              <th scope="row">登陆权限</th>
              <td>
              		<select   name="account_status"  id="account_status" class="easyui-combobox">
										<option value="1" selected="selected">可登陆</option>
										<option value="4" >不可登陆</option>
					</select></td>
            </tr>
            </table>
            <input type="hidden" name="dutyIds" id="dutyIds">
      </form>
              <p>
              <label> <b> 职务信息</b></label>
          </p>
        <table border="0" class="edit-table">
          <tr>
            <th>选择职务</th>
            <td><select name="dutyid"   id="dutyid" class="easyui-combobox" >
				    <c:forEach var="duty"  items="${dutyLists}" varStatus="status" >
						<c:choose>
							<c:when test="${comuserinfo.dutyid==comuserinfo.id }">
								<option value="${duty.id }" memo="${duty.memo }" selected="selected">${duty.duty_name }</option>
							</c:when>
							<c:otherwise>
								<option value="${duty.id }" duty_type="${duty.duty_type }" >${duty.duty_name }</option>
							</c:otherwise>
						</c:choose>
				   </c:forEach>
			   </select>
			  
			   <a class="button button_position addOneDuty"  title="新增">
			    <img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/>
			    </a>
			   </td>
           
          </tr>
        </table>
        <br/>
        <table style="width:800px">
          <thead>
            <tr>
              <th scope="col" class="chebox">项次</th>
              <th  scope="col" >职务名称</th>
              <th  scope="col" >备注信息</th>
              <th  scope="col" class="picture2">功能</th>
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
	              <td><div align="center">
	                <a href="javascript:void(0)"  class="showdelete"><img src="<%=basePath %>static/images/icons/cross.png" title="删除"/></a></div></td>
	            </tr>
          </c:forEach>
          </tbody>
        </table>
  </div>
            <table>
            <tr>
              <td>&nbsp;</td>
              <td colspan="3"><a class="button_new" href="javascript:history.go(-1)" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a><a class="button_new" id="submitButton" href="javascript:void(0)" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a>  </td>
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