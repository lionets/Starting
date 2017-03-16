<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath =  path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>塔机动态管理系统</title>
<!--                       CSS                       -->
<!-- Reset Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
<!-- Main Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen" />
<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
<link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/css/select.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/facebox.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery.wysiwyg.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery.datePicker.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery.date.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/calendar.js"></script>
<SCRIPT src="<%=basePath %>static/js/jquery.js" type=text/javascript></SCRIPT>
<SCRIPT src="<%=basePath %>static/js/jQselect.js" type=text/javascript></SCRIPT>
<SCRIPT type=text/javascript>
	$(document).ready(function() {
		$("#a").selectbox();
		$("#b").selectbox();
		$("#c").selectbox();
		$("#d").selectbox();
		$("#e").selectbox();
		$("#f").selectbox();
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
      <h3>查看资产到货信息</h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <div class="search-actions">
          <div class="search-condition-show">
              <table class="edit-table">
                <tr>
                  <th>合同编号</th>
                  <td ><label>001Z0001</label></td>
                </tr>
                <tr>
                  <th >签订日期
                    </th>
                  <td ><label>2011-03-02</label></td>
                </tr>
                <tr>
                  <th >所属公司</th>
                  <td ><label>北京达丰</label></td>
                </tr>
                <tr>
                  <th>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</th>
                  <td >&nbsp;</td>
                </tr>
              </table>
            </div>
       
        <p>  <b> 塔机信息</b></p>
          <table>
            <thead>
              <tr>
                <th scope="col" class="chebox">项次</th>
                <th  scope="col">资产名称</th>
                <th  scope="col">生产厂家</th>
                <th  scope="col">塔机编号</th>
                <th  scope="col">出厂编号</th>
                <th  scope="col">规格型号</th>
                <th  scope="col">塔机样式</th>
                <th  scope="col">数量</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>1</td>
                <td>塔式起重机</td>
                <td>抚顺永茂</td>
                <td> 087101Z562D </td>
                <td> 2010H492 </td>
                <td>F0/23B-10T</td>
                <td>固定式</td>
                <td>1</td>
              </tr>
              <tr>
                <td>2</td>
                <td>塔式起重机</td>
                <td>抚顺永茂</td>
                <td> 087101Z563D </td>
                <td> 2010H493</td>
                <td>ST55/13-6T</td>
                <td>固定式</td>
                <td>1</td>
              </tr>
            </tbody>
            <tfoot>
              <tr>
                <td colspan="15"><div class="bulk-actions align-left">
                    <label>共有塔机：<b>2</b>台</label>
                  </div>
                   <div class="pagination"> <a href="#" title="First Page">|&lt;</a><a href="#" title="Previous Page">&lt;</a> <a href="#" class="number current" title="1">1</a> <a href="#" class="number" title="2">2</a> <a href="#" class="number" title="3">3</a> <a href="#" class="number" title="4">4</a> <a href="#" title="Next Page">&gt;</a><a href="#" title="Last Page">&gt;|</a> </div></td></tr></tfoot></table>
          </table>
          <p>  <b>  零部件信息</b></p>
          <table>
            <thead>
              <tr>
                <th scope="col" class="chebox">项次</th>
                <th  scope="col">零部件名称</th>
                <th  scope="col">零部件型号</th>
                <th  scope="col">数量</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>1</td>
                <td>标准节</td>
                <td>&nbsp;</td>
                <td>1</td>
              </tr>
            </tbody>
            <tfoot>
              <tr>
                <td colspan="4"><div class="bulk-actions align-left">
                    <label>共有零部件：<b>200</b></label>
                  </div>
                  <div class="pagination"> <a href="#" title="First Page">|&lt;</a><a href="#" title="Previous Page">&lt;</a> <a href="#" class="number current" title="1">1</a> <a href="#" class="number" title="2">2</a> <a href="#" class="number" title="3">3</a> <a href="#" class="number" title="4">4</a> <a href="#" title="Next Page">&gt;</a><a href="#" title="Last Page">&gt;|</a> </div>
                  <!-- End .pagination -->
                  <div class="clear"></div></td>
              </tr>
            </tfoot>
          </table>
        </div>
        <div class="caozuobc"> <a class="button_new" href="#" onclick="window.close()" title="close"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a></div>
      </div>
    </div>
  </div>
</div>
</body>
</html>