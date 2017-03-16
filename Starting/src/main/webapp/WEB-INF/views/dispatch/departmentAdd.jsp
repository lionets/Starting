<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath =  path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>塔机动态管理系统</title>
<!--                       CSS                       -->
<!-- Reset Stylesheet -->
<!-- Reset Stylesheet -->
<link rel="stylesheet" type="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/default/easyui.css">
<link rel="stylesheet" type="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/icon.css">
<link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
<!-- Main Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen" />
<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
<link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/css/select.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
<script src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" ></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<script type="text/javascript">
using(['window']);//加载window插件
var pdocument = window.opener.document;
<%--  function showParts(id){
	filterlever3Date(id);
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

var level3Options = "";
function filterlever3Date(partid){
	 level3Options = "<option></option>";
	for(var i=0;i<level3PartListJson.length; i++){
		if(level3PartListJson[i].pid ==partid){
			var id = level3PartListJson[i].id;
			var partName = level3PartListJson[i].part_name;
			var partModel = "";
			if(JSON.stringify(level3PartListJson[i]).split(",").length != 3){
				partModel = level3PartListJson[i].part_model;
			}
			var pid = level3PartListJson[i].pid;
			level3Options += "<option value='"+id+"' pid='"+pid+"' partModel='"+partModel+"'>"+partName+"</option>";
		}
	}
}


function refreshIndex(trs){
	var z= 1;
	trs.each(function(){
		$(this).children(":first").children(":first").text(z++);
	})
	
}

//左侧添加时右侧同步添加隐藏的html代码
function dynamicHtml(id){
	var tbodyId = "levelTow"+id;
	var temp  = "<tbody id='"+tbodyId+"'  class='tbody' style='display:none'>"+
	        "<tr>"+
	          "<td><a class='button1 button_position addOneLevelThree'  title='新增'><img src='<%=basePath %>static/images/icons/add_icon.png' class='px18'/></a></td>"+
	          "<td colspan='7'></td>"+
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
		var siblings = thisTr.siblings("tr").not(":last");
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
		var siblings = thisTr.siblings("tr").not(":last");
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
        "<td></td>"+
        "<td>12</td>"+
        "<td>21</td>"+
        "<td><input   name='Input' type='text' value='1' class='picture2r'/></td>"+
        "<td>个</td>"+
          "<td align='center'><a href='javascript:void(0)' class='deleteOne'><img src='<%=basePath %>static/images/icons/cross.png' alt='删除' title='删除'/></a></td>"+
      "</tr>"
		thisTr.before(html);
      //更新索引
		refreshIndex(thisTr.siblings("tr"));
		//添加删除事件
		deleteOneTr();
		
		$(".level3Combobox").on("change",function(){
			var text = $(this).find('option:selected').text();
			var value = $(this).val();
			var pid = $(this).find('option:selected').attr("pid");
			var partModel = $(this).find('option:selected').attr("partModel");
			//不要有重复的
			var siblings = $(this).parent().parent().siblings().not(":last");
			var partids=[];
			var m = 0;
			for(var i=0; i<siblings.length; i++){
				var partid= $(siblings[i]).attr("partid");
				if(partid != null && partid != ""){
					partids[m] = partid;
					m++;
				}
			};
			if(iscontains(partids,value)){
				tatongMethod.alert("提示","已经存在的零部件！");
				$(this).val("");
				return;
			} 
			
			//设置本行的属性
			$(this).parent().parent().attr("pid",pid);
			$(this).parent().parent().attr("partid",value);
			//设置型号
			$(this).parent().next().html(partModel);
			$(this).parent().html(text);
			dynamicHtml(value);
		})
		
	})
} --%>

	function change(record){
		$("#form").submit();
	}

$(function(){
	//根据原来填写的数字进行展示
	if('${partData}' != ""){
		var partDataJson = $.parseJSON('${partData}');
		var parts = partDataJson.parts;
		for(var i=0; i<parts.length; i++){
			var partid = parts[i].partid;
			var num = parts[i].num;
			$("tr[partid='"+partid+"']").find("input").val(num);
		}
	}
	//更新数据
	//filterlever3Date($("#mainPartTable").find("tr:eq(1)").attr("partid"));
	$(".picture2r").on("change",function(){
		var patt = /^(([0-9]*[1-9][0-9]*$)|(0))$/;//非负整数
		var value = $(this).val();
		var maxNum = $(this).parent().prev().text();
		if(!patt.test(value)){
			tatongMethod.alert("提示","请正确输入数字！");
			$(this).val(maxNum);
		}
		if(value > maxNum){
			tatongMethod.alert("提示","超过可掉数量！");
			$(this).val($(this).parent().prev().text());
		}
	})
	
	//提交表单数据
	$("#submitButton").on("click",function(){
		var jsonDate = {};
		var parts = [];
		var data = $("tr[partid]").filter("[partid != '']");
		for(var i=0; i<data.length; i++){
			var one = {};
			var partid = $(data[i]).attr("partid");
			var num = $(data[i]).find("input").last().val();
			one.partid=partid;
			one.num=num;
			parts[i]=one;
		}
		jsonDate.parts=parts;
		$("#partData").val(JSON.stringify(jsonDate));
		$("#comeAddress").val("${come_address}");
		$("#come_address",pdocument).val("${come_address}");
		$("#start_address",pdocument).val("${come_address}");
		$("#formOne").submit();
		window.close();
	})
/* 	addOne();
	//左侧新增按钮添加点击事件
	$(".addOneLevelTow").on("click",function(){
		var thisTr = $(this).parent().parent();
       var html =  "<tr pid='' partid=''>"+
       "<td><div align='center'>"+
       "</div></td>"+
	    "<td width='100'><select class='level2Combobox' style='float:left;width:120px;margin-bottom:0px;height:23px;'>"+level2Options+"</select></td>"+
	       "<td ></td>"+
	       "<td >10</td>"+
	       "<td >11</td>"+
	   "<td><input name='Input' type='text' value='0' class='picture2r'></td>"+
	   "<td>个</td>"+
	   "<td align='center'><a href='javascript:void(0)' class='deleteLevel2One'><img src='/leap/static/images/icons/cross.png' alt='删除' title='删除'></a></td>"+
	 "</tr>"
		thisTr.before(html);
		$(".level2Combobox").on("change",function(){
			var text = $(this).find('option:selected').text();
			var pid = $(this).find('option:selected').attr("pid");
			var partModel = $(this).find('option:selected').attr("partModel");
			var value = $(this).val();
			var temp = "<a href='javascript:showParts("+value+")'   class='chick_a current1'>"+text+"</a>";
			var siblings = $(this).parent().parent().siblings().not(":last");
			var partids=[];
			var m = 0;
			for(var i=0; i<siblings.length; i++){
				var partid= $(siblings[i]).attr("partid");
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
			//设置本行的属性
			$(this).parent().parent().attr("pid",pid);
			$(this).parent().parent().attr("partid",value);
			//设置型号
			$(this).parent().next().html(partModel);
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
	deleteLevel2OneTr(); */
})

</script>
</head>
<body>
<div id="main-content">
<form action="<%=basePath %>transfer/valueToSession" method="post" id="formOne">
<input type="hidden" name="partData" id="partData"/>
<input type="hidden" name="divHtml" id="divHtml"/>
<input type="hidden" name="come_address"  id="comeAddress"/>
</form>
  <div class="clear"></div>
  <!-- End .clear -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3> 可调部件</h3>
    </div>
   <div class="content-box-content" >
   <form action="<%=basePath %>transfer/departmentAdd" id="form" method="post">
	   <input  type="hidden" name="towerModel" value="${towerModel }"/>
	   <input  type="hidden" name="contractId" value="${contractId }"/>
	   <input  type="hidden" name="towerNo" value="${towerNo }"/>
	   <input  type="hidden" name="createNo" value="${createNo }"/>
        <table border="0" class="edit-table">
            <tr>
              <th>发出地</th>
 			<td >
	 			<select class="easyui-combobox"  name="come_address" data-options="onSelect:change"  id="come_address" disabled="disabled" style="width:150px;">
							<option value="">不限</option>
						<c:forEach var="address"  items="${comeAddressList}" varStatus="status" >
							<c:choose>
								<c:when test="${address.come_address==come_address }">
									<option value="${address.come_address }"  selected="selected">${address.come_address }</option>
								</c:when>
								<c:otherwise>
									<option value="${address.come_address }">${address.come_address }</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</select>
                </td>
              <th>塔机型号
               </th>
              <td>${towerModel}</td>

              <th>塔机编号
                  </th>
              <td>${towerNo } </td>
              <th>出厂编号
                 </th>
              <td>${createNo}</td>
              <%-- <td> <a class="button button_position" onclick="document.getElementById('form').submit()" href="javascript:void(0)" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a> </td> --%>
             </tr>
            </table>
      </form>
       <div  style="width:1150px" id="dynamicDiv">
      <div class="lefttable" style="float:left; clear:left;overflow:auto; overflow-x:hidden; width:530px; height:540px;">
       <p>
          <label> <b>主要部件</b>(选择左侧列表的主要部件名称，系统自动带出右侧相关零部件清单。)</label></p>
        <table   id="mainPartTable">
          <thead>
            <tr>
              <th  scope="col" class="picture2"></th>
              <th  style="width:133px;" scope="col">名称</th>
              <th  style="width:41px;" scope="col" >型号</th>
              <th  style="width:39px;" scope="col" >需求</th>
               <th style="width:39px;"  scope="col" >可调</th>
              <th style="width:72px;"  scope="col" >调度</th>
              <th style="width:39px;" scope="col" >单位</th>
              <!-- <th style="width:29px;" scope="col" ></th> -->
            </tr>
          </thead>
          <tbody>
         <c:forEach var="part"  items="${part2Detail}" varStatus="status" >
            <tr   pid="${part.pid }" partid="${part.id }" >
              <td><div align="center">
                  <script type="text/javascript">
		          	var num =	${status.index+1};
		          	document.write(num);
		          </script>
              </div></td>
               <td><a href="javascript:showParts(${part.id})" class="chick_a current1">${part.part_name }</a></td>
              <td>${part.part_model}</td>
              <td> ${part.needNum<0||part.needNum==null?0:part.needNum}</td>
              <td>${part.maxNum<0||part.maxNum==null?0+part.dispatchNum:part.maxNum+part.dispatchNum}</td>
              <td><input name="Input" type="text" readonly="readonly" value="${part.dispatchNum<0||part.dispatchNum==null?0:part.dispatchNum}" class="picture2r"/></td>
              <td>${part.part_unit}</td>
                <%-- <td align="center"><a href="javascript:void(0)"   class="deleteLevel2One"><img src="<%=basePath %>static/images/icons/cross.png" alt="删除" title="删除"/></a></td> --%>
            </tr>
          </c:forEach>
<%--              <tr>
          <td> <a class="button1 button_position addOneLevelTow" href="javascript:void(0)" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a></td>
          <td colspan="8"></td>
                </tr> --%>
          </tbody>
        </table>
      </div>
      <div style="float:left;clear:right;overflow:auto; overflow-x:hidden;margin-left:10px;height:540px; width:530px;">
       
        <p>
          <label> <b> 零部件</b></label>
         </p>
         <div>
      <div id="tab1" class="tab-content default-tab">
        </div>
         <div id="tab2" class="tab-content" >
        <table  id="partTable">
          <thead>
            <tr>
              <th  scope="col" class="picture2"></th>
              <th  style="width:133px;" scope="col">名称</th>
              <th  style="width:41px;" scope="col" >型号</th>
              <th  style="width:39px;" scope="col" >需求</th>
               <th style="width:39px;"  scope="col" >可调</th>
              <th style="width:72px;"  scope="col" >调度</th>
              <th style="width:39px;" scope="col" >单位</th>
              <!-- <th style="width:29px;" scope="col" ></th> -->
            </tr>
          </thead>
          <c:forEach var="partTow"  items="${part2Detail}" varStatus="status" >
			<script type="text/javascript">
	          	var num = 1;
	     	</script>
				<tbody  id="levelTow${partTow.id }"  class="tbody" <c:if test="${status.index!=0}">style="display:none"</c:if> >
					<c:forEach var="partThree"  items="${part3Detail}" varStatus="status" >
			   		  	<c:choose>
						       <c:when test="${partThree.pid==partTow.id}">
						       <script>
						       </script>
							            <tr  pid="${partThree.pid }" partid="${partThree.id }" >
							              <td><div align="center">
							              	<script type="text/javascript">
										          	document.write(num++);
										     </script>
							              </div></td>
							              <td>${partThree.part_name }</td>
							              <td>${partThree.part_model}</td>
								          <td>${partThree.needNum<0?0:partThree.needNum}</td>
							              <td>${partThree.maxNum==null?0:partThree.maxNum}</td>
							              <td><input name="Input" type="text" value="${partThree.maxNum==null?0:partThree.maxNum}" class="picture2r"/></td>
							               <td>${partThree.part_unit}</td>
							               <%-- <td align="center"><a href="javascript:void(0)"   class='deleteOne'><img src="<%=basePath %>static/images/icons/cross.png" alt="删除" title="删除"/></a></td> --%>
							            </tr>
							         </c:when>
						</c:choose>
					</c:forEach>
<%-- 						  <tr>
					          <td> <a class="button1 button_position addOneLevelThree" href="javascript:void(0)" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a></td>
					          <td colspan="7"></td>
					    </tr> --%>
			     </tbody>
       </c:forEach>
        </table>
        </div>
        </div>
        </div>
<%-- 		<c:if test="${divHtml !=null}">
			${divHtml}
		</c:if>      --%>   
        </div>
        <table border="0" class="edit-table">
          <tr>
            <td>&nbsp;</td>
            <td colspan="2"><a class="button_new" onclick="window.close()" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a><a class="button_new" href="javascript:void(0)" id="submitButton" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a></td>
          </tr>
        </table>
      </div>
    </div>
</div>

</body>
</html>
