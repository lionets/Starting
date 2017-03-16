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
<!-- Reset Stylesheet -->
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
<script src="<%=basePath %>static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
<script type="text/javascript">
using(['messager']);
var pdocument = window.opener.document;

function showParts(id){
	var tbodyId = "levelTow"+id;
	$("#"+tbodyId).show();
	$("#"+tbodyId).siblings("tbody").hide();
}


//数组中是否包含
function iscontains(array,value){
	var flag = false;
	for(var i=0; i<array.length; i++){
		if(array[i] == value){
			flag = true;
		}
	}
	return flag;
}

$(function(){
	//提交表单数据
	$("#submitButton").on("click",function(){
		var jsonDate = {};
		jsonDate.id="${id}";
		var parts = [];
		var data = $("tr[partid]").filter("[partid != '']");
		for(var i=0; i<data.length; i++){
			var one = {};
			var partid = $(data[i]).attr("partid");
			var num = $(data[i]).find("input").last().val();
			one.partid=partid;
			one.num=num;
			parts[i]=one;
		}
		jsonDate.parts = parts;
		$("#partDate",pdocument).val(JSON.stringify(jsonDate));
		window.close();
        //ajax请求将表单域直接序列化
//        $.messager.progress({title:"请稍等",text:"正在提交",interval:100}); 
/*        $.ajax( {
                type : "POST",
                url : "<%=basePath %>transfer/updateDispatchPart",
                data : "data="+JSON.stringify(jsonDate),
                success : function() {
                    $.messager.progress("close"); 
                    tatongMethod.alert("提示","修改成功!");
                },
                error : function(html) {
                    $.messager.progress("close"); 
                    tatongMethod.alert("错误","服务器遇到问题");
                }
            });  */
	})
})

</script>
</head>
<body>
<div id="main-content">
  <form method="post" action="<%=basePath %>transfer/updateDispatchPart" style="display:none">
  		<input type="hidden" name="data" id="data">
  </form>
  <div class="clear"></div>
  <!-- End .clear -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
      <h3> 可调部件</h3>
    </div>
   <div class="content-box-content" >
        <table border="0" class="edit-table">
            <tr>
              <th>发出地</th>
              <td  ><input   type="text" name="link" readonly="readonly" value="${come_address }" />
                </td>
              <th>塔机型号
               </th>
              <td>${dispatch.tower_model }</td>

              <th>塔机编号
                  </th>
              <td>${dispatch.tower_no } </td>
              <th>出厂编号
                 </th>
              <td>${dispatch.tower_factoryno }</td>
             </tr>
            </table>
            
             <div  style="width:1160px">
      <div class="lefttable" style="float:left; clear:left;overflow:auto; overflow-x:hidden; height:540px;">
       <p>
          <label> <b>主要部件</b>(选择左侧列表的主要部件名称，系统自动带出右侧相关零部件清单。)</label></p>
        <table   id="mainPartTable">
          <thead>
            <tr>
              <th scope="col" class="picture2"></th>
              <th  scope="col" width="133">主要部件</th>
              <th  scope="col"  width="41">型号</th>
              <th  scope="col"  width="39">需求</th>
              <th  scope="col"  width="39">可调</th>
              <th  scope="col"  width="72">调度</th>
              <th  scope="col"  width="39">单位</th>
              <!-- <th  scope="col"  width="29"></th> -->
            </tr>
          </thead>
          <tbody>
          <c:forEach var="part"  items="${part2Detail}" varStatus="status" >
            <tr   pid="${part.pid }" partid="${part.id }" >
              <td><div align="center">
                  <script type="text/javascript">
		          	var num =	${status.index+1};
		          	document.write(num);
		          </script>
              </div></td>
               <td><a href="javascript:showParts(${part.id})" class="chick_a current1">${part.part_name }</a></td>
              <td>${part.part_model}</td>
              <td> ${part.needNum<0||part.needNum==null?0:part.needNum}</td>
              <td>${part.maxNum<0||part.maxNum==null?0+part.dispatchNum:part.maxNum+part.dispatchNum}</td>
              <td><input name="Input" type="text" value="${part.dispatchNum<0||part.dispatchNum==null?0:part.dispatchNum}" class="picture2r"/></td>
              <td>${part.part_unit}</td>
                <%-- <td align="center"><a href="javascript:void(0)"   class="deleteLevel2One"><img src="<%=basePath %>static/images/icons/cross.png" alt="删除" title="删除"/></a></td> --%>
            </tr>
          </c:forEach>
 <%--             <tr>
          <td> <a class="button1 button_position addOneLevelTow" href="javascript:void(0)" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a></td>
          <td colspan="8"></td>
                </tr> --%>
          </tbody>
        </table>
      </div>
      <div style="float:left;clear:right;overflow:auto; margin-left:10px;overflow-x:hidden;height:540px; width:550px;">
       
        <p>
          <label> <b> 零部件</b></label>
         </p>
         <div>
      <div id="tab1" class="tab-content default-tab">
        </div>
         <div id="tab2" class="tab-content" >
        <table  id="partTable">
          <thead>
            <tr>
              <th scope="col" class="picture2"></th>
              <th  scope="col" width="133">部件名称</th>
              <th  scope="col"  width="41">型号</th>
              <th  scope="col"  width="39">需求</th>
              <th  scope="col"  width="39">可调</th>
              <th  scope="col"  width="72">调度</th>
              <th  scope="col"  width="39">单位</th>
              <!-- <th  scope="col"  width="29"></th> -->
            </tr>
          </thead>
          <c:forEach var="partTow"  items="${part2Detail}" varStatus="status" >
			<script type="text/javascript">
	          	var num = 1;
	     	</script>
				<tbody  id="levelTow${partTow.id }"  class="tbody" <c:if test="${status.index!=0}">style="display:none"</c:if> >
					<c:forEach var="partThree"  items="${part3Detail}" varStatus="status" >
			   		  	<c:choose>
						       <c:when test="${partThree.pid==partTow.id}">
						       <script>
						       </script>
							            <tr  pid="${partThree.pid }" partid="${partThree.id }" >
							              <td><div align="center">
							              	<script type="text/javascript">
										          	document.write(num++);
										     </script>
							              </div></td>
							              <td>${partThree.part_name }</td>
							              <td>${partThree.part_model}</td>
							              <td>
							              ${partThree.needNum<0||partThree.needNum==null?0:partThree.needNum}
							              </td>
							              <td>${partThree.maxNum<0||partThree.maxNum==null?0+partThree.dispatchNum:partThree.maxNum+partThree.dispatchNum}</td>
							              <td><input name="Input" type="text" value="${partThree.dispatchNum<0||partThree.dispatchNum==null?0:partThree.dispatchNum}" class="picture2r"/></td>
							               <td>${partThree.part_unit}</td>
							               <%-- <td align="center"><a href="javascript:void(0)"   class='deleteOne'><img src="<%=basePath %>static/images/icons/cross.png" alt="删除" title="删除"/></a></td> --%>
							            </tr>
							         </c:when>
						</c:choose>
					</c:forEach>
	<%-- 					  <tr>
					          <td> <a class="button1 button_position addOneLevelThree" href="javascript:void(0)" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a></td>
					          <td colspan="7"></td>
					    </tr> --%>
			     </tbody>
       </c:forEach>
          
          
          <%-- <tbody>
            <tr>
              <td><div align="center">1</div></td>
              <td>标准节</td>
              <td>L68B1</td>
              <td>1</td>
              <td>1</td>
              <td><input  readonly="readonly" name="Input" type="text" value="1" class="picture2r"/></td>
              <td>&nbsp;</td>
              <td align="center"><a href="#" onclick="showdelete()"><img src="<%=basePath %>static/images/icons/cross.png" alt="删除" title="删除"/></a></td>
            </tr>
            <tr>
              <td><div align="center">2</div></td>
              <td>电源电缆</td>
              <td>YCW3*35+2</td>
              <td>2</td>
              <td>1</td>
              <td><input  readonly="readonly" name="Input" type="text" value="1" class="picture2r"/></td>
              <td>&nbsp;</td>
              <td align="center"><a href="#" onclick="showdelete()"><img src="<%=basePath %>static/images/icons/cross.png" alt="删除" title="删除"/></a></td>
            </tr>
             <tr>
          <td> <a class="button1 button_position" href="#" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a></td>
          <td colspan="7"></td>
                </tr>
          </tbody> --%>
        </table>
        </div>
        <div id="tab3" class="tab-content">
        </div>
         <div id="tab4" class="tab-content" >
        </div>
        </div>
        </div>
        </div>
        <table border="0" class="edit-table">
          <tr>
            <td>&nbsp;</td>
            <td colspan="2"><a class="button_new" onclick="window.close()" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a><a class="button_new" href="javascript:void(0)" id="submitButton" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a></td>
          </tr>
        </table>
      </div>
    </div>

</div>
</body>
</html>
