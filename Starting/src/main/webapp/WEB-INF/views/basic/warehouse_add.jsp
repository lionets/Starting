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
<link rel="stylesheet" href="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/default/easyui.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/icon.css" type="text/css" media="screen" />
<!-- Reset Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
<!-- Main Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen" />
<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
<link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/css/select.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery-easyui-1.4.1/jquery.easyui.min.js"></script>
<script src="<%=basePath %>static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<SCRIPT type=text/javascript>
	$(document).ready(function() {
		
		$('#dispatchId').combobox({
			url:'<%=basePath %>company/manageCompanyCombox',
			valueField:'id',
			textField:'companyShortName'
		});
		$('#repArea').combobox({
			url:'<%=basePath %>area/getAreainfo?areaType=1',
			valueField:'areaCode',
			textField:'areaName',
			onSelect:function(rec){
				//alert(JSON.stringify(rec));
				$('#repProvince').combobox('clear');
				$('#repCity').combobox('clear');
				var url = '<%=basePath %>area/getAreainfo?areaType=2&areaCode='+rec.areaCode;
				$('#repProvince').combobox('reload', url);
			}
		});
		$('#repProvince').combobox({
			valueField:'areaCode',
			textField:'areaName',
			onSelect:function(rec){
				//alert(JSON.stringify(rec));
				$('#repCity').combobox('clear');
				var url = '<%=basePath %>area/getAreainfo?areaType=3&areaCode='+rec.areaCode;
				$('#repCity').combobox('reload', url);
			}
		});
		
		$('#repCity').combobox({
			valueField:'areaCode',
			textField:'areaName'
		});
		
		$("#submitButton").on("click",function(){
			if(tatongMethod.isChecked()){
				$.ajax({
					async : false,
					cache : false,
					type : 'POST',
					data :$("#repForm").serialize(),
					url :'<%=basePath %>warehouse/add',
					error : function() {// 请求失败处理函数
						$.messager.alert('错误','保存请求提交失败!','error');
					},
					success : function(data){
						if('n' == data){
							$.messager.alert('失败','仓库信息保存失败!','error');
						}else{
							$.messager.alert('成功','仓库信息保存入库成功!','info',function(){
								window.location.href = '<%=basePath %>warehouse/init/4';
							});
						}
					}
				});
			}
		});
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
      <h3>新增仓库</h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form id="repForm" method="post">
          <table border="0" class="edit-table">
            <tr>
              <th><label ><b>*</b>仓库名称</label></th>
              <td><input name="storeName" type="text" required="true"/></td>
              <td >&nbsp;</td>
            </tr>
            <tr>
              <th scope="row"><label><b>*</b>联系人姓名 </label></th>
              <td><input name="repContact" type="text" required="true"></td>
              <td><span >(输入不能超过20个字)</span></td>
            </tr>
            <tr>
              <th scope="row">电话</th>
              <td>
                <input name="rermark3" type="text" /></td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <th scope="row">手机</th>
              <td><input name="repConPhone" type="text" /></td>
               <td>(手机格式:99999999999)</td>
            </tr>
            <tr>
              <th scope="row"><label ><b>*</b>仓库地址</label></th>
              <td>
              <select id="repArea" name="repArea" style="width: 80px;" class="easyui-combobox" >
              </select>
              <select id="repProvince" name="repProvince" style="width: 80px;" class="easyui-combobox" >
              </select>
              <select id="repCity" name="repCity" style="width: 80px;" class="easyui-combobox" >
              </select>
              <input name="repAddress" type="text" class="medium-input" required="true"/>
            </td>
              <td></td>
            </tr>
            <tr>
              <th scope="row"><label ><b>*</b>仓库面积</label></th>
              <td><input name="repRermark1" type="text" required="true"/></td>
              <td>平方米（m2）</td>
            </tr>
            <tr>
              <th scope="row">道路交通</th>
              <td><textarea name="repRermark2" id="rep_rermark2" cols="25" rows="3"></textarea></td>
              <td></td>
            </tr>
            <tr>
              <th scope="row">租期</th>
              <td><input name="repCreateDate" type="text" readonly="readonly"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"/></td>
              <td></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td colspan="2"><a class="button_new" id="submitButton" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a> <a class="button_new" href="<%=basePath %>warehouse/init/4" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a> <a class="button_new" href="#" title="人工定位"><img src="<%=basePath %>static/images/icons/dingwei_icon.png" class="px18"/></a> </td>
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