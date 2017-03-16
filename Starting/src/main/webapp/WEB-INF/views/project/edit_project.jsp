<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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
<link rel="stylesheet" href="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/default/easyui.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/icon.css" type="text/css" media="screen" />
<!-- Reset Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
<!-- Main Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen" />
<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
<link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/css/select.css" type="text/css" media="screen" />

<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
<SCRIPT src="<%=basePath %>static/js/jQselect.js" type=text/javascript></SCRIPT>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<script type="text/javascript" src='<%=basePath %>static/js/UTIL.js'></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<SCRIPT type=text/javascript>
	var trNum = 0;
	var loadNum = 0;
	var idNum = 0;
	var isUnSub = 0;
	$(document).ready(function() {
		
		$('#proManagedept').combobox({
			url:'<%=basePath %>department/ajax',
			valueField:'id',
			textField:'departmentName',
			onLoadSuccess:function(){
				$('#proManagedept').combobox('setValue','${proInfo.proManagedept}');
			}
		});
		
		$('#proArea').combobox({
			url:'<%=basePath %>area/getAreainfo?areaType=1',
			valueField:'areaCode',
			textField:'areaName',
			onSelect:function(rec){
				loadNum++;
				//alert(JSON.stringify(rec));
				$('#proProvince').combobox('clear');
				$('#proCity').combobox('clear');
				var url = '<%=basePath %>area/getAreainfo?areaType=2&areaCode='+rec.areaCode;
				$('#proProvince').combobox('reload', url);
			}
		});
		$('#proProvince').combobox({
			url:'<%=basePath %>area/getAreainfo?areaType=2&areaCode=${proInfo.proArea}',
			valueField:'areaCode',
			textField:'areaName',
			onSelect:function(rec){
				loadNum++;
				//alert(JSON.stringify(rec));
				$('#proCity').combobox('clear');
				var url = '<%=basePath %>area/getAreainfo?areaType=3&areaCode='+rec.areaCode;
				$('#proCity').combobox('reload', url);
			}
		});
		
		$('#proCity').combobox({
			url:'<%=basePath %>area/getAreainfo?areaType=3&areaCode=${proInfo.proProvince}',
			valueField:'areaCode',
			textField:'areaName',
			onSelect:function(rec){
				$('#cityId').val(rec.areaCode);
			}
		});
		$("#proType").combobox({
			url:"<%=basePath %>dictionary/selectByDictCode?dict_code=XMLX",
			valueField: 'dict_name',
			textField: 'dict_value',
			onLoadSuccess:function(){
				$('#proType').combobox('setValue','${proInfo.proType}');
			}
		});
		$("#proStatus").combobox({
			url:"<%=basePath %>dictionary/selectByDictCode?dict_code=XMZT",
			valueField: 'dict_name',
			textField: 'dict_value',
			onLoadSuccess:function(){
				$('#proStatus').combobox('setValue','${proInfo.proStatus}');
			}
		});
		
		$("#submitButton").on("click",function(){
			if(isUnSub>0){
				return;//防止重复提交
			}
			if(tatongMethod.isChecked()){
				isUnSub++;
				onProjectSubmit();
			}
		});
		$('#proArea').combobox('setValue','${proInfo.proArea}');
		$('#proProvince').combobox('setValue','${proInfo.proProvince}');
		$('#proCity').combobox('setValue','${proInfo.proCity}');
		$('#cityId').val('${proInfo.proCity}');
		
	});
	
	function onProjectSubmit(){
		
		$.ajax({
			async : false,
			cache : false,
			type : 'POST',
			data :$("#projectForm").serialize(),
			url :'<%=basePath %>project/editProjectSaveAjax',
			error : function() {// 请求失败处理函数
				isUnSub--;
				$.messager.alert('错误','保存请求提交失败!','error');
			},
			success : function(data){
				if('n' == data){
					isUnSub--;
					$.messager.alert('失败','项目信息保存失败!','error');
				}else{
					$.messager.alert('成功','项目信息保存入库成功!','info',function(){
						window.location.href = '<%=basePath %>project/init/1';
					});
				}
			}
		});
	}
	function checkValue(obj){
		var value = $(obj).val();
		if(!/^[\w]+$/.test(value) && isEmpty(value) == false){
			/* $.messager.alert("错误","编号无效! 仅支持字母与数字下划线。",'error',function(){
				$(obj).val('');
			});
			return; */
		}
	}
	</SCRIPT>
</head><body>
<jsp:include page="../header-bar.jsp"/>
<div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>项目资料</h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form id="projectForm" method="post">
          <table border="0" class="edit-table">
           <tr >
             <th><label><b>*</b>项目编号 </label></th>
              <td>
              <input name="id" value="${proInfo.id }" type="hidden"/>
              <input name="proNo" type="text" value="${proInfo.proNo }" onblur="checkValue(this);" readonly="readonly" /></td>
               <td>&nbsp;</td>
               </tr>
            <tr >
             <th><label><b>*</b>项目名称</label></th>
              <td><input name="proName" type="text" value="${proInfo.proName }" required="true"/></td>
               <td>&nbsp;</td>
               </tr>
               <tr>
              <th><label>项目简称 </label></th>
              <td><input id="proShortName" value="${proInfo.proShortName }" name="proShortName" required="true"/></td>
 			<th>&nbsp;</th>
            </tr>
            <tr>
            <th>项目高度</th>
              <td>
              <input name="proHeight" value="${proInfo.proHeight }"/>
              </td>
              <td>&nbsp;</td>
            </tr>
            <tr >
              <th><label><b>*</b>项目地点</label></th>
              <td>
              <select id="proArea" name="proArea" style="width: 80px;" class="easyui-combobox" >
              </select>
              <select id="proProvince" name="proProvince" style="width: 80px;" class="easyui-combobox" >
              </select>
              <select id="proCity" name="proCity" style="width: 80px;" class="easyui-combobox" >
              </select>
              <input id="proAddress" name="proAddress" value="${proInfo.proAddress }" style="background-color: white;"/>
              <input id="cityId" type="hidden" required="true"/>
              </td>
 			  <td>&nbsp;</td>
            </tr>
            <tr >
             <th><label><b>*</b>类型</label></th>
              <td>
              <select id="proType" name="proType" style="width: 140px;" class="easyui-combobox" >
              
              </select>
              </td>
                   <td>&nbsp;</td>
                   </tr>
                   <tr>
              <th><label><b>*</b>状态</label></th>
              <td>
              <select id="proStatus" name="proStatus" class="easyui-combobox" style="width: 140px;">
              
              </select>
              </td>
 <th>&nbsp;</th>

            </tr>
                   <tr>
                     <th scope="row">管理单位</th>
                     <td>
                     <select id="proManagedept" name="proManagedept" class="easyui-combobox">
              			</select>
              			</td>
                     <th>&nbsp;</th>
                   </tr>
            <tr >
              <th>备注</th>
              <td colspan="2"><textarea id="proEquipment" name="proEquipment" cols="" rows="">${proInfo.proEquipment }</textarea></td>
            </tr>
          <tr>
              <td>&nbsp;</td>
              <td colspan="2"><a href="<%=basePath %>project/init/1" class="button_new" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a><a id="submitButton" class="button_new" href="#" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a>  </td>
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
</body>

</html>