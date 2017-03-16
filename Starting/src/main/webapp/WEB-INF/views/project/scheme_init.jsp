<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath =  path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>合同信息审核</title>
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
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<script type="text/javascript" src='<%=basePath %>static/js/UTIL.js'></script>
<SCRIPT type=text/javascript>
	
	function showMessager(title,msg){
		$.messager.show({
			title:title,msg:msg,
			timeout:3000,showType:'show'
		});
	}
	function onProjectSubmit(){
		var id,value;
		var isSubmit = 1;//1提交 0禁止提交
		var name = '';
		var newDevice = document.getElementById('cloneNodeTbody');
		var length = document.getElementById('cloneNodeTbody').getElementsByTagName('tr').length;
		var tr;
		var jsonData = "[";
		for (var i = 0; i < length; i++) {
			tr = $(newDevice).find('tr:eq('+i+')');
			
			jsonData = jsonData + "{id:"+tr.find('td:eq(0)').children('input').val();
			id = tr.find('td:eq(5)').children('select').attr('id');
			value = $('#'+id).combobox('getValue');
			jsonData = jsonData + ",setupType:'"+value;
			if(isEmpty(value)){
				showMessager('设备需求','安装方式不能为空，请填写安装方式!');
				return;
			}
			
			//塔机零部件数据-towerPartsJson
			jsonData = jsonData + "',partsJson:"+tr.find('td:eq(8)').children('input').val();
			if("[]" == tr.find('td:eq(8)').children('input').val()){
				name = tr.find('td:eq(2)').text();
				showMessager('设备需求',name+'型号的设备零部件方案未完成，请完成零部件方案!');
				return;
			}
			
			value = tr.find('td:eq(6)').children('input').val();
			if(!isEmpty(value)){
				jsonData = jsonData + ",dbcd:"+value;
			}
			
			value = tr.find('td:eq(7)').children('input').val();
			if(!isEmpty(value)){
				jsonData = jsonData + ",fagd:"+value;
			}
			
			jsonData = jsonData + "}";
			if(i<length-1){
				jsonData = jsonData + ",";
			}
		}
		jsonData = jsonData + "]";
		onSubmit(jsonData);
	}
	
	function onSubmit(jsonData){
		$.ajax({
			async : false,
			cache : false,
			type : 'POST',
			data :{"jsonData_Scheme":jsonData},
			url :'<%=basePath %>contractPro/saveScheme',
			error : function() {// 请求失败处理函数
				$.messager.alert('错误','保存请求提交失败!','error');
			},
			success : function(data){
				if('n' == data){
					$.messager.alert('失败','合同设备需求方案保存失败!','error');
				}else{
					$.messager.alert('成功','合同设备需求方案保存入库成功!','info',function(){
						window.location.href = '<%=basePath %>contractPro/init/4';
					});
				}
			}
		});
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
	
	function openwin(obj){
		var name = $(obj).parent().parent().find('td:eq(1)').text();
		var model = $(obj).parent().parent().find('td:eq(2)').text();
		model = encodeURI(encodeURI(model));
		var goodsId = $(obj).parent().parent().find('td:eq(0)').children('input').val();
		var resultValue;
		resultValue = window.showModalDialog('<%=basePath %>contractPro/addSchemePartInit?towerModel='+model+'&goodsId='+goodsId,'',"dialogWidth=1200px;dialogHeight=550px");
		if(!isEmpty(resultValue)){
			$(obj).parent().children('input').val(resultValue);
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
      <h3>添加合同方案</h3>
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
              ${cust.customerCnName}
               </td>
              <th>客户编号</th>
              <td>${cust.customerCode}</td>
              <th></th>
              <td></td>
            </tr>
            <tr >
              <th>联系人</th>
              <td>${cust.cpCnName}</td>
              <th>联系人手机</th>
              <td>${cust.phone}</td>
              <th>邮箱</th>
              <td>${cust.email}</td>
            </tr>
          </table>
          <p>
            <label> <b>合同信息</b></label> 
          </p>
          <table border="0" class="edit-table">
            <tr>
              <th scope="row"><label><b>*</b>合同编号 </label></th>
              <td width="300px">
              <input id="id" name="id" type="hidden" value="${con.id }"/>
              ${con.contractNo}
              </td>
              <th>合同状态</th>
              <td>
              <c:choose>
              <c:when test="${con.contractStatus == 0 }">待启动</c:when>
              <c:when test="${con.contractStatus == 1 }">已启动</c:when>
              <c:when test="${con.contractStatus == 2 }">已关闭</c:when>
              <c:otherwise>未知状态</c:otherwise>
              </c:choose>
              </td>
            </tr>
            <tr>
              <th>所属公司</th>
              <td>
              ${con.proCompanyName}
              </td>
              <th>管理单位</th>
              <td>
              ${con.proManagedeptName}
              </td>
            </tr>
            <tr >
              <th>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</th>
              <td colspan="5">${con.remark}</td>
            </tr>
          </table>
          <p>
            <label> <b>项目信息</b></label> 
          </p>
          <table border="0" class="edit-table">
            <tr>
              <th scope="row"><label><b>*</b>项目名称 </label></th>
              <td width="300px">
              ${pro.proName}
              </td>
              <th><label><b>*</b>项目简称</label></th>
              <td>
              ${pro.proShortName}
              </td>
              <th></th>
              <td></td>
            </tr>
            <tr >
              <th><label><b>*</b>项目地点</label></th>
              <td colspan="5">
              ${pro.proArea}
              &nbsp;&nbsp;&nbsp;
              ${pro.proProvince}
              &nbsp;&nbsp;&nbsp;
              ${pro.proCity}
              &nbsp;&nbsp;&nbsp;
              ${pro.proAddress}
              </td>
            </tr>
            <tr>
              <th>项目类型</th>
              <td>${pro.proType}
              </td>
              <th>项目状态</th>
              <td>
              <c:choose>
              <c:when test="${pro.proStatus == 0 }">待启动</c:when>
              <c:when test="${pro.proStatus == 1 }">已启动</c:when>
              <c:when test="${pro.proStatus == 2 }">已关闭</c:when>
              <c:otherwise>未知状态</c:otherwise>
              </c:choose>
              </td>
            </tr>
          </table>
          
          <p>
            <label> <b> 设备需求信息</b></label>
          </p>
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
            <tbody id="cloneNodeTbody">
              <c:forEach items="${list }" var="device" varStatus="num">
              <tr>
              <td>${num.index+1 }<input type="hidden" value="${device.id }"/></td>
              <td>${device.productName }</td>
              <td>${device.towerModel }</td>
              <td>${device.towerNo }</td>
              <td>${device.createNo }</td>
              <td>
              <select class="easyui-combobox" id="type${device.id }" model="model">
              <c:forEach items="${towerType }" var="type" >
              <option <c:if test="${device.setupType == type.dict_value}">selected="selected"</c:if> value="${type.dict_value }">${type.dict_value }</option>
              </c:forEach>
              </select>
              </td>
              <td><input type="text" value="${device.dbcd }"/></td>
              <td><input type="text" value="${device.fagd }"/></td>
              <td>
              <input type="hidden" value="[]">
              <a class="add" onclick="reloadPart(this);"><img src="<%=basePath %>static/images/icons/pencil.png" title="编辑"/></a>
              </td>
              </tr>
              </c:forEach>
            </tbody>
          </table>
          </div>
          <table  class="edit-table" border="0">
            <tr>
              <td>&nbsp;</td>
              <td colspan="5">
              <a class="button_new" href="<%=basePath %>contractPro/init/4" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a>
              <a onclick="onProjectSubmit();" class="button_new" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a>
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