<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
  String path = request.getContextPath();
  String basePath =  path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <title>塔机动态管理系统</title>
  <!--                       CSS                       -->
  <!-- Reset Stylesheet -->
  <link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
  <!-- Main Stylesheet -->
  <link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen" />
  <!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
  <link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen" />
  <link rel="stylesheet" href="<%=basePath %>static/css/select.css" type="text/css" media="screen" />
  <script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
  <script type="text/javascript" src="<%=basePath %>static/js/facebox.js"></script>
  <script type="text/javascript" src="<%=basePath %>static/js/jquery.wysiwyg.js"></script>
  <script type="text/javascript" src="<%=basePath %>static/js/jquery.datePicker.js"></script>
  <script type="text/javascript" src="<%=basePath %>static/js/jquery.date.js"></script>
  <script type="text/javascript" src="<%=basePath %>static/js/calendar.js"></script>
  <SCRIPT src="<%=basePath %>static/js/jquery.js" type=text/javascript></SCRIPT>
  <SCRIPT src="<%=basePath %>static/js/jQselect.js" type=text/javascript></SCRIPT>
  <SCRIPT type=text/javascript>
    $(document).ready(function() {
      $("#a").selectbox();
      $("#b").selectbox();
      $("#c").selectbox();
      $("#d").selectbox();
      $("#e").selectbox();
      $("#f").selectbox();
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
        <shiro:hasPermission name="leap:projectReport">
          <li><a href="<%=basePath %>report/init/1" > <h4>项目信息汇总表</h4></a></li>
        </shiro:hasPermission>
        <shiro:hasPermission name="leap:towerReport">
          <li> <a href="<%=basePath %>report/init/2" class="default-tab"> <h4>塔机动态汇总表</h4></a></li>
        </shiro:hasPermission>
        <shiro:hasPermission name="leap:unusedDeviceReport">
          <li> <a href="<%=basePath %>report/init/3"> <h4>设备闲置报表</h4></a></li>
        </shiro:hasPermission>
        <!-- href must be unique and match the id of target div -->
      </ul>
      <div class="clear"></div>
      <h3></h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <shiro:hasPermission name="leap:projectReport">
        <div class="tab-content" id="tab1">
          <form action="" method="post">
            <div class="search-actions">
              <div class="search-condition">
                <div class="search-condition-show">
                  <table class="seach-table">
                    <tr>
                      <td><label>所属公司:</label></td>
                      <td ><input type="text" list="company_list" name="link" />
                        <datalist id="company_list">
                          <option label="北京达丰" value="北京达丰"></option>
                          <option label="北京永茂" value="北京永茂"></option>
                          <option label="上海达丰" value="上海达丰"></option>
                          <option label="江苏正和达丰" value="江苏正和达丰"></option>
                          <option label="四川达丰" value="四川达丰" > </option>
                          <option label="中核华兴达丰" value="中核华兴达丰"></option>
                        </datalist></td>
                      <td ><label>项目名称:</label></td>
                      <td ><input name="Input3" type="text" ></td>
                      <td ><label>客户名称:</label></td>
                      <td ><input name="Input" type="text" ></td>
                    </tr>
                  </table>
                </div>
                <div id="search-condition-hidden">
                  <table class="seach-table">
                    <tr>
                      <td ><label>合同编号:</label></td>
                      <td ><input name="Input4" type="text" ></td>
                      <td ><label>截止日期:</label></td>
                      <td ><input name="Input5" type="text" readonly onClick="calendar.show(this)"></td>
                      <td><label>项目状态:</label></td>
                      <td ><input type="text" list="status_list" name="link" />
                        <datalist id="status_list">
                          <option label="启动" value="启动"></option>
                          <option label="关闭" value="关闭"></option>
                        </datalist></td>
                    </tr>
                  </table>
                </div>
              </div>
              <div class="search-button">
                <shiro:hasPermission name="leap:projectReport:query">
                  <a class="button button_position" href="#" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:projectReport:export">
                  <a class="button button_position" href="#" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a>
                </shiro:hasPermission>
              </div>
              <div class="clear"></div>
            </div>
          </form>
          <table>
            <thead>
            <tr>
              <th rowspan="2" class="chebox" scope="col">项次</th>
              <th rowspan="2"  scope="col" >合同编号</th>
              <th rowspan="2"  scope="col">设备编号</th>
              <th rowspan="2"  scope="col" >设备型号</th>
              <th rowspan="2"  scope="col" >承租单位</th>
              <th rowspan="2"  scope="col" >项目名称</th>
              <th rowspan="2"  scope="col" >起租日期</th>
              <th rowspan="2"  scope="col" >停组日期</th>
              <th colspan="3"  scope="col" >项目地点</th>
              <th colspan="3"  scope="col" >方案配置</th>
              <th rowspan="2"  scope="col">所属公司</th>
              <th rowspan="2"  scope="col">管理部门</th>
            </tr>
            <tr>
              <th  scope="col" >所在区域</th>
              <th  scope="col" >省份</th>
              <th  scope="col" >城市</th>
              <th  scope="col" >设备形式</th>
              <th  scope="col" >方案高度</th>
              <th  scope="col">大臂长度</th>
            </tr>
            </thead><tbody>
          <tr>
            <td>1</td>
            <td>ZHTH-ZL2010-27</td>
            <td>ZD-006</td>
            <td>ST50/15A</td>
            <td>北安泰诚机械塔机有限责任公司</td>
            <td>松芝万象城</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>华东区</td>
            <td>安徽省</td>
            <td>合肥市</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>北京达丰</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>2</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>3</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>4</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>5</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>6</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>7</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>8</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>9</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>10</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          </tbody>
            <tfoot>
            <tr>
              <td colspan="16"><div class="bulk-actions align-left">
                <label>共有<b>200</b>条数据</label>
              </div>
                <div class="pagination"> <a href="#" title="First Page">|&lt;</a><a href="#" title="Previous Page">&lt;</a> <a href="#" class="number current" title="1">1</a> <a href="#" class="number" title="2">2</a> <a href="#" class="number" title="3">3</a> <a href="#" class="number" title="4">4</a> <a href="#" title="Next Page">&gt;</a><a href="#" title="Last Page">&gt;|</a> </div>
                <!-- End .pagination -->
                <div class="clear"></div></td>
            </tr>
            </tfoot>
          </table>
        </div>
      </shiro:hasPermission>
      <shiro:hasPermission name="leap:towerReport">
        <div class="tab-content  default-tab" id="tab2">
          <form action="" method="post">
            <div class="search-actions">
              <div class="search-condition">
                <table class="seach-table">
                  <tr>
                    <td><label>管理公司:</label></td>
                    <td ><input type="text" list="company_list" name="link" />
                      <datalist id="company_list">
                        <option label="北京达丰" value="北京达丰"></option>
                        <option label="北京永茂" value="北京永茂"></option>
                        <option label="上海达丰" value="上海达丰"></option>
                        <option label="江苏正和达丰" value="江苏正和达丰"></option>
                        <option label="四川达丰" value="四川达丰" > </option>
                        <option label="中核华兴达丰" value="中核华兴达丰"></option>
                      </datalist></td>
                    <td><label>截止日期:
                    </label></t>
                    <td ><input name="Input5" type="text" readonly onClick="calendar.show(this)"></td>
                  </tr>
                </table>

              </div>
              <div class="search-button">
                <shiro:hasPermission name="leap:towerReport:query">
                  <a class="button button_position" href="#" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:towerReport:export">
                  <a class="button button_position" href="#" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a>
                </shiro:hasPermission>
              </div>
              <div class="clear"></div>
            </div>
          </form>
          <table>
            <thead>
            <tr>
              <th scope="col" class="chebox">项次</th>
              <th  scope="col">塔机编号</th>
              <th  scope="col" >设备来源</th>
              <th  scope="col" >塔机型号</th>
              <th  scope="col" >额定起重力矩</th>
              <th  scope="col" >出厂编号</th>
              <th  scope="col" >项目(仓库)名称</th>
              <th  scope="col" >项目类别</th>
              <th  scope="col" >所在地理区域</th>
              <th  scope="col" >执行状况</th>
              <th  scope="col" >臂架拉杆(汇总)</th>
              <th  scope="col" >变幅机构(汇总)</th>
              <th  scope="col">标准节(汇总)</th>
              <th  scope="col">电源电缆(汇总)</th>
              <th  scope="col">顶升套架(汇总)</th>
              <th  scope="col">附墙框(汇总)</th>
              <th  scope="col">钢丝绳(汇总)</th>
              <th  scope="col">固定脚(汇总)</th>
              <th  scope="col">固定框(汇总)</th>
              <th  scope="col">过渡节(汇总)</th>
              <th  scope="col">回转机构(汇总)</th>
              <th  scope="col">可拆卸地脚(汇总)</th>
              <th  scope="col">配重(汇总)</th>
              <th  scope="col">起重臂(汇总)</th>
              <th  scope="col">提升机构(汇总)</th>
            </tr></thead>
            <tbody>
            <tr>
              <td>1</td>
              <td>ZD-006</td>
              <td>&nbsp;</td>
              <td>ST50/15A</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>2</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>3</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>4</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>5</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>6</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>7</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>8</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>9</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>10</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            </tbody>
            <tfoot>
            <tr>
              <td colspan="25"><div class="bulk-actions align-left">
                <label>共有<b>200</b>条数据</label>
              </div>
                <div class="pagination"> <a href="#" title="First Page">|&lt;</a><a href="#" title="Previous Page">&lt;</a> <a href="#" class="number current" title="1">1</a> <a href="#" class="number" title="2">2</a> <a href="#" class="number" title="3">3</a> <a href="#" class="number" title="4">4</a> <a href="#" title="Next Page">&gt;</a><a href="#" title="Last Page">&gt;|</a> </div>
                <!-- End .pagination -->
                <div class="clear"></div></td>
            </tr>
            </tfoot>
          </table>
        </div>
      </shiro:hasPermission>
      <shiro:hasPermission name="leap:unusedDeviceReport">
        <div class="tab-content" id="tab3">
          <form action="" method="post">
            <div class="search-actions">
              <div class="search-condition">
                <div class="search-condition-show">
                  <table class="seach-table">
                    <tr>
                      <td><label>管理公司:</label></td>
                      <td ><input type="text" list="company_list" name="link" />
                        <datalist id="company_list">
                          <option label="北京达丰" value="北京达丰"></option>
                          <option label="北京永茂" value="北京永茂"></option>
                          <option label="上海达丰" value="上海达丰"></option>
                          <option label="江苏正和达丰" value="江苏正和达丰"></option>
                          <option label="四川达丰" value="四川达丰" > </option>
                          <option label="中核华兴达丰" value="中核华兴达丰"></option>
                        </datalist></td>
                      <td ><label>设备编号:</label></td>
                      <td ><input type="text" list="number_list" name="link" />
                        <datalist id="number_list">
                          <option label="1" value="1"></option>
                          <option label="2" value="2"></option>
                          <option label="3" value="3"></option>
                        </datalist></td>
                      <td ><label>设备型号:</label></td>
                      <td ><input type="text" list="modle_list" name="link" />
                        <datalist id="modle_list">
                          <option label="F0/23B-10T" value="F0/23B-10T"></option>
                          <option label="FH60/15-10T" value="FH60/15-10T" > </option>
                          <option label="ST55/13-6T" value="ST55/13-6T" ></option>
                          <option label="ST5515B-8T" value="ST5515B-8T" ></option>
                          <option label="ST60/15-10T" value="ST60/15-10T" ></option>
                          <option label="ST70/27-16T" value="ST70/27-16T" ></option>
                          <option label="ST70/30-12T" value="ST70/30-12T" ></option>
                          <option label="STT133-6T" value="STT133-6T" ></option>
                          <option label="STT200-10T" value="STT200-10T" ></option>
                          <option label="STT200-12T" value="STT200-12T" ></option>
                          <option label="STT293-12T" value="STT293-12T" ></option>
                          <option label="STT293-18T" value="STT293-18T" ></option>
                          <option label="STT403-24T" value="STT403-24T" ></option>
                          <option label="STT553-24T" value="STT553-24T" ></option>
                        </datalist></td>
                    </tr>

                    <tr>
                      <td><label>放置地点:</label></td>
                      <td ><input name="Input4" type="text" ></td>
                      <td><label>截止日期:</label></td>
                      <td ><input name="Input5" type="text" readonly onClick="calendar.show(this)"></td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                  </table>
                </div>

              </div>
              <div class="search-button">
                <shiro:hasPermission name="leap:unusedDeviceReport:query">
                  <a class="button button_position" href="#" title="查询"><img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:unusedDeviceReport:export">
                  <a class="button button_position" href="#" title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a>
                </shiro:hasPermission>
              </div>

              <div class="clear"></div>
            </div>
          </form>
          <table>
            <thead>
            <tr>
              <th scope="col" class="chebox">项次</th>
              <th  scope="col">设备编号</th>
              <th  scope="col" >设备型号</th>
              <th  scope="col">设备状态</th>
              <th  scope="col">放置地点</th>
              <th  scope="col" class="time">闲置日期</th>
              <th  scope="col">闲置天数</th>
              <th  scope="col">租赁意向</th>
              <th  scope="col">产权公司</th>
              <th  scope="col">所属公司</th>
            </tr></thead>
            <tbody>
            <tr>
              <td>1</td>
              <td>ZD-006</td>
              <td>ST50/15A</td>
              <td>闲置</td>
              <td>仪征仓库</td>
              <td>2010-06-05</td>
              <td>23</td>
              <td>&nbsp;</td>
              <td>北京达丰</td>
              <td>北京达丰</td>
            </tr>
            <tr>
              <td>2</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>3</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>4</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>5</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>6</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>7</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>8</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>9</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            <tr>
              <td>10</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
              <td>&nbsp;</td>
            </tr>
            </tbody>
            <tfoot>
            <tr>
              <td colspan="10"><div class="bulk-actions align-left">
                <label>共有<b>200</b>条数据</label>
              </div>
                <div class="pagination"> <a href="#" title="First Page">|&lt;</a><a href="#" title="Previous Page">&lt;</a> <a href="#" class="number current" title="1">1</a> <a href="#" class="number" title="2">2</a> <a href="#" class="number" title="3">3</a> <a href="#" class="number" title="4">4</a> <a href="#" title="Next Page">&gt;</a><a href="#" title="Last Page">&gt;|</a> </div>
                <!-- End .pagination -->
                <div class="clear"></div></td>
            </tr>
            </tfoot>
          </table>
        </div>
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
</html>