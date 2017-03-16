<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath =  path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>塔机动态管理系统</title>
<!--                       CSS                       -->
<!-- 分页css -->
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
<script type="text/javascript" src="<%=basePath %>static/js/calendar.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/paging/jquery.pagination.js"></script>
<SCRIPT src="<%=basePath %>static/js/jQselect.js" type=text/javascript></SCRIPT>
<SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></SCRIPT>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<SCRIPT type=text/javascript>
	//分页,传递只需要页码和每页条数即可
	var currentPage = "${currentPage}"==""?0:"${currentPage}";
	var pageSize =  "${pageSize}"==""?10: "${pageSize}";
	
	//分页点击执行的操作
	function changePage(index){
		$("#currentPage").val(index);
		$("#pageSize").val(pageSize);
		$("#form1").submit();
	}
	
	//分页初始化传入id代表要创建分页的id号，参数count代表总数量，perPage表示每页显示条数,current_page为当前页
	function initPagination(count,perPage,current_page) {
		$("#pagination").pagination(count, {
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
		initPagination("${count}",pageSize,currentPage);
		$("#manageCompany").selectbox();
		
		$("#seq").click(function(){
			$("#form1").submit();
		});
		
		$("#dc").click(function(){
			tatongMethod.confirm("导出","确定要导出吗?",function(){
				$("#form1").attr("action","<%=basePath %>report/createOfferExcel/3");
				$("#form1").submit();
				$("#form1").attr("action","<%=basePath %>report/init/3");
			});
		});
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
        <li><a href="<%=basePath %>report/init/1" > <h4>项目信息汇总表</h4></a></li>
        <!-- href must be unique and match the id of target div -->
        <li> <a href="<%=basePath %>report/init/2"> <h4>塔机动态汇总表</h4></a></li>
         <li> <a href="<%=basePath %>report/init/3" class="default-tab" > <h4>设备闲置报表</h4></a></li>
      </ul>
      <div class="clear"></div>
      <h3></h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
       <div class="tab-content  default-tab" id="tab3">
        <form id="form1" action="<%=basePath %>report/init/3" method="post">
          <input type="hidden" id="currentPage" name="currentPage" value="0"/>
		  <input type="hidden" id="pageSize" name="pageSize" value="10"/>
          <div class="search-actions">
            <div class="search-condition">
              <div class="search-condition-show">
                                <table class="seach-table">
                  <tr>
                    <td><label>管理公司:</label></td>
      <td >
      	<select id="manageCompany" name="manageCompany">
      		<option value="">全部</option>                   
            <c:forEach items="${companylist }" var="c">
            	<option value="${c.companyName }" <c:if test="${manageCompany==c.companyName }">selected="selected"</c:if>>${c.companyName }</option>
            </c:forEach>
      	</select>
	  </td>
      <td ><label>设备编号:</label></td>
      <td ><input type="text" name="towerNo" value="${towerNo }" /></td>
      <td ><label>设备型号:</label></td>
      <td ><input type="text" name="towerClass" value="${towerClass }" /></td>
    </tr>
    
    <tr>
      <td ><label>放置地点:</label></td>
      <td ><input name="repAddress" type="text" value="${repAddress }" ></td>
      <td ><label>截止日期:</label></td>
      <td ><input name="dispatchEndTime" type="text" value="${dispatchEndTime }" readonly onClick="calendar.show(this)"></td>
       <td>&nbsp;</td>
                    <td>&nbsp;</td>
    </tr>
  </table>
 </div>

            </div>
            <div class="search-button">
	            <a id="seq" class="button button_position" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
	            <a id="dc" class="button button_position" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a> 
            </div>
           
            <div class="clear"></div>
          </div>
        </form>
        <table>
          <thead>
          <tr>
            <th scope="col" class="chebox">项次</th>
            <th  scope="col">设备编号</th>
            <th  scope="col" >设备型号</th>
            <th  scope="col">设备状态</th>
            <th  scope="col">放置地点</th>
            <th  scope="col" class="time">闲置日期</th>
            <th  scope="col">闲置天数</th>
            <th  scope="col">租赁意向</th>
            <th  scope="col">产权公司</th>
            <th  scope="col">管理公司</th>
            </tr></thead>
            <tbody>
				<c:forEach items="${list }" var="m" varStatus="status">
            		<tr>
					  <td>${status.index+1+currentPage*pageSize }</td>
					  <td>${m.towerNo }</td>
					  <td>${m.towerClass }</td>
					  <td><c:if test="${m.towerState==2 }">托管</c:if><c:if test="${m.towerState==4 }">闲置</c:if></td>
					  <td>${m.repAddress }</td>
					  <td>${m.dispatchEndTime }</td>
					  <td><c:if test="${m.spareTime>0 }">${m.spareTime}</c:if></td>
					  <td>${m.leaseIntention }</td>
					  <td>${m.rightCompany }</td>
					  <td>${m.manageCompany }</td>
					</tr>
				</c:forEach>
          </tbody>
          <tfoot>
            <tr>
              <td colspan="16"><div class="bulk-actions align-left">
                  <label>共有<b>${count }</b>条数据</label>
                </div>
                <div  id="pagination" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                <!-- End .pagination -->
              </td>
            </tr>
          </tfoot>
        </table>
      </div>
      <!-- End #tab3 -->
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