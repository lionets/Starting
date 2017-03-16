<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath =  path + "/";
%>
<!-- Reset Stylesheet -->
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
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></SCRIPT>
<script src="<%=basePath %>static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<SCRIPT type=text/javascript>
	using(['window'],function(){});//加载window插件
		$(document).ready(function() {
			//表单提交
			$("#submitButton").on("click",function(){
				if(tatongMethod.isChecked()){
					//验证公司代码是否重复
				    $.ajax( {
				        dataType : "JSON",
				        type : "POST",
				        url : "<%=basePath%>ajax",
				        data : "method=selectList&sqlId=cn.com.newglobe.common.dao.read.ComDepartmentReadDao.selectDepartmentListByCode&department_code="+$("#department_code").val()+"&company_id="+$("#company_id").val(),
				        success : function(json) {
				        	var count = json[0].count;
				        	if(count ==0){
								tatongMethod.confirm("添加","确定要添加吗?",function(){
									$("form").submit();
								})
				        	}else{
				        		var temp = '<span class="apendhtml" style="color: red;margin-left: 5px;">部门代码重复</span>';
				        		$("#department_code").after(temp);
				        	}
				        },
				        error : function() {
				        	tatongMethod.alert("错误","验证部门代码失败！");
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
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>部门信息</h3>
  </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form action="<%=basePath %>company/department_update" method="post">
        <input type="hidden" name="id" value="${id }">
        <input type="hidden" name="tab7PageNum" value="0">
        <input type="hidden" name="tab7PerPage" value="10">
          <table border="0" class="edit-table">
            <tr>
              <th><label ><b>*</b>部门名称</label></th>
    <td><input name="department_name" type="text"  required="true" value="${department.department_name }"/></td>
    <th scope="row"><label ><b>*</b>部门代码</label></th>
    <td><input name="department_code" type="text" required="true" value="${department.department_code }"/></td>
  </tr>
  
  <tr>
    <th scope="row">所属公司</th>
    <td>
        <select name="company_id" id="company_id"  class="easyui-combobox" style="width: 156px;">
        	<c:forEach var="company" items="${companys }">
    		<option value="${company.id}">${company.companyShortName}</option>
        	</c:forEach>
    	</select>
    	<script type="text/javascript">
    		$("#company_id").val("${department.company_id}");
    	</script>
	</td>
 <th scope="row">上级部门</th>
    <td>
    	<select name="pdept_id" id="pdept_id"  class="easyui-combobox" style="width: 156px;">
    		<option value="">无上级部门</option>
    		<c:forEach var="dept" items="${departments }">
    			<option value="${dept.id }">${dept.department_name }</option>
    		</c:forEach>
    	</select>
    	<script type="text/javascript">
    		$("#pdept_id").val("${department.pdept_id}");
    	</script>
	</td>
  </tr>

  <tr>
    <th scope="row"><label ><b>*</b>部门电话</label></th>
    <td>
        <input  type="text"  required="true" vtype="telPhone"  value="${department.tel }" name="tel" /></td>
    <th scope="row"><label ><b>*</b>部门传真</label></th>
    <td>
        <input  type="text" required="true" vtype="fax"   name="fax" value="${department.fax }"/></td>
  </tr>
  
  <tr>
    <th scope="row">备注</th>
    <td colspan="3"><textarea name="memo" cols="" rows="">${department.memo }</textarea>
      &nbsp;</td>
  </tr>
<tr>
              <td>&nbsp;</td>
              <td colspan="3"><a class="button_new" href="javascript:history.go(-1)" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a><a class="button_new"  id="submitButton" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a>  </td>
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
