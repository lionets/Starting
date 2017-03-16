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
</head>
<body>
<jsp:include page="../header-bar.jsp"/>
<div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>新增零部件资料</h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form action="" method="post">
          <table border="0" class="edit-table">
            <tr>
             <th><label ><b>*</b>零部件名称 </label></th>
              <td width="300px"><input type="text" list="parts_list" name="link" />
                          <datalist id="parts_list">
                  <option label="臂" value="臂"></option>
                  <option  label="提升机构" value="提升机构"></option>
                  <option label="回转机构" value="回转机构"></option>
                  <option  label="变频机构" value="变频机构"></option>
                  <option label="电源电缆" value="电源电缆" ></option>
                  <option label="地脚" value="地脚" ></option>
                  <option label="钢丝绳" value="钢丝绳" ></option>
                  </datalist></td>
              <th>零部件编号</th>
              <td><input name="Input" type="text"  value="SBJTHZ087001" /></td>
             
            </tr>
            <tr>
              <th scope="row">零部件型号</th>
              <td><input type="text" list="model_list" name="link" />
                          <datalist id="model_list">
                  <option label="L68B1" value="L68B1"></option>
                  <option label="70米" value="70米"></option>
                </datalist></td>
              <th scope="row">所属塔机编号</th>
              <td><input type="text" list="modle_list" name="link" />
                          <datalist id="modle_list">
                          <option label="1" value="1"></option>
                          <option label="2" value="2" > </option>
                          <option label="3" value="3" ></option>
                          <option label="4" value="4" ></option>
                         
                        </datalist></td>
                        </tr>
                 <tr>       
              <th scope="row">数量</th>
              <td><input name="Input3" type="text"  value="14" readonly="readonly"/></td>
              
              <th scope="row">单位</th>
              <td><input name="Input4" type="text"  value="节" readonly="readonly"/></td>
             
            </tr>
           
            <tr>
             <th scope="row">执行状况</th>
              <td><input type="text" list="status_list" name="link" />
                      <datalist id="status_list">
                    <option label="在使用" value="在使用"></option>
                    <option label="闲置" value="闲置"></option>
                    <option label="托管" value="托管"></option>
                    <option label="冬停" value="冬停" ></option>
                    <option label="未使用" value="未使用"></option>
                  </datalist></td>
              <th scope="row">采购合同编号</th>
              <td><input name="Input2" type="text"  value="THZM090530-F-001" class="px200"/></td>
             
            </tr>
         <tr >
              <th scope="row">产权公司</th>
              <td><input type="text" list="company_list" name="link" />
                      <datalist id="company_list">
                         <option label="北京达丰" value="北京达丰"></option>
                        <option label="北京永茂" value="北京永茂"></option>
                        <option label="上海达丰" value="上海达丰"></option>
                        <option label="江苏正和达丰" value="江苏正和达丰"></option>
                        <option label="四川达丰" value="四川达丰" > </option>
                        <option label="中核华兴达丰" value="中核华兴达丰"></option>
                      </datalist></td>
             
              <th scope="row">管理公司</th>
              <td><input type="text" list="company1_list" name="link" />
                      <datalist id="company1_list">
                         <option label="北京达丰" value="北京达丰"></option>
                        <option label="北京永茂" value="北京永茂"></option>
                        <option label="上海达丰" value="上海达丰"></option>
                        <option label="江苏正和达丰" value="江苏正和达丰"></option>
                        <option label="四川达丰" value="四川达丰" > </option>
                        <option label="中核华兴达丰" value="中核华兴达丰"></option>
                      </datalist></td>
           
          
            <tr>
              <th scope="row">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</th>
              <td colspan="3"><textarea name="textarea" id="textarea" cols="25" rows="3"></textarea>              </td>
              
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td colspan="3"><a class="button_new" href="#" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a> <a class="button_new" href="<%=basePath %>customer/init/1" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a> </td>
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