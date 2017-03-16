<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
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
    <script type="text/javascript" src="<%=basePath %>static/js/jquery.datePicker.js"></script>
    <script src="<%=basePath %>static/js/jQselect.js" type="text/javascript"></script>
    <script type="text/javascript" src='<%=basePath %>static/js/UTIL.js'></script>
    <script src="<%=basePath %>static/js/jquery-easyui-1.4.1/jquery.easyui.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="<%=basePath %>static/js/paging/jquery.pagination.js"></script>

    <script type="text/javascript">

        //分页点击执行的操作
        function changePage(index,jq){
            if(jq.attr("id")=="proPagination"){
                $("#propageNumber").val(index);
                document.getElementById("proForm").submit();
            }
            if(jq.attr("id")=="intentPagination"){
                $("#leasepageNumber").val(index);
                document.getElementById("leaseForm").submit();
            }
            if(jq.attr("id")=="progressPagination"){
                $("#progresspageNumber").val(index);
                document.getElementById("progressForm").submit();
            }
            if(jq.attr("id")=="conPagination"){
                $("#conpageNumber").val(index);
                document.getElementById("conForm").submit();
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
                initPagination("proPagination","${proTatol}",10,"${pageNumber}");
            }else if('2' == '${flag}'){
                initPagination("conPagination","${conTatol}",10,"${pageNumber}");
            }else if('3' == '${flag}'){
                initPagination("progressPagination","${progressTatol}",10,"${pageNumber}");
            }else{
                initPagination("intentPagination","${intentTatol}",10,"${pageNumber}");
            }
            $('#proCompany').combobox({
                url:'<%=basePath %>company/manageCompanyCombox',
                valueField:'id',
                textField:'companyShortName',
                onLoadSuccess:function(){
                    if(!isEmpty('${proCompany}')){
                        $('#proCompany').combobox('setValue','${proCompany}');
                    }
                }
            });
            $('#conCompany').combobox({
                url:'<%=basePath %>company/manageCompanyCombox',
                valueField:'id',
                textField:'companyShortName',
                onLoadSuccess:function(){
                    $('#conCompany').combobox('setValue','${dispatchId}');
                }
            });
            $('#progressCompany').combobox({
                url:'<%=basePath %>company/manageCompanyCombox',
                valueField:'id',
                textField:'companyShortName',
                onLoadSuccess:function(){
                    $('#progressCompany').combobox('setValue','${dispatchId}');
                }
            });
            $('#ofCompany').combobox({
                url:'<%=basePath %>company/manageCompanyCombox',
                valueField:'id',
                textField:'companyShortName',
                onLoadSuccess:function(){
                    $('#ofCompany').combobox('setValue','${ofCompany}');
                }
            });
            $("#towerCase").combobox({
                url:"<%=basePath %>dictionary/selectByDictCode?dict_code=TJXH",
                valueField: 'dict_value',
                textField: 'dict_value',
                onLoadSuccess:function(){
                    if(!isEmpty('${towerCase}')){
                        $('#towerCase').combobox('setValue','${towerCase}');
                    }
                }
            });
            $("#proStatus").combobox({
                url:"<%=basePath %>dictionary/selectByDictCode?dict_code=XMZT",
                valueField: 'dict_name',
                textField: 'dict_value',
                onLoadSuccess:function(){
                    if(!isEmpty('${proStatus}')){
                        $('#proStatus').combobox('setValue','${proStatus}');
                    }
                }
            });

            $("#conStatus").combobox({
                url:"<%=basePath %>dictionary/selectByDictCode?dict_code=XMZT",
                valueField: 'dict_name',
                textField: 'dict_value',
                onLoadSuccess:function(){
                    if(!isEmpty('${contractStatus}')){
                        $('#conStatus').combobox('setValue','${contractStatus}');
                    }
                }
            });
            $("#progressStatus").combobox({
                url:"<%=basePath %>dictionary/selectByDictCode?dict_code=XMZT",
                valueField: 'dict_name',
                textField: 'dict_value',
                onLoadSuccess:function(){
                    if(!isEmpty('${contractStatus}')){
                        $('#progressStatus').combobox('setValue','${contractStatus}');
                    }
                }
            });

        });
        function openwin(){
            window.open('<%=basePath %>project/find','newwindow','height=700,width=1000,top=0,left=200,toolbar=0,menubar=0,scrollbar=yes,resizable=no.location=no,status=no')
        }
        function aHrefClick(flag){
            var url = '';
            if(flag == 1){
                url = '<%=basePath %>project/init/'+flag;
            }else if(flag == 2){
                url = '<%=basePath %>contractPro/init/'+flag;
            }else if(flag == 3){
                url = '<%=basePath %>contractPro/init/'+flag;
            }else{
                url = '<%=basePath %>project/init/'+flag;
            }
            window.location.href = url;
        }
        function proFormSubmit(){
            document.getElementById("proForm").submit();
        }
        function conFormSubmit(){
            document.getElementById("conForm").submit();
        }
        function progressFormSubmit(){
            document.getElementById("progressForm").submit();
        }
        function leaseFormSubmit(){
            document.getElementById("leaseForm").submit();
        }

        function delLease(id) {
            $.messager.confirm('意向删除', '您确定删除当前选中的租凭意向？', function (yes) {
                if(yes == true){
                    window.location.href = '<%=basePath %>project/delLease?leaseId='+id;
                }
            });
        }

        function delProject(id) {
            $.messager.confirm('项目删除', '您确定删除当前选中的项目记录？', function (yes) {
                if(yes == true){
                    $.ajax({
                        async : false,
                        cache : false,
                        type : 'POST',
                        data :{"projectId":id},
                        url :'<%=basePath %>project/delProject',
                        error : function() {// 请求失败处理函数
                            $.messager.alert('错误','查询塔机请求失败!','error');
                        },
                        success : function(data){
                            if('n' == data){
                                $.messager.alert('失败','项目信息删除失败!','error');
                            }else if('e' == data){
                            	$.messager.alert('警告','项目存在正在使用的合同信息，不能删除该项目信息!','error');
                            }else{
                                $.messager.alert('成功','项目信息删除成功!','info',function(){
                                    window.location.href = '<%=basePath %>project/init/1';
                                });
                            }
                        }
                    });
                }
            });
        }

        function delContract(id) {
            $.messager.confirm('合同删除', '您确定删除当前选中的合同信息？', function (yes) {
                if(yes == true){
                    $.ajax({
                        async : false,
                        cache : false,
                        type : 'POST',
                        data :{"contractId":id},
                        url :'<%=basePath %>contractPro/delContract',
                        error : function() {// 请求失败处理函数
                            $.messager.alert('错误','查询塔机请求失败!','error');
                        },
                        success : function(data){
                            if('n' == data){
                                $.messager.alert('失败','合同信息删除失败!','error');
                            }else{
                                $.messager.alert('成功','合同信息删除成功!','info',function(){
                                    window.location.href = '<%=basePath %>contractPro/init/2';
                                });
                            }
                        }
                    });
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
                <shiro:hasPermission name="leap:projectInfo">
                    <li> <a href="#tab1" onclick="aHrefClick(1);" <c:if test="${flag == '1'}">class="default-tab"</c:if>> <h4>项目资料</h4></a></li>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:contractInfo">
                    <li><a href="#tab2" onclick="aHrefClick(2);" <c:if test="${flag == '2'}">class="default-tab"</c:if>> <h4>合同信息</h4></a></li>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:projectProgress">
                    <li> <a href="#tab3" onclick="aHrefClick(3);" <c:if test="${flag == '3'}">class="default-tab"</c:if>> <h4>项目进度</h4></a></li>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:leaseIntent">
                    <li> <a href="#tab4" onclick="aHrefClick(4);" <c:if test="${flag == '4'}">class="default-tab"</c:if>> <h4>租赁意向</h4></a></li>
                </shiro:hasPermission>
                <!-- href must be unique and match the id of target div -->
            </ul>
            <div class="clear"></div>
        </div>
        <div class="content-box-content">
            <shiro:hasPermission name="leap:projectInfo">
                <div  <c:choose>
                    <c:when test="${flag == '1'}">class="tab-content default-tab"</c:when>
                    <c:otherwise>class="tab-content"</c:otherwise>
                </c:choose> id="tab1">
                    <form name="proForm" id="proForm" action="<%=basePath %>project/init/1" method="post">
                        <div class="search-actions">
                            <div class="search-condition">
                                <div class="search-condition-show">
                                    <table class="seach-table">
                                        <tr>
                                            <td><label>项目名称:</label></td>
                                            <td >
                                                <input name="proName" type="text" value="${proName}"/>
                                                <input id="proflag" type="hidden" name="flag" value="${flag}"/>
                                                <input id="propageNumber" type="hidden" name="pageNumber" value="${pageNumber}"/>
                                                <input id="proorderByType" type="hidden" name="orderByType" value="${orderByType}"/>
                                                <input id="proorderByName" type="hidden" name="orderByName" value="${orderByName}"/>
                                            </td>
                                            <td><label>项目编号:</label></td>
                                            <td ><input name="proNo" type="text" value="${proNo}"/></td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="search-condition-hidden">
                                    <table class="seach-table">
                                        <tr>
                                            <td class="px4z"><label>项目状态:</label></td>
                                            <td >
                                                <select id="proStatus" name="proStatus" class="easyui-combobox">
                                                </select>
                                            </td>
                                            <td><label>所属公司:</label></td>
                                            <td>
                                                <select id="proCompany" name="proCompany" class="easyui-combobox">
                                                </select>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="search-button">
                                <shiro:hasPermission name="leap:projectInfo:query">
                                    <a onclick="proFormSubmit()" class="button button_position" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="leap:projectInfo:add">
                                    <a class="button button_position" href="<%=basePath %>project/addProInit" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="leap:projectInfo:export">
                                    <a class="button button_position" href="<%=basePath %>project/down" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a>
                                </shiro:hasPermission>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </form>
                    <table>
                        <thead>
                        <tr>
                            <th class="chebox">项次</th>
                            <th  scope="col">项目编号</th>
                            <th  scope="col">项目名称</th>
                            <th  scope="col">区域</th>
                            <th  scope="col">省份</th>
                            <th  scope="col">城市</th>
                            <th  scope="col">项目类型</th>
                            <th  scope="col">项目状态</th>
                            <th  scope="col">所属公司</th>
                            <th  scope="col">管理单位</th>
                            <th  scope="col" class="picture3">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${proInfoList }" var="pro" varStatus="num">
                            <tr>
                                <td >
                                    <c:choose>
                                        <c:when test="${9 > num.index}">
                                            <c:if test="${(pageNumber+1) > 1}">${pageNumber}</c:if>${num.index+1 }
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber type="number" value="${pageNumber + ((((num.index+1)-(num.index+1)%10)/10))}"/>${(num.index+1)%10}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td ><div align="center">${pro.proNo}</div></td>
                                <td >${pro.proName}</td>
                                <td ><div align="center">${pro.proArea}</div></td>
                                <td><div align="center">${pro.proProvince}</div></td>
                                <td><div align="center">${pro.proCity}</div></td>
                                <td>
                                <div align="center">${pro.proType}</div>
                                </td>
                                <td>
                                <div align="center">
                                    <c:choose>
                                        <c:when test="${pro.proStatus == 0}">待启动</c:when>
                                        <c:when test="${pro.proStatus == 1}">已启动</c:when>
                                        <c:when test="${pro.proStatus == 2}">完成</c:when>
                                        <c:otherwise>未知状态</c:otherwise>
                                    </c:choose>
                                    </div>
                                </td>
                                <td><div align="center">${pro.proCompanyName}</div></td>
                                <td><div align="center">${pro.proManagedeptName}</div></td>
                                <td>
                                    <shiro:hasPermission name="leap:projectInfo:edit">
                                        <a href="<%=basePath %>project/editFind?projectId=${pro.id}" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" title="编辑"/></a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="leap:projectInfo:delete">
                                        <a href="#" onclick="delProject(${pro.id})" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" title="删除"/></a>
                                    </shiro:hasPermission>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="11"><div class="bulk-actions align-left">
                                <label>共有<b>${proTatol}</b>条数据</label>
                            </div>
                                <div id="proPagination" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                                <!-- End .pagination -->
                            </td>
                        </tr>
                        </tfoot>
                    </table>
                </div>
                <!-- End #tab1 -->
            </shiro:hasPermission>
            <shiro:hasPermission name="leap:contractInfo">
                <div  <c:choose>
                    <c:when test="${flag == '2'}">class="tab-content default-tab"</c:when>
                    <c:otherwise>class="tab-content"</c:otherwise>
                </c:choose> id="tab2">
                    <form name="conForm" id="conForm" action="<%=basePath %>contractPro/init/2" method="post">
                        <div class="search-actions">
                            <div class="search-condition">
                                <div class="search-condition-show">
                                    <table class="seach-table">
                                        <tr>
                                            <td><label>项目名称:</label></td>
                                            <td >
                                                <input name="proName" type="text" value="${proName}"/>
                                                <input id="conflag" type="hidden" name="flag" value="${flag}"/>
                                                <input id="conpageNumber" type="hidden" name="pageNumber" value="${pageNumber}"/>
                                                <input id="conorderByType" type="hidden" name="orderByType" value="${orderByType}"/>
                                                <input id="conorderByName" type="hidden" name="orderByName" value="${orderByName}"/>
                                            </td>
                                            <td><label>合同编号:</label></td>
                                            <td ><input name="contractNo" type="text" value="${contractNo}"/></td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="search-condition-hidden">
                                    <table class="seach-table">
                                        <tr>
                                            <td class="px4z"><label>项目状态:</label></td>
                                            <td >
                                                <select id="conStatus" name="contractStatus" class="easyui-combobox">
                                                </select>
                                            </td>
                                            <td><label>所属公司:</label></td>
                                            <td>
                                                <select id="conCompany" name="dispatchId" class="easyui-combobox">
                                                </select>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="search-button">
                                <shiro:hasPermission name="leap:contractInfo:query">
                                    <a class="button button_position" onclick="conFormSubmit();" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="leap:contractInfo:add">
                                    <a class="button button_position" href="<%=basePath %>project/addInit" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="leap:contractInfo:export">
                                    <a class="button button_position" href="<%=basePath %>contractPro/down" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a>
                                </shiro:hasPermission>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </form>
                    <table>
                        <thead>
                        <tr>
                            <th class="chebox">项次</th>
                            <th  scope="col">合同编号</th>
                            <th  scope="col">项目名称</th>
                            <th  scope="col">区域</th>
                            <th  scope="col">省份</th>
                            <th  scope="col">城市</th>
                            <th  scope="col">类型</th>
                            <th  scope="col">状态</th>
                            <th  scope="col">所属公司</th>
                            <th  scope="col">管理单位</th>
                            <th  scope="col" class="picture4">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${conInfoList }" var="pro" varStatus="num">
                            <tr>
                                <td >
                                    <c:choose>
                                        <c:when test="${9 > num.index}">
                                            <c:if test="${(pageNumber+1) > 1}">${pageNumber}</c:if>${num.index+1 }
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber type="number" value="${pageNumber + ((((num.index+1)-(num.index+1)%10)/10))}"/>${(num.index+1)%10}
                                        </c:otherwise>
                                    </c:choose></td>
                                <td ><div align="center"><a href="<%=basePath %>contractPro/find?contractId=${pro.id}&flag=${flag}" class="edit">${pro.contractNo}</a></div></td>
                                <td >${pro.proName}</td>
                                <td ><div align="center">${pro.proArea}</div></td>
                                <td><div align="center">${pro.proProvince}</div></td>
                                <td><div align="center">${pro.proCity}</div></td>
                                <td>
                                <div align="center">${pro.proType}</div>
                                </td>
                                <td>
                                <div align="center">
                                    <c:choose>
                                        <c:when test="${pro.contractStatus == 0}">待启动</c:when>
                                        <c:when test="${pro.contractStatus == 1}">已启动</c:when>
                                        <c:when test="${pro.contractStatus == 3}">完成</c:when>
                                        <c:otherwise>未知状态</c:otherwise>
                                    </c:choose>
                                    </div>
                                </td>
                                <td><div align="center">${pro.proCompanyName}</div></td>
                                <td><div align="center">${pro.proManagedeptName}</div></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${pro.checkUserid != null }">
                                            <a  class="edit"><img src="<%=basePath %>static/images/icons/tests-icon.png" alt="已经完成审核操作" title="已经完成审核操作"/></a>
                                            <a href="<%=basePath %>contractPro/findContractSchedule?contractId=${pro.id}" class="edit"><img src="<%=basePath %>static/images/icons/view.png" alt="详情" title="详情"/></a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="<%=basePath %>contractPro/checkInit?contractId=${pro.id}" class="edit"><img src="<%=basePath %>static/images/icons/tests-icon.png" title="审核"/></a>
                                            <a href="<%=basePath %>contractPro/editInit?contractId=${pro.id}" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" alt="编辑" title="编辑"/></a>
                                        </c:otherwise>
                                    </c:choose>
                                    <a href="#" onclick="delContract(${pro.id})" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" title="删除"/></a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="11"><div class="bulk-actions align-left">
                                <label>共有<b>${conTatol}</b>条数据</label>
                            </div>
                                <div id="conPagination" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                                <!-- End .pagination -->
                            </td>
                        </tr>
                        </tfoot>
                    </table>
                </div>

                <!-- End #tab2 -->
            </shiro:hasPermission>
            <shiro:hasPermission name="leap:projectProgress">

                <div <c:choose>
                    <c:when test="${flag == '3'}">class="tab-content default-tab"</c:when>
                    <c:otherwise>class="tab-content"</c:otherwise>
                </c:choose> id="tab3">
                    <form id="progressForm" action="<%=basePath %>contractPro/init/3" method="post">
                        <div class="search-actions">
                            <div class="search-condition">
                                <div class="search-condition-show">
                                    <table class="seach-table">
                                        <tr>
                                            <td><label>项目名称:</label></td>
                                            <td >
                                                <input name="proName" type="text" value="${proName}"/>
                                                <input id="progressflag" type="hidden" name="flag" value="${flag}"/>
                                                <input id="progresspageNumber" type="hidden" name="pageNumber" value="${pageNumber}"/>
                                                <input id="progressorderByType" type="hidden" name="orderByType" value="${orderByType}"/>
                                                <input id="progressorderByName" type="hidden" name="orderByName" value="${orderByName}"/>
                                            </td>
                                            <td><label>合同编号:</label></td>
                                            <td ><input name="contractNo" type="text" value="${contractNo}"/></td>
                                        </tr>
                                    </table>
                                </div>
                                <div id="search-condition-hidden">
                                    <table class="seach-table">
                                        <tr>
                                            <td class="px4z"><label>项目状态:</label></td>
                                            <td >
                                                <select id="progressStatus" name="contractStatus" class="easyui-combobox">
                                                </select>
                                            </td>
                                            <td><label>所属公司:</label></td>
                                            <td>
                                                <select id="progressCompany" name="dispatchId" class="easyui-combobox">
                                                </select>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="search-button">
                                <shiro:hasPermission name="leap:contractInfo:query">
                                    <a class="button button_position" onclick="progressFormSubmit();" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="leap:contractInfo:export">
                                    <a class="button button_position" href="#" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a>
                                </shiro:hasPermission>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </form>
                    <table >
                        <thead>
                        <tr>
                            <th class="chebox">项次</th>
                            <th  scope="col">合同编号</th>
                            <th  scope="col">项目名称</th>
                            <th  scope="col">区域</th>
                            <th  scope="col">省份</th>
                            <th  scope="col">城市</th>
                            <th  scope="col">类型</th>
                            <th  scope="col">状态</th>
                            <th  scope="col">所属公司</th>
                            <th  scope="col">管理单位</th>
                            <th  scope="col" class="picture3">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${progressList}" var="pro" varStatus="num">
                            <tr>
                                <td >
                                    <c:choose>
                                        <c:when test="${9 > num.index}">
                                            <c:if test="${(pageNumber+1) > 1}">${pageNumber}</c:if>${num.index+1 }
                                        </c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber type="number" value="${pageNumber + ((((num.index+1)-(num.index+1)%10)/10))}"/>${(num.index+1)%10}
                                        </c:otherwise>
                                    </c:choose></td>
                                <td ><div align="center"><a href="<%=basePath %>contractPro/find?contractId=${pro.id}&flag=${flag}" class="edit">${pro.contractNo}</a></div></td>
                                <td >${pro.proName}</td>
                                <td ><div align="center">${pro.proArea}</div></td>
                                <td><div align="center">${pro.proProvince}</div></td>
                                <td><div align="center">${pro.proCity}</div></td>
                                <td><div align="center">${pro.proType}</div>
                                </td>
                                <td>
                                <div align="center">
                                    <c:choose>
                                        <c:when test="${pro.contractStatus == 0}">待启动</c:when>
                                        <c:when test="${pro.contractStatus == 1}">已启动</c:when>
                                        <c:when test="${pro.contractStatus == 2}">已关闭</c:when>
                                        <c:otherwise>未知状态</c:otherwise>
                                    </c:choose>
                                    </div>
                                </td>
                                <td><div align="center">${pro.proCompanyName}</div></td>
                                <td><div align="center">${pro.proManagedeptName}</div></td>
                                <td>
                                    <shiro:hasPermission name="leap:contractInfo:check">
                                        <a href="<%=basePath %>contractPro/addGoodsUseInit?contractId=${pro.id}&isEdit=2&flag=${flag}" class="edit"><img src="<%=basePath %>static/images/icons/tests-icon.png" title="审核"/></a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="leap:contractInfo:edit">
                                        <a href="<%=basePath %>contractPro/addGoodsUseInit?contractId=${pro.id}&isEdit=1&flag=${flag}" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" title="编辑"/></a>
                                    </shiro:hasPermission>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="11"><div class="bulk-actions align-left">
                                <label>共有<b>${progressTatol}</b>条数据</label>
                            </div>
                                <div id="progressPagination" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                                <!--  End .pagination -->
                            </td>
                        </tr>
                        </tfoot>
                    </table>
                </div>
                <!-- End #tab3 -->
            </shiro:hasPermission>
            <shiro:hasPermission name="leap:leaseIntent">

                <div <c:choose>
                    <c:when test="${flag == '4'}">class="tab-content default-tab"</c:when>
                    <c:otherwise>class="tab-content"</c:otherwise>
                </c:choose> id="tab4">
                    <form id="leaseForm" action="<%=basePath %>project/init/4" method="post">
                        <div class="search-actions">
                            <div class="search-condition">
                                <div class="search-condition-show">
                                    <table class="seach-table">
                                        <tr>
                                            <td><label>所属公司:</label></td>
                                            <td >
                                                <select id="ofCompany" name="ofCompany" class="easyui-combobox">
                                                </select>
                                            </td>
                                            <td ><label>塔机编号:</label></td>
                                            <td >
                                                <input name="towerNo" type="text" class="text-input" value="${towerNo }"/>
                                                <input id="leaseflag" type="hidden" name="flag" value="${flag}"/>
                                                <input id="leasepageNumber" type="hidden" name="pageNumber" value="${pageNumber}"/>
                                                <input id="leaseorderByType" type="hidden" name="orderByType" value="${orderByType}"/>
                                                <input id="leaseorderByName" type="hidden" name="orderByName" value="${orderByName}"/>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td ><label>塔机型号:</label></td>
                                            <td >
                                                <select id="towerCase" name="towerCase" class="easyui-combobox">
                                                    <option></option>
                                                </select>
                                            </td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="search-button">
                                <shiro:hasPermission name="leap:leaseIntent:query">
                                    <a class="button button_position" onclick="leaseFormSubmit();" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="leap:leaseIntent:add">
                                    <a class="button button_position" href="<%=basePath %>project/addInitLease" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a> <a class="button button_position" href="<%=basePath %>project/downLeaseExcel" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a>
                                </shiro:hasPermission>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </form>
                    <table >
                        <thead>
                        <tr>
                            <th scope="col" class="chebox">项次</th>
                            <th  scope="col">塔机编号</th>
                            <th  scope="col" >塔机型号</th>
                            <th  scope="col" >区域</th>
                            <th  scope="col" >省份</th>
                            <th  scope="col" >城市</th>
                            <th  scope="col" >执行状况</th>
                            <th  scope="col" class="time">停租日期</th>
                            <th  scope="col" >租赁意向</th>
                            <th  scope="col" class="time">预计进场时间</th>
                            <th  scope="col" >管理公司</th>
                            <th  scope="col" class="picture2">编辑</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${leaList}" var="lease" varStatus="num">
                            <tr>
                                <td><c:choose>
                                    <c:when test="${9 > num.index}">
                                        <c:if test="${(pageNumber+1) > 1}">${pageNumber}</c:if>${num.index+1 }
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatNumber type="number" value="${pageNumber + ((((num.index+1)-(num.index+1)%10)/10))}"/>${(num.index+1)%10}
                                    </c:otherwise>
                                </c:choose></td>
                                <td ><div align="center">${lease.towerNo }</div></td>
                                <td ><div align="center">${lease.towerCase }</div></td>
                                <td><div align="center">${lease.proArea }</div></td>
                                <td><div align="center">${lease.proProvince }</div></td>
                                <td><div align="center">${lease.proCity  }</div></td>
                                <td><div align="center">
                                    <c:choose>
                                        <c:when test="${lease.leaseStatus == 0}">未启用</c:when>
                                        <c:when test="${lease.leaseStatus == 1}">转为项目</c:when>
                                        <c:otherwise>未知状态</c:otherwise>
                                    </c:choose>
                                    </div>
                                </td>
                                <td><div align="center"><fmt:formatDate pattern="yyyy-MM-dd" value="${lease.leaseEndtime}" type="both" /></div></td>
                                <td><div align="center">${lease.leaseIntention }</div></td>
                                <td><div align="center"><fmt:formatDate pattern="yyyy-MM-dd" value="${lease.leaseStarttime}" type="both" /></div></td>
                                <td><div align="center">${lease.manageCompanyName }</div></td>
                                <td>
                                    <shiro:hasPermission name="leap:leaseIntent:edit">
                                        <a href="<%=basePath %>project/editFindLease?intentId=${lease.id}" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" title="编辑"/></a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="leap:leaseIntent:delete">
                                        <a href="#" onclick="delLease(${lease.id})" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" title="删除"/></a>
                                    </shiro:hasPermission>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="11"><div class="bulk-actions align-left">
                                <label>共有<b>${intentTatol}</b>条数据</label>
                            </div>
                                <div id="intentPagination" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                                <!--  End .pagination -->
                            </td>
                        </tr>
                        </tfoot>
                    </table>
                </div>
                <!-- End #tab4 -->
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