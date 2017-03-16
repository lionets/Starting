<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
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
<script type="text/javascript" src="<%=basePath %>static/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery-easyui-1.4.1/plugins/jquery.dialog.js"></script>
<SCRIPT src="<%=basePath %>static/js/jQselect.js" type=text/javascript></SCRIPT>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<script type="text/javascript" src='<%=basePath %>static/js/UTIL.js'></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery.datePicker.js"></script>
<script src="<%=basePath %>static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<SCRIPT type=text/javascript>

	var isUnSub = 0;
	$(document).ready(function() {
		//productName 塔式起重机=1,零部件=2
		if('${productName}' == '2'){
			if('${contractType}' == '1'){
				$.messager.alert("采购到货","当前采购合同为单独采购零部件资产，<br/>必须挂载指定的目标塔机！");
			}else{
				$.messager.alert("外租合同","当前外租合同为单独外租零部件资产，<br/>必须挂载指定的目标塔机，<br/>并且填写零部件调度单编号！");
			}
		}
		$('#manageCompany').combobox({
			url:'<%=basePath %>company/manageCompanyCombox',
			valueField:'id',
			textField:'companyShortName',
			readonly: false,
			onSelect:function(rec){
				$('#manageDepartment').combobox('clear');
				var url = '<%=basePath %>department/ajax?companyId='+rec.id;
				$('#manageDepartment').combobox('reload', url);
			},
			onLoadSuccess:function(){
				var url = '<%=basePath %>department/ajax?companyId=';
				if('${manage.manageCompany}' != ''){
					$('#manageCompany').combobox('setValue','${manage.manageCompany}');
					url = url + '${manage.manageCompany}';
				}else{
					$('#manageCompany').combobox('setValue','${curCompany}');
					url = url + '${curCompany}';
				}
				$('#manageDepartment').combobox('reload', url);
				$('#manageCompany').combobox('readonly');
			}
		});
		
		$('#manageDepartment').combobox({
			url:'<%=basePath %>department/ajax?companyId=${curCompany}',
			valueField:'id',
			textField:'departmentName',
			onLoadSuccess:function(){
				$('#manageDepartment').combobox('setValue','${manage.manageDepartment}');
			}
		});
		$('#towerRightcompany').combobox({
			url:'<%=basePath %>company/manageCompanyCombox',
			valueField:'id',
			textField:'companyShortName',
			readonly: false,
			onLoadSuccess:function(){
				if('${manage.towerRightcompany}' != ''){
					$('#towerRightcompany').combobox('setValue','${manage.towerRightcompany}');
				}else{
					$('#towerRightcompany').combobox('setValue','${curCompany}');
				}
				$('#towerRightcompany').combobox('readonly');
			}
		});
		$('#towerCreatecompany').combobox({
			url:"<%=basePath %>dictionary/selectByDictCode?dict_code=SCCJ",
			valueField:'id',
			textField:'dict_value',
			onLoadSuccess:function(){
				if('${info.towerCreatecompany}' != ''){
					$('#towerCreatecompany').combobox('setValue','${info.towerCreatecompany}');
				}else{
					$('#towerCreatecompany').combobox('setValue','${manufacturer}');
				}
				$('#towerCreatecompany').combobox('readonly');
			}
		});
		
		$("#towerModel").combobox({
			url:"<%=basePath %>dictionary/selectByDictCode?dict_code=TJXH",
			valueField: 'dict_value',
			textField: 'dict_value',
			readonly: false,
			onLoadSuccess:function(){
				if('${info.towerModel}' != ''){
					$('#towerModel').combobox('setValue','${info.towerModel}');
				}else{
					$('#towerModel').combobox('setValue','${specification}');
				}
				$('#towerModel').combobox('readonly');
			}
		});
		$("#towerType").combobox({
			url:"<%=basePath %>dictionary/selectByDictCode?dict_code=TJYS",
			valueField: 'dict_value',
			textField: 'dict_value',
			readonly: false,
			onLoadSuccess:function(){
				if('${info.towerType}' != ''){
					$('#towerType').combobox('setValue','${info.towerType}');
				}else{
					$('#towerType').combobox('setValue','${tower_type}');
				}
				$('#towerType').combobox('readonly');
			}
		});
		
		$("#towerSource").combobox({
			url:"<%=basePath %>dictionary/selectByDictCode?dict_code=TJLY",
			valueField: 'dict_value',
			textField: 'dict_value',
			onLoadSuccess:function(){
				$('#towerSource').combobox('setValue','${manage.towerSource}');
			}
		});
		
		$("#submitButton").on("click",function(){
			if(tatongMethod.isChecked() && duibi()){
				onProjectSubmit();
			}else if(tatongMethod.isChecked() == false){
				selectTab(2);
			}
		});
		/**
		**零部件操作方法********************
		**********************************
		**/
		//更新数据
		//filterlever3Date($("#mainPartTable").find("tr:eq(1)").attr("partid"));
		
		addOne();
		//左侧新增按钮添加点击事件
		$(".addOneLevelTow").on("click",function(){
			var thisTr = $(this).parent().parent();
	       var html =  "<tr pid='' partid=''>"+
	       "<td><div align='center'>"+
	       "</div></td>"+
		    "<td width='100'><select class='level2Combobox' style='float:left;width:120px;margin-bottom:0px;height:23px;'>"+level2Options+"</select></td>"+
		       "<td ><select class='level2ModelCombobox' style='float:left;width:120px;margin-bottom:0px;height:23px;'></select></td>"+
		   "<td ><div align='center'><input name='Input' type='text' value='0' class='picture2r'></div></td>"+
		   "<td>&nbsp;</td>"+
		   "<td align='center'><a href='javascript:void(0)' class='deleteLevel2One'><img src='/leap/static/images/icons/cross.png' alt='删除' title='删除'></a></td>"+
		 "</tr>"
			thisTr.before(html);
			$(".level2Combobox").on("change",function(){
				var text = $(this).find('option:selected').text();
				var pid = $(this).find('option:selected').attr("pid");
				var partModel = $(this).find('option:selected').attr("partModel");
				var value = $(this).val();
				var temp =  text;
					//"<a href='javascript:showParts("+value+")' class='chick_a default-tab'>"+text+"</a>";
				var siblings = $(this).parent().parent().siblings().not(":last");
				//根据value发送ajax请求
			var modelTd= 	$(this).parent().parent().children(":eq(2)").children();
				    $.ajax( {
				        dataType : "JSON",
				        type : "POST",
				        url : "<%=basePath %>part/ajaxPartModel",
				        data : "id="+value,
				        success : function(jsonStr) {
				        	var tempOption  ="<option vlaue='-1'></option>";
				        	for(var i=0; i<jsonStr.length; i++){
				        		var part_model =jsonStr[i]["part_model"];
				        		var id =jsonStr[i]["id"];
				        		tempOption +=  "<option value='"+id+"'>"+part_model+"</option>";
				        	} 
				        	modelTd.append(tempOption);
				        	level2ModelComboboxChange();
				        },
				        error : function(html) {
				        	$.messager.alert("错误","加载型号数据错误");
				        }
				    });
				 
				 
				//设置本行的属性
				$(this).parent().parent().attr("pid",pid);
				$(this).parent().parent().attr("partid",value);
				//设置型号
				//$(this).parent().parent().find("input").first().val(partModel);
				$(this).parent().html(temp);
				dynamicHtml(value);
			})
			
	      //更新索引
			refreshIndex(thisTr.siblings());
			//添加删除事件
			deleteLevel2OneTr();
			addOne();
		})
		//绑定两边的删除
		deleteOneTr();
		deleteLevel2OneTr();
	});
	var isRepeat1 = false;
	function onblurByTowerFacNo(){
		var towerFacNo = $('#towerFactoryno').val();
		if(!isEmpty('${manage.id}') && '${info.towerFactoryno}' == towerFacNo){
			return;//在未审核之前的资产到货信息可以编辑，所以此时的编辑不需要出发
		}
		
		/* if(!/^[\w]+$/.test(towerFacNo) && isEmpty(towerFacNo) == false){
			$.messager.alert("错误","编号无效! 仅支持字母与数字下划线。",'error');
			$('#towerFactoryno').val('');
			return;
		} */
		if(!isEmpty(towerFacNo)){
			$.ajax({
				async : false,
				cache : false,
				type : 'POST',
				data:{"towerFactoryno":towerFacNo},
				url :'<%=basePath %>tower/findByFactoryno',
				error : function() {// 请求失败处理函数
					$.messager.alert('错误','查询塔机出厂编号请求失败!','error');
				},
				success : function(data){
					//JSON.parse(jsonstr); //可以将json字符串转换成json对象
					//JSON.stringify(jsonobj); //可以将json对象转换成json对符串 
					//data = eval('('+data+')');
					var jsonData = JSON.parse(data);
					//合同类型 1采购 2外租
					if('${contractType}' == '1'){
						if(!isEmpty(jsonData.id)){
							isRepeat1 = true;
							$.messager.alert('重复','塔机出厂编号已经存在于系统中!','error');
						}else{
							isRepeat1 = false;
						}
					}else{
						
						if(jsonData != null){
							$("#towerNo").val(jsonData.towerNo);
							$("#tower_id").val(jsonData.id);
							$("#towerModel").combobox('setValue',jsonData.towerModel);
							$("#towerType").combobox('setValue',jsonData.towerType);
							$("#towerCreatecompany").combobox('setValue',jsonData.towerCreatecompany);
							$("#towerRightcompany").combobox('setValue',jsonData.towerRightcompany);
							$("#towerFactorydate").val(jsonData.towerFactorydate);
							$("#towerSource").combobox('setValue','外租');
							$("#qzlj").val(jsonData.qzlj);
							$("#qzljsl").val(jsonData.qzljsl);
							$("#simNumber").val(jsonData.simNumber);
							$("#gpsNo").val(jsonData.gpsNo);
						}
					}
				}
			});
		}
	}
	
	function onProjectSubmit(){
		if(isUnSub>0){
			return;//防止重复提交
		}
		isUnSub++;
		//重复TowerNo不能提交
		if(isRepeat == true){
			$.messager.alert('错误','您所填写的塔机编号重复，不能提交保存!','error');
			return;
		}
		//重复TowerFactryNo不能提交
		if(isRepeat1 == true){
			$.messager.alert('错误','您所填写的塔机出厂编号重复，不能提交保存!','error');
			return;
		}
		var parts = [];
		var data = $("[partmodelid]");
		for(var i=0; i<data.length; i++){
			var one = {};
			/* var partid = $(data[i]).attr("partid");
			var pid = $(data[i]).attr("partid");
			var model = $(data[i]).find("input").first().val();
			var num = $(data[i]).find('td:eq(3)').text(); */
			var contractPartId = $(data[i]).parent().parent().find('td:eq(5)').attr('id');
			var partNum = $(data[i]).parent().parent().find("input").last().val();
			
			one.assetId=contractPartId;
			if(!isEmpty(partNum) && partNum > 0){
				one.arrivalNum=partNum;
			}else{
				one.arrivalNum=0;
			}
			parts[i]=one;
		}
		$('#partJsonStr').val(JSON.stringify(parts));
		
		$.ajax({
			async : false,
			cache : false,
			type : 'POST',
			data :$("#projectForm").serialize(),
			url :'<%=basePath %>purchase/truck',
			error : function() {// 请求失败处理函数
				isUnSub--;
				$.messager.alert('错误','保存请求提交失败!','error');
			},
			success : function(data){
				window.returnValue = data;
				isUnSub--;
				if('y' == data){
					$.messager.alert('成功','资产信息保存入库成功!','info',function(){
						window.close();
					});
				}else if('n' == data){
					$.messager.alert('失败','资产信息保存失败!','error');
				}else{
					$.messager.alert('异常','资产信息保存异常!','error');
				}
			}
		});
	}
	
	/**
	**零部件操作方法*****************************
	*******************************************
	**/
	function showParts(id){
		//filterlever3Date(id);
		var tbodyId = "levelTow"+id;
		$("#"+tbodyId).show();
		$("#"+tbodyId).siblings("tbody").hide();
}

function deleteParts(id){
	var tbodyId = "levelTow"+id;
	$("#"+tbodyId).remove();
}

//数组中是否包含
function iscontains(array,value){
	var flag = false;
	for(var i=0; i<array.length; i++){
		if(array[i] == value){
			flag = true;
		}
	}
	return flag;
}

var level2PartListJson = $.parseJSON('${level2PartListJson}');
var level2Options = "<option></option>";
for(var i=0;i<level2PartListJson.length; i++){
	var id = level2PartListJson[i].id;
	var partName = level2PartListJson[i].part_name;
	var pid = level2PartListJson[i].pid;
	var partModel = "";
	if(JSON.stringify(level2PartListJson[i]).split(",").length != 3){
		partModel = level2PartListJson[i].part_model;
	}
	level2Options += "<option value='"+id+"' pid='"+pid+"' partModel='"+partModel+"'>"+partName+"</option>";
}
var level3PartListJson = $.parseJSON('${level3PartListJson}');
	 level3Options = "<option></option>";
	for(var i=0;i<level3PartListJson.length; i++){
			var id = level3PartListJson[i].id;
			var partName = level3PartListJson[i].part_name;
			var partModel = "";
			if(JSON.stringify(level3PartListJson[i]).split(",").length != 3){
				partModel = level3PartListJson[i].part_model;
			}
			var pid = level3PartListJson[i].pid;
			level3Options += "<option value='"+id+"' pid='"+pid+"' partModel='"+partModel+"'>"+partName+"</option>";
	}


function refreshIndex(trs){
	var i = 1;
	trs.each(function(){
		$(this).children(":first").children(":first").text(i++);
	})
}

//左侧添加时右侧同步添加隐藏的html代码
function dynamicHtml(id){
	var tbodyId = "levelTow"+id;
	var temp  = "<tbody id='"+tbodyId+"'  class='tbody' style='display:none'>"+
	        "<tr>"+
	          "<td><a class='button button_position addOneLevelThree'  title='新增'><img src='<%=basePath %>static/images/icons/add_icon.png' class='px18'/></a></td>"+
	          "<td colspan='6'></td>"+
	        "</tr>"+
	     "</tbody>";
	 $("#partTable").append(temp);
	 addOne();
}

function deleteOneTr(){
	//解除原来的事件
	$(".deleteOne").unbind("click");
	//删除一行
	$(".deleteOne").on("click",function(index){
		var thisTr = $(this).parent().parent();
		var siblings = thisTr.siblings().not(":last");
		thisTr.remove();
	     //更新索引
		refreshIndex(siblings);
	})
}


function deleteLevel2OneTr(){
	//解除原来的事件
	$(".deleteLevel2One").unbind("click");
	//删除一行
	$(".deleteLevel2One").on("click",function(index){
		var thisTr = $(this).parent().parent();
		var siblings = thisTr.siblings().not(":last");
		var  partid = thisTr.attr("partid");
		deleteParts(partid);
		thisTr.remove();
	     //更新索引
		refreshIndex(siblings);
	})
}

function addOne(){
	//filterlever3Date(toglepid);
	//解除原来的事件
	$(".addOneLevelThree").unbind("click");
	//右侧新增按钮添加点击事件
	$(".addOneLevelThree").on("click",function(){
		var thisTr = $(this).parent().parent();
       var html =  "<tr pid='' partid=''>"+
        "<td><div align='center'>"+
        "</div></td>"+
        "<td width='100px;'><select class='level3Combobox' style='float:left;width:120px;margin-bottom:0px;height:23px;'>"+level3Options+"</select></td>"+
        "<td><select class='level3ModelCombobox' style='float:left;width:120px;margin-bottom:0px;height:23px;'></select></td>"+
        "<td><div align='center'><input   name='Input' type='text' value='0' class='picture2r'/></div></td>"+
        "<td><div align='center'>个</div></td>"+
          "<td align='center'><a href='javascript:void(0)' class='deleteOne'><img src='<%=basePath %>static/images/icons/cross.png' alt='删除' title='删除'/></a></td>"+
      "</tr>"
		thisTr.before(html);
      //更新索引
		refreshIndex(thisTr.siblings());
		//添加删除事件
		deleteOneTr();
		
		$(".level3Combobox").on("change",function(){
			var text = $(this).find('option:selected').text();
			var value = $(this).val();
			var pid = $(this).find('option:selected').attr("pid");
			var partModel = $(this).find('option:selected').attr("partModel");
			//不要有重复的
			var siblings = $(this).parent().parent().siblings().not(":last");
			//根据value发送ajax请求
			var modelTd= 	$(this).parent().parent().children(":eq(2)").children();
				    $.ajax( {
				        dataType : "JSON",
				        type : "POST",
				        url : "<%=basePath %>part/ajaxPartModel",
				        data : "id="+value,
				        success : function(jsonStr) {
				        	var tempOption  ="<option></option>";
				        	for(var i=0; i<jsonStr.length; i++){
				        		var part_model =jsonStr[i]["part_model"];
				        		var id =jsonStr[i]["id"];
				        		tempOption +=  "<option value='"+id+"'>"+part_model+"</option>";
				        	} 
				        	modelTd.append(tempOption);
				        	level3ModelComboboxChange();
				        },
				        error : function(html) {
				        	$.messager.alert("错误","加载型号数据错误");
				        }
				    });
			
			//设置本行的属性
			$(this).parent().parent().attr("pid",pid);
			$(this).parent().parent().attr("partid",value);
			//设置型号
			//$(this).parent().parent().find("input").first().val(partModel);
			$(this).parent().html(text);
		})
		
	})
}


function level2ModelComboboxChange(){
	$(".level2ModelCombobox").on("change",function(){
		var text = $(this).children(":selected").text();
		var value = $(this).children(":selected").val();
		var modelLeft = $(".modelLeft");
		var partids=[];
		var m = 0;
		for(var i=0; i<modelLeft.length; i++){
			var partid= $(modelLeft[i]).attr("partModelId");
			if(partid != null && partid != ""){
				partids[m] = partid;
				m++;
			}
		};
		if(iscontains(partids,value)){
			$.messager.alert("提示","已经存在的主部件！",function(r){
			});
			$(this).val("");
			return;
		} 
		$(this).parent().parent().attr("partid",value);//这只改行的属性
		$(this).parent().html("<a href='javascript:showParts("+value+")' partModelId='"+value+"' class='chick_a default-tab modelLeft'>"+text+"</a>");
		dynamicHtml(value);
	})
}
function level3ModelComboboxChange(){
	$(".level3ModelCombobox").on("change",function(){
		var partModelPid = $(this).parent().parent().parent().attr("id").substring(8);
		var text = $(this).children(":selected").text();
		var value = $(this).children(":selected").val();
		var modelRight = $(".modelRight");
		var partids=[];
		var m = 0;
		for(var i=0; i<modelRight.length; i++){
			var partid= $(modelRight[i]).attr("partModelId");
			if(partid != null && partid != ""){
				partids[m] = partid;
				m++;
			}
		};
		if(iscontains(partids,value)){
		if($("[partmodelid='"+value+"']").attr("partmodelpid") ==partModelPid ){
			$.messager.alert("提示","已经存在的零部件！",function(r){
			});
			$(this).val("");
			return;
			};
		} 
		$(this).parent().html("<div partModelPid='"+partModelPid+"' partModelId='"+value+"' class='chick_a default-tab modelRight'>"+text+"</div>");
		dynamicHtml(value);
	})
}
	function showMessager(title,msg){
		$.messager.show({
			title:title,msg:msg,
			timeout:3000,showType:'show'
		});
	}
	function sumUseNum(obj){
		var num = $(obj).val();
		if(!/^(([0-9]*[1-9][0-9]*$)|(0))$/.test(num)){
			tatongMethod.alert("错误","只能输入数字");
			$(obj).val(0);
			return;
		}
		var partNumber = Number($(obj).parent().parent().find("td:eq(3)").text());
		var useNum = Number($(obj).parent().parent().find("td:eq(4)").attr('title'));
		var newUseNum = Number($(obj).val());
		var num = useNum + newUseNum;
		if(num > partNumber){
			showMessager('到货数量','总到货数量超过需求数量:'+partNumber+',当前已到货量:'+useNum);
			$(obj).val(partNumber - useNum);
			numOnChange(obj);
		}
	}
	var isRepeat = false;
	function checkTowerNo(obj){
		var towerNo = $(obj).val();
		if(!isEmpty('${manage.id}') && '${manage.towerManageNo}' == towerNo){
			return;//在未审核之前的资产到货信息可以编辑，所以此时的编辑不需要出发
		}
		
		/* if(!/^[\w]+$/.test(towerNo) && isEmpty(towerNo) == false){
			$.messager.alert("错误","编号无效! 仅支持字母与数字下划线。",'error',function(){
				$(obj).val('');
			}); 
			return;
		}*/
		var companyId = '${curCompany}';
		$.ajax({
			async : false,
			cache : false,
			type : 'POST',
			data:{
				"towerNo":towerNo,
				"companyId":companyId
			},
			url :'<%=basePath %>purchase/checkTowerNo',
			error : function() {// 请求失败处理函数
				$.messager.alert('错误','查询塔机编号请求失败!','error');
			},
			success : function(data){
				//JSON.parse(jsonstr); //可以将json字符串转换成json对象
				//JSON.stringify(jsonobj); //可以将json对象转换成json对符串 
				//data = eval('('+data+')');
				if(data == 'o'){
					$.messager.alert('错误','查询塔机编号请求失败!','error');
				}else if(data == 'n'){
					isRepeat = true;
					$.messager.alert('重复','您所填写的塔机编号，在当前管理公司已经存在!','error');
				}else{
					isRepeat = false;
				}
			}
		});
	}
	function selectTab(num){
		if(duibi() == false){//出厂时间错误不跳转
			return;
		}
		if(num == 1){
			$("#tabA1").removeClass("current"); //移除p元素中值为"high"的class 
			$("#tab5").css('display','none');
			$("#tab6").css('display','block');
			$("#tabA2").addClass("current"); // 追加样式 
		}else{
			$("#tabA2").removeClass("current"); //移除p元素中值为"high"的class 
			$("#tab6").css('display','none');
			$("#tab5").css('display','block');
			$("#tabA1").addClass("current"); // 追加样式 
		}
		
	}
	function duibi() {
		 
		/**2015-09-02 陈虹 因bug导致无法提交 暂时注释此方法*/
		var a = $('#towerFactorydate').val();
		if(isEmpty(a) == true){
			return true;//出厂时间为空时不做判断
		}
		var b = $('#receiveDate').val();
	    var arr = a.split("-");
	    var starttime = new Date(arr[0], arr[1], arr[2]);
	    var starttimes = starttime.getTime();

	    var arrs = b.split("-");
	    var lktime = new Date(arrs[0], arrs[1], arrs[2]);
	    var lktimes = lktime.getTime();

	    if (starttimes > lktimes) {
	    	$.messager.alert('错误','到货日期不能早于出厂日期!','error');
	        return false;
	    }else{return true;} 
	    
	}
	
	function numOnChange(obj){
		var num = $(obj).val();
		if(!/^(([0-9]*[1-9][0-9]*$)|(0))$/.test(num)){
			tatongMethod.alert("错误","只能输入数字");
			$(obj).val(0);
			return;
		}
		var befor = Number($(obj).parent().parent().find('td:eq(3)').text());
		if(befor == 0){befor=1;}//为零的时候强制转成1，防止计算异常NaN
		var sum;
		var result;
		var partid = $(obj).parent().parent().find("[partmodelid]").attr("partmodelid");
		$("#levelTow"+partid).find("input").each(
				function(){
					sum = Number($(this).parent().parent().find('td:eq(3)').text());
					num = Number(num);
					result = parseInt(sum/befor*num);
					$(this).val(result);
				}
		)
	}
	
	</SCRIPT>
</head>
<body>
<div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <ul class="content-box-tabs">
      	<li><a id="tabA1" href="#tab5" class="default-tab chick_a" > <h4>基础资料</h4></a></li>
        <!-- href must be unique and match the id of target div -->
        <li> <a id="tabA2" href="#tab6" class="chick_a"> <h4>部件到货</h4></a></li>
      </ul>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab5">
      <form id="projectForm">
      <!-- productName 塔式起重机=1,零部件=2 -->
      <c:choose>
      <c:when test="${productName == '2' }">
      	<table border="0" class="edit-table">
            <tr>
              <th><label ><b>*</b>塔机编号 </label></th>
              <td width="300">
              <%-- <input name="towerNo" type="text" required="true" value="${manage.towerManageNo }" <c:if test="${manage.id != null }">disabled="disabled"</c:if>/> --%>
              <%-- <c:choose>
              <c:when test="${towerNo != null }">
              ${towerNo}
              <input name="towerNo" type="hidden" value="${towerNo}"/>
              </c:when>
              <c:otherwise>
              <select name="towerNo" required="true"   class="easyui-combobox" <c:if test="${'0' != arrivalState }">disabled="disabled"</c:if>>
              	<c:forEach var="towerNo" items="${towerNoList}">
              		<option value="${towerNo.tower_no }" <c:if test="${manage.towerManageNo ==towerNo.tower_no }">selected="selected" </c:if>>${towerNo.tower_no }</option>
              	</c:forEach>
              </select>
              </c:otherwise>
              </c:choose> --%>
              <select name="towerNo" required="true"   class="easyui-combobox" <c:if test="${'0' != arrivalState }">disabled="disabled"</c:if>>
              	<c:forEach var="towerNo" items="${towerNoList}">
              		<option value="${towerNo.tower_no }" <c:if test="${manage.towerManageNo ==towerNo.tower_no }">selected="selected" </c:if>>${towerNo.tower_no }</option>
              	</c:forEach>
              </select>
              <!-- 资产到货编号 -->
              <input type="hidden" name="contractTowerId" value="${contractTowerId }" />
              <input type="hidden" name="id" id="tower_id"/>
              <input id="partJsonStr" type="hidden" name="partJsonStr">
              </td>
              <c:choose>
              <c:when test="${contractType == 1}">
              <th></th>
              <td></td>
              </c:when>
              <c:otherwise>
              <th scope="row"><label><b>*</b>调度单号</label></th>
              <td><input id="" required="true" name="dispatchNo" type="text"/></td>
              </c:otherwise>
              </c:choose>
            </tr>
          </table>
      </c:when>
      <c:otherwise>
      	<table border="0" class="edit-table">
            <tr>
              <th><label ><b>*</b>塔机编号 </label></th>
              <td width="300">
              <input name="towerNo" type="text" onblur="checkTowerNo(this);" required="true" value="${manage.towerManageNo }" <c:if test="${'0' != arrivalState }">disabled="disabled"</c:if> onpaste="return true" ondragenter="return false" oncontextmenu="return false;" style="ime-mode:disabled"/>
              <!-- 资产到货编号 -->
              <input type="hidden" name="contractTowerId" value="${contractTowerId }" />
              <input type="hidden" name="id" id="tower_id"/>
              <input type="hidden" name="manageId" value="${manage.id }">
              <input id="partJsonStr" type="hidden" name="partJsonStr">
              </td>
              <th scope="row"><label><b>*</b>塔机型号</label></th>
              <td>
              <select id="towerModel" class="easyui-combobox" name="towerModel"></select>
              </td>
            </tr>
            <tr>
            <th scope="row">出厂编号 </th>
              <td><input id="towerFactoryno" name="towerFactoryno" value="${info.towerFactoryno }" type="text" onblur="onblurByTowerFacNo();" <c:if test="${'0' != arrivalState}">disabled="disabled"</c:if> onpaste="return true" ondragenter="return false" oncontextmenu="return false;" style="ime-mode:disabled"/></td>
              <th scope="row"><label >塔机样式</label>              </th>
              <td><select id="towerType" name="towerType" class="easyui-combobox" ></select></td>
            </tr> 
            <tr>
              <th scope="row">出厂日期</th>
              <td><input id="towerFactorydate" name="towerFactorydate" type="text" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${info.towerFactorydate}" type="both" />" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'%y-%M-%d'});" <c:if test="${'0' != arrivalState}">disabled="disabled"</c:if>/></td>
              <th scope="row">到货日期</th>
              <td>
              <c:choose>
              <c:when test="${'0' != arrivalState}">
              <input name="receiveDate" id="receiveDate" type="text" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${info.receiveDate}" type="both" />" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'towerFactorydate\',{d:0});}'});" <c:if test="${'0' != arrivalState}">disabled="disabled"</c:if>/>
              </c:when>
              <c:otherwise>
              <input name="receiveDate" id="receiveDate" type="text" readonly="readonly" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${curDate}" type="both" />" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'towerFactorydate\',{d:0});}'});" <c:if test="${'0' != arrivalState}">disabled="disabled"</c:if>/>
              </c:otherwise>
              </c:choose>
              </td>
            </tr>
            <tr>
              <th scope="row">塔机来源</th>
              <td><select id="towerSource" name="towerSource" class="easyui-combobox" <c:if test="${'0' != arrivalState}">disabled="disabled"</c:if>>
              </select></td>
            
              <th scope="row">起重力矩</th>
              <td><input id="qzlj" name="qzlj" value="${info.qzlj }" type="text" <c:if test="${'0' != arrivalState}">disabled="disabled"</c:if>/>
                (单位：吨米)</td>
            </tr>
            <tr>
             <th scope="row">生产厂家</th>
              <td><select id="towerCreatecompany" name="towerCreatecompany" <c:if test="${'0' != arrivalState}">disabled="disabled"</c:if>></select></td>
              <th scope="row">容绳量</th>
              <td><input name="qzljsl" id="qzljsl" value="${info.qzljsl }" type="text" <c:if test="${'0' != arrivalState}">disabled="disabled"</c:if>/>
                (单位：米)</td>
            </tr>
            <tr>
              <th scope="row">管理公司</th>
              <td><select id="manageCompany" name="manageCompany" ></select></td>
              <th scope="row">管理单位</th>
              <td><select id="manageDepartment" name="manageDepartment" <c:if test="${'0' != arrivalState}">disabled="disabled"</c:if>></select></td>
            </tr>
            <tr>
              <th scope="row">合同编号</th>
              <td><input name="towerContractNo" type="text" readonly="readonly" value="${agreementNo }" /></td>
              <th scope="row">所属公司</th>
              <td><select id="towerRightcompany" name="towerRightcompany" ></select></td>
            </tr>
            <%-- <tr>
              <th scope="row">SIM卡号</th>
              <td><input name="simNumber" id="simNumber" value="${info.simNumber }" type="text" <c:if test="${manage.id != null }">disabled="disabled"</c:if>/></td>
              <th scope="row">GPS机具编号</th>
              <td><input name="gpsNo" id="gpsNo" value="${info.gpsNo }" type="text" <c:if test="${manage.id != null }">disabled="disabled"</c:if>/></td>
            </tr> --%>
          </table>
      </c:otherwise>
      </c:choose>
      </form>
      <table border="0" class="edit-table">
            <tr>
              <td width="42">&nbsp;</td>
              <td colspan="7">
              <a class="button_new" onclick="selectTab(1)" title="下一页"><img src="<%=basePath %>static/images/icons/next_icon.png" class="px18"/></a>
            </tr>
          </table>
      </div>
      
      <!-- End #tab1 -->
      <div class="tab-content" id="tab6">
      <table border="0" class="edit-table">
            <tr>
             <th><label><b>*</b>塔机型号:</label></th>
             <td>${towerModel }</td>
             <td></td>
             <td></td>
             <td></td>
             <td></td>
            </tr>
      </table>
      <div class="lefttable" style="float:left; clear:left;overflow:auto; overflow-x:hidden; width:550px;">
       <p>
          <label> <b>主要部件</b>(选择左侧列表的主要部件名称，系统自动带出右侧相关零部件清单。)</label></p>
        <table >
          <thead>
            <tr>
              <th scope="col" class="picture2"></th>
              <th  scope="col">主要部件</th>
              <th  scope="col" >型号</th>
              <th  scope="col" >合同</th>
              <th  scope="col" >剩余</th>
              <th  scope="col" >收货</th>
              <th  scope="col" >单位</th>
            </tr>
          </thead>
          <tbody>
		     <c:forEach var="part"  items="${part2Detail}" varStatus="status" >
           <tr pid="${part.pid }" partid="${part.id }" >
		        <td><div align="center">     
		          <script type="text/javascript">
		          	var num =	${status.index+1};
		          	document.write(num);
		           </script>
		          </div> 
	           </td>
	          <td>${part.part_name }</td>
              <td><a href="javascript:showParts('${part.part_model_id}')" partmodelid="${part.part_model_id}" class="chick_a default-tab modelLeft">${part.part_model}</a></td>
              <td>${part.partNumber}</td>
              <td title="${part.receivingAmount}">${part.partNumber - part.receivingAmount}</td>
              <td id="${part.contractPartId }">
              <c:choose>
              <c:when test="${part.arrivalNum != null }">
              <input onblur="sumUseNum(this);" onchange="numOnChange(this)" value="${part.arrivalNum}"/>
              </c:when>
              <c:otherwise>
              <c:choose>
              <c:when test="${part.partNumber - part.receivingAmount == 0}">已完毕</c:when>
              <c:otherwise><input onblur="sumUseNum(this);" onchange="numOnChange(this)" value="${part.partNumber - part.receivingAmount}"/></c:otherwise>
              </c:choose>
              </c:otherwise>
              </c:choose>
              </td>
              <td>${part.part_unit}</td>
            </tr>
       </c:forEach>
           
          </tbody>
        </table>
      </div>
      <div style="float:right;clear:right;overflow:auto; overflow-x:hidden;width:550px;">
        <p>
          <label> <b> 零部件</b></label>
         </p>
        <table >
          <thead>
            <tr>
              <th scope="col" class="picture2"></th>
              <th  scope="col">名称</th>
              <th  scope="col" >型号</th>
              <th  scope="col" >合同</th>
              <th  scope="col" >剩余</th>
              <th  scope="col" >收货</th>
              <th  scope="col" >单位</th>
             
            </tr>
          </thead>
          <c:forEach var="partTow"  items="${part2Detail}" varStatus="status" >
         
			<script type="text/javascript">
	          	var num = 1;
	     	</script>
				<tbody id="levelTow${partTow.part_model_id }"  class="tbody" <c:if test="${status.index!=0}">style="display:none"</c:if>>
					<c:forEach var="partThree"  items="${part3Detail}" varStatus="status" >
			   		  	<c:choose>
						       <c:when test="${partThree.part_model_pid==partTow.part_model_id}">
 						            <tr class="dataTr" pid="${partThree.part_model_pid }" partid="${partThree.part_model_id }" >
							              <td><div align="center">
							              	<script type="text/javascript">
										          	document.write(num++);
										     </script>
							              </div></td>
							              <td>${partThree.part_name }</td>
							              <td><div partmodelpid="${partThree.part_model_pid}" partmodelid="${partThree.part_model_id}" class="chick_a default-tab modelRight">${partThree.part_model}</div></td>
							              <td>${partThree.partNumber }</td>
							              <td title="${partThree.receivingAmount}">${partThree.partNumber - partThree.receivingAmount}</td>
							              <td id="${partThree.contractPartId }">
							              <c:choose>
							              <c:when test="${partThree.arrivalNum != null }">
							              <input onblur="sumUseNum(this);" value="${partThree.arrivalNum}"/>
							              </c:when>
							              <c:otherwise>
							              <c:choose>
							              <c:when test="${partThree.partNumber - partThree.receivingAmount == 0}">已完毕</c:when>
							              <c:otherwise><input onblur="sumUseNum(this);" value="${partThree.partNumber - partThree.receivingAmount}"/></c:otherwise>
							              </c:choose>
							              </c:otherwise>
							              </c:choose>
							              </td>
							              <td><div align="center">${partThree.part_unit}</div></td>
							            </tr>
							         </c:when>
						</c:choose>
					</c:forEach>
			        
			     </tbody>
       </c:forEach>
        </table>
      </div>
       <!-- End #tab2 -->
       <table border="0" class="edit-table">
            <tr>
              <td width="42">&nbsp;</td>
              <td colspan="7">
              <a class="button_new" onclick="window.close()" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a>
              <a id="submitButton" class="button_new" href="#" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a>
            </tr>
          </table>
    </div>
    <!-- End .content-box-content --> 
  </div>
  <!-- End .content-box -->
  <div class="clear"></div>
  
</div>
<!-- End #main-content -->
</div>
</body>
</html>