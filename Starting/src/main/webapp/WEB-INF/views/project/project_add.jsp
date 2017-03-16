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
<script type="text/javascript" src="<%=basePath %>static/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<SCRIPT src="<%=basePath %>static/js/jQselect.js" type=text/javascript></SCRIPT>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<script type="text/javascript" src='<%=basePath %>static/js/UTIL.js'></script>
<script type="text/javascript" src='<%=basePath %>static/js/json2.js'></script>
<SCRIPT type=text/javascript>
	var trNum = 0;
	var idNum = 0;
	var isUnSub = 0;
	var isReloadPro,isReloadCust = 0;
	$(document).ready(function() {
		$('#manageDepartmentId').combobox({
			url:'<%=basePath %>department/ajax',
			valueField:'id',
			textField:'departmentName'
		});
		$('#proArea').combobox({
			url:'<%=basePath %>area/getAreainfo?areaType=1',
			valueField:'areaCode',
			textField:'areaName',
			onSelect:function(rec){
				//alert(JSON.stringify(rec));
				$('#proProvince').combobox('clear');
				$('#proCity').combobox('clear');
				var url = '<%=basePath %>area/getAreainfo?areaType=2&areaCode='+rec.areaCode;
				$('#proProvince').combobox('reload', url);
			}
		});
		$('#proProvince').combobox({
			url:'<%=basePath %>area/getAreainfo?areaType=2',
			valueField:'areaCode',
			textField:'areaName',
			onSelect:function(rec){
				//alert(JSON.stringify(rec));
				$('#proCity').combobox('clear');
				var url = '<%=basePath %>area/getAreainfo?areaType=3&areaCode='+rec.areaCode;
				$('#proCity').combobox('reload', url);
			}
		});
		$('#proCity').combobox({
			url:'<%=basePath %>area/getAreainfo?areaType=3',
			valueField:'areaCode',
			textField:'areaName'
		});
		$("#contractStatus").combobox({
			url:"<%=basePath %>dictionary/selectByDictCode?dict_code=XMZT",
			valueField: 'dict_name',
			textField: 'dict_value',
			onLoadSuccess:function(){
				$('#contractStatus').combobox('setValue','0');
			}
		});
		$("#proType").combobox({
			url:"<%=basePath %>dictionary/selectByDictCode?dict_code=XMLX",
			valueField: 'dict_name',
			textField: 'dict_value'
		});
		$("#proStatus").combobox({
			url:"<%=basePath %>dictionary/selectByDictCode?dict_code=XMZT",
			valueField: 'dict_name',
			textField: 'dict_value',
			onLoadSuccess:function(){
				$('#proStatus').combobox('setValue','0');
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
				if(1 > isReloadCust){
					$('#customerInfo').combobox('setValue','${customerId}');
					var id = $('#customerInfo').combobox('getValue');
					setCustomerInfo(id);
				}
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
				if(1 > isReloadPro){
					$('#projectId').combobox('setValue','${projectId}');
					var id = $('#projectId').combobox('getValue');
					setProjectInfo(id);
				}
			}
		});
		
		//$("#proType").selectbox();
		//$("#proStatus").selectbox();
		//$("#proCompany").selectbox();
		$("#submitButton").on("click",function(){
			if(tatongMethod.isChecked()){
				onProjectSubmit();
			}
		});
		if(!isEmpty('${leaseId}')){
			addTr();
		}
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
					$('#proType ').combobox('setValue',jsonData.proType);
					$('#proStatus ').combobox('setValue',jsonData.proStatus);
					$('#proArea ').combobox('setValue',jsonData.proArea);
					$('#proProvince ').combobox('setValue',jsonData.proProvince);
					$('#proCity ').combobox('setValue',jsonData.proCity);
				}
			}
		});
	}
	
	function addTr(){
		trNum++;
		var sourceNode = document.getElementById("device"); // 获得被克隆的节点对象 
		var clonedNode = sourceNode.cloneNode(true); // 克隆节点 
		clonedNode.setAttribute("id", "deviceDetailTr-" + idNum); // 修改一下id 值，避免id 重复 
		//sourceNode.parentNode.appendChild(); // 在父节点插入克隆的节点 
		$(clonedNode).find('td:eq(0)').text(trNum);
		$(clonedNode).find('td:eq(1)').children('select').attr("id","assetName"+idNum);
		$(clonedNode).find('td:eq(2)').children('select').attr("id","towerModel"+idNum);
		$('#newDevice').append(clonedNode);
		//url:'<%=basePath %>tower/towerType',
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
		if(!isEmpty('${leaseId}')){
			$("#towerModel"+idNum).combobox('setValue','${towerModel}');
			$("#assetName"+idNum).combobox('setValue','塔式起重机');
		}
		idNum++;
	}
	
	function delTr(obj){
		$.messager.confirm('设备需求', '您确定移除当前设备需求？', function (yes) {
			if(yes == true){
				trNum--;
				$(obj).parent().parent().remove();
			}
		});
	}
	
	function onProjectSubmit(){
		var length = document.getElementById('newDevice').getElementsByTagName('tr').length;
		if(1 > length){
			$.messager.confirm('设备需求', '当前未添加设备需求信息，您是否继续保存？', function (yes) {
				if(yes == true){
					setJsonDate();
				}
			});
		}else{
			setJsonDate();
		}
	}
	function setJsonDate(){
		if(isUnSub>0){
			return;//防止重复提交
		}
		var newDevice = document.getElementById('newDevice');
		var length = document.getElementById('newDevice').getElementsByTagName('tr').length;
		var tr;
		var value = '';
		var id = '';
		var jsonData = [];
		for (var i = 0; i < length; i++) {
			var data = {};
			tr = $(newDevice).find('tr:eq('+i+')');
			id = tr.find('td:eq(1)').children('select').attr('id');
			value = $('#'+id).combobox('getValue');
			
			if(isEmpty(value)){
				$.messager.alert('错误','资产名称不能为空!','error');
				return;
			}
			data.productName=value;
			id = tr.find('td:eq(2)').children('select').attr('id');
			value = $('#'+id).combobox('getValue');
			if(!isEmpty(value)){
				data.towerModel=value;
			}
			jsonData[i]=data;
		}
		$('#jsonList').val(JSON.stringify(jsonData));
		
		isUnSub++;
		$.ajax({
			async : false,
			cache : false,
			type : 'POST',
			data :$("#conProForm").serialize(),
			url :'<%=basePath %>contractPro/addSave',
			error : function() {// 请求失败处理函数
				isUnSub--;
				$.messager.alert('错误','保存请求提交失败!','error');
			},
			success : function(data){
				if('n' == data){
					isUnSub--;
					$.messager.alert('失败','项目信息保存失败!','error');
				}else{
					if(!isEmpty('${leaseId}')){
						editLeaseInfo();
					}else{
						$.messager.alert('成功','项目信息保存入库成功!','info',function(){
							window.location.href = '<%=basePath %>contractPro/init/2';
						});
					}
				}
			}
		});
	}
	
	function editLeaseInfo(){
		$.ajax({
			async : false,
			cache : false,
			type : 'POST',
			data :{"leaseId":'${leaseId }'},
			url :'<%=basePath %>project/leaseToContract',
			error : function() {// 请求失败处理函数
				$.messager.alert('错误','保存请求提交失败!','error');
			},
			success : function(data){
				if('n' == data){
					$.messager.alert('失败','租赁意向转项目失败!','error');
				}else{
					$.messager.alert('成功','租赁意向转项目成功!','info',function(){
						<%-- /*window.location.href = '<%=basePath %>project/init/4';*/ --%>
						window.location.href = '<%=basePath %>contractPro/init/2';
					});
				}
			}
		});
	}
	
	function checkValue(obj){
		var value = $(obj).val();
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
	</SCRIPT>
</head><body>
<jsp:include page="../header-bar.jsp"/>
<div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>新增合同信息</h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form id="conProForm" method="post">
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
              <input name="contractNo" type="text" onblur="checkValue(this);" required="true" onpaste="return true" ondragenter="return false" oncontextmenu="return false;" style="ime-mode:disabled"/>
              <input id="jsonList" name="jsonList" type="hidden"/>
              </td>
              <th></th>
              <td></td>
            </tr>
            <tr>
              <th>合同状态</th>
              <td>
              <select id="contractStatus" name="contractStatus" class="easyui-combobox" style="width: 140px;">
              </select>
              </td>
              <th>管理单位</th>
              <td>
              <select id="manageDepartmentId" name="manageDepartmentId" style="width: 140px;" class="easyui-combobox">
              </select>
              </td>
            </tr>
            <tr >
              <th>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</th>
              <td colspan="5"><textarea name="remark" cols="" rows=""></textarea></td>
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
            </tr>
          </table>
          
          <p>
            <label> <b> 设备需求信息</b></label>
            <a class="button button_position" onclick="addTr();" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a></p>
            <div style="overflow: auto;HEIGHT: 150px;">
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
            <%-- <a class="edit" onclick="setValueFun(this);"><img src="<%=basePath %>static/images/icons/pencil.png" title="编辑"/></a> --%>
            <a href="#" onClick="delTr(this);" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" title="删除"/></a></td>
            </tr>
            </tfoot>
          </table>
          </div>
          <table  class="edit-table" border="0">
            <tr>
              <td>&nbsp;</td>
              <td colspan="5"><a id="submitButton" class="button_new" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a> <a class="button_new" href="<%=basePath %>contractPro/init/2" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a> </td>
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
		var resultValue =  window.showModalDialog('<%=basePath %>customer/addInitByProject','',"dialogWidth=1200px;dialogHeight=550px");
		if(!isEmpty(resultValue)){
			isReloadCust = 1;
			setCustomerInfo(resultValue);
			$('#customerInfo').combobox('reload','<%=basePath %>customer/ajax');
			$('#customerInfo').combobox('setValue',resultValue);
		}
	}
	function openProject(){
		var resultValue =  window.showModalDialog('<%=basePath %>project/addInitToWind','',"dialogWidth=1200px;dialogHeight=550px");
		if(!isEmpty(resultValue)){
			isReloadPro = 1;
			setProjectInfo(resultValue);
			$('#projectId').combobox('reload','<%=basePath %>project/loadProInfoToCombox');
			$('#projectId').combobox('setValue',resultValue);
		}
	}
 </script>
</html>