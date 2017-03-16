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
<!-- Reset Stylesheet -->
<link rel="stylesheet" type="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/default/easyui.css">
<link rel="stylesheet" type="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/icon.css">
<link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
<!-- Main Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen" />
<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
<link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/css/select.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
<SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></SCRIPT>
<SCRIPT src="<%=basePath %>static/js/jQselect.js" type=text/javascript></SCRIPT>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<SCRIPT type=text/javascript>
	$(document).ready(function() {
		$("#submitButton").on("click",function(){
				if(tatongMethod.isChecked()){
						//ajax请求
						    $.ajax( {
							        dataType : "html",
							        type : "POST",
							        url : "<%=basePath %>users/editPWD",
							        data : $("form").serialize(),
							        success : function(html) {
							        	tatongMethod.alert("提示信息",html,"info",function(){
							        	});
							        },
							        error : function(html) {
							        	tatongMethod.alert("错误","服务器遇到问题");
							        }
							    });
				}		
		
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
        
            <li> <a href="#tab4"  class="default-tab" > <h4>修改密码</h4></a></li>
      </ul>
      <div class="clear"></div>
      <h3></h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
   
       <div class="tab-content  default-tab" id="tab4">
        <form action="<%=basePath %>users/editPWD" method="post">
          <table border="0" class="edit-table">
            <tr>
              <th><label ><b>*</b>旧密码</label></th>
    <td><input required="true"  vtype="limit" minLength="6" maxLength="20" name="oldPWD" type="text" /></td>
    <td class="zhushi">(输入不能超过20个字)</td>
  </tr>
   
    <tr>
      <th scope="row"><label ><b>*</b>新密码</label></th>
      <td><input  required="true" id="password" vtype="limit" minLength="6" maxLength="20"  name="password" type="password"></td>
      <td><span class="zhushi">(输入不能超过20个字)</span></td>
    </tr>
    <tr>
      <th scope="row"><label ><b>*</b>确认密码</label></th>
      <td><input  vtype='passwordAgain' id="passwordAgain" type="password" /></td>
      <td><span class="zhushi">(输入不能超过20个字)</span></td>
    </tr>
<tr>
              <td>&nbsp;</td>
              <td colspan="2"><a class="button_new" href="javascript:void(0)" id="submitButton" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a>   <a class="button_new" href="javascript:history.go(-1)" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a></td>
            </tr>
            </tfoot>
            
          </table>
        </form>
      </div>
      <!-- End #tab4 -->
    
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