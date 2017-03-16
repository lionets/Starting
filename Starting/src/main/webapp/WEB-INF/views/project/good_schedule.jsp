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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
<title>设备日程信息</title>
<script type="text/javascript">
	var isUnSub = 0;
	var isopen = new Array();
	var idNum = 0;
	$(document).ready(function() {
		
		$("#submitButton").on("click",function(){
			if(tatongMethod.isChecked()){
				onPurchaseSubmit();
			}
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
	function addTr(){
		idNum++;
		trNum++;
		isopen.push("deviceDetailTr-" + idNum);//打开新建tr，需要确认后才能保存
		var sourceNode = document.getElementById("cloneNodeTr"); // 获得被克隆的节点对象 
		var clonedNode = sourceNode.cloneNode(true); // 克隆节点 
		clonedNode.setAttribute("id", "deviceDetailTr-" + idNum); // 修改一下id 值，避免id 重复 
		//sourceNode.parentNode.appendChild(); // 在父节点插入克隆的节点 
		$(clonedNode).find('td:eq(1)').children('select').attr("id","reson"+trNum);
		$('#cloneNodeTbody').append(clonedNode);
		
		$("#reson"+trNum).combobox({
			valueField: 'label',
			textField: 'value',
			data: [{label: '冬停',value: '冬停'},
			       {label: '维修',value: '维修'}]
		});
	}
	function showMessager(title,msg){
		$.messager.show({
			title:title,msg:msg,
			timeout:3000,showType:'show'
		});
	}
	function isEmptyValue(obj){
		var id;
		var value;
		id = $(obj).parent().parent().find('td:eq(1)').children('select').attr("id");
		value = $('#'+id).combobox("getValue");
		
		if(isEmpty(value)){
			showMessager('设备日程','设备暂停原因不能为空!');
			return false;
		}
		value = $(obj).parent().parent().find('td:eq(2)').children('input').val();
		if(isEmpty(value)){
			showMessager('设备日程','设备暂停开始时间不能为空!');
			return false;
		}
		value = $(obj).parent().parent().find('td:eq(3)').children('input').val();
		if(isEmpty(value)){
			showMessager('设备日程','设备暂停结束时间不能为空!');
			return false;
		}
		return true;
	}
	
	function setValueFun(obj){
		//验证是否有空值
		if(isEmptyValue(obj) == false){
			return false;
		}
		removeIsopen(obj);//关闭新建tr，得到确认，要所有新建tr都关闭才能保存
		
		var id;
		var value;
		var text;
		//取input值set到td文本
		//$(obj).parent().parent().find('td:eq(0)').text(trNum);
		id = $(obj).parent().parent().find('td:eq(1)').children('select').attr("id");
		value = $('#'+id).combobox("getValue");
		$(obj).parent().parent().find('td:eq(1)').attr('title',value);
		text = $('#'+id).combobox("getText");
		$(obj).parent().parent().find('td:eq(1)').text(text);
		
		value = $(obj).parent().parent().find('td:eq(2)').children('input').val();
		$(obj).parent().parent().find('td:eq(2)').text(value);
		
		value = $(obj).parent().parent().find('td:eq(3)').children('input').val();
		$(obj).parent().parent().find('td:eq(3)').text(value);
		$(obj).remove();
	}
	
	function delTr(obj){
		$.messager.confirm('资产信息', '您确定移除当前暂停信息？', function (yes) {
			if(yes == true){
				removeIsopen(obj);//关闭新建tr，得到确认，要所有新建tr都关闭才能保存
				trNum--;
				$(obj).parent().parent().remove();
			}
		});
	}
	
	function removes(obj){
		$.messager.confirm('资产信息', '您确定移除当前暂停信息？', function (yes) {
			if(yes == true){
				var scheduleId = $(obj).parent().parent().find('td:eq(0)').attr('title');
				$.ajax({
					async : false,
					cache : false,
					type : 'POST',
					data :{"scheduleId":scheduleId},
					url :'<%=basePath %>contractPro/delGoodsSchedule',
					error : function() {// 请求失败处理函数
						$.messager.alert('错误','保存请求提交失败!','error');
					},
					success : function(data){
						if('n' == data){
							$.messager.alert('失败','设备日程删除失败!','error');
						}else{
							$(obj).parent().parent().remove();
						}
					}
				});
				
			}
		});
	}
	
	function onPurchaseSubmit(){
		isOpenTrLength();
	}
	
	function isOpenTrLength(){
		/* if(isopen.length > 0){
			$.messager.alert('资产信息','资产信息编辑未保存，<br/>请点击右侧编辑按钮完成编辑操作!','error');
			return;
		} */
		var id;
		var forArray = new Array();
		for(var i=0;i<isopen.length;i++){
			forArray.push(isopen[i]);
		}
		for(var i=0;i<forArray.length;i++){
			id = forArray[i];
			var obj = $('#'+id).find('td:eq(4)').children('a')[0];
			var start = $(obj).parent().parent().find('td:eq(2)').children('input').val();
			var ent = $(obj).parent().parent().find('td:eq(3)').children('input').val();
			if(duibi(start,ent,3) == false){
				return;
			}
			//alert(obj.nodeName);
			var flag = setValueFun(obj);
			if(flag == false){
				return;//有空值，结束提交方法
			}
		}
		if(!timeCheck())return;//判断起租时间，停租时间先后
		setJsonDate();
	}
	function setJsonDate(){
		var newDevice = document.getElementById('cloneNodeTbody');
		var length = document.getElementById('cloneNodeTbody').getElementsByTagName('tr').length;
		var tr;
		var value;
		var jsonData = "[";
		for (var i = 0; i < length; i++) {
			tr = $(newDevice).find('tr:eq('+i+')');
			value = tr.find('td:eq(0)').attr('title');
			if(isEmpty(value)){//只保存新增的数据，title有值的(日程记录ID)不保存
				jsonData = jsonData + "{reason:'"+tr.find('td:eq(1)').attr('title')+"'";
				jsonData = jsonData + ",startsTime:"+tr.find('td:eq(2)').text();
				jsonData = jsonData + ",endTime:"+tr.find('td:eq(3)').text()+"}";
				if(i<length-1){
					jsonData = jsonData + ",";
				}
			}
		}
		jsonData = jsonData + "]";
		$('#ext1').val(jsonData);
		onSubmit();
	}
	
	function onSubmit(){
		$.ajax({
			async : false,
			cache : false,
			type : 'POST',
			data :$("#scheduleForm").serialize(),
			url :'<%=basePath %>contractPro/saveGoodsSchedule',
			error : function() {// 请求失败处理函数
				$.messager.alert('错误','保存请求提交失败!','error');
			},
			success : function(data){
				if('n' == data){
					$.messager.alert('失败','设备日程保存失败!','error');
				}else{
					$.messager.alert('成功','设备日程保存成功!','info',function(){
						window.close();
					});
				}
			}
		});
	}
	
	function timeCheck(){
		var a = $('#rentTime').val();
		if(isEmpty(a) == true){
			return true;//出厂时间为空时不做判断
		}
		var b = $('#stopRentTime').val();
		if(isEmpty(b) == false){
			return duibi(a,b,1);
		}
		var c = $('#expectStopTime').val();
		if(isEmpty(c) == false){
			return duibi(a,c,2);
		}
		return true;
	}
	
	function duibi(a,b,num) {
		if(isEmpty(a) == true){
			return true;//出厂时间为空时不做判断
		}
	    var arr = a.split("-");
	    var starttime = new Date(arr[0], arr[1], arr[2]);
	    var starttimes = starttime.getTime();

	    if(isEmpty(b) == true){
			return true;//出厂时间为空时不做判断
		}
	    var arrs = b.split("-");
	    var lktime = new Date(arrs[0], arrs[1], arrs[2]);
	    var lktimes = lktime.getTime();
	    if (starttimes >= lktimes) {
	    	if(num == 1){
	    		$.messager.alert('错误','停租日期不能早于起租日期!','error');
	    	}else if(num == 2){
	    		$.messager.alert('错误','预计停租日期不能早于起租日期!','error');
	    	}else{
	    		$.messager.alert('错误','结束日期不能早于开始日期!','error');
	    	}
	        return false;
	    }else{return true;}
	}
</SCRIPT>
</head>
<body>
<div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>设备日程信息</h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form id="scheduleForm" action="" method="post">
          <table border="0" class="edit-table">
            <tr>
              <th><label>塔机型号</label></th>
              <td>
              <input id="id" name="id" type="hidden" value="${info.id }"/>
              <input id="ext1" name="ext1" type="hidden"/>
              <input type="text" readonly="readonly" name="towerModel" value="${info.towerModel }"/>
              </td>
              <th><label >塔机编号</label></th>
              <td><input class="medium-input" type="text" readonly="readonly" value="${info.towerNo }" /></td>
               <th width="200"><label >出厂编号</label></th>
              <td width="200"><input name="Input4" type="text"  value="${info.createNo }" readonly="readonly" /></td>
            </tr>
            <tr>
              <th scope="row">起租时间</th>
              <td><input name="rentTime" id="rentTime" type="text" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${info.rentTime}" type="both" />" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/></td>
              <th><label>停租时间</label></th>
              <td><input name="stopRentTime" id="stopRentTime" type="text" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${info.stopRentTime}" type="both" />" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'rentTime\',{d:0});}'});"/></td>
               <th><label>预计停租时间</label></th>
              <td><input name="expectStopTime" id="expectStopTime" type="text" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${info.expectStopTime}" type="both" />" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'rentTime\',{d:0});}'});"/></td>
            </tr>
          </table>
           <p>
            <label> <b> 暂停时间</b></label>
          </p>
          <table>
            <thead>
              <tr>
                <th scope="col" class="picture2">&nbsp;</th>
                <th  scope="col">暂停原因</th>
                <th  scope="col">开始时间</th>
                <th  scope="col">结束时间</th>
                <th  scope="col" class="picture1"></th>
              </tr>
            </thead>
            <tbody id="cloneNodeTbody">
            <c:forEach items="${scheduleList }" var="schedule" varStatus="num">
            <tr>
            <td title="${schedule.id }">${num.index+1 }</td>
            <td>${schedule.reason }</td>
            <td><fmt:formatDate pattern="yyyy-MM-dd" value="${schedule.startsTime}" type="both" /></td>
            <td><fmt:formatDate pattern="yyyy-MM-dd" value="${schedule.endTime}" type="both" /></td>
            <td><a href="#" onClick="removes(this)" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" title="删除"/></a></td>
            </tr>
            </c:forEach>
            </tbody>
            <tfoot >
              <tr><td><div align="center"><a onclick="addTr();" class="button1 button_position" href="#" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a></div></td>
              <td colspan="4">&nbsp;</td>
              </tr>
              <tr>
          <td></td>
          <td colspan="4"><a class="button_new" onclick="window.close()"  title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a><a id="submitButton" class="button_new" href="#" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a>  </td>
          </tr>
            </tfoot>
          </table>
          <table style="display: none;">
          <tbody>
          <tr id="cloneNodeTr">
                <td></td>
                <td><select></select></td>
                <td><input name="Input3" type="text" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/></td>
                <td><input name="Input2" type="text" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/></td>
                <td><a href="#" onClick="delTr(this)" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" title="删除"/></a></td>
              </tr>
          </tbody>
          </table>
        </form>
      </div>
      <!-- End #tab1 -->
    </div>
    <!-- End .content-box-content -->
  </div>
  <!-- End .content-box -->
</div>
<!-- End #main-content -->
</body>
</html>