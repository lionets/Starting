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
<link rel="stylesheet" type="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/default/easyui.css">
<link rel="stylesheet" type="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/icon.css">
<link rel="stylesheet" href="<%=basePath %>static/js/paging/pagination.css" />
<link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
<!-- Main Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen" />
<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
<link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/css/select.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery.datePicker.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/paging/jquery.pagination.js"></script>
<SCRIPT src="<%=basePath %>static/js/jQselect.js" type=text/javascript></SCRIPT>
<SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></SCRIPT>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>

<style type="text/css">
    #imgdiv
    {
     FILTER: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)
    }
</style>
<SCRIPT type=text/javascript>
	using(['messager']);
	var pwindow = window.opener;
	var pdocument = window.opener.document;
	
	var tab1PageNum = "${tab1PageNum}"==""?0:"${tab1PageNum}";
	var tab1PerPage =  "${tab1PerPage}"==""?5: "${tab1PerPage}";

	var tab2PageNum = "${tab2PageNum}"==""?0:"${tab2PageNum}";
	var tab2PerPage =   "${tab2PerPage}"==""?5: "${tab2PerPage}";
	
	//分页点击执行的操作
 	function changePage(index,jq){
		if(jq.attr("id")=="pagination1"){
			$("#tab1PageNum").val(index);
			$("#tab1PerPage").val(tab1PerPage);
			$("#form1").submit();
		 }
		if(jq.attr("id")=="pagination2"){
			$("#tab2PageNum").val(index);
			$("#tab2PerPage").val(tab1PerPage);
			$("#form2").submit();
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
			link_to:"javascript:void(0)",
			ellipse_text:"...",//中间缺省内容
			prev_show_always:true,
			next_show_always:true,
			show_if_single_page:true,
			callback:changePage,
			load_first_page:false,
		});
	 };
	$(document).ready(function() {
 		if("${dispatchType}"=="1"){
			$("#atab2").hide();
			initPagination("pagination1","${count}",5,tab1PageNum);
		}else{
			$("#atab1").hide();
			initPagination("pagination2","${count}",5,tab2PageNum);
		} 
 		//提交表单
 		$("#submitButton").on("click",function(){
 			if("${dispatchType}"=="1"){
 	           // 获得被选中的合同
 	           var selectRadio = $("[name='contractRadio']:checked");
 	           var goodsInfoId =selectRadio.val();
 	     	    $("#goodsInfoId", pdocument).val(goodsInfoId);
 	           var towerModelRadio = $("[name='towerModelRadio']:checked");
 	           var towerId = towerModelRadio.val();
 	           var product_name=towerModelRadio.attr("product_name");
 	           var goods_id =  towerModelRadio.parent().parent().attr("goods_id");
 	         $("#goods_id", pdocument).val(goods_id);
 	         $("#product_name", pdocument).val(product_name);
 	           if(selectRadio.length == 0){
 	        	   tatongMethod.alert("提示","请先选择一个合同!");
 	        	   return;
 	           }
 	           if(towerModelRadio.length == 0){
 	        	   tatongMethod.alert("提示","请先选择一个塔机型号!");
 	        	   return;
 	           }
 	           var contractId = selectRadio.val();
 			   var contractNo = selectRadio.parent().parent().children(":eq(2)").text();
 			   var proName = selectRadio.parent().parent().children(":eq(3)").text();
 			   var tempStr = "合同编号:"+contractNo+", 项目名称:"+proName;
 				var towerModel = towerModelRadio.parent().parent().children(":eq(2)").text();//塔机型号
 				var towerNo = towerModelRadio.parent().parent().children(":eq(3)").text();//塔机编号
 				var createNo = towerModelRadio.parent().parent().children(":eq(4)").text();//出厂编号
 			   //设置父窗口的表单值
 				 $("#input3",pdocument).val(tempStr);
 				 $("#end_address",pdocument).val(proName);
 				$("#proName",pdocument).val(proName);
 				 $("#contractId",pdocument).val(contractId);
 				 $("#proName",pdocument).val(proName);
 				 //设置父窗口隐藏的行
 				 window.close();
 				var hideTr =  $("#hideTr",pdocument);
 				hideTr.children(":eq(1)").children().text(towerModel);
 				hideTr.children(":eq(2)").children().text(towerNo);
 				hideTr.children(":eq(3)").children().text(createNo);
 				hideTr.show();
 			}
 			if("${dispatchType}"=="2"){
  	           // 获得被选中的仓库
  	           var JQselectRadio = $("[name='repositoryRadio']:checked");
  	         	var repositoryName = JQselectRadio.parent().parent().children(":eq(2)").text();
  	         	$("#end_address".pdocument).val(repositoryName);
  	         	 $("#proName",pdocument).val(repositoryName);
  	         	if(repositoryName == ""){
  	         	 	tatongMethod.alert("提示","请先选择一个仓库!");
  	        	 }else{
  	 			   //设置父窗口的表单值
  	 				 $("#input3",pdocument).val(repositoryName);
  	 				window.close();
  	        	 }
 			}
            
 		})
 		
 		//单选按钮发生变化
 		$("[name='contractRadio']").on("click",function(){
 			var contractid = $(this).val();
  		    $.ajax( {
 		        dataType : "JSON",
 		        type : "POST",
 		        url : "<%=basePath %>transfer/selectNeedGoods",
 		        data : "contract_id="+contractid,
 		        success : function(jsonStr) {
 		        	var html = "";
 		        	for(var i=0; i<jsonStr.length; i++){
 		        		var tower = jsonStr[i];
 		        		if(!tower.tower_no){
 		        			tower.tower_no = "";
 		        		}
 		        		if(!tower.create_no){
 		        			tower.create_no = "";
 		        		}
 		        		if(!tower.towerId){
 		        			tower.towerId="";
 		        		}
 		        		if(!tower.product_name){
 		        			tower.product_name="";
 		        		}
 		        		var goods_id = tower.goods_id
 	 		        	 html += "<tr  goods_id='"+goods_id+"'>"+
 	 		              "<td><input type='radio' product_name='"+tower.product_name+"'  name='towerModelRadio'  value='"+tower.towerId+"'   /></td>"+
 	 		              "<td><div align='center'>"+(i+1)+"</div></td>"+
 	 		              "<td ><div align='center'>"+tower.tower_model+"</div></td>"+
 	 		              "<td ><div align='center'>"+tower.tower_no+"</div></td>"+
 	 		              "<td ><div align='center'>"+tower.create_no+"</div></td>"+
 	 		             "<td><div align='center'>"+tower.product_name+"</div></td>"+
 	 		            "</tr>";
 		        	}
 		        	
				$("#dynamicTbody").empty();
				$("#dynamicTbody").append(html);
 		        },
 		        error : function() {
 		        	tatongMethod.alert("提示","塔机需求获取失败!");
 		        }
 		    }); 
 			
 		})
 		
	});
	</SCRIPT>
</head>
<body>
<div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <ul class="content-box-tabs">
       <c:if test="${dispatchType=='1' }">
        <li><a href="#tab1"  class="default-tab" id="atab1">
          <h4>调度项目</h4>
          </a></li>
          </c:if>
        <c:if test="${dispatchType=='2' }">
        <!-- href must be unique and match the id of target div -->
        <li> <a href="#tab2"  id="atab2" class="default-tab">
          <h4>其他</h4>
          </a></li>
          </c:if>
      </ul>
      <div class="clear"></div>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
    <c:if test="${dispatchType=='1' }">
    <form action="<%=basePath %>transfer/destination" id="form1" method="post">
      <div class="tab-content default-tab" id="tab1">
      <input type="hidden" id="dispatchType" name="dispatchType" value="1">
      <input type="hidden" id="tab1PageNum" name="tab1PageNum" value="0">
  	   <input type="hidden" id="tab1PerPage" name="tab1PerPage" value="5">
        <table class="edit-table">
          <tr>
            <th scope="row">合同编号: </th>
            <td><input name="contract_no" value="${contract_no }" type="text" /></td>
            <th scope="row">项目名称:</th>
            <td><input name="pro_name" value="${pro_name }"  type="text" /></td>
          </tr>
          <tr>
            <th scope="row">客户名称:</th>
            <td><input name="customer_cn_name" value="${customer_cn_name }"  type="text" />
              <a class="button1 button_position"  href="javascript:void(0)" onclick="document.getElementById('form1').submit();return false" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a></td>
            <td colspan="2"></td>
          </tr>
        </table>
        <br/>
        <table  height="160">
          <thead>
            <tr>
              <th scope="col" class="chebox"></th>
              <th scope="col" class="chebox">项次</th>
              <th  scope="col">合同编号</th>
              <th  scope="col">项目名称</th>
              <th  scope="col">客户名称</th>
              <th  scope="col">区域</th>
            </tr>
          </thead>
          <tbody style="height:160px;">
          <c:forEach varStatus="status" items="${contractProList }" var="contract">
             <tr>
              <td><input type="radio" name="contractRadio"    value="${contract.id }" />
              </td>
              <td><div align="center">
              <script type="text/javascript">
	          	var num =	${status.index+1}+tab1PageNum* tab1PerPage;
	          	document.write(num);
              </script>
              </div></td>
              <td><div align="center">${contract.contract_no }</div></td>
              <td>${contract.pro_name }</td>
              <td >${contract.customer_cn_name }</td>
              <td ><div align="center">${contract.area_name }</div></td>
            </tr>
          </c:forEach>
<!--             <tr>
              <td><input type="radio" name="radio" id="radio2" value="radio" /></td>
              <td><div align="center">2</div></td>
              <td ><div align="center">THZM101025043</div></td>
              <td >广东台山发电厂二期（首两台1000MW级机组)扩建工程施工现场</td>
              <td >广东火电工程总公司台山工程项目部</td>
              <td ><div align="center">华南区</div></td>
            </tr> -->
          </tbody>
          <tfoot>
            <tr>
              <td colspan="6"><div class="bulk-actions align-left">
                  <label>共有<b>${count}</b>条数据</label>
                </div>
                <div  id="pagination1" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
              </td>
            </tr>
          </tfoot>
        </table>
        <P><b>调度塔机</b></P>
        <table style="width:500px;">
          <thead>
            <tr>
              <th scope="col" class="chebox">&nbsp;</th>
              <th scope="col" class="chebox">项次</th>
              <th  scope="col">塔机型号</th>
              <th  scope="col">塔机编号</th>
              <th  scope="col">出厂编号</th>
              <th  scope="col">调度类型</th>
            </tr>
          </thead>
          <tbody id='dynamicTbody'>
          </tbody>
        </table>
      </div>
      </form>
      </c:if>
      <c:if test="${dispatchType=='2' }">
      <form action="<%=basePath %>transfer/destination" id="form2" method="post">
      <div class="tab-content default-tab" id="tab2">
      <input type="hidden" id="dispatchType" name="dispatchType" value="2">
       <input type="hidden" id="tab2PageNum" name="tab2PageNum" value="0">
  	   <input type="hidden" id="tab2PerPage" name="tab2PerPage" value="5">
        <table  class="edit-table">
          <tr>
            <th scope="row">地址: </th>
            <td><input name="store_name" type="text"  value="${store_name }"/>
              <a class="button1 button_position" href="javascript:void(0)" onclick="document.getElementById('form2').submit();return false" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a> </td>
          </tr>
        </table>
        <br/>
        <table height="160">
          <thead>
            <tr>
              <th scope="col" class="chebox"></th>
              <th scope="col" class="chebox"></th>
              <th  scope="col">地点</th>
              <th  scope="col">联系人</th>
              <th  scope="col">联系人手机</th>
              <th  scope="col">区域</th>
              <th  scope="col">省份</th>
              <th  scope="col">城市</th>
              <th  scope="col">地址</th>
              <th  scope="col">道路交通</th>
              <th  scope="col">管理公司</th>
            </tr>
          </thead>
          <tbody style="height:160px;">
          <c:forEach varStatus="status" items="${repositoryProList }" var="repository">
             <tr>
              <td><input type="radio" name="repositoryRadio"  value="${repository.id }" />
              </td>
              <td><div align="center">
              	<script type="text/javascript">
	          	var num =	${status.index+1};
	          	document.write(num);
	           </script>
              </div></td>
			  <td>${repository.store_name }</td>
              <td><div align="center">${repository.rep_contact }</div></td>
              <td><div align="center">${repository.rep_con_phone }</div></td>
              <td ><div align="center">${repository.area }</div></td>
              <td ><div align="center">${repository.province }</div></td>
              <td ><div align="center">${repository.city }</div></td>
              <td>${repository.rep_address }</td>
              <td>${repository.rep_rermark2 }</td>
              <td><div align="center">${repository.company_short_name }</div></td>
            </tr>
          </c:forEach>
          
<!--             <tr>
              <td><input type="radio" name="radio" id="radio" value="radio" />
              </td>
              <td><div align="center">2</div></td>
              <td>北京永茂厂仓库</td>
              <td><div align="center">王迪</div></td>
              <td><div align="center">13699288256</div></td>
              <td ><div align="center">华北区</div></td>
              <td ><div align="center">山西省</div></td>
              <td ><div align="center">晋中市</div></td>
              <td>北京市顺义区林河工业开发区双河大街12#</td>
              <td>最大满足17.5米板车进出</td>
              <td><div align="center">北京达丰</div></td>
            </tr> -->
            
            
          </tbody>
          <tfoot>
            <tr>
              <td colspan="11"><div class="bulk-actions align-left">
                  <label>共有<b>${count}</b>条数据</label>
                </div>
                <div  id="pagination2" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
              </td>
            </tr>
          </tfoot>
        </table>
      </div>
      </form>
      </c:if>
    </div>
    <table border="0" class="edit-table">
        <tr>
          <td>&nbsp;</td>
          <td colspan="2"><a class="button_new" onclick="window.close()"title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a><a class="button_new" href="javascript:void(0)" id="submitButton" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a> </td>
        </tr>
      </table>
  </div>
</div>
</div>
</div>
</body>
</html>