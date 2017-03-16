<%@ page language="java" contentType="text/html; charset=UTF-8"%>
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
<link rel="stylesheet" href="<%=basePath %>static/css/top.css" type="text/css" media="screen" />
<!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
<link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen" />
<script type="text/javascript" src="<%=basePath %>static/js/jquery-1.3.2.min.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/facebox.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery.wysiwyg.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery.datePicker.js"></script>
<script type="text/javascript" src="<%=basePath %>static/js/jquery.date.js"></script>
<script type="text/javascript"src="http://code.jquery.com/jquery-1.8.1.min.js"></script>
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
        <li><a href="#tab1" > <h4>设备定位</h4></a></li>
        <!-- href must be unique and match the id of target div -->
        <li> <a href="#tab2"> <h4>历史轨迹</h4></a></li>
         <li> <a href="#tab3"> <h4>信令发送</h4></a></li>
          <li> <a href="#tab4"> <h4>人工定位</h4></a></li>
           <li> <a href="#tab5"  class="default-tab"> <h4>gps维修</h4></a></li>
      </ul>
      <div class="clear"></div>
      <h3></h3>
    </div>
    <!-- End .content-box-header -->
    <div class="content-box-content">
      <div class="tab-content " id="tab1">
       <form action="" method="post">
        <div class="search-actions">
          <div class="search-condition">
            <div class="search-condition-show">
              <table class="seach-table">
                <tr>
                    <td ><label>管理公司:</label></td>
                  <td><input type="text" list="company_list" name="link" />
                      <datalist id="company_list">
                         <option label="北京达丰" value="北京达丰"></option>
                        <option label="北京永茂" value="北京永茂"></option>
                        <option label="上海达丰" value="上海达丰"></option>
                        <option label="江苏正和达丰" value="江苏正和达丰"></option>
                        <option label="四川达丰" value="四川达丰" > </option>
                        <option label="中核华兴达丰" value="中核华兴达丰"></option>
                      </datalist></td>
      <td><label>设备编号:</label></td>
      <td ><input type="text" list="modle_list" name="link" />
                          <datalist id="modle_list">
                          <option label="1" value="1"></option>
                          <option label="2" value="2" > </option>
                          <option label="3" value="3" ></option>
                          <option label="4" value="4" ></option>
                         
                        </datalist></td>
      <td><label>设备类别:</label></td>
      <td ><input type="text" list="name_list" name="link" />
                          <datalist id="name_list">
                  <option label="塔机" value="塔机"></option>
                  <option label="汽车" value="汽车"></option>
                </datalist></td>
    </tr>
    
    <tr>
      <td class="px4z"><label>所在区域:</label></td>
      <td width="200px"><input type="text" list="area_list" name="link" />
                      <datalist id="area_list">
                    <option label="华北区" value="华北区"></option>
                    <option label="东北区" value="东北区"></option>
                    <option label="华东区" value="华东区"></option>
                    <option label="华南区" value="华南区"></option>
                    <option label="西北区" value="西北区"></option>
                    <option label="西南区" value="西南区"></option>
                  </datalist></td>
      <td class="px4z"><label>所在省份:</label></td>
      <td > <input type="text" list="province_list" name="link" />
                      <datalist id="province_list">
                    <option label="北京市" value="北京市"></option>
                    <option label="上海市" value="上海市"></option>
                    <option label="天津市" value="天津市"></option>
                    <option label="江苏省" value="江苏省"></option>
                  </datalist></td>
                  <td></td>
                  <td></td>
     
    </tr>
  </table> </div>
          </div>
          <div class="search-button"> <a class="button button_position" href="javascript:void(0)" title="查询"><img src="../resources/images/icons/search_icon.png" class="px18"/></a></div>
         
          <div class="clear"></div>
        </div>
        </form>
        <table>
          <thead>
          <tr>
            <th width="18px"><input class="check-all" type="checkbox" /></th>
            <th scope="col" class="chebox">项次</th>
            <th  scope="col">塔机编号</th>
            <th  scope="col" >塔机类型</th>
            <th  scope="col" >执行状况</th>
            <th  scope="col" >所在区域</th>
            <th  scope="col" >省份</th>
            <th  scope="col">所属公司</th>
            <th  scope="col">查看位置</th>
            </tr>
            </thead>
            <tbody>
		<tr>
		  <td><input name="" type="checkbox" value=""></td>
		  <td>1</td>
		  <td>ZD-006</td>
		  <td>塔式起重机</td>
		  <td>在使用</td>
		  <td>华东区</td>
		  <td>安徽省</td>
		  <td>北京达丰</td>
		  <td><a><img src="../resources/images/icons/map-icon.png" class="earth" title="查看地图"/></a></td>
		  </tr>
        <tr>
          <td><input name="input" type="checkbox" value=""></td>
          <td>2</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>	
        <tr>
          <td><input name="input2" type="checkbox" value=""></td>
          <td>3</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>	
        <tr>
          <td><input name="input3" type="checkbox" value=""></td>
          <td>4</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>	
        <tr>
          <td><input name="input4" type="checkbox" value=""></td>
          <td>5</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>	
        <tr>
          <td><input name="input5" type="checkbox" value=""></td>
          <td>6</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>	
        <tr>
          <td><input name="input6" type="checkbox" value=""></td>
          <td>7</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>	
        <tr>
          <td><input name="input7" type="checkbox" value=""></td>
          <td>8</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>	
        <tr>
          <td><input name="input8" type="checkbox" value=""></td>
          <td>9</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          </tr>	
        <tr>
          <td><input name="input9" type="checkbox" value=""></td>
          <td>10</td>
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
              <td colspan="9"><div class="bulk-actions align-left">
                  <label>共有<b>200</b>条数据</label>
                </div>
                <div class="pagination"> <a href="javascript:void(0)" title="First Page">|&lt;</a><a href="javascript:void(0)" title="Previous Page">&lt;</a> <a href="javascript:void(0)" class="number current" title="1">1</a> <a href="javascript:void(0)" class="number" title="2">2</a> <a href="javascript:void(0)" class="number" title="3">3</a> <a href="javascript:void(0)" class="number" title="4">4</a> <a href="javascript:void(0)" title="Next Page">&gt;</a><a href="javascript:void(0)" title="Last Page">&gt;|</a> </div>
                <!-- End .pagination -->
                <div class="clear"></div></td>
            </tr>
          </tfoot>
        </table>
      </div>
      <!-- End #tab1 -->
       <div class="tab-content" id="tab2">
        <form action="" method="post">
          <div class="search-actions">
            <div class="search-condition">
              <table class="seach-table">
                <tr>
                  <td ><label>所属公司:</label></td>
                  <td><input type="text" list="company_list" name="link" />
                      <datalist id="company_list">
                         <option label="北京达丰" value="北京达丰"></option>
                        <option label="北京永茂" value="北京永茂"></option>
                        <option label="上海达丰" value="上海达丰"></option>
                        <option label="江苏正和达丰" value="江苏正和达丰"></option>
                        <option label="四川达丰" value="四川达丰" > </option>
                        <option label="中核华兴达丰" value="中核华兴达丰"></option>
                      </datalist></td>
                  <td><label><b style="color:#FF0000;">*</b>设备编号:</label></td>
                  <td ><input type="text" list="modle_list" name="link" />
                          <datalist id="modle_list">
                          <option label="1" value="1"></option>
                          <option label="2" value="2" > </option>
                          <option label="3" value="3" ></option>
                          <option label="4" value="4" ></option>
                         
                        </datalist></td>
                </tr>
               <tr>
                  <td ><label><b style="color:#FF0000;">*</b>轨迹精度:</label></td>
                  <td colspan="3" style="text-align:left"><label>
                    <input type="radio" name="RadioGroup1" value="单选" id="RadioGroup1_0" style="width:30px;">
                    精确  提示:精确只能查询两小时以内的历史轨迹!</label>
                    <br>
                    <label>
                    <input type="radio" name="RadioGroup1" value="单选" id="RadioGroup1_1"  style="width:30px;">
                    普通  提示:标准只能查询十个小时以内的历史轨迹!</label>
                    <br>
                    <label>
                    <input type="radio" name="RadioGroup1" value="单选" id="RadioGroup1_2"  style="width:30px;">
                    模糊  提示:模糊查询20个小时以内的历史轨迹!</label>
                  </td>
                </tr>
                <tr>
                  <td ><label><b style="color:#FF0000;">*</b>起迄时间:</label></td>
                  <td ><input name="Input2" type="text"  onclick="new Calendar().show(this);" readonly></td>
                    
                   <td > <label> ~</label></td>
                  <td >  <input name="Input4" type="text"  onclick="new Calendar().show(this);" readonly>
                    </td>
                </tr>
              </table>
            </div>
            <div class="search-button"> <a class="button button_position" href="javascript:void(0)" title="查询"><img src="../resources/images/icons/search_icon.png" class="px18"/></a> </div>
            <div class="clear"></div>
          </div>
           <table border="0" >
           <tr><td><a href="javascript:void(0)" class="history">设备087101z333历史轨迹</a></td></tr>
           </table>
        </form>
      </div>
      <!-- End #tab2 -->
       <div class="tab-content" id="tab3">
        <form action="" method="post">
          <div class="search-actions">
          <div class="search-condition">
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
                <td><label>设备编号:</label></td>
                <td ><input name="Input" type="text" ></td>
              </tr>
              <tr>
                <td ><label>功能列表:</label></td>
                <td ><input type="text" list="type_list" name="link" />
                      <datalist id="type_list">
                      <option label="通电" value="通电"> </option>
                      <option label="断电" value="断电"> </option>
                      <option label=" 更改IP地址" value=" 更改IP地址"></option>
                      <option label="ACC关定时发送时间" value="ACC关定时发送时间"> </option>
                      <option label=" 汇报间隔" value=" 汇报间隔" ></option>
                    </datalist></td>
                   <td><label>提示:</label></td>
                <td><input type="text" list="type_list1" name="link" />
                      <datalist id="type_list1">
                    <option label="例:219.134.132.093,8889 地址中间不足三个字符的前面补'0'" value="例:219.134.132.093,8889 地址中间不足三个字符的前面补'0'"></option>
                    <option label="请输入数字" value="请输入数字"></option>
                    <option label="例:调度测试信息" value="例:调度测试信息"></option>
                    </datalist></td>
              </tr>
              <tr>
                <td><label>值:</label></td>
                <td ><input name="Input" type="text" ></td>
               <td colspan="2"><a class="button button_position" href="javascript:void(0)" title="send"><img src="../resources/images/icons/send_icon.png" class="px18"/></a> </td>
              </tr>
            </table>
          </div>
          <div class="search-button"> <a class="button button_position" href="javascript:void(0)" title="查询"><img src="../resources/images/icons/search_icon.png" class="px18"/></a> </div>
          <div class="clear"></div>
           </div>
        </form>
     
      <table>
        <thead>
          <tr>
            <th width="18px"><input class="check-all" type="checkbox" /></th>
            <th  scope="col" class="chebox">项次</th>
            <th  scope="col" >设备编号</th>
            <th  scope="col">设备型号</th>
            <th  scope="col">SIM卡号</th>
            <th  scope="col">设备类别</th>
            <th  scope="col">设备状态</th>
            <th  scope="col">所属公司</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td><input name="" type="checkbox" value=""></td>
            <td>1</td>
            <td>001Z0001</td>
            <td>STT553</td>
            <td>15062446570</td>
            <td>塔式起重机</td>
            <td>在使用</td>
            <td>北京达丰</td>
          </tr>
          <tr>
            <td><input name="input" type="checkbox" value=""></td>
            <td>2</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><input name="input2" type="checkbox" value=""></td>
            <td>3</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><input name="input3" type="checkbox" value=""></td>
            <td>4</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><input name="input4" type="checkbox" value=""></td>
            <td>5</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><input name="input5" type="checkbox" value=""></td>
            <td>6</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><input name="input6" type="checkbox" value=""></td>
            <td>7</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><input name="input7" type="checkbox" value=""></td>
            <td>8</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><input name="input8" type="checkbox" value=""></td>
            <td>9</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td><input name="input9" type="checkbox" value=""></td>
            <td>10</td>
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
            <td colspan="8"><div class="bulk-actions align-left">
                <label>共有<b>200</b>条数据</label>
              </div>
              <div class="pagination"> <a href="javascript:void(0)" title="First Page">|&lt;</a><a href="javascript:void(0)" title="Previous Page">&lt;</a> <a href="javascript:void(0)" class="number current" title="1">1</a> <a href="javascript:void(0)" class="number" title="2">2</a> <a href="javascript:void(0)" class="number" title="3">3</a> <a href="javascript:void(0)" class="number" title="4">4</a> <a href="javascript:void(0)" title="Next Page">&gt;</a><a href="javascript:void(0)" title="Last Page">&gt;|</a> </div>
              <!-- End .pagination -->
              <div class="clear"></div></td>
          </tr>
        </tfoot>
      </table>
    </div>
    <!-- End #tab3 -->
     <div class="tab-content " id="tab4">
       <form action="" method="post">
        <div class="search-actions">
          <div class="search-condition">
              <table class="seach-table">
                <tr>
                  <td ><label>管理公司:</label></td>
                  <td><input type="text" list="company_list" name="link" />
                      <datalist id="company_list">
                         <option label="北京达丰" value="北京达丰"></option>
                        <option label="北京永茂" value="北京永茂"></option>
                        <option label="上海达丰" value="上海达丰"></option>
                        <option label="江苏正和达丰" value="江苏正和达丰"></option>
                        <option label="四川达丰" value="四川达丰" > </option>
                        <option label="中核华兴达丰" value="中核华兴达丰"></option>
                      </datalist></td>
     
      <td><label>回报状态:</label></td>
      <td ><input type="text" list="status_list" name="link" />
                      <datalist id="status_list">                      
                        <option label="回报异常" value="回报异常"></option>
                      </datalist></td>
    </tr>
  </table> </div>
          <div class="search-button"> <a class="button button_position" href="javascript:void(0)" title="查询"><img src="../resources/images/icons/search_icon.png" class="px18"/></a>  <a class="button button_position" href="javascript:void(0)" title="导出"><img src="../resources/images/icons/export_icon.png" class="px18"/></a> </div>
          <div class="clear"></div>
        </div>
        </form>
        <table>
          <thead>
          <tr>
            <th scope="col" class="chebox">项次</th>
            <th  scope="col" >设备编号</th>
            <th  scope="col">设备型号</th>
            <th  scope="col">SIM卡号</th>
            <th  scope="col">设备类别</th>
            <th  scope="col">设备状态</th>
            <th  scope="col">所属公司</th>
            <th  scope="col" class="time">最后回报时间</th>
            <th  scope="col" class="time">人工定位时间</th>
            <th  scope="col" class="picture2">编辑</th>
            </tr></thead><tbody>
		<tr>
		  <td>1</td>
		  <td>001Z0001</td>
		  <td>STT553</td>
		  <td>15062446570</td>
		  <td>塔式起重机</td>
		  <td>在使用</td>
		  <td>北京达丰</td>
		  <td>2010-09-01 10:17:04</td>
		  <td>2010-07-14 09:14:26</td>
		  <td><a  class="edit"><img src="../resources/images/icons/pencil.png" title="编辑"/></a></td>
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
                <div class="pagination"> <a href="javascript:void(0)" title="First Page">|&lt;</a><a href="javascript:void(0)" title="Previous Page">&lt;</a> <a href="javascript:void(0)" class="number current" title="1">1</a> <a href="javascript:void(0)" class="number" title="2">2</a> <a href="javascript:void(0)" class="number" title="3">3</a> <a href="javascript:void(0)" class="number" title="4">4</a> <a href="javascript:void(0)" title="Next Page">&gt;</a><a href="javascript:void(0)" title="Last Page">&gt;|</a> </div>
                <!-- End .pagination -->
                <div class="clear"></div></td>
            </tr>
          </tfoot>
        </table>
      </div>
      <!-- End #tab4 -->
       <div class="tab-content default-tab" id="tab5">
       <form action="" method="post">
        <div class="search-actions">
          <div class="search-condition">
              <table class="seach-table">
                <tr>
                  <td><label>塔机编号:</label></td>
      <td ><input name="Input" type="text" ></td>
      <td><label>寄出时间:</label></td>
      <td ><input type="text" readonly="ture"  onclick="new Calendar().show(this);">~<input type="text" readonly="ture" onclick="new Calendar().show(this);"></td>
      </tr>
  </table>
</div>
          <div class="search-button"> <a class="button button_position" href="javascript:void(0)" title="查询"><img src="../resources/images/icons/search_icon.png" class="px18"/></a> <a class="button button_position" href="GPS_edit.html" title="新增"><img src="../resources/images/icons/add_icon.png" class="px18"/></a> <a class="button button_position" href="javascript:void(0)" title="导出"><img src="../resources/images/icons/export_icon.png" class="px18"/></a> </div>
          <div class="clear"></div>
        </div>
        </form>
        <table>
          <thead>
            <tr>
                  <th scope="col" class="chebox">项次</th>
              <th  scope="col">塔机编号</th>
            <th  scope="col">所在位置</th>
            <th  scope="col">机具编号</th>
            <th  scope="col" >Sim卡号</th>
            <th  scope="col" >GPS运行状况</th>
            <th  scope="col">异常原因</th>
            <th  scope="col">拆除部件</th>
            <th  scope="col">寄出时间</th>
            <th  scope="col">返回时间</th>
            <th  scope="col" class="picture2">编辑</th>
            </tr></thead><tbody>
		<tr>
		  <td>1</td>
		  <td>BJTHZ081001</td>
		  <td>&nbsp;</td>
		  <td>ST5515B</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>&nbsp;</td>
		  <td>2010-12-12</td>
		  <td>2010-12-12</td>
		  <td><a href="GPS_edit.html" class="edit"><img src="../resources/images/icons/pencil.png" title="编辑"/></a><a href="javascript:void(0)" onClick="showdelete()" class="delete"><img src="../resources/images/icons/cross.png" title="删除"/></a></td>
		  </tr>
        <tr>
          <td>2</td>
          <td>BJTHZ081002</td>
          <td>&nbsp;</td>
          <td>ST5515B</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>2010-10-11</td>
          <td>2010-10-11</td>
          <td><a href="GPS_edit.html" class="edit"><img src="../resources/images/icons/pencil.png" alt="修改" title="编辑"/></a><a href="javascript:void(0)" onClick="showdelete()" class="delete"><img src="../resources/images/icons/cross.png" alt="删除" title="删除"/></a></td>
          </tr>	
        <tr>
          <td>3</td>
          <td>BJTHZ081003</td>
          <td>&nbsp;</td>
          <td>ST5515B</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>2010-12-15</td>
          <td>2010-12-15</td>
          <td><a href="GPS_edit.html" class="edit"><img src="../resources/images/icons/pencil.png" alt="修改" title="编辑"/></a><a href="javascript:void(0)" onClick="showdelete()" class="delete"><img src="../resources/images/icons/cross.png" alt="删除" title="删除"/></a></td>
          </tr>	
        <tr>
          <td>4</td>
          <td>BJTHZ081004</td>
          <td>&nbsp;</td>
          <td>ST5515B</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>2010-12-19</td>
          <td>2010-12-19</td>
          <td><a href="GPS_edit.html" class="edit"><img src="../resources/images/icons/pencil.png" alt="修改" title="编辑"/></a><a href="javascript:void(0)" onClick="showdelete()" class="delete"><img src="../resources/images/icons/cross.png" alt="删除" title="删除"/></a></td>
          </tr>	
        <tr>
          <td>5</td>
          <td>BJTHZ081005</td>
          <td>&nbsp;</td>
          <td>ST5515B</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>2010-12-20</td>
          <td>2010-12-20</td>
          <td><a href="GPS_edit.html" class="edit"><img src="../resources/images/icons/pencil.png" alt="修改" title="编辑"/></a><a href="javascript:void(0)" onClick="showdelete()" class="delete"><img src="../resources/images/icons/cross.png" alt="删除" title="删除"/></a></td>
          </tr>	
        <tr>
          <td>6</td>
          <td>BJTHZ087005</td>
          <td>&nbsp;</td>
          <td>F0/23B</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>2010-12-21</td>
          <td>2010-12-21</td>
          <td><a href="GPS_edit.html" class="edit"><img src="../resources/images/icons/pencil.png" alt="修改" title="编辑"/></a><a href="javascript:void(0)" onClick="showdelete()" class="delete"><img src="../resources/images/icons/cross.png" alt="删除" title="删除"/></a></td>
          </tr>	
        <tr>
          <td>7</td>
          <td>BJTHZ087001</td>
          <td>&nbsp;</td>
          <td>F0/23B</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>2010-12-22</td>
          <td>2010-12-22</td>
          <td><a href="GPS_edit.html" class="edit"><img src="../resources/images/icons/pencil.png" alt="修改" title="编辑"/></a><a href="javascript:void(0)" onClick="showdelete()" class="delete"><img src="../resources/images/icons/cross.png" alt="删除" title="删除"/></a></td>
          </tr>	
        <tr>
          <td>8</td>
          <td>BJTHZ087002</td>
          <td>&nbsp;</td>
          <td>F0/23B</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>2010-12-23</td>
          <td>2010-12-23</td>
          <td><a href="GPS_edit.html" class="edit"><img src="../resources/images/icons/pencil.png" alt="修改" title="编辑"/></a><a href="javascript:void(0)" onClick="showdelete()" class="delete"><img src="../resources/images/icons/cross.png" alt="删除" title="删除"/></a></td>
          </tr>	
        <tr>
          <td>9</td>
          <td>BJTHZ087003</td>
          <td>&nbsp;</td>
          <td>F0/23B</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>2010-12-24</td>
          <td>2010-12-24</td>
          <td><a href="GPS_edit.html" class="edit"><img src="../resources/images/icons/pencil.png" alt="修改" title="编辑"/></a><a href="javascript:void(0)" onClick="showdelete()" class="delete"><img src="../resources/images/icons/cross.png" alt="删除" title="删除"/></a></td>
          </tr>	
        <tr>
          <td>10</td>
          <td>BJTHZ087004</td>
          <td>&nbsp;</td>
          <td>F0/23B</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>2010-12-25</td>
          <td>2010-12-25</td>
          <td><a href="GPS_edit.html" class="edit"><img src="../resources/images/icons/pencil.png" alt="修改" title="编辑"/></a><a href="javascript:void(0)" onClick="showdelete()" class="delete"><img src="../resources/images/icons/cross.png" alt="删除" title="删除"/></a></td>
          </tr>				
     </tbody>
          <tfoot>
            <tr>
              <td colspan="11"><div class="bulk-actions align-left">
                  <label>共有<b>200</b>条数据</label>
                </div>
                <div class="pagination"> <a href="javascript:void(0)" title="First Page">|&lt;</a><a href="javascript:void(0)" title="Previous Page">&lt;</a> <a href="javascript:void(0)" class="number current" title="1">1</a> <a href="javascript:void(0)" class="number" title="2">2</a> <a href="javascript:void(0)" class="number" title="3">3</a> <a href="javascript:void(0)" class="number" title="4">4</a> <a href="javascript:void(0)" title="Next Page">&gt;</a><a href="javascript:void(0)" title="Last Page">&gt;|</a> </div>
                <!-- End .pagination -->
                <div class="clear"></div></td>
            </tr>
          </tfoot>
        </table>
      </div>
      <!-- End #tab5 -->
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
