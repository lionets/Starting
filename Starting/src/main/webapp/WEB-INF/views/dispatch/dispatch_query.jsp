<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
    <link rel="stylesheet" type="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/icon.css">
    <link rel="stylesheet" href="<%=basePath %>static/js/paging/pagination.css" />
    <link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
    <!-- Main Stylesheet -->
    <link rel="stylesheet" type="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/default/easyui.css">
    <link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen" />
    <!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
    <link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen" />
    <link rel="stylesheet" href="<%=basePath %>static/css/select.css" type="text/css" media="screen" />
    <script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>static/js/paging/jquery.pagination.js"></script>
    <SCRIPT src="<%=basePath %>static/js/jQselect.js" type=text/javascript></SCRIPT>
    <SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></SCRIPT>
    <script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
    <script src="<%=basePath %>static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <SCRIPT type=text/javascript>
        using(['window'],function(){});//加载window插件
        using(['combobox']);//加载window插件 
        using(['messager']);//加载window插件   
        
        function checkit(id,status){
            if(status!="1"){
                tatongMethod.alert("提示","只有待签核状态才能签核！");
                return;
            }
            location.href="<%=basePath %>transfer/dispatch_audit?tab=tab1&id="+id+"&tab1PageNum=${tab1PageNum}";
        }

        function showdispatch(id,status,dispatch_type){
            if(status!="2"){
                tatongMethod.alert("提示","只有待调度状态才能调度！");
                return;
            }
            tatongMethod.confirm("提示","确定要调度吗?",function(){
				using(['messager'],function(){
				    $.messager.progress({text:"正在提交...",interval:500}); 
				}); 
                var url = "<%=basePath %>transfer/dispatch?id="+id+"&tab=tab1&tab1PageNum="+tab1PageNum+"&dispatch_type="+encodeURI(encodeURI(dispatch_type));
                location.href=url;
            })
        }

        //分页点击执行的操作
        function changePage(index,jq){
            if(jq.attr("id")=="pagination1"){
                $("#tab1PageNum").val(index);
                $("#tab1PerPage").val(tab1PerPage);
                $("#form1").submit();
            }
            if(jq.attr("id")=="pagination2"){
                $("#conpageNumber").val(index);
                $("#tab2PerPage").val(tab2PerPage);
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
                ellipse_text:"...",//中间缺省内容
                prev_show_always:true,
                next_show_always:true,
                show_if_single_page:true,
                callback:changePage,
                load_first_page:false,
            });
        };
	
        
        function dispatch_edit(id,tab1PageNum,status,dispatch_type){
        	if(status != '1'){
        		 tatongMethod.alert("提示","只有待签核状态才能编辑！");
        		 return
        	}
        	location.href = '<%=basePath %>transfer/dispatch_edit?id='+id+"&tab1PageNum="+tab1PageNum+"&dispatch_type="+encodeURI(encodeURI(dispatch_type));
        }

        //控制应该显示的面板
        var togle =	function(tab){
            $("#"+tab).siblings().hide();
            $("#a"+tab).addClass("current");
            $("#"+tab).show();
            //初始化分页默认每页显示10条
            if(tab=="tab1"){
                initPagination("pagination1","${count}",10,tab1PageNum);
            }
            if(tab=="tab2"){
                initPagination("pagination2","${schemeTatol}",10,'${pageNumber}');
            }
        }

        //删除一条记录
        function showdelete(id,tab,count,status){
            if(status!="1" && status!="2"){
                tatongMethod.alert("提示","只有待签核和待调度状态可以作废！");
                return;
            }
            tatongMethod.confirm("提示","确定要作废吗?",function(){
                var url = "<%=basePath %>transfer/deleteOne?id="+id+"&tab="+tab;
                if(tab=="tab1"){
                    $("#tab1PageNum").val(tab1PageNum);
                    $("#tab1PerPage").val(tab1PerPage);
                    $("#form1").attr("action",url);
                    $("#form1").submit();
                }
                if(tab=="tab2"){
                    if("${count}"%tab2PerPage ==1){
                        tab2PageNum --;
                        if(tab2PageNum <0){
                            tab2PageNum=0;
                        }
                    }
                    $("#tab2PageNum").val(tab2PageNum);
                    $("#tab2PerPage").val(tab2PerPage);
                    $("#form2").attr("action",url);
                    $("#form2").submit();
                }
            })
        }

        //公司管理分页,传递只需要页码和每页条数即可
        var tab1PageNum = "${tab1PageNum}"==""?0:"${tab1PageNum}";
        var tab1PerPage =  "${tab1PerPage}"==""?10: "${tab1PerPage}";

        //用户管理分页
        var tab2PageNum = "${tab2PageNum}"==""?0:"${tab2PageNum}";
        var tab2PerPage =   "${tab2PerPage}"==""?10: "${tab2PerPage}";

        $(document).ready(function() {
            /* 		$(".start_address").bind("mouseover",function(){
             $('.start_address').tinytooltip({message: $(this).attr("start_address")});
             })
             $(".end_address").bind("mouseover",function(){
             $('.end_address').tinytooltip({message: $(this).attr("end_address")});
             }) */

            //控制显示的面板
            var tab = "${tab}";
            togle(tab);
            //添加点击事件
            $(".atab").on("click",function(){
                var url = "<%=basePath %>transfer/init/"+$(this).attr("name");
                if($(this).attr("name")=="tab1"){
                    url += "?tab1PageNum="+tab1PageNum+"&tab1PerPage="+tab1PerPage;
                }
                if($(this).attr("name")=="tab2"){
                    url = "<%=basePath %>contractPro/init/4?tab2PageNum="+tab2PageNum+"&tab2PerPage="+tab2PerPage;
                }
                location.href= url;
            });
            using(['combobox'],function(){
            $('#conCompany').combobox({
                url:'<%=basePath %>company/manageCompanyCombox',
                valueField:'id',
                textField:'companyShortName',
                onLoadSuccess:function(){
                    $('#conCompany').combobox('setValue','${dispatchId}');
                }
            });})
            using(['combobox'],function(){
            $("#conStatus").combobox({
                url:"<%=basePath %>dictionary/selectByDictCode?dict_code=XMZT",
                valueField: 'dict_name',
                textField: 'dict_value',
                onLoadSuccess:function(){
                    if(('${contractStatus}') != ''){
                        $('#conStatus').combobox('setValue','${contractStatus}');
                    }
                }
            });
            })
        });
    </SCRIPT>
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
                <shiro:hasPermission name="leap:assetSchedule">
                    <li><a href="#tab1" id="atab1" name="tab1" class="atab"> <h4>资产调度</h4></a></li>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:projectCase">
                    <li><a href="#tab2" id="atab2" name="tab2" class="atab"> <h4>项目方案</h4></a></li>
                </shiro:hasPermission>
            </ul>
        </div>
        <!-- End .content-box-header -->
        <div class="content-box-content">
            <shiro:hasPermission name="leap:assetSchedule">
                <c:if test='${tab=="tab1" }'>
                    <div class="tab-content default-tab" id="tab1">
                        <form id="form1" action="<%=basePath %>transfer/init/tab1" method="post">
                            <input type="hidden" id="tab1PageNum" name="tab1PageNum" value="0">
                            <input type="hidden" id="tab1PerPage" name="tab1PerPage" value="10">
                            <div class="search-actions">
                                <div class="search-condition">
                                    <table class="seach-table">
                                        <tr>
                                            <td><label>合同编号:</label></td>
                                            <td ><input name="contract_no" type="text"  value="${contract_no }"></td>
                                            <td><label>项目:</label></td>
                                            <td ><input name="end_address" type="text" value="${end_address }"></td>
                                            <td><label>调度单号:</label></td>
                                            <td ><input name="dispatch_no" type="text"  value="${dispatch_no }"></td>
                                        </tr>

                                        <tr>
                                            <td ><label>塔机编号:</label></td>
                                            <td >
                                                <input name="tower_no" type="text" value="${tower_no }"/>
                                            </td>
                                            <td ><label>状态:</label></td>
                                            <td >
                                                <!--<input type="text" list="number_list" name="link" />
                                                     <datalist id="number_list">
                                                      <option label="待启动" value="待启动"></option>
                                                      <option label="已启动" value="已启动"></option>
                                                      <option label="完成" value="完成"></option>
                                                    </datalist>   -->

                                                <select id="dispatch_status" name="dispatch_status" class="easyui-combobox" >
                                                    <option value="">不限</option>
                                                    <c:forEach var="ddzt" items="${ddztList }">
                                                     <option  value="${ddzt.dict_name }"  <c:if test='${dispatch_status==ddzt.dict_name }'>selected="selected"</c:if>>${ddzt.dict_value }</option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td ><label>调度时间:</label></td>
                                            <td ><input name="dispatch_time_start" value="${dispatch_time_start }" type="text" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});"   /></td>
                                            <td style="text-align:left" colspan="4"> ~
                                                <input name="dispatch_time_end"  value="${dispatch_time_end }"  readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});"  type="text"  /></td>
                                        </tr>
                                    </table>

                                </div>
                                <div class="search-button">
                                    <shiro:hasPermission name="leap:assetSchedule:query">
                                        <a class="button button_position" href="javascript:void(0)" onclick="document.getElementById('form1').submit()" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="leap:assetSchedule:add">
                                        <a class="button button_position" href='<%=basePath %>transfer/dispatch_new?tab=tab1&tab1PageNum=${tab1PageNum==null?"0":tab1PageNum}' title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="leap:assetSchedule:export">
                                        <a class="button button_position" href="<%=basePath %>transfer/exportExcel" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a>
                                    </shiro:hasPermission>
                                </div>
                                <div class="clear"></div>
                            </div>
                        </form>
                        <table>
                            <thead>
                            <tr>
                                <th width="30"  scope="col" class="chebox"><div align="center">项次</div></th>
                                <th width="80" scope="col"><div align="center">合同编号</div></th>
                                <th width="120"  scope="col" >项目</th>
                                <th width="100"  scope="col" ><div align="center">调度单号</div></th>
                                <th width="100"  scope="col"><div align="center">塔机编号</div></th>
                                <th width="100"  scope="col"><div align="center">状态</div></th>
                                <th width="100"   scope="col" class="date"><div align="center">调度时间</div></th>
                                <th width="100"  scope="col" ><div align="center">起止地址</div></th>
                                <th width="190"  scope="col" class="picture4"><div align="center">功能</div></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="dispatch" varStatus="status" items="${dispatchList }">
                                <tr>
                                    <td class="tbllb"><div align="center">
                                        <script type="text/javascript">
                                            var num =	${status.index+1}+tab1PageNum* tab1PerPage;
                                            document.write(num);
                                        </script>
                                    </div></td>
                                    <td ><div align="center">${dispatch.contract_no }</div></td>
                                    <td >${dispatch.end_address }</td>
                                    <td><div align="center"><a  href='<%=basePath %>transfer/dispatch_view?tab=tab1&id=${dispatch.id }&tab1PageNum=${tab1PageNum}&dispatch_type=${dispatch.dispatch_type=="项目"?1:2}' >${dispatch.dispatch_no }</a></div></td>
                                    <td><div align="center">${dispatch.tower_manage_no }</div></td>
                                    <td><div align="center">
                                        <script type="text/javascript">
                                            var status = "${dispatch.dispatch_status }";
                                            var showStr = "待签核";
                                            switch (status) {
                                                case "1":
                                                    showStr = "待签核";
                                                    break;
                                                case "2":
                                                    showStr = "待调度";
                                                    break;
                                                case "3":
                                                    showStr = "已作废";
                                                    break;
                                                case "4":
                                                    showStr = "待提交";
                                                    break;
                                                case "5":
                                                    showStr = "调度结束";
                                                    break;
                                            }
                                            document.write(showStr);
                                        </script>

                                    </div></td>
                                    <td><div align="center">  <fmt:formatDate  value="${dispatch.dispatch_time }" type="both" pattern="yyyy-MM-dd" /></div></td>
                                    <td><div align="center">
	           <span title="${dispatch.start_address }">
	           <script type="text/javascript">
                   document.write("${dispatch.start_address }".substring(0,2)+"...");
               </script>
	           </span> -&gt;<span  title="${dispatch.end_address }">
	           <script type="text/javascript">
                   document.write("${dispatch.end_address }".substring(0,2)+"...");
               </script>
	           </span>
                                    </div></td>
                                    <td><div align="center">
                                        <shiro:hasPermission name="leap:assetSchedule:check">
                                            <a onclick="checkit(${dispatch.id },'${dispatch.dispatch_status }')" href="javascript:void(0)" class="edit"><img src="<%=basePath %>static/images/icons/tests-icon.png" alt="审核" title="审核"/></a>
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="leap:assetSchedule:confirm">
                                            <a onClick="showdispatch(${dispatch.id },'${dispatch.dispatch_status }','${dispatch.dispatch_type}')" class="edit"><img src="<%=basePath %>static/images/icons/success-icon.png" alt="确认调度" title="确认调度"/></a>
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="leap:assetSchedule:edit">
                                            <a onClick="dispatch_edit(${dispatch.id },0,'${dispatch.dispatch_status }','${dispatch.dispatch_type}')" href='javascript:void(0)' class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" alt="编辑" title="编辑"/></a>
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="leap:assetSchedule:delete">
                                            <a href="javascript:void(0)" onClick="showdelete(${dispatch.id},'tab1',${count},'${dispatch.dispatch_status }')" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" alt="Delete" /></a>
                                        </shiro:hasPermission>
                                    </div></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="10"><div class="bulk-actions align-left">
                                    <label>共有<b>${count}</b>条数据</label>
                                </div>
                                    <div  id="pagination1" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </c:if>
            </shiro:hasPermission>
            <shiro:hasPermission name="leap:projectCase">
                <c:if test='${tab=="tab2" }'>
                    <div class="tab-content" id="tab2">
                        <form action="<%=basePath %>contractPro/init/4" id="form2" method="post">
                            <input type="hidden" id="tab2PageNum" name="tab2PageNum" value="0">
                            <input type="hidden" id="tab2PerPage" name="tab2PerPage" value="10">
                            <div class="search-actions">
                                <div class="search-condition">
                                    <div class="search-condition-show">
                                        <table class="seach-table">
                                            <tr>
                                                <td><label>项目名称:</label></td>
                                                <td>
                                                    <input name="proName" type="text" value="${proName}"/>
                                                    <input id="conpageNumber" type="hidden" name="pageNumber" value="${pageNumber}"/>
                                                    <input id="conorderByType" type="hidden" name="orderByType" value="${orderByType}"/>
                                                    <input id="conorderByName" type="hidden" name="orderByName" value="${orderByName}"/>
                                                </td>
                                                <td><label>合同编号:</label></td>
                                                <td ><input name="contractNo" type="text" value="${contractNo}"/></td>
                                        </table>
                                    </div>
                                    <div id="search-condition-hidden">
                                        <table class="seach-table">
                                            <tr>
                                                <td class="px4z"><label>状态:</label></td>
                                                <td >
                                                    <select id="conStatus" name="contractStatus" class="easyui-combobox">
                                                    </select>
                                                </td>
                                                <td><label>所属公司:</label></td>
                                                <td><select id="conCompany" name="dispatchId" class="easyui-combobox">
                                                </select>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                                <div class="search-button">
                                    <shiro:hasPermission name="leap:projectCase:query">
                                        <a class="button button_position" href="javascript:void(0)" onclick="document.getElementById('form2').submit()" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="leap:projectCase:export">
                                        <a class="button button_position" href="#" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a>
                                    </shiro:hasPermission>
                                </div>

                                <div class="clear"></div>
                            </div>
                        </form>
                        <table>
                            <thead>
                            <tr>
                                <th class="chebox"><div align="center">项次</div></th>
                                <th  scope="col"><div align="center">合同编号</div></th>
                                <th  scope="col">项目名称</th>
                                <th  scope="col"><div align="center">区域</div></th>
                                <th  scope="col"><div align="center">省份</div></th>
                                <th  scope="col"><div align="center">城市</div></th>
                                <th  scope="col"><div align="center">类型</div></th>
                                <th  scope="col"><div align="center">状态</div></th>
                                <th  scope="col" >所属公司</th>
                                <th  scope="col">管理单位</th>
                                <th  scope="col" class="picture4"><div align="center">功能</div></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${schemeList }" var="pro" varStatus="num">
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
                                    <td ><div align="center"><a href="<%=basePath %>contractPro/find?contractId=${pro.id}&flag=4" class="edit">${pro.contractNo}</a></div></td>
                                    <td >${pro.proName}</td>
                                    <td ><div align="center">${pro.proArea}</div></td>
                                    <td><div align="center">${pro.proProvince}</div></td>
                                    <td><div align="center">${pro.proCity}</div></td>
                                    <td>
                                    <div align="center">${pro.proType}</div>
                                    </td>
                                    <td><div align="center">
                                        <c:choose>
                                            <c:when test="${pro.contractStatus == 0}">待启动</c:when>
                                            <c:when test="${pro.contractStatus == 1}">已启动</c:when>
                                            <c:when test="${pro.contractStatus == 2}">完成</c:when>
                                            <c:otherwise>未知状态</c:otherwise>
                                        </c:choose>
                                        </div>
                                    </td>
                                    <td><div align="center">${pro.proCompanyName}</div></td>
                                    <td><div align="center">${pro.proManagedeptName}</div></td>
                                    <td><div align="center">
                                        <c:choose>
                                            <c:when test="${pro.schemeCheckState == '2'}">
                                                <a href="#" class="edit"><img src="<%=basePath %>static/images/icons/tests-icon.png" alt="已经完成审核操作" title="已经完成审核操作"/></a>
                                                <a href="#" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" alt="审核已经完成，不能再编辑合同方案" title="审核已经完成，不能再编辑合同方案"/></a>
                                            </c:when>
                                            <c:when test="${pro.schemeCheckState == '1'}">
                                            	<shiro:hasPermission name="leap:projectCase:check">
                                                    <a href="<%=basePath %>contractPro/checkSchemeInit?contractId=${pro.id}" class="edit"><img src="<%=basePath %>static/images/icons/tests-icon.png" alt="审核" title="审核"/></a>
                                                </shiro:hasPermission>
                                                <shiro:hasPermission name="leap:projectCase:edit">
                                                    <a href="<%=basePath%>contractPro/addSchemeInit?contractId=${pro.id}" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" title="编辑"/></a>
                                                </shiro:hasPermission>
                                            </c:when>
                                            <c:otherwise>
                                                <shiro:hasPermission name="leap:projectCase:edit">
                                                    <a href="<%=basePath%>contractPro/addSchemeInit?contractId=${pro.id}" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" title="编辑"/></a>
                                                </shiro:hasPermission>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:choose>
                                        <c:when test="${pro.dispatchStatus == '1'}">
                                        <a href="#" class="edit"><img src="<%=basePath %>static/images/icons/orange_icon.png" title="调度中"/></a>
                                        </c:when>
                                        <c:when test="${pro.dispatchStatus == '2'}">
                                        <a href="#" class="edit"><img src="<%=basePath %>static/images/icons/green_icon.png" title="调度完成"/></a>
                                        </c:when>
                                        <c:otherwise>
                                        <a href="#" class="edit"><img src="<%=basePath %>static/images/icons/red_icon.png" title="未调度"/></a>
                                        </c:otherwise>
                                        </c:choose>
                                    </div></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="11"><div class="bulk-actions align-left">
                                    <label>共有<b>${schemeTatol}</b>条数据</label>
                                </div>
                                    <div  id="pagination2" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </c:if>
            </shiro:hasPermission>
            <!-- End #tab1 -->
            <!-- End #tab2 -->
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
<script type="text/javascript">
</script>
</html>