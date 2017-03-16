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
<link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
<!-- Main Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen" />
<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
<link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/css/select.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery.datePicker.js"></script>
    <script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>static/js/paging/jquery.pagination.js"></script>
        <script src="<%=basePath %>static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></SCRIPT>
    <script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<SCRIPT type=text/javascript>
using(['window']);
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
  if (jq.attr("id") == "pagination3") {
      $("#tab3PageNum").val(index);
      $("#form3").submit();
  }
  if (jq.attr("id") == "pagination4") {
      $("#tab4PageNum").val(index);
      $("#form4").submit();
  }
  if (jq.attr("id") == "pagination5") {
      $("#tab5PageNum").val(index);
      $("#form5").submit();
  }
}

function getExcel1(){
	location.href="<%=basePath%>report/getExcel1";
}
function getExcel2(){
	location.href="<%=basePath%>report/getExcel2";
}
function getExcel3(){
	location.href="<%=basePath%>report/getExcel3";
}
function getExcel4(){
	location.href="<%=basePath%>report/getExcel4";
}
function getExcel5(){
	location.href="<%=basePath%>report/getExcel5";
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
      //ajax加载数据
      initPagination("pagination2", "${count}", 10, tab2PageNum);
  }
  if (tab == "tab3") {
      initPagination("pagination3", "${count}", 10, tab3PageNum);
  }
  if (tab == "tab4") {
      initPagination("pagination4", "${count}", 10, tab4PageNum);
  }
  if (tab == "tab5") {
      initPagination("pagination5", "${count}", 10, tab5PageNum);
  }
}



var tab1PageNum = "${tab1PageNum}" == "" ? 0 : "${tab1PageNum}";
var tab2PageNum = "${tab2PageNum}" == "" ? 0 : "${tab2PageNum}";
var tab3PageNum = "${tab3PageNum}" == "" ? 0 : "${tab3PageNum}";
var tab4PageNum = "${tab4PageNum}" == "" ? 0 : "${tab4PageNum}";
var tab5PageNum = "${tab5PageNum}" == "" ? 0 : "${tab5PageNum}";

$(document).ready(function() {
      //控制显示的面板
      var tab = "${tab}"
      //根据点击的id发送请求
      $(".atab").on("click", function () {
          var url = "<%=basePath %>report/init/" + $(this).attr("name");
          if ($(this).attr("name") == "tab1") {
              url += "?tab1PageNum=" + tab1PageNum ;
          }
          if ($(this).attr("name") == "tab2") {
              url += "?tab2PageNum=" + tab2PageNum;
          }
          if ($(this).attr("name") == "tab3") {
              url += "?tab3PageNum=" + tab3PageNum;
          }
          if ($(this).attr("name") == "tab4") {
              url += "?tab4PageNum=" + tab4PageNum;
          }
          if ($(this).attr("name") == "tab5") {
              url += "?tab5PageNum=" + tab5PageNum;
          }
          location.href = url;
      })
      togle(tab);
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
        <li><a id="atab1" href="#tab1" name="tab1" class="atab"> <h4>项目信息汇总表</h4></a></li>
        <!-- href must be unique and match the id of target div -->
        <li> <a id="atab2" href="#tab2" name="tab2" class="atab"> <h4>设备整机动态表</h4></a></li>
        <li> <a  id="atab3" href="#tab3" name="tab3"  class="atab"> <h4>设备配置动态表</h4></a></li>
        <li> <a id="atab4" href="#tab4" name="tab4" class="atab"> <h4>总公司查询设备动态表</h4></a></li>
         <li> <a id="atab5"  href="#tab5" name="tab5" class="atab"> <h4>设备闲置报表</h4></a></li>
      </ul>
      <div class="clear"></div>
      <h3></h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <c:if test='${tab== "tab1"}'>
      <div class="tab-content default-tab" id="tab1">
      <form id="form1" action="<%=basePath %>report/init/tab1" method="post">
       <input type="hidden" id="tab1PageNum" name="tab1PageNum" value="0">
          <div class="search-actions">
            <div class="search-condition">
              <div class="search-condition-show">
                <table class="seach-table">
                  <tr>
                    <td><label>所属公司:</label></td>
      <td>
            <select class="easyui-combobox" name="rightCompanyId" id="rightCompanyId">
	      		<option value="" >不限</option>
      		<c:forEach var="company" items="${companyList }">
	      		<option value="${company.id }" <c:if test="${ company.id ==rightCompanyId}">selected="selected"</c:if>>${company.shortName }</option>
      		</c:forEach>
      		</select>
      
      </td>
      <td ><label>项目名称:</label></td>
      <td ><input name="pro_name" type="text" value="${pro_name }"></td>
      <td ><label>客户名称:</label></td>
      <td ><input name="Input" type="text" ></td>
    </tr>
     </table>
              </div>
              <div id="search-condition-hidden">
                <table class="seach-table">
    <tr>
      <td ><label>合同编号:</label></td>
      <td ><input name="contract_no" type="text" value="${contract_no }"></td>
      <td ><label>截止日期:</label></td>
      <td ><input name="stop_rent_time" value="${ stop_rent_time}" type="text" readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"></td>
      <td><label>项目状态:</label></td>
      <td >
      		<select class="easyui-combobox"  name="pro_status"  >
      		<option value="">不限</option>
      		<c:forEach items="${proStatusList }"  var="proStatus">
      		<option value="${proStatus.dict_name }" <c:if test="${proStatus.dict_name== pro_status}">selected="selected"</c:if>>${proStatus.dict_value }</option>
      		</c:forEach>
      		</select>
	</td>
    </tr>
  </table>
 </div>
            </div>
            <div class="search-button">     <a class="button button_position"
                                           onclick="document.getElementById('form1').submit();return false"
                                           href="javascript:void(0)" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a><a class="button button_position" href="javascript:void(0)" onclick="getExcel1()" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a> </div>
           
            <div class="clear"></div>
          </div>
        </form>
        <table>
          <thead>
            <tr>
            <th rowspan="2" class="chebox" scope="col">项次</th>
            <th rowspan="2"  scope="col" >合同编号</th>
            <th rowspan="2"  scope="col">设备编号</th>
            <th rowspan="2"  scope="col" >设备型号</th>
            <th rowspan="2"  scope="col" >承租单位</th>
            <th rowspan="2"  scope="col" >项目名称</th>
            <th rowspan="2"  scope="col" >起租日期</th>
            <th rowspan="2"  scope="col" >停租日期</th>
            <th colspan="3"  scope="col" >项目地点</th>
            <th colspan="3"  scope="col" >方案配置</th>
            <th rowspan="2"  scope="col">所属公司</th>
            <th rowspan="2"  scope="col">管理部门</th>
            </tr>
            <tr>
              <th  scope="col" >所在区域</th>
              <th  scope="col" >省份</th>
              <th  scope="col" >城市</th>
              <th  scope="col" >设备形式</th>
              <th  scope="col" >方案高度</th>
              <th  scope="col">大臂长度</th>
            </tr>
            </thead><tbody>
            <c:forEach var="tower" items="${proTowers }" varStatus="status">
            		<tr>
				  <td>
				  		<script type="text/javascript">
	                    var num = ${status.index+1}+tab4PageNum * 10;
	                    document.write(num);
	                </script>
				  </td>
				  <td>${tower.contract_no }</td>
				  <td>${tower.tower_manage_no }</td>
				  <td>${tower.tower_model }</td>
				  <td>${tower.customer_cn_name }</td>
				  <td>${tower.pro_name }</td>
				  <td>${tower.rent_time }</td>
				  <td>${tower.stop_rent_time }</td>
				  <td>${tower.area }</td>
				  <td>${tower.province }</td>
				  <td>${tower.city }</td>
				  <td>${tower.tower_class }</td>
				  <td>${tower.fagd }</td>
				  <td>${tower.dbcd }</td>
				  <td>${tower.company_short_name }</td>
				  <td>${tower.department_name }</td>
				  </tr>
            </c:forEach>
               </tbody>
               <tfoot>
               <tr>
                   <td colspan="17">
                       <div class="bulk-actions align-left">
                           <label>共有<b>${count}</b>条数据</label>
                       </div>
                       <div id="pagination1" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                   </td>
               </tr>
               </tfoot>
        </table>
      </div>
      </c:if>
      <!-- End #tab1 -->
      <c:if test='${tab== "tab2"}'>
        <div class="tab-content" id="tab2">
        <form id="form2" action="<%=basePath %>report/init/tab2" method="post">
       <input type="hidden" id="tab2PageNum" name="tab2PageNum" value="0">
          <div class="search-actions">
            <div class="search-condition">
                <table class="seach-table">
                  <tr>
                    <td><label>管理公司:</label></td>
      <td >
                <select class="easyui-combobox" name="rightCompanyId" id="rightCompanyId">
	      		<option value="" >不限</option>
      		<c:forEach var="company" items="${companyList }">
	      		<option value="${company.id }" <c:if test="${ company.id ==rightCompanyId}">selected="selected"</c:if>>${company.shortName }</option>
      		</c:forEach>
      		</select>
      </td>
      <td><label>截止日期:
        </label></td>
              <td ><input name="endTime" value="${endTime }" type="text" value="${aaendTime }"readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"></td>
      </tr>
  </table>

            </div>
            <div class="search-button"> <a class="button button_position"  onclick="document.getElementById('form2').submit();return false"
                                           href="javascript:void(0)" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a><a class="button button_position" href="javascript:void(0)" onclick="getExcel2()" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a> </div>
            <div class="clear"></div>
          </div>
        </form>
        <table>
          <thead>
          <tr>
            <th scope="col" class="chebox">项次</th>
            <th  scope="col">设备编号</th>
            <th  scope="col" >设备来源</th>
            <th  scope="col" >设备型号</th>
            <th  scope="col" >出厂编号</th>
            <th  scope="col" >额定起重力矩</th>
            <th  scope="col" >塔身/平衡臂颜色</th>
            <th  scope="col" >容绳量</th>
            <th  scope="col" >起重臂（米）</th>
            <th  scope="col" >项目(仓库)地点/名称</th>
            <th  scope="col" >项目类别</th>
            <th  scope="col" >所在地理区域</th>
            <th  scope="col">所在市县</th>
            <th  scope="col">所属分公司/区域公司</th>
            <th  scope="col">状态</th>
            <th  scope="col">在使用设备合同计划停租日</th>
            <th  scope="col">闲置设备      停租日</th>
            <th  scope="col">租赁意向</th>
            <th  scope="col">项目名称</th>
            <th  scope="col">承租单位</th>
            <th  scope="col">项目所在地</th>
            <th  scope="col">预计进场时间</th>
            <th  scope="col">租赁周期</th>
            <th  scope="col">月租单价</th>
            <th  scope="col">进出场费</th>
            <th  scope="col">合同租金</th>
            <th  scope="col">备注</th>
            </tr></thead>
            <tbody>
           <c:forEach var="tower" items="${dynamicTowerList }" varStatus="status">
            		<tr>
				  <td>
				  		<script type="text/javascript">
	                    var num = ${status.index+1}+tab4PageNum * 10;
	                    document.write(num);
	                </script>
				  </td>
		  <td>${tower.tower_manage_no }</td>
		  <td>${tower.tower_source }</td>
		  <td>${tower.tower_model }</td>
		  <td>${tower.tower_factoryno }</td>
		  <td>${tower.qzlj }</td>
		  <td>没有起重臂颜色</td>
		  <td>${tower.qzljsl }</td>
		  <td>${tower.boom_length }</td>
		  <td>${tower.address }</td>
		  <td>${tower.proType }</td>
		  <td>${tower.areaName }</td>
		  <td>${tower.cityName }</td>
		  <td>${tower. company_short_name}</td>
		  <td>
		  		<script type="text/javascript">
						var status =   '${tower.tower_manage_state }';
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
		  <td>${tower.stopDay }</td>
		  <td>${tower.lease_endtime }</td>
		  <td>${tower.lease_intention }</td>
		  <td>${tower.pro_name }</td>
		  <td>${tower.customer_cn_name }</td>
		  <td>${tower.pro_address }</td>
		  <td>${tower.lease_starttime }</td>
		  <td></td>
		  <td></td>
		  <td></td>
		  <td></td>
		  <td></td>
		  </tr>
		  </c:forEach>
       
              </tbody>
                             <tfoot>
                            <tr>
                                <td colspan="27">
                                    <div class="bulk-actions align-left">
                                        <label>共有<b>${count}</b>条数据</label>
                                    </div>
                                    <div id="pagination2" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                                </td>
                            </tr>
               </tfoot>
        </table>
      </div>
      </c:if>
      <!-- End #tab2 -->
      <c:if test='${tab== "tab3"}'>
       <div class="tab-content" id="tab3">
        <form id="form3" action="<%=basePath %>report/init/tab3" method="post">
      		<input type="hidden" id="tab3PageNum" name="tab3PageNum" value="0">
          <div class="search-actions">
            <div class="search-condition">
                <table class="seach-table">
                  <tr>
                    <td><label>管理公司:</label></td>
      <td >
                  <select class="easyui-combobox" name="rightCompanyId" id="rightCompanyId">
	      		<option value="" >不限</option>
      		<c:forEach var="company" items="${companyList }">
	      		<option value="${company.id }" <c:if test="${ company.id ==rightCompanyId}">selected="selected"</c:if>>${company.shortName }</option>
      		</c:forEach>
      		</select>
      </td>
      <td><label>截止日期:
        </label>
        </td>
            <td ><input name="endTime" value="${endTime }" type="text" value="${aaendTime }"readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"></td>
      </tr>
  </table>

            </div>
            <div class="search-button"> <a class="button button_position"  onclick="document.getElementById('form3').submit();return false"
                                           href="javascript:void(0)"  title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a><a class="button button_position" href="javascript:void(0)" onclick="getExcel3()" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a> </div>
            <div class="clear"></div>
          </div>
        </form>
        <table>
                 <thead>
          <tr>
            <th scope="col" class="chebox">项次</th>
            <th  scope="col">设备编号</th>
            <th  scope="col" >设备来源</th>
            <th  scope="col" >设备型号</th>
            <th  scope="col" >出厂编号</th>
            <th  scope="col">项目(仓库)地点/名称</th>
            <th  scope="col">执行状况</th>
            <th  scope="col">基础节/过渡节</th>
             <th  scope="col">起重臂</th>
            <th  scope="col">标准节</th>
            <th  scope="col">附墙框</th>
            <th scope="col">配重</th>
            <th scope="col">行走机构/内爬机构</th>
            <th  scope="col">备注</th>
            </tr></thead>
            <tbody>
            <c:forEach var="tower" varStatus="status" items="${towerList }">
            	<tr>
					  <td>
                       <script type="text/javascript">
                              var num = ${status.index+1}+tab3PageNum * 10;
                              document.write(num);
                          </script>
					  </td>
					  <td>${tower.tower_manage_no }</td>
					  <td>${tower.tower_source }</td>
					  <td>${tower.tower_model }</td>
					  <td>${tower.tower_factoryno }</td>
					  <td>${tower.comeaddress }</td>
					  <td>
					  <script type="text/javascript">
						var status =   '${tower.tower_manage_state }';
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
					  <td>&nbsp;</td>
					  <td>&nbsp;</td>
					  <td>&nbsp;</td>
					  <td>&nbsp;</td>
					  <td>&nbsp;</td>
					  <td>&nbsp;</td>
					  <td>${tower.memo }</td>
			 </tr>
            </c:forEach>

              </tbody>
                             <tfoot>
                            <tr>
                                <td colspan="17">
                                    <div class="bulk-actions align-left">
                                        <label>共有<b>${count}</b>条数据</label>
                                    </div>
                                    <div id="pagination3" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                                </td>
                            </tr>
               </tfoot>
        </table>
      </div>
      </c:if>
      <!-- End #tab3 -->
      <c:if test='${tab== "tab4"}'>
 <div class="tab-content" id="tab4">
     <form id="form4" action="<%=basePath %>report/init/tab4" method="post">
       <input type="hidden" id="tab4PageNum" name="tab4PageNum" value="0">
          <div class="search-actions">
            <div class="search-condition">
                <table class="seach-table">
                  <tr>
                    <td><label>管理公司:</label></td>
      <td >
          <select class="easyui-combobox" name="rightCompanyId" id="rightCompanyId">
	      		<option value="" >不限</option>
      		<c:forEach var="company" items="${companyList }">
	      		<option value="${company.id }" <c:if test="${ company.id ==rightCompanyId}">selected="selected"</c:if>>${company.shortName }</option>
      		</c:forEach>
      		</select>
      
      </td>
      <td><label>截止日期:
        </label></td>
            <td ><input name="endTime" value="${endTime }" type="text" value="${aaendTime }"readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"></td>
      </tr>
  </table>

            </div>
            <div class="search-button"> <a class="button button_position" onclick="document.getElementById('form4').submit();return false"
                                           href="javascript:void(0)"  title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a><a class="button button_position" href="javascript:void(0)" onclick="getExcel4()" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a> </div>
            <div class="clear"></div>
          </div>
        </form>
        <table>
          <thead>
          <tr>
            <th scope="col" class="chebox">项次</th>
            <th  scope="col">设备编号</th>
            <th  scope="col" >设备来源</th>
            <th  scope="col" >设备型号</th>
            <th  scope="col" >出厂编号</th>
            <th  scope="col" >额定起重力矩</th>
            <th  scope="col" >塔身/平衡臂颜色</th>
            <th  scope="col" >容绳量</th>
            <th  scope="col" >起重臂（米）</th>
            <th  scope="col" >项目(仓库)地点/名称</th>
            <th  scope="col" >项目类别</th>
            <th  scope="col" >所在地理区域</th>
            <th  scope="col">所在城市</th>
            <th  scope="col">所属分公司/区域公司</th>
            <th  scope="col">执行状况</th>
            <th  scope="col">在使用设备合同计划停租日</th>
            <th  scope="col">备注</th>
            </tr></thead>
            <tbody>
            <c:forEach var="tower" varStatus="status" items="${towerList }">
            		<tr>
		  <td>
		             <script type="text/javascript">
                              var num = ${status.index+1}+tab4PageNum * 10;
                              document.write(num);
                     </script>
		  </td>
		  <td>${tower.tower_manage_no }</td>
		  <td>${tower.tower_source }</td>
		  <td>${tower.tower_model }</td>
		  <td>${tower.tower_factoryno }</td>
		  <td>${tower.qzlj }</td>
		  <td>${tower.phbys }</td>
		  <td>${tower.qzljsl }</td>
		  <td>${tower.qzbcd }</td>
		  <td>${tower.address }</td>
		  <td>
	${tower.proType }
		  </td>
		  <td>${tower.area }</td>
		  <td>${tower.city }</td>
		  <td>${tower.company_short_name }</td>
		  <td>
		  <script type="text/javascript">
						var status =   '${tower.tower_manage_state }';
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
		  <td>${tower.lease_endtime }</td>
		  <td></td>
		  </tr>
            </c:forEach>
            

              </tbody>
                             <tfoot>
                            <tr>
                                <td colspan="17">
                                    <div class="bulk-actions align-left">
                                        <label>共有<b>${count}</b>条数据</label>
                                    </div>
                                    <div id="pagination4" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                                </td>
                            </tr>
               </tfoot>
        </table>
      </div>
      </c:if>
      <!-- End #tab4 -->
       <c:if test='${tab== "tab5"}'>
       <div class="tab-content" id="tab5">
        <form id="form5" action="<%=basePath %>report/init/tab5" method="post">
       <input type="hidden" id="tab5PageNum" name="tab5PageNum" value="0">
          <div class="search-actions">
            <div class="search-condition">
              <div class="search-condition-show">
                                <table class="seach-table">
                  <tr>
                    <td><label>管理公司:</label></td>
      <td >
      		<select class="easyui-combobox" name="companyId" id="companyId">
	      		<option value="" >不限</option>
      		<c:forEach var="company" items="${companyList }">
	      		<option value="${company.id }" <c:if test="${ company.id ==companyId}">selected="selected"</c:if>>${company.shortName }</option>
      		</c:forEach>
      		</select>
      </td>
      <td ><label>设备编号:</label></td>
      <td >
            <select class="easyui-combobox" name="tower_no" id="tower_no">
            <option value="" >不限</option>
      		<c:forEach var="oneTowerNo" items="${towerNoList }">
	      		<option value="${oneTowerNo.tower_no }" <c:if test="${ oneTowerNo.tower_no==tower_no}">selected="selected"</c:if>>${oneTowerNo.tower_no }</option>
      		</c:forEach>
      		</select>
      </td>
      <td ><label>设备型号:</label></td>
                    <td >
		            <select class="easyui-combobox" name="towerModel" id="towerModel">
		            <option value="" >不限</option>
		      		<c:forEach var="onewTowerModel" items="${towerModelList }">
			      		<option value="${onewTowerModel.dict_value }"  <c:if test="${onewTowerModel.dict_value==towerModel}">selected="selected"</c:if>>${onewTowerModel.dict_value }</option>
		      		</c:forEach>
		      		</select>
                    </td>
    </tr>
    
    <tr>
      <td ><label>放置地点:</label></td>
      <td ><input name="address" type="text"  value="${address }"></td>
      <td ><label>截止日期:</label></td>
      <td ><input name="endTime" value="${endTime }" type="text" value="${aaendTime }"readonly="readonly" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"></td>
       <td>&nbsp;</td>
                    <td>&nbsp;</td>
    </tr>
  </table>
 </div>

            </div>
            <div class="search-button"> <a class="button button_position"
                                           onclick="document.getElementById('form5').submit()"
                                           href="javascript:void(0)" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a><a class="button button_position" href="javascript:void(0)" onclick="getExcel5()" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a> </div>
           
            <div class="clear"></div>
          </div>
        </form>
        <table>
          <thead>
          <tr>
            <th scope="col" class="chebox">项次</th>
            <th  scope="col">设备编号</th>
            <th  scope="col" >设备型号</th>
            <th  scope="col">执行状况</th>
            <th  scope="col">放置地点</th>
            <th  scope="col" class="time">闲置日期</th>
            <th  scope="col">闲置天数</th>
            <th  scope="col">租赁意向</th>
            <th  scope="col">产权公司</th>
            <th  scope="col">所属公司</th>
            </tr></thead>
            <tbody>
            <c:forEach var="tower" items="${towerList }"  varStatus="status">
            	<tr>
				  <td>
                       <script type="text/javascript">
                              var num = ${status.index+1}+tab5PageNum * 10;
                              document.write(num);
                          </script>
				  </td>
				  <td>${tower.tower_no }</td>
				  <td>${tower.tower_model }</td>
				  <td>${tower.tower_manage_state==1?"闲置":"托管" }</td>
				  <td>${tower.address }</td>
				  <td>${tower.idleday }</td>
				  <td>${tower.days}</td>
				  <td>${tower.lease_intention }</td>
				  <td>${tower.rightCompany }</td>
				  <td>${tower.managerCompany }</td>
				  </tr>
            </c:forEach>
              </tbody>
                             <tfoot>
                            <tr>
                                <td colspan="10">
                                    <div class="bulk-actions align-left">
                                        <label>共有<b>${count}</b>条数据</label>
                                    </div>
                                    <div id="pagination5" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                                </td>
                            </tr>
               </tfoot>
        </table>
      </div>
      </c:if>
      <!-- End #tab3 -->
    </div>
    <!-- End .content-box-content -->
  </div>
  <!-- End .content-box -->
  <div class="clear"></div>
</div>
<!-- End #main-content -->
<div id="footer"> <small> Copyright © 2015 上海乔罗网络科技有限公司 </small> </div>
<!-- End #footer -->
</body>
</html>

