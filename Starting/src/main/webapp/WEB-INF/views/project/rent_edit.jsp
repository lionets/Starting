<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	var loadNum = 0;
	var isUnSub = 0;
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
				$('#proArea').combobox('setValue','${proInfo.proArea}');
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
			},
			onLoadSuccess:function(){
				if(1 > loadNum){//第一次页面初始化时才加载
					$('#proProvince').combobox('setValue','${proInfo.proProvince}');
				}
			}
		});
		
		$('#proCity').combobox({
			url:'<%=basePath %>area/getAreainfo?areaType=3&areaCode=${proInfo.proProvince}',
			valueField:'areaCode',
			textField:'areaName',
			onLoadSuccess:function(){
				if(1 > loadNum){//第一次页面初始化时才加载
					$('#proCity').combobox('setValue','${proInfo.proCity}');
				}
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
		
		$("#leaseIntention").combobox({
			url:"<%=basePath %>dictionary/selectByDictCode?dict_code=ZLYX",
			valueField: 'dict_name',
			textField: 'dict_value',
			onLoadSuccess:function(){
				$('#leaseIntention').combobox('setValue','${lease.leaseIntention}');
			}
		});
		
		$.ajax({
			async : false,
			cache : false,
			type : 'POST',
			data:{"id":'${lease.towerId}'},
			url :'<%=basePath %>tower/findByAjaxId',
			error : function() {// 请求失败处理函数
				$.messager.alert('错误','查询塔机请求失败!','error');
			},
			success : function(data){
				//JSON.parse(jsonstr); //可以将json字符串转换成json对象
				//JSON.stringify(jsonobj); //可以将json对象转换成json对符串 
				//data = eval('('+data+')');
				var jsonData = JSON.parse(data);
				if(jsonData != null){
					$("#towerNo").val(jsonData.towerNo);
					$("#ccNum").val(jsonData.towerFactoryno);
					$("#towerId").val(jsonData.id);
					$("#towerType").val(jsonData.towerType);
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
				}
			}
		});
		
		$("#submitButton").on("click",function(){
			if(tatongMethod.isChecked()){
				if(isUnSub > 0){
					return;//防止重复提交
				}
				isUnSub++;
				if(tatongMethod.isChecked()){
					onProjectSubmit();
				}
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
					$.messager.alert('错误','查询塔机请求失败!','error');
				},
				success : function(data){
					//JSON.parse(jsonstr); //可以将json字符串转换成json对象
					//JSON.stringify(jsonobj); //可以将json对象转换成json对符串 
					//data = eval('('+data+')');
					var jsonData = JSON.parse(data);
					if(jsonData != null){
						$("#ccNum").val(jsonData.towerFactoryno);
						$("#towerId").val(jsonData.id);
						$("#towerType").val(jsonData.towerType);
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
					}
				}
			});
		});
	});
	function onProjectSubmit(){
		$.ajax({
			async : false,
			cache : false,
			type : 'POST',
			data :$("#leaseForm").serialize(),
			url :'<%=basePath %>project/editLeaseSave',
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
	function leaseToProject(){
		$.messager.confirm('资产信息', '您确定将租赁意向转为合同信息？', function (yes) {
			if(yes == true){
				window.location.href = '<%=basePath %>project/leaseToContractInit?leaseId=${lease.id}';
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
    <td width="200px">
    <input name="ccNum" id="ccNum" type="text" />
    </td>
    <th scope="row" width="200px">塔机型号</th>
    <td width="200px">
     <input type="text" id="towerType" name="towerType" />
    </td>
    <th></th>
    <td></td>
  </tr>
    <tr>
      <th scope="row" width="200px">状态</th>
      <td width="200px">
      <input type="text" id="towerState" value=""/>
      </td>
      <th scope="row" width="200px">停租日期</th>
      <td width="200px"><input name="leaseEndtime" type="text" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${lease.leaseEndtime}" type="both" />" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></td>
      <th></th>
      <td></td>
    </tr>
    <tr>
       <th scope="row" width="200px"><label><b>*</b>租赁意向</label></th>
      <td width="200px">
      		<select name="leaseIntention" id="leaseIntention" class="easyui-combobox">
		       </select>
      </td>
      <th scope="row" width="200px"><label><b>*</b>预计进场时间</label></th>
      <td width="200px"><input required="true" name="leaseStarttime" type="text" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${lease.leaseStarttime}" type="both" />" readonly="readonly"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></td>
      <th></th>
      <td></td>
      </tr>
	</table>
	<p><b>客户信息</b></p>
	 <table border="0" class="edit-table">
	 <tr>
	 <th scope="row" width="200px">承租单位
	</th>
    <td width="200px">
    <select id="customerInfo" name="customerInfo" class="easyui-combobox">
    </select>
    <c:if test="${lease.leaseStatus == 0}">
    <a class="button button_position" onClick="openwin()" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a>
    </c:if> 
    </td>
      <th scope="row" width="200px">客户编号</th>
      <td width="200px"><input id="customerNo" name="customerNo" type="text" /></td>
      <th></th>
	  <td></td>
    </tr>
    <tr >
      <th scope="row" width="200px">联系人</th>
      <td width="200px"><input readonly="readonly" id="cusConto" type="text" /></td>
      <th scope="row" width="200px">联系方式</th>
      <td width="200px"><input readonly="readonly" id="cusPhone" type="text" /></td>
      <th scope="row" width="200px">邮箱</th>
	  <td width="200px"><input readonly="readonly" id="cusEmail" type="text" /></td>
  	</tr>
   </table>
          <p><b>租赁信息</b></p>
		 <table border="0" class="edit-table">
		 <tr>
		 <th scope="row" width="200px">项目名称
		 </th>
		 <td width="200px"><input name="proName" type="text" value="${proInfo.proName }" required="true"/></td>
		 <th scope="row" width="200px">项目简称</th>
		 <td width="200px">
		 <input name="proShortName" value="${proInfo.proShortName }" type="text" />
		 <input name="proId" value="${proInfo.id }" type="hidden" />
      	 <input name="leaseId" value="${lease.id }" type="hidden" />
		 </td>
		 <th></th>
		 <td></td>
		  </tr>
		  <tr>
		      <th scope="row" width="200px">类型</th>
		      <td width="200px">
		      <select name="proType" id="proType" class="easyui-combobox">
		       </select>
       		  </td>
		      <th scope="row" width="200px">状态</th>
		      <td width="200px">
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
              <input id="proAddress" name="proAddress" value="${proInfo.proAddress }" style="background-color: white;"/>
		 </td>
		 </tr>
		  <tr >
		      <th scope="row" width="200px">备&nbsp;&nbsp;&nbsp;&nbsp;注</th>
		      <td colspan="5"><textarea name="proEquipment" cols="" rows="">${proInfo.proEquipment }</textarea></td>
		  </tr>
            <tr>
              <td>&nbsp;</td>
              <td colspan="5">
              <a class="button_new" href="<%=basePath %>project/init/4" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a>
              <c:if test="${lease.leaseStatus == 0}">
              <a class="button_new" id="submitButton" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a> 
              <a class="button_new" onclick="leaseToProject()" title="转为项目"><img src="<%=basePath %>static/images/icons/freebie-icon.png" class="px18"/></a>
              </c:if> 
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