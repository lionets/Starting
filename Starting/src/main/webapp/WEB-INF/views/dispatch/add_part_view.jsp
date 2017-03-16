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
var pdocument = window.opener.document;

using(['window']);//加载window插件
var pdocument = window.opener.document;
//公司管理分页,传递只需要页码和每页条数即可
var tab1PageNum = "${tab1PageNum}"==""?0:"${tab1PageNum}";
var tab1PerPage =  "${tab1PerPage}"==""?10: "${tab1PerPage}";

var togleRadioValue="";


function showParts(id){
	//filterlever3Date(id);
	var tbodyId = "levelTow"+id;
	$("#"+tbodyId).show();
	$("#"+tbodyId).siblings("tbody").hide();
}
//下一页
function selectTab(){
	$("#atab5").removeClass("current"); //移除p元素中值为"high"的class 
	$("#tab5").css('display','none');
	$("#atab6").addClass("current"); // 追加样式 
	$("#tab6").show();
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

$(function(){
	//根据之前的调度数据回显
	if('${partJson}' != ""){
		var parts = $.parseJSON('${partJson}');
		for(var i=0; i<parts.length; i++){
			var part = parts[i];
			 var partid = part.partid;
			 var pid = (part.pid == null ? "":part.pid);
			 var num = part.num;
			 $("[partid='"+partid+"'][pid='"+pid+"']").find("input").val(num);
/* 			var alowTd =  $("[partid='"+partid+"'][pid='"+pid+"']").find("input").parent().parent().prev().prev().children();
			alowTd.text(parseInt(alowTd.text())+parseInt(num)); */
		}
	}
	
	$('[name="partNumber"]').on("change",function(){
		var partNum = $(this).val();
		var prevNum = $(this).parent().parent().prev().prev().text();
		var patten = /^(([0-9]*[1-9][0-9]*$)|(0))$/;
		if(!patten.test(partNum)){
			tatongMethod.alert("提示","请正确输入数字！");
			$(this).val(0);
			return;
		}
		if(parseInt(prevNum)<parseInt(partNum)){
			tatongMethod.alert("提示","超过最大可调数量！");
			$(this).val(prevNum);
			return;
		}
		var partid = $(this).parent().parent().parent().attr("partid");
		var pid = $(this).parent().parent().parent().attr("pid");
		if(pid == ""){
			var base = parseInt($("tr[pid='"+partid+"']").attr("base"));
			if(isNaN(base)){
				base = 0;
			}
			
			$("tr[pid='"+partid+"']").find("input").val(base*partNum);
		}
	})
	
	
	
	//更新数据
	//filterlever3Date($("#mainPartTable").find("tr:eq(1)").attr("partid"));
	//提交表单数据
	$("#submitButton").on("click",function(){
		
			if('${come_address}' ==""){
				tatongMethod.alert("提示","请选择仓库！");
				return;
			}

			
			//准备零部件数据
			var jsonDate = {};
			var parts = [];
			var data = $("tr[partid]").filter("[partid != '']");
			for(var i=0; i<data.length; i++){
				var one = {};
				var partid = $(data[i]).attr("partid");
				var pid  = $(data[i]).attr("pid");
				var num = $(data[i]).find("input").last().val();
				one.partid=partid;
				one.pid=pid;
				one.num=num;
				parts[i]=one;
			}
			jsonDate.parts=parts;
			$("#partData",pdocument).val(JSON.stringify(jsonDate));
			$("#start_address",pdocument).val('${come_address}');
			$("#startAddressLabel",pdocument).text('${come_address}');
			window.close();
	})
	
	//查询按钮点击事件
	$("#submitButton1").on("click",function(){
		$("#tab").val("tab1");
		$("#form1").submit();
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
      
          <h3>处置部件</h3>
         
    </div>
    <div class="content-box-content">
     <form id="form1" action="<%=basePath %>/handle/add_part" method="post">
     	<input type="hidden" name="towerModel" value="${towerModel}"/>
     	<input type="hidden" name="towerNo" value="${towerNo}"/>
     	<input type="hidden" name="partData" value=""/>
        <table   class="edit-table">
            <tr>
             <th ><label><b>*</b>发出地:</label></th>
              <td>
             ${come_address }
			</td>
            <th >塔机型号:</th>
              <td>${towerModel }
                  </td>
                  <th >塔机编号:</th>
              <td>
                    ${towerNo }
                 
                  </td>
                <td><a class="button1 button_position" href="javascript:void(0)"  id="submitButton1"  title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a></td>
            </tr>
          </table>
         </form>
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
              <th width="60px;" scope="col" >部件数量</th>
              <th width="60px;" scope="col" >需求数</th>
              <th width="60px;" scope="col" >处置数量</th>
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
              <td><div align="center"><input  name="partNumber" disabled="disabled"  type="text" value="0" class="picture2r"/></div></td>
              <td><div align="center">${part.part_unit}</div></td>
            </tr>
       </c:forEach>
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
              <th  width="60px;" scope="col" class="picture2"></th>
              <th width="100px;" scope="col">部件名称</th>
              <th width="100px;" scope="col" >型号</th>
              <th width="60px;" scope="col" >部件数量</th>
              <th width="60px;" scope="col" >需求数</th>
              <th width="60px;" scope="col" >处置数量</th>
              <th width="38px;" scope="col" >单位</th>
            </tr>
          </thead>
         <c:forEach var="partTow"  items="${part2Detail}" varStatus="status" >
			<script type="text/javascript">
			var num =1;
	     	</script>
				<tbody id="levelTow${partTow.part_model_id }"  class="tbody" <c:if test="${status.index!=0}">style="display:none"</c:if>>
					<c:forEach var="partThree"  items="${part3Detail}" varStatus="status" >
 			   		  	<c:choose>
						       <c:when test="${partThree.part_model_pid==partTow.part_model_id}">
 						            <tr class="dataTr" pid="${partThree.part_model_pid }" partid="${partThree.part_model_id }"  base="${partThree.partNumber/partTow.partNumber }">
							             	 <td><div align="center">
							              	<script type="text/javascript">
										          	document.write(num++);
										     </script>
							              </div></td>
							              
							              <td>${partThree.part_name }</td>
							               <td><div partmodelpid="${partThree.part_model_pid}" partmodelid="${partThree.part_model_id}" class="chick_a default-tab modelRight">${partThree.part_model}</div></td>
							              <td><div align="center">${partThree.num==null?0:partThree.num}</div></td>
							              <td><div align="center">${partThree.partNumber }</div></td>
							              <td><div align="center"><input disabled="disabled"  name="partNumber" type="text" value="0" class="picture2r"/></div></td>
							              <td><div align="center">${partThree.part_unit}</div></td>
							            </tr>
							         </c:when>
						</c:choose> 
					</c:forEach>
			     </tbody>
       </c:forEach>
        </table>
      </div>
          
        
      <!-- End .content-box-content -->
      <table border="0" class="edit-table">
          <tr>
            <td>&nbsp;</td>
            <td colspan="2"><a class="button_new" onclick="window.close()" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a> </td>
          </tr>
        </table>
    </div>
    <!-- End .content-box -->
    <div class="clear"></div>
  </div>
</div>
<!-- End #main-content -->
</body>
</html>
