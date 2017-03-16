<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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
<!-- Reset Stylesheet -->
    <link rel="stylesheet" type="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/icon.css">
    <link rel="stylesheet" href="<%=basePath %>static/js/paging/pagination.css" />
    <link rel="stylesheet" type="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/default/easyui.css">
<link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
<!-- Main Stylesheet -->
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
<script type="text/javascript" src="<%=basePath %>static/js/jquery.datePicker.js"></script>

</head>
<body>
<jsp:include page="../header-bar.jsp"/>
<div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>归还外租资产</h3>
    </div>
    <!-- End .content-box-header -->
     <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form action="" method="post">
          <table border="0" class="edit-table">
            <tr>
              <th scope="row">外租合同编号</th>
              <td ><input name="" type="text" /> <a class="button1 button_position" onClick="openwin1()" title="查询"><img src="<%=basePath%>static/images/icons/search_icon.png" class="px18"/></a>              </td>
              <th scope="row">归还时间</th>
              <td><input name="Input" type="text" onclick="new Calendar().show(this);" readonly="readonly"/></td>
              
            </tr>
            <tr>
            <th scope="row">所属公司</th>
              <td>常州达丰</td>
             
              <th scope="row">&nbsp;</th>
              <td>&nbsp;</td>
           
            </tr>
          </table>
<P><b>归还资产</b><label style="padding-left:61px"> <b style="color:#FF0000">*</b>发出地</label><label style="padding-left:20px">北京仓库</label></P>
          <table >
            <thead>
              <tr>
                <th  scope="col" class="chebox">&nbsp;</th>
                <th  scope="col">资产名称</th>
                <th  scope="col">塔机编号</th>
                <th  scope="col">塔机型号</th>
                <th  scope="col">出厂编号</th>
                <th  scope="col">塔机来源</th>
                <th  scope="col">所属公司</th>
                <th  scope="col">管理公司</th>
                <th  scope="col">管理单位</th>
                <th  scope="col" class="picture2"></th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td><div align="center">1</div></td>
                <td width="94">塔式起重机</td>
                <td width="94">BJTHZ081</td>
                <td width="78"><div align="center">ST70/30-12T</div></td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td><div align="center"><a onclick="openwin2()" title="归还资产"><img src="<%=basePath%>static/images/icons/pencil.png" /></a> <a href="#" onclick="showdelete()" ><img src="<%=basePath%>static/images/icons/cross.png" alt="Delete" /></a></div></td>
              </tr>
            </tbody>
          </table>
         <br/>
             <table border="0"  class="edit-table">
           
            <tr>
              <th  scope="row">上传</th>
              <td width="250" ><label>名称</label>
                <input name="Input29" type="text" />
                <a class="button_new" href="#" title="上传">上传</a>
                <br/><br/>
              <img style="width:100px; height:100px; padding-left:30px;"/> </td>
              <td><table>
                <thead >
                  <tr>
                    <td scope="col" class="chebox">&nbsp;</td>
                    <td style="font-weight:bold"><div align="center">名称</div></td >
                    <td style="font-weight:bold"><div align="center">图片</div></td >
                    <td style="font-weight:bold"><div align="center">时间</div></td >
                    <td class="picture2">&nbsp;</td >
                  </tr>
                </thead>
                <tr>
                  <td><div align="center">1</div></td>
                  <td><div align="center">装车单</div></td>
                  <td><div align="center"><a onclick="openwin4()"><img width="20px" height="20px"/></a></div></td>
                  <td><div align="center">2015-01-19</div></td>
                  <td><div align="center"><a href="#" title="Edit" class="edit"><img src="<%=basePath%>static/images/icons/pencil.png" alt="Edit" /></a> <a href="#" title="Delete" class="delete"><img src="<%=basePath%>static/images/icons/cross.png" alt="Delete" /></a></div></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td colspan="10"><a class="button_new" href="return_query.html" target="_parent" title="返回"><img src="<%=basePath%>static/images/icons/back_icon.png" class="px18"/></a><a class="button_new" href="#" title="保存"><img src="<%=basePath%>static/images/icons/save-icon.png" class="px18"/></a> </td>
            </tr>
          </table>
          
        </form>
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
 <script type="text/javascript">
<!--

function openwin1(){
window.open('destination-g.html','newwindow','height=700,width=1000,top=0,left=100,toolbar=0,menubar=0,scrollbar=yes,resizable=no.location=no,status=no')
}
function openwin2(){
window.open('asset-g.html','newwindow','height=800,width=1100,top=100,left=100,toolbar=0,menubar=0,scrollbar=yes,resizable=yes,location=no,status=no,fullscreen=yes')
}
function openwin4(){
window.open('images.html','newwindow','height=450,width=680,top=0,left=200,toolbar=0,menubar=0,scrollbar=yes,resizable=no,location=no,status=no,fullscreen=yes')
}
//-->
 </script>
</html>