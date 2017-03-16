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

	$(document).ready(function() {
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
</SCRIPT>
</head>
<body>
<div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <ul class="content-box-tabs">
        <li> <a href="#tab6" class="default-tab chick_a"> <h4>塔机零部件信息</h4></a></li>
      </ul>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab6">
      <div class="lefttable" style="float:left; clear:left;overflow:auto; overflow-x:hidden; width:550px;">
       <p>
          <label> <b>主要部件</b>(选择左侧列表的主要部件名称，系统自动带出右侧相关零部件清单。)</label></p>
        <table >
          <thead>
            <tr>
              <th scope="col" class="picture2"></th>
              <th  scope="col">主要部件</th>
              <th  scope="col" >型号</th>
              <th  scope="col" >数量</th>
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
              <td><a href="javascript:showParts('${part.part_model_id}')" partmodelid="${part.part_model_id}" class="chick_a default-tab modelLeft current1">${part.part_model}</a></td>
              <td>${part.partNumber}</td>
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
      <div>
      <div id="tab1" class="tab-content default-tab">
        <table >
          <thead>
            <tr>
              <th scope="col" class="picture2"></th>
              <th  scope="col">名称</th>
              <th  scope="col" >型号</th>
              <th  scope="col" >数量</th>
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
							              <td><div align="center">${partThree.part_unit}</div></td>
							            </tr>
							         </c:when>
						</c:choose>
					</c:forEach>
			     </tbody>
       </c:forEach>
        </table>
        </div>
        </div>
      </div>
       <!-- End #tab2 -->
    </div>
    <!-- End .content-box-content --> 
  </div>
  <!-- End .content-box -->
  <div class="clear"></div>
  <table border="0" class="edit-table">
            <tr>
              <td>&nbsp;</td>
              <td colspan="2">
              <a class="button_new" onclick="window.close()" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a>
            </tr>
          </table>
</div>
<!-- End #main-content -->
</div>
</body>
</html>