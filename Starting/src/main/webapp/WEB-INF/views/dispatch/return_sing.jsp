<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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
</head><body>
<div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>归还单签核</h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form action="" method="post">
          <table  class="edit-table" border="0">
          <tr>
              <th scope="row">归还单号</th>
              <td><input name="Input2" type="text"  readonly="readonly" value="D131000397"/></td>
              <td>&nbsp;</td>
              </tr>
              <tr>
               <th scope="row">装车单</th>
              <td align="center">
                <img width="100px" height="100px"/> </td>
             <td>&nbsp;</td>
         </table>
         <P><b>归还目的地</b></P>
          <table border="0"  class="edit-table">
            <tr>
              <th  scope="row">归还地点</th>
              <td><input name="Input" type="text" value="上海四建崇明百联项目"  readonly="readonly"/></td>
              <th >处置形式</th>
              <td ><input name="Input6" type="text" readonly="readonly"/></td>
            </tr>
            <tr>
              <th>合同编号
                <label></label></th>
              <td><input name="Input5" type="text" readonly="readonly" value="THZM090530-F-001"/></td>
              <th>归还时间</th>
              <td><input name="Input" type="text" value="2014-1-1"readonly="readonly"/></td>
            </tr>
            <tr>
              <th>起止地址</th>
              <td><input name="Input3" type="text" value="上海" readonly="readonly" width="100"/>
                -&gt;
                <input name="Input4" type="text"  value="北京" readonly="readonly" width="100"/></td>
              <th>&nbsp;</th>
              <td>&nbsp;</td>
            </tr>
          </table>
          <P><b>塔机资料</b></P>
          <table >
            <thead>
              <tr>
                <th  scope="col">塔机编号</th>
                <th  scope="col">塔机型号</th>
                <th  scope="col">塔机来源</th>
                <th  scope="col">塔机产权公司</th>
                <th  scope="col">塔机管理公司</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>BJTHZ008</td>
                <td>STT293-18T</td>
                <td>自有</td>
                <td>北京达丰</td>
                <td>北京达丰</td>
              </tr>
            </tbody>
          </table>
          <P><b>零部件资料</b></P>
          <table>
            <thead>
              <tr>
                <th  scope="col">零部件名称</th>
                <th  scope="col">零部件型号</th>
                <th  scope="col">零部件编号</th>
                <th  scope="col">对应塔机型号</th>
                <th  scope="col">数量</th>
                <th  scope="col" >单位</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>基础节</td>
                <td>L68B1</td>
                <td>BJTHZ008001</td>
                <td>1</td>
                <td>1</td>
                <td>节</td>
              </tr>
              <tr>
                <td>过渡节</td>
                <td>L46A1</td>
                <td>BJTHZ008002</td>
                <td>12</td>
                <td>1</td>
                <td>节</td>
              </tr>
            </tbody>
             <tfoot>
            <tr>
              <td colspan="6"><div class="bulk-actions align-left">
                  <label>共有<b>200</b>条数据</label>
                </div>
                <div class="pagination"> <a href="#" title="First Page">|&lt;</a><a href="#" title="Previous Page">&lt;</a> <a href="#" class="number current" title="1">1</a> <a href="#" class="number" title="2">2</a> <a href="#" class="number" title="3">3</a> <a href="#" class="number" title="4">4</a> <a href="#" title="Next Page">&gt;</a><a href="#" title="Last Page">&gt;|</a> </div>
                <!-- End .pagination -->
                <div class="clear"></div></td>
            </tr>
          </tfoot>
          </table>
         <table>
             <tr>
              <td></td>
              <td >
              <a class="button_new" href="#" onclick="window.close()" title="agree"><img src="<%=basePath %>static/images/icons/agree_icon.png" class="px18"/></a>
              <a class="button_new" href="#" onclick="window.close()" title="disagree"><img src="<%=basePath %>static/images/icons/disagree_icon.png" class="px18"/></a>
              
             <a class="button_new" href="#" onclick="window.close()" title="close"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a> </td>
            </tr>
          </table>
        </form>
      </div>
      </div>
  </div>
</div>
</body>
</html>