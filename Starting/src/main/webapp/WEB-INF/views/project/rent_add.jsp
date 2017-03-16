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
<SCRIPT src="<%=basePath %>static/js/jQselect.js" type=text/javascript></SCRIPT>
<script type="text/javascript" src="<%=basePath %>static/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<script src="<%=basePath %>static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="<%=basePath %>static/js/json2.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<script type="text/javascript" src='<%=basePath %>static/js/UTIL.js'></script>
<SCRIPT type=text/javascript>
	var isNullCust = 0;
	var isNullTower = 0;
	var isUnSub = 0;
	$(document).ready(function() {
		
		$('#proCompany').combobox({
			url:'<%=basePath %>company/manageCompanyCombox',
			valueField:'id',
			textField:'companyShortName'
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
				$('#proType').combobox('setValue','0');
			}
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
				/* var id = $('#customerInfo').combobox('getValue');
				alert(id);
				setCustomerInfo(rec.id); */
			}
		});
		
		$("#leaseIntention").combobox({
			url:"<%=basePath %>dictionary/selectByDictCode?dict_code=ZLYX",
			valueField: 'dict_name',
			textField: 'dict_value',
			onLoadSuccess:function(){
				//$('#leaseIntention').combobox('setValue','0');
			}
		});
		
		$("#submitButton").on("click",function(){
			if(isUnSub > 0){
				return;//防止重复提交
			}
			if(tatongMethod.isChecked()){
				onProjectSubmit();
			}
		});
		$("#towerNo").on("blur",function(){
			if(isEmpty($("#towerNo").val()) == true){
				return;//为空 返回
			}
			$.ajax({
				async : false,
				cache : false,
				type : 'POST',
				data:{"towerNo":$("#towerNo").val()},
				url :'<%=basePath %>tower/findByNo',
				error : function() {// 请求失败处理函数
					isUnSub--;
					$.messager.alert('错误','查询塔机请求失败!','error');
				},
				success : function(data){
					isNullTower = 0;
					//JSON.parse(jsonstr); //可以将json字符串转换成json对象
					//JSON.stringify(jsonobj); //可以将json对象转换成json对符串 
					//data = eval('('+data+')');
					var jsonData = JSON.parse(data);
					if(jsonData != null){
						isNullTower = 1;
						$("#ccNum").val(jsonData.towerFactoryno);
						$("#towerId").val(jsonData.id);
						$("#towerType").val(jsonData.towerModel);
						//塔机状态：1闲置，2未启用，3在使用，4冬停，5托管
						if('1' == jsonData.towerState){
							$("#towerState").val("闲置");
						}else if('2' == jsonData.towerState){
							$("#towerState").val("未启用");
						}else if('3' == jsonData.towerState){
							$("#towerState").val("在使用");
						}else if('4' == jsonData.towerState){
							$("#towerState").val("冬停");
						}else {
							$("#towerState").val("托管");
						}
					}else{
						$.messager.alert('警告','塔机编号无效，请正确填写!','error');
					}
				}
			});
		});
	});
	
	function onProjectSubmit(){
		if(isNullTower == 0){
			$.messager.alert('警告','塔机编号无效，请正确填写!','error');
			return false;
		}
		isUnSub++;
		$.ajax({
			async : false,
			cache : false,
			type : 'POST',
			data :$("#leaseForm").serialize(),
			url :'<%=basePath %>project/addLeaseSave',
			error : function() {// 请求失败处理函数
				isUnSub--;
				$.messager.alert('错误','保存请求提交失败!','error');
			},
			success : function(data){
				if('n' == data){
					isUnSub--;
					$.messager.alert('失败','租赁意保存失败!','error');
				}else{
					$.messager.alert('成功','租赁意向保存入库成功!','info',function(){
						window.location.href = '<%=basePath %>project/init/4';
					});
				}
			}
		});
	}
	
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
				isNullCust = 0;
				var jsonData = JSON.parse(data);
				if(jsonData != null){
					isNullCust = 1;
					$("#customerNo").val(jsonData.customerCode);
					$("#cusPhone").val(jsonData.phone);
					$("#cusConto").val(jsonData.cpCnName);
					$("#cusEmail").val(jsonData.email);
				}
			}
		});
	}
	function openwin(){
		var resultValue =  window.showModalDialog('<%=basePath %>customer/addInitByProject','',"dialogWidth=1200px;dialogHeight=550px");
		setCustomerInfo(resultValue);
		$('#customerInfo').combobox('reload','<%=basePath %>customer/ajax');
		$('#customerInfo').combobox('setValue',resultValue);
	}
</SCRIPT>
</head>
<body>
<jsp:include page="../header-bar.jsp"/>
<div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>新增塔机租赁意向</h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form name="leaseForm" id="leaseForm" method="post">
        <p><b>塔机信息</b></p>
          <table border="0" class="edit-table">
            <tr>
              <th scope="row" width="200px"><label><b>*</b>塔机编号</label></th>
    <td >
    <input id="towerNo" name="towerNo" type="text" required="true"/>
    <input id="towerId" name="towerId" type="hidden" >
    </td>
    <th></th>
    <td></td>
    <th></th>
    <td></td>
  </tr>
  <tr>
  	<th scope="row" width="200px"><label >出厂编号</label></th>
    <td >
    <input name="ccNum" id="ccNum" type="text" readonly="readonly"/>
    </td>
    <th scope="row" width="200px">塔机型号</th>
    <td >
     <input type="text" id="towerType" name="towerType" readonly="readonly"/>
    </td>
    <th></th>
    <td></td>
  </tr>
    <tr>
      <th scope="row" width="200px">状态</th>
      <td >
      <input type="text" id="towerState" readonly="readonly" />
      </td>
      <th scope="row" width="200px">停租日期</th>
      <td ><input name="leaseEndtime" type="text" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></td>
      <th></th>
      <td></td>
    </tr>
    <tr>
       <th scope="row" width="200px"><label><b>*</b>租赁意向</label></th>
      <td >
      		<select name="leaseIntention" id="leaseIntention" class="easyui-combobox">
		       </select>
      </td>
      <th scope="row" width="200px"><label><b>*</b>预计进场时间</label></th>
      <td ><input required="true" name="leaseStarttime" type="text" readonly="readonly"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></td>
      <th></th>
      <td></td>
      </tr>
	</table>
	<p><b>客户信息</b></p>
	 <table border="0" class="edit-table">
	 <tr>
	 <th scope="row" width="200px">承租单位
	</th>
    <td >
    <select id="customerInfo" name="customerInfo" class="easyui-combobox">
    </select>
    <a class="button button_position" onClick="openwin()" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a>
    </td>
      <th scope="row" width="200px">客户编号</th>
      <td ><input id="customerNo" name="customerNo" type="text" readonly="readonly" /></td>
      <th></th>
	  <td></td>
    </tr>
    <tr >
      <th scope="row" width="200px">联系人</th>
      <td ><input readonly="readonly" id="cusConto" type="text" /></td>
      <th scope="row" width="200px">联系方式</th>
      <td ><input readonly="readonly" id="cusPhone" type="text" /></td>
      <th scope="row" width="200px">邮箱</th>
	  <td ><input readonly="readonly" id="cusEmail" type="text" /></td>
  	</tr>
   </table>
          <p><b>租赁信息</b></p>
		 <table border="0" class="edit-table">
		 <tr>
		 <th scope="row" width="200px">项目名称
		 </th>
		 <td ><input name="proName" type="text" required="true"/></td>
		 <th scope="row" width="200px">项目简称</th>
		 <td ><input name="proShortName" type="text" /></td>
		 <th></th>
		 <td></td>
		  </tr>
		  <tr>
		      <th scope="row" width="200px">类型</th>
		      <td >
		      <select name="proType" id="proType" class="easyui-combobox">
		       </select>
       		  </td>
		      <th scope="row" width="200px">状态</th>
		      <td >
		      <select name="proStatus" id="proStatus" class="easyui-combobox">
		      </select>
		      </td>
		      <th></th>
		      <td></td>
		    </tr>
		  <tr>
		 <th scope="row" width="200px">项目地点</th>
		 <td colspan="5">
		    <select id="proArea" name="proArea" style="width: 80px;" class="easyui-combobox">
              </select>
              <select id="proProvince" name="proProvince" style="width: 80px;" class="easyui-combobox">
              </select>
              <select id="proCity" name="proCity" style="width: 80px;" class="easyui-combobox">
              </select>
              <input id="proAddress" name="proAddress" style="background-color: white;"/>
              <input id="cityId" type="hidden" required="true"/>
		 </td>
		 </tr>
		  <tr >
		      <th scope="row" width="200px">备&nbsp;&nbsp;&nbsp;&nbsp;注</th>
		      <td colspan="5"><textarea name="proEquipment" cols="" rows=""></textarea></td>
		  </tr>
            <tr>
              <td>&nbsp;</td>
              <td colspan="5"><a class="button_new" id="submitButton" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a> <a class="button_new" href="<%=basePath %>project/init/4" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a> </td>
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