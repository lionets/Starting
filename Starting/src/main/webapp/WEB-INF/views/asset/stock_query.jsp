<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
<link rel="stylesheet" href="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/default/easyui.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/icon.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/js/paging/pagination.css" />
<!-- Reset Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
<!-- Main Stylesheet -->

<link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen" />
<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
<link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/css/select.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery.datePicker.js"></script>
<script src="<%=basePath %>static/js/jQselect.js" type="text/javascript"></script>
<script src="<%=basePath %>static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src='<%=basePath %>static/js/UTIL.js'></script>
<script type="text/javascript" src="<%=basePath %>static/js/paging/jquery.pagination.js"></script>

<script type="text/javascript">
	//分页点击执行的操作
	function changePage(index,jq){
		if(jq.attr("id")=="puPagination"){
			$("#pupageNumber").val(index);
			document.getElementById("purchaseFrom").submit();
		 }
		 if(jq.attr("id")=="rePagination"){
			 $("#repageNumber").val(index);
				document.getElementById("rentalForm").submit();
		 }
		 if(jq.attr("id")=="arPagination"){
			 $("#arpageNumber").val(index);
				document.getElementById("arrivalForm").submit();
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
	$(document).ready(function() {
		
		if(!isEmpty('${requestScope.message}')){
		    $.messager.alert('提示','${requestScope.message}','info');
		}
		
		var dispatchId = "#PudispatchId";
		//初始化分页
		if('1' == '${flag}'){
			initPagination("puPagination","${purchaseTatol}",10,"${pageNumber}");
		}else if('2' == '${flag}'){
			dispatchId = "#RedispatchId";
			initPagination("rePagination","${rentalTatol}",10,"${pageNumber}");
		}else{
			dispatchId = "#ofCompany";
			initPagination("arPagination","${arrivalTatol}",10,"${pageNumber}");
		}
		$(dispatchId).combobox({
			url:'<%=basePath %>company/manageCompanyCombox',
			valueField:'id',
			textField:'companyShortName',
			onLoadSuccess:function(){
				if(!isEmpty('${dispatchId}')){
					$(dispatchId).combobox('setValue','${dispatchId}');
				}
			}
		});
		
		$("#Puspecification").combobox({
			url:"<%=basePath %>dictionary/selectByDictCode?dict_code=TJXH",
			valueField: 'dict_value',
			textField: 'dict_value',
			onLoadSuccess:function(){
				if(!isEmpty('${specification}')){
					$('#Puspecification').combobox('setValue','${specification}');
				}
			}
		});
		$("#Respecification").combobox({
			url:"<%=basePath %>dictionary/selectByDictCode?dict_code=TJXH",
			valueField: 'dict_value',
			textField: 'dict_value',
			onLoadSuccess:function(){
				if(!isEmpty('${specification}')){
					$('#Respecification').combobox('setValue','${specification}');
				}
			}
		});
	});

	function aHrefClick(flag){
		window.location.href = '<%=basePath %>purchase/init/'+flag;
	}
	function rentalFormSubmit(){
		$('#rentalForm').submit();
	}
	function purchaseFromSubmit(){
		$('#purchaseFrom').submit();
	}
	function arrivalFromSubmit(){
		$('#arrivalForm').submit();
	}
	
	function findContractInfo(purchaseId){
		var resultValue =  window.showModalDialog('<%=basePath %>purchase/find?purchaseId='+purchaseId,'',"dialogWidth=1200px;dialogHeight=550px");
	}
	
	function findArrivalInfo(no){
		var resultValue =  window.showModalDialog('<%=basePath %>purchase/arrivalFind?contractNo='+no,'',"dialogWidth=1200px;dialogHeight=550px");
	}
	</script>
</head>
<body bgcolor="">
<jsp:include page="../header-bar.jsp"/>
<div id="main-content">
  <div class="clear"></div>
  <!-- End .clear -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
     <ul class="content-box-tabs">
       <shiro:hasPermission name="leap:procurementContract">
         <li><a href="#tab1" onclick="aHrefClick(1);" <c:if test="${flag == '1'}">class="default-tab"</c:if>> <h4>采购合同</h4></a></li>
       </shiro:hasPermission>
       <shiro:hasPermission name="leap:leaseContract">
         <li> <a href="#tab2" onclick="aHrefClick(2);" <c:if test="${flag == '2'}">class="default-tab"</c:if>> <h4>外租合同</h4></a></li>
       </shiro:hasPermission>
       <shiro:hasPermission name="leap:assetArrival">
         <li> <a href="#tab3" onclick="aHrefClick(3);" <c:if test="${flag == '3'}">class="default-tab"</c:if>> <h4>资产到货</h4></a></li>
       </shiro:hasPermission>
        <!-- href must be unique and match the id of target div -->
      </ul>
      <div class="clear"></div>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <shiro:hasPermission name="leap:procurementContract">
        <div <c:choose>
          <c:when test="${flag == '1'}">class="tab-content default-tab"</c:when>
          <c:otherwise>class="tab-content"</c:otherwise>
        </c:choose> id="tab1">
          <form id="purchaseFrom" action="<%=basePath %>purchase/init/1" method="post">
            <div class="search-actions">
              <div class="search-condition">
                <div class="search-condition-show">
                  <table class="seach-table">
                    <tr>
                      <td><label>合同编号:</label></td>
                      <td ><input name="contractNo" value="${contractNo }" type="text" class="text-input" /></td>
                      <td ><label>资产名称:</label></td>
                      <td ><input name="productName" value="${productName }"/>
                        <input id="puflag" type="hidden" name="flag" value="${flag}"/>
                        <input id="pupageNumber" type="hidden" name="pageNumber" value="${pageNumber}"/>
                        <input id="puorderByType" type="hidden" name="orderByType" value="${orderByType}"/>
                        <input id="puorderByName" type="hidden" name="orderByName" value="${orderByName}"/>
                      </td>
                    </tr>
                  </table>
                </div>
                <div id="search-condition-hidden">
                  <table class="seach-table">
                    <tr>
                      <td ><label>签订日期:</label></td>
                      <td ><input name="signTime" type="text" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${signTime}"/></td>
                      <td ><label>所属公司:</label></td>
                      <td>
                        <select name="dispatchId" id="PudispatchId" class="easyui-combobox">
                          <option></option>
                        </select>
                      </td>
                    </tr>
                  </table>
                </div>
              </div>
              <div class="search-button">
                <shiro:hasPermission name="leap:procurementContract:query">
                  <a onclick="purchaseFromSubmit();" class="button button_position" href="#" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:procurementContract:add">
                  <a class="button button_position" href="<%=basePath %>purchase/addInit" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:procurementContract:export">
                  <a class="button button_position" href="#" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a> 
                </shiro:hasPermission>
                </div>
              <div class="clear"></div>
            </div>
          </form>
          <table>
            <thead>
            <tr>
              <th scope="col" class="chebox">项次</th>
              <th  scope="col">合同编号</th>
              <th  scope="col">签订日期</th>
              <th  scope="col">所属公司</th>
              <th  scope="col">资产名称</th>
              <th  scope="col">厂家</th>
              <th  scope="col">规格型号</th>
              <th  scope="col">塔机样式</th>
              <th  scope="col">到货地点</th>
              <th  scope="col" class="picture4">编辑</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${purchaseList }" var="pu" varStatus="num">
              <tr>
                <td rowspan="${fn:length(pu.conTowerList)}">
                  <c:choose>
                    <c:when test="${9 > num.index}">
                      <c:if test="${(pageNumber+1) > 1}">${pageNumber}</c:if>${num.index+1 }
                    </c:when>
                    <c:otherwise>
                      <fmt:formatNumber type="number" value="${pageNumber + ((((num.index+1)-(num.index+1)%10)/10))}"/>${(num.index+1)%10}
                    </c:otherwise>
                  </c:choose>
                </td>
                <td rowspan="${fn:length(pu.conTowerList)}"><div align="center"><a href="<%=basePath %>purchase/find?purchaseId=${pu.id}&flag=${flag}" >${pu.contractNo }</a></div></td>
                <td rowspan="${fn:length(pu.conTowerList)}"><div align="center"><fmt:formatDate pattern="yyyy-MM-dd" value="${pu.signTime}" type="both" /></div></td>
                <td rowspan="${fn:length(pu.conTowerList)}"><div align="center">${pu.dispatchName }</div></td>
                <c:choose>
                <c:when test="${fn:length(pu.conTowerList) > 0}">
	                <c:forEach items="${pu.conTowerList }" varStatus="status" var="tower">
		                <c:choose>
		                <c:when test="${status.index > 0 }">
			                <tr>
			                <td><div align="center">${tower.productName }</div></td>
			                <td><div align="center">${tower.createFactryName }</div></td>
			                <td><div align="center">${tower.specification }</div></td>
			                <td><div align="center">${tower.towerType }</div></td>
			                <td><div align="center">${tower.arrivalPlace }</div></td>
			                </tr>
		                </c:when>
		                <c:otherwise>
			                <td><div align="center">${tower.productName }</div></td>
			                <td><div align="center">${tower.createFactryName }</div></td>
			                <td><div align="center">${tower.specification }</div></td>
			                <td><div align="center">${tower.towerType }</div></td>
			                <td><div align="center">${tower.arrivalPlace }</div></td>
			                <td rowspan="${fn:length(pu.conTowerList)}">
			                  <c:choose>
			                    <c:when test="${pu.checkUserid != null }">
			                      <shiro:hasPermission name="leap:procurementContract:check">
			                        <a class="edit"><img src="<%=basePath %>static/images/icons/tests-icon.png" title="已审核，不能审核"/></a>
			                      </shiro:hasPermission>
			                      <shiro:hasPermission name="leap:procurementContract:edit">
			                        <a class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" alt="Edit" title="已审核，不能编辑"/></a>
			                      </shiro:hasPermission>
			                    </c:when>
			                    <c:otherwise>
			                      <shiro:hasPermission name="leap:procurementContract:check">
			                        <a href="<%=basePath %>purchase/checkInit/${flag}?contractId=${pu.id}" class="edit"><img src="<%=basePath %>static/images/icons/tests-icon.png" title="审核"/></a>
			                      </shiro:hasPermission>
			                      <shiro:hasPermission name="leap:procurementContract:edit">
			                        <a href="<%=basePath %>purchase/editFind?purchaseId=${pu.id}&flag=${flag}" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" alt="Edit" title="编辑" /></a>
			                      </shiro:hasPermission>
			                    </c:otherwise>
			                  </c:choose>
			                  <shiro:hasPermission name="leap:procurementContract:download">
			                    <a href="#" class="edit"><img src="<%=basePath %>static/images/icons/download-icon.png" alt="download" title="下载"/></a>
			                  </shiro:hasPermission>
			                </td>
			              </tr>
		                </c:otherwise>
		                </c:choose>
	                </c:forEach>
                </c:when>
                <c:otherwise>
	                <td></td>
	                <td></td>
	                <td></td>
	                <td></td>
	                <td></td>
	                <td >
	                  <c:choose>
	                    <c:when test="${pu.checkUserid != null }">
	                      <shiro:hasPermission name="leap:procurementContract:check">
	                        <a class="edit"><img src="<%=basePath %>static/images/icons/tests-icon.png" title="已审核，不能审核"/></a>
	                      </shiro:hasPermission>
	                      <shiro:hasPermission name="leap:procurementContract:edit">
	                        <a class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" alt="Edit" title="已审核，不能编辑"/></a>
	                      </shiro:hasPermission>
	                    </c:when>
	                    <c:otherwise>
	                      <shiro:hasPermission name="leap:procurementContract:check">
	                        <a href="<%=basePath %>purchase/checkInit/${flag}?contractId=${pu.id}" class="edit"><img src="<%=basePath %>static/images/icons/tests-icon.png" title="审核"/></a>
	                      </shiro:hasPermission>
	                      <shiro:hasPermission name="leap:procurementContract:edit">
	                        <a href="<%=basePath %>purchase/editFind?purchaseId=${pu.id}&flag=${flag}" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" alt="Edit" title="编辑" /></a>
	                      </shiro:hasPermission>
	                    </c:otherwise>
	                  </c:choose>
	                  <shiro:hasPermission name="leap:procurementContract:download">
	                    <a href="#" class="edit"><img src="<%=basePath %>static/images/icons/download-icon.png" alt="download" title="下载"/></a>
	                  </shiro:hasPermission>
	                </td>
	                </tr>
                </c:otherwise>
                </c:choose>
            </c:forEach>
            </tbody>
            <tfoot>
            <tr>
              <td colspan="13"><div class="bulk-actions align-left">
                <label>共有<b>${purchaseTatol}</b>条数据</label>
              </div>
                <div id="puPagination" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                <!-- End .pagination -->
              </td>
            </tr>
            </tfoot>
          </table>

        </div>
        <!-- End #tab1 -->
      </shiro:hasPermission>
      <shiro:hasPermission name="leap:leaseContract">
        <div <c:choose>
          <c:when test="${flag == '2'}">class="tab-content default-tab"</c:when>
          <c:otherwise>class="tab-content"</c:otherwise>
        </c:choose> id="tab2">
          <form id="rentalForm" action="<%=basePath %>purchase/init/2" method="post">
            <div class="search-actions">
              <div class="search-condition">
                <div class="search-condition-show">
                  <table class="seach-table">
                    <tr>
                      <td><label>合同编号:</label></td>
                      <td ><input name="contractNo" value="${contractNo }" type="text" class="text-input" /></td>
                      <td ><label>资产名称:</label></td>
                      <td ><input name="productName" value="${productName }"/>
                        <input id="reflag" type="hidden" name="flag" value="${flag}"/>
                        <input id="repageNumber" type="hidden" name="pageNumber" value="${pageNumber}"/>
                        <input id="reorderByType" type="hidden" name="orderByType" value="${orderByType}"/>
                        <input id="reorderByName" type="hidden" name="orderByName" value="${orderByName}"/>
                      </td>
                    </tr>
                  </table>
                </div>
                <div id="search-condition-hidden">
                  <table class="seach-table">
                    <tr>
                      <td ><label>签订日期:</label></td>
                      <td ><input name="signTime" type="text" readonly="readonly"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" class="text-input" value="${signTime}"/></td>
                      <td ><label>所属公司:</label></td>
                      <td>
                        <select name="dispatchId" id="RedispatchId" class="easyui-combobox">
                          <option></option>
                        </select>
                      </td>
                    </tr>
                  </table>
                </div>
              </div>
              <div class="search-button">
                <shiro:hasPermission name="leap:leaseContract:query">
                  <a onclick="rentalFormSubmit();" class="button button_position" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:leaseContract:add">
                  <a class="button button_position" href="<%=basePath %>purchase/addInitRental" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:leaseContract:export">
                  <a class="button button_position" href="#" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a>
                </shiro:hasPermission>
              </div>

              <div class="clear"></div>
            </div>
          </form>
          <table>
            <thead>
            <tr>
              <th scope="col" class="chebox">项次</th>
              <th  scope="col">合同编号</th>
              <th  scope="col">签订日期</th>
              <th  scope="col">所属公司</th>
              <th  scope="col">资产名称</th>
              <th  scope="col">厂家</th>
              <th  scope="col">规格型号</th>
              <th  scope="col">塔机样式</th>
              <th  scope="col">到货地点</th>
              <th  scope="col" class="picture4">编辑</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${rentalList }" var="re" varStatus="num">
              <tr>
                <td rowspan="${fn:length(re.conTowerList)}"><div align="center" rowspan="${fn:length(re.conTowerList)}">
                  <c:choose>
                    <c:when test="${9 > num.index}">
                      <c:if test="${(pageNumber+1) > 1}">${pageNumber}</c:if>${num.index+1 }
                    </c:when>
                    <c:otherwise>
                      <fmt:formatNumber type="number" value="${pageNumber + ((((num.index+1)-(num.index+1)%10)/10))}"/>${(num.index+1)%10}
                    </c:otherwise>
                  </c:choose>
                  </div>
                </td>
                <td rowspan="${fn:length(re.conTowerList)}"><div align="center"><a href="<%=basePath %>purchase/find?purchaseId=${re.id}&flag=${flag}"  class="edit">${re.contractNo }</a></div></td>
                <td rowspan="${fn:length(re.conTowerList)}"><div align="center"><fmt:formatDate pattern="yyyy-MM-dd" value="${re.signTime}" type="both" /></div></td>
                <td rowspan="${fn:length(re.conTowerList)}"><div align="center">${re.dispatchName }</div></td>
                <c:choose>
                <c:when test="${fn:length(re.conTowerList) > 0}">
	                <c:forEach items="${re.conTowerList }" varStatus="status" var="tower">
		                <c:choose>
		                <c:when test="${status.index > 0}">
			                <tr>
			                <td><div align="center">${tower.productName }</div></td>
			                <td><div align="center">${tower.createFactryName }</div></td>
			                <td><div align="center">${tower.specification }</div></td>
			                <td><div align="center">${tower.towerType }</div></td>
			                <td><div align="center">${tower.arrivalPlace }</div></td>
			                </tr>
		                </c:when>
		                <c:otherwise>
			                <td><div align="center">${tower.productName }</div></td>
			                <td><div align="center">${tower.createFactryName }</div></td>
			                <td><div align="center">${tower.specification }</div></td>
			                <td><div align="center">${tower.towerType }</div></td>
			                <td><div align="center">${tower.arrivalPlace }</div></td>
			                <td rowspan="${fn:length(re.conTowerList)}">
			                  <c:choose>
			                    <c:when test="${re.checkUserid != null }">
			                      <shiro:hasPermission name="leap:leaseContract:check">
			                        <a class="edit"><img src="<%=basePath %>static/images/icons/tests-icon.png" title="已审核，不能审核"/></a>
			                      </shiro:hasPermission>
			                      <shiro:hasPermission name="leap:leaseContract:edit">
			                        <a class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" alt="Edit" title="已审核，不能编辑"/></a>
			                      </shiro:hasPermission>
			                    </c:when>
			                    <c:otherwise>
			                      <shiro:hasPermission name="leap:leaseContract:check">
			                        <a href="<%=basePath %>purchase/checkInit/${flag}?contractId=${re.id}" class="edit"><img src="<%=basePath %>static/images/icons/tests-icon.png" title="审核"/></a>
			                      </shiro:hasPermission>
			                      <shiro:hasPermission name="leap:leaseContract:edit">
			                        <a href="<%=basePath %>purchase/editRentalFind?rentalId=${re.id}&flag=${flag}" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" alt="Edit" title="编辑"/></a>
			                      </shiro:hasPermission>
			                    </c:otherwise>
			                  </c:choose>
			                  <a href="#" class="edit"><img src="<%=basePath %>static/images/icons/download-icon.png" alt="download" title="下载"/></a>
			                </td>
			                </tr>
		                </c:otherwise>
		                </c:choose>
	                </c:forEach>
                </c:when>
                <c:otherwise>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td>
                  <c:choose>
                    <c:when test="${re.checkUserid != null }">
                      <shiro:hasPermission name="leap:leaseContract:check">
                        <a class="edit"><img src="<%=basePath %>static/images/icons/tests-icon.png" title="已审核，不能审核"/></a>
                      </shiro:hasPermission>
                      <shiro:hasPermission name="leap:leaseContract:edit">
                        <a class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" alt="Edit" title="已审核，不能编辑"/></a>
                      </shiro:hasPermission>
                    </c:when>
                    <c:otherwise>
                      <shiro:hasPermission name="leap:leaseContract:check">
                        <a href="<%=basePath %>purchase/checkInit/${flag}?contractId=${re.id}" class="edit"><img src="<%=basePath %>static/images/icons/tests-icon.png" title="审核"/></a>
                      </shiro:hasPermission>
                      <shiro:hasPermission name="leap:leaseContract:edit">
                        <a href="<%=basePath %>purchase/editRentalFind?rentalId=${re.id}&flag=${flag}" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" alt="Edit" title="编辑"/></a>
                      </shiro:hasPermission>
                    </c:otherwise>
                  </c:choose>
                  <a href="#" class="edit"><img src="<%=basePath %>static/images/icons/download-icon.png" alt="download" title="下载"/></a>
                </td>
                </tr>
                </c:otherwise>
                </c:choose>
            </c:forEach>
            </tbody>
            <tfoot>
            <tr>
              <td colspan="13"> <div class="bulk-actions align-left">
                <label>共有<b>${rentalTatol}</b>条数据</label>
              </div>
                <div id="rePagination" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                <!-- End .pagination -->
              </td>
            </tr>
            </tfoot>
          </table>
        </div>
        <!-- End #tab2 -->
      </shiro:hasPermission>
      <shiro:hasPermission name="leap:assetArrival">
        <div <c:choose>
          <c:when test="${flag == '3'}">class="tab-content default-tab"</c:when>
          <c:otherwise>class="tab-content"</c:otherwise>
        </c:choose> id="tab3">
          <form id="arrivalForm" action="<%=basePath %>purchase/init/3" method="post">
            <div class="search-actions">
              <div class="search-condition">
                <div class="search-condition-show">
                  <table class="seach-table">
                    <tr>
                      <td><label>合同编号:</label></td>
                      <td ><input name="contractNo" type="text" value="${contractNo }"/></td>
                      <td ><label>合同类型:</label></td>
                      <td >
                        <select id="contractType" name="contractType" class="easyui-combobox">
                          <option></option>
                          <option value="1" <c:if test="${contractType == 1 }">selected="selected"</c:if>>采购合同</option>
                          <option value="2" <c:if test="${contractType == 2 }">selected="selected"</c:if>>外租合同</option>
                        </select>
                      </td>
                      <td><label>资产名称:</label></td>
                      <td>
                        <input type="text" name="productName" value="${productName }"/>
                      </td>
                    </tr>
                  </table>
                </div>
                <div id="search-condition-hidden">
                  <table class="seach-table">
                    <tr>
                      <td ><label>合同状态:</label></td>
                      <td >
                        <select id="contractStatus" name="contractStatus" class="easyui-combobox">
                          <option></option>
                          <option value="0" <c:if test="${contractStatus == '0' }">selected="selected"</c:if>>待确认</option>
                          <option value="1" <c:if test="${contractStatus == '1' }">selected="selected"</c:if>>确认中</option>
                          <option value="2" <c:if test="${contractStatus == '2' }">selected="selected"</c:if>>已确认</option>
                        </select>
                        <input id="arflag" type="hidden" name="flag" value="${flag}"/>
                        <input id="arpageNumber" type="hidden" name="pageNumber" value="${pageNumber}"/>
                        <input id="arorderByType" type="hidden" name="orderByType" value="${orderByType}"/>
                        <input id="arorderByName" type="hidden" name="orderByName" value="${orderByName}"/>
                      </td>
                      <td><label>签订日期:</label></td>
                      <td ><input name="signTime" type="text" readonly="readonly"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${signTime }"/></td>
                      <td ><label> 所属公司:</label>
                      </td>
                      <td>
                        <select id="ofCompany" name="dispatchId" class="easyui-combobox">
                          <option></option>
                        </select>
                      </td>
                    </tr>
                  </table>
                </div>
              </div>
              <div class="search-button">
                <shiro:hasPermission name="leap:assetArrival:query">
                  <a onclick="arrivalFromSubmit();" class="button button_position" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:assetArrival:export">
                  <a class="button button_position" href="#" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a>
                </shiro:hasPermission>
              </div>

              <div class="clear"></div>
            </div>
          </form>
          <table>
            <thead>
            <tr>
              <th scope="col" class="chebox">项次</th>
              <th  scope="col">合同编号</th>
              <th  scope="col">所属公司</th>
              <th  scope="col">签订日期</th>
              <th  scope="col">资产名称</th>
              <th  scope="col">塔机编号</th>
              <th  scope="col">出厂编号</th>
              <th  scope="col">厂家</th>
              <th  scope="col" >规格型号</th>
              <th  scope="col" class="date">到货地点</th>
              <th  scope="col" class="date">状态</th>
              <th  scope="col" class="picture4">编辑</th>
            </tr>
          </thead>
          <tbody>
          <c:forEach items="${arrivalList }" var="arrival" varStatus="num">
            <tr>
              <td rowspan="${fn:length(arrival.conTowerList)}">
              <c:choose>
              <c:when test="${9 > num.index}">
              <c:if test="${(pageNumber+1) > 1}">${pageNumber}</c:if>${num.index+1 }
              </c:when>
              <c:otherwise>
              <fmt:formatNumber type="number" value="${pageNumber + ((((num.index+1)-(num.index+1)%10)/10))}"/>${(num.index+1)%10}
              </c:otherwise>
              </c:choose>
              </td>
              <td rowspan="${fn:length(arrival.conTowerList)}"><div align="center"><a href="<%=basePath %>purchase/arrivalFind?contractId=${arrival.id}" class="edit">${arrival.contractNo }</a></div></td>
              <td rowspan="${fn:length(arrival.conTowerList)}"><div align="center">${arrival.dispatchName }</div></td>
              <td rowspan="${fn:length(arrival.conTowerList)}"><div align="center"><fmt:formatDate pattern="yyyy-MM-dd" value="${arrival.signTime}" type="both" /></div></td>
              <c:choose>
              <c:when test="${fn:length(arrival.conTowerList) > 0}">
              <c:forEach items="${arrival.conTowerList }" varStatus="status" var="tower">
              <c:choose>
              <c:when test="${status.index > 0}">
              <tr>
              <td><div align="center">${tower.productName }</div></td>
              <td><div align="center">${tower.towerNo }</div></td>
              <td><div align="center">${tower.outFactryNo }</div></td>
              <td><div align="center">${tower.createFactryName }</div></td>
              <td><div align="center">${tower.specification }</div></td>
              <td><div align="center">${tower.arrivalPlace }</div></td>
              <td><div align="center">
              <c:choose>
              <c:when test="${tower.arrivalState == 0 }">待确认</c:when>
              <c:when test="${tower.arrivalState == 1 }">确认中</c:when>
              <c:when test="${tower.arrivalState == 2 }">已确认</c:when>
              <c:otherwise>未知状态</c:otherwise>
              </c:choose>
              </div>
              </td>
              </tr>
              </c:when>
              <c:otherwise>
              <td><div align="center">${tower.productName }</div></td>
              <td><div align="center">${tower.towerNo }</div></td>
              <td><div align="center">${tower.outFactryNo }</div></td>
              <td><div align="center">${tower.createFactryName }</div></td>
              <td><div align="center">${tower.specification }</div></td>
              <td><div align="center">${tower.arrivalPlace }</div></td>
              <td><div align="center">
              <c:choose>
              <c:when test="${tower.arrivalState == 0 }">待确认</c:when>
              <c:when test="${tower.arrivalState == 1 }">确认中</c:when>
              <c:when test="${tower.arrivalState == 2 }">已确认</c:when>
              <c:otherwise>未知状态</c:otherwise>
              </c:choose>
              </div>
              </td>
              <td rowspan="${fn:length(arrival.conTowerList)}">
                  <shiro:hasPermission name="leap:assetArrival:check">
                        <a href="<%=basePath %>purchase/checkArrivalInit?contractId=${arrival.id}" class="edit"><img src="<%=basePath %>static/images/icons/tests-icon.png" title="审核"/></a>
                      </shiro:hasPermission>
                      <shiro:hasPermission name="leap:assetArrival:edit">
                        <a href="<%=basePath %>purchase/editFindArrival?contractId=${arrival.id}" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" alt="Edit" title="编辑"/></a>
                      </shiro:hasPermission>
                  <shiro:hasPermission name="leap:assetArrival:download">
                    <a href="#" class="edit"><img src="<%=basePath %>static/images/icons/download-icon.png" alt="download" title="下载"/></a>
                  </shiro:hasPermission>
              </td>
            </tr>
            </c:otherwise>
            </c:choose>
            </c:forEach>
              </c:when>
              <c:otherwise>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td></td>
              <td>
                  <shiro:hasPermission name="leap:assetArrival:check">
                        <a href="<%=basePath %>purchase/checkArrivalInit?contractId=${arrival.id}" class="edit"><img src="<%=basePath %>static/images/icons/tests-icon.png" title="审核"/></a>
                      </shiro:hasPermission>
                      <shiro:hasPermission name="leap:assetArrival:edit">
                        <a href="<%=basePath %>purchase/editFindArrival?contractId=${arrival.id}" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" alt="Edit" title="编辑"/></a>
                      </shiro:hasPermission>
                  <shiro:hasPermission name="leap:assetArrival:download">
                    <a href="#" class="edit"><img src="<%=basePath %>static/images/icons/download-icon.png" alt="download" title="下载"/></a>
                  </shiro:hasPermission>
              </td>
              </tr>
              </c:otherwise>
              </c:choose>
          </c:forEach>
          </tbody>
          <tfoot>
            <tr>
              <td colspan="12">
                <div class="bulk-actions align-left">
                  <label>共有<b>${arrivalTatol}</b>条数据</label>
                </div>
                <div id="arPagination" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                <!-- End .pagination -->
              </td>
            </tr>
            </tfoot>
          </table>
        </div>
        <!-- End #tab3 -->
      </shiro:hasPermission>
    </div>
    <!-- End .content-box-content -->
  </div>
  <!-- End .content-box -->
  <div class="clear"></div>
</div>
<!-- End #main-content -->
<div id="footer">
<small>達豐中國 地址：上海市长宁区天山西路1068号联强国际D栋4楼 电话:+86 21 60825373 </small><br /><br />
 <small>系统开发 Copyright © 2015 上海乔罗网络科技有限公司 </small> </div>
<!-- End #footer -->
</body>
</html>