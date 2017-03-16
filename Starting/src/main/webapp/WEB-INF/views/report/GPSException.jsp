<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
    <SCRIPT src="<%=basePath %>static/js/jQselect.js" type=text/javascript></SCRIPT>
    <SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></SCRIPT>
    <script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<SCRIPT type=text/javascript>
using(['window']);

function changePage(index, jq) {
    if (jq.attr("id") == "pagination6") {
        $("#tab6PageNum").val(index);
        $("#form6").submit();
    }
}

function getExcel4(){
	location.href="<%=basePath%>report/getExcel6";
}
var tab6PageNum = "${tab6PageNum}" == "" ? 0 : "${tab6PageNum}";
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
		initPagination("pagination6", "${count}", 10, tab6PageNum);
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
      <h3>GPS回报异常警报汇总表</h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form id="form6" action="<%=basePath %>report/init/tab6" method="post">
       <input type="hidden" id="tab6PageNum" name="tab6PageNum" value="0">
          <div class="search-actions">
            <div class="search-condition">
                <table class="seach-table">
                  <tr>
                    <td><label>管理公司:</label></td>
      <td >  <select class="easyui-combobox" name="companyId" id="companyId">
	      		<option value="" >不限</option>
      		<c:forEach var="company" items="${companyList }">
	      		<option value="${company.id }" <c:if test="${ company.id ==companyId}">selected="selected"</c:if>>${company.shortName }</option>
      		</c:forEach>
      		</select></td>
     
      <td ><label>回报状态超过:
        </label></td>
      <td ><input type="text" name="abnormal"  value="${abnormal }"/>小时</td>
      </tr>
  </table>

            </div>
            <div class="search-button"> <a class="button button_position"
                                           onclick="document.getElementById('form4').submit();return false"
                                           href="javascript:void(0)" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a><a class="button button_position" href="javascript:void(0)" onclick="getExcel4()" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a> </div>
            <div class="clear"></div>
          </div>
        </form>
        <table>
          <thead>
          <tr>
            <th scope="col" class="chebox">项次</th>
            <th  scope="col">塔机编号</th>
            <th  scope="col" >塔机型号</th>
            <th  scope="col">SIM卡号</th>
            <th  scope="col">执行状况</th>
            <th  scope="col" class="time">最后回报时间</th>
            <th  scope="col">产权公司</th>
            <th  scope="col">管理公司</th>
            </tr></thead>
            <tbody>
            <c:forEach items="${towerList }" var="tower" varStatus="status">
            		<tr>
				  <td>
					<script type="text/javascript">
	                    var num = ${status.index+1}+tab6PageNum * 10;
	                    document.write(num);
	                </script>
				  </td>
				  <td>${tower.tower_no }</td>
				  <td>${tower.tower_model }</td>
				  <td>${tower.sim_number }</td>
				  <td>
				  	  <script type="text/javascript">
					  var status = '${tower.tower_manage_state }';
					  var statusStr="";
					  switch (status) {
						case '1':
							statusStr="闲置";
							break;
						case '2':
							statusStr="未启用";
							break;
						case '3':
							statusStr="在使用";
							break;
						case '4':
							statusStr="冬停";
							break;
						case '5':
							statusStr="托管";
							break;
						}
					  document.write(statusStr);
					  </script>
				  </td>
				  <td><fmt:formatDate value="${tower.lasttime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				  <td>${tower.rightCompany }</td>
				  <td>${tower.manageCompany }</td>
				  </tr>
            </c:forEach>
               </tbody>
                 <tfoot>
               <tr>
                   <td colspan="8">
                       <div class="bulk-actions align-left">
                           <label>共有<b>${count}</b>条数据</label>
                       </div>
                       <div id="pagination6" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                   </td>
               </tr>
               </tfoot>
        </table>
      </div>
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
