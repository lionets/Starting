<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
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
    <script type="text/javascript" src='<%=basePath %>static/js/UTIL.js'></script>
    <script type="text/javascript" src="<%=basePath %>static/js/paging/jquery.pagination.js"></script>
    <script type="text/javascript">

        //分页点击执行的操作
        function changePage(index,jq){
            if(jq.attr("id")=="custPagination"){
                $("#custpageNumber").val(index);
                document.getElementById("customerForm").submit();
            }
            if(jq.attr("id")=="towerPagination"){
                $("#towerpageNumber").val(index);
                document.getElementById("towerForm").submit();
            }
            if(jq.attr("id")=="partPagination"){
                $("#partpageNumber").val(index);
                document.getElementById("partForm").submit();
            }
            if(jq.attr("id")=="repPagination"){
                $("#reppageNumber").val(index);
                document.getElementById("repForm").submit();
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

            //初始化分页
            if('1' == '${flag}'){
                initPagination("custPagination","${custTotal}",10,"${pageNumber}");
            }else if('2' == '${flag}'){
                initPagination("towerPagination","${towerTotal }",10,"${pageNumber}");
            }else if('3' == '${flag}'){
                initPagination("partPagination","${partTotal}",10,"${pageNumber}");
            }else{
                initPagination("repPagination","${repTotal}",10,"${pageNumber}");
            }

            $('#custDispatchId').combobox({
                url:'<%=basePath %>company/manageCompanyCombox',
                valueField:'id',
                textField:'companyShortName',
                onLoadSuccess:function(){
                    if(!isEmpty('${dispatchId}')){
                        $('#custDispatchId').combobox('setValue','${dispatchId}');
                    }
                }
            });

            $('#towerManageCompany').combobox({
                url:'<%=basePath %>company/manageCompanyCombox',
                valueField:'id',
                textField:'companyShortName',
                onLoadSuccess:function(){
                    if(!isEmpty('${manageCompany}')){
                        $('#towerManageCompany').combobox('setValue','${manageCompany}');
                    }
                }
            });
            $('#partManageCompany').combobox({
                url:'<%=basePath %>company/manageCompanyCombox',
                valueField:'id',
                textField:'companyShortName',
                onLoadSuccess:function(){
                    if(!isEmpty('${manageCompany}')){
                        $('#partManageCompany').combobox('setValue','${manageCompany}');
                    }
                }
            });
            $('#manageDepartment').combobox({
                url:'<%=basePath %>department/ajax',
                valueField:'id',
                textField:'departmentName',
                onLoadSuccess:function(){
                    if(!isEmpty('${manageDepartment}')){
                        $('#manageDepartment').combobox('setValue','${manageDepartment}');
                    }
                }
            });

            $('#repDispatchId').combobox({
                url:'<%=basePath %>company/manageCompanyCombox',
                valueField:'id',
                textField:'companyShortName',
                onLoadSuccess:function(){
                    if(!isEmpty('${manageCompanyId}')){
                        $('#repDispatchId').combobox('setValue','${manageCompanyId}');
                    }
                }
            });
            $("#towerModel").combobox({
                url:"<%=basePath %>dictionary/selectByDictCode?dict_code=TJXH",
                valueField: 'dict_value',
                textField: 'dict_value',
                onLoadSuccess:function(){
                    if(!isEmpty('${towerModel}')){
                        $('#towerModel').combobox('setValue','${towerModel}');
                    }
                }
            });

            $("#partStatus").combobox({
                url:"<%=basePath %>dictionary/selectByDictCode?dict_code=TJZT",
                valueField: 'dict_name',
                textField: 'dict_value',
                onLoadSuccess:function(){
                    if(!isEmpty('${partStatus}')){
                        $('#partStatus').combobox('setValue','${partStatus}');
                    }
                }
            });
            
            $("#partOfTower").combobox({
                onLoadSuccess:function(){
                    if(!isEmpty('${partOfTower}')){
                        $('#partOfTower').combobox('setValue','${partOfTower}');
                    }
                }
            });
            
            $("#customerButton").on("click",function(){
                $("#customerForm").submit();
            });
            $("#towerButton").on("click",function(){
                $("#towerForm").submit();
            });
            $("#partButton").on("click",function(){
                $("#partForm").submit();
            });
            $("#repButton").on("click",function(){
                $("#repForm").submit();
            });
        });
        function aHrefClick(flag){
            var url = '<%=basePath %>';
            if(flag == 1){
                url = url + 'customer/init/1';
            }else if(flag == 2){
                url = url + 'tower/init/2';
            }else if(flag == 3){
                url = url + 'parts/init/3';
            }else if(flag ==4){
                url = url + 'warehouse/init/4';
            }
            window.location.href = url;
        }
        function delRepInfo(id){
            $.messager.confirm('仓库删除', '您确定删除当前选中的仓库记录？', function (yes) {
                if(yes == true){
                    window.location.href = '<%=basePath %>warehouse/del?warehouseId='+id;
                }
            });
        }
        function delCustomerInfo(id){
            $.messager.confirm('客户删除', '您确定删除当前选中的客户记录？', function (yes) {
                if(yes == true){
                    window.location.href = '<%=basePath %>customer/del?customerId='+id;
                }
            });
        }
        
        function showdelete(id){
        	$.messager.confirm('零件删除', '您确定删除当前选中的零部件记录？', function (yes) {
                if(yes == true){
                    window.location.href = '<%=basePath %>parts/del?partsId='+id;
                }
            });
        }

    </script>

</head>
<body>
<jsp:include page="../header-bar.jsp"/>
<div id="main-content">
    <div class="clear"></div>
    <!-- End .clear -->
    <div class="content-box">
        <!-- Start Content Box -->
        <div class="content-box-header">

            <ul class="content-box-tabs">
                <shiro:hasPermission name="leap:customerData">
                    <li><a href="#tab1" onclick="aHrefClick(1);" <c:if test="${flag == '1'}">class="default-tab"</c:if>> <h4>客户</h4></a></li>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:towerData">
                    <li><a href="#tab2" onclick="aHrefClick(2);" <c:if test="${flag == '2'}">class="default-tab"</c:if>> <h4>塔机</h4></a></li>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:partData">
                    <li><a href="#tab3" onclick="aHrefClick(3);" <c:if test="${flag == '3'}">class="default-tab"</c:if>> <h4>零部件</h4></a></li>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:repertoryData">
                    <li> <a href="#tab4" onclick="aHrefClick(4);" <c:if test="${flag == '4'}">class="default-tab"</c:if>> <h4>仓库</h4></a></li>
                </shiro:hasPermission>
            </ul>
            <div class="clear"></div>
        </div>
        <!-- End .content-box-header -->
        <div class="content-box-content">
            <shiro:hasPermission name="leap:customerData">
                <div <c:choose>
                    <c:when test="${flag == '1'}">class="tab-content default-tab"</c:when>
                    <c:otherwise>class="tab-content"</c:otherwise>
                </c:choose> id="tab1">
                    <form id="customerForm" action="<%=basePath %>customer/init/1" method="post">
                        <div class="search-actions">
                            <div class="search-condition">
                                <div class="search-condition-show">
                                    <table class="seach-table">
                                        <tr>
                                            <td ><label>管理公司:</label></td>
                                            <td>
                                                <select id="custDispatchId" name="dispatchId"></select>
                                                <input id="custflag" type="hidden" name="flag" value="${flag}"/>
                                                <input id="custpageNumber" type="hidden" name="pageNumber" value="${pageNumber}"/>
                                                <input id="custorderByType" type="hidden" name="orderByType" value="${orderByType}"/>
                                                <input id="custorderByName" type="hidden" name="orderByName" value="${orderByName}"/>
                                            </td>
                                            <td><label>客户名称:</label></td>
                                            <td><input class="text-input" type="text" name="customerCnName" value="${customerCnName}" /></td>
                                        </tr>
                                        <tr>
                                            <td class="px4z"><label>客户编号:</label></td>
                                            <td><input class="text-input" type="text" name="customerCode" value="${customerCode }"/></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="search-button">
                                <shiro:hasPermission name="leap:customerData:query">
                                    <a id="customerButton" class="button button_position" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="leap:customerData:add">
                                    <a class="button button_position" href="<%=basePath %>customer/addInit" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="leap:customerData:export">
                                    <a class="button button_position" href="<%=basePath %>customer/down" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a>
                                </shiro:hasPermission>
                            </div>

                            <div class="clear"></div>
                        </div>
                    </form>
                    <table>
                        <thead>
                        <tr>
                            <th scope="col" class="chebox">项次</th>
                            <th  scope="col">客户名称</th>
                            <th  scope="col">客户编号</th>
                            <th  scope="col">联系人</th>
                            <th  scope="col">管理公司</th>
                            <th  scope="col" class="picture2">编辑</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${custList }" var="cust" varStatus="num">
                            <tr>
                                <td class="tbllb">
                                    <c:choose>
                                        <c:when test="${9 > num.index}">
                                            <c:if test="${(pageNumber+1) > 1}">${pageNumber}</c:if>${num.index+1 }
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber type="number" value="${pageNumber + ((((num.index+1)-(num.index+1)%10)/10))}"/>${(num.index+1)%10}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${cust.customerCnName }</td>
                                <td>${cust.customerCode }</td>
                                <td>${cust.cpCnName }</td>
                                <td>${cust.dispatchName }</td>
                                <td class="operation"><!-- Icons -->
                                    <shiro:hasPermission name="leap:customerData:edit">
                                        <a href="<%=basePath %>customer/editFind?customerId=${cust.id}" title="Edit" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" alt="Edit" /></a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="leap:customerData:delete">
                                        <a onclick="delCustomerInfo(${cust.id})" title="Delete"><img src="<%=basePath %>static/images/icons/cross.png" alt="Delete" /></a>
                                    </shiro:hasPermission>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="6"><div class="bulk-actions align-left">
                                <label>共有<b>${custTotal}</b>条数据</label>
                            </div>
                                <div id="custPagination" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                            </td>
                        </tr>
                        </tfoot>
                        <!-- End .pagination -->
                    </table>
                </div>
            </shiro:hasPermission>
            <shiro:hasPermission name="leap:towerData">
                <div <c:choose>
                    <c:when test="${flag == '2'}">class="tab-content default-tab"</c:when>
                    <c:otherwise>class="tab-content"</c:otherwise>
                </c:choose> id="tab2">
                    <form id="towerForm" action="<%=basePath %>tower/init/2" method="post">
                        <div class="search-actions">
                            <div class="search-condition">
                                <table class="seach-table">
                                    <tr>
                                        <td><label>塔机编号:</label></td>
                                        <td ><input name="towerNo" type="text" value="${towerNo }"></td>
                                        <td ><label>塔机型号:</label></td>
                                        <td >
                                            <select id="towerModel" name="towerModel" ></select>
                                        </td>
                                    </tr>
                                </table>

                                <table class="seach-table">
                                    <tr>
                                        <td><label>出厂编号:</label></td>
                                        <td ><input name="towerFactoryno" type="text" value="${towerFactoryno }"></td>
                                        <td ><label>管理公司:</label></td>
                                        <td >
                                            <select id="towerManageCompany" name="manageCompany"></select>
                                            <input id="towerflag" type="hidden" name="flag" value="${flag}"/>
                                            <input id="towerpageNumber" type="hidden" name="pageNumber" value="${pageNumber}"/>
                                            <input id="towerorderByType" type="hidden" name="orderByType" value="${orderByType}"/>
                                            <input id="towerorderByName" type="hidden" name="orderByName" value="${orderByName}"/>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="search-button">
                                <shiro:hasPermission name="leap:towerData:query">
                                    <a class="button button_position" id="towerButton" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="leap:towerData:export">
                                    <a class="button button_position" href="<%=basePath %>tower/down" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a>
                                </shiro:hasPermission>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </form>
                    <table>
                        <thead>
                        <tr>
                            <th scope="col" class="chebox"><div align="center">项次</div></th>
                            <th  scope="col"><div align="center">塔机编号</div></th>
                            <th  scope="col"><div align="center">塔机型号</div></th>
                            <th  scope="col"><div align="center">出厂编号</div></th>
                            <th  scope="col"><div align="center">执行状况</div></th>
                            <th  scope="col"><div align="center">产权公司</div></th>
                            <th  scope="col" ><div align="center">管理公司</div></th>
                            <th  scope="col" ><div align="center">管理单位</div></th>
                            <th  scope="col" class="picture2"><div align="center">功能</div></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${towerList }" var="tower" varStatus="num">
                            <tr>
                                <td class="tbllb">
                                    <c:choose>
                                        <c:when test="${9 > num.index}">
                                            <c:if test="${(pageNumber+1) > 1}">${pageNumber}</c:if>${num.index+1 }
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber type="number" value="${pageNumber + ((((num.index+1)-(num.index+1)%10)/10))}"/>${(num.index+1)%10}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td ><div align="center">${tower.towerManageNo }</div></td>
                                <td><div align="center">${tower.towerModel }</div></td>
                                <td> <div align="center">${tower.towerFactoryno }</div></td>
                                <td ><div align="center">
                                    <c:choose>
                                        <c:when test="${tower.towerManageState == 1 }">闲置</c:when>
                                        <c:when test="${tower.towerManageState == 2 }">未启用</c:when>
                                        <c:when test="${tower.towerManageState == 3 }">在使用</c:when>
                                        <c:when test="${tower.towerManageState == 4 }">冬停</c:when>
                                        <c:when test="${tower.towerManageState == 5 }">托管</c:when>
                                    </c:choose>
                                </div></td>
                                <td><div align="center">${tower.towerRightcompanyName }</div></td>
                                <td><div align="center">${tower.manageCompanyName }</div></td>
                                <td><div align="center">${tower.departmentName }</div></td>
                                <td><div align="center">
                                    <shiro:hasPermission name="leap:towerData:detail">
                                        <a href="<%=basePath %>tower/find?towerId=${tower.id }" class="view"><img src="<%=basePath %>static/images/icons/view.png" title="查看"/></a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="leap:towerData:edit">
                                        <a href="<%=basePath %>tower/editFind?towerId=${tower.id }" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" title="编辑"/></a>
                                    </shiro:hasPermission>
                                </div></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="10"><div class="bulk-actions align-left">
                                <label>共有<b>${towerTotal}</b>条数据</label>
                            </div>
                                <div id="towerPagination" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                            </td>
                        </tr>
                        </tfoot>
                        <!--  End .pagination -->
                    </table>
                </div>
                <!-- End #tab2 -->
            </shiro:hasPermission>
            <shiro:hasPermission name="leap:partData">
                <div <c:choose>
                    <c:when test="${flag == '3'}">class="tab-content default-tab"</c:when>
                    <c:otherwise>class="tab-content"</c:otherwise>
                </c:choose> id="tab3">
                    <form action="<%=basePath %>parts/init/3" id="partForm" method="post">
                        <div class="search-actions">
                            <div class="search-condition">
                                <div class="search-condition-show">
                                    <table class="seach-table">
                                        <tr>
                                            <td ><label>零部件名称:</label></td>
                                            <td ><input type="text" name="partName" value="${partName }"/>
                                            </td>
                                            <td ><label>合同编号:</label></td>
                                            <td ><input name="contractNo" type="text" value="${contractNo }">
                                                <input id="partflag" type="hidden" name="flag" value="${flag}"/>
                                                <input id="partpageNumber" type="hidden" name="pageNumber" value="${pageNumber}"/>
                                                <input id="partorderByType" type="hidden" name="orderByType" value="${orderByType}"/>
                                                <input id="partorderByName" type="hidden" name="orderByName" value="${orderByName}"/>
                                            </td>
                                            <td ><label>执行状况:</label></td>
                                            <td >
                                                <select id="partStatus" name="partStatus"> </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td ><label>所属塔机:</label></td>
                                            <td >
                                                <select name="partOfTower" class="easyui-combobox">
                                                	<option></option>
									              	<c:forEach var="towerNo" items="${towerNoList}">
									              		<option value="${towerNo.tower_no }" <c:if test="${partOfTower == towerNo.tower_no }">selected="selected" </c:if>>${towerNo.tower_no }</option>
									              	</c:forEach>
									              </select>
                                            </td>
                                            <td><label>管理公司:</label></td>
                                            <td >
                                                <select id="partManageCompany" name="manageCompany"></select>
                                            </td>
                                            <td><label>管理单位:</label></td>
                                            <td >
                                                <select id="manageDepartment" name="manageDepartment"></select>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="search-button">
                                <shiro:hasPermission name="leap:partData:delete">
                                    <a class="button button_position" id="partButton" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                                </shiro:hasPermission>
                                    <%-- <a class="button button_position" href="<%=basePath %>parts/addInit" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a> --%>
                                <shiro:hasPermission name="leap:partData:export">
                                    <a class="button button_position" href="<%=basePath %>parts/down" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a>
                                </shiro:hasPermission>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </form>
                    <table>
                        <thead>
                        <tr>
                            <th scope="col" class="chebox" align="center"><div align="center">项次</div></th>
                            <th  scope="col" align="center"><div align="center">编号</div></th>
                            <th  scope="col">名称</th>
                            <th  scope="col">型号</th>
                            <th  scope="col" align="center"><div align="center">数量</div></th>
                            <th  scope="col" ><div align="center">执行状况</div></th>
                            <th  scope="col"><div align="center">所属塔机</div></th>
                            <th  scope="col"><div align="center">塔机型号</div></th>
                            <th  scope="col"><div align="center">合同编号</div></th>
                            <th  scope="col" ><div align="center">产权公司</div></th>
                            <th  scope="col" ><div align="center">管理公司</div></th>
                            <th  scope="col" ><div align="center">管理单位</div></th>
                            <th  scope="col" class="picture2"><div align="center">编辑</div></th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${partList }" var="part" varStatus="num">
                            <tr>
                                <td class="tbllb">
                                    <c:choose>
                                        <c:when test="${9 > num.index}">
                                            <c:if test="${(pageNumber+1) > 1}">${pageNumber}</c:if>${num.index+1 }
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber type="number" value="${pageNumber + ((((num.index+1)-(num.index+1)%10)/10))}"/>${(num.index+1)%10}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td><div align="center">
                                        ${part.partMapNo }
                                </div></td>
                                <td>${part.partName }</td>
                                <td>${part.partMode }</td>
                                <td><div align="center">${part.receivingAmount }${part.partUnit }</div></td>
                                <td><div align="center">
                                    <c:choose>
                                        <c:when test="${part.partStatus == 1 }">闲置</c:when>
                                        <c:when test="${part.partStatus == 2 }">未启用</c:when>
                                        <c:when test="${part.partStatus == 3 }">在使用</c:when>
                                        <c:when test="${part.partStatus == 4 }">冬停</c:when>
                                        <c:when test="${part.partStatus == 5 }">托管</c:when>
                                    </c:choose>
                                </div></td>
                                <td><div align="center">${part.partOfTower }</div></td>
                                <td><div align="center">${part.towerModel }</div></td>
                                <td><div align="center">${part.contractNo }</div></td>

                                <td><div align="center">${part.partOfCompanyName }</div></td>
                                <td><div align="center">${part.manageCompanyName }</div></td>
                                <td><div align="center">${part.departmentName }</div></td>
                                <td>
                                    <div align="center">
                                        <shiro:hasPermission name="leap:partData:edit">
                                            <a href="<%=basePath %>parts/editFind?partsId=${part.id }" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" title="编辑"/></a>
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="leap:partData:delete">
                                            <a href="#" onClick="showdelete(${part.id })" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" title="删除"/></a>
                                        </shiro:hasPermission>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="14"><div class="bulk-actions align-left">
                                <label>共有<b>${partTotal}</b>条数据</label>
                            </div>
                                <div id="partPagination" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                            </td>
                        </tr>
                        </tfoot>
                        <!-- End .pagination -->
                    </table>
                </div>
            </shiro:hasPermission>.
            <shiro:hasPermission name="leap:repertoryData">
                <div <c:choose>
                    <c:when test="${flag == '4'}">class="tab-content default-tab"</c:when>
                    <c:otherwise>class="tab-content"</c:otherwise>
                </c:choose> id="tab4">
                    <form id="repForm" action="<%=basePath %>warehouse/init/4" method="post">
                        <div class="search-actions">
                            <div class="search-condition">
                                <div class="search-condition-show">
                                    <table class="seach-table">
                                        <tr>
                                            <td><label>管理公司:</label></td>
                                            <td>
                                                <select id="repDispatchId" name="manageCompanyId"></select>
                                            </td>
                                            <td><label>仓库名称:</label></td>
                                            <td><input class="text-input" type="text" name="storeName" value="${storeName }"/></td>
                                        </tr>
                                        <tr>
                                            <td ><label>联系人:</label></td>
                                            <td><input class="text-input" type="text" name="repContact" value="${repContact }"/></td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="search-button">
                                <shiro:hasPermission name="leap:repertoryData:query">
                                    <a class="button button_position" id="repButton" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="leap:repertoryData:add">
                                    <a class="button button_position" href="<%=basePath %>warehouse/addInit" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="leap:repertoryData:export">
                                    <a class="button button_position" href="<%=basePath %>warehouse/down" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a>
                                </shiro:hasPermission>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </form>
                    <table>
                        <thead>
                        <tr>
                            <th scope="col" class="chebox">项次</th>
                            <th  scope="col">名称</th>
                            <th  scope="col">联系人</th>
                            <th  scope="col">联系人手机</th>
                            <th  scope="col">仓库大小(㎡)</th>
                            <th  scope="col">区域</th>
                            <th  scope="col">省份</th>
                            <th  scope="col">管理公司</th>
                            <th  scope="col" class="picture4">编辑</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${repList }" var="rep" varStatus="num">
                            <tr>
                                <td class="tbllb">
                                    <c:choose>
                                        <c:when test="${9 > num.index}">
                                            <c:if test="${(pageNumber+1) > 1}">${pageNumber}</c:if>${num.index+1 }
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber type="number" value="${pageNumber + ((((num.index+1)-(num.index+1)%10)/10))}"/>${(num.index+1)%10}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${rep.storeName }</td>
                                <td>${rep.repContact }</td>
                                <td>${rep.repConPhone }</td>
                                <td>${rep.repRermark1 }</td>
                                <td>${rep.repArea }</td>
                                <td>${rep.repProvince }</td>
                                <td>${rep.dispatchName }</td>
                                <td>
                                    <shiro:hasPermission name="leap:repertoryData:edit">
                                        <a href="<%=basePath %>warehouse/editFind?warehouseId=${rep.id}" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" title="编辑"/></a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="leap:repertoryData:delete">
                                        <a href="#" onClick="delRepInfo(${rep.id})" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" title="删除"/></a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="leap:repertoryData:manLocate">
                                        <%-- <a href="#" class="edit"><img src="<%=basePath %>static/images/icons/earth-icon.png" title="人工定位"/></a> --%>
                                    </shiro:hasPermission>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="9"><div class="bulk-actions align-left">
                                <label>共有<b>${repTotal}</b>条数据</label>
                            </div>
                                <div id="repPagination" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                            </td>
                        </tr>
                        </tfoot>
                        <!-- End .pagination -->
                    </table>
                </div>
            </shiro:hasPermission>.
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