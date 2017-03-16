<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath =  path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>leap系统</title>
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

<script src="<%=basePath %>static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<script type="text/javascript" src='<%=basePath %>static/js/UTIL.js'></script>
<script type="text/javascript" src='<%=basePath %>static/js/json2.js'></script>
<SCRIPT type=text/javascript>
	var isOpenTr = false;
	var isUnSub = 0;
	$(document).ready(function() {
		$('#customerId').combobox({
			url:'<%=basePath %>company/outside',
			valueField:'id',
			textField:'companyShortName'
		});
		
		$("#submitButton").on("click",function(){
			if(tatongMethod.isChecked()){
				onPurchaseSubmit();
			}
		});
		$("#assetOriginAdd").on("click",function(){
			findTowerByDispatchNo();
		});
	});
	
	var trNum = 0;
	function addTr(data){
		trNum++;
		var sourceNode = document.getElementById("cloneNodeTr"); // 获得被克隆的节点对象 
		var clonedNode = sourceNode.cloneNode(true); // 克隆节点 
		clonedNode.setAttribute("id", "deviceDetailTr-" + trNum); // 修改一下id 值，避免id 重复 
		//sourceNode.parentNode.appendChild(); // 在父节点插入克隆的节点 
		$(clonedNode).find('td:eq(1)').children('select').attr("id","assetName"+trNum);
		$(clonedNode).find('td:eq(2)').children('select').attr("id","createFactry"+trNum);
		$(clonedNode).find('td:eq(3)').children('select').attr("id","assetModel"+trNum);
		$(clonedNode).find('td:eq(4)').children('select').attr("id","assetType"+trNum);
		$(clonedNode).find('td:eq(5)').children('select').attr("id","address"+trNum);
		$(clonedNode).find('td:eq(0)').text(trNum);
		$('#cloneNodeTbody').append(clonedNode);
		
		$("#createFactry"+trNum).combobox({
			url:"<%=basePath %>dictionary/selectByDictCode?dict_code=SCCJ",
			valueField: 'id',
			textField: 'dict_value'
		});
		$("#assetName"+trNum).combobox({
			url:"<%=basePath %>dictionary/selectByDictCode?dict_code=ZCMC",
			valueField: 'dict_value',
			textField: 'dict_value'
		});
		$("#assetModel"+trNum).combobox({
			url:"<%=basePath %>dictionary/selectByDictCode?dict_code=TJXH",
			valueField: 'dict_value',
			textField: 'dict_value'
		});
		
		$("#assetType"+trNum).combobox({
			url:"<%=basePath %>dictionary/selectByDictCode?dict_code=TJYS",
			valueField: 'dict_value',
			textField: 'dict_value'
		});
		$("#assetType"+trNum).combobox({
			url:"<%=basePath %>dictionary/selectByDictCode?dict_code=TJYS",
			valueField: 'dict_value',
			textField: 'dict_value'
		});
		
		$("#address"+trNum).combobox({
			url:"<%=basePath %>warehouse/queryCombox",
			valueField: 'id',
			textField: 'storeName'
		});
		
		
		if(!isEmpty(data)){
			$(clonedNode).find('td:eq(0)').attr("title",data.id);
			//记录调度单号用于对每一条资产查询零部件模板，因为一个调度单只能调度一台塔机资产
			$(clonedNode).find('td:eq(1)').children('input').val(data.dispatchId);
			$("#createFactry"+trNum).combobox('setValue',data.towerCreatecompany);
			$("#assetName"+trNum).combobox('setValue','塔式起重机');//默认是塔机
			$("#assetModel"+trNum).combobox('setValue',data.towerModel);
			$("#assetType"+trNum).combobox('setValue',data.towerType);
		}
	}
	
	/*function setValueFun(obj){
		var address = $(obj).parent().parent().find('td:eq(5)').children('input').val();
		if(isEmpty(address)){
			$(obj).parent().parent().find('td:eq(5)').children('input').focus();//光标自动聚焦
			$.messager.alert('提示','资产到货地点不能为空!','error');
			return false;
		}
		trNum++;
		 //取input值set到td文本
		$(obj).parent().parent().find('td:eq(0)').text(trNum);
		$(obj).parent().parent().find('td:eq(1)').text($(obj).parent().parent().find('td:eq(1)').children('input').val());
		var value = $(obj).parent().parent().find('td:eq(2)').children('select').val();
		$(obj).parent().parent().find('td:eq(2)').attr('title',value);
		$(obj).parent().parent().find('td:eq(2)').text($(obj).parent().parent().find('td:eq(2)').children('select').text());
		$(obj).parent().parent().find('td:eq(3)').text($(obj).parent().parent().find('td:eq(3)').children('select').val());
		$(obj).parent().parent().find('td:eq(4)').text($(obj).parent().parent().find('td:eq(4)').children('select').val());
		$(obj).parent().parent().find('td:eq(5)').text($(obj).parent().parent().find('td:eq(5)').children('input').val()); 
		//自动带出塔机信息，只需填写到货地点
		$(obj).parent().parent().find('td:eq(5)').text($(obj).parent().parent().find('td:eq(5)').children('input').val());
		$(obj).remove();
		isOpenTr = false;
		return true;
	}*/
	
	function delTr(obj){
		$.messager.confirm('资产信息', '您确定移除当前资产信息？', function (yes) {
			if(yes == true){
				trNum--;
				$(obj).parent().parent().remove();
			}
		});
	}
	
	function onPurchaseSubmit(){
		var id;
		var text;
		var value;
		var type;
		var isSubmit = 1;//1提交 0禁止提交
		var name = '';
		var newDevice = document.getElementById('cloneNodeTbody');
		var length = document.getElementById('cloneNodeTbody').getElementsByTagName('tr').length;
		if(1 > length){//没有资产信息
			var flag = findTowerByDispatchNo();
			if(flag == false){
				$.messager.show({
					title:'添加资产',
					msg:'当前未添加资产信息，请添加资产信息!',
					timeout:3000,
					showType:'show'
				});
				return;
			}
		}
		
		var tr;
		var jsonData = [];
		for (var i = 0; i < length; i++) {
			var data = {};
			tr = $(newDevice).find('tr:eq('+i+')');
			id = tr.find('td:eq(1)').children('select').attr("id");
			value = $('#'+id).combobox("getText");
			type = $('#'+id).combobox("getText");
			if(isEmpty(value)){
				jsonData = [];
				$.messager.alert('资产信息','资产名称不能为空，请选择资产名称!','error');
				return;
			}else{
				data.productName = value;
			}
			
			id = tr.find('td:eq(2)').children('select').attr("id");
			value = $('#'+id).combobox("getValue");
			if(isEmpty(value) && type != '零部件'){
				jsonData = [];
				$.messager.alert('资产信息','生产厂家不能为空，请选择生产厂家!','error');
				return;
			}else if(!isEmpty(value)){
				data.manufacturer = value;
			}
			//塔机零部件数据-towerPartsJson
			if("[]" == tr.find('td:eq(6)').children('input').val()){
				name = tr.find('td:eq(1)').text();
				isSubmit = 0;
			}else{
				data.towerPartsJson = tr.find('td:eq(6)').children('input').val();
			}
			id = tr.find('td:eq(3)').children('select').attr("id");
			value = $('#'+id).combobox("getValue");
			if(isEmpty(value) && type != '零部件'){
				jsonData = [];
				$.messager.alert('资产信息','规格型号不能为空，请选择规格型号!','error');
				return;
			}else if(!isEmpty(value)){
				data.specification = value;
			}
			
			id = tr.find('td:eq(4)').children('select').attr("id");
			value = $('#'+id).combobox("getValue");
			if(isEmpty(value) && type != '零部件'){
				jsonData = [];
				$.messager.alert('资产信息','塔机样式不能为空，请选择塔机样式!','error');
				return;
			}else if(!isEmpty(value)){
				data.towerType = value;
			}
			
			id = tr.find('td:eq(5)').children('select').attr("id");
			text = $('#'+id).combobox("getText");
			value = $('#'+id).combobox("getValue");
			if(isEmpty(value)){
				jsonData = [];
				$.messager.alert('资产信息','到货地点不能为空，请填写到货地点!','error');
				return;
			}else{
				data.receivingBy = value;
				data.arrivalPlace = text;
			}
			jsonData[i] = data;
		}
		$('#towerJson').val(JSON.stringify(jsonData));
		if(isSubmit == 0){
			$.messager.confirm('零部件', '塔机资产:'+name+'的零部件为空!您确定继续保存？', function (yes) {
				if(yes == true){
					onSubmit();
				}else{
					jsonData = [];
				}
			});
		}else{
			onSubmit();
		}
	}
	
	function onSubmit(){
		if(isUnSub>0){
			return;//防止重复提交
		}
		isUnSub++;
		$.ajax({
			async : false,
			cache : false,
			type : 'POST',
			data :$("#purchaseForm").serialize(),
			url :'<%=basePath %>purchase/addRental',
			error : function() {// 请求失败处理函数
				isUnSub--;
				$.messager.alert('错误','保存请求提交失败!','error');
			},
			success : function(data){
				if('n' == data){
					isUnSub--;
					$.messager.alert('失败','外租合同保存失败!','error');
				}else{
					$.messager.alert('成功','外租合同保存入库成功!','info',function(){
						window.location.href = '<%=basePath %>purchase/init/2';
					});
				}
			}
		});
	}
	
	function findTowerByDispatchNo(){
		var dispatchNo = $("#assetOrigin").val();
		if(isEmpty(dispatchNo)){
			$.messager.alert('提示','资产调度单编号不能为空!','error');
			return false;
		}
		$.ajax({
			async : false,
			cache : false,
			type : 'POST',
			data : {"dispatchNo":dispatchNo},
			url :'<%=basePath %>purchase/findTowerByDispatchNo',
			error : function() {// 请求失败处理函数
				$.messager.alert('错误','外租合同塔机资产确认请求失败!','error');
			},
			success : function(data){
				if('null' == data){
					$.messager.alert('提示','输入的调度单无法查询塔机信息!请确认输入的调度单号完全正确!','error');
				}else{
					var towerInfo = JSON.parse(data);
					if(checkTowerId(towerInfo.id) == 1){
						addTr(towerInfo);
					}
				}
			}
		});
		return true;
	}
	//检查是否重复添加资产
	function checkTowerId(id){
		var newDevice = document.getElementById('cloneNodeTbody');
		var length = document.getElementById('cloneNodeTbody').getElementsByTagName('tr').length;
		var tr;
		var value;
		var ispush = 1;//是否增加新行1是0否，已存在的塔机不再新增行
		for (var i = 0; i < length; i++) {
			tr = $(newDevice).find('tr:eq('+i+')');
			value = tr.find('td:eq(0)').attr("title");
			if(value == id){
				ispush = 0;
				$.messager.show({
					title:'添加资产',
					msg:'当前调度单资产已经自动带出，无需重复操作新增按钮!',
					timeout:3000,
					showType:'show'
				});
				break;
			}
		}
		return ispush;
	}
	function checkValue(obj){
		var value = $(obj).val();
		if(isEmpty(value) == false){
			$.ajax({
				async : false,
				cache : false,
				type : 'POST',
				data :{"contractNo":value},
				url :'<%=basePath %>purchase/checkContractNo',
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
	
	function reloadPart(obj){
		var value = $(obj).parent().children('input').val();
		if('[]' != value){
			$.ajax({
				async : false,
				cache : false,
				type : 'POST',
				data :{"json":value},
				url :'<%=basePath %>purchase/partToSession',
				error : function() {// 请求失败处理函数
					$.messager.alert('错误','零部件编辑请求发送失败!','error');
				},
				success : function(data){
					openwin(obj);
				}
			});
		}else{
			openwin(obj);
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
      <h3>新增外租合同</h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form id="purchaseForm" action="<%=basePath %>purchase/addRental" method="post">
          <table border="0" class="edit-table">
      <tr>
        <th ><label><b>*</b>合同编号</label></th>
        <td >
        <input name="contractNo" type="text" onblur="checkValue(this);" required="true" onpaste="return true" ondragenter="return false" oncontextmenu="return false;" style="ime-mode:disabled">
        <input name="towerJson" id="towerJson" type="hidden"/>
        <!-- 合同类型 1 采购合同 2 外租合同 -->
        <input type="hidden" name="contractType" value="2">
        </td>
        <th ><label><b>*</b>签订日期</label></th>
        <td ><input name="signTime" type="text" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});" required="true"/></td>
        <td></td>
      </tr>
      <tr>
        <th >资产来源</th>
        <td>
        <select name=customerId id="customerId">
        </select>
        </td>
        <%-- <th scope="row">调度单号</th>
        <td>
        <input id="assetOrigin" name="assetOrigin" > 
        <a class="button button_position" id="assetOriginAdd" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a>
        <a class="button button_position" onClick="openwin2()" title="查看"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a> 
        </td> --%>
        <td></td>
        <td></td>
        
        <td></td>
      </tr>
       <tr>
        <th scope="row">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</th>
        <td colspan="3"><textarea name="memo" id="memo" cols="25" rows="3"></textarea></td>
        <td></td>
      </tr>
    </table>
      <p>
              <label> <b> 资产信息</b></label>
              <a class="button button_position" onclick="addTr();" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a></p>
            <table>
              <thead>
                <tr>
                  <th scope="col" class="chebox"></th>
                  <th  scope="col">资产名称</th>
                  <th  scope="col">生产厂家</th>
                  <th  scope="col">规格型号</th>
                  <th  scope="col">塔机样式</th>
                  <th  scope="col">到货地点</th>
                  <th  scope="col">零部件</th>
                  <th  scope="col" class="picture2">编辑</th>
                </tr>
              </thead>
              <tbody id="cloneNodeTbody">
                
              </tbody>
            <tfoot>
            <tr>
              <td >&nbsp;</td>
              <td colspan="7"><a class="button_new" id="submitButton" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a> <a class="button_new" href="<%=basePath %>purchase/init/2" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a> </td>
            </tr>
            </tfoot>
          </table>
          <table style="display: none;">
          <tr id="cloneNodeTr">
          <td></td>
          <td>
          <select ></select>
          <!-- 此作用域为了存储调度单号，用于查询调度单零部件形成模板 -->
          <input type="hidden" />
          </td>
          <td >
          <select id=""></select>
          </td>
          <td >
          <select id="" ></select>
          </td>
          <td>
          <select id="" ></select>
          </td>
          <td>
          <select id="" ></select>
          </td>
          <td>
          <input type="hidden" value="[]">
          <a onClick="reloadPart(this);" title="新增"><img src="<%=basePath %>static/images/icons/Down-icon.png" /></a>
          </td>
          <td align="center">
          <%-- <a onclick="setValueFun(this);" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" /></a> --%>
          <a onClick="delTr(this);" ><img src="<%=basePath %>static/images/icons/cross.png" alt="Delete" /></a>
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
<script>
function openwin(obj){
	var id = $(obj).parent().parent().find('td:eq(3)').children('select').attr('id');
	var model = $('#'+id).combobox("getValue");
	model = encodeURI(encodeURI(model));
	var dispatchId = $(obj).parent().parent().find('td:eq(1)').children('input').val();
	//alert($(obj).parent().parent().html());
	id = $(obj).parent().parent().find('td:eq(1)').children('select').attr('id');
	var type = $('#'+id).combobox("getValue");
	if(isEmpty(type)){
		$.messager.alert('资产信息','资产名称为空，<br/>请选择名称再添加零部件!','error');
		return;
	}
	
	if(isEmpty(model)){
		$.messager.alert('资产信息','资产规格型号为空，<br/>请选择规格型号再添加零部件!','error');
		return;
	}
	var url = '<%=basePath %>purchase/addPartInit?dispatchId='+dispatchId+'&towerModel='+model+'&assetType='+type;
	var value = $(obj).parent().children('input').val();
	var resultValue = window.showModalDialog(url,'',"dialogWidth=1200px;dialogHeight=550px");
	if(!isEmpty(resultValue)){
		$(obj).parent().children('input').val(resultValue);
	}
}
function openwin1(){
window.open('vie_part.html','newwindow','height=600,width=980,top=100,left=100,toolbar=0,menubar=0,scrollbar=yes,resizable=yes,location=no,status=no')
}</script>
</html>