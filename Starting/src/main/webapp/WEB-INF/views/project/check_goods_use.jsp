<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%
	String path = request.getContextPath();
	String basePath =  path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>塔机方案</title>
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
<script type="text/javascript">
var mainPartId = 0;
var toglepid="";
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
			        	tatongMethod.alert("错误","加载型号数据错误");
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
		tatongMethod.alert("提示","已经存在的主部件！",function(r){
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
		tatongMethod.alert("提示","已经存在的零部件！",function(r){
		});
		$(this).val("");
		return;
		};
	} 
	$(this).parent().html("<div partModelPid='"+partModelPid+"' partModelId='"+value+"' class='chick_a default-tab modelRight'>"+text+"</div>");
	dynamicHtml(value);
})
}


	$(function(){
	
	//更新数据
	//filterlever3Date($("#mainPartTable").find("tr:eq(1)").attr("partid"));
	//提交表单数据
		$("#submitButton").on("click",function(){
			$.messager.confirm('进度审核', '您正在提交设备进度审核操作，是否确认并继续？', function (yes) {
				if(yes == true){
					$.ajax({
						async : false,
						cache : false,
						type : 'POST',
						data :{"goodsId":'${pro.id}',"useBatchNo":'${pro.useBatchNo}'},
						url :'<%=basePath %>contractPro/saveCheckGoodsUse',
						error : function() {// 请求失败处理函数
							$.messager.alert('错误','提交请求失败!','error');
						},
						success : function(data){
							if('n' == data){
								$.messager.alert('失败','设备需求进度审核失败!','error');
							}else{
								$.messager.alert('成功','设备需求进度审核成功!','info',function(){
									window.close();
								});
							}
						}
					});
				}
			});
		})
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
			        	tatongMethod.alert("错误","加载型号数据错误");
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
	function showMessager(title,msg){
		$.messager.show({
			title:title,msg:msg,
			timeout:3000,showType:'show'
		});
	}
	function sumUseNum(){
		var partNumber = Number($(obj).parent().parent().find("td:eq(3)").text());
		var dispatchNum = Number($(obj).parent().parent().find("td:eq(4)").text());
		var useNum = Number($(obj).parent().parent().find("td:eq(5)").text());
		var newUseNum = Number($(obj).val());
		var num = useNum + newUseNum;
		if(num > partNumber){
			showMessager('使用数量','总使用数量超过需求数量:'+partNumber+',当前已使用量:'+useNum);
			$(obj).val(partNumber - useNum);
		}
		if(num > dispatchNum){
			showMessager('使用数量','总使用数量超过调度数量:'+partNumber+',当前已使用量:'+useNum);
			$(obj).val(partNumber - useNum);
		}
	}
</script>
</head>
<body>
<div id="main-content">
  <div class="clear"></div>
  <!-- End .clear -->
  <div class="content-box">
  <form method="post" action="<%=basePath %>part/updateTemplate" style="display:none">
  		<input type="hidden" name="data" id="data">
  </form>
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>查询部件模块</h3>
    </div>
    <div class="content-box-content" >
     <table border="0" class="edit-table">
            <tr>
              <th><label><b>*</b>塔机型号:</label></th>
              <td >${pro.towerModel }</td>
              <th></th>
              <td ></td>
             </tr>
              <tr>
    <th scope="row"></th>
    <td colspan="5"></td>
             </tr>
            </table>
            <div style="width:100%">
      <div style="float:left;clear:left;overflow:auto; overflow-x:hidden;height:40%;">
        <p>
          <label> <b>主要部件</b></label>
         </p>
         <div>
      <div id="tab1" class="tab-content default-tab">
        <table  id="mainPartTable">
          <thead>
            <tr>
              <th scope="col" class="picture2"></th>
              <th scope="col">部件名称</th>
              <th scope="col" >型号</th>
              <th scope="col" >需求</th>
              <th scope="col" >调度</th>
              <th scope="col" >已用</th>
              <th scope="col" >申请</th>
              <th scope="col" >单位</th>
              <th scope="col" ></th>
            </tr>
          </thead>
          <tbody>
		     <c:forEach var="part"  items="${part2Detail}" varStatus="status" >
           <tr pid="${part.pid }" partid="${part.part_model_id }" >
		        <td><div align="center">     
		          <script type="text/javascript">
		          	var num =	${status.index+1};
		          	document.write(num);
		           </script>
		          </div> 
	           </td>
	            <td>${part.part_name }</td>
                <td><a href="javascript:showParts('${part.part_model_id}')" partmodelid="${part.part_model_id}" goodsDetailId="${part.goodsDetailId }" class="chick_a default-tab modelLeft current1">${part.part_model}</a></td>
              <td>${part.partNumber}</td>
              <td>${part.dispatchNum}</td>
              <td>${part.useNum }</td>
              <td>${part.number}</td>
              <td>${part.part_unit}</td>
              <td align="center"></td>
            </tr>
       </c:forEach>
             <tr>
          <td><%-- <a class="button button_position addOneLevelTow" href="javascript:void(0)" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a> --%></td>
          <td colspan="6"></td>
                </tr>
          </tbody>
        </table>
        </div>
        </div>
        </div>
        </div>
       <div class="lefttable" style="float:left; margin-left:10px;overflow:auto; overflow-x:hidden; height:40%;">
       <p>
          <label> <b>零部件</b></label></p>
        <table id="partTable">
          <thead>
            <tr>
              <th scope="col" class="picture2"></th>
              <th scope="col">部件名称</th>
              <th scope="col" >型号</th>
              <th scope="col" >需求</th>
              <th scope="col" >调度</th>
              <th scope="col" >已用</th>
              <th scope="col" >申请</th>
              <th scope="col" >单位</th>
              <th scope="col" ></th>
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
							               <td><div partmodelpid="${partThree.part_model_pid}" partmodelid="${partThree.part_model_id}" goodsDetailId="${partThree.goodsDetailId }" class="chick_a default-tab modelRight">${partThree.part_model}</div></td>
							              <td>${partThree.partNumber }</td>
							              <td>${partThree.dispatchNum}</td>
							              <td>${partThree.useNum }</td>
							              <td>${partThree.number }</td>
							              <td><div align="center">${partThree.part_unit}</div></td>
							                <td align="center"><%-- <a href="javascript:void(0)" class='deleteOne'><img src="<%=basePath %>static/images/icons/cross.png" alt="删除" title="删除"/></a> --%></td>
							            </tr>
							         </c:when>
						</c:choose>
					</c:forEach>
			        <tr>
			          <td><%-- <a class="button button_position addOneLevelThree"  title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a> --%></td>
			          <td colspan="6"></td>
			        </tr>
			     </tbody>
       </c:forEach>
        </table>
      </div>
        <table border="0" class="edit-table">
           <tr>
              <td >
              <a class="button_new" href="javascript:window.close();" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a>
              <a class="button_new" id="submitButton" href="javascript:void(0)" title="审核"><img src="<%=basePath %>static/images/icons/check_icons.png" class="px18"/></a> 
              </td>
              <td colspan="3">&nbsp;</td>
            </tr>
          </table>
      </div>
      <!-- End #tab1 -->
    </div>
    <!-- End .content-box-content -->
  </div>
  <!-- End .content-box -->
  <div class="clear"></div>

<!-- End #main-content -->
<div id="footer">
<small>達豐中國 地址：上海市长宁区天山西路1068号联强国际D栋4楼 电话:+86 21 60825373 </small><br /><br />
 <small>系统开发 Copyright © 2015 上海乔罗网络科技有限公司 </small> </div>
<!-- End #footer -->
</body>
</html>