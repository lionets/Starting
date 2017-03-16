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
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></SCRIPT>
<script src="<%=basePath %>static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<SCRIPT type=text/javascript>

	function selectChange(record){
		var data="sqlId=cn.com.newglobe.tathong.common.dao.read.GpsbaseReadDao.selectCount&method=selectList";
		if(record.value == undefined){
				data += "&tower_no="+record[0].value
				}else{
				data += "&tower_no="+record.value
				}
				//加载塔机gps信息
			    $.ajax( {
			            dataType : "json",
			            type : "POST",
			            url : "<%=basePath %>tathAjax",
			            data :data,
			            success : function(json) {
			            	if(json[0]){
		            	$("[name='gps_no']").val(json[0].gps_no);
		            	$("[name='sim_number']").val(json[0].sim_number);
		            	$("[name='waterproof']").val(json[0].waterproof);
		            	} else{
		                	$("[name='gps_no']").val("");
		                	$("[name='sim_number']").val("");
		                	$("[name='waterproof']").val("");
		            	}
		            },
		            error : function(html) {
		                tatongMethod.alert("错误","服务器遇到问题");
		            }
		        });
		}


	using(['window'],function(){});//加载window插件
	$(document).ready(function() {
		//表单提交
		$("#submitButton").on("click",function(){
				//塔机编号必输项
				if($("[name='towerNo']").val()==""){
					$("#showspan").text("该项为必输项");
					return;
				}
				else{
					$("#showspan").text("");
				}	
				if(tatongMethod.isChecked()){
					if(!/1[1-9]\d{9}/.test($("[name='sim_number']").val())){
						 $("[name='sim_number']").after( '<span class="apendhtml" style="color: red;margin-left: 5px;">SIM卡号格式不正确</span>');
						 return;
					}
					
					if(!/^(\d{4})-(\d{2})-(\d{2})-(\d{4})/.test($("[name='gps_no']").val())){
						 $("[name='gps_no']").after( '<span class="apendhtml" style="color: red;margin-left: 5px;">格式不正确(2013-05-27-0910)</span>');
						 return;
					}
					
					//需要检查sim卡号，GPS主机号，防水盒编号是否有重复的
                      $.ajax( {
                              dataType : "JSON",
                              type : "POST",
                              url : "<%=basePath %>driverManage/repetition",
                              data : $("form").serialize(),
                              success : function(json) {
                            	  if(json.length>0){
                            		 var gpsBase = json[0];
                            		 if(gpsBase.sim_number==$("[name='sim_number']").val()){
                            			 $("[name='sim_number']").after( '<span class="apendhtml" style="color: red;margin-left: 5px;">SIM卡号重复</span>');
                            				 return;
                            		 }
                            		 if(gpsBase.gps_no==$("[name='gps_no']").val()){
                            			 $("[name='gps_no']").after( '<span class="apendhtml" style="color: red;margin-left: 5px;">GPS主机号号重复</span>');
                            			 return;
                            		 }
                            		 if(gpsBase.waterproof==$("[name='waterproof']").val()){
                            			 $("[name='waterproof']").after( '<span class="apendhtml" style="color: red;margin-left: 5px;">防水盒号重复</span>');
                            			 return;
                            		 }
                            	  }else{
                  					tatongMethod.confirm("修改","确定要修改吗?",function(){
                						$("form").submit();
                					})
                            	  }
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
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>GPS管理</h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form action="<%=basePath %>driverManage/gpsManageAdd" method="post">
             <input type="hidden" name="id" value="${gpsBaseId}">
        	<input type="hidden" name="tab6PageNum" value='${tab6PageNum==""?0:tab6PageNum}'>
        	<input type="hidden" name="tab6PerPage" value='${tab6PerPage==""?10:tab6PerPage}'>
        	<input type="hidden" name="status" value="1">
        	<input type="hidden" name="tab" value="tab6">
          <table border="0" class="edit-table">
            <tr>
              <th><label ><b>*</b></label>SIM卡号</th>
       <td><input name="sim_number" type="text" required="true" ></td>
     </tr>

     <tr>
       <th scope="row"><label ><b>*</b></label>GPS主机号</th>
       <td><input name="gps_no" type="text" required="true" ></td>
     </tr>
     <tr>
       <th scope="row">防水盒编号</th>
       <td><input name="waterproof" type="text" ></td>
     </tr>
     <tr>
       <th scope="row">到货地点</th>
       <td><input name="address" type="text" value="${gpsBase.address }"/></td>
     </tr>
     <tr>
       <th scope="row">收货人</th>
       <td><input name="receiveman" type="text" value="${gpsBase.receiveman }"/></td>
     </tr>
     
     <tr>
       <th scope="row">发货时间</th>
       <td><input name="sendtime" type="text" readonly="ture"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});"  value="<fmt:formatDate  value="${gpsBase.sendtime }" type="both" pattern="yyyy-MM-dd hh:mm:ss" />"/></td>
     </tr>
     <tr>
       <th scope="row">绑定塔机编号</th>
       <td>
      <select class="easyui-combobox" data-options=""  name="tower_no" style="width:154px;">
                                                <option value="">不限</option>
                                                <c:forEach var="towerNoOne" items="${towerNoList}"
                                                       varStatus="status">
                                                <c:choose>
                                                    <c:when test="${towerNoOne.tower_no==towerNo }">
                                                        <option value="${towerNoOne.tower_no }"
                                                                selected="selected">${towerNoOne.tower_no }</option>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <option value="${towerNoOne.tower_no }">${towerNoOne.tower_no }</option>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
            </select>
       </td>
     </tr>
    <tr>
              <td>&nbsp;</td>
              <td colspan="2"><a class="button_new" href='<%=basePath %>driverManage/init/tab6?tab6PageNum=${tab6PageNum==""?0:tab6PageNum }&tab6PerPage=${tab6PerPage==""?0:tab6PerPage}' title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a><a class="button_new" href="javascript:void(0)" id="submitButton" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a><a class="button_new" href="<%=basePath %>driverManage/GPS_add?tab6PageNum=0&tab6PerPage=10" title="返修"><img src="<%=basePath %>static/images/icons/maintenance_icon.png" class="px18"/></a>  </td>
            </tr>
            </tfoot>
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

