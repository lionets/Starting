<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<script type="text/javascript" src="<%=basePath %>static/js/paging/jquery.pagination.js"></script>
<SCRIPT src="<%=basePath %>static/js/jQselect.js" type=text/javascript></SCRIPT>
<SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></SCRIPT>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<script src="<%=basePath %>static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
alert("hlelo");
</script>
</head>
<body>
<jsp:include page="../header-bar.jsp"/>
<div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>调度单</h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form action="" method="post">
          <table  class="edit-table" border="0">
            <tr>
              <th scope="row">调度单号</th>
              <td width="300px">${dispatch.dispatch_no }</td>
              <th scope="row">调度时间</th>
              <td>${dispatch.dispatch_time }</td>
            </tr>
          </table>
          <P><b>目的地</b></P>
          <table border="0"  class="edit-table">
            <tr>
              <th scope="row">地点</th>
			<td width="300px"><label>
                <input type="radio" name="radio" id="radio" value="项目"  disabled="disabled"  <c:if test='${dispatch.dispatch_type=="项目" }'>checked="checked"</c:if> />
              项目</label>
                <label>
                <input type="radio" name="radio" id="radio2" disabled="disabled"     value="仓库" <c:if test='${dispatch.dispatch_type=="仓库" }'>checked="checked"</c:if>/>
                其他</label>
         </td>
              <th scope="row">&nbsp;</th>
              <td>&nbsp;</td>
            </tr>
			<tr>
              <th scope="row">信息</th>
              <td colspan="3">
              <script type="text/javascript">
              var type = "${dispatch.dispatch_type}";
              var showStr = "";
              if(type=="项目"){
            	  showStr = "合同编号:${dispatch.contract_no},项目名称:${dispatch.end_address }";
              }
              else{
            	  showStr ="仓库:${dispatch.end_address }";
              }
              document.write(showStr);
              </script>
              </td>
              <!--调度目的地为项目时显示合同编号和项目名称-->
            </tr>
          </table>
          <P><b>调度资产</b>
            <label style="padding-left:61px"> <b style="color:#FF0000">*</b>发出地:</label>
            ${dispatch.start_address }
           </P>
          <table >
            <thead>
              <tr>
                <th  scope="col" class="picture2">&nbsp;</th>
                <th  scope="col">塔机型号</th>
                <th  scope="col">塔机编号</th>
                <th  scope="col">出厂编号</th>
                <th  scope="col">塔机来源</th>
                <th  scope="col">状态</th>
                <th  scope="col">所属公司</th>
                <th  scope="col">管理公司</th>
                <th  scope="col">管理单位</th>
                 <th  scope="col" class="picture2"></th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td><div align="center">1</div></td>
                <td width="94"><div align="center">${dispatch.tower_model }</div></td>
                <td width="78"><div align="center"> ${dispatch.tower_no } </div></td>
                <td><div align="center">${dispatch.tower_factoryno }</div></td>
                <td><div align="center">${dispatch.tower_source }</div></td>
                <td><div align="center">
                <script type="">
               	var status =  '${dispatch.tower_manage_state }';
				var tempStr = "";
				if(status == "1"){
					tempStr="闲置"
				}
				if(status == "2"){
					tempStr="未启用"
				}
				if(status == "3"){
					tempStr="在使用"
				}
				if(status == "4"){
					tempStr="冬停"
				}
				if(status == "5"){
					tempStr="托管"
				}
				document.write(tempStr);
				</script>
                </div></td>
                <td><div align="center">${dispatch.rightCompany }</div></td>
                <td><div align="center">${dispatch.department_name }</div></td>
                <td><div align="center">${dispatch.manageCompany }</div></td>
                <td><div align="center"><a onclick="openwin3()" title="调度零部件"><img src="<%=basePath %>static/images/icons/view.png" /></a></div></td>
              </tr>
            </tbody>
          </table>
 	<P><b>装车单</b></P>
          <table>
            <thead >
              <tr>
                <th scope="col" class="chebox">&nbsp;</th>
                <th style="font-weight:bold"><div align="center">名称</div></th >
                <th style="font-weight:bold"><div align="center">图片</div></th >
                <th style="font-weight:bold"><div align="center">时间</div></th >
              </tr>
            </thead>
            <c:forEach items="${dispatchAttachmentList}" var="dispatchAttachment" varStatus="status">
		            <tr>
		              <td><div align="center">
		              	<script type="text/javascript">
				          	var num =	${status.index+1};
				          	document.write(num);
				        </script>
		              </div></td>
		              <td><div align="center">${dispatchAttachment.attachment_name }</div></td>
		              <td><div align="center"><a><img width="20px" src="<%=basePath %>static/upload/${dispatchAttachment.attachment_path }" height="20px"/></a></div></td>
		              <td><div align="center">${dispatchAttachment.attachment_time }</div></td>
		            </tr>
             </c:forEach>
            <tr>
              <td >&nbsp;</td>
              <td colspan="4"><a class="button_new" href="javascript:history.go(-1)" target="_parent" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a>
           </td>
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
<div id="footer"> <small>達豐中國 地址：上海市长宁区天山西路1068号联强国际D栋4楼 电话:+86 21 60825373 </small><br />
  <br />
  <small>系统开发 Copyright © 2015 上海乔罗网络科技有限公司 </small> </div>
<!-- End #footer -->
</body>
<script>
function openwin3(){
window.open('<%=basePath%>transfer/department_view?dispatch_id=${id}&dispatch_type=${dispatch.dispatch_type=="项目"?1:2}','newwindow','height=800,width=1180,top=0,left=100,toolbar=0,menubar=0,scrollbar=yes,resizable=no,location=no,status=no,fullscreen=yes')
}
//-->
 </script>
</html>
