<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></SCRIPT>
<script type="text/javascript" src='<%=basePath %>static/js/UTIL.js'></script>
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
<script type="text/javascript">

	$(document).ready(function() {
		
		$("#towerButton").on("click",function(){
			$("#towerForm").submit();
			//document.forms[0].submit();
			//onTowerSubmit();
		});
		$("#reportAddButton").on("click",function(){
			$('#reportName2').val($('#reportName1').val());
			$("#reportForm").submit();
			/* if(src == ""){
				$.messager.alert("提示","请先选择本地图片!");
			}else if(!isimg(src)){
				$.messager.alert("提示","图片必须gif,jpg,jpeg,png,bmp格式!");
			}else {
				$("#reportForm").submit();
			} */
		});
		$('#editReportDiv').dialog({
			title: '编辑检测报告',
			width: 600,
			height: 400,
			closed: true,
			cache: false,
			modal: true,
			buttons:[{
				text:'保存',
				handler:function(){
					$("#reportEditForm").submit();
					/* var src = $('#fileToUpload5').val();//获取图片路径
					if(src == ""){
						$.messager.alert("提示","请先选择本地图片!");
					}else if(!isimg(src)){
						$.messager.alert("提示","图片必须gif,jpg,jpeg,png,bmp格式!");
					}else {
						$("#reportEditForm").submit(); 
					} */
				}
			},{
				text:'取消',
				handler:function(){
					$('#editReportDiv').dialog('close');
				}
			}]
		});
		
	});
	function editReport(obj){
		$("#imghead5").attr("src",$(obj).parent().parent().find('td:eq(2)').children('img').attr("src"));
		$("#editName").val($(obj).parent().parent().find('td:eq(1)').text());
		$("#reportId").val($(obj).parent().parent().find('td:eq(0)').children('input').val());
		$('#editReportDiv').dialog('open');
	}
	function delReport(obj){
		$.messager.confirm('检查报告', '您确定删除此检查报告？', function (yes) {
			if(yes == true){
				var id = $(obj).parent().parent().find('td:eq(0)').children('input').val();
				$.ajax({
					async : false,
					cache : false,
					type : 'POST',
					data :{"reportId":id},
					url :'<%=basePath %>tower/delReport',
					error : function() {// 请求失败处理函数
						$.messager.alert('错误','删除请求提交失败!','error');
					},
					success : function(data){
						if('n' == data){
							$.messager.alert('失败','检查报告删除失败!','error');
						}else{
							$.messager.alert('成功','检查报告删除成功!','info',function(){
								window.location.href = '<%=basePath %>tower/editFind?towerId=${manage.id }';
							});
						}
					}
				});
			}
		});
	}
	function onTowerSubmit(){
		$.ajax({
			async : false,
			cache : false,
			type : 'POST',
			data :$("#towerForm").serialize(),
			url :'<%=basePath %>tower/editSave',
			error : function() {// 请求失败处理函数
				$.messager.alert('错误','保存请求提交失败!','error');
			},
			success : function(data){
				if('n' == data){
					$.messager.alert('失败','塔机信息保存失败!','error');
				}else{
					$.messager.alert('成功','塔机信息保存入库成功!','info',function(){
						window.location.href = '<%=basePath %>tower/init/2';
					});
				}
			}
		});
	}
	function openwin(towerId){
		var resultValue =  window.showModalDialog('<%=basePath %>parts/queryTowerPart?towerId='+towerId,'',"dialogWidth=1200px;dialogHeight=550px");
	}
	var nums;
	function fileSelect(num) {
		nums = num;
	    document.getElementById("fileToUpload"+nums).click(); 
	}
	//图片上传预览    IE是用了滤镜。
	function previewImage(file)
	{
	  var MAXWIDTH  = 260; 
	  var MAXHEIGHT = 180;
	  var div = document.getElementById('preview'+nums);
	  if (file.files && file.files[0])
	  {
	      div.innerHTML ='<img id="imghead'+nums+'"  onclick="fileSelect('+nums+')" style="width:100px; height:100px; padding-left:30px;margin-top:0px;">';
	      var img = document.getElementById('imghead'+nums);
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
	    div.innerHTML = '<img id="imghead'+nums+'" onclick="fileSelect('+nums+')" style="width:100px; height:100px; padding-left:30px;;margin-top:0px;">';
	    var img = document.getElementById('imghead'+nums);
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

		function openImg(src){
			window.open(src,'newwindow','height=600,width=800,top=0,left=100,toolbar=0,menubar=0,scrollbar=yes,resizable=no,location=no,status=no,fullscreen=yes')
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
      <h3>塔机资料</h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content default-tab" id="tab1">
        <form id="towerForm" name="towerForm" action="<%=basePath %>tower/editSave" method="post" enctype="multipart/form-data">
          <table border="0" class="edit-table">
            <tr>
              <th><label ><b>*</b>塔机编号 </label></th>
              <td width="300px">
              <input name="towerManageNo" value="${manage.towerManageNo }" type="text" readonly="readonly" />
              <input name="id" type="hidden" value="${manage.id }"/>
              </td>
              <th scope="row"><label ><b>*</b>塔机型号</label></th>
              <td>
              <input name="towerModel" id="towerModel" value="${info.towerModel }" type="text" readonly="readonly" />
              </td>
            </tr>
            <tr>
              <th scope="row">说明书</th>
              <td><input name="check1" type="checkbox" <c:if test="${info.check1 == true}">checked="checked"</c:if> value="1" />
              &nbsp;</td>
              <th scope="row">&nbsp;</th>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <th scope="row">合格证</th>
              <td align="center"><input name="check2" type="checkbox" <c:if test="${info.check2 == true}">checked="checked"</c:if> value="1" />
                  <div id="preview1">
                  <c:choose>
                  <c:when test="${info.check2Icon != null}">
                  <img id="imghead" onclick="fileSelect(1)" src="<%=basePath %>static/upload/tower/${info.check2Icon}"  style="width:100px; height:100px; padding-left:30px;;margin-top:0px;">
                  <a onclick="openImg('<%=basePath %>static/upload/tower/${info.check2Icon}')" class="view"><img src="<%=basePath %>static/images/icons/view.png" title="查看"/></a>
                  </c:when>
                  <c:otherwise>
                  <img id="imghead" onclick="fileSelect(1)" src="<%=basePath %>static/upload/select.jpg"  style="width:100px; height:100px; padding-left:30px;;margin-top:0px;">
                  </c:otherwise>
                  </c:choose>
				</div>
	    		<input type="file" name="fileToUpload1" id="fileToUpload1" onchange="previewImage(this)" style="display:none;"></td>
              <th scope="row">监检证</th>
              <td  valign="middle"><input name="check3" type="checkbox" <c:if test="${info.check3 == true}">checked="checked"</c:if> value="1" />
                  <div id="preview2">
                  <c:choose>
                  <c:when test="${info.check3Icon != null}">
                  <img id="imghead" onclick="fileSelect(2)" src="<%=basePath %>static/upload/tower/${info.check3Icon}"  style="width:100px; height:100px; padding-left:30px;;margin-top:0px;">
                  <a onclick="openImg('<%=basePath %>static/upload/tower/${info.check3Icon}')" class="view"><img src="<%=basePath %>static/images/icons/view.png" title="查看"/></a>
                  </c:when>
                  <c:otherwise>
                  <img id="imghead" onclick="fileSelect(2)" src="<%=basePath %>static/upload/select.jpg"  style="width:100px; height:100px; padding-left:30px;;margin-top:0px;">
                  </c:otherwise>
                  </c:choose>
				</div>
	    		<input type="file" name="fileToUpload2" id="fileToUpload2" onchange="previewImage(this)" style="display:none;"></td>
            </tr>
            <tr>
              <th scope="row">产权证</th>
              <td  valign="middle"><input name="check4" type="checkbox" <c:if test="${info.check4 == true}">checked="checked"</c:if> value="1" />
                  <div id="preview3">
                  <c:choose>
                  <c:when test="${info.check1Icon != null}">
                  <img id="imghead" onclick="fileSelect(3)" src="<%=basePath %>static/upload/tower/${info.check1Icon}"  style="width:100px; height:100px; padding-left:30px;;margin-top:0px;">
                  <a onclick="openImg('<%=basePath %>static/upload/tower/${info.check1Icon}')" class="view"><img src="<%=basePath %>static/images/icons/view.png" title="查看"/></a>
                  </c:when>
                  <c:otherwise>
                  <img id="imghead" onclick="fileSelect(3)" src="<%=basePath %>static/upload/select.jpg"  style="width:100px; height:100px; padding-left:30px;;margin-top:0px;">
                  </c:otherwise>
                  </c:choose>
				</div>
	    		<input type="file" name="fileToUpload3" id="fileToUpload3" onchange="previewImage(this)" style="display:none;"></td>
              <th scope="row">检测报告</th>
              <td >
                <table>
                <thead>
                  <tr>
	              <td><input name="input" type="checkbox" /></td>
	              <td colspan="2">
	              	<label>报告名称</label>
	                <input id="reportName1" type="text" required="true"/>
	              </td>
	              <td>
	              	<div id="preview4">
	                <img id="imghead" onclick="fileSelect(4)" src="<%=basePath %>static/upload/select.jpg" width="60px" height="60px">
	                </div>
	              </td>
	              <td><a class="button_new" id="reportAddButton" title="保存">保存</a></td>
	              </tr>
                </thead>
                <tbody>
                <tr>
                    <td>项次</td>
                    <td>报告名称</td>
                    <td>图片</td>
                    <td>时间</td>
                    <td class="picture2">编辑</td>
                </tr>
                <c:forEach items="${reportList }" var="report" varStatus="num">
                <tr>
                    <td>${num.index+1 }
                    <input type="hidden" value="${report.id }"/>
                    </td>
                    <td>${report.reportName }</td>
                    <td><img width="30px" height="30px" src="<%=basePath %>static/upload/tower/${report.reportIcon }" onclick="openImg('<%=basePath %>static/upload/tower/${report.reportIcon}')"/></td>
                    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${report.submitDate}" type="both" /></td>
                    <td>
                    <a onclick="editReport(this)" title="Edit" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" alt="Edit" /></a> 
                    <a onclick="delReport(this)" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" alt="Delete" /></a>
                    </td>
                  </tr>
                </c:forEach>
                </tbody>
                </table>
              </td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td colspan="3">
              <a class="button_new" href="<%=basePath %>tower/init/2" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a>
              <a class="button_new" id="towerButton" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a>
              <%-- <a class="button_new" href="#" title="审核"><img src="<%=basePath %>static/images/icons/check_icons.png" class="px18"/></a> --%>
              <a class="button_new" onclick="openwin(${manage.id });" title="零部件"><img src="<%=basePath %>static/images/icons/parts.png" class="px18"/></a> </td>
            </tr>
          </table>
        </form>
      </div>
      <!-- End #tab1 -->
      <div id="editReportDiv" class="easyui-dialog">
		<form id="reportEditForm" action="<%=basePath %>tower/editReport" method="post" enctype="multipart/form-data">
		<table class="edit-table">
		<tr>
		<th>报告名称</th>
		<td><input id="editName" name="reportName" />
		<input type="hidden" name="id" id="reportId"/>
		<input type="hidden" name="towerId" value="${manage.id }"/>
		</td>
		</tr>
		<tr>
		<th>图片</th>
		<td>
		<div id="preview5">
		<img id="imghead5" onclick="fileSelect(5)" width="60px" height="60px">
		</div>
        <input type="file" name="fileToUpload5" id="fileToUpload5" onchange="previewImage(this)" style="display:none;">
		</td>
		</tr>
		</table>
		</form>
	  </div>
	  <div style="display:none;">
	  <form id="reportForm" name="reportForm" action="<%=basePath %>tower/addReport" method="post" enctype="multipart/form-data">
		<input name="towerId" value="${manage.id }"/>
		<input id="reportName2" name="reportName"/>
		<input type="file" name="fileToUpload4" id="fileToUpload4" onchange="previewImage(this)" style="display:none;">
	  </form>
	  </div>
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