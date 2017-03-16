<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = path + "/";
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
    <link rel="stylesheet" href="<%=basePath %>static/js/paging/pagination.css"/>
    <link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen"/>
    <!-- Main Stylesheet -->
    <link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen"/>
    <!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
    <link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen"/>
    <link rel="stylesheet" href="<%=basePath %>static/css/select.css" type="text/css" media="screen"/>
    <script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>static/js/jquery.datePicker.js"></script>
    <script type="text/javascript" src="<%=basePath %>static/js/paging/jquery.pagination.js"></script>
    <script src="<%=basePath %>static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <SCRIPT src="<%=basePath %>static/js/jQselect.js" type=text/javascript></SCRIPT>
    <SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></SCRIPT>
    <script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<SCRIPT type=text/javascript>
using(['window']);//加载window插件
var tab1PageNum = "${tab1PageNum}" == "" ? 0 : "${tab1PageNum}";

var tab2PageNum = "${tab2PageNum}" == "" ? 0 : "${tab2PageNum}";


//分页点击执行的操作
function changePage(index, jq) {
    if (jq.attr("id") == "pagination1") {
        $("#tab1PageNum").val(index);
        $("#form1").submit();
    }
    if (jq.attr("id") == "pagination2") {
        $("#tab2PageNum").val(index);
        $("#form2").submit();
    }
}

//删除一条记录
function showdelete(id, tab, count) {
    tatongMethod.confirm("删除", "确定要删除吗?", function () {
        var url = "<%=basePath %>maintain/deleteOne/" + tab + "?id=" + id;
        if (tab == "tab1") {
            if ("${count}" % 10 == 1) {
                tab1PageNum--;
                if (tab1PageNum < 0) {
                    tab1PageNum = 0;
                }
            }
            $("#tab1PageNum").val(tab1PageNum);
            $("#form1").attr("action", url);
            $("#form1").submit();
        }
        if (tab == "tab2") {
            if ("${count}" % 10 == 1) {
                tab2PageNum--;
                if (tab2PageNum < 0) {
                    tab2PageNum = 0;
                }
            }
            $("#tab2PageNum").val(tab2PageNum);
            $("#form2").attr("action", url);
            $("#form2").submit();
        }
    })
}

//控制应该显示的面板
var togle = function (tab) {
    $("#" + tab).siblings().hide();
    $("#a" + tab).addClass("current");
    $("#" + tab).show();
    //初始化分页默认每页显示10条
    if (tab == "tab1") {
        initPagination("pagination1", "${count}", 10, tab1PageNum);
    }
    if (tab == "tab2") {
        initPagination("pagination2", "${count}", 10, tab2PageNum);
    }
}


//分页初始化传入id代表要创建分页的id号，参数count代表总数量，perPage表示每页显示条数,current_page为当前页
function initPagination(id, count, perPage, current_page) {
    $("#" + id).pagination(count, {
        items_per_page: perPage, //每页显示数目
        num_edge_entries: 4,//边缘页后面显示数目
        num_display_entries: 4,//边缘页前面显示数目
        current_page: current_page,//显示第1页
        prev_text: "上页",
        next_text: "下页",
        ellipse_text: "...",//中间缺省内容
        prev_show_always: true,
        next_show_always: true,
        show_if_single_page: true,
        callback: changePage,
        load_first_page: false,
    });
}


	$(document).ready(function() {
        //控制显示的面板
        var tab = "${tab}";
       	togle(tab);
        //根据点击的id发送请求
        $(".atab").on("click", function () {
            var url = "<%=basePath %>maintain/init/" + $(this).attr("name");
            if ($(this).attr("name") == "tab1") {
                url += "?tab1PageNum=" + tab1PageNum;
            }
            if ($(this).attr("name") == "tab2") {
                url += "?tab2PageNum=" + tab2PageNum;
            }
            location.href = url;
        })
        
        $("#exportCheckList").on("click",function(){
        	location.href = '<%=basePath %>maintain/exportCheckList';
        })
        $("#exportMaintain").on("click",function(){
        	location.href = '<%=basePath %>maintain/exportMaintain';
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
       <shiro:hasPermission name="leap:securityCheck">
         <li><a href="#tab1" id="atab1" name="tab1" class="atab"> <h4>安全检查</h4></a></li>
       </shiro:hasPermission>
       <shiro:hasPermission name="leap:equipmentMaintenance">
         <li> <a href="#tab2" id="atab2" name="tab2" class="atab"> <h4>设备维修</h4></a></li>
       </shiro:hasPermission>
        <!-- href must be unique and match the id of target div -->
      </ul>
      <div class="clear"></div>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <c:if test='${tab=="tab1" }'>
      <shiro:hasPermission name="leap:securityCheck">
        <div class="tab-content " id="tab1">
          <form action="<%=basePath %>/maintain/init/tab1" id="form1" method="post">
          <input type="hidden" id="tab1PageNum" name="tab1PageNum" value="0">
            <div class="search-actions">
              <div class="search-condition">
                <div class="search-condition-show">
                  <table class="seach-table">
                    <tr>
                      <td><label>检查单编号:</label></td>
                      <td ><input name="checklisst_no" type="text" value="${checklisst_no }"></td>
                      <td ><label>项目名称:</label></td>
                      <td ><input name="project_name" type="text" value="${project_name }"></td>
                      <td ><label>检查类别:</label></td>
                      <td >
                      <select id="check_type" class="easyui-combobox" name="check_type" style="width:200px;"> 
                      		<option></option>
                          <option  value="月度检查" <c:if test='${check_type=="月度检查" }'>selected="selected"</c:if>>月度检查</option>
                          <option value="年度检查"  <c:if test='${check_type=="年度检查" }'>selected="selected"</c:if>>年度检查</option>
						</select>  
						</td>
                    </tr>
                  </table>
                </div>
              </div>
              <div class="search-button">
                <shiro:hasPermission name="leap:securityCheck:query">
                  <a class="button button_position" href="javascript:document.getElementById('form1').submit()" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:securityCheck:add">
                  <a class="button button_position" href="<%=basePath %>maintain/addCheckInit?tab1PageNum=${tab1PageNum==null?0:tab1PageNum}" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:securityCheck:export">
                  <a class="button button_position" href="javascript:void(0)" id="exportCheckList" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a>
                </shiro:hasPermission>
              </div>
              <div class="clear"></div>
            </div>
          </form>
          <table>
            <thead>
            <tr>
              <th scope="col" class="chebox">项次</th>
              <th  scope="col">检查单编号</th>
              <th  scope="col">项目名称</th>
              <th  scope="col">塔机编号</th>
              <th  scope="col">检查类别</th>
              <th  scope="col">检查人</th>
              <th  scope="col">检查日期</th>
              <th  scope="col">整改单</th>
              <th  scope="col">填表人</th>
              <th  scope="col">填表日期</th>
              <th  scope="col" class="picture2">编辑</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="checkList" items="${checkLists}"  varStatus="status">
            <tr>
              <td class="tbllb">
                    <script type="text/javascript">
                        var num = ${status.index+1}+tab1PageNum * 10;
                        document.write(num);
                    </script>
              </td>
              <td>${checkList.checklisst_no }</td>
              <td>${checkList.project_name }</td>
              <td>${checkList.tower_no }</td>
              <td>${checkList.check_type }</td>
              <td>${checkList.check_by }</td>
              <td><fmt:formatDate value="${checkList.check_date }" pattern="yyyy-MM-dd"/></td>
              <td>${checkList.recttification_no==1?"有":"无" }</td>
              <td>${checkList.guidance_by }</td>
              <td><fmt:formatDate value="${checkList.guidance_date }" pattern="yyyy-MM-dd"/></td>
              <td>
                <shiro:hasPermission name="leap:securityCheck:edit">
                  <a href="<%=basePath %>maintain/editCheckInit?tab1PageNum=${tab1PageNum==null?0:tab1PageNum}&id=${checkList.id }" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" alt="Edit" /></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:securityCheck:delete">
                  <a href="javascript:void(0)" onClick="showdelete(${checkList.id},'tab1',${count})" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" alt="Delete" /></a>
                </shiro:hasPermission>
              </td>
            </tr>
            </c:forEach>
            
            </tbody>
                   <tfoot>
             <tr>
                 <td colspan="11">
                     <div class="bulk-actions align-left">
                         <label>共有<b>${count}</b>条数据</label>
                     </div>
                     <div id="pagination1" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                 </td>
             </tr>
             </tfoot>
          </table>
        </div>
      </shiro:hasPermission>
      </c:if>
      <c:if test='${tab=="tab2" }'>
      <shiro:hasPermission name="leap:equipmentMaintenance">
        <div class="tab-content default-tab"  id="tab2">
       <form action="<%=basePath %>/maintain/init/tab2" id="form2" method="post">
          <input type="hidden" id="tab2PageNum" name="tab2PageNum" value="0">
            <div class="search-actions">
              <div class="search-condition">
                <div class="search-condition-show">
                  <table class="seach-table">
                    <tr>
                      <td><label>塔机编号:</label></td>
                      <td ><input name="tower_no" type="text"  value="${tower_no }"></td>
                      <td ><label>维修日期:</label></td>
                      <td ><input name="maintainStartDate" value="${ maintainStartDate}" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});">
                        <c:if test="${ maintainStartDate != null}">~</c:if>
                        <input name="maintainEndDate" value="${ maintainEndDate}"  readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});"></td>
                    </tr>
                  </table>
                </div>
              </div>
              <div class="search-button">
                <shiro:hasPermission name="leap:equipmentMaintenance:query">
                  <a class="button button_position" href="javascript:document.getElementById('form2').submit()"  title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:equipmentMaintenance:add">
                  <a class="button button_position" href="<%=basePath %>maintain/addMaintainInit" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:equipmentMaintenance:export">
                  <a class="button button_position" href="javascript:void(0)" id="exportMaintain"  title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a>
                </shiro:hasPermission>
              </div>
              <div class="clear"></div>
            </div>
          </form>
          <table>
            <thead>
            <tr>
              <th scope="col" class="chebox">项次</th>
              <th  scope="col">维修单编号</th>
              <th  scope="col">维修类别</th>
              <th  scope="col">维修日期</th>
              <th  scope="col">维修部门</th>
              <th  scope="col">维修资产编号</th>
              <th  scope="col">维修资产数量</th>
              <th  scope="col">维修内容</th>
              <th  scope="col">维修结果</th>
              <th  scope="col" class="picture2">编辑</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${maintainList}" var="maintain" varStatus="status">
            <tr>
              <td class="tbllb">
                      <script type="text/javascript">
                        var num = ${status.index+1}+tab2PageNum * 10;
                        document.write(num);
                    </script>
              </td>
              <td>${maintain.maintain_no }</td>
              <td>${maintain.maintain_type==1?"大修":"项修" }</td>
              <td><fmt:formatDate value="${maintain.maintain_date_start }" pattern="yyyy-MM-dd"/>~<fmt:formatDate value="${maintain.maintain_date_end }" pattern="yyyy-MM-dd"/></td>
              <td>${maintain.maintain_dept }</td>
              <td>${maintain.tower_no }</td>
              <td>${maintain.number }</td>
              <td>${maintain.maintain_content }</td>
              <td>${maintain.check_result }</td>
              <td>
                <shiro:hasPermission name="leap:equipmentMaintenance:edit">
                  <a href="<%=basePath %>maintain/editMaintainInit?tab2PageNum=${tab2PageNum==null?0:tab2PageNum}&id=${maintain.id }" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" alt="Edit" /></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:equipmentMaintenance:delete">
                  <a href="javascript:void(0)" onClick="showdelete(${maintain.id},'tab2',${count})" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" alt="Delete" /></a>
                </shiro:hasPermission>
              </td>
            </tr>
             </c:forEach>
            </tbody>
           <tfoot>
                        <tr>
                            <td colspan="10">
                                <div class="bulk-actions align-left">
                                    <label>共有<b>${count}</b>条数据</label>
                                </div>
                                <div id="pagination2" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                            </td>
                        </tr>
            </tfoot>
          </table>
        </div>
      </shiro:hasPermission>
      </c:if>
      <!-- End #tab1 -->
      <!-- End #tab1 -->
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