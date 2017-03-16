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
<link rel="stylesheet" href="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/default/easyui.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/icon.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<script type="text/javascript" src='<%=basePath %>static/js/UTIL.js'></script>

</head>
<body>
<jsp:include page="../header-bar.jsp"/>
<div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>查看零部件资料</h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form id="partForm" action="<%=basePath %>parts/editSave" method="post">
          <table border="0" class="edit-table">
            <tr>
             <th><label ><b>*</b>零部件名称 </label></th>
              <td width="300px">
              ${info.partName }
              </td>
              <th>零部件编号</th>
              <td>${info.partMapNo }</td>
            </tr>
            <tr>
              <th scope="row">零部件型号</th>
              <td>
              ${info.partMode }
              </td>
              <th scope="row">所属塔机编号</th>
              <td>
              ${info.partOfTower }
              </td>
             </tr>
             <tr>       
              <th scope="row">数量</th>
              <td>${info.receivingAmount }</td>
              <th scope="row">单位</th>
              <td>${info.partUnit }</td>
            </tr>
            <tr>
             <th scope="row">执行状况</th>
              <td>
              ${info.partStatus }
              </td>
              <th scope="row">采购合同编号</th>
              <td>${info.contractNo }</td>
            </tr>
         <tr >
              <th scope="row">产权公司</th>
              <td>
              ${info.partOfCompanyName }
              </td>
              <th scope="row">管理公司</th>
              <td>
              ${info.manageCompanyName }
              </td>
            <tr>
              <th scope="row">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</th>
              <td colspan="3"><textarea name="memo" id="memo" cols="25" rows="3">${info.memo }</textarea></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td colspan="3">
              <%-- <a class="button_new" id="submitButton" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a>  --%>
              <a class="button_new" href="<%=basePath %>parts/init/3" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a> </td>
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
</html>