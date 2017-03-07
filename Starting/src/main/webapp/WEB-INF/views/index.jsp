<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
	String path = request.getContextPath();
	String basePath =  path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<title><spring:message code="sys.name"/></title>
<!--                       CSS                       -->
<!-- Reset Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
<!-- Main Stylesheet -->
<link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen" />
<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
<link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen" />

<link rel="stylesheet" href="<%=basePath %>static/css/firstpage1.css" type="text/css" media="screen" />

<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/firstpage.js"></script>
<SCRIPT src="<%=basePath %>static/js/jquery.js" type=text/javascript></SCRIPT>

</head>
<body>
<jsp:include page="header-bar.jsp"/>

<div id="firstpage" >
<div id="wai_box">
  <div class="lanrenzhijia_box">
    <ul class="firstline">
      <li class="images blue" data-device="#stockItem" value="1"> <a href="#" ><img src="<%=basePath %>static/images/icons/128x128/purchase-icon1.png"/></a> <span class="title"> </span>
        <p class="word">
          <label>采&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;购</label>
        </p>
      </li>
      <li class="images green" data-device="#projectItem" value="2"><a href="#" ><img src="<%=basePath %>static/images/icons/128x128/gold-icon.png"/></a> <span class="title">
        <label></label>
        </span>
        <p class="word">
          <label>项&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;目</label>
        </p>
      </li>
      <li class="images yellow"  data-device="#dispatchItem" value="3"><a href="#" ><img src="<%=basePath %>static/images/icons/128x128/truck-icon.png"/></a> <span class="title">
        <label></label>
        </span>
        <p class="word">
          <label>调&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;度</label>
        </p>
      </li>
      <li class="images orange"  data-device="#checkItem" value="4"><a href="#" ><img src="<%=basePath %>static/images/icons/128x128/maintenance-icon1.png"/></a> <span class="title">
        <label></label>
        </span>
        <p class="word">
          <label>安检维修</label>
        </p>
      </li>
      <li class="images red"  data-device="#backItem" value="5"><a href="#" ><img src="<%=basePath %>static/images/icons/128x128/return-icon1.png"/></a> <span class="title">
        <label></label>
        </span>
        <p class="word">
          <label>处置归还</label>
        </p>
      </li>
    </ul>
    <div id="expandZone0" class="expand active" >
      <div class="download">
        <div id="leapItem" class="item">
          <div class="download-list" >
            <div style="padding-top:11px">
              <label> <b style="color:#01752c; font-size:24px; font-weight:700;">L</b><b style="color:#333333; font-size:24px; font-weight:700;">easing</b></label>
              &nbsp;&nbsp;
              <label> <b style="color:#01752c; font-size:24px; font-weight:700;">E</b><b style="color:#333333; font-size:24px; font-weight:700;">quipment</b></label>
              &nbsp;&nbsp;
              <label><b style="color:#01752c; font-size:24px; font-weight:700;">A</b><b style="color:#333333; font-size:24px; font-weight:700;">dministrative</b></label>
              &nbsp;&nbsp;
              <label><b style="color:#01752c; font-size:24px; font-weight:700;">P</b><b style="color:#333333; font-size:24px; font-weight:700;">latform</b></label>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div id="expandZone" class="expand active" >
      <div class="download">
        <div id="stockItem" class="item">
          <div class="download-list"> <a href="<%=basePath %>purchase/init/1" class="btn stock"  ><span class="icon"></span><span class="text">采购合同</span></a> <a href="<%=basePath %>purchase/init/2" class="btn rent"  ><span class="icon"></span><span class="text">外租合同</span></a> <a href="<%=basePath %>purchase/init/3" class="btn receive" ><span class="icon"></span><span class="text">资产到货</span></a> </div>
        </div>
        <div id="projectItem" class="item">
          <div class="download-list"><a href="<%=basePath %>project/init/1" class="btn project"  ><span class="icon"></span><span class="text">项目资料</span></a> <a href="<%=basePath %>contractPro/init/2" class="btn plan"  ><span class="icon"></span><span class="text">合同信息</span></a><a href="<%=basePath %>contractPro/init/3" class="btn use"  ><span class="icon"></span><span class="text">项目进度</span></a> <a href="<%=basePath %>project/init/4" class="btn rent" ><span class="icon"></span><span class="text">租赁意向</span></a> </div>
        </div>
        <div id="dispatchItem" class="item">
          <div class="download-list"> <a href="<%=basePath %>transfer/init/tab1" class="btn dispatch"  ><span class="icon"></span><span class="text">资产调度</span></a><a href="<%=basePath %>contractPro/init/4" class="btn plan"  ><span class="icon"></span><span class="text">项目方案</span></a></div>
        </div>
        <div id="checkItem" class="item">
          <div class="download-list"> <a href="<%=basePath %>maintain/init/tab1" class="btn check"  ><span class="icon"></span><span class="text">安全检查</span></a> <a  href="<%=basePath %>maintain/init/tab2" class="btn maintain"  ><span class="icon"></span><span class="text">设备维修</span></a> </div>
        </div>
        <div id="backItem" class="item">
          <div class="download-list"> <a href="<%=basePath %>handle/init/tab1" class="btn work"  ><span class="icon"></span><span class="text">资产处置</span></a> <a href="<%=basePath %>handle/init/tab2" class="btn back"  ><span class="icon"></span><span class="text">资产归还</span></a></div>
        </div>
        <div id="systemItem" class="item">
                  <div id="return41" style=" float:left; padding-left:20px;"> <a href="javascript:void(0);" onmouseover="overMar4(1);" onmouseout="outMar4();"> <img src="<%=basePath %>static/images/leftarrow.png" style="width:10px; height:18px;padding-top:14px; "></a></div>
        <div id="demo4" class="download-list" style="OVERFLOW: hidden; float:left; padding-left:20px; width:848px; margin:0 20px;" >
          <TABLE>
            <TR>
              <TD id="demo41"><table width="1180px">
                  <tr>
                <td width="250px"><a href="<%=basePath %>company/init/tab1?tab1PageNum=0&tab1PerPage=10" class="btn department"  ><span class="icon"></span><span class="text">公司管理</span></a></td>
                <td width="250px"><a href="<%=basePath %>company/init/tab7?tab1PageNum=0&tab1PerPage=10" class="btn company"  ><span class="icon"></span><span class="text">部门管理</span></a> </td>
                <td width="250px"><a href="<%=basePath %>company/init/tab2?tab1PageNum=0&tab1PerPage=10" class="btn user"  ><span class="icon"></span><span class="text">用户管理</span></a></td>
                <td width="250px"><a href="<%=basePath %>company/init/tab3?tab1PageNum=0&tab1PerPage=10" class="btn position"  ><span class="icon"></span><span class="text">职务管理</span></a></td>
                <td width="250px"><a href="<%=basePath %>company/init/tab5?tab1PageNum=0&tab1PerPage=10" class="btn role"  ><span class="icon"></span><span class="text">角色管理</span></a></td>
                <td width="250px"><a href="<%=basePath %>company/init/tab4?tab1PageNum=0&tab1PerPage=10" class="btn data" ><span class="icon"></span><span class="text">公共资料</span></a></td>
                <td width="250px"><a href="<%=basePath %>part/init/tab2" class="btn parts" ><span class="icon"></span><span class="text">部件资料</span></a></td>
                <td width="250px"><a href="<%=basePath %>part/init/tab3" class="btn parts" ><span class="icon"></span><span class="text">部件模块</span></a></td>
              
              </tr>
              
            </table>
            </TD>
            
            <td id="demo42"></td>
            </TR>
          </TABLE>
        </div>
        <div id="next41" style=" float:right; padding-right:20px "> <a href="javascript:void(0);" onmouseover="overMar4(0);" onmouseout="outMar4();"><img src="<%=basePath %>static/images/arrowright.png" style="width:10px; height:18px; padding-top:14px;"></a></div>
        <script>
var speed4=5//速度数值越大速度越慢
var MyMar4;
document.getElementById("demo42").innerHTML=document.getElementById("demo41").innerHTML;
//左移动
function MarqueeAdd4(){
if(document.getElementById("demo42").offsetWidth-document.getElementById("demo4").scrollLeft<=0){
document.getElementById("demo4").scrollLeft=document.getElementById("demo4").scrollLeft-document.getElementById("demo41").offsetWidth;
}else{
document.getElementById("demo4").scrollLeft++;
}
}
//右移动
function MarqueeDes4(){
if(document.getElementById("demo42").offsetWidth-document.getElementById("demo4").scrollLeft>=0){
document.getElementById("demo4").scrollLeft=document.getElementById("demo4").scrollLeft+document.getElementById("demo41").offsetWidth;
}else{
document.getElementById("demo4").scrollLeft--;
}
}
//鼠标画出停止
function outMar4(){
clearInterval(MyMar4);
}
//鼠标滑过滚动
function overMar4(jadge4){
if(jadge4==0){
MyMar4=setInterval(MarqueeAdd4,speed4);
}else{
MyMar4=setInterval(MarqueeDes4,speed4);
} 
}
 
//MyMar=setInterval(MarqueeAdd,speed);//自动左移动
//MyMar=setInterval(MarqueeDes,speed);//自动右移动
</script>
      </div>
      <div id="gpsItem" class="item">
        <div id="return31" style=" float:left; padding-left:20px;"> <a href="javascript:void(0);" onmouseover="overMar1(1);" onmouseout="outMar1();"> <img src="<%=basePath %>static/images/leftarrow.png" style="width:10px; height:18px;padding-top:14px; "></a></div>
        <div id="demo3" class="download-list" style="OVERFLOW: hidden; float:left; padding-left:20px; width:848px; margin:0 20px;" >
          <TABLE>
            <TR>
              <TD id="demo31"><table width="1000px">
                  <tr>
                    <td width="250px"><a href="<%=basePath %>driverManage/init/tab1?tab1PageNum=0&tab1PerPage=10" class="btn statu"  ><span class="icon"></span><span class="text">设备地图</span></a></td>
                    <td width="250px"><a href="<%=basePath %>driverManage/init/tab2?tab1PageNum=0&tab1PerPage=10" class="btn history" ><span class="icon"></span><span class="text">轨迹查询</span></a> </td>
                    <td width="250px"><a href="<%=basePath %>driverManage/init/tab3?tab1PageNum=0&tab1PerPage=10" class="btn locate" ><span class="icon"></span><span class="text">人工定位</span></a></td>
                    <td width="250px"><a href="<%=basePath %>driverManage/init/tab4?tab1PageNum=0&tab1PerPage=10" class="btn maintain" ><span class="icon"></span><span class="text">GPS维修</span></a></td>
                    <td width="250px"><a href="<%=basePath %>driverManage/init/tab6?tab1PageNum=0&tab1PerPage=10" class="btn gps"  ><span class="icon"></span><span class="text">GPS管理</span></a></td>
                    <td width="250px"><a href="<%=basePath %>driverManage/init/tab5?tab1PageNum=0&tab1PerPage=10" class="btn send"  ><span class="icon"></span><span class="text">信令发送</span></a> </td>
                  </tr>
                </table></TD>
              <td id="demo32"></td>
            </TR>
          </TABLE>
        </div>
        <div id="next31" style=" float:right; padding-right:20px "> <a href="javascript:void(0);" onmouseover="overMar1(0);" onmouseout="outMar1();"><img src="<%=basePath %>static/images/arrowright.png" style="width:10px; height:18px; padding-top:14px;"></a></div>
        <script>
var speed1=8//速度数值越大速度越慢
var MyMar1;
document.getElementById("demo32").innerHTML=document.getElementById("demo31").innerHTML;
//左移动
function MarqueeAdd1(){
if(document.getElementById("demo32").offsetWidth-document.getElementById("demo3").scrollLeft<=0){
document.getElementById("demo3").scrollLeft=document.getElementById("demo3").scrollLeft-document.getElementById("demo31").offsetWidth;
}else{
document.getElementById("demo3").scrollLeft++;
}
}
//右移动
function MarqueeDes1(){
if(document.getElementById("demo32").offsetWidth-document.getElementById("demo3").scrollLeft>=0){
document.getElementById("demo3").scrollLeft=document.getElementById("demo3").scrollLeft+document.getElementById("demo31").offsetWidth;
}else{
document.getElementById("demo3").scrollLeft--;
}
}
//鼠标画出停止
function outMar1(){
clearInterval(MyMar1);
}
//鼠标滑过滚动
function overMar1(jadge1){
if(jadge1==0){
MyMar1=setInterval(MarqueeAdd1,speed1);
}else{
MyMar1=setInterval(MarqueeDes1,speed1);
} 
}
 
//MyMar=setInterval(MarqueeAdd,speed);//自动左移动
//MyMar=setInterval(MarqueeDes,speed);//自动右移动
</script>
      </div>
      <div id="warehouseItem" class="item">
        <div class="download-list"><a href="<%=basePath %>customer/init/1" class="btn client"  ><span class="icon"></span><span class="text">客户资料</span></a> <a href="<%=basePath %>tower/init/2"  class="btn tower" ><span class="icon"></span><span class="text">塔机资料</span></a> <a href="<%=basePath %>parts/init/3" class="btn parts" ><span class="icon"></span><span class="text">零部件资料</span></a><a href="<%=basePath %>warehouse/init/4" class="btn warehouse"  ><span class="icon"></span><span class="text">仓库资料</span></a></div>
      </div>
      <div id="assetItem" class="item">
        <div id="return1" style=" float:left; padding-left:20px;"> <a href="javascript:void(0);" onmouseover="overMar(1);" onmouseout="outMar();"> <img src="<%=basePath %>static/images/leftarrow.png" style="width:10px; height:18px;padding-top:14px; "></a></div>
        <div id="demo" class="download-list" style="OVERFLOW: hidden; float:left; padding-left:20px; width:850px; margin:0 20px;" >
          <TABLE>
            <TR>
              <TD id="demo1"><table width="1500px">
                  <tr>
                    <td width="160px"><a  href="<%=basePath %>report/init/tab1" class="btn project"  ><span class="icon"></span><span class="text">项目信息汇总表</span></a> </td>
                    <td width="160px"><a  href="<%=basePath %>report/init/tab2" class="btn project"  ><span class="icon"></span><span class="text">设备整机动态表</span></a> </td>
                    <td width="160px"><a  href="<%=basePath %>report/init/tab3" class="btn project"  ><span class="icon"></span><span class="text">设备配置动态表</span></a> </td>
                    <td width="160px"><a  href="<%=basePath %>report/init/tab4"  class="btn tower"  ><span class="icon"></span><span class="text">总公司查询设备动态表</span></a></td>
                    <td width="160px"><a href="<%=basePath %>report/init/tab5" class="btn free" ><span class="icon"></span><span class="text">设备闲置报表</span></a> </td>
                    <td width="160px"><a  href="<%=basePath %>report/init/tab6" class="btn gps"  ><span class="icon"></span><span class="text">GPS回报状态表</span></a></td>
<%--                     <td width="300px"><a  href="<%=basePath %>report/init/2"  class="btn tower"  ><span class="icon"></span><span class="text">塔机动态汇总表</span></a> </td>
                    <td width="300px"><a href="<%=basePath %>report/init/3" class="btn free" ><span class="icon"></span><span class="text">设备闲置报表</span></a> </td>
                    <td width="300px"><a  href="<%=basePath %>report/init/1" class="btn project"  ><span class="icon"></span><span class="text">项目信息汇总表</span></a> </td>
                    <td width="300px"><a  href="<%=basePath %>report/init/2"  class="btn tower"  ><span class="icon"></span><span class="text">塔机动态汇总表</span></a> </td>
                    <td width="300px"><a href="<%=basePath %>report/init/3" class="btn free" ><span class="icon"></span><span class="text">设备闲置报表</span></a></td>  --%>
                  </tr>
                </table></TD>
              <td id="demo2"></td>
            </TR>
          </TABLE>
        </div>
        <div id="next1" style=" float:right; padding-right:20px "> <a href="javascript:void(0);" onmouseover="overMar(0);" onmouseout="outMar();"><img src="<%=basePath %>static/images/arrowright.png" style="width:10px; height:18px; padding-top:14px;"></a></div>
        <script>
var speed=8//速度数值越大速度越慢
var MyMar;
document.getElementById("demo2").innerHTML=document.getElementById("demo1").innerHTML;
//左移动
function MarqueeAdd(){
if(document.getElementById("demo2").offsetWidth-document.getElementById("demo").scrollLeft<=0){
document.getElementById("demo").scrollLeft=document.getElementById("demo").scrollLeft-document.getElementById("demo1").offsetWidth;
}else{
document.getElementById("demo").scrollLeft++;
}
}
//右移动
function MarqueeDes(){
if(document.getElementById("demo2").offsetWidth-document.getElementById("demo").scrollLeft>=0){
document.getElementById("demo").scrollLeft=document.getElementById("demo").scrollLeft+document.getElementById("demo1").offsetWidth;
}else{
document.getElementById("demo").scrollLeft--;
}
}
//鼠标画出停止
function outMar(){
clearInterval(MyMar);
}
//鼠标滑过滚动
function overMar(jadge){
if(jadge==0){
MyMar=setInterval(MarqueeAdd,speed);
}else{
MyMar=setInterval(MarqueeDes,speed);
} 
}
 
//MyMar=setInterval(MarqueeAdd,speed);//自动左移动
//MyMar=setInterval(MarqueeDes,speed);//自动右移动
</script>
      </div>
      <div id="clientItem" class="item">
        <div class="download-list"><a  href="<%=basePath %>index/home" class="btn kanban"  ><span class="icon"></span><span class="text">经营看板</span></a> </div>
      </div>
    </div>
  </div>
  <ul class="firstline1">
    <li class="images red" data-device="#clientItem" value="10"><a href="#" ><img src="<%=basePath %>static/images/icons/128x128/Data--icon.png"/></a> <span class="title">
      <label></label>
      </span>
      <p class="word">
        <label>经营看板</label>
      </p>
    </li>
    <li class="images orange" data-device="#assetItem" value="9"><a href="#"  ><img src="<%=basePath %>static/images/icons/128x128/download-icon1.png"/></a> <span class="title">
      <label></label>
      </span>
      <p class="word">
        <label>报&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;表</label>
      </p>
    </li>
    <li class="images yellow" data-device="#warehouseItem" value="8"><a href="#" ><img src="<%=basePath %>static/images/icons/128x128/data-icon1.png"/></a> <span class="title">
      <label></label>
      </span>
      <p class="word">
        <label>基础信息</label>
      </p>
    </li>
    <li class="images green"  data-device="#gpsItem" value="7"><a href="#" ><img src="<%=basePath %>static/images/icons/128x128/gps.png"/></a> <span class="title">
      <label></label>
      </span>
      <p class="word">
        <label>GPS管理</label>
      </p>
    </li>
    <!--      <li class="images blue"  data-device="#upItem"><a href="#" ></a>
        <p class="word"><label>附件上传</label>
        <span class="title">
        <label >附件上传</label>
        </span></li>
  -->
    <li class="images blue"  data-device="#systemItem" value="6"><a href="#" ><img src="<%=basePath %>static/images/icons/128x128/settings-icon1.png"/></a> <span class="title">
      <label></label>
      </span>
      <p class="word">
        <label>系统设置</label>
      </p>
    </li>
  </ul>
</div>
</div>
<!-- End #menu-content -->
<!-- End #menu -->
<div id="footer"> <small>南狮科技 地址：上海市徐汇区龙州路450弄55号2楼 电话:+86 21 28289418 </small><br />
  <br />
  <small>系统开发 Copyright © 2017 上海南狮科技有限公司 </small> </div>
  </div>
</body>
</html>

</body>
</html>