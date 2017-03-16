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
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<script type="text/javascript" src='<%=basePath %>static/js/UTIL.js'></script>
<script type="text/javascript">

var isUnSub = 0;
$(document).ready(function() {
	$("#submitButton").on("click",function(){
		if(isUnSub > 0){
			return;//防止重复提交
		}
		if(tatongMethod.isChecked()){
			isUnSub++;
			$.ajax({
				async : false,
				cache : false,
				type : 'POST',
				data :$("#editCustomerForm").serialize(),
				url :'<%=basePath %>customer/editSave',
				error : function() {// 请求失败处理函数
					isUnSub--;
					$.messager.alert('错误','提交请求失败!','error');
				},
				success : function(data){
					if('n' == data){
						isUnSub--;
						$.messager.alert('失败','客户资料保存失败!','error');
					}else{
						$.messager.alert('成功','客户资料保存成功!','info',function(){
							window.location.href = '<%=basePath %>customer/init/1';
						});
					}
				}
			});
		}
	});
});
function checkValue(obj){
	var value = $(obj).val();
	if(!/^[\w]+$/.test(value) && isEmpty(value) == false){
		$.messager.alert("错误","编号无效! 仅支持字母与数字下划线。",'error',function(){
			$(obj).val('');
		});
		return;
	}
}
</script>
</head>
<body>
<jsp:include page="../header-bar.jsp"/>
<div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>编辑客户资料</h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form id="editCustomerForm" action="<%=basePath %>customer/editSave" method="post">
          <table border="0" class="edit-table">
            <tr>
              <th><label>客户编号</label></th>
              <td>
              <input type="hidden" name="id" value="${info.id }"/>
              <input class="medium-input" type="text" onblur="checkValue(this);" id="customerCode" name="customerCode" value="${info.customerCode }" required="true"/></td>
              <td>(输入不能超过20个字)</td>
            </tr>
            <tr>
              <th><label ><b>*</b>客户名称</label></th>
              <td><input class="medium-input" type="text" id="customerCnName" name="customerCnName" value="${info.customerCnName }" required="true"/></td>
              <td>(输入不能超过40个字)</td>
            </tr>
            <tr>
              <th><label><b>*</b>联系人中文名</label></th>
              <td><input class="medium-input" type="text" id="cpCnName" name="cpCnName" value="${info.cpCnName }" required="true"/></td>
              <td>(输入不能超过20个字)</td>
            </tr>
            <tr>
              <th>职位</th>
              <td><input class="medium-input" type="text" id="chinese_name2" name="chinese_name2" /></td>
              <td>(输入不能超过20个字)</td>
            </tr>
            <tr>
              <th><label>联系人英文名</label></th>
              <td><input class="medium-input" type="text" id="cpEnName" name="cpEnName" value="${info.cpEnName }" required="true"/></td>
              <td>(输入不能超过20个字)</td>
            </tr>
            <tr>
              <th><label>电话</label></th>
              <td><input class="medium-input" type="text" id="tel" name="tel" value="${info.tel }" required="true"/></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <th><label>分机</label></th>
              <td><input class="medium-input" type="text" id="extension" name="extension" value="${info.extension }" /></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <th><label>手机</label></th>
              <td><input class="medium-input" type="text" id="phone" name="phone" value="${info.phone }" /></td>
              <td>(手机格式:99999999999)</td>            
            </tr>
            <tr>
              <th><label>传真</label></th>
              <td><input class="medium-input" type="text" id="fax" name="fax" value="${info.fax }"/></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <th><label>电子邮箱</label></th>
              <td><input class="medium-input" type="text" id="email" name="email" value="${info.email }" required="true"/></td>
              <td>(邮箱格式:xxxx@email.com)</td>
            </tr>
            <tr>
              <th><label>备注</label></th>
              <td><input type="text" class="medium-input" id="remark" name="remark" value="${info.remark }" />
                     </td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td colspan="2"><a class="button_new" id="submitButton" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a> <a class="button_new" href="<%=basePath %>customer/init/1" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a> </td>
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