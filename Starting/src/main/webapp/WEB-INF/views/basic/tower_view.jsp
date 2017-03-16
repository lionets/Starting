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
<title>塔机明细查询</title>
<!--                       CSS                       -->
<link rel="stylesheet" href="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/default/easyui.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/icon.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/js/paging/pagination.css" />
<!-- Reset Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
<!-- Main Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen" />
<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
<link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen" />
<link rel="stylesheet" href="<%=basePath %>static/css/select.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src='<%=basePath %>static/js/UTIL.js'></script>
<script>
function openwin(towerId){
	var resultValue =  window.showModalDialog('<%=basePath %>parts/queryTowerPart?towerId='+towerId,'',"dialogWidth=1200px;dialogHeight=550px");
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
        <form action="" method="post">
          <table border="0" class="edit-table">
            <tr>
              <th><label ><b>*</b>塔机编号 </label></th>
              <td width="300px">${manage.towerManageNo }</td>
              <th scope="row"><label ><b>*</b>塔机型号</label>              </th>
              <td>${info.towerModel }</td>
            </tr>
            <tr>
              <th scope="row">出厂编号 </th>
              <td>${info.towerFactoryno }</td>
              <th scope="row"><label >塔机样式</label>              </th>
              <td>${info.towerType }</td>
            </tr>
            <tr>
              <th scope="row">出厂日期</th>
              <td><fmt:formatDate pattern="yyyy-MM-dd" value="${info.towerFactorydate}" type="both" /></td>
              <th scope="row">到货日期</th>
              <td><fmt:formatDate pattern="yyyy-MM-dd" value="${info.receiveDate}" type="both" /></td>
            </tr>
            <tr>
              <th scope="row">塔机来源</th>
              <td>${manage.towerSource }</td>
              <th scope="row">起重力矩</th>
              <td>${info.qzlj }
                (单位：吨米)</td>
            </tr>
            <tr>
              <th scope="row">生产厂家</th>
              <td>${info.towerCreatecompanyName }</td>
              <th scope="row">容绳量</th>
              <td>${info.qzljsl }(单位：米)</td>
            </tr>
            <tr>
              <th scope="row">所属公司</th>
              <td>${manage.towerRightcompanyName }</td>
              <th scope="row">管理公司</th>
              <td>${manage.manageCompanyName }</td>
            </tr>
            <tr>
              <th scope="row">管理单位</th>
              <td>${manage.departmentName }</td>
              <th scope="row">&nbsp;</th>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <th scope="row">GPS机具编号</th>
              <td>${info.gpsNo }(唯一值)</td>
              <th scope="row">SIM卡号</th>
              <td>${info.simNumber }(唯一值)</td>
            </tr>
            <tr>
              <th scope="row">合同编号</th>
              <td>${manage.managerSourceNo }</td>
              <th scope="row">状态</th>
              <td><c:choose>
              <c:when test="${manage.towerManageState == 1 }">闲置</c:when>
              <c:when test="${manage.towerManageState == 2 }">未启用</c:when>
              <c:when test="${manage.towerManageState == 3 }">在使用</c:when>
              <c:when test="${manage.towerManageState == 4 }">冬停</c:when>
              <c:when test="${manage.towerManageState == 5 }">托管</c:when>
              <c:otherwise>未知状态</c:otherwise>
              </c:choose></td>
            </tr>
			<tr>
              <th scope="row">说明书</th>
              <td><input name="input" type="checkbox" <c:if test="${info.check1 == true}">checked="checked"</c:if> checked="checked" disabled="disabled"/>
  				&nbsp;</td>
              <th scope="row">&nbsp;</th>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <th scope="row">合格证</th>
              <td align="center">
                  <img width="100px" height="100px" src="<%=basePath %>static/images/${info.check2Icon }"/> </td>
              <th scope="row">监检证</th>
              <td  valign="middle">
                  <img alt="" width="100px" height="100px" src="<%=basePath %>static/images/${info.check3Icon }"/> </td>
            </tr>
            <tr>
              <th scope="row">产权证</th>
              <td  valign="middle">
                  <img width="100px" height="100px" src="<%=basePath %>static/images/${info.check5Icon }"/>  </td>
              <th scope="row">检测报告</th>
              <td >
                <table>
                  <thead><tr>
                    <td class="chebox"><div align="center"></div></td>
                    <td style="font-weight:bold"><div align="center">报告名称</div></td>
                    <td style="font-weight:bold"><div align="center">图片</div></td>
                    <td style="font-weight:bold"><div align="center">时间</div></td>
                  </tr></thead>
                  <tbody>
                <c:forEach items="${reportList }" var="report" varStatus="num">
                <tr>
                    <td>${num.index+1 }
                    <input type="hidden" value="${report.id }"/>
                    </td>
                    <td>${report.reportName }</td>
                    <td><img width="30px" height="30px" src="<%=basePath %>static/images/${report.reportIcon }"/></td>
                    <td><fmt:formatDate pattern="yyyy-MM-dd" value="${report.submitDate}" type="both" /></td>
                    <td>
                    </td>
                  </tr>
                </c:forEach>
                </tbody>
              </table></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td colspan="3"><a class="button_new" href="<%=basePath %>tower/init/2" target="_parent" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a><a class="button_new" onclick="openwin(${manage.id})"title="零部件"><img src="<%=basePath %>static/images/icons/parts.png" class="px18"/></a> </td>
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