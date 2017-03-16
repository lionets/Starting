<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath =  path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
<link rel="stylesheet" href="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/default/easyui.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/icon.css" type="text/css" media="screen" />

<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
<script src="<%=basePath %>static/js/jQselect.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<script type="text/javascript" src='<%=basePath %>static/js/UTIL.js'></script>
<script type=text/javascript>
	var trNum = 0;
	var loadNum = 0;
	var isopen = new Array();
	var idNum = 0;
	$(document).ready(function() {
		
		$('#proCompany').combobox({
			url:'<%=basePath %>company/manageCompanyCombox',
			valueField:'id',
			textField:'companyShortName',
			onLoadSuccess:function(){
				$('#proCompany').combobox('setValue','${proInfo.proCompany}');
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
			},
			onLoadSuccess:function(){
				
			}
		});
		$('#proProvince').combobox({
			//url:'<%=basePath %>area/getAreainfo?areaType=2&areaCode=${proInfo.proArea}',
			url:'<%=basePath %>area/getAreainfo?areaType=2',
			valueField:'areaCode',
			textField:'areaName',
			onSelect:function(rec){
				loadNum++;
				//alert(JSON.stringify(rec));
				$('#proCity').combobox('clear');
				var url = '<%=basePath %>area/getAreainfo?areaType=3&areaCode='+rec.areaCode;
				$('#proCity').combobox('reload', url);
			},
			onLoadSuccess:function(){
				if(1 > loadNum){//第一次页面初始化时才加载
					
				}
			}
		});
		
		$('#proCity').combobox({
			//url:'<%=basePath %>area/getAreainfo?areaType=3&areaCode=${proInfo.proProvince}',
			url:'<%=basePath %>area/getAreainfo?areaType=3',
			valueField:'areaCode',
			textField:'areaName',
			onLoadSuccess:function(){
				if(1 > loadNum){//第一次页面初始化时才加载
					
				}
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
		$('#customerInfo').combobox({
			url :'<%=basePath %>customer/ajax',
			valueField:'id',
			textField:'customerCnName',
			onSelect:function(rec){
				setCustomerInfo(rec.id);
			},
			onLoadSuccess:function(){
				$('#customerInfo').combobox('setValue','${proInfo.customerInfo}');
				var id = $('#customerInfo').combobox('getValue');
				setCustomerInfo(id);
			}
		});
		
		$("#submitButton").on("click",function(){
			if(tatongMethod.isChecked()){
				onProjectSubmit();
			}
		});
		
		$('#proArea').combobox('setValue','${proInfo.proArea}');
		$('#proProvince').combobox('setValue','${proInfo.proProvince}');
		$('#proCity').combobox('setValue','${proInfo.proCity}');
	});
	
	function setCustomerInfo(id){
		$.ajax({
			async : false,
			cache : false,
			type : 'POST',
			data:{"customerId":id},
			url :'<%=basePath %>customer/findAjax',
			error : function() {// 请求失败处理函数
				$.messager.alert('错误','查询客户请求失败!','error');
			},
			success : function(data){
				var jsonData = JSON.parse(data);
				if(jsonData != null){
					$("#customerNo").val(jsonData.customerCode);
					$("#cusPhone").val(jsonData.phone);
					$("#cusConto").val(jsonData.cpCnName);
				}
			}
		});
	}
	
	function removeIsopen(obj){
		var ids;
		var id = $(obj).parent().parent().attr('id');//取出行id
		alert(id);
		for (var i = 0; i < isopen.length; i++) {
			ids = isopen[i];
			if(ids == id){
				isopen.splice(i,1);//只删除下标为 i 的 1 个元素
			}
		}
	}
	
	function addTr(){
		trNum++;
		idNum++;
		isopen.push("deviceDetailTr-" + idNum);//打开新建tr，需要确认后才能保存
		var sourceNode = document.getElementById("device"); // 获得被克隆的节点对象 
		var clonedNode = sourceNode.cloneNode(true); // 克隆节点 
		clonedNode.setAttribute("id", "deviceDetailTr-" + idNum); // 修改一下id 值，避免id 重复 
		//sourceNode.parentNode.appendChild(); // 在父节点插入克隆的节点 
		$('#newDevice').append(clonedNode);
	}
	
	function setValueFun(obj){
		removeIsopen(obj);//关闭新建tr，得到确认，要所有新建tr都关闭才能保存
		//取input值set到td文本
		$(obj).parent().parent().find('td:eq(0)').text(trNum);
		$(obj).parent().parent().find('td:eq(1)').text($(obj).parent().parent().find('td:eq(1)').children('select').val());
		$(obj).parent().parent().find('td:eq(2)').text($(obj).parent().parent().find('td:eq(2)').children('select').val());
		$(obj).parent().parent().find('td:eq(3)').text($(obj).parent().parent().find('td:eq(3)').children('input').val());
		$(obj).parent().parent().find('td:eq(4)').text($(obj).parent().parent().find('td:eq(4)').children('input').val());
		$(obj).remove();
	}
	
	function delTr(obj){
		$.messager.confirm('设备需求', '您确定移除当前设备需求？', function (yes) {
			if(yes == true){
				removeIsopen(obj);//关闭新建tr，得到确认，要所有新建tr都关闭才能保存
				trNum--;
				$(obj).parent().parent().remove();
			}
		});
	}
	
	function removeDevice(obj){
		$.messager.confirm('设备需求', '您确定删除当前设备需求？', function (yes) {
			if(yes == true){
				$('#delDeviceId').val($(obj).parent().parent().find('td:eq(0)').children('input').val()+'/');
				$(obj).parent().parent().remove();
			}
		});
	}
	
	function onProjectSubmit(){
		var length = document.getElementById('newDevice').getElementsByTagName('tr').length;
		if(1 > length){
			$.messager.confirm('设备需求', '当前未添加设备需求信息，您是否继续保存？', function (yes) {
				if(yes == true){
					isOpenTrLength();
				}
			});
		}else{
			isOpenTrLength();
		}
	}
	
	function isOpenTrLength(){
		if(isopen.length > 0){
			$.messager.alert('设备需求','设备需求编辑未保存，<br/>请点击右侧编辑按钮完成编辑操作!','error');
			return;
		}
		setJsonDate();
	}
	
	function setJsonDate(){
		var newDevice = document.getElementById('newDevice');
		var length = document.getElementById('newDevice').getElementsByTagName('tr').length;
		var tr;
		var jsonData = "[";
		for (var i = 0; i < length; i++) {
			tr = $(newDevice).find('tr:eq('+i+')');
			if(!isEmpty(tr.find('td:eq(0)').children('input').val())){
				jsonData = jsonData + "{id:"+tr.find('td:eq(0)').children('input').val()+",goodName:'"+tr.find('td:eq(1)').text();
			}else{
				jsonData = jsonData + "{goodName:'"+tr.find('td:eq(1)').text();
			}
			jsonData = jsonData + "',goodUnit:'"+tr.find('td:eq(2)').text();
			jsonData = jsonData + "',goodWeight:"+tr.find('td:eq(3)').text()+",goodCube:"+tr.find('td:eq(4)').text()+"}";
			if(i<length-1){
				jsonData = jsonData + ",";
			}
		}
		jsonData = jsonData + "]";
		$('#jsonList').val(jsonData);
		$("#projectEditForm").submit();
	}
	</script>
</head><body>
<jsp:include page="../header-bar.jsp"/>
<div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>编辑项目信息</h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form id="projectEditForm" action="<%=basePath %>project/editProjectSave" method="post">
          <table border="0" class="edit-table">
            <tr>
              <th ><label><b>*</b>合同编号 </label></th>
              <td width="300px">
              <input name="id" value="${proInfo.id }" type="hidden"/>
              <input name="proNo" value="${proInfo.proNo }" type="text" required="true"/>
              <input id="delDeviceId" type="hidden" name="delDeviceId"/>
              <input id="jsonList" name="jsonList" type="hidden"/>
              </td>
              <th><label><b>*</b>项目名称 </label></th>
              <td><input name="proName" value="${proInfo.proName }" type="text" required="true"/></td>
            </tr>
            <tr >
              <th><label><b>*</b>项目简称</label></th>
              <td>
              <input id="proShortName" name="proShortName" required="true" value="${proInfo.proShortName }"/>
              </td>
              <th>项目类型</th>
              <td>
              <select id="proType" name="proType" class="easyui-combobox" >
              </select>
              </td>
            </tr>
            <tr >
              <th>项目状态</th>
              <td>
              <select id="proStatus" name="proStatus" class="easyui-combobox" >
              <option value="0" <c:if test="${proInfo.proStatus == 0 }">selected="selected"</c:if>>待启动</option>
                    <option value="1" <c:if test="${proInfo.proStatus == 1 }">selected="selected"</c:if>>已启动</option>
                    <option value="2" <c:if test="${proInfo.proStatus == 2 }">selected="selected"</c:if>>已关闭</option>
              </select>
              </td>
             
              <th>所属公司</th>
              <td>
              <select id="proCompany" name="proCompany" class="easyui-combobox" >
              </select>
              </td>
            </tr>
             <tr >
              <th>项目高度</th>
              <td>
              <input id="proHeight" name="proHeight" value="${proInfo.proHeight }" />
              </td>
              <th><label><b>*</b>项目地点</label></th>
              <td><select id="proArea" name="proArea" style="width: 80px;" class="easyui-combobox" >
              </select>
              <select id="proProvince" name="proProvince" style="width: 80px;" class="easyui-combobox" >
              </select>
              <select id="proCity" name="proCity" style="width: 80px;" class="easyui-combobox" >
              </select>
              </td>
            </tr>
            <tr class="tablecolumn" >
              <th>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</th>
              <td colspan="3"><textarea name="proEquipment" cols="" rows="">${proInfo.proEquipment }</textarea></td>
            </tr>
          </table>
          <p>
            <label> <b>客户信息</b></label> 
          </p>
          <table border="0" class="edit-table">
            <tr>
              <th scope="row">承租单位</th>
              <td width="300px">
               <select id="customerInfo" name="customerInfo" class="easyui-combobox" >
               </select>
              <a class="button button_position" onClick="openwin()" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a>
              </td>
              <th>客户编号</th>
              <td><input id="customerNo" type="text" /></td>
            </tr>
            <tr >
              <th>联系人</th>
              <td><input id="cusConto" type="text" value=""/></td>
              <th>联系人手机</th>
              <td><input id="cusPhone" type="text" />(手机格式:13900000000)</td>
            </tr>
          </table>
          <p>
            <label> <b> 设备需求信息</b></label>
            <a class="button button_position" onclick="addTr()" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a></p>
          <table>
            <thead>
              <tr>
                <th scope="col" class="chebox">项次</th>
                <th  scope="col">塔机型号</th>
                <th  scope="col">塔机样式</th>
                <th  scope="col">大臂长度(米)</th>
                <th  scope="col">方案高度(米)</th>
                <th  scope="col" class="picture1" style="width: 50px;">操作</th>
              </tr>
            </thead>
            <tbody id="newDevice">
              <c:forEach items="${list }" var="device" varStatus="num">
              <tr>
              <td>${num.index+1 }<input type="hidden" value="${device.id }"/></td>
              <td>${device.goodName }</td>
              <td>${device.goodUnit }</td>
              <td>${device.goodWeight }</td>
              <td>${device.goodCube }</td>
              <td><a href="#" onClick="removeDevice(this);" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" title="删除"/></a></td>
              </tr>
              </c:forEach>
            </tbody>
            <tfoot style="display: none;">
            <tr id="device">
            <td></td>
            <td><select id="towerCase">
            <option  value="F0/23B-10T">F0/23B-10T</option>
                          <option  value="FH60/15-10T" >FH60/15-10T</option>
                          <option  value="ST55/13-6T" >ST55/13-6T</option>
                          <option  value="ST5515B-8T" >ST5515B-8T</option>
                          <option value="ST60/15-10T" >ST60/15-10T</option>
                          <option value="ST70/27-16T" >ST70/27-16T</option>
                          <option value="ST70/30-12T" >ST70/30-12T</option>
                          <option value="STT133-6T" >STT133-6T</option>
                          <option value="STT200-10T" >STT200-10T</option>
                          <option value="STT200-12T" >STT200-12T</option>
                          <option value="STT293-12T" >STT293-12T</option>
                          <option value="STT293-18T" >STT293-18T</option>
                          <option value="STT403-24T" >STT403-24T</option>
                          <option value="STT553-24T" >STT553-24T</option>
            </select></td>
            <td><select id="towerType">
              <option value="固定式">固定式</option>
              <option value="内爬式">内爬式</option>
              <option value="行走式">行走式</option>
              <option value="附着式">附着式</option>
              <option  value="固定式+行走式">固定式+行走式</option>
            </select></td>
            <td><input type="text"/></td>
            <td><input type="text"/></td>
            <td><a class="add" onclick="setValueFun(this);"><img src="<%=basePath %>static/images/icons/pencil.png" title="编辑"/></a><a href="#" onClick="delTr(this);" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" title="删除"/></a></td>
            </tr>
            </tfoot>
          </table>
          <table class="edit-table" border="0">
            <tr>
              <td>&nbsp;</td>
              <td colspan="5">
              <a id="submitButton" class="button_new" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a> 
              <a class="button_new" href="<%=basePath %>project/init/1" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a>
              </td>
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
 <script type="text/javascript">

function openwin(){
window.open('<%=basePath %>customer/addInitByProject','newwindow','height=500,width=950,top=100,left=300,toolbar=0,menubar=0,scrollbar=yes,resizable=yes,location=no,status=no')
}

 </script>
</html>