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
		
		$('#dispatchId').combobox({
			url:'<%=basePath %>company/manageCompanyCombox',
			valueField:'id',
			textField:'companyShortName',
			onLoadSuccess:function(){
				$('#dispatchId').combobox('setValue','${proInfo.dispatchId}');
			}
		});
		$('#manageId').combobox({
			url:'<%=basePath %>department/ajax',
			valueField:'id',
			textField:'departmentName',
			onLoadSuccess:function(){
				$('#manageId').combobox('setValue','${proInfo.manageDepartmentId}');
			}
		});
		
		$('#proArea').combobox({
			url:'<%=basePath %>area/getAreainfo?areaType=1',
			valueField:'areaCode',
			textField:'areaName'
		});
		
		$('#proProvince').combobox({
			url:'<%=basePath %>area/getAreainfo?areaType=2',
			valueField:'areaCode',
			textField:'areaName'
		});
		
		$('#proCity').combobox({
			url:'<%=basePath %>area/getAreainfo?areaType=3',
			valueField:'areaCode',
			textField:'areaName'
		});
		
		$('#customerInfo').combobox({
			url :'<%=basePath %>customer/ajax',
			valueField:'id',
			textField:'customerCnName',
			onSelect:function(rec){
				setCustomerInfo(rec.id);
			},
			onLoadSuccess:function(){
				$('#customerInfo').combobox('setValue','${proInfo.customerId}');
				var id = $('#customerInfo').combobox('getValue');
				setCustomerInfo(id);
			}
		});
		$('#projectId').combobox({
			url:'<%=basePath %>project/loadProInfoToCombox',
			valueField:'id',
			textField:'proName',
			onSelect:function(rec){
				setProjectInfo(rec.id);
			},
			onLoadSuccess:function(){
				$('#projectId').combobox('setValue','${proInfo.proId}');
				var id = $('#projectId').combobox('getValue');
				setProjectInfo(id);
			}
		});
		$("#contractStatus").combobox({
			url:"<%=basePath %>dictionary/selectByDictCode?dict_code=XMZT",
			valueField: 'dict_name',
			textField: 'dict_value',
			onLoadSuccess:function(){
				$('#contractStatus').combobox('setValue','${proInfo.contractStatus}');
			}
		});
		$('#proStatus').combobox({
			url:"<%=basePath %>dictionary/selectByDictCode?dict_code=XMZT",
			valueField: 'dict_name',
			textField: 'dict_value'
		});
		$("#proType").combobox({
			url:"<%=basePath %>dictionary/selectByDictCode?dict_code=XMLX",
			valueField: 'dict_name',
			textField: 'dict_value'
		});
		
		$("#submitButton").on("click",function(){
			if(tatongMethod.isChecked()){
				onProjectSubmit();
			}
		});
		
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
					$("#cusEmail").val(jsonData.email);
				}
			}
		});
	}
	
	function setProjectInfo(id){
		$.ajax({
			async : false,
			cache : false,
			type : 'POST',
			data:{"projectId":id},
			url :'<%=basePath %>project/findAjax',
			error : function() {// 请求失败处理函数
				$.messager.alert('错误','查询客户请求失败!','error');
			},
			success : function(data){
				var jsonData = JSON.parse(data);
				if(jsonData != null){
					$("#proShortName ").val(jsonData.proShortName );
					$("#proHeight ").val(jsonData.proHeight );
					$("#proAddress").val(jsonData.proAddress);
					$('#proType').combobox('setValue',jsonData.proType);
					$('#proStatus').combobox('setValue',jsonData.proStatus);
					$('#proArea').combobox('setValue',jsonData.proArea);
					$('#proProvince').combobox('setValue',jsonData.proProvince);
					$('#proCity').combobox('setValue',jsonData.proCity);
				}
			}
		});
	}
	
	function removeIsopen(obj){
		var ids;
		var id = $(obj).parent().parent().attr('id');//取出行id
		for (var i = 0; i < isopen.length; i++) {
			ids = isopen[i];
			if(ids == id){
				isopen.splice(i,1);//只删除下标为 i 的 1 个元素
			}
		}
	}
	
	function addTr(){
		trNum++;
		var sourceNode = document.getElementById("device"); // 获得被克隆的节点对象 
		var clonedNode = sourceNode.cloneNode(true); // 克隆节点 
		clonedNode.setAttribute("id", "deviceDetailTr-" + idNum); // 修改一下id 值，避免id 重复 
		isopen.push("deviceDetailTr-" + idNum);//打开新建tr，需要确认后才能保存
		//sourceNode.parentNode.appendChild(); // 在父节点插入克隆的节点 
		$(clonedNode).find('td:eq(0)').text(trNum);
		$(clonedNode).find('td:eq(1)').children('select').attr("id","assetName"+idNum);
		$(clonedNode).find('td:eq(2)').children('select').attr("id","towerModel"+idNum);
		$('#newDevice').append(clonedNode);
		$("#towerModel"+idNum).combobox({
			url:"<%=basePath %>dictionary/selectByDictCode?dict_code=TJXH",
			valueField: 'dict_value',
			textField: 'dict_value'
		});
		$("#assetName"+idNum).combobox({
			url:"<%=basePath %>dictionary/selectByDictCode?dict_code=ZCMC",
			valueField: 'dict_value',
			textField: 'dict_value'
		});
		idNum++;
	}
	function showMessager(title,msg){
		$.messager.show({
			title:title,msg:msg,
			timeout:3000,showType:'show'
		});
	}
	function setValueFun(obj){
		
		//取input值set到td文本
		var id = $(obj).parent().parent().find('td:eq(1)').children('select').attr('id');
		var value = $("#"+id).combobox('getValue');
		if(isEmpty(value)){
			$.messager.alert('错误','资产名称不能为空!','error');
			return false;
		}
		
		$(obj).parent().parent().find('td:eq(0)').text(trNum);
		$(obj).parent().parent().find('td:eq(1)').text(value);
		id = $(obj).parent().parent().find('td:eq(2)').children('select').attr('id');
		value = $("#"+id).combobox('getValue');
		$(obj).parent().parent().find('td:eq(2)').text(value);
		$(obj).remove();
		removeIsopen(obj);//关闭新建tr，得到确认，要所有新建tr都关闭才能保存
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
		/* if(isopen.length > 0){
			$.messager.alert('设备需求','设备需求编辑未保存，<br/>请点击右侧编辑按钮完成编辑操作!','error');
			return;
		} */
		var id;
		var forArray = new Array();
		for(var i=0;i<isopen.length;i++){
			forArray.push(isopen[i]);
		}
		for(var i=0;i<forArray.length;i++){
			id = forArray[i];
			var obj = $('#'+id).find('td:eq(8)').children('a')[0];
			var flag = setValueFun(obj);
			if(flag == false){
				return;//有空值，结束提交方法
			}
		}
		setJsonDate();
	}
	
	function setJsonDate(){
		var newDevice = document.getElementById('newDevice');
		var length = document.getElementById('newDevice').getElementsByTagName('tr').length;
		var tr;
		var jsonData = [];
		var data;
		for (var i = 0; i < length; i++) {
			data = {};
			tr = $(newDevice).find('tr:eq('+i+')');
			if(isEmpty(tr.find('td:eq(1)').text())){
				$.messager.alert('错误','资产名称不能为空!','error');
				return;
			}
			data.productName=tr.find('td:eq(1)').text();
			if(!isEmpty(tr.find('td:eq(2)').text())){
				data.towerModel=tr.find('td:eq(2)').text();
			}
			jsonData[i]=data;
		}
		$('#jsonList').val(JSON.stringify(jsonData));
		$.ajax({
			async : false,
			cache : false,
			type : 'POST',
			data :$("#projectEditForm").serialize(),
			url :'<%=basePath %>contractPro/editSave',
			error : function() {// 请求失败处理函数
				$.messager.alert('错误','保存请求提交失败!','error');
			},
			success : function(data){
				if('n' == data){
					$.messager.alert('失败','合同信息保存失败!','error');
				}else{
					$.messager.alert('成功','合同信息保存入库成功!','info',function(){
						window.location.href = '<%=basePath %>contractPro/init/2';
					});
				}
			}
		});
	}
	function openwin(){
		var resultValue =  window.showModalDialog('<%=basePath %>customer/addInitByProject','',"dialogWidth=1200px;dialogHeight=550px");
		setCustomerInfo(resultValue);
	}
	function openProject(){
		var resultValue =  window.showModalDialog('<%=basePath %>project/addInitToWind','',"dialogWidth=1200px;dialogHeight=550px");
		setProjectInfo(resultValue);
	}
	function checkValue(obj){
		var value = $(obj).val();
		var curNo = '${proInfo.contractNo }';
		if(curNo == value){
			return;//没有编辑就不验证
		}
		if(isEmpty(value) == false){
			$.ajax({
				async : false,
				cache : false,
				type : 'POST',
				data :{"contractNo":value},
				url :'<%=basePath %>contractPro/checkContractNo',
				error : function() {// 请求失败处理函数
					$.messager.alert('错误','编号验证请求提交失败!','error');
				},
				success : function(data){
					if('n' == data){
						$.messager.alert('失败','合同编号重复,请重新填写新的编号!','error',function(){
							$(obj).val('');
						});
					}
				}
			});
		}
	}
	</script>
</head><body>
<jsp:include page="../header-bar.jsp"/>
<div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>编辑合同信息</h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form id="projectEditForm" method="post">
          <p>
            <label> <b>客户信息</b></label> 
          </p>
          <table border="0" class="edit-table">
            <tr>
              <th scope="row">承租单位</th>
              <td width="300px">
              <select id="customerInfo" name="customerId" style="width: 140px;" class="easyui-combobox" >
              </select>
              <a class="button button_position" onClick="openwin()" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a>
               </td>
              <th>客户编号</th>
              <td><input readonly="readonly" id="customerNo" type="text" /></td>
              <th></th>
              <td></td>
            </tr>
            <tr >
              <th>联系人</th>
              <td><input readonly="readonly" id="cusConto" type="text" /></td>
              <th>联系人手机</th>
              <td><input readonly="readonly" id="cusPhone" type="text" /></td>
              <th>邮箱</th>
              <td><input readonly="readonly" id="cusEmail" type="text" /></td>
            </tr>
          </table>
          <p>
            <label> <b>合同信息</b></label> 
          </p>
          <table border="0" class="edit-table">
            <tr>
              <th scope="row"><label><b>*</b>合同编号 </label></th>
              <td width="300px">
              <input name="contractNo" type="text" value="${proInfo.contractNo }" onblur="checkValue(this);" required="true" onpaste="return true" ondragenter="return false" oncontextmenu="return false;" style="ime-mode:disabled"/>
              <input name="id" type="hidden" value="${proInfo.id }"/>
              <input id="delDeviceId" type="hidden" name="delDeviceId"/>
              <input id="jsonList" name="jsonList" type="hidden"/>
              </td>
              <th>合同状态</th>
              <td>
              <select id="contractStatus" disabled="disabled" name="contractStatus" class="easyui-combobox" style="width: 140px;">
              </select>
              </td>
            </tr>
            <tr>
              <th>所属公司</th>
              <td>
              <select id="dispatchId" name="dispatchId" style="width: 140px;" class="easyui-combobox">
              </select>
              </td>
              <th>管理单位</th>
              <td>
              <select id="manageId" name="manageDepartmentId" style="width: 140px;" class="easyui-combobox">
              </select>
              </td>
            </tr>
            <tr >
              <th>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</th>
              <td colspan="5"><textarea name="remark" cols="" rows="">${proInfo.remark }</textarea></td>
            </tr>
          </table>
          <p>
            <label> <b>项目信息</b></label> 
          </p>
          <table border="0" class="edit-table">
            <tr>
              <th scope="row"><label><b>*</b>项目名称 </label></th>
              <td width="300px">
              <select id="projectId" name="proId" style="width: 140px;" class="easyui-combobox">
              </select>
              <a class="button button_position" onClick="openProject()" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a>
              </td>
              <th><label><b>*</b>项目简称</label></th>
              <td>
              <input id="proShortName" readonly="readonly"/>
              </td>
              <th></th>
              <td></td>
            </tr>
            <tr>
            <th>项目类型</th>
              <td>
              <select id="proType" disabled="disabled" name="proType" style="width: 140px;" class="easyui-combobox" >
              </select>
              </td>
              <th>项目状态</th>
              <td>
              <select id="proStatus" disabled="disabled" name="proStatus" class="easyui-combobox" style="width: 140px;">
              </select>
              </td>
              <th>项目高度</th>
              <td>
              <input id="proHeight" readonly="readonly" name="proHeight" />
              </td>
            </tr>
            <tr >
              <th><label><b>*</b>项目地点</label></th>
              <td colspan="5">
              <select id="proArea" disabled="disabled" name="proArea" style="width: 80px;" class="easyui-combobox" >
              </select>
              <select id="proProvince" disabled="disabled" name="proProvince" style="width: 80px;" class="easyui-combobox" >
              </select>
              <select id="proCity" disabled="disabled" name="proCity" style="width: 80px;" class="easyui-combobox" >
              </select>
              <input id="proAddress" readonly="readonly" style="background-color: white;"/>
              </td>
            </tr>
          </table>
          <p>
            <label> <b> 设备需求信息</b></label>
            <a class="button button_position" onclick="addTr()" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a></p>
          <table>
            <thead>
              <tr>
                <th scope="col" class="chebox">项次</th>
                <th  scope="col">资产名称</th>
                <th  scope="col">塔机型号</th>
                <th  scope="col">塔机编号</th>
                <th  scope="col">出厂编号</th>
                <th  scope="col">安装方式</th>
                <th  scope="col">大臂长度(米)</th>
                <th  scope="col">方案高度(米)</th>
                <th  scope="col" class="picture1" style="width: 50px;">操作</th>
              </tr>
            </thead>
            <tbody id="newDevice">
              <c:forEach items="${list }" var="device" varStatus="num">
              <tr>
              <td>${num.index+1 }</td>
              <td>${device.productName }</td>
              <td>${device.towerModel }</td>
              <td>${device.towerNo }</td>
              <td>${device.createNo }</td>
              <td>${device.setupType }</td>
              <td>${device.dbcd }</td>
              <td>${device.fagd }</td>
              <td>
              <c:if test="${device.dbcd == null}">
              <a href="#" onclick="removeDevice(this);" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" title="删除"/></a>
              </c:if>
              </td>
              </tr>
              </c:forEach>
            </tbody>
            <tfoot style="display: none;">
            <tr id="device">
            <td></td>
            <td><select></select></td>
            <td><select></select></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td>
            <%-- <a class="add" onclick="setValueFun(this);"><img src="<%=basePath %>static/images/icons/pencil.png" title="编辑"/></a> --%>
            <a href="#" onClick="delTr(this);" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" title="删除"/></a></td>
            </tr>
            </tfoot>
          </table>
          <table class="edit-table" border="0">
            <tr>
              <td>&nbsp;</td>
              <td colspan="5">
              <a id="submitButton" class="button_new" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a> 
              <a class="button_new" href="<%=basePath %>contractPro/init/2" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a>
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
</html>