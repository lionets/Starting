<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String path = request.getContextPath();
	String basePath =  path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title>塔机动态管理系统</title>
<!--                       CSS                       -->
<!-- Reset Stylesheet -->
<!-- 分页css -->
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
using(['window'],function(){});//加载window插件
	//分页点击执行的操作
 	function changePage(index,jq){
		 if(jq.attr("id")=="pagination2"){
				$("#tab2PageNum").val(index);
				$("#tab2PerPage").val(tab2PerPage);
				$("#form2").submit();
		 }
		 if(jq.attr("id")=="pagination3"){
				$("#tab3PageNum").val(index);
				$("#tab3PerPage").val(tab3PerPage);
				$("#form3").submit();
		 }
		 if(jq.attr("id")=="pagination4"){
				$("#tab4PageNum").val(index);
				$("#tab4PerPage").val(tab4PerPage);
				$("#form4").submit();
		 }
	} 
	//分页初始化传入id代表要创建分页的id号，参数count代表总数量，perPage表示每页显示条数,current_page为当前页
	function initPagination(id,count,perPage,current_page) {
		$("#"+id).pagination(count, {
			items_per_page:perPage, //每页显示数目
			num_edge_entries:4,//边缘页后面显示数目
			num_display_entries:4,//边缘页前面显示数目
			current_page:current_page,//显示第1页
			prev_text:"上页",
			next_text:"下页",
			ellipse_text:"...",//中间缺省内容
			prev_show_always:true,
			next_show_always:true,
			show_if_single_page:true,
			callback:changePage,
			load_first_page:false,
		});
	 };
	 
	 //控制应该显示的面板
	var togle =	function(tab){
			$("#"+tab).siblings().hide();
			$("#a"+tab).addClass("current");
			$("#"+tab).show();
			if(tab=="tab2"){
				initPagination("pagination2","${count}",10,tab2PageNum);
			}
			if(tab=="tab3"){
				initPagination("pagination3","${count}",10,tab3PageNum);
			}
			if(tab=="tab4"){
				initPagination("pagination4","${count}",10,tab4PageNum);
			}
		}

	//删除一条记录
	function showdelete(id,tab,count){
		tatongMethod.confirm("删除","确定要删除吗?",function(){
			var url = "<%=basePath %>part/deleteOne/"+tab+"?id="+id;
			 if(tab=="tab2"){
				 if("${count}"%tab2PerPage ==1){
					 tab2PageNum --;
					 if(tab2PageNum <0){
						 tab2PageNum=0;
					 }
				 }
				 $("#tab2PageNum").val(tab2PageNum);
				 $("#tab2PerPage").val(tab2PerPage);
				 $("#form2").attr("action",url);
				 $("#form2").submit();
			 }
			 if(tab=="tab3"){
				 if("${count}"%tab3PerPage ==1){
					 tab3PageNum --;
					 if(tab3PageNum <0){
						 tab3PageNum=0;
					 }
				 }
				 $("#tab3PageNum").val(tab3PageNum);
				 $("#tab3PerPage").val(tab3PerPage);
				 $("#form3").attr("action",url);
				 $("#form3").submit();
			 }
			 
			 if(tab=="tab4"){
					url = "<%=basePath %>company/deleteOne/"+tab+"?id="+id;
				 if("${count}"%tab4PerPage ==1){
					 tab4PageNum --;
					 if(tab4PageNum <0){
						 tab4PageNum=0;
					 }
				 }
				 $("#tab4PageNum").val(tab4PageNum);
				 $("#tab4PerPage").val(tab4PerPage);
				 $("#form4").attr("action",url);
				 $("#form4").submit();
			 }
		})
	}
	

	//公共资料分页
	var tab4PageNum = "${tab4PageNum}"==""?0:"${tab4PageNum}";
	var tab4PerPage =  "${tab4PerPage}"==""?10: "${tab4PerPage}";

	//用户管理分页
	var tab2PageNum = "${tab2PageNum}"==""?0:"${tab2PageNum}";
	var tab2PerPage =   "${tab2PerPage}"==""?10: "${tab2PerPage}";
	
	//职务管理分页
	var tab3PageNum = "${tab3PageNum}"==""?0:"${tab3PageNum}";
	var tab3PerPage =   "${tab3PerPage}"==""?10: "${tab3PerPage}";

	$(document).ready(function() {
		//控制显示的面板
		var tab = "${tab}";
		//根据点击的id发送请求
		$(".atab").on("click",function(){
			 var url = "<%=basePath %>part/init/"+$(this).attr("name");
			 if($(this).attr("name")=="tab2"){
				 url += "?tab2PageNum="+tab2PageNum+"&tab2PerPage="+tab2PerPage;
			 }
			 if($(this).attr("name")=="tab3"){
				 url += "?tab3PageNum="+tab3PageNum+"&tab3PerPage="+tab3PerPage;
			 }
			 if($(this).attr("name")=="tab4"){
				 url = "<%=basePath %>company/init/"+$(this).attr("name");
				 url += "?tab4PageNum="+tab4PageNum+"&tab4PerPage="+tab4PerPage;
			 }
			 location.href= url;
		})
		togle(tab);
	});
	</SCRIPT>
</head>
<body>
<jsp:include page="../header-bar.jsp"/>
<div id="main-content">
  <div class="clear"></div>
  <!-- End .clear -->
  <div class="content-box">
    <!-- Start Content Box -->
    <div class="content-box-header">
     <ul class="content-box-tabs">
        <li> <a href="#tab4" id="atab4" name="tab4"  class="atab"> <h4>公共资料</h4></a></li>
        <li><a href="#tab2" id="atab2" name="tab2" class="atab"> <h4>部件管理</h4></a></li>
        <li> <a href="#tab3" id="atab3" name="tab3"  class="atab"> <h4>部件模块</h4></a></li>
      </ul>
      <div class="clear"></div>
      <h3></h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
    <c:if test='${tab=="tab4" }'>
       <div class="tab-content" id="tab4">
             <form id="form4" action="<%=basePath %>company/init/tab4" method="post">
             <input type="hidden" id="tab4PageNum" name="tab4PageNum" value="0">
			 <input type="hidden" id="tab4PerPage" name="tab4PerPage" value="10">
          <div class="search-actions">
            <div class="search-condition">
              <table class="seach-table">
                <tr>
                  <td><label>词组类别:</label></td>
      <td>
             	<select  name="czid" id="dutyid1" class="easyui-combobox">
             		<option value="0">不限</option>
             		<option <c:if test="${czid==-1 }">selected="selected"</c:if> value="-1">（词组类别）</option>
             		<c:forEach var="cz"  items="${czlist}" varStatus="status" >
             			<option <c:if test="${czid==cz.id }">selected="selected"</c:if> value="${cz.id }">${cz.dictValue }</option>
             		</c:forEach>
					
					
					<!-- <option value="资产名称">资产名称</option>
					<option value="标准节">标准节</option> -->
					<!-- <script type="text/javascript">
						$("#dutyid").val("${wordClass }");
					</script> -->
			   </select>           
      </td>
      <td><label>词组名称:</label></td>
      <td ><input name="czval" type="text" value="${czval }">&nbsp;</td>
      </tr>
  </table>
</div>
            <div class="search-button"> <a class="button button_position" onclick="document.getElementById('form4').submit();return false"  href="javascript:void(0)" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a> <a class="button button_position" href="<%=basePath %>common/addInit?tab=tab4&tab4PageNum=${tab4PageNum}&tab4PerPage=${tab4PerPage}" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a> </div>
            <div class="clear"></div>
          </div>
        </form>
        <table>
          <thead>
          <tr>
            <th scope="col" class="chebox">项次</th>
            <th  scope="col">词组类别</th>
            <th  scope="col">词组中文名称</th>
            <th  scope="col">词组繁体中文名称</th>
            <th  scope="col">词组英文名称</th>
            <th  scope="col">最后修改时间</th>
            <th  scope="col" class="time">最后修改人</th>
            <th  scope="col" class="time">描述</th>
            <th  scope="col" class="picture2">编辑</th>
            </tr>
            </thead><tbody>
             <c:forEach var="publicInfo"  items="${publicInfoList}" varStatus="status" >
	           <tr>
	              <td>
						<script type="text/javascript">
				          	var num =	${status.index+1}+tab4PageNum* tab4PerPage;
				          	document.write(num);
				          </script>
		           </td>
				  <%-- <td>${publicInfo.wordClass }</td>
				  <td>${publicInfo.wordCnName }</td>
				  <td>${publicInfo.wordEnName }</td>
				  <td> <fmt:formatDate value="${publicInfo.modifyTime}" pattern="yyyy年MM月dd日 HH:mm:ss" /></td>
				  <td>${publicInfo.modifyBy }</td>
				  <td>${publicInfo.publicDesc }</td> --%>
				  <td>${publicInfo.dictModuleValue }</td>
				  <td>${publicInfo.dictValue }</td>
				  <td>${publicInfo.dictValueT }</td>
				  <td>${publicInfo.dictValueE }</td>
				  <td> <fmt:formatDate value="${publicInfo.dictUpdateTime}" pattern="yyyy年MM月dd日 HH:mm:ss" /></td>
				  <td>${publicInfo.dictUserName }</td>
				  <td>${publicInfo.dictMemo }</td>
				  <td><a href="<%=basePath %>common/editFind?tab=tab4&id=${publicInfo.id}&tab4PageNum=${tab4PageNum}&tab4PerPage=${tab4PerPage}" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" title="编辑"/></a><a href="javascript:void(0)" onClick="showdelete(${publicInfo.id},'tab4',${count})" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" title="删除"/></a></td>
		  </tr>	
	       </c:forEach>
       </tbody>
           <tfoot>
            <tr>
              <td colspan="9"><div class="bulk-actions align-left">
                  <label>共有<b>${count}</b>条数据</label>
                </div>
                <div  id="pagination4" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
              </td>
            </tr>
          </tfoot>
        </table>
      </div>
      <!-- End #tab4 -->
      </c:if>
    
    
     <c:if test="${tab=='tab2' }">
           <div class="tab-content" id="tab1">
        <form id="form1" action="<%=basePath %>part/init/tab1" method="post">
    		<input type="hidden" id="tab1PageNum" name="tab1PageNum" value="0">
	      <input type="hidden" id="tab1PerPage" name="tab1PerPage" value="10">
          <div class="search-actions">
            <div class="search-condition">
              <table class="seach-table">
                <tr>
                  <td><label>词组类别:</label></td>
      <td ><input type="text" list="type_list" name="link" />
                      <datalist id="type_list">
                        <option label="塔机型号" value="塔机型号"></option>
                        <option label="资产名称" value="资产名称"></option>
                        <option label="标准节" value="标准节"></option>
                      </datalist></td>
      <td><label>词组名称:</label></td>
      <td ><input name="" type="text">&nbsp;</td>

      </tr>
  </table>
</div>
            <div class="search-button"> <a class="button button_position" href="javascript:void(0)" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a> <a class="button button_position" href="word_edit.html" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a> </div>
            <div class="clear"></div>
          </div>
        </form>
        <table>
          <thead>
          <tr>
            <th scope="col" class="chebox">项次</th>
            <th  scope="col">词组类别</th>
            <th  scope="col">词组中文名称</th>
            <th  scope="col">词组英文名称</th>
            <th  scope="col">最后修改时间</th>
            <th  scope="col" class="time">最后修改人</th>
            <th  scope="col" class="time">描述</th>
            <th  scope="col" class="picture2">功能</th>
            </tr>
            </thead><tbody>
       </tbody>
                   <tfoot>
            <tr>
              <td colspan="8"><div class="bulk-actions align-left">
                  <label>共有<b>${count}</b>条数据</label>
                </div>
                <div  id="pagination1" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
              </td>
            </tr>
          </tfoot>
        </table>
      </div>
      <!-- End #tab1 -->
       <div class="tab-content default-tab " id="tab2">
        <form id="form2" action="<%=basePath %>part/init/tab2" method="post">
        			      <input type="hidden" id="tab2PageNum" name="tab2PageNum" value="0">
			      <input type="hidden" id="tab2PerPage" name="tab2PerPage" value="10">
          <div class="search-actions">
            <div class="search-condition">
              <table class="seach-table">
                <tr>
                 <td><label>部件名称:</label></td>
      <td ><input type="text"  name="partName"  value="${partName }"/>
<%--       			<select class="easyui-combobox"  name="partName" style="width:200px;">
						<option value="">不限</option>
					<c:forEach var="part"  items="${allPartList}" varStatus="status" >
						<c:choose>
							<c:when test="${part.part_name==partName }">
								<option value="${part.part_name }"  selected="selected">${part.part_name }</option>
							</c:when>
							<c:otherwise>
								<option value="${part.part_name }"  >${part.part_name }</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select> --%>
      </td>
                  <td><label>部件类别:</label></td>
      <td >
      <select class="easyui-combobox"  name="level" style="width:200px;">
      	<option value="">不限</option>
      	<option value="1" <c:if test="${level ==1 }">selected="selected" </c:if>>主要部件</option>
      	
      	<option value="2" <c:if test="${level ==2 }">selected="selected" </c:if>>零部件</option>
      </select>
      </td>
      </tr>
  </table>
</div>
            <div class="search-button"> <a class="button button_position" onclick="document.getElementById('form2').submit();return false" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a> <a class="button button_position" href="<%=basePath %>part/part_add?tab=tab2&id=${duty.id}&tab2PageNum=${tab2PageNum}&tab2PerPage=${tab2PerPage}" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a> </div>
            <div class="clear"></div>
          </div>
        </form>
        <table>
          <thead>
          <tr>
            <th scope="col" class="chebox">项次</th>
            <th  scope="col">部件名称</th>
            <th  scope="col">部件类别</th>
            <th  scope="col">单位</th>
            <th  scope="col" class="time">描述</th>
            <th  scope="col" class="picture2">功能</th>
            </tr>
            </thead><tbody>
         	<c:forEach var="part"  items="${partList}" varStatus="status" >
	           <tr>
	              <td>
						<script type="text/javascript">
				          	var num =	${status.index+1}+tab2PageNum* tab2PerPage;
				          	document.write(num);
				          </script>
		           </td>
				  <td>${part.part_name }</td>
				  <td>${part.level==2?"零部件":"主部件"}</td>
				  <td>${part.part_unit}</td>
				  <td>${part.memo}</td>
				  <td><a href="<%=basePath %>part/editFind?tab=tab2&id=${part.id}&tab2PageNum=${tab2PageNum}&tab2PerPage=${tab2PerPage}&level=${part.level}" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" title="编辑"/></a><a href="javascript:void(0)" onClick="showdelete(${part.id},'tab2',${count})" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" title="删除"/></a></td>
				  </tr>	
	       </c:forEach>
       </tbody>
      <tfoot>
            <tr>
              <td colspan="6"><div class="bulk-actions align-left">
                  <label>共有<b>${count}</b>条数据</label>
                </div>
                <div  id="pagination2" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
              </td>
            </tr>
          </tfoot>
        </table>
      </div>
      </c:if>
      <c:if test="${tab=='tab3' }">
      <!-- End #tab2 -->
       <div class="tab-content" id="tab3">
       <form id="form3" action="<%=basePath %>part/init/tab3" method="post">
     	<input type="hidden" id="tab3PageNum" name="tab3PageNum" value="0">
		<input type="hidden" id="tab3PerPage" name="tab3PerPage" value="10">
          <div class="search-actions">
            <div class="search-condition">
              <table class="seach-table">
                <tr>
                  <td><label>塔机型号:</label></td>
      <td >
                        <select name="towerModel" class="easyui-combobox" id="tower_model">
                        <option value="">不限</option>
                            <c:forEach var="oneTowerModel" items="${towerModelList}" varStatus="status">
                                <c:choose>
                                    <c:when test="${oneTowerModel.dict_value==towerModel}">
                                        <option value="${oneTowerModel.dict_value }"
                                                selected="selected">${oneTowerModel.dict_value }</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${oneTowerModel.dict_value }">${oneTowerModel.dict_value }</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select>
				
      </td>
      <td><label>所属公司:</label></td>
                  <td >
                  <select class="easyui-combobox"  name="companyId" style="width:200px;">
						<option value="">不限</option>
					<c:forEach var="company"  items="${companyList}" varStatus="status" >
						<c:choose>
							<c:when test="${company.id==companyId }">
								<option value="${company.id }"  selected="selected">${company.companyShortName }</option>
							</c:when>
							<c:otherwise>
								<option value="${company.id }">${company.companyShortName }</option>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</select>
                  </td>

      </tr>
  </table>
</div>
            <div class="search-button"> <a class="button button_position" href="javascript:void(0)" onclick="document.getElementById('form3').submit();return false"  title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a> <a class="button button_position" href="<%=basePath %>part/partm_add?tab=tab3&id=${template.id}&tab3PageNum=${tab3PageNum}&tab3PerPage=${tab3PerPage}"  title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a> </div>
            <div class="clear"></div>
          </div>
        </form>
        <table>
          <thead>
          <tr>
            <th scope="col" class="chebox">项次</th>
            <th  scope="col">模块名称</th>
            <th  scope="col">塔机型号</th>
            <th  scope="col">所属公司</th>
            <th  scope="col" class="time">描述</th>
            <th  scope="col" class="picture2">功能</th>
            </tr>
            </thead><tbody>
             <c:forEach var="template"  items="${templateList}" varStatus="status" >
	           <tr>
	              <td>
						<script type="text/javascript">
				          	var num =	${status.index+1}+tab3PageNum* tab3PerPage;
				          	document.write(num);
				          </script>
		           </td>
				  <td>${template.template_name }</td>
				  <td>${template.tower_model }</td>
				  <td>${template.company_short_name }</td>
				  <td>${template.description}</td>
				  <td><a href="<%=basePath %>part/editmFind?tab=tab3&id=${template.id}&tab3PageNum=${tab3PageNum}&tab3PerPage=${tab3PerPage}" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" title="编辑"/></a><a href="javascript:void(0)" onClick="showdelete(${template.id},'tab3',${count})" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" title="删除"/></a></td>
				  </tr>	
	       </c:forEach>
       </tbody>
                    <tfoot>
            <tr>
              <td colspan="6"><div class="bulk-actions align-left">
                  <label>共有<b>${count}</b>条数据</label>
                </div>
                <div  id="pagination3" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
              </td>
            </tr>
          </tfoot>
        </table>
      </div>
     </c:if>
      <!-- End #tab3 -->
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