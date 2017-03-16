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
var pdocument = window.opener.document;
//公司管理分页,传递只需要页码和每页条数即可
var tab1PageNum = "${tab1PageNum}"==""?0:"${tab1PageNum}";
var tab1PerPage =  "${tab1PerPage}"==""?10: "${tab1PerPage}";
var togleRadioValue="";

function changePage(index,jq){
	if(jq.attr("id")=="pagination1"){
		$("#tab1PageNum").val(index);
		$("#tab1PerPage").val(tab1PerPage);
		$("#form1").submit();
	 }
} 

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
	$("[name='radio']").on("click",function(){
		var towerId = $(this).val();
		var tower_model =$(this).parent().parent().children(":eq(2)").text();
		if(togleRadioValue != towerId){
			togleRadioValue = towerId;
			$(this).attr("checked","checked");
		}else{//相等的时候设置不被选中
			togleRadioValue="";
			$(this).removeAttr("checked");
		} 
		//发送ajax请求修改塔机
	    $.ajax( {
	        dataType : "html",
	        type : "POST",
	        url : "<%=basePath %>transfer/ajaxTowerPart",
	        data : "tower_model="+tower_model,
	        success : function(html) {
	        	var parts = $.parseJSON(html);
	        	for(var i=0; i<parts.length; i++){
	        		var part = parts[i];
	        		var partid = part.part_id;
	        		var part_number = part.part_number;
	        		var tr = $("tr[partid='"+partid+"']");
	        		tr.children(":eq(3)").text(part_number);//设置需求数量
	        		var needNum= tr.children(":eq(4)").text();//可调数量
	        		var dispatchNum = needNum>part_number?part_number:needNum;
	        		tr.children(":eq(5)").find("input").val(dispatchNum);//设置调度数量
	        	}
	        },
	        error : function(html) {
	        	tatongMethod.alert("提示","服务器遇到问题！");
	        }
	    });
		
		
	})
	
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
			$("tr[pid='"+partid+"']").each(function(){
				var base = parseInt($(this).attr("base"));
				var dynamicNum =  base*partNum;
				if(!isNaN(dynamicNum) && dynamicNum >= 0){
					var input = $(this).find("input");
					var maxNum = input.parent().parent().prev().prev().text();
					if(maxNum<dynamicNum){
						input.val(maxNum);
					}else{
						input.val(dynamicNum);
					}
				}
			})
		}
	})
	//根据原来填写的数字进行展示
	if($("#partData",pdocument).val() != ""){
		var partDataJson = $.parseJSON($("#partData",pdocument).val());
		var parts = partDataJson.parts;
		for(var i=0; i<parts.length; i++){
			var partid = parts[i].partid;
			var num = parts[i].num;
			$("tr[partid='"+partid+"']").find("input").val(num);
		}
	}
	
	var dispatchType="${dispatchType}";
	if(dispatchType == "1"){
		$("#atab6").hide();
		$("#tab6").hide();
	}else{
		var tab = '${tab}';
		if(tab== "tab2"){
			$("#atab5").removeClass("current");
			$("#atab6").addClass("current");
			$("#tab5").hide();
			$("#tab6").show();
		} else{
			$("#atab6").removeClass("current");
			$("#atab5").addClass("current");
			$("#tab6").hide();
			$("#tab5").show();
		}
	}
	
	//初始化分页默认每页显示10条
	initPagination("pagination1","${count}",10,tab1PageNum);
	
	//更新数据
	//filterlever3Date($("#mainPartTable").find("tr:eq(1)").attr("partid"));
	//提交表单数据
	$("#submitButton").on("click",function(){
		
			if('${come_address}' ==""){
				tatongMethod.alert("提示","请选择仓库！");
				return;
			}
			var disc = $("#input3",pdocument).val();
			if("${come_address}" == disc){
				tatongMethod.alert("提示","发出地不能同于目的地！");
				return;	
			}
			window.close();
			var towerId = $("[name='radio']:checked").val();
			$("#towerId",pdocument).val(towerId);//设置塔机id
			var come_address = $("[name='radio']:checked").parent().parent().attr("come_address");//发出地
			var siblings = $("[name='radio']:checked").parent().siblings();
			var html = "";
			var towerId = $("[name='radio']:checked").val();
			if(towerId){
				html  = siblings.outerHTML();
			}else{
				html = 
                  "<td><div align='center'></div></td>"+
                "<td width='94'><div align='center'></div></td>"+
                "<td width='78'><div align='center'></div></td>"+
                "<td><div align='center'></div></td>"+
                "<td><div align='center'></div></td>"+
                "<td><div align='center'></div></td>"+
                "<td><div align='center'></div></td>"+
                "<td><div align='center'></div></td>";
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
			$("#come_address",pdocument).val("${come_address}");
			$("#template_id",pdocument).val("${template_id}");
			$("#start_address",pdocument).val("${come_address}");
			//准备零部件数据
			$("#hideTr",pdocument).html(html);
			$("#hideTr",pdocument).show();
			$("#hideTr",pdocument).children(":first").children(":first").text("1");
	})
	
	//查询按钮点击事件
	$("#submitButton1").on("click",function(){
		$("#tab").val("tab1");
		$("#form1").submit();
	})
	$("#submitButton2").on("click",function(){
		$("#tab").val("tab2");
		$("#form1").submit();
	})
	
})

</script>
</head>
<body>
<div id="main-content">
<form action="<%=basePath %>transfer/valueToSession" method="post" id="formOne">
<input type="hidden" name="partData" id="partData"/>
<input type="hidden" name="comeAddress"  id="comeAddress"/>
</form>
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <ul class="content-box-tabs">
        <li><a href="#tab5" class="default-tab chick_a" id="atab5"> <h4>调度资产</h4></a></li>
        <!-- href must be unique and match the id of target div -->
        <li> <a href="#tab6" class="chick_a" id="atab6"> <h4>调度部件</h4></a></li>
      </ul>
    </div>
   <div class="content-box-content">
       <form id="form1" action="<%=basePath %>transfer/selAsset" method="post">
      <div class="tab-content default-tab" id="tab5">
       <P><b>调度塔机</b></P>
      	<input type="hidden" id="dispatchType" name="dispatchType" value="${dispatchType }">
      	<input type="hidden" id="tab1PageNum" name="tab1PageNum" value="0">
	  	<input type="hidden" id="tab1PerPage" name="tab1PerPage" value="10">
	  	<input type="hidden" id="tab" name="tab" value="tab1">
          <table  class="edit-table">
            <tr>
             <th ><label><b>*</b>发出地:</label></th>
              <td>
              <select class="easyui-combobox"  name=come_address style="width:150px;">
						<option value="">不限</option>
					<c:forEach var="address"  items="${addressList}" varStatus="status" >
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
            <th >塔机型号:</th>
              <td>
          	<select class="easyui-combobox"  name="towerModel" style="width:150px;">
          		<option value="">不限</option>
					<c:forEach var="oneTowerModel"  items="${towerModelList}"   >
					<option value="${oneTowerModel.tower_model }" <c:if test='${oneTowerModel.tower_model == towerModel }'>selected</c:if>>${oneTowerModel.tower_model }</option>
					</c:forEach>
				</select> 
                  </td>
                  <th >塔机编号:</th>
              <td>
                    <input type="text" name="tower_manage_no"  value="${tower_manage_no }"/>
                 
                  </td>
              <th >出厂编号:</th>
              <td><input name="tower_factoryno" type="text" value="${tower_factoryno }"/></td>
             
                <td><a class="button1 button_position" href="javascript:void(0)"  id="submitButton1"  title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a></td>
            </tr>
          
          </table>

          <table >
            <thead>
              <tr>
                <th scope="col" class="chebox">&nbsp;</th>
                <th scope="col" class="chebox">项次</th>
                <th  scope="col">塔机型号</th>
                <th  scope="col">塔机编号</th>
                <th  scope="col">出厂编号</th>
                <th  scope="col">塔机来源</th>
                <th  scope="col">产权公司</th>
                <th  scope="col">管理公司</th>
                <th  scope="col">管理单位</th>
              </tr>
            </thead>
            <tbody>
			<c:forEach var="tower"  items="${towerList}" varStatus="status" >
              <tr come_address="${tower.come_address }">
                <td><input name="radio" type="radio" value="${tower.id }"  /></td>
                <td><div align="center">${status.index+1 }</div></td>
                <td width="94"><div align="center">${tower.tower_model}</div></td>
                <td width="78"><div align="center">${tower.tower_manage_no}</div></td>
                <td><div align="center">${tower.tower_factoryno}</div></td>
                <td><div align="center">${tower.tower_source}</div></td>
                <td><div align="center">${tower.rightCompany}</div></td>
                <td><div align="center">${tower.manageCompany}</div></td>
                <td><div align="center">${tower.department_name}</div></td>
              </tr>
			</c:forEach>
	          <tfoot>
	            <tr>
	              <td colspan="9"><div class="bulk-actions align-left">
	                  <label>共有<b>${count}</b>条数据</label>
	                </div>
	                <div  id="pagination1" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
	              </td>
	            </tr>
	          </tfoot>
          </table>
          <a class="button_new" onclick="selectTab()" title="下一页"><img src="<%=basePath %>static/images/icons/next_icon.png" class="px18"/></a>
 </div>
     <!-- End #tab1 -->
      <div class="tab-content" id="tab6">
          <table   class="edit-table">
            <tr>
             <th ><label><b>*</b>发出地:</label></th>
              <td>
              <input type="text" value="${come_address }" name="come_address1" readonly="readonly" name="link" />
              </td>
<%--               <th><label>部件名称:</label></th>
              <td ><input type="text"  name="part_name" value="${part_name }" /></td>
              <th><label>部件型号:</label></th>
              <td><input type="text" name="part_model" value="${part_model }" /></td>
              <td><a class="button1 button_position" href="javascript:void(0)" id="submitButton2" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a></td> --%>
              </tr>
          </table>
          
        <div  style="width:1140px"   style="overflow:auto;">
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
              <td><div align="center"><input  name="partNumber" type="text" value="0" class="picture2r"/></div></td>
              <td><div align="center">${part.part_unit}</div></td>
            </tr>
       </c:forEach>
          </tbody>
        </table>
        </div>
        </div>
        </div>
        </div>
       <div class="lefttable" style="float:left; margin-left:10px;overflow:auto; overflow-x:hidden; height:480px; ">
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
							              <td><div align="center"><input   name="partNumber" type="text" value="0" class="picture2r"/></div></td>
							              <td><div align="center">${partThree.part_unit}</div></td>
							            </tr>
							         </c:when>
						</c:choose> 
					</c:forEach>
			     </tbody>
       </c:forEach>
        </table>
      </div>
      
      
      
      
      
                <table border="0" class="edit-table">
            <tr>
              <td>&nbsp;</td>
              <td colspan="2"><a class="button_new" onclick="window.close()" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a><a class="button_new" href="javascript:void(0)" id="submitButton" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a>  </td>
            </tr>
          </table>
       </div>   
       </form>
       <!-- End #tab2 -->
    </div>
    <!-- End .content-box-content --> 
     
  </div>
  
  <!-- End .content-box -->
  <div class="clear"></div>

</div>
<!-- End #main-content -->

</body>
</html>