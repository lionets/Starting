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
	var dispatch_type=encodeURI(encodeURI('${dispatch.dispatch_type}'));
	tatongMethod.confirm("提示","确定要删除吗?",function(){
		location.href="<%=basePath %>transfer/deleteAtach?attachmentId="+attachmentId+"&id=${id}&tab1PageNum=${tab1PageNum}&dispatch_type="+dispatch_type;
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
      div.innerHTML ='<img id="imghead"  onclick="fileSelect()" style="width:100px; height:100px; padding-left:30px;margin-top:0px;">';
      var img = document.getElementById('imghead');
      img.onload = function(){
        var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
        img.width  =  rect.width;
        img.height =  rect.height;
        //img.style.marginTop = rect.top+'px';
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
    div.innerHTML = '<img id="imghead" onclick="fileSelect()" style="width:100px; height:100px; padding-left:30px;;margin-top:0px;">';
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
		var attachId  = $("#attachId").val();
		//如果是选择的修改
		if(attachId!=""){
			if($("#imgName").val() == ""){
				tatongMethod.alert("提示","请输入名称!");
				return;
			}
			$("#imgForm").submit();
		}
		else{
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
	}
	$(document).ready(function() {
		$("#submitButton").on("click",function(){
			var time = $("[name='create_time']").val();
			if(time == ""){
				$("[name='create_time']").after("<span class='apendhtml' style='color: red;margin-left: 5px;'>该项为必输项!</span>");
				return;
			}
			tatongMethod.confirm("提示","确定要提交吗!",function(){
				using(['messager'],function(){
				    $.messager.progress({text:"正在提交...",interval:500}); 
				});   
				$("#formid").submit();
			});
		})
	});
	
	function editAttach(name,id, attach){
		$("#imgName").val(name);
		$("#imghead").attr("src","<%=basePath%>static/upload/"+attach);
		$("#attachId").val(id);
	}
	
	</SCRIPT>
</head><body>
<jsp:include page="../header-bar.jsp"/>
<div id="main-content">
  <!-- Main Content Section with everything -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3>编辑调度单</h3>
    </div>
    <!-- End .content-box-header -->
        <div class="content-box-content">
        
        
      	<div class="tab-content default-tab" id="tab1">
      	<form id="formid" action="<%=basePath %>transfer/updateDispatch" method="post">
             <input type="hidden" name="id"  readonly="readonly" value="${id }"/>
             <input type="hidden" name="tab1PageNum"  readonly="readonly" value="${tab1PageNum }"/>
             <input type="hidden" name="tab"  readonly="readonly" value="tab1"/>
             <input type="hidden" name="partData" id="partData">
             <input name="dispatch_type" id="dispatch_type" value='${dispatch.dispatch_type}' type="hidden" />
             <input name="come_address" id="dispatch_type" value='${dispatch.start_address}' type="hidden" />
              <table  class="edit-table" border="0">
            <tr>
              <th scope="row">调度单号</th>
              <td width="300px"><input type="text"  readonly="readonly" value="${dispatch.dispatch_no }"/></td>
              <th scope="row">调度时间</th>
              <td><input name="dispatch_time" requied="true"  type="text" value='<fmt:formatDate value="${dispatch.dispatch_time }" pattern="yyyy-MM-dd HH:mm:ss"/>' onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});" readonly="readonly"/></td>
            </tr>
          </table>
          </form>
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
              <a class="button1 button_position" onClick="" title="新增"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a></td>
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
          <P><b>调度资产</b><label style="padding-left:61px"> <b style="color:#FF0000">*</b>发出地</label><input   type="text" value=" ${dispatch.start_address }" readonly="readonly" style="margin-left:23px;" list="fachu_list" name="link" /></P>
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
                <script type="text/javascript">
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
                <td><div align="center">${dispatch.manageCompany }</div></td>
                <td><div align="center">${dispatch.department_name }</div></td>
                <td><a onclick="openwin2('${dispatch.contact_id }')" href='javascript:void(0)' class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" alt="编辑" title="编辑"/></a></td>
              </tr>
            </tbody>
          </table>
           <P><b>装车单</b></P>
          <table border="0"  class="edit-table">
            <tr>
              <th  scope="row">上传</th>
           <form action="<%=basePath %>transfer/uploadImg?id=${id }&tab1PageNum=${tab1PageNum}" id="imgForm" method="post" enctype="multipart/form-data">
              <td width="250" ><label>名称</label>
                <input name="attachment_name" id="imgName" type="text" />
                <input name="dispatch_type" id="dispatch_type" value='${dispatch.dispatch_type}' type="hidden" />
                <a class="button_new" href="javascript:upload()" title="上传">上传</a>
                <br/><br/>
			<div id="preview">
		   		 <img id="imghead" onclick="fileSelect()" src="<%=basePath %>static/upload/select.jpg"  style="width:100px; height:100px; padding-left:30px;;margin-top:0px;">
			</div>
    		<input type="file" name="fileToUpload" id="fileToUpload" onchange="previewImage(this)" style="display:none;">
    		<input type="hidden" name="attachId" id="attachId" value="">
    		<input type="hidden" name="updateFilename" id="updateFilename" value="">
              </td>
              </form>
              <td><table>
                <thead >
                  <tr>
                    <td scope="col" class="chebox">&nbsp;</td>
                    <td style="font-weight:bold"><div align="center">名称</div></td >
                    <td style="font-weight:bold"><div align="center">图片</div></td >
                    <td style="font-weight:bold"><div align="center">时间</div></td >
                    <td class="picture2">&nbsp;</td >
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
			              <td><div align="center"><a><img onclick="openImg(this)" width="20px" src="<%=basePath %>static/upload/${dispatchAttachment.attachment_path }" height="20px"/></a></div></td>
			              <td><div align="center">
			              <fmt:formatDate value="${dispatchAttachment.attachment_time }" pattern="yyyy-MM-dd HH:mm:ss"/>
			              </div></td>
			              <td><div align="center"><a href="javascript:editAttach('${dispatchAttachment.attachment_name }','${dispatchAttachment.id }','${dispatchAttachment.attachment_path }')" title="Edit" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" alt="Edit" /></a> <a href="javascript:showDelete(${dispatchAttachment.id },${id },${tab1PageNum})" title="删除" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" alt="Delete" /></a></div></td>
			            </tr>
	             </c:forEach>
              </table></td>
            </tr>
            <tr>
              <td >&nbsp;</td>
              <td colspan="2"><a class="button_new" href="<%=basePath %>transfer/init/tab1" target="_parent" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a><a class="button_new" href="javascript:void(0)" id="submitButton" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a></td>
            </tr>
          </table>      
          </div>
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
 <script type="text/javascript">

 function openwin1(){
	 window.open('<%=basePath %>transfer/destination','newwindow','height=700,width=1000,top=0,left=100,toolbar=0,menubar=0,scrollbar=yes,resizable=no.location=no,status=no')
 }
 function openwin2(){
	var come_address =  encodeURI(encodeURI('${dispatch.start_address }'));
	var goods_id = '${dispatch.goods_id}';
	 window.open('<%=basePath %>transfer/assetedit?dispatch_id=${id}&come_address='+come_address+'&template_id=${dispatch.template_id}'+'&dispatch_type=${dispatch.dispatch_type=="项目"?"1":"2" }'+'&goods_id='+goods_id,'newwindow','height=800,width=1200,top=0,left=100,toolbar=0,menubar=0,scrollbar=yes,resizable=yes,location=no,status=no,fullscreen=yes')
	 } 
 
 function openwin3(contract_id){
		var  come_address= encodeURI(encodeURI('${dispatch.start_address }'));
	 window.open('<%=basePath %>transfer/department?id=${id}&contract_id='+contract_id+'&come_address='+come_address,'newwindow','height=800,width=1200,top=0,left=100,toolbar=0,menubar=0,scrollbar=yes,resizable=no,location=no,status=no,fullscreen=yes')
	 }
 
 
 function openImg(img){
		window.open(img.src,'newwindow','height=600,width=800,top=0,left=100,toolbar=0,menubar=0,scrollbar=yes,resizable=no,location=no,status=no,fullscreen=yes')
	}
 </script>
</html>