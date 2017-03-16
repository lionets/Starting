<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = path + "/";
%>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>塔机动态管理系统</title>
    <!--                       CSS                       -->
    <link rel="stylesheet" type="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/default/easyui.css">
    <link rel="stylesheet" type="<%=basePath %>static/js/jquery-easyui-1.4.1/themes/icon.css">
    <link rel="stylesheet" href="<%=basePath %>static/js/paging/pagination.css"/>
    <link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen"/>
    <!-- Main Stylesheet -->
    <link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen"/>
    <!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
    <link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen"/>
    <link rel="stylesheet" href="<%=basePath %>static/css/select.css" type="text/css" media="screen"/>
    <script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>static/js/paging/jquery.pagination.js"></script>
    <script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
    <SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></SCRIPT>
    <script src="<%=basePath %>static/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script type="text/javascript"
            src="http://api.map.baidu.com/api?v=2.0&ak=kOTXraW2Ff9FPlYxLkqPsyX2"></script>
    <SCRIPT type=text/javascript>
    using(['window'], function () {
    });//加载window插件
    using(['combobox']);//加载window插件  
    function loadTowerNo1(){
        $.ajax( {
            dataType : "JSON",
            type : "POST",
            url : "<%=basePath%>driverManage/loadTowerNo",
            data : "manage_company="+$('[name="manageCompanyId"]').val(),
            success : function(html) {
            	var arr = [];
            	arr[0] ={"tower_no":"不限","tower_no":"不限"}
            	html = arr.concat(html);  
                using(['combobox'],function(){
                    $("#towerNo1").combobox(
                    		{
                    			valueField: 'tower_no',
                    			textField: 'tower_no',
                    			data:html
                    		}
                    	);
                    $("#towerNo1").combobox("setValue","不限");
                });
            },
            error : function(html) {
                   
            }
        });
    }
    function loadTowerNo2(){
        $.ajax( {
            dataType : "JSON",
            type : "POST",
            url : "<%=basePath%>driverManage/loadTowerNo",
            data : "manage_company="+$('[name="manageCompanyId"]').val(),
            success : function(html) {
            	var arr = [];
            	arr[0] ={"tower_no":"不限","tower_no":"不限"}
            	html = arr.concat(html);
                using(['combobox'],function(){
                    $("#towerNo2").combobox(
                    		{
                    			valueField: 'tower_no',
                    			textField: 'tower_no',
                    			data:html
                    		}
                    	);
                    $("#towerNo2").combobox("setValue","不限");
                });
            },
            error : function(html) {
                   
            }
        });
    }
    

        //删除一条记录
        function showdelete(id, tab, count) {
            tatongMethod.confirm("删除", "确定要删除吗?", function () {
                var url = "<%=basePath %>driverManage/deleteOne/" + tab + "?id=" + id;
                if (tab == "tab4") {
                    if ("${count}" % tab4PerPage == 1) {
                        tab4PageNum--;
                        if (tab4PageNum < 0) {
                            tab4PageNum = 0;
                        }
                    }
                    $("#tab4PageNum").val(tab4PageNum);
                    $("#tab4PerPage").val(tab4PerPage);
                    $("#form4").attr("action", url);
                    $("#form4").submit();
                }
                if (tab == "tab6") {
                    var url = "<%=basePath %>driverManage/deleteOneGpsManage/" + tab + "?id=" + id;
                    if ("${count}" % tab6PerPage == 1) {
                        tab6PageNum--;
                        if (tab6PageNum < 0) {
                            tab6PageNum = 0;
                        }
                    }
                    $("#tab6PageNum").val(tab6PageNum);
                    $("#tab6PerPage").val(tab6PerPage);
                    $("#form6").attr("action", url);
                    $("#form6").submit();
                }
            })
        }


        function exportGps() {
            var url = "<%=basePath %>driverManage/exportGpsManageExcel";
            $("#form6").attr("action", url);
            $("#form6").submit();
            url = "<%=basePath %>driverManage/init/tab6";
            $("#form6").attr("action", url);
        }


        function changePage(index, jq) {
            if (jq.attr("id") == "pagination1") {
                $("#tab1PageNum").val(index);
                $("#tab1PerPage").val(tab1PerPage);
                $("#form1").submit();
            }
            if (jq.attr("id") == "pagination2") {
                $("#tab2PageNum").val(index);
                $("#tab2PerPage").val(tab2PerPage);
                $("#form2").submit();
            }
            if (jq.attr("id") == "pagination3") {
                $("#tab3PageNum").val(index);
                $("#tab3PerPage").val(tab3PerPage);
                $("#form3").submit();
            }
            if (jq.attr("id") == "pagination4") {
                $("#tab4PageNum").val(index);
                $("#tab4PerPage").val(tab4PerPage);
                $("#form4").submit();
            }
            if (jq.attr("id") == "pagination5") {
                $("#tab5PageNum").val(index);
                $("#tab5PerPage").val(tab5PerPage);
                $("#form5").submit();
            }
            if (jq.attr("id") == "pagination6") {
                $("#tab6PageNum").val(index);
                $("#tab6PerPage").val(tab5PerPage);
                $("#form6").submit();
            }
        }


        //公司管理分页,传递只需要页码和每页条数即可
        var tab1PageNum = "${tab1PageNum}" == "" ? 0 : "${tab1PageNum}";
        var tab1PerPage = "${tab1PerPage}" == "" ? 10 : "${tab1PerPage}";
        //职务管理分页
        var tab2PageNum = "${tab3PageNum}" == "" ? 0 : "${tab3PageNum}";
        var tab2PerPage = "${tab3PerPage}" == "" ? 10 : "${tab3PerPage}";
        //职务管理分页
        var tab3PageNum = "${tab3PageNum}" == "" ? 0 : "${tab3PageNum}";
        var tab3PerPage = "${tab3PerPage}" == "" ? 10 : "${tab3PerPage}";
        //公共资料分页
        var tab4PageNum = "${tab4PageNum}" == "" ? 0 : "${tab4PageNum}";
        var tab4PerPage = "${tab4PerPage}" == "" ? 10 : "${tab4PerPage}";
        //公共资料分页
        var tab5PageNum = "${tab5PageNum}" == "" ? 0 : "${tab5PageNum}";
        var tab5PerPage = "${tab5PerPage}" == "" ? 10 : "${tab5PerPage}";
        //公共资料分页
        var tab6PageNum = "${tab6PageNum}" == "" ? 0 : "${tab6PageNum}";
        var tab6PerPage = "${tab6PerPage}" == "" ? 10 : "${tab6PerPage}";

        //控制应该显示的面板
        var togle = function (tab) {
            $("#" + tab).siblings().hide();
            $("#a" + tab).addClass("current");
            $("#" + tab).show();
            //初始化分页默认每页显示10条
            if (tab == "tab1") {
                initPagination("pagination1", "${count}", 10, tab1PageNum);
            }
            if (tab == "tab2") {
                //ajax加载数据
                //companyListView("companyid");
                //initPagination("pagination2","${count}",10,tab2PageNum);
            }
            if (tab == "tab3") {
                initPagination("pagination3", "${count}", 10, tab3PageNum);
            }
            if (tab == "tab4") {
                initPagination("pagination4", "${count}", 10, tab4PageNum);
            }
            if (tab == "tab5") {
                initPagination("pagination5", "${count}", 10, tab5PageNum);
            }
            if (tab == "tab6") {
                initPagination("pagination6", "${count}", 10, tab6PageNum);
            }
        }


        //分页初始化传入id代表要创建分页的id号，参数count代表总数量，perPage表示每页显示条数,current_page为当前页
        function initPagination(id, count, perPage, current_page) {
            $("#" + id).pagination(count, {
                items_per_page: perPage, //每页显示数目
                num_edge_entries: 4,//边缘页后面显示数目
                num_display_entries: 4,//边缘页前面显示数目
                current_page: current_page,//显示第1页
                prev_text: "上页",
                next_text: "下页",
                ellipse_text: "...",//中间缺省内容
                prev_show_always: true,
                next_show_always: true,
                show_if_single_page: true,
                callback: changePage,
                load_first_page: false,
            });
        }
        ;

        $(document).ready(function () {
            //控制显示的面板
            var tab = "${tab}";
            togle(tab);
            //根据点击的id发送请求
            $(".atab").on("click", function () {
                var url = "<%=basePath %>driverManage/init/" + $(this).attr("name");
                if ($(this).attr("name") == "tab1") {
                    url += "?tab1PageNum=" + tab1PageNum + "&tab1PerPage=" + tab1PerPage;
                }
                if ($(this).attr("name") == "tab2") {
                    url += "?tab2PageNum=" + tab2PageNum + "&tab2PerPage=" + tab2PerPage;
                }
                if ($(this).attr("name") == "tab3") {
                    url += "?tab3PageNum=" + tab3PageNum + "&tab3PerPage=" + tab3PerPage;
                }
                if ($(this).attr("name") == "tab4") {
                    url += "?tab4PageNum=" + tab4PageNum + "&tab4PerPage=" + tab4PerPage;
                }
                if ($(this).attr("name") == "tab5") {
                    url += "?tab5PageNum=" + tab5PageNum + "&tab5PerPage=" + tab5PerPage;
                }
                if ($(this).attr("name") == "tab6") {
                    url += "?tab6PageNum=" + tab6PageNum + "&tab6PerPage=" + tab6PerPage;
                }
                location.href = url;
            })
            
            //动态加载地区和省份
            
              using(['combobox'],function(){
		    		$('#area').combobox({
		    			url:'<%=basePath %>area/getAreainfo?areaType=1',
		    			valueField:'areaCode',
		    			textField:'areaName',
		    			onSelect:function(rec){
		    				//alert(JSON.stringify(rec));
		    				$('#province').combobox('clear');
		    				var url = '<%=basePath %>area/getAreainfo?areaType=2&areaCode='+rec.areaCode;
		    				$('#province').combobox({
		    					valueField:'areaCode',
		    					textField:'areaName',
		    				});
		    				$('#province').combobox('reload', url);
		    			}
		    		});
              })
        });

        //地图相关


        function addTips(point, marker) {
            //添加提示信息
            var geoc = new BMap.Geocoder();
            geoc.getLocation(point, function (rs) {
                var addComp = rs.addressComponents;
                var address = addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
                var opts = {
                    width: 200,     // 信息窗口宽度
                    height: 10,     // 信息窗口高度
                    title: "地址:"
                }
                var infoWindow = new BMap.InfoWindow(address, opts);
                marker.addEventListener("mouseover", function () {
                    map.openInfoWindow(infoWindow, point)
                });
            })
        }

        var map;
        function addMarker(point, label) {
            var myIcon = new BMap.Icon("<%=basePath %>static/images/towerpic.gif", new BMap.Size(155, 90), {
                anchor: new BMap.Size(23,48)
            });
            var marker = new BMap.Marker(point, {icon: myIcon});  // 创建标注
            //var marker = new BMap.Marker(point);  // 创建标注
            map.addOverlay(marker);
            marker.setLabel(label);
            addTips(point, marker);
        }

        function sendAjax() {
            if ($("[name='endTime']").val() != "" && $("[name='startTime']").val() == "" || $("[name='endTime']").val() == "" && $("[name='startTime']").val() != "") {
                tatongMethod.alert("提示", "请正确选择时间段！");
                return;
            }
            $("#allmap").children().remove();
            //ajax请求将表单域直接序列化
            $.ajax({
                dataType: "html",
                type: "POST",
                url: "<%=basePath %>driverManage/ajax",
                data: $("#form2").serialize(),
                success: function (json) {
                    var json = $.parseJSON(json);
                    if (json.flag == "no") {
                        tatongMethod.alert("提示", json.msg);
                    }
                    else {
                        // 百度地图API功能
                        map = new BMap.Map("allmap");
                        var gpsList = json.gpsList
                        var points = [];
                        map.centerAndZoom(new BMap.Point(gpsList[0].latitude, gpsList[0].longitude), 11);
                        map.addControl(new BMap.NavigationControl());        // 添加平移缩放控件
                        map.addControl(new BMap.ScaleControl());             // 添加比例尺控件
                        map.addControl(new BMap.OverviewMapControl());       //添加缩略地图控件
                        map.enableScrollWheelZoom();
                        for (var i = 0; i < gpsList.length; i++) {
                            var longitude = gpsList[i].longitude;
                            var latitude = gpsList[i].latitude;
                            var point = new BMap.Point(latitude, longitude);
                            map.centerAndZoom(point);
                            points[i] = point;
                            if (gpsList.length == 1) {
                                addMarker(point);
                            } else {
                                if (i == 0) {
                                    var label = new BMap.Label("起点", {offset: new BMap.Size(20, -10)});
                                    addMarker(point, label);
                                }
                                else if (i == gpsList.length - 1) {
                                    var label = new BMap.Label("终点", {offset: new BMap.Size(20, -10)});
                                    addMarker(point, label);
                                }
                                else {
                                    addMarker(point);
                                }
                            }

                        }
                        var polyline = new BMap.Polyline(points, {
                            strokeColor: "blue",
                            strokeWeight: 3,
                            strokeOpacity: 1
                        });   //创建折线
                        map.addOverlay(polyline);   //增加折线
                    }
                },
                error: function (json) {
                    tatongMethod.alert("错误", "服务器遇到问题");
                }
            });
        }


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
                <shiro:hasPermission name="leap:deviceMap">
                    <li><a href="javascript:void(0)" id="atab1" name="tab1" class="atab"><h4>设备地图</h4></a></li>
                </shiro:hasPermission>
                <!-- href must be unique and match the id of target div -->
                <shiro:hasPermission name="leap:trajectoryQuery">
                    <li><a href="javascript:void(0)" id="atab2" name="tab2" class="atab"><h4>历史轨迹</h4></a></li>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:manualLocate">
                    <li><a href="javascript:void(0)" id="atab3" name="tab3" class="atab"><h4>人工定位</h4></a></li>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:gpsMaintain">
                    <li><a href="javascript:void(0)" id="atab4" name="tab4" class="atab"><h4>gps维修</h4></a></li>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:gpsManagement">
                    <li><a href="javascript:void(0)" id="atab6" name="tab6" class="atab"><h4>gps管理</h4></a></li>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:signalling">
                    <li><a href="javascript:void(0)" id="atab5" name="tab5" class="atab"><h4>信令发送</h4></a></li>
                </shiro:hasPermission>
            </ul>
            <div class="clear"></div>
            <h3></h3>
        </div>
        <!-- End .content-box-header -->
        <div class="content-box-content">
            <c:if test='${tab=="tab1" }'>
                <shiro:hasPermission name="leap:deviceMap">
                    <div class="tab-content default-tab" id="tab1">
                        <a></a>

                        <form id="form1" action="<%=basePath %>driverManage/init/tab1" method="post">
                            <input type="hidden" id="tab1PageNum" name="tab1PageNum" value="0">
                            <input type="hidden" id="tab1PerPage" name="tab1PerPage" value="10">

                            <div class="search-actions">
                                <div class="search-condition">
                                    <div class="search-condition-show">
                                        <table class="seach-table">
                                            <tr>
                                                <td><label>所属公司:</label></td>
                                                <td>
                                                    <select class="easyui-combobox" name="manageCompanyId"
                                                    data-options="onSelect:loadTowerNo1,onLoadSuccess:loadTowerNo1"
                                                            style="width:200px;">
                                                        <option value="">不限</option>
                                                        <c:forEach var="manageCompany" items="${manageCompanyList}"
                                                                   varStatus="status">
                                                            <c:choose>
                                                                <c:when test="${manageCompany.id==manageCompanyId }">
                                                                    <option value="${manageCompany.id }" selected="selected">${manageCompany.shortName }</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="${manageCompany.id }">${manageCompany.shortName }</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </select>
                                                </td>
                                                <td><label>设备编号:</label></td>
                                                <td>
                                                    <select class="easyui-combobox" id="towerNo1" name="towerNo" style="width:200px;">
                                                        <option value="">不限</option>
                                                        <c:forEach var="towerNoOne" items="${towerNoList}"
                                                                   varStatus="status">
                                                            <c:choose>
                                                                <c:when test="${towerNoOne.tower_no==towerNo }">
                                                                    <option value="${towerNoOne.tower_no }"
                                                                            selected="selected">${towerNoOne.tower_no }</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="${towerNoOne.tower_no }">${towerNoOne.tower_no }</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </select>
                                                </td>
                                                <td><label>设备类型:</label></td>
                                                <td>
                                                    <select class="easyui-combobox" name="towerClass"
                                                            style="width:200px;">
                                                        <option value="">不限</option>
                                                        <option value="塔式起重机" <c:if test='${towerClass=="塔式起重机" }'>selected="selected"</c:if>>塔式起重机</option>
                                                        <option value="汽车" <c:if test='${towerClass=="汽车" }'>selected="selected"</c:if>>汽车</option>
                                                        
<%--                                                         <c:forEach var="towerClassOne" items="${towerClassList}"
                                                                   varStatus="status">
                                                            <c:choose>
                                                                <c:when test="${towerClassOne.dict_value==towerClass }">
                                                                    <option value="${towerClassOne.dict_value }"
                                                                            selected="selected">${towerClassOne.dict_value }</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="${towerClassOne.dict_value }">${towerClassOne.dict_value }</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach> --%>
                                                    </select>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td class="px4z"><label>所在区域:</label></td>
                                                <td width="200px"><select class="easyui-combobox" id="area" name="area"
                                                                          style="width:200px;">
<!--                                                     <option value="">不限</option>
                                                    <option value="华北区">华北区</option>
                                                    <option value="东北区">东北区</option>
                                                    <option value="华东区">华东区</option>
                                                    <option value="华南区">华南区</option>
                                                    <option value="西北区">西北区</option>
                                                    <option value="西南区">西南区</option> -->
                                                </select>
                                                    <script type="text/javascript">
                                                        $("#area").children().each(function () {
                                                            if ($(this).val() == "${area}") {
                                                                $("#area").val("${area}");
                                                            }
                                                        })
                                                    </script>
                                                </td>
                                                <td class="px4z"><label>所在省份:</label></td>
                                                <td><select class="easyui-combobox" id="province" name="province"
                                                            style="width:200px;">
                                                    <!-- <option value="">不限</option>
                                                    <option value="北京市">北京市</option>
                                                    <option value="上海市">上海市</option>
                                                    <option value="天津市">天津市</option>
                                                    <option value="重庆市">重庆市</option>
                                                    <option value="黑龙江省">黑龙江省</option>
                                                    <option value="辽宁省">辽宁省</option>
                                                    <option value="吉林省">吉林省</option>
                                                    <option value="河北省">河北省</option>
                                                    <option value="河南省">河南省</option>
                                                    <option value="湖北省">湖北省</option>
                                                    <option value="湖南省">湖南省</option>
                                                    <option value="山东省">山东省</option>
                                                    <option value="山西省">山西省</option>
                                                    <option value="陕西省">陕西省</option>
                                                    <option value="安徽省">安徽省</option>
                                                    <option value="浙江省">浙江省</option>
                                                    <option value="江苏省">江苏省</option>
                                                    <option value="福建省">福建省</option>
                                                    <option value="广东省">广东省</option>
                                                    <option value="海南省">海南省</option>
                                                    <option value="四川省">四川省</option>
                                                    <option value="云南省">云南省</option>
                                                    <option value="贵州省">贵州省</option>
                                                    <option value="青海省">青海省</option>
                                                    <option value="甘肃省">甘肃省</option>
                                                    <option value="江西省">江西省</option>
                                                    <option value="台湾省">台湾省</option>
                                                    <option value="内蒙古自治区">内蒙古自治区</option>
                                                    <option value="宁夏回族自治区">宁夏回族自治区</option>
                                                    <option value="新疆维吾尔自治区">新疆维吾尔自治区</option>
                                                    <option value="西藏自治区">西藏自治区</option>
                                                    <option value="广西壮族自治区">广西壮族自治区</option>
                                                    <option value="香港特别行政区">香港特别行政区</option>
                                                    <option value="澳门特别行政区">澳门特别行政区</option> -->
                                                </select>
                                                    <script type="text/javascript">
                                                        $("#province").children().each(function () {
                                                            if ($(this).val() == "${province}") {
                                                                $("#province").val("${province}");
                                                            }
                                                        })
                                                    </script>
                                                </td>
                                                <td>&nbsp;<a target="blank" href="<%=basePath %>driverManage/toallmap">查看所有塔机分布</a>
                                                </td>
                                                <td>&nbsp;</td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                                <div class="search-button"><a class="button button_position" href="javascript:void(0)"
                                                              onclick="document.getElementById('form1').submit();return false"
                                                              title="查询"><img
                                        src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a></div>

                                <div class="clear"></div>
                            </div>
                        </form>
                        <table>
                            <thead>
                            <tr>
                                <th scope="col" class="chebox">项次</th>
                                <th scope="col">塔机编号</th>
                                <th scope="col">设备类型</th>
                                <th scope="col">执行状况</th>
                                <th scope="col">所在区域</th>
                                <th scope="col">省份</th>
                                <th scope="col">所属公司</th>
                                <th scope="col">查看位置</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="tower" items="${towerList}" varStatus="status">
                                <tr>
                                    <td>
                                    <div align="center">
                                        <script type="text/javascript">
                                            var num = ${status.index+1}+tab1PageNum * tab1PerPage;
                                            document.write(num);
                                        </script>
                                        </div>
                                    </td>
                                    <td><div align="center">${tower.tower_no }</div></td>
                                    <td><div align="center">${tower.tower_class }</div></td>
                                    <td>
                                    <div align="center">
                                        <script type="text/javascript">
                                            var state = "${tower.tower_manage_state }";
                                            var stateStr = "";
                                            switch (state) {
                                                case "1":
                                                    stateStr = "闲置"
                                                    break;
                                                case "2":
                                                    stateStr = "未启用"
                                                    break;
                                                case "3":
                                                    stateStr = "在使用"
                                                    break;
                                                case "4":
                                                    stateStr = "冬停"
                                                    break;
                                                case "5":
                                                    stateStr = "托管"
                                                    break;
                                            }
                                            document.write(stateStr);
                                        </script>
                                        </div>
                                    </td>
                                    <td><div align="center">${tower.area }</div></td>
                                    <td><div align="center">${tower.province }</div></td>
                                    <td><div align="center">${tower.rightCompany}</div></td>
                                    <td><div align="center"><a target="blank"
                                           href="<%=basePath %>driverManage/map?id=${tower.id}&langitude=${tower.latitude}&latitude=${tower.longitude}&towerManagerId=${tower.towerManagerId }"><img
                                            src="<%=basePath %>static/images/icons/map-icon.png" class="earth"
                                            title="查看地图"/></a></div></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="9">
                                    <div class="bulk-actions align-left">
                                        <label>共有<b>${count}</b>条数据</label>
                                    </div>
                                    <div id="pagination1" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </shiro:hasPermission>
            </c:if>
            <!-- End #tab1 -->
            <c:if test='${tab=="tab2" }'>
                <shiro:hasPermission name="leap:trajectoryQuery">
                    <div class="tab-content" id="tab2">
                        <form id="form2" action="<%=basePath %>driverManage/init/tab2" method="post">
                            <div class="search-actions">
                                <div class="search-condition">
                                    <table class="seach-table">
                                        <tr>
                                            <td><label>所属公司:</label></td>
                                            <td>
                                                    <select class="easyui-combobox" name="manageCompanyId"  data-options="onSelect:loadTowerNo2,onLoadSuccess:loadTowerNo2"
                                                            style="width:200px;">
                                                        <option value="">不限</option>
                                                        <c:forEach var="manageCompany" items="${manageCompanyList}"
                                                                   varStatus="status">
                                                            <c:choose>
                                                                <c:when test="${manageCompany.id==manageCompanyId }">
                                                                    <option value="${manageCompany.id }" selected="selected">${manageCompany.shortName }</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="${manageCompany.id }">${manageCompany.shortName }</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </select>
                                            </td>
                                            <td><label>设备编号:</label></td>
                                            <td>
                                                <select class="easyui-combobox" name="towerNo" id="towerNo2" style="width:200px;">
                                                        <option value="">不限</option>
                                                        <c:forEach var="towerNoOne" items="${towerNoList}"
                                                                   varStatus="status">
                                                            <c:choose>
                                                                <c:when test="${towerNoOne.tower_no==towerNo }">
                                                                    <option value="${towerNoOne.tower_no }"
                                                                            selected="selected">${towerNoOne.tower_no }</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="${towerNoOne.tower_no }">${towerNoOne.tower_no }</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><label><b style="color:#FF0000;"></b>设备类型:</label></td>
                                            <td>
                                                <select class="easyui-combobox" name="towerClass"
                                                            style="width:200px;">
                                                        <option value="">不限</option>
                                                          <option value="塔式起重机" <c:if test='${towerClass=="塔式起重机" }'>selected="selected"</c:if>>塔式起重机</option>
                                                        <option value="汽车" <c:if test='${towerClass=="汽车" }'>selected="selected"</c:if>>汽车</option>
                                                        <%-- <c:forEach var="towerClassOne" items="${towerClassList}"
                                                                   varStatus="status">
                                                            <c:choose>
                                                                <c:when test="${towerClassOne.dict_value==towerClass }">
                                                                    <option value="${towerClassOne.dict_value }"
                                                                            selected="selected">${towerClassOne.dict_value }</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="${towerClassOne.dict_value }">${towerClassOne.dict_value }</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach> --%>
                                                    </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><label><b style="color:#FF0000;">*</b>起迄时间:</label></td>
                                            <td><input name="startTime" type="text" readonly="readonly"
                                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});"></td>
                                            <td><label> ~</label></td>
                                            <td><input name="endTime" type="text" readonly="readonly"
                                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});">
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="search-button">
                                    <shiro:hasPermission name="leap:trajectoryQuery:query">
                                        <a class="button button_position" href="javascript:void(0)"
                                           onclick="sendAjax()" title="查询"><img
                                                src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                                    </shiro:hasPermission>
                                </div>
                                <div class="clear"></div>
                            </div>
                            <table border="0">
                                <tr>
                                    <td><a href="javascript:void(0)" class="history">设备${towerNo }历史轨迹</a></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div id="allmap" style="height:400px;"></div>
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </div>
                </shiro:hasPermission>
                <!-- End #tab2 -->
            </c:if>
            <!-- End #tab3 -->
            <c:if test='${tab=="tab3" }'>
                <shiro:hasPermission name="leap:manualLocate">
                    <div class="tab-content " id="tab3">
                        <form id="form3" action="<%=basePath %>driverManage/init/tab3" method="post">
                            <input type="hidden" id="tab3PageNum" name="tab3PageNum" value="0">
                            <input type="hidden" id="tab3PerPage" name="tab3PerPage" value="10">

                            <div class="search-actions">
                                <div class="search-condition">
                                    <table class="seach-table">
                                        <tr>
                                            <td><label>所属公司:</label></td>
                                            <td>
                                                    <select class="easyui-combobox" name="manageCompanyId"
                                                            style="width:200px;">
                                                        <option value="">不限</option>
                                                        <c:forEach var="manageCompany" items="${manageCompanyList}"
                                                                   varStatus="status">
                                                            <c:choose>
                                                                <c:when test="${manageCompany.id==manageCompanyId }">
                                                                    <option value="${manageCompany.id }" selected="selected">${manageCompany.shortName }</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="${manageCompany.id }">${manageCompany.shortName }</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </select>
                                                <script type="text/javascript">
                                                    $("#manageCompanyId3").children().each(function () {
                                                        if ($(this).val() == "${manageCompanyId}") {
                                                            $("#manageCompanyId3").val("${manageCompanyId}");
                                                        }
                                                    })
                                                </script>
                                            </td>

                                            <td><label>回报状态:</label></td>
                                            <td><input name="abnormal" id="abnormal" value="${abnormal}">小时
                                            </td>
                                            <td><label>回报日期:</label></td>
                                            <td><input name="lastDay" value="${lastDay }" readonly="readonly"
                                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});">之前
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="search-button">
                                    <shiro:hasPermission name="leap:manualLocate:query">
                                        <a class="button button_position" href="javascript:void(0)"
                                           onclick="document.getElementById('form3').submit();return false"
                                           title="查询"><img
                                                src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="leap:manualLocate:export">
                                        <a class="button button_position"
                                           href="<%=basePath %>driverManage/getExcelRGDW"
                                           title="导出"><img src="<%=basePath %>static/images/icons/export_icon.png"
                                                           class="px18"/></a>
                                    </shiro:hasPermission>
                                </div>
                                <div class="clear"></div>
                            </div>
                        </form>
                        <table>
                            <thead>
                            <tr>
                                <th scope="col" class="chebox">项次</th>
                                <th scope="col">设备编号</th>
                                <th scope="col">设备型号</th>
                                <th scope="col">SIM卡号</th>
                                <th scope="col">设备类型</th>
                                <th scope="col">执行状况</th>
                                <th scope="col">所属公司</th>
                                <th scope="col" class="time">最后回报时间</th>
                                <th scope="col" class="time">人工定位时间</th>
                                <th scope="col" class="picture2">编辑</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="tower" items="${towerList}" varStatus="status">
                                <tr>
                                                                      <td>
                                    <div align="center">
                                        <script type="text/javascript">
                                            var num = ${status.index+1}+tab1PageNum * tab1PerPage;
                                            document.write(num);
                                        </script>
                                        </div>
                                    </td>
                                    <td><div align="center">${tower.tower_no }</div></td>
                                    <td><div align="center">${tower.tower_model }</div></td>
                                    <td><div align="center">${tower.sim_number }</div></td>
                                    <td><div align="center">${tower.tower_class}</div></td>
                                    <td>
                                    <div align="center">
                                        <script type="text/javascript">
                                            var state = "${tower.tower_manage_state }";
                                            var stateStr = "";
                                            switch (state) {
                                                case "1":
                                                    stateStr = "闲置"
                                                    break;
                                                case "2":
                                                    stateStr = "未启用"
                                                    break;
                                                case "3":
                                                    stateStr = "在使用"
                                                    break;
                                                case "4":
                                                    stateStr = "冬停"
                                                    break;
                                                case "5":
                                                    stateStr = "托管"
                                                    break;
                                            }
                                            document.write(stateStr);
                                        </script>
                                        </div>
                                    </td>
                                    <td><div align="center">${tower.rightCompany}</div></td>
                                    <td><div align="center"><fmt:formatDate value="${tower.lasttime }" pattern="yyyy/MM/dd HH:mm:ss"/></div><div align="center"></td>
                                    <td><div align="center"><fmt:formatDate value="${tower.modifytime }"
                                                        pattern="yyyy/MM/dd HH:mm:ss"/>
                                                        </div>
                                                        </td>
                                    <td>
                                        <shiro:hasPermission name="leap:manualLocate:edit">
                                            <a target="blank"
                                               href="<%=basePath %>driverManage/map?show=true&id=${tower.lasttimeid}&langitude=${tower.latitude}&latitude=${tower.longitude}&towerid=${tower.id}&towerManagerId=${tower.towerManagerId }"><img
                                                    src="<%=basePath %>static/images/icons/pencil.png" class="earth"
                                                    title="编辑"/></a>
                                        </shiro:hasPermission>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="10">
                                    <div class="bulk-actions align-left">
                                        <label>共有<b>${count}</b>条数据</label>
                                    </div>
                                    <div id="pagination3" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </shiro:hasPermission>
                <!-- End #tab4 -->
            </c:if>
            <c:if test='${tab=="tab4" }'>
                <shiro:hasPermission name="leap:gpsMaintain">
                    <div class="tab-content" id="tab4">
                        <form id="form4" action="<%=basePath %>driverManage/init/tab4" method="post">
                            <input type="hidden" id="tab4PageNum" name="tab4PageNum" value="0">
                            <input type="hidden" id="tab4PerPage" name="tab4PerPage" value="10">

                            <div class="search-actions">
                                <div class="search-condition">
                                    <table class="seach-table">
                                        <tr>
                                            <td><label>塔机编号:</label></td>
                                            <td>
                                            <select class="easyui-combobox" name="towerNo" style="width:200px;">
                                                        <option value="">不限</option>
                                                        <c:forEach var="towerNoOne" items="${towerNoList}"
                                                                   varStatus="status">
                                                            <c:choose>
                                                                <c:when test="${towerNoOne.tower_no==towerNo }">
                                                                    <option value="${towerNoOne.tower_no }"
                                                                            selected="selected">${towerNoOne.tower_no }</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="${towerNoOne.tower_no }">${towerNoOne.tower_no }</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </select>
                                            </td>
                                            <td><label>寄出时间:</label></td>
                                            <td><input name="sendTimeStart" value="${sendTimeStart }" type="text"
                                                       readonly="readonly"
                                                       onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});">~<input
                                                    name="sendTimeEnd" value="${sendTimeEnd }" type="text"
                                                    readonly="readonly"
                                                    onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});"></td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="search-button">
                                    <shiro:hasPermission name="leap:gpsMaintain:query">
                                        <a class="button button_position" href="javascript:void(0)"
                                           onclick="document.getElementById('form4').submit();return false"
                                           title="查询"><img
                                                src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="leap:gpsMaintain:add">
                                        <a class="button button_position"
                                           href="<%=basePath %>driverManage/GPS_add?tab4PageNum=${tab4PageNum}&tab4PerPage=${tab4PerPage}"
                                           title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png"
                                                           class="px18"/></a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="leap:gpsMaintain:export">
                                        <a class="button button_position"
                                           href="<%=basePath %>driverManage/exportExcelGpsWX"
                                           title="导出"><img
                                                src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a>
                                    </shiro:hasPermission>
                                </div>
                                <div class="clear"></div>
                            </div>
                        </form>
                        <table>
                            <thead>
                            <tr>
                                <th scope="col" class="chebox">项次</th>
                                <th scope="col">塔机编号</th>
                                <th scope="col">机具编号</th>
                                <th scope="col">Sim卡号</th>
                                <th scope="col">GPS运行状况</th>
                                <th scope="col">异常原因</th>
                                <th scope="col">拆除部件</th>
                                <th scope="col">返修时间</th>
                                <th scope="col">寄出时间</th>
                                <th scope="col">维修状态</th>
                                <th scope="col" class="picture2">编辑</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="maintain" items="${maintainList}" varStatus="status">
                                <tr>
                                    <td>
                                    <div align="center">
                                        <script type="text/javascript">
                                            var num = ${status.index+1}+tab4PageNum * tab4PerPage;
                                            document.write(num);
                                        </script>
                                        </div>
                                    </td>
                                    <td><div align="center">${maintain.tower_no }</div></td>
                                    <td><div align="center">${maintain.gps_no }</div></td>
                                    <td><div align="center">${maintain.sim_number }</div></td>
                                    <td><div align="center">${maintain.gps_state }</div></td>
                                    <td>
                                    <div align="center">
                                        <script type="text/javascript">
                                            var cause = ${maintain.cause };
                                            var causeStr = "";
                                            switch (cause) {
                                                case 1:
                                                    causeStr = "GPS 维修后待安装";
                                                    break;
                                                case 2:
                                                    causeStr = "GPS邮件损坏，待维修";
                                                    break;
                                                case 3:
                                                    causeStr = "GPS硬件损坏，维修中";
                                                    break;
                                                case 4:
                                                    causeStr = "GPS整机丢失";
                                                    break;
                                                case 5:
                                                    causeStr = "仓库堆放，未完成充电";
                                                    break;
                                                case 6:
                                                    causeStr = "塔机现场闲置未使用"
                                                    break;
                                                case 7:
                                                    causeStr = "需要现场查看"
                                                    break;
                                            }
                                            document.write(causeStr);
                                        </script>
                                        </div>
                                    </td>
                                    <td><div align="center">${maintain.dismantle_part }</div></td>
                                    <td><div align="center"><fmt:formatDate value="${maintain.send_time }"
                                                        pattern="yyyy-MM-dd HH:mm:ss"/>
                                                        </div>
                                                        </td>
                                    <td><div align="center"><fmt:formatDate value="${maintain.renturn_time }"
                                                        pattern="yyyy-MM-dd HH:mm:ss"/>
                                                        </div>
                                                        </td>
                                    <td><div align="center">${maintain.maintain_status}</div></td>
                                    <td>
                                        <shiro:hasPermission name="leap:gpsMaintain:edit">
                                            <a href="<%=basePath %>driverManage/GPS_edit?id=${maintain.id}&tab4PageNum=${tab4PageNum}&tab4PerPage=${tab4PerPage}"
                                               class="edit"><img src="<%=basePath %>static/images/icons/pencil.png"
                                                                 title="编辑"/></a>
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="leap:gpsMaintain:delete">
                                            <a href="javascript:void(0)"
                                          onClick="showdelete(${maintain.id},'tab4',${count })"
                                               class="delete"><img
                                                    src="<%=basePath %>static/images/icons/cross.png" title="删除"/></a>
                                        </shiro:hasPermission>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="12">
                                    <div class="bulk-actions align-left">
                                        <label>共有<b>${count}</b>条数据</label>
                                    </div>
                                    <div id="pagination4" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </shiro:hasPermission>
                <!-- End #tab5 -->
            </c:if>
            <c:if test='${tab=="tab5" }'>
                <shiro:hasPermission name="leap:signalling">
                    <div class="tab-content" id="tab5">
                        <form id="form5" action="<%=basePath %>driverManage/init/tab5" method="post">
                            <input type="hidden" id="tab5PageNum" name="tab5PageNum" value="0">
                            <input type="hidden" id="tab5PerPage" name="tab5PerPage" value="10">

                            <div class="search-actions">
                                <div class="search-condition">
                                    <table class="seach-table">
                                        <tr>
                                            <td><label>所属公司:</label></td>
                                                <td>
                                                    <select class="easyui-combobox" name="manageCompanyId"
                                                            style="width:200px;">
                                                        <option value="">不限</option>
                                                        <c:forEach var="manageCompany" items="${manageCompanyList}"
                                                                   varStatus="status">
                                                            <c:choose>
                                                                <c:when test="${manageCompany.id==manageCompanyId }">
                                                                    <option value="${manageCompany.id }" selected="selected">${manageCompany.shortName }</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="${manageCompany.id }">${manageCompany.shortName }</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </select>
                                                </td>
                                            <td><label>设备编号:</label></td>
                                            <td>
												<select class="easyui-combobox" name="towerNo" style="width:200px;">
                                                        <option value="">不限</option>
                                                        <c:forEach var="towerNoOne" items="${towerNoList}"
                                                                   varStatus="status">
                                                            <c:choose>
                                                                <c:when test="${towerNoOne.tower_no==towerNo }">
                                                                    <option value="${towerNoOne.tower_no }"
                                                                            selected="selected">${towerNoOne.tower_no }</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="${towerNoOne.tower_no }">${towerNoOne.tower_no }</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </select>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td><label>功能列表:</label></td>
                                            <td><input type="text" list="type_list" name="link"/>
                                                <datalist id="type_list">
                                                    <option label="通电" value="通电"></option>
                                                    <option label="断电" value="断电"></option>
                                                    <option label=" 更改IP地址" value=" 更改IP地址"></option>
                                                    <option label="ACC关定时发送时间" value="ACC关定时发送时间"></option>
                                                    <option label=" 汇报间隔" value=" 汇报间隔"></option>
                                                </datalist>
                                            </td>
                                            <td><label>提示:</label></td>
                                            <td><input type="text" list="type_list1" name="link"/>
                                                <datalist id="type_list1">
                                                    <option label="例:219.134.132.093,8889 地址中间不足三个字符的前面补'0'"
                                                            value="例:219.134.132.093,8889 地址中间不足三个字符的前面补'0'"></option>
                                                    <option label="请输入数字" value="请输入数字"></option>
                                                    <option label="例:调度测试信息" value="例:调度测试信息"></option>
                                                </datalist>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><label>值:</label></td>
                                            <td><input name="Input" type="text"></td>
                                            <td colspan="2">
                                                <shiro:hasPermission name="leap:signalling:send">
                                                    <a class="button button_position" href="javascript:void(0)"
                                                       title="send"><img
                                                            src="<%=basePath %>static/images/icons/send_icon.png" class="px18"/></a>
                                                </shiro:hasPermission>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="search-button">
                                    <shiro:hasPermission name="leap:signalling:query">
                                        <a class="button button_position" href="javascript:void(0)"
                                           onclick="document.getElementById('form5').submit();return false"
                                           title="查询"><img
                                                src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                                    </shiro:hasPermission>

                                </div>
                                <div class="clear"></div>
                            </div>
                        </form>

                        <table>
                            <thead>
                            <tr>
                                <th width="18px"><input class="check-all" type="checkbox"/></th>
                                <th scope="col" class="chebox">项次</th>
                                <th scope="col">设备编号</th>
                                <th scope="col">设备型号</th>
                                <th scope="col">SIM卡号</th>
                                <th scope="col">设备类型</th>
                                <th scope="col">执行状况</th>
                                <th scope="col">所属公司</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="tower" items="${towerList}" varStatus="status">
                                <tr>
                                    <td><input name="" type="checkbox" value=""></td>
                                    <td>
                                    <div align="center">
                                        <script type="text/javascript">
                                            var num = ${status.index+1}+tab5PageNum * tab5PerPage;
                                            document.write(num);
                                        </script>
                                        </div>
                                    </td>
                                    <td><div align="center">${tower.towerNo }</div></td>
                                    <td><div align="center">${tower.towerModel }</div></td>
                                    <td><div align="center">${tower.simNumber }</div></td>
                                    <td><div align="center">${tower.towerClass }</div></td>
                                    <td><div align="center">
                                        <script type="text/javascript">
                                            var state = "${tower.towerState }";
                                            var stateStr = "";
                                            
                                            switch (state) {
                                            case "1":
                                                stateStr = "闲置"
                                                break;
                                            case "2":
                                                stateStr = "未启用"
                                                break;
                                            case "3":
                                                stateStr = "在使用"
                                                break;
                                            case "4":
                                                stateStr = "冬停"
                                                break;
                                            case "5":
                                                stateStr = "托管"
                                                break;
                                        }
                                            document.write(stateStr);
                                        </script>
                                        </div>
                                    </td>
                                    <td><div align="center">${tower.rightCompanyShortName }</div></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="8">
                                    <div class="bulk-actions align-left">
                                        <label>共有<b>${count}</b>条数据</label>
                                    </div>
                                    <div id="pagination5" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </shiro:hasPermission>
                <!-- tab5end -->
            </c:if>
            <c:if test='${tab=="tab6" }'>
                <shiro:hasPermission name="leap:gpsManagement">
                    <div class="tab-content default-tab" id="tab6">
                        <form id="form6" action="<%=basePath %>driverManage/init/tab6" method="post">
                            <input type="hidden" id="tab6PageNum" name="tab6PageNum" value="0">
                            <input type="hidden" id="tab6PerPage" name="tab6PerPage" value="10">

                            <div class="search-actions">
                                <div class="search-condition">
                                    <table class="seach-table">
                                        <tr>
                                            <td><label>塔机编号:</label></td>
                                            <td>
                                            <select class="easyui-combobox" name="towerNo" style="width:200px;">
                                                        <option value="">不限</option>
                                                        <c:forEach var="towerNoOne" items="${towerNoList}"
                                                                   varStatus="status">
                                                            <c:choose>
                                                                <c:when test="${towerNoOne.tower_no==towerNo }">
                                                                    <option value="${towerNoOne.tower_no }"
                                                                            selected="selected">${towerNoOne.tower_no }</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="${towerNoOne.tower_no }">${towerNoOne.tower_no }</option>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </select>
                                            </td>
                                            <td><label>Sim卡号</label></td>
                                            <td>
                                                <select class="easyui-combobox" name="simNumber" style="width:200px;">
                                                    <option value="">不限</option>
                                                    <c:forEach var="simNumberOne" items="${simNumberList}"
                                                               varStatus="status">
                                                        <c:choose>
                                                            <c:when test="${simNumberOne.simNumber==simNumber}">
                                                                <option value="${simNumberOne.simNumber}"
                                                                        selected="selected">${simNumberOne.simNumber }</option>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <option value="${simNumberOne.simNumber }">${simNumberOne.simNumber}</option>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><label>防水盒号:</label></td>
                                            <td><input name="waterproof" type="text" value="${waterproof}"/></td>
                                            <td><label>信号:</label></td>
                                            <td>
                                                <select class="easyui-combobox" id="gps_state" name="gps_state"
                                                        style="width:200px;">
                                                    <option value="">不限</option>
                                                    <option value="正常">正常</option>
                                                    <option value="异常">异常</option>
                                                </select>
                                                <script type="text/javascript">
                                                    $("#gps_state").val("${gps_state}");
                                                </script>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="search-button">
                                    <shiro:hasPermission name="leap:gpsManagement:query">
                                        <a class="button button_position" href="javascript:void(0)"
                                           onclick="document.getElementById('form6').submit();return false" title="查询">
                                            <img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="leap:gpsManagement:add">
                                        <a class="button button_position"
                                           href="<%=basePath %>driverManage/GPSmanage_add?tab6PageNum=${tab6PageNum}&tab6PerPage=${tab6PerPage}"
                                           title="新增">
                                            <img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="leap:gpsManagement:export">
                                        <a class="button button_position" href="<%=basePath %>driverManage/exportExcelGpsGL"
                                            title="导出">
                                            <img src="<%=basePath %>static/images/icons/export_icon.png" class="px18"/></a>
                                    </shiro:hasPermission>
                                </div>
                                <div class="clear"></div>
                            </div>
                        </form>
                        <table>
                            <thead>
                            <tr>
                                <th scope="col" class="chebox">项次</th>
                                <th scope="col">防水盒号</th>
                                <th scope="col">机具编号</th>
                                <th scope="col">Sim卡号</th>
                                <th scope="col">塔机编号</th>
                                <th scope="col">定位地点</th>
                                <th scope="col">项目地点</th>
                                <th scope="col">信号</th>
                                <th scope="col">执行状况</th>

                                <th scope="col" class="picture2">功能</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="tower" items="${towerList}" varStatus="status">
                                <tr>
                                    <td>
                                    <div align="center">
                                        <script type="text/javascript">
                                            var num = ${status.index+1}+tab6PageNum * tab6PerPage;
                                            document.write(num);
                                        </script>
                                        </div>
                                    </td>
                                    <td><div align="center">${tower.waterproof }</div></td>
                                    <td><div align="center">${tower.gpsNo }</div></td>
                                    <td><div align="center">${tower.simNumber }</div></td>
                                    <td><div align="center">${tower.towerNo }</div></td>
                                    <td><div align="center">${tower.province }</div></td>
                                    <td><div align="center">${tower.pro_city }</div></td>
                                    <td><div align="center">${tower.gps_state }</div></td>
                                    <td>
                                        <div align="center">
                                            <script type="text/javascript">
                                                var state = "${tower.towerState }";
                                                var stateStr = "";
                                                switch (state) {
                                                case "1":
                                                    stateStr = "闲置"
                                                    break;
                                                case "2":
                                                    stateStr = "未启用"
                                                    break;
                                                case "3":
                                                    stateStr = "在使用"
                                                    break;
                                                case "4":
                                                    stateStr = "冬停"
                                                    break;
                                                case "5":
                                                    stateStr = "托管"
                                                    break;
                                            }
                                                document.write(stateStr);
                                            </script>
                                        </div>
                                    </td>
                                    <td>
                                        <div align="center">
                                            <shiro:hasPermission name="leap:gpsManagement:edit">
                                                <a href="<%=basePath %>driverManage/GPSmanage_edit?gpsBaseId=${tower.gpsBaseId}&tab6PageNum=${tab6PageNum}&tab6PerPage=${tab6PerPage}&tower_no=${tower.towerNo }"
                                                   class="edit"><img src="<%=basePath %>static/images/icons/pencil.png"
                                                                     title="编辑"/></a>
                                            </shiro:hasPermission>
                                            <shiro:hasPermission name="leap:gpsManagement:delete">
                                                <a href="javascript:void(0)"
                                                   onClick="showdelete('${tower.gpsBaseId }','tab6')"
                                                   class="delete"><img
                                                        src="<%=basePath %>static/images/icons/cross.png" title="删除"/></a>
                                            </shiro:hasPermission>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                                <%-- <tr>
                                  <td><div align="center">1</div></td>
                                  <td>&nbsp;</td>
                                  <td><div align="center">2013-05-27-0930</div></td>
                                  <td><div align="center">13818834301</div></td>
                                  <td><div align="center">BJTHZ081001</div></td>
                                  <td>&nbsp;</td>
                                  <td><div align="center">江东软件城</div></td>
                                  <td><div align="center">异常</div></td>
                                  <td><div align="center">返修</div></td>

                                  <td><div align="center"><a href="GPSmanage_edit.html" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" title="编辑"/></a><a href="javascript:void(0)" onClick="showdelete()" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" title="删除"/></a></div></td>
                                  </tr>
                                <tr>
                                  <td><div align="center">10</div></td>
                                  <td>&nbsp;</td>
                                  <td><div align="center">2013-05-27-0939</div></td>
                                  <td><div align="center">13818834310</div></td>
                                  <td><div align="center">BJTHZ087004</div></td>
                                  <td>&nbsp;</td>
                                  <td><div align="center">江东软件城</div></td>
                                  <td><div align="center">正常</div></td>
                                  <td><div align="center">在使用</div></td>

                                  <td><div align="center"><a href="GPSmanage_edit.html" class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" alt="修改" title="编辑"/></a><a href="javascript:void(0)" onClick="showdelete()" class="delete"><img src="<%=basePath %>static/images/icons/cross.png" alt="删除" title="删除"/></a></div></td>
                                  </tr>	 --%>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="10">
                                    <div class="bulk-actions align-left">
                                        <label>共有<b>${count}</b>条数据</label>
                                    </div>
                                    <div id="pagination6" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </shiro:hasPermission>
                <!-- tab6end -->
            </c:if>
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
