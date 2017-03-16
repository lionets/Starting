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
<jsp:include page="../header-bar.jsp"/>
 <div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>项目方案</h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form action="" method="post">
         <p>
            <label> <b>客户信息</b></label> 
          </p>
          <table border="0" class="edit-table">
            <tr>
              <th scope="row" width="200px">客户名称 </th>
              <td width="200px"><input type="text" readonly value="安徽电力建设第二工程公司" name="link" class="address"/>
                      
              </td>
            
              <th width="200px">客户编号</th>
              <td width="200px"><input name="Input3" type="text" readonly/></td>
             <th>&nbsp;</th>
             <td>&nbsp;</td>
            </tr>
            <tr >
              <th>联系人</th>
              <td><input name="Input5" type="text"  readonly  value="华兴达丰"/></td>
             
              <th>联系方式</th>
              <td><input name="Input6" type="text" readonly/></td>
               <th width="200px">邮箱</th>
             <td><input name="Input6" type="text" readonly/></td>
            </tr>
          </table>
          <p>
            <label> <b>合同信息</b></label> 
          </p>
          <table border="0" class="edit-table">
            <tr>
              <th width="200px"><label>合同编号 </label></th>
              <td width="200px"><input name="Input9" type="text" readonly="readonly" value="087101z452d"/></td>
             
              <th width="200px">所属公司</th>
              <td width="200px"><input type="text" readonly="readonly" value="华兴达丰" name="link" />
          </td>
 <th width="200px">管理单位</th>
  <td ><input type="text" readonly="readonly" value="单位1" name="link" />
                     </td>

            </tr>
            <tr class="tablecolumn" >
              <th>备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</th>
              <td colspan="5"><textarea name="textarea" readonly="readonly" value="" cols="" rows=""></textarea></td>
            </tr>
            </table>
              <p>
            <label> <b>项目信息</b></label> 
          </p>
          <table border="0" class="edit-table">
            <tr >
             <th><label>项目名称 </label></th>
              <td><input name="Input9" type="text" readonly="readonly" value="成都库房自用" class="address"/></td>
              <th><label>项目简称 </label></th>
              <td><input name="Input9" type="text" readonly="readonly" value="成都库房自用"/></td>
 <th>&nbsp;</th>
             <td>&nbsp;</td>
            </tr>
            <tr >
              <th><label>项目地点</label></th>
              <td colspan="5"><input type="text" readonly="readonly" value="西南区" name="link" class="picture2"/>
                  
                  <input type="text" readonly="readonly" value="四川省" name="link" class="picture2"/>
                  
                  <input type="text" readonly="readonly" value="成都市" name="link" class="picture3"/>
                  <input name="Input9" type="text" class="address" readonly="readonly" value="成都"/></td>

            </tr>
            <tr >
             <th><label>类型</label></th>
              <td><input type="text" readonly="readonly" value="民用" name="link"/>
                     </td>
              <th><label>状态</label></th>
              <td><input type="text" readonly="readonly" value="待启动" name="link" />
                  </td>
 <th>&nbsp;</th>
             <td>&nbsp;</td>
            </tr>
            
          </table>
         
          <p>
            <label> <b> 设备需求</b></label>
            </p>
          <table>
            <thead>
              <tr>
                <th scope="col" class="picture2">&nbsp;</th>
                <th  scope="col">塔机型号</th>
                <th  scope="col">塔机编号</th>
                <th  scope="col">出厂编号</th>
                <th  scope="col">调度单号</th>
                <th  scope="col">状态</th>
                <th  scope="col">安装方式</th>
                <th  scope="col">大臂长度(米)</th>
                <th  scope="col">方案高度(米)</th>
     <th  scope="col" class="picture2"></th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td><div align="center">1</div></td>
                <td><div align="center">
                    <input type="text" readonly="readonly" value="jcp7427-18t" name="link2" />
                 
                      </div>                   </td>
                <td><div align="center">
                    <input name="Input7" type="text" readonly="readonly" value="087101z027" class="picture5"/>
                </div></td>
                <td><div align="center">
                    <input name="Input4" type="text"readonly="readonly" value="2005h94"  class="picture5"/>
                </div></td>
                <td><input name="Input4" type="text"  class="picture5" readonly="readonly" value="D141000014" /></td>
                <td><input name="Input4" type="text"  class="picture5" readonly="readonly" value="调度结束" /></td>
                <td><div align="center">
                    <input type="text" readonly="readonly" value="固定式" name="link2" />
                  </div>                    </td>
                <td><div align="center">
                    <input name="Input" type="text" readonly="readonly" value="80" class="picture5"/>
                </div></td>
                <td><div align="center">
                    <input name="Input2" type="text" readonly="readonly" value="100" class="picture5"/>
                </div></td>
         <td><div align="center"> <a onClick="openwin1()" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" alt="Edit" /></a></div></td>
              </tr>
            </tbody>
            <tr>
              <td>&nbsp;</td>
              <td colspan="9"><a class="button_new" href="plan_query.html" target="_parent" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a><a class="button_new" href="#" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a><a class="button_new" href="#" title="审批"><img src="<%=basePath %>static/images/icons/check_icons.png" class="px18"/></a> </td>
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
window.open('add_part_plan.html','newwindow','height=700,width=1050,top=50,left=100,toolbar=0,menubar=0,scrollbar=yes,resizable=no,location=no,status=no')
}
//-->
 </script>
</html>