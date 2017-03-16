<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
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
    <link rel="stylesheet" type="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/icon.css">
    <link rel="stylesheet" href="<%=basePath %>static/js/paging/pagination.css" />
    <link rel="stylesheet" type="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/default/easyui.css">
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
    <script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
    <script src="<%=basePath %>static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery.datePicker.js"></script>

<SCRIPT type=text/javascript>
using(['window'],function(){});//加载window插件
//分页点击执行的操作
function changePage(index,jq){
    if(jq.attr("id")=="pagination1"){
        $("#tab1PageNum").val(index);
        $("#tab1PerPage").val(tab1PerPage);
        $("#form1").submit();
    }
    if(jq.attr("id")=="pagination2"){
        $("#conpageNumber").val(index);
        $("#tab2PerPage").val(tab2PerPage);
        $("#form2").submit();
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
    //初始化分页默认每页显示10条
    if(tab=="tab1"){
        initPagination("pagination1","${count}",10,tab1PageNum);
    }
    if(tab=="tab2"){
        initPagination("pagination2","${count}",10,tab2PageNum);
    }
}

//删除一条记录
function showdelete(id,tab,old_tower_no){
    tatongMethod.confirm("提示","确定要删除吗?",function(){
        var url = "<%=basePath %>handle/deleteOne?id="+id+"&tab="+tab+"&old_tower_no="+old_tower_no;
        if(tab=="tab1"){
            $("#tab1PageNum").val(tab1PageNum);
            $("#tab1PerPage").val(tab1PerPage);
            $("#form1").attr("action",url);
            $("#form1").submit();
        }
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
    })
}

var tab1PageNum = "${tab1PageNum}"==""?0:"${tab1PageNum}";
var tab1PerPage =  "${tab1PerPage}"==""?10: "${tab1PerPage}";

var tab2PageNum = "${tab2PageNum}"==""?0:"${tab2PageNum}";
var tab2PerPage =   "${tab2PerPage}"==""?10: "${tab2PerPage}";

	$(document).ready(function() {
        //控制显示的面板
        var tab = "${tab}";
        togle(tab);
        
        //添加点击事件
        $(".atab").on("click",function(){
            var tab = $(this).attr("name");
            if(tab=="tab1"){
                url = "<%=basePath %>handle/init/"+tab+"?tab1PageNum="+tab1PageNum+"&tab1PerPage="+tab1PerPage;
            }
            if(tab=="tab2"){
            	 url = "<%=basePath %>handle/init/"+tab+"?tab2PageNum="+tab2PageNum+"&tab2PerPage="+tab2PerPage;
            }
            location.href= url;
        })
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
       <shiro:hasPermission name="leap:assetsDisposal">
         <li><a href="#tab1" id="atab1" name="tab1" class="atab">  <h4>资产处置</h4></a></li>
       </shiro:hasPermission>
       <shiro:hasPermission name="leap:assetsRevert">
         <li> <a href="#tab2" id="atab2" name="tab2" class="atab">  <h4>资产归还</h4></a></li>
       </shiro:hasPermission>
        <!-- href must be unique and match the id of target div -->
      </ul>
      <div class="clear"></div>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <shiro:hasPermission name="leap:assetsDisposal">
      <c:if test='${tab=="tab1" }'>
        <div class="tab-content default-tab" id="tab1">
          <form id="form1" action="<%=basePath %>handle/init/tab1" method="post">
            <input type="hidden" id="tab1PageNum" name="tab1PageNum" value="0">
            <input type="hidden" id="tab1PerPage" name="tab1PerPage" value="10">
            <div class="search-actions">
              <div class="search-condition">
                <div class="search-condition-show">
                  <table class="seach-table">
                    <tr>
                      <td><label>塔机编号:</label></td>
                      <td >
                      		<select class="easyui-combobox" name="towerNo">
                      				<option value="">不限</option>
                      			<c:forEach items="${towerNoList }" var="tower">
                      				<option value="${tower.tower_no }"  <c:if test="${tower.tower_no == towerNo }">selected="selected"</c:if>>${tower.tower_no }</option>
                      			</c:forEach>
                      		</select>
                      </td>
                      <td ><label>处置时间:</label></td>
                      <td ><input type="text"readonly="readonly" name="disposalStart" value="${disposalStart }" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});">
                        ~
                        <input type="text" readonly="readonly" name="disposalEnd" value="${disposalEnd }"    onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"></td>
                    </tr>
                  </table>
                </div>
              </div>
              <div class="search-button">
                <shiro:hasPermission name="leap:assetsDisposal:query">
                  <a class="button button_position"  href="javascript:void(0)" onclick="document.getElementById('form1').submit()"  title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:assetsDisposal:add">
                  <a class="button button_position" href="<%=basePath %>handle/addHandleInit" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:assetsDisposal:export">
                  <a class="button button_position" href="#" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a>
                </shiro:hasPermission>
              </div>
              <div class="clear"></div>
            </div>
          </form>
          <table>
          <thead>
            <tr>
              <th scope="col" class="chebox"><div align="center">项次</div></th>
              <th  scope="col">处置单号</th>
              <th  scope="col"><div align="center">处置方式</div></th>
              <th  scope="col">资产名称</th>
              <th  scope="col"><div align="center">塔机编号</div></th>
              <th  scope="col"><div align="center">塔机型号</div></th>
              <th  scope="col" >出厂编号</th>
              <th  scope="col"><div align="center">处置时间</div></th>
              <th  scope="col" ><div align="center">所属公司</div></th>
              <th  scope="col" class="picture4"><div align="center">功能</div></th>
            </tr>
          </thead>
          <tbody>
          <c:forEach items="${ assetManagelist}" var="assetManage" varStatus="status">
             <tr>
              <td class="tbllb"><div align="center">
	              <script type="text/javascript">
                  var num =	${status.index+1}+tab1PageNum* tab1PerPage;
                  document.write(num);
	              </script>
              </div></td>
              <td><div align="center"><a href="<%=basePath %>handle/disposition_view?id=${assetManage.id }">${assetManage.disposal_no }</a></div></td>
              <td><div align="center">${assetManage.disposal_type }</div></td>
              <td>${assetManage.asset_name }</td>
              <td><div align="center">${assetManage.tower_no }</div></td>
              <td><div align="center">${assetManage.tower_model }</div></td>
              <td><div align="center">${assetManage.tower_factoryno }</div></td>
              <td><div align="center">${assetManage.disposal_date }</div></td>
              <td><div align="center">${assetManage.company_short_name }</div></td>
              <td><div align="center"><c:if test="${assetManage.check_status ==0 }"><a href="<%=basePath %>handle/disposition_aduit?id=${assetManage.id}" class="edit"><img src="<%=basePath %>static/images/icons/tests-icon.png" title="审核"/></a><a href="<%=basePath %>handle/editHandleInit?id=${assetManage.id}" target="_parent" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" alt="Edit" /></a><a href="javascript:void(0)" onClick="showdelete(${assetManage.id },'tab1','${assetManage.tower_no }')" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" alt="Delete" /></a></c:if><a href="#" class="edit"><img src="<%=basePath %>static/images/icons/download-icon.png" alt="download" /></a></div></td>
            </tr>
          </c:forEach>
          </tbody>
            <tfoot>
                    <tr>
                        <td colspan="11"><div class="bulk-actions align-left">
                            <label>共有<b>${count}</b>条数据</label>
                        </div>
                            <div  id="pagination1" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                        </td>
                    </tr>
            </tfoot>
          </table>
        </div>
        </c:if>
      </shiro:hasPermission>
      <shiro:hasPermission name="leap:assetsRevert">
      <c:if test='${tab=="tab2" }'>
        <div class="tab-content default-tab" id="tab2">
       <form id="form2" action="<%=basePath %>handle/init/tab2" method="post">
         <input type="hidden" id="tab2PageNum" name="tab2PageNum" value="0">
         <input type="hidden" id="tab2PerPage" name="tab2PerPage" value="10">
        <div class="search-actions">
          <div class="search-condition">
          
              <table class="seach-table">
                <tr>
                  <td><label>外租合同编号:</label></td>
                  <td ><input name="contract_no" value="${contract_no }" type="text" class="text-input"></td>
                  <td ><label>归还单号:</label></td>
                  <td ><input name="return_no" value="${return_no }" type="text" /></td>
                  <td ><label> 所属公司:</label>                  </td>
                  <td>
                  	 	<select class="easyui-combobox" name="rightCompanyId">
                      				<option value="">不限</option>
                      			<c:forEach items="${companyList }" var="company">
                      				<option value="${company.id }"  <c:if test="${company.id == rightCompanyId }">selected="selected"</c:if>>${company.shortName }</option>
                      			</c:forEach>
                      		</select>
                  </td>
                </tr>
                <tr>
                  <td ><label>归还日期:</label></td>
                  <td style="text-align:left" colspan="3" >
                  <input type="text" name="returnStart" value="${returnStart }" readonly="readonly"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});"/> ~ 
                    <input type="text"  name="returnEnd"  value="${returnEnd }"   readonly="readonly"  onclick="WdatePicker({dateFmt:'yyyy-MM-dd'});">
                  </td>
                  
                </tr>
              </table>
       
          </div>
          <div class="search-button"> <a class="button button_position" href="javascript:void(0)" onclick="document.getElementById('form2').submit()" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a> <a class="button button_position" href="<%=basePath %>handle/addReturnInit" target="_parent" title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a> <a class="button button_position" href="#" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a> </div>
         
          <div class="clear"></div>
        </div>
        </form>
        <table>
          <thead>
            <tr>
              <th scope="col" class="chebox"><div align="center">项次</div></th>
              <th  scope="col"><div align="center">外租合同编号</div></th>
              <th  scope="col" ><div align="center">归还单号</div></th>
              <th  scope="col">资产名称</th>
              <th  scope="col"><div align="center">塔机编号</div></th>
              <th  scope="col"><div align="center">塔机型号</div></th>
              <th  scope="col" >出厂编号</th>
              <th  scope="col" class="date"><div align="center">归还日期</div></th>
              <th  scope="col" ><div align="center">起止地址</div></th>
              <th  scope="col" >所属公司</th>
              <th  scope="col" class="picture6"><div align="center">功能</div></th>
            </tr>
          </thead>
          <tbody>
          <c:forEach items="${returnAssetList }"  varStatus="status" var="returnAsset">
            <tr>
              <td class="tbllb"><div align="center">
              		 <script type="text/javascript">
                     var num =	${status.index+1}+tab1PageNum* tab1PerPage;
                     document.write(num);
	              </script>
              </div></td>
              <td ><div align="center">${returnAsset.contract_no }</div></td>
              <td><div align="center"><a href="return_view.html">${returnAsset.return_no }</a></div></td>
              <td><div align="center">${returnAsset.asset_name }</div></td>
              <td><div align="center">${returnAsset.tower_no }</div></td>
              <td><div align="center">${returnAsset.tower_model }</div></td>
              <td><div align="center">${returnAsset.tower_factoryno }</div></td>
              <td><div align="center">${returnAsset.return_day } </div></td>
              <td><div align="center">${returnAsset.contract_start_plac }-&gt;${returnAsset.return_addr }</div></td>
              <td>${returnAsset.company_short_name }</td>
              <td><div align="center"> <a href="return_aduit.html"> <img src="<%=basePath %>static/images/icons/tests-icon.png" alt="审核" title="审核"/></a><a onclick="showdispatch()" class="edit"><img src="<%=basePath %>static/images/icons/success-icon.png" alt="确认归还" title="确认归还"/></a><a href="<%=basePath %>handle/editReturnInit?id=${returnAsset.id}" target="_parent" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" alt="编辑" title="编辑"/></a><a href="#" onclick="showdelete('${returnAsset.id }','tab2')" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" alt="Delete" /></a><a onclick="openwin2()" class="edit"><img src="<%=basePath %>static/images/icons/download-icon.png" alt="download" /></a></div></td>
            </tr>
            </c:forEach>
          </tbody>
              <tfoot>
                    <tr>
                        <td colspan="11"><div class="bulk-actions align-left">
                            <label>共有<b>${count}</b>条数据</label>
                        </div>
                            <div  id="pagination2" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                        </td>
                    </tr>
            </tfoot>
        </table>
      </div>
        </c:if>
      </shiro:hasPermission>
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
<script type="text/javascript">

function openwin(){
window.open('<%=basePath %>handle/returnFind','newwindow','height=700,width=1000,top=0,left=100,toolbar=0,menubar=0,scrollbar="yes",resizable=no.location=no,status=no')
}
function openwin1(){
window.open('<%=basePath %>handle/returnSing','newwindow','height=700,width=1000,top=0,left=100,toolbar=0,menubar=0,scrollbar="yes",resizable=no.location=no,status=no')
}
 </script>
</html>