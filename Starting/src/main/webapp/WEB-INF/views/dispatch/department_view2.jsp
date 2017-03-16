<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath =  path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>塔机动态管理系统</title>
<!--                       CSS                       -->
<!-- Reset Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
<!-- Main Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/js/paging/pagination.css" />
<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
<link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/css/select.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery.datePicker.js"></script>
<SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></SCRIPT>
<script type="text/javascript" src="<%=basePath %>static/js/paging/jquery.pagination.js"></script>
<script src="<%=basePath %>static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<script type="text/javascript">
using(['window']);//加载window插件
using(['combobox']);//加载window插件
var pdocument = window.opener.document;

//公司管理分页,传递只需要页码和每页条数即可
var tab1PageNum = "${tab1PageNum}"==""?0:"${tab1PageNum}";
var tab1PerPage =  "${tab1PerPage}"==""?10: "${tab1PerPage}";

function changePage(index,jq){
	if(jq.attr("id")=="pagination1"){
		$("#tab1PageNum").val(index);
		$("#tab1PerPage").val(tab1PerPage);
		$("#form1").submit();
	 }
} 


//分页初始化传入id代表要创建分页的id号，参数count代表总数量，perPage表示每页显示条数,current_page为当前页
function initPagination(id,count,perPage,current_page) {
	$("#"+id).pagination(count, {
		items_per_page:perPage, //每页显示数目
		num_edge_entries:4,//边缘页后面显示数目
		num_display_entries:4,//边缘页前面显示数目
		current_page:current_page,//显示第1页
		prev_text:"上页",
		next_text:"下页",
		ellipse_text:"...",//中间缺省内容
		prev_show_always:true,
		next_show_always:true,
		show_if_single_page:true,
		callback:changePage,
		load_first_page:false,
	});
 };

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

jQuery.fn.outerHTML = function() {
    return $("<p>").append( $(this).clone()).html();
};

function showParts(id){
	var tbodyId = "levelTow"+id;
	$("#"+tbodyId).show();
	$("#"+tbodyId).siblings("tbody").hide();
}


$(function(){
	//根据之前的调度数据回显
	if('${dispatchPartList}' != ""){
		var parts = $.parseJSON('${dispatchPartList}');
		for(var i=0; i<parts.length; i++){
			var part = parts[i];
			 var partid = part.partid;
			 var pid = part.pid==null?"":part.pid;
			 var num = part.num;
			 $("[partid='"+partid+"'][pid='"+pid+"']").find("input").val(num);
		}
	}
	

	//必须输入数字
	$("[ name='dispatchNum']").on("change",function(){
		var patten = /^(([0-9]*[1-9][0-9]*$)|(0))$/;//非负整数
		var dispatchNum = $(this).val();
		var allowNum = $(this).parent().prev().text();
		if(!patten.test(dispatchNum)){
			tatongMethod.alert("提示","请正确输入数字！");
		}
		if (parseInt(allowNum)<parseInt(dispatchNum)){
			tatongMethod.alert("提示","不能超过可掉数量！");
			$(this).val(allowNum);
		}
	})
	
	$("#submitButton").on("click",function(){
		if('${come_address}'==""){
			tatongMethod.alert("提示","您还未选择仓库！");
			return
		}
		var trs = $("tr[partid]");
		//准备零部件数据
		var jsonDate = {};
		var parts = [];
		for(var i=0; i<trs.length; i++){
			var onePart = {};
			var tr = trs[i];
			var partid = $(tr).attr("partid");
			var pid = $(tr).attr("pid");
			var num = $(tr).find("input").val();
			onePart.partid = partid;
			onePart.pid = pid;
			onePart.num = num;
			parts[i]=onePart;
		}
		jsonDate.parts=parts;
		$("#partData",pdocument).val(JSON.stringify(jsonDate));
		$("#come_address",pdocument).val("${come_address}");
		$("#start_address",pdocument).val("${come_address}");
		window.close();
	})
	

	$("#submitButton2").on("click",function(){
		$("#form2").submit();
	})
	
})

</script>
</head>
<body>
<div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <ul class="content-box-tabs">
        <!-- href must be unique and match the id of target div -->
        <li> <a href="#tab6" class="chick_a default-tab" id="atab6"> <h4>调度部件</h4></a></li>
      </ul>
    </div>
   <div class="content-box-content">
     <!-- End #tab1 -->
     <form id="form2" action="<%=basePath %>transfer/assetedit" method="post">
 	 <input type="hidden" id="tab1PageNum" name="tab1PageNum" value="0">
	 <input type="hidden" id="tab1PerPage" name="tab1PerPage" value="10">
	 <input type="hidden" name="towerModel" value="${towerModel }">
     <input type="hidden" name="dispatch_type" value="${dispatch_type }">
     <input type="hidden" name="towerNo" value="${towerNo }">
     <input type="hidden" name="contractId" value="${contractId }">
      <input type="hidden" name="goods_id" value="${goods_id }">
      <input type="hidden" name="dispatch_id" value="${dispatch_id }">
      <div class="tab-content default-tab" id="tab6">
          <table   class="edit-table">
            <tr>
             <th ><label><b>*</b>发出地:</label></th>
              <td>
                     ${come_address }
			 <%-- <th><label>部件名称:</label></th>
              <td ><input type="text"  name="part_name" value="${part_name }" /></td>
              <th><label>部件型号:</label></th>
              <td><input type="text" name="part_model" value="${part_model }" /></td>
              <td><a class="button1 button_position" href="javascript:void(0)" id="submitButton2" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a></td>
              --%> </tr>
          </table>
          
         <div  style="width:1140px">
      <div style="float:left;clear:left;overflow:auto; overflow-x:hidden;height:480px; width:500px;">
        <p>
          <label> <b>主要部件</b></label>
         </p>
         <div>
      <div id="tab1" class="tab-content default-tab">
        <table  id="mainPartTable">
          <thead>
            <tr>
              <th width="60px;" scope="col" class="picture2"></th>
              <th width="100px;" scope="col">部件名称</th>
              <th width="100px;" scope="col" >型号</th>
              <th width="60px;" scope="col" >可调</th>
              <th width="60px;" scope="col" >需求数</th>
              <th width="60px;" scope="col" >调度</th>
              <th width="39px;"  scope="col" >单位</th>
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
                  <td><a href="javascript:showParts('${part.part_model_id}')" partmodelid="${part.part_model_id}" class="chick_a default-tab modelLeft">${part.part_model}</a></td>
              <td><div align="center">${part.num==null?0:part.num}</div></td>
              <td><div align="center">${part.partNumber}</div></td>
              <td><div align="center"><input  name="partNumber" type="text" value="0"  disabled="disabled" class="picture2r"/></div></td>
              <td><div align="center">${part.part_unit}</div></td>
            </tr>
       </c:forEach>
          </tbody>
        </table>
        </div>
        </div>
        </div>
        
       <div class="lefttable" style="float:left; margin-left:10px;overflow:auto; overflow-x:hidden; height:40%;">
       <p>
          <label> <b>零部件</b></label></p>
        <table id="partTable">
          <thead>
            <tr>
              <th  width="60px;" scope="col" class="picture2"></th>
              <th width="100px;" scope="col">部件名称</th>
              <th width="100px;" scope="col" >型号</th>
              <th width="60px;" scope="col" >可调</th>
              <th width="60px;" scope="col" >需求数</th>
              <th width="60px;"  scope="col" >调度</th>
              <th width="38px;" scope="col" >单位</th>
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
							              <td><div align="center">${partThree.num==null?0:partThree.num}</div></td>
							              <td><div align="center">${partThree.partNumber }</div></td>
							              <td><div align="center"><input   name="partNumber" type="text" value="0" disabled="disabled" class="picture2r"/></div></td>
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
       <!-- End #tab2 -->
    </div>
    </form>
    <!-- End .content-box-content --> 
  </div>
  
  <!-- End .content-box -->
  <div class="clear"></div>
          <table border="0" class="edit-table">
            <tr>
              <td>&nbsp;</td>
              <td colspan="2"><a class="button_new" onclick="window.close()" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a></td>
            </tr>
          </table>
</div>
</div>
<!-- End #main-content -->

</body>
</html>