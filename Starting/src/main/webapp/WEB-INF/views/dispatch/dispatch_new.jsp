<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<script type="text/javascript" src="<%=basePath %>static/js/paging/jquery.pagination.js"></script>
<SCRIPT src="<%=basePath %>static/js/jQselect.js" type=text/javascript></SCRIPT>
<SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></SCRIPT>
<SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/jquery.easyui.min.js" type=text/javascript></SCRIPT>
<script src="<%=basePath %>static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<style type="text/css">
    #imgdiv
    {
     FILTER: progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)
    }
</style>
<style type="text/css">
input {
padding: 1px;
font-size: 13px;
background: none;
border: 1px solid #cccccc;
border-left: none;
border-right: none;
border-top: none;
color: #333;
vertical-align: middle;
}

 .fileInputContainer{
        height:100;
        position:relative;
        width: 130;
    }
    .fileInput{
        overflow: hidden;
        font-size: 300px;
        position:absolute;
        right:0;
        top:0;
        opacity: 0;
        filter:alpha(opacity=0);
        cursor:pointer;
         height:100;
          width: 130;
    }

</style>
<SCRIPT type=text/javascript>
using(['window']);//加载window插件
using(['messager']);//加载window插件  


function fileSelect() {
    document.getElementById("fileToUpload").click(); 
}
//删除附件
function showDelete(attachmentId,id,tab1PageNum){
	tatongMethod.confirm("提示","确定要删除吗?",function(){
		location.href="<%=basePath %>transfer/deleteAtach?attachmentId="+attachmentId+"&id=${id}&tab1PageNum=${tab1PageNum}";
	});
}

//删除塔机
function showdeleteOne(goodsId){
	tatongMethod.confirm("提示","确定要删除吗?",function(){
		location.href="<%=basePath %>transfer/deleteGoods?goodsId="+goodsId+"&id=${id}&tab1PageNum=${tab1PageNum}";
	});
}



//图片上传预览    IE是用了滤镜。
function previewImage(file)
{
  var MAXWIDTH  = 260; 
  var MAXHEIGHT = 180;
  var div = document.getElementById('preview');
  if (file.files && file.files[0])
  {
      div.innerHTML ='<img id=imghead  onclick="fileSelect()">';
      var img = document.getElementById('imghead');
      img.onload = function(){
        var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
        img.width  =  rect.width;
        img.height =  rect.height;
        img.style.marginTop = rect.top+'px';
      }
      var reader = new FileReader();
      reader.onload = function(evt){img.src = evt.target.result;}
      reader.readAsDataURL(file.files[0]);
  }
  else //兼容IE
  {
    var sFilter='filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src="';
    file.select();
    var src = document.selection.createRange().text;
    div.innerHTML = '<img id=imghead onclick="fileSelect()">';
    var img = document.getElementById('imghead');
    img.filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
    var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
    status =('rect:'+rect.top+','+rect.left+','+rect.width+','+rect.height);
    div.innerHTML = "<div id=divhead style='width:"+rect.width+"px;height:"+rect.height+"px;margin-top:"+rect.top+"px;"+sFilter+src+"\"'></div>";
  }
}
function clacImgZoomParam( maxWidth, maxHeight, width, height ){
    var param = {top:0, left:0, width:width, height:height};
    if( width>maxWidth || height>maxHeight )
    {
        rateWidth = width / maxWidth;
        rateHeight = height / maxHeight;
         
        if( rateWidth > rateHeight )
        {
            param.width =  maxWidth;
            param.height = Math.round(height / rateWidth);
        }else
        {
            param.width = Math.round(width / rateHeight);
            param.height = maxHeight;
        }
    }
     
    param.left = Math.round((maxWidth - param.width) / 2);
    param.top = Math.round((maxHeight - param.height) / 2);
    return param;
}

//是不是图片
	function isimg(src)
	{
		var ext = ['.gif', '.jpg', '.jpeg', '.png','.bmp'];
		var s = src.toLowerCase();
		var r = false;
		for(var i = 0; i < ext.length; i++)
		{
			if (s.indexOf(ext[i]) > 0)
			{
				r = true;
				break;
			}
		}	
		return r;
	}

	function upload(){
		var src = $("#fileToUpload").val();
		if($("#imgName").val() == ""){
			tatongMethod.alert("提示","请输入名称!");
			return;
		}
		if(src == ""){
			tatongMethod.alert("提示","请先选择本地图片!");
			return;
		}
		else if(!isimg(src)){
			tatongMethod.alert("提示","图片必须gif,jpg,jpeg,png,bmp格式!");
			return;
		}
		else {
			$("#imgForm").submit();
		}
	}

	
	$(document).ready(function() {
		$("#submitButton").on("click",function(){
			
			
			$("#start_address").val($("#come_address").val());
			//设置塔机相关信息
			var towerData={};
			towerData.towerId = $("#towerId").val();
			towerData.towerNo = $("#hideTr").children(":eq(2)").text();
			towerData.createNo = $("#hideTr").children(":eq(3)").text();
			$("#towerData").val(JSON.stringify(towerData));
			var time = $("[name='create_time']").val();
			if(time == ""){
				$("[name='create_time']").after("<span class='apendhtml' style='color: red;margin-left: 5px;'>该项为必输项!</span>");
				return;
			}
			if(tatongMethod.isChecked()){
				tatongMethod.confirm("提示","确定要提交吗!",function(){
					using(['messager'],function(){
						$.messager.progress({text:"正在提交...",interval:500}); 
					}); 
					$("#form").submit();
				});
			}
		})
		
	});
	</SCRIPT>
</head><body>
<jsp:include page="../header-bar.jsp"/>
<div id="main-content">
<form action="<%=basePath %>transfer/addDispatch" method="post" id="form">
<input type="hidden" name="contractId" id="contractId">
<input type="hidden" name="end_address" id="proName">
<input type="hidden" name="template_id" id="template_id" >
<input type="hidden" name="tab" value="${tab }"> 
<input type="hidden" name="tab1PageNum" value="${tab1PageNum }"> 
<input id="start_address" type="hidden" name="start_address">
<input type="hidden" name="towerId" id="towerId">
<input type="hidden" name="partData" id="partData" value="" />
<input type="hidden" name="dispatchAssetType" id="dispatchAssetType" value="" />
<input type="hidden" name="goods_id" id="goods_id" value="" />
<input type="hidden" name="towerData" id="towerData" value="" />
<input type="hidden" name="product_name" id="product_name" value="" />
<input type="hidden" name="goodsInfoId" id="goodsInfoId" value="" />
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>新增调度单</h3>
    </div>
    <!-- End .content-box-header -->
        <div class="content-box-content">
      	<div class="tab-content default-tab" id="tab1">
           <P><b>目的地</b></P>
        <table border="0"  class="edit-table">
            <tr>
              <th scope="row">地点</th>
              <td width="300px"><label>
                <input type="radio" name="dispatchType"  value="项目"   checked="checked"/>
              项目</label>
                <label>
                <input type="radio" name="dispatchType"    value="仓库"/>
                其他</label>
              <a class="button1 button_position" onClick="openwin1()" title="新增"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a></td>
               <th scope="row"><b style="color:#FF0000">*</b>调度时间</th>
              <td><input name="dispatch_time" type="text" required="true"  value='<fmt:formatDate value="${dispatch.dispatch_time }" pattern="yyyy-MM-dd HH:mm:ss"/>' onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});" readonly="readonly"/></td>
            </tr>
            <tr>
              <th scope="row">信息</th>
              <td colspan="3"><input id="input3" type="text" readonly="readonly" value="" style="width:100%"  /></td>
            <!--调度目的地为项目时显示合同编号和项目名称-->
            </tr>
          </table>
          <P><b>调度资产</b><label style="padding-left:61px"> <b style="color:#FF0000">*</b>发出地</label><input   type="text" value="" required="true"  style="margin-left:23px;" readonly="readonly" name="come_address" id="come_address" />
             </P>
        		<table >
            <thead>
              <tr>
                <th  scope="col" class="picture2">&nbsp;</th>
                <th  scope="col">塔机型号</th>
                <th  scope="col">塔机编号</th>
                <th  scope="col">出厂编号</th>
                <th  scope="col">塔机来源</th>
                <th  scope="col">所属公司</th>
                <th  scope="col">管理公司</th>
                <th  scope="col">管理单位</th>
                <!-- <th  scope="col" class="picture2"></th> -->
              </tr>
            </thead>
            <tbody>
              <tr style="display:none" id="hideTr">
                  <td><div align="center">1</div></td>
                <td width="94"><div align="center"></div></td>
                <td width="78"><div align="center"></div></td>
                <td><div align="center"></div></td>
                <td><div align="center"></div></td>
                <td><div align="center"></div></td>
                <td><div align="center"></div></td>
                <td><div align="center"></div></td>
                <%-- <td><div align="center"><a onclick="openwin3()" title="调度零部件"><img src="<%=basePath %>static/images/icons/pencil.png" /></a> <a href="javascript:void(0)" onclick="showdeleteOne(${dispatch.goodsId})" ><img src="<%=basePath %>static/images/icons/cross.png" alt="Delete" /></a></div></td> --%>
              </tr>
              <tr id="addTR">
                <td><a class="button1 button_position" onClick="openwin2()" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a></td>
                <td colspan="10">&nbsp;</td>
              </tr>
            </tbody>
          </table>        
          <table border="0"  class="edit-table">
            <tr>
              <td >&nbsp;</td>
              <td colspan="2"><a class="button_new" href="<%=basePath %>transfer/init/tab1" target="_parent" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a><a class="button_new" href="javascript:void(0)" id="submitButton" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a></td>
            </tr>
          </table>      
          </div>
      </div>
    <!-- End .content-box-content -->
  </div>
  </form>
  <!-- End .content-box -->
  <div class="clear"></div>
</div>
<!-- End #main-content -->
<div id="footer"> <small>達豐中國 地址：上海市长宁区天山西路1068号联强国际D栋4楼 电话:+86 21 60825373 </small><br />
  <br />
  <small>系统开发 Copyright © 2015 上海乔罗网络科技有限公司 </small> </div>
<!-- End #footer -->
</body>
 <script type="text/javascript">

	
 function openwin1(){
		var dispatchType = $("[name='dispatchType']:checked").val();
		if(dispatchType=="项目"){
			dispatchType=1
		}else{
			dispatchType=2
		}
	 window.open('<%=basePath %>transfer/destination?dispatchType='+dispatchType,'newwindow','height=800,width=1200,top=0,left=100,toolbar=0,menubar=0,scrollbar=yes,resizable=yes,location=no,status=no,fullscreen=yes')
 }
 function openwin2(){
		var dispatchType = $("[name='dispatchType']:checked").val();
		if(dispatchType=="项目"){
			dispatchType=1
		}else{
			dispatchType=2
		}
	 //如果没有塔机型号不允许进入下个页面
	var  towerModel = $("#hideTr").children(":eq(1)").children().text();
	 
	towerModel = encodeURI(encodeURI(towerModel));
	var contractId = $("#contractId").val();
	 if(dispatchType==1){
			if(towerModel ==""){
				tatongMethod.alert("提示","调度到项目必须先确定塔机型号!");
				return;
			}
	 }else{
		 if($("#input3").val()==""){
			 tatongMethod.alert("提示","请先选择目的仓库!");
			 return;
		 }
	 }
	 var come_address = encodeURI(encodeURI($("#come_address").val()));
	 var towerId = $("#towerId").val();
	 var goods_id   = $("#goods_id").val();
	 var towerNo = $("#hideTr").children(":eq(2)").children().text();
	 //判断是零部件调度还是塔机调度
	var product_name =  $("#product_name").val();
	var dispatchAssetType = 1;
	 if(product_name=="零部件"){
		 dispatchAssetType = 2;//塔机调度
	 }else{
		 dispatchAssetType = 1;//零部件调度
	 }
	window1 =  window.open('<%=basePath %>transfer/selAsset?towerModel='+towerModel+'&dispatchType='+dispatchType+'&towerNo='+towerNo+'&contractId='+contractId+'&towerId='+towerId+'&come_address='+come_address+'&dispatchAssetType='+dispatchAssetType+'&goods_id='+goods_id,'newwindow','height=800,width=1200,top=0,left=100,toolbar=0,menubar=0,scrollbar=yes,resizable=yes,location=no,status=no,fullscreen=yes')
 }
 
 function openwin3(towerModel){
		var dispatchType = $("[name='dispatchType']:checked").val();
		if(dispatchType=="项目"){
			dispatchType=1
		}else{
			dispatchType=2
		}
		
		if(dispatchType==1){
			if($("#hideTr").children(":eq(2)").children().text() ==""){
				tatongMethod.alert("提示","请先添加塔机需求!");
				return;
			}
		}
		
	var towerModel = $("#hideTr").children(":eq(1)").children().text();
	var towerNo = $("#hideTr").children(":eq(2)").children().text();
	var createNo = $("#hideTr").children(":eq(3)").children().text();
	var contractId = $("#contractId").val();
	var come_address = encodeURI(encodeURI($("#come_address").val()));
	 window.open('<%=basePath %>transfer/departmentAdd?towerModel='+towerModel+"&contractId="+contractId+"&towerNo="+towerNo+'&createNo='+createNo,'newwindow','height=800,width=1200,top=0,left=100,toolbar=0,menubar=0,scrollbar=yes,resizable=no,location=no,status=no,fullscreen=yes')
	 }
 </script>
</html>