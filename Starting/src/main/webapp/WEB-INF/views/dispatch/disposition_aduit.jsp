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
<!-- Reset Stylesheet -->
<!-- Reset Stylesheet -->
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
<SCRIPT src="<%=basePath %>static/js/jQselect.js" type=text/javascript></SCRIPT>

<script src="<%=basePath %>static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
    <script type="text/javascript">
    $(function(){
    	//添加按钮
    	$("#addButton").on("click",function(){
    		var manageType = $("[name='manageType']:checked").val();
    		if("towerRadio" == manageType){//调度塔机
    			var towerNo = $('#towerNo').combobox("getValue");
    			if(towerNo == ""){
    				$.messager.alert("提示","调度塔机必须选择塔机编号!");
    				return;
    			}else{//得到塔机相关信息
                    $.ajax( {
                            dataType : "json",
                            type : "POST",
                            url : "<%=basePath %>handle/getTowerByTowerNo",
                            data : $("form").serialize(),
                            success : function(jsonStr) {
                            	var tower_class = jsonStr.tower_class==null?"":jsonStr.tower_class;
                            	var towerNo = jsonStr.towerNo==null?"":jsonStr.towerNo; 
                            	var tower_model = jsonStr.tower_model==null?"":jsonStr.tower_model;
                            	var tower_factoryno = jsonStr.tower_factoryno==null?"":jsonStr.tower_factoryno;
                            	var tower_source = jsonStr.tower_source==null?"":jsonStr.tower_source;
                            	var rightCompany =  jsonStr.rightCompany==null?"":jsonStr.rightCompany;
                            	var manageCompany = jsonStr.manageCompany==null?"":jsonStr.manageCompany;
                				var html = "<tr class='alt-row'>"+
        		                "<td><div align='center'>塔机</div></td>"+
        		                "<td><div align='center'>"+towerNo+"</div></td>"+
        		                "<td><div align='center'>"+tower_model+"</div></td>"+
        		                "<td><div align='center'>"+tower_factoryno+"</div></td>"+
        		                "<td>"+tower_source+"</td>"+
        		                "<td>"+rightCompany+"</td>"+
        		                "<td>"+manageCompany+"</td>"+
        		                '<td><div align="center"><a onclick="openwin(\''+tower_model+'\')" title="编辑零部件"><img src="<%=basePath%>static/images/icons/pencil.png"></a></div></td>'+
        		              "</tr>";
        		              $("#dynamicTbody").empty();
        		              $("#dynamicTbody").append(html);
                            },
                            error : function(html) {
                                tatongMethod.alert("错误","服务器遇到问题");
                            }
                        });
    			}
    		}else{//处置零部件
    			var html = "<tr>"+
                "<td><div align='center'>"+
                   "部件</div></td>"+
                "<td></td>"+
                "<td></td>"+
                "<td></td>"+
                "<td></td>"+
                "<td></td>"+
                "<td></td>"+
                "<td><div align='center'><a onclick='openwin()' title='编辑零部件'><img src='<%=basePath%>static/images/icons/pencil.png'></a></div></td>"+
              "</tr>";
	              $("#dynamicTbody").empty();
	              $("#dynamicTbody").append(html);
    		}
    		
    	})
    	
    	$("#submitButton").on("click",function(){
    		var dynamicTbody = $("#dynamicTbody").text().trim();
    		if(dynamicTbody == ""){
    			$.messager.alert("提示","请先添加处置方式");
    		}
    		var tower_no = $("#dynamicTbody").children().children(":eq(1)").text().trim();
    		var tower_model = $("#dynamicTbody").children().children(":eq(2)").text().trim();
    		var asset_name = $("#dynamicTbody").children().children(":eq(0)").text().trim();
    		$("#tower_no").val(tower_no);
    		$("#tower_model").val(tower_model);
    		$("#asset_name").val(asset_name);
    		if(tatongMethod.isChecked()){
    			$("form").submit();
    		}
    	})
    	
    	$("#checkButton").on("click",function(){
    	    $.ajax( {
    	        dataType : "html",
    	        type : "POST",
    	        url : "<%=basePath %>handle/disposition_check",
    	        data : "id=${id }",
    	        success : function(html) {
    	        	$.messager.alert("提示","审核成功!","",function(){
    	        		location.href = "<%=basePath %>handle/init/tab1";
    	        	});
    	        },
    	        error : function(html) {
    	               
    	        }
    	    });
    	})
    	
    })
    </script>
</head>
<body>
<jsp:include page="../header-bar.jsp"/>
 <div id="main-content" >
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>资产处置</h3>
  </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
    
    <div class="tab-content default-tab" id="tab1">
        <form action="<%=basePath %>handle/addHandle" method="post">
        	<input type="hidden" name="start_address" id="start_address" value="${assetManage.start_address }"/>
        	<input type="hidden" name="partData" id="partData"/>
        	<input type="hidden" name="tower_no" id="tower_no" value="${assetManage.start_address }"/>
        	<input type="hidden" name="asset_name" id="asset_name" value="${assetManage.asset_name }"/>
          <table border="0" class="edit-table">
            <tr >
              <th ><label><b>*</b>处置单号</label></th>
              <td class="px200">${assetManage.disposal_no}</td>
              <th ></th>
            <td >
               </td>
              <td >
               </td>
            </tr>
            <tr>
              <th ><label><b>*</b>处置资产</label></th>
              <td class="px200">${assetManage.asset_name}</td>
              <th ><label>塔机编号</label></th>
            <td >${assetManage.tower_no }
               </td>
              <td >
               </td>
            </tr>
            <tr>
              <th ><label><b>*</b>处置方式</label></th>
              <td>${assetManage.disposal_type}
                  </td>
              <th ><label><b>*</b>处置时间</label></th>
              <td >
              ${assetManage.disposal_date }
              </td>
              <td></td>
            </tr>
           
          </table>
          <p>
            <label> <b> 资产信息</b><label style="padding-left:61px"> <b style="color:#FF0000">*</b>发出地</label><label id="startAddressLabel" style="padding-left:20px">${assetManage.start_address }</label>
        </p>
        <div >
          <table width="100%" >
            <thead>
              <tr>
                <th  scope="col">资产名称</th>
                <th  scope="col">塔机编号</th>
                <th  scope="col">塔机型号</th>
                <th  scope="col">出厂编号</th>
                <th  scope="col">塔机来源</th>
                <th  scope="col">所属公司</th>
               
                <th  scope="col">管理公司</th>
                <th  scope="col"><span class="picture2">功能</span></th>
              </tr>
            </thead>
            <tbody id="dynamicTbody">
            <tr><td><div align="center">${assetManage.asset_name }</div></td><td><div align="center">${assetManage.tower_no }</div></td><td><div align="center">${assetManage.tower_model }</div></td><td><div align="center">${assetManage.tower_factoryno }</div></td><td>${assetManage.tower_source }</td><td>${assetManage.rightCompany }</td><td>${assetManage.manageCompany }</td><td><div align="center"><a onclick="openwin()" title="查看零部件"><img src="<%=basePath %>static/images/icons/view.png"></a></div></td></tr>
             </tbody>
              </table>
              </div>
              <table>
              <tr>  
              <td>&nbsp;</td>
              <td colspan="9"><a class="button_new" href="javascript:history.go(-1)" target="_parent" title="返回"><img src="<%=basePath%>static/images/icons/back_icon.png" class="px18"/></a>
              <a class="button_new" id="checkButton" href="javascript:void(0)" title="审核"><img src="<%=basePath%>static/images/icons/check_icons.png" class="px18"></a>
              </td>
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
<script>
function openwin(){
	var towerModel =  $("#dynamicTbody").children().children(":eq(2)").text();
	var towerNo =  $("#dynamicTbody").children().children(":eq(1)").text();
	var come_address = encodeURI(encodeURI($("#start_address").val()));
	towerModel = encodeURI(encodeURI(towerModel));
	towerNo = encodeURI(encodeURI(towerNo));
	window.open('add_part_view?towerModel='+towerModel+'&towerNo='+towerNo+"&come_address="+come_address+"&manage_id=${id}",'newwindow','height=700,width=1200,top=50,left=100,toolbar=0,menubar=0,scrollbar=yes,resizable=no,location=no,status=no')
}</script>
</html>
