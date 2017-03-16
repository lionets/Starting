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
<!-- 分页css -->
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
<SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></SCRIPT>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<script type="text/javascript">
using(['window'],function(){});//加载window插件
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


//删除绑定事件
function deleteOne(){
	$(".deleteOne").on("click",function(){
		var thisTr = $(this).parent().parent().parent();
		var siblings = thisTr.siblings().not(":last");
		thisTr.remove();
		refreshIndex(siblings);
	})
} 

function refreshIndex(tr){
	for(var i=1; i<tr.length+1; i++){
		$(tr[i-1]).children(":first").children().text(i);
	}
	$(tr).filter(":even").addClass("alt-row");
	$(tr).filter(":odd").removeClass("alt-row");
} 

$(function(){
	//提交表单
	$("#submitButton").on("click",function(){
        //ajax请求将表单域直接序列化
        $.ajax( {
                dataType : "html",
                type : "POST",
                url : "<%=basePath %>part/isExistPartBase",
                data : $("form").serialize(),
                success : function(html) {
                    if(html=="Y"){
                    	tatongMethod.alert("提示","该部件类型已存在请修改!");
                    }else{
                		//封装数据
                		var partModels = [];
                		var trs = $("#dynamicTbody").children(":not(:last)");
                		for(var i=0; i<trs.length; i++){
                			var onePartModel = {};
                			var oneTr = trs[i];
                			var partModel = $(oneTr).find("input:first").val();
                			var memo = $(oneTr).find("input:last").val();
                			onePartModel.partModel = partModel;
                			onePartModel.memo = memo;
                			partModels[i]=onePartModel;
                		}
                		var data = JSON.stringify(partModels);
                		$("#data").val(data);
                		if(tatongMethod.isChecked()){
                			tatongMethod.confirm("添加","确定要添加吗?",function(){
                				$("form").submit();
                			})
                		}
                    }
                },
                error : function(html) {
                    tatongMethod.alert("错误","服务器遇到问题");
                }
            });
	})
	
	
	$(".button1").on("click",function(){
		var html = "<tr class='alt-row'>"+
        "<td><div align='center'>1</div></td>"+
        "<td><div align='center'><input name='Input2' type='text'></div></td>"+
        "<td><div align='center'><input name='Input2' type='text'></div></td>"+
        "<td><div align='center'><a class='deleteOne' href='javascript:void(0)'><img src='/leap/static/images/icons/cross.png' alt='Delete'></a></div></td>"+
      "</tr>";
		$(this).parent().parent().before(html);
		var siblings = $(this).parent().parent().siblings();
		refreshIndex(siblings);
		deleteOne();
	})
	deleteOne();
	
})


</script>
</head>
<body>
<jsp:include page="../header-bar.jsp"/>
<div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>新增部件资料</h3>
  </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form action="<%=basePath %>part/addPart" method="post">
        	<input type="hidden" name="data" id="data">
        
          <table border="0" class="edit-table">
            <tr>
              <th><label ><b>*</b>部件名称</label></th>
    <td><input name="part_name" id="part_name" required="true" type="text" value="${thisLevel.part_name }"/></td>
    <th scope="row">
      <label><b>*</b>部件类别</label></th>
    <td>  <select class="easyui-combobox" id="level"  name="level" style="width:200px;">
						<option value="1">主部件</option>
						<option value="2">零部件</option>
				</select>
     </td>
<%--     <th scope="row"><label><b>*</b>上级部件</label></th>
    <td>  
     	<select name="pid" class="easyui-combobox"   >
				    <c:forEach var="pLevel"  items="${pLevelList}" varStatus="status" >
				    	<c:choose>
						       <c:when test="${pLevel.id==thisLevel.pid}">
						              <option value="${pLevel.id }" selected="selected">${pLevel.part_name }</option>
						       </c:when>
						       <c:otherwise>
						             <option value="${pLevel.id }" >${pLevel.part_name }</option>
						       </c:otherwise>
						</c:choose>
				   </c:forEach>
			</select>
	</td> --%>
<%--     <th scope="row"><label><b></b>部件型号</label></th>
    <td><input type="text"  name="part_model" id="part_model"  value="${thisLevel.part_model }"   /></td> --%>
       <th scope="row"><label><b></b>零部件单位</label></th>
    <td>
    		<select  name="part_unit" id="part_unit" class="easyui-combobox">
    			<c:forEach var="part_unit" items="${part_units }">
    					<option value="${part_unit.dict_value }" <c:if test="${part_unit.dict_value==part_unit }">selected="selected"</c:if>>${part_unit.dict_name }</option>
    			</c:forEach>
    		</select>
    </td>
       <th scope="row"><label><b>*</b>英文简称</label></th>
	    <td>
	    	<input name="part_letter" vtype="english" required="true" >
	    </td>
  </tr>
  <tr>
    <th scope="row">描述</th>
    <td colspan="8"><textarea name="memo" id="memo" cols="" rows="">${thisLevel.memo }</textarea>
 </td>
  </tr>
  <tr></tr>
  <tr></tr>
  </table>
   </form>
  <p><b>部件型号</b></p>
  <table style=" width:500px">
            <thead>
              <tr>
                <th scope="col" class="picture2">&nbsp;</th>
                <th scope="col">部件型号</th>
                <th scope="col">描述</th>

                <th scope="col" class="picture2"></th>
              </tr>
            </thead>
            <tbody  id='dynamicTbody'>
              <tr class="alt-row">
                <td><div align="center">1</div></td>
                <td><div align="center"><input name="Input2" type="text"></div></td>
                <td><div align="center"><input name="Input2" type="text"></div></td>
                <td><div align="center"><a class='deleteOne' href="javascript:void(0)" ><img src="<%=basePath %>static/images/icons/cross.png" alt="Delete"></a></div></td>
              </tr>
              <tr>
                <td><a class="button1 button_position" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"></a></td>
                <td colspan="10">&nbsp;</td>
              </tr>
            </tbody>
            <tbody><tr> <td colspan="2"></td><td colspan=""><a class="button_new" href="javascript:history.go(-1)" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a><a class="button_new" id="submitButton" href="javascript:void(0)" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a> </td></tr>
          </tbody></table>
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