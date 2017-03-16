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

function showParts(id){
	var tbodyId = "levelTow"+id;
	$("#"+tbodyId).show();
	$("#"+tbodyId).siblings("tbody").hide();
}


$(function(){
	var towerNo = '${towerNo}';
	var towerId = '${towerId}';
	if(towerId != ""){
		var come_address = $("#come_address",pdocument).val();
		using(['combobox'],function(){
			$("#come_addressbox").combobox('setValue',come_address);
			$("#come_addressbox").combobox('readonly');
		});
	}
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
	
	if(towerNo != ""){
		$("#tab5").hide();
		$("#atab5").hide();
 		$("#atab6").addClass("current");
		$("#tab6").show(); 
	}
	$("#atab5").on("click",function(){
		$("#tab5").show();
		$("#tab6").hide();
	})
	$("#atab6").on("click",function(){
		$("#tab6").show();
		$("#tab5").hide();
	})

	//必须输入数字
	$("[ name='dispatchNum']").on("change",function(){
		var patten = /^(([0-9]*[1-9][0-9]*$)|(0))$/;//非负整数
		var dispatchNum = $(this).val();
		var allowNum = $(this).parent().prev().text();
		if(!patten.test(dispatchNum)){
			tatongMethod.alert("提示","请正确输入数字！");
			return;
		}
		allowNum = parseInt(allowNum);
		dispatchNum = parseInt(dispatchNum);
		if(allowNum<dispatchNum){
			tatongMethod.alert("提示","不能超过可掉数量！");
			$(this).val(allowNum);
			return;
		}
		
		if($(this).attr("partLeft")){
			var needNum = $(this).parent().prev().prev().text();
			
			needNum = parseInt(needNum);
			if(dispatchNum>needNum){
				tatongMethod.alert("提示","超过需求数量！");
				return;
			}
		}
		
		
		var partid = $(this).parent().parent().attr("partid");
		var pid = $(this).parent().parent().attr("pid");
		if(pid == ""){
			$("tr[pid='"+partid+"']").each(function(){
				var base = parseInt($(this).attr("base"));
				var dynamicNum =  base*dispatchNum;
				if(!isNaN(dynamicNum) && dynamicNum >= 1){
					var input = $(this).find("input");
					input.val(dynamicNum);
					var maxNum = input.parent().prev().text();
					if(maxNum<dynamicNum){
						input.val(maxNum);
					}
				}
			})
		}
		
	})
	
	
	$("#submitButton").on("click",function(){
		if('${come_address}'==""){
			tatongMethod.alert("提示","您还未选择仓库！");
			return
		}
		var disc = $("#input3",pdocument).val();
		disc=disc.substring(disc.indexOf("项目名称:")+5).trim();
		if("${come_address}" == disc){
			tatongMethod.alert("提示","发出地不能同于目的地！");
			return;	
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
		var towerId = $("[name='radio']:checked").val();
		var siblings = $("[name='radio']:checked").parent().siblings();
		if(towerId){
			$("#towerId",pdocument).val(towerId);//设置塔机id
			html  = siblings.outerHTML();
			$("#hideTr",pdocument).html(html);
		}else{
			if('${towerNo}' ==""){
				tatongMethod.alert("提示","请选择一个塔机！");
				return
			}
		}
		window.close();
	})
	

	$("#submitButton1").on("click",function(){
		$("#form1").submit();
	})
	$("#submitButton2").on("click",function(){
		$("#form2").submit();
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
	     <input type="hidden" id="tab1PageNum" name="tab1PageNum" value="0">
		 <input type="hidden" id="tab1PerPage" name="tab1PerPage" value="10">
		 <input type="hidden" name="towerModel" value="${towerModel }">
	     <input type="hidden" name="dispatchType" value="${dispatchType }">
	     <input type="hidden" name="towerNo" value="${towerNo }">
	     <input type="hidden" name="contractId" value="${contractId }">
	     <input type="hidden" name="dispatchAssetType" value="${dispatchAssetType }">
	     <input type="hidden" name="goods_id" value="${goods_id }">
          <table  class="edit-table">
            <tr>
             <th ><label><b>*</b>发出地:</label></th>
              <td>
              <select class="easyui-combobox"  name="come_address" style="width:150px;">
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
            <th >塔机型号:</th>
              <td>
                    <input type="text"  value="${towerModel }" name="towerModel"  <c:if test='${dispatchType==1 }'>readonly="readonly"</c:if>/>
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
    </form>
     <!-- End #tab1 -->
     <form id="form2" action="<%=basePath %>transfer/selAsset" method="post">
 	 <input type="hidden" id="tab1PageNum" name="tab1PageNum" value="0">
	 <input type="hidden" id="tab1PerPage" name="tab1PerPage" value="10">
	 <input type="hidden" name="towerModel" value="${towerModel }">
     <input type="hidden" name="dispatchType" value="${dispatchType }">
     <input type="hidden" name="dispatchAssetType" value="${dispatchAssetType }">
     <input type="hidden" name="towerNo" value="${towerNo }">
     <input type="hidden" name="contractId" value="${contractId }">
     <input type="hidden" name="goods_id" value="${goods_id }">
      <div class="tab-content" id="tab6">
          <table   class="edit-table">
            <tr>
             <th ><label><b>*</b>发出地:</label></th>
              <td>
                     <select class="easyui-combobox"  name="come_address" id="come_addressbox"  <c:if test='${towerNo ==""}'> disabled</c:if> style="width:150px;">
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
              &nbsp;&nbsp;&nbsp;&nbsp;<c:if test='${towerNo!=""}'> <a class="button1 button_position" href="javascript:void(0)"  id="submitButton2"  title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></c:if>
              </td>
              </tr>
          </table>
          
        <div  style="width:1140px"  style="overflow:auto;">
      <div class="lefttable" style="float:left; clear:left;overflow:auto; overflow-x:hidden; width:530px;height:450px;">
       <p><label> <b>主要部件</b>(选择左侧列表的主要部件名称，系统自动带出右侧相关零部件清单。)</label></p>
        <table   id="mainPartTable">
          <thead>
            <tr>
              <th  scope="col" class="picture2"></th>
              <th  style="width:133px;" scope="col">主要部件</th>
              <th  style="width:41px;" scope="col" >型号</th>
              <th  style="width:39px;" scope="col" >需求</th>
               <th style="width:39px;"  scope="col" >可调</th>
              <th style="width:72px;"  scope="col" >调度</th>
              <th style="width:39px;" scope="col" >单位</th>
            </tr>
          </thead>
<tbody>
         <c:forEach var="part"  items="${part2Detail}" varStatus="status" >
            <tr   pid="${part.part_base_pid }" partid="${part.part_base_id }" >
              <td><div align="center">
                  <script type="text/javascript">
		          	var num =	${status.index+1};
		          	document.write(num);
		          </script>
              </div></td>
              <td>${part.part_name }</td>
              <td><a href="javascript:showParts(${part.part_base_id})" class="chick_a current1">${part.part_model}</a></td>
              <td>${part.needNum<0?0:part.needNum}</td>
              <td>${part.maxNum==null?0:part.maxNum}</td>
              <td><input name="dispatchNum" type="text" partLeft="true" value="${(part.needNum<0?0:part.needNum) <(part.maxNum==null?0:part.maxNum)?(part.needNum<0?0:part.needNum):(part.maxNum==null?0:part.maxNum)  }" class="picture2r"/></td>
              <td>${part.part_unit}</td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
      <div class="lefttable" style="float:left; clear:right;overflow:auto;margin-left:20px; overflow-x:hidden; width:530px; height:450px;">
       <p>
        <label> <b>零部件</b></label></p>
		<table  id="partTable" >
          <thead>
            <tr >
              <th  scope="col" class="picture2"></th>
              <th  style="width:133px;" scope="col">名称</th>
              <th  style="width:41px;" scope="col" >型号</th>
              <th  style="width:39px;" scope="col" >需求</th>
               <th style="width:39px;"  scope="col" >可调</th>
              <th style="width:72px;"  scope="col" >调度</th>
              <th style="width:39px;" scope="col" >单位</th>
            </tr>
          </thead>
		<c:forEach var="partTow"  items="${part2Detail}" varStatus="status" >
			<script type="text/javascript">
	          	var num = 1;
	     	</script>
				<tbody  id="levelTow${partTow.part_base_id }"  class="tbody" <c:if test="${status.index!=0}">style="display:none"</c:if> >
					<c:forEach var="partThree"  items="${part3Detail}" varStatus="status" >
			   		  	<c:choose>
						       <c:when test="${partThree.part_base_pid==partTow.part_base_id}">
						       <script>
						       </script>
							            <tr  pid="${partThree.part_base_pid }" partid="${partThree.part_base_id }"  base="${partThree.needNum/partTow.needNum }">
							              <td><div align="center">
							              	<script type="text/javascript">
										          	document.write(num++);
										     </script>
							              </div></td>
							              <td>${partThree.part_name }</td>
							              <td>${partThree.part_model}</td>
								          <td>${partThree.needNum<0?0:partThree.needNum}</td>
							              <td>${partThree.maxNum==null?0:partThree.maxNum}</td>
							              <td><input name="dispatchNum" type="text" value="${(partThree.needNum<0?0:partThree.needNum) <(partThree.maxNum==null?0:partThree.maxNum)?(partThree.needNum<0?0:partThree.needNum):(partThree.maxNum==null?0:partThree.maxNum)  }" class="picture2r"/></td>
							               <td>${partThree.part_unit}</td>
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
                 <table border="0" class="edit-table">
            <tr>
              <td>&nbsp;</td>
              <td colspan="2"><a class="button_new" onclick="window.close()" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a><a class="button_new" href="javascript:void(0)" id="submitButton" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a>  </td>
            </tr>
          </table>
    </div>
    </form>
    <!-- End .content-box-content --> 
  </div>
  
  <!-- End .content-box -->
  <div class="clear"></div>
</div>
</div>
<!-- End #main-content -->

</body>
</html>