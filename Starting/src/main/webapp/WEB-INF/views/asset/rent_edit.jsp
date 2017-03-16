<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<script type="text/javascript" src="<%=basePath %>static/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery-easyui-1.4.1/plugins/jquery.dialog.js"></script>
<SCRIPT src="<%=basePath %>static/js/jQselect.js" type=text/javascript></SCRIPT>

<script src="<%=basePath %>static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<script type="text/javascript" src='<%=basePath %>static/js/UTIL.js'></script>
<script type="text/javascript" src='<%=basePath %>static/js/json2.js'></script>
<SCRIPT type=text/javascript>
	var isopen = new Array();
	var idNum = 0;
	var isUnSub = 0;
	$(document).ready(function() {
		
		$('#customerId').combobox({
			url:'<%=basePath %>company/outside',
			valueField:'id',
			textField:'companyShortName'
		});
		$('#customerId').combobox('setValue','${info.customerId}');
		
		$("#submitButton").on("click",function(){
			if(isUnSub>0){
				return;//防止重复提交
			}
			if(tatongMethod.isChecked()){
				onPurchaseSubmit();
			}
		});
		
		$("#assetOriginAdd").on("click",function(){
			editfindTowerByDispatchNo();
		});
	});
	
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
	
	var trNum = 0;
	function addTr(data){
		trNum++;
		idNum++;
		isopen.push("deviceDetailTr-" + idNum);//打开新建tr，需要确认后才能保存
		var sourceNode = document.getElementById("cloneNodeTr"); // 获得被克隆的节点对象 
		var clonedNode = sourceNode.cloneNode(true); // 克隆节点 
		clonedNode.setAttribute("id", "deviceDetailTr-" + idNum); // 修改一下id 值，避免id 重复 
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
	function showMessager(title,msg){
		$.messager.show({
			title:title,msg:msg,
			timeout:3000,showType:'show'
		});
	}
	function isEmptyValue(obj){
		//确认零部件是否为空
		if("[]" == $(obj).parent().parent().find('td:eq(6)').children('input').val()){
			showMessager('资产信息','资产信息零部件资产未选择，请选择零部件信息!');
			return false;
		}
		var id;
		var value;
		var type;
		id = $(obj).parent().parent().find('td:eq(1)').children('select').attr("id");
		value = $('#'+id).combobox("getValue");
		type = $('#'+id).combobox("getText");
		if(isEmpty(value)){
			showMessager('资产信息','资产名称不能为空，请选择资产名称!');
			return false;
		}
		id = $(obj).parent().parent().find('td:eq(2)').children('select').attr("id");
		value = $('#'+id).combobox("getValue");
		if(isEmpty(value) && type != '零部件'){
			showMessager('资产信息','生产厂家不能为空，请选择生产厂家!');
			return false;
		}
		id = $(obj).parent().parent().find('td:eq(3)').children('select').attr("id");
		value = $('#'+id).combobox("getValue");
		if(isEmpty(value) && type != '零部件'){
			showMessager('资产信息','规格型号不能为空，请选择规格型号!');
			return false;
		}
		id = $(obj).parent().parent().find('td:eq(4)').children('select').attr("id");
		value = $('#'+id).combobox("getValue");
		if(isEmpty(value) && type != '零部件'){
			showMessager('资产信息','塔机样式不能为空，请选择塔机样式!');
			return false;
		}
		id = $(obj).parent().parent().find('td:eq(5)').children('select').attr("id");
		value = $('#'+id).combobox("getValue");
		if(isEmpty(value)){
			showMessager('资产信息','到货地点不能为空，请填写到货地点!');
			return false;
		}
		return true;
	}
	function setValueFun(obj){
		var id,value,text;
		
		//验证是否有空值
		if(isEmptyValue(obj) == false){
			return false;
		}
		
		removeIsopen(obj);//关闭新建tr，得到确认，要所有新建tr都关闭才能保存
		trNum++;
		
		//取input值set到td文本
		$(obj).parent().parent().find('td:eq(0)').text(trNum);
		id = $(obj).parent().parent().find('td:eq(1)').children('select').attr("id");
		value = $('#'+id).combobox("getValue");
		
		text = $('#'+id).combobox("getText");
		$(obj).parent().parent().find('td:eq(1)').attr("title",value);
		$(obj).parent().parent().find('td:eq(1)').text(text);
		
		id = $(obj).parent().parent().find('td:eq(2)').children('select').attr("id");
		value = $('#'+id).combobox("getValue");
		
		text = $('#'+id).combobox("getText");
		$(obj).parent().parent().find('td:eq(2)').attr('title',value);
		$(obj).parent().parent().find('td:eq(2)').text(text);
		id = $(obj).parent().parent().find('td:eq(3)').children('select').attr("id");
		value = $('#'+id).combobox("getValue");
		
		$(obj).parent().parent().find('td:eq(3)').text(value);
		id = $(obj).parent().parent().find('td:eq(4)').children('select').attr("id");
		value = $('#'+id).combobox("getValue");
		
		$(obj).parent().parent().find('td:eq(4)').text(value);
		
		id = $(obj).parent().parent().find('td:eq(5)').children('select').attr("id");
		value = $('#'+id).combobox("getValue");
		text = $('#'+id).combobox("getText");
		$(obj).parent().parent().find('td:eq(5)').attr('id',value);
		$(obj).parent().parent().find('td:eq(5)').text(text);
		
		$(obj).remove();
	}
	
	function delTr(obj){
		$.messager.confirm('设备需求', '您确定移除当前资产、零部件信息？', function (yes) {
			if(yes == true){
				removeIsopen(obj);//关闭新建tr，得到确认，要所有新建tr都关闭才能保存
				trNum--;
				$(obj).parent().parent().remove();
			}
		});
	}
	
	function removes(obj){
		$.messager.confirm('设备需求', '您确定删除当前资产、零部件信息？', function (yes) {
			if(yes == true){
				var value = $('#removeId').val();
				value = value + $(obj).parent().parent().find('td:eq(0)').children('input').val()+'/'
				$('#removeId').val(value);
				$(obj).parent().parent().remove();
			}
		});
	}
	function onPurchaseSubmit(){
		var length = document.getElementById('cloneNodeTbody').getElementsByTagName('tr').length;
		if(1 > length){
			$.messager.confirm('资产信息', '当前未添加资产信息信息，您是否继续保存？', function (yes) {
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
			$.messager.alert('资产信息','资产信息编辑未保存，<br/>请点击右侧编辑按钮完成编辑操作!','error');
			return;
		} */
		var id;
		for(var i=0;i<isopen.length;i++){
			id = isopen[i];
			var obj = $('#'+id).find('td:eq(7)').children('a')[0];
			//alert(obj.nodeName);
			var flag = setValueFun(obj);
			if(flag == false){
				return;//有空值，结束提交方法
			}
		}
		setJsonDate();
	}
	
	function setJsonDate(){
		var isSubmit = 1;//1提交 0禁止提交
		var name = '';
		var newDevice = document.getElementById('cloneNodeTbody');
		var length = document.getElementById('cloneNodeTbody').getElementsByTagName('tr').length;
		var tr;
		var jsonData = [];
		for (var i = 0; i < length; i++) {
			var data={};
			tr = $(newDevice).find('tr:eq('+i+')');
			
			if(!isEmpty(tr.find('td:eq(0)').children('input').val())){
				data.id = tr.find('td:eq(0)').children('input').val();
				data.productName = tr.find('td:eq(1)').text();
			}else{
				//新增资产时必须指出零部件为空
				data.productName = tr.find('td:eq(1)').text();
				if("[]" == tr.find('td:eq(6)').children('input').val()){
					name = tr.find('td:eq(1)').text();
					isSubmit = 0;
				}
			}
			//塔机零部件数据-towerPartsJson
			if(!isEmpty(tr.find('td:eq(6)').children('input').val()) && "[]" != tr.find('td:eq(6)').children('input').val()){
				//修改时判断值是否发生变化
				data.towerPartsJson = tr.find('td:eq(6)').children('input').val();
			}
			if(!isEmpty(tr.find('td:eq(2)').attr('title'))){
				data.manufacturer = tr.find('td:eq(2)').attr('title');
			}
			if(!isEmpty(tr.find('td:eq(3)').text())){
				data.specification = tr.find('td:eq(3)').text();
			}
			if(!isEmpty(tr.find('td:eq(4)').text())){
				data.towerType = tr.find('td:eq(4)').text();
			}
			if(!isEmpty(tr.find('td:eq(5)').attr('id'))){
				data.receivingBy = tr.find('td:eq(5)').attr('id');
			}
			if(!isEmpty(tr.find('td:eq(5)').text())){
				data.arrivalPlace = tr.find('td:eq(5)').text();
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
		isUnSub++;
		$.ajax({
			async : false,
			cache : false,
			type : 'POST',
			data :$("#purchaseForm").serialize(),
			url :'<%=basePath %>purchase/edit',
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
	
	function editfindTowerByDispatchNo(){
		/* var assetOrigin = ''; */
		var dispatchNo = $("#assetOrigin").val();
		if(assetOrigin != dispatchNo){
			$.messager.confirm('资产', '修改调度单号后外租资产也将发生变化，<br/>您是否继续修改调度单号并变更外租资产？', function (yes) {
				if(yes == true){
					findTowerByDispatchNo();
				}
			});
		}else{
			$.messager.show({
				title:'添加资产',
				msg:'当前调度单号没有修改，添加资产操作无效!',
				timeout:3000,
				showType:'show'
			});
		}
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
		var curNo = '${info.contractNo }';
		if(curNo == value){
			return;//没有编辑就不验证
		}
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
      <h3>编辑外租合同</h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form id="purchaseForm" action="<%=basePath %>purchase/editRental" method="post">
          <table border="0" class="edit-table">
      <tr>
        <th ><label><b>*</b>合同编号</label></th>
        <td >
        <input name="contractNo" type="text" value="${info.contractNo }" onblur="checkValue(this);" required="true" onpaste="return true" ondragenter="return false" oncontextmenu="return false;" style="ime-mode:disabled">
        <input name="towerJson" id="towerJson" type="hidden"/>
        <input name="id" type="hidden" value="${info.id }"/>
        <input name="removeId" id="removeId" type="hidden" />
        </td>
        <td></td>
      </tr>
      <tr>
        <th ><label><b>*</b>签订日期</label></th>
        <td ><input name="signTime" type="text" readonly="readonly" required="true" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${info.signTime}" type="both" />" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/></td>
        <td></td>
      </tr>
      <tr>
        <th >资产来源</th>
        <td>
        <select name=customerId id="customerId">
        </select>
        </td>
        <td></td>
      </tr>
      <%-- <tr>
              <th scope="row">调度单号</th>
              <td><input id="assetOrigin" name="assetOrigin" type="text"  value=""> 
              <a class="button button_position" id="assetOriginAdd" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a>
              <a class="button button_position" onClick="openwin2()" title="查看"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a> </td>
              <td></td>
            </tr>--%>
       <tr> 
        <th scope="row">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</th>
        <td><textarea name="memo" id="memo" cols="25" rows="3">${info.memo }</textarea>        </td>
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
                <c:forEach items="${towerList }" var="tower" varStatus="num">
                <tr>
                <td><c:if test="${pageNumber > 1}">${pageNumber-1}</c:if>${num.index+1 }
                <input type="hidden" value="${tower.id }"/>
                </td>
                <td>${tower.productName }</td>
                <td title="${tower.manufacturer }">${tower.createFactryName }</td>
                <td>${tower.specification }</td>
                <td>${tower.towerType }</td>
                <td id="${tower.receivingBy }">${tower.arrivalPlace }</td>
                <td >
                <input type="hidden" value="${tower.towerPartsJson}" >
		          <a onClick="reloadPart(this);" title="新增"><img src="<%=basePath %>static/images/icons/Down-icon.png" /></a>
		          <a onClick="openwin1(this)" title="查看"><img src="<%=basePath %>static/images/icons/view.png" title="查看"/></a>
		          </td>
		          <td align="center">
		          <a onClick="removes(this);" ><img src="<%=basePath %>static/images/icons/cross.png" alt="Delete" /></a>
		        </td>
                </tr>
                </c:forEach>
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
          <select></select>
          <!-- 此作用域为了存储调度单号，用于查询调度单零部件形成模板 -->
          <input type="hidden" />
          </td>
          <td>
          <select id="createFactry"></select>
          </td>
          <td>
          <select id="" >
          </select>
          </td>
          <td>
          <select id="">
          </select>
          </td>
          <td>
          <select id="" ></select>
          </td>
          <td>
          <input type="hidden" value="[]">
          <a onClick="reloadPart(this);" title="新增"><img src="<%=basePath %>static/images/icons/Down-icon.png" /></a>
          <%-- <a onClick="openwin1()" title="查看"><img src="<%=basePath %>static/images/icons/view.png" title="查看"/></a> --%>
          </td>
          <td align="center">
          <a onclick="setValueFun(this);" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" /></a>
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
	var towerId = $(obj).parent().parent().find('td:eq(0)').children('input').val();
	if(!isEmpty(towerId)){
		var towerModel = $(obj).parent().parent().find('td:eq(3)').text();
		var url = '<%=basePath %>purchase/editPartInit?towerId='+towerId+'&towerModel='+towerModel;
		
		var resultValue =  window.showModalDialog(url,'',"dialogWidth=1200px;dialogHeight=550px");
		$(obj).parent().children('input').val(resultValue);
	}else{
		id = $(obj).parent().parent().find('td:eq(1)').children('select').attr('id');
		var type = $('#'+id).combobox("getValue");
		if(isEmpty(type)){
			$.messager.alert('资产信息','资产名称为空，<br/>请选择名称再添加零部件!','error');
			return;
		}
		
		var id = $(obj).parent().parent().find('td:eq(3)').children('select').attr("id");
		var model = $('#'+id).combobox("getValue");
		model = encodeURI(encodeURI(model));
		if(isEmpty(model)){
			$.messager.alert('资产信息','资产规格型号为空，<br/>请选择规格型号再添加零部件!','error');
			return;
		}
		
		var resultValue =  window.showModalDialog('<%=basePath %>purchase/addPartInit?towerModel='+model+'&assetType='+type,'',"dialogWidth=1200px;dialogHeight=550px");
		if(!isEmpty(resultValue)){
			$(obj).parent().children('input').val(resultValue);
		}
	}
}
function openwin1(obj){
	var towerId = $(obj).parent().parent().find('td:eq(0)').children('input').val();
	var towerModel = $(obj).parent().parent().find('td:eq(3)').text();
	/*
	*var url = '<%=basePath %>purchase/queryPartInit?towerId='+towerId+'&towerModel='+towerModel;*/
	var url = "<%=basePath %>purchase/queryArrivePart?contractTowerId="+towerId;
	var resultValue =  window.showModalDialog(url,'',"dialogWidth=1200px;dialogHeight=550px");
}
</script>
</html>