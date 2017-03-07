<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%-- <%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> --%>
<%
    String path = request.getContextPath();
    String basePath =  path + "/";
%>
<link rel="stylesheet" href="<%=basePath %>static/css/top.css" type="text/css" media="screen" />
<div style="margin-bottom: 25px;">
<div id="header-bar" style="min-width:980px;">
    <div class="site-loopback" >
        <a href="#" title="LEAP"><img id="logo" src="<%=basePath %>static/images/logo6.png" alt="LEAP" style="padding-left:28px;"/></a> </div>
    <!-- <div class="todo">
       <ul>
         <li><a href="asset/receiving_query.html" target="main-iframe">资产到货<span class="label label-important">5</span> </a></li>
         <li><a href="dispatch/dispatch_query.html" target="main-iframe">待调度<span class="label label-important">4</span> </a></li>
         <li><a href="dispatch/dispatch_query.html" target="main-iframe">待签核<span class="label label-important">5</span> </a></li>
       </ul>
     </div>-->
    <div class="meta-data">
        <a  href="<%=basePath %>index/init" class="purchase" title="<spring:message code="headerbar.overview"/>">
            <img src="<%=basePath %>static/images/icons/view_icon1.png" style="width:16px; height:14px;"/>
        </a>
        <a  href="<%=basePath %>index/home" class="purchase" title="<spring:message code="headerbar.home"/>">
            <img src="<%=basePath %>static/images/icons/home_icon1.png" style="width:16px; height:14px;"/>
        </a>
        <a class="purchase" href="<%=basePath %>company/init/tab4?tab1PageNum=0&tab1PerPage=10" title="<spring:message code="headerbar.dic"/>">
            <img src="<%=basePath %>static/images/icons/book_icon1.png" class="px16"/>
        </a>
        <a class="purchase" href="<%=basePath %>company/init/tab1?tab1PageNum=0&tab1PerPage=10" title="<spring:message code="headerbar.setting"/>">
            <img src="<%=basePath %>static/images/icons/set_icon.png" style="width:16px; height:16px;"/>
        </a>
        <a class="purchase" href="<%=basePath %>logout"  title="<spring:message code="headerbar.logout"/>">
            <img src="<%=basePath %>static/images/icons/logout_icon1.png" class="px16"/>
        </a>
    </div>
    <div class="clear"></div>
</div>
<div class="denglu" ><label>${loginCompanyShortName }</label>&nbsp;&nbsp;<label>${loginDepartmentName }</label>&nbsp;&nbsp;<label>${loginRealName }</label>&nbsp;&nbsp;|&nbsp;&nbsp;<label><a href="<%=basePath %>users/editPWDInit" target="main-iframe"  style="color:#555">修改密码</a></label>&nbsp;&nbsp;|&nbsp;&nbsp;<label><a href="<%=basePath %>index?locale=zh_CN" target="main-iframe"  style="color:#555">中文</a></label>&nbsp;&nbsp;|&nbsp;&nbsp;<label><a href="<%=basePath %>index?locale=en_US" target="main-iframe"  style="color:#555">英文</a></label>&nbsp;&nbsp;|&nbsp;&nbsp;<label>
<a href="<%=basePath %>static/leap-userguide/index.html" target="blank"  style="color:#555">操作手册</a>
</label></div>
</div>

