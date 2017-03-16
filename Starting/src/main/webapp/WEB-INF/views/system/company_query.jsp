<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%
    String path = request.getContextPath();
    String basePath = path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>塔机动态管理系统</title>
    <!--                       CSS                       -->
    <!-- Reset Stylesheet -->
    <!-- 分页css -->
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
    <script type="text/javascript" src="<%=basePath %>static/js/jquery.datePicker.js"></script>
    <script type="text/javascript" src="<%=basePath %>static/js/paging/jquery.pagination.js"></script>
    <SCRIPT src="<%=basePath %>static/js/jQselect.js" type=text/javascript></SCRIPT>
    <SCRIPT src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></SCRIPT>
    <script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
    <SCRIPT type=text/javascript>
        //分页点击执行的操作
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
                $("#tab6PerPage").val(tab6PerPage);
                $("#form6").submit();
            }
            if (jq.attr("id") == "pagination7") {
                $("#tab7PageNum").val(index);
                $("#tab7PerPage").val(tab7PerPage);
                $("#form7").submit();
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
                initPagination("pagination2", "${count}", 10, tab2PageNum);
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
            if (tab == "tab7") {
                initPagination("pagination7", "${count}", 10, tab7PageNum);
            }
        }

        //删除一条记录
        function showdelete(id, tab, count) {
            tatongMethod.confirm("删除", "确定要删除吗?", function () {
                var url = "<%=basePath %>company/deleteOne/" + tab + "?id=" + id;
                if (tab == "tab1") {
                    if ("${count}" % tab1PerPage == 1) {
                        tab1PageNum--;
                        if (tab1PageNum < 0) {
                            tab1PageNum = 0;
                        }
                    }
                    $("#tab1PageNum").val(tab1PageNum);
                    $("#tab1PerPage").val(tab1PerPage);
                    $("#form1").attr("action", url);
                    $("#form1").submit();
                }
                if (tab == "tab2") {
                    if ("${count}" % tab2PerPage == 1) {
                        tab2PageNum--;
                        if (tab2PageNum < 0) {
                            tab2PageNum = 0;
                        }
                    }
                    $("#tab2PageNum").val(tab2PageNum);
                    $("#tab2PerPage").val(tab2PerPage);
                    $("#form2").attr("action", url);
                    $("#form2").submit();
                }
                if (tab == "tab3") {
                    if ("${count}" % tab3PerPage == 1) {
                        tab3PageNum--;
                        if (tab3PageNum < 0) {
                            tab3PageNum = 0;
                        }
                    }
                    $("#tab3PageNum").val(tab3PageNum);
                    $("#tab3PerPage").val(tab3PerPage);
                    $("#form3").attr("action", url);
                    $("#form3").submit();
                }
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
                if (tab == "tab5") {
                    if ("${count}" % tab5PerPage == 1) {
                        tab5PageNum--;
                        if (tab5PageNum < 0) {
                            tab5PageNum = 0;
                        }
                    }
                    $("#tab5PageNum").val(tab5PageNum);
                    $("#tab5PerPage").val(tab5PerPage);
                    $("#form5").attr("action", url);
                    $("#form5").submit();
                }
                if (tab == "tab6") {
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
                if (tab == "tab7") {
                    if ("${count}" % tab7PerPage == 1) {
                        tab7PageNum--;
                        if (tab7PageNum < 0) {
                            tab7PageNum = 0;
                        }
                    }
                    $("#tab7PageNum").val(tab7PageNum);
                    $("#tab7PerPage").val(tab7PerPage);
                    $("#form7").attr("action", url);
                    $("#form7").submit();
                }
            })
        }


        //公司管理分页,传递只需要页码和每页条数即可
        var tab1PageNum = "${tab1PageNum}" == "" ? 0 : "${tab1PageNum}";
        var tab1PerPage = "${tab1PerPage}" == "" ? 10 : "${tab1PerPage}";

        //用户管理分页
        var tab2PageNum = "${tab2PageNum}" == "" ? 0 : "${tab2PageNum}";
        var tab2PerPage = "${tab2PerPage}" == "" ? 10 : "${tab2PerPage}";

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

        //公共资料分页
        var tab7PageNum = "${tab7PageNum}" == "" ? 0 : "${tab7PageNum}";
        var tab7PerPage = "${tab7PerPage}" == "" ? 10 : "${tab7PerPage}";
        //得到所属公司列表方法
        function companyListView(selectid, param) {
            var parameter = "method=selectList&sqlId=cn.com.newglobe.common.dao.read.ComCompanyInfoReadDao.selectPlist&" + param;
            $.ajax({
                dataType: "json",
                type: "POST",
                url: "<%=basePath %>ajax",
                data: parameter,
                success: function (json) {
                    var html = "<option value=''>不限</option>";
                    for (var i = 0; i < json.length; i++) {
                        html += "<option value='" + json[i].id + "'>" + json[i].companyShortName + "</option>";
                    }
                    $("#" + selectid).append(html);
                    $("#" + selectid).val("${companyid}");
                    $("#" + selectid).selectbox();
                },
                error: function (json) {
                    tatongMethod.alert("错误", "公司信息加载出错！");
                }
            });
        }
        $(document).ready(function () {

            //控制显示的面板
            var tab = "${tab}"
            //根据点击的id发送请求
            $(".atab").on("click", function () {
                var url = "<%=basePath %>company/init/" + $(this).attr("name");
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
                if ($(this).attr("name") == "tab7") {
                    url += "?tab7PageNum=" + tab7PageNum + "&tab7PerPage=" + tab7PerPage;
                }
                location.href = url;
            })
            togle(tab);

            $("#dutyid1").selectbox();
            $("#dutyid2").selectbox();
            $("#dutyid3").selectbox();

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
                <shiro:hasPermission name="leap:companyManagement">
                    <li><a href="#tab1" id="atab1" name="tab1" class="atab"><h4>公司管理</h4></a></li>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:departmentManagement">
                    <li><a href="#tab7" id="atab7" name="tab7" class="atab"><h4>部门管理</h4></a></li>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:userManagement">
                    <li><a href="#tab2" id="atab2" name="tab2" class="atab"><h4>用户管理</h4></a></li>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:partsModule">
                    <li><a href="#tab3" id="atab3" name="tab3" class="atab"><h4>职务管理</h4></a></li>
                </shiro:hasPermission>
                <shiro:hasPermission name="leap:roleManagement">
                    <li><a href="#tab5" id="atab5" name="tab5" class="atab"><h4>角色管理</h4></a></li>
                </shiro:hasPermission>
                <!-- <li> <a href="#tab4" id="atab4" name="tab4"  class="atab"> <h4>公共资料</h4></a></li> -->
                <!--          <li> <a href="#tab6" id="atab6" name="tab6"  class="atab"> <h4>权限管理</h4></a></li> -->
            </ul>

            <div class="clear"></div>
            <h3></h3>
        </div>
        <!-- End .content-box-header -->
        <div class="content-box-content">
            <c:if test='${tab=="tab1" }'>
                <shiro:hasPermission name="leap:companyManagement">
                    <div class="tab-content" id="tab1">
                        <form id="form1" action="<%=basePath %>company/init/tab1" method="post">
                            <div class="search-actions">
                                <div class="search-condition">
                                    <table class="seach-table">
                                        <tr>
                                            <td><label>公司简称:</label></td>
                                            <td><input name="shortName" type="text" value="${shortName }">&nbsp;</td>
                                            <input type="hidden" id="tab1PageNum" name="tab1PageNum" value="0">
                                            <input type="hidden" id="tab1PerPage" name="tab1PerPage" value="10">
                                        </tr>
                                    </table>
                                </div>
                                <div class="search-button">
                                    <shiro:hasPermission name="leap:companyManagement:query">
                                        <a class="button button_position"
                                           onclick="document.getElementById('form1').submit();return false"
                                           href="javascript:void(0)" title="查询"><img
                                                src="<%=basePath %>static/images/icons/search_icon.png"
                                                class="px18"/></a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="leap:companyManagement:query">
                                        <a class="button button_position"
                                           href="<%=basePath %>company/addInit?tab=tab1&tab1PageNum=${tab1PageNum}&tab1PerPage=${tab1PerPage}"
                                           title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png"
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
                                <th scope="col">公司简称</th>
                                <th scope="col">公司中文名</th>
                                <th scope="col">公司英文名</th>
                                <th scope="col">上级公司</th>
                                <th scope="col" class="picture2">编辑</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="company" items="${companyList}" varStatus="status">
                                <tr>
                                    <td>
                                        <script type="text/javascript">
                                            var num = ${status.index+1}+tab1PageNum * tab1PerPage;
                                            document.write(num);
                                        </script>
                                    </td>
                                    <td>${company.shortName}</td>
                                    <td>${company.companyName}</td>
                                    <td>${company.engName}</td>
                                    <td>${company.pCompaneName}</td>
                                    <td>
                                        <shiro:hasPermission name="leap:companyManagement:edit">
                                            <a href="<%=basePath %>company/editFind?tab=tab1&id=${company.id}&tab1PageNum=${tab1PageNum}&tab1PerPage=${tab1PerPage}"
                                               class="edit"><img src="<%=basePath %>static/images/icons/pencil.png"
                                                                 title="编辑"/></a>
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="leap:companyManagement:delete">
                                            <a onclick="showdelete(${company.id},'tab1',${count})" class="delete"><img
                                                    src="<%=basePath %>static/images/icons/cross.png" title="删除"/></a>
                                        </shiro:hasPermission>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="6">
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
                <!-- End #tab1 -->
            </c:if>
            <c:if test='${tab=="tab2" }'>
                <shiro:hasPermission name="leap:userManagement">
                    <div class="tab-content" id="tab2">
                        <form id="form2" action="<%=basePath %>company/init/tab2" method="post">
                            <input type="hidden" id="tab2PageNum" name="tab2PageNum" value="0">
                            <input type="hidden" id="tab2PerPage" name="tab2PerPage" value="10">

                            <div class="search-actions">
                                <div class="search-condition">
                                    <table class="seach-table">
                                        <tr>
<%--                                             <td><label>所属公司:</label></td>
                                            <td>
                                                <select name="companyid" id="companyid" value="${companyid }">
                                                </select>
                                            </td> --%>
                                            <td><label>登录名:</label></td>
                                            <td><input name="accountName" type="text" value="${accountName }"></td>
                                            <td><label>用户名:</label></td>
                                            <td><input name="realName" type="realName" value="${realName }"></td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="search-button">
                                    <shiro:hasPermission name="leap:userManagement:query">
                                        <a class="button button_position"
                                           onclick="document.getElementById('form2').submit();return false"
                                           href="javascript:void(0)" title="查询"><img
                                                src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="leap:userManagement:add">
                                        <a class="button button_position"
                                           href="<%=basePath %>users/addInit?tab=tab2&tab2PageNum=${tab2PageNum}&tab2PerPage=${tab2PerPage}"
                                           title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a>
                                    </shiro:hasPermission>
                                </div>
                                <div class="clear"></div>
                            </div>
                        </form>
                        <table>
                            <thead>
                            <tr>
                                <th scope="col" class="chebox">项次</th>
                                <th scope="col">登录名</th>
                                <th scope="col">用户名</th>
                                <th scope="col">电话</th>
                                <th scope="col">手机</th>
                                <th scope="col">地址</th>
                                <th scope="col">身份证号</th>
                                <th scope="col" class="picture2" style="width:80px;">编辑</th>
                            </tr>
                            </thead>
                            <tbody>

                            <c:forEach var="user" items="${userList}" varStatus="status">
                                <tr>
                                    <td>
                                        <script type="text/javascript">
                                            var num = ${status.index+1}+tab2PageNum * tab2PerPage;
                                            document.write(num);
                                        </script>
                                    </td>
                                    <td>${user.accountName }</td>
                                    <td>${user.realName }</td>
                                    <td>${user.telphone }</td>
                                    <td>${user.phone }</td>
                                    <td>${user.address }</td>
                                    <td>${user.cardnum }</td>
                                    <td>
                                        <shiro:hasPermission name="leap:userManagement:detail">
                                            <a href="<%=basePath %>users/view?tab=tab2&id=${user.id}&tab2PageNum=${tab2PageNum}&tab2PerPage=${tab2PerPage}"
                                               class="edit"><img src="<%=basePath %>static/images/icons/view.png"
                                                                 title="查看"/></a>
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="leap:userManagement:edit">
                                            <a href="<%=basePath %>users/editFind?tab=tab2&id=${user.id}&tab2PageNum=${tab2PageNum}&tab2PerPage=${tab2PerPage}"
                                               class="edit"><img src="<%=basePath %>static/images/icons/pencil.png"
                                                                 title="编辑"/></a>
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="leap:userManagement:delete">
                                            <a href="javascript:void(0)"     onClick="showdelete(${user.id},'tab2',${count})"
                                               class="delete"><img
                                                    src="<%=basePath %>static/images/icons/cross.png" title="删除"/></a>
                                        </shiro:hasPermission>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>

                            <tfoot>
                            <tr>
                                <td colspan="9">
                                    <div class="bulk-actions align-left">
                                        <label>共有<b>${count}</b>条数据</label>
                                    </div>
                                    <div id="pagination2" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </shiro:hasPermission>
                <!-- End #tab2 -->
            </c:if>
            <c:if test='${tab=="tab3" }'>
                <shiro:hasPermission name="leap:dutyManagement">
                    <div class="tab-content" id="tab3">
                        <form id="form3" action="<%=basePath %>company/init/tab3" method="post">
                            <input type="hidden" id="tab3PageNum" name="tab3PageNum" value="0">
                            <input type="hidden" id="tab3PerPage" name="tab3PerPage" value="10">

                            <div class="search-actions">
                                <div class="search-condition">
                                    <table class="seach-table">
                                        <tr>
                                            <td><label>职务名称:</label></td>
                                            <td><input name="dutyName" type="text" value="${dutyName }">&nbsp;</td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="search-button">
                                    <shiro:hasPermission name="leap:dutyManagement:query">
                                        <a class="button button_position"
                                           onclick="document.getElementById('form3').submit();return false"
                                           href="javascript:void(0)" title="查询"><img
                                                src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="leap:dutyManagement:add">
                                        <a class="button button_position"
                                           href="<%=basePath %>past/addInit?tab=tab3&tab3PageNum=${tab3PageNum}&tab3PerPage=${tab3PerPage}"
                                           title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a>
                                    </shiro:hasPermission>
                                </div>
                                <div class="clear"></div>
                            </div>
                        </form>
                        <table>
                            <thead>
                            <tr>
                                <th scope="col" class="chebox">项次</th>
                                <th scope="col" class="address">职务名称</th>
                                <th scope="col" class="address">职务代码</th>
                                <!-- <th scope="col" class="address">职务类别</th> -->
                                <th scope="col">备注</th>
                                <th scope="col" class="picture2">编辑</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="duty" items="${dutyList}" varStatus="status">
                                <tr>
                                    <td>
                                        <script type="text/javascript">
                                            var num = ${status.index+1}+tab3PageNum * tab3PerPage;
                                            document.write(num);
                                        </script>
                                    </td>
                                    <td>${duty.dutyName }</td>
                                    <td>${duty.dutyCode }</td>
                                    <%-- <td>${duty.dutyType }</td> --%>
                                    <td>${duty.memo}</td>
                                    <td>
                                        <shiro:hasPermission name="leap:dutyManagement:edit">
                                            <a href="<%=basePath %>past/editFind?tab=tab3&id=${duty.id}&tab3PageNum=${tab3PageNum}&tab3PerPage=${tab3PerPage}"
                                               class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" title="编辑"/></a>
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="leap:dutyManagement:delete">
                                            <a href="javascript:void(0)" onClick="showdelete(${duty.id},'tab3',${count})"
                                               class="delete"><img src="<%=basePath %>static/images/icons/cross.png"
                                                                   title="删除"/></a>
                                        </shiro:hasPermission>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="5">
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
            </c:if>
            <c:if test='${tab=="tab4" }'>
                <shiro:hasPermission name="leap:publicData">
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
                                                <select name="czid" id="dutyid1">
                                                    <option value="0">不限</option>
                                                    <option
                                                            <c:if test="${czid==-1 }">selected="selected"</c:if> value="-1">
                                                        （词组类别）
                                                    </option>
                                                    <c:forEach var="cz" items="${czlist}" varStatus="status">
                                                        <option
                                                                <c:if test="${czid==cz.id }">selected="selected"</c:if>
                                                                value="${cz.id }">${cz.dictValue }</option>
                                                    </c:forEach>


                                                    <!-- <option value="资产名称">资产名称</option>
                                                    <option value="标准节">标准节</option> -->
                                                    <!-- <script type="text/javascript">
						$("#dutyid").val("${wordClass }");
					</script> -->
                                                </select>
                                            </td>
                                            <td><label>词组名称:</label></td>
                                            <td><input name="czval" type="text" value="${czval }">&nbsp;</td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="search-button">
                                    <shiro:hasPermission name="leap:publicData:query">
                                        <a class="button button_position"
                                           onclick="document.getElementById('form4').submit();return false"
                                           href="javascript:void(0)" title="查询"><img
                                                src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="leap:publicData:add">
                                        <a   class="button button_position"
                                             href="<%=basePath %>common/addInit?tab=tab4&tab4PageNum=${tab4PageNum}&tab4PerPage=${tab4PerPage}"
                                             title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a>
                                    </shiro:hasPermission>
                                </div>
                                <div class="clear"></div>
                            </div>
                        </form>
                        <table>
                            <thead>
                            <tr>
                                <th scope="col" class="chebox">项次</th>
                                <th scope="col">词组类别</th>
                                <th scope="col">词组中文名称</th>
                                <th scope="col">词组繁体中文名称</th>
                                <th scope="col">词组英文名称</th>
                                <th scope="col">最后修改时间</th>
                                <th scope="col" class="time">最后修改人</th>
                                <th scope="col" class="time">描述</th>
                                <th scope="col" class="picture2">编辑</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="publicInfo" items="${publicInfoList}" varStatus="status">
                                <tr>
                                    <td>
                                        <script type="text/javascript">
                                            var num = ${status.index+1}+tab4PageNum * tab4PerPage;
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
                                    <td><fmt:formatDate value="${publicInfo.dictUpdateTime}"
                                                        pattern="yyyy年MM月dd日 HH:mm:ss"/></td>
                                    <td>${publicInfo.dictUserName }</td>
                                    <td>${publicInfo.dictMemo }</td>
                                    <td>
                                        <shiro:hasPermission name="leap:publicData:edit">
                                            <a href="<%=basePath %>common/editFind?tab=tab4&id=${publicInfo.id}&tab4PageNum=${tab4PageNum}&tab4PerPage=${tab4PerPage}"
                                               class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" title="编辑"/></a>
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="leap:publicData:delete">
                                            <a  href="javascript:void(0)" onClick="showdelete(${publicInfo.id},'tab4',${count})"
                                                class="delete"><img src="<%=basePath %>static/images/icons/cross.png"
                                                                    title="删除"/></a>
                                        </shiro:hasPermission>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="8">
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
                <!-- End #tab4 -->
            </c:if>
            <c:if test='${tab=="tab5" }'>
                <shiro:hasPermission name="leap:roleManagement">
                    <!-- tab5部分 -->
                    <div class="tab-content" id="tab5">
                        <form id="form5" action="<%=basePath %>company/init/tab5" method="post">
                            <input type="hidden" id="tab5PageNum" name="tab5PageNum" value="0">
                            <input type="hidden" id="tab5PerPage" name="tab5PerPage" value="10">

                            <div class="search-actions">
                                <div class="search-condition">
                                    <table class="seach-table">
                                        <tr>
                                            <td><label>角色名称:</label></td>
                                            <td><input name="roleName" type="text" value="${roleName}">&nbsp;</td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="search-button">
                                    <shiro:hasPermission name="leap:roleManagement:query">
                                        <a class="button button_position"
                                           onclick="document.getElementById('form5').submit();return false"
                                           href="javascript:void(0)" title="查询"><img
                                                src="<%=basePath %>static/images/icons/search_icon.png"
                                                class="px18"/></a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="leap:roleManagement:add">
                                        <a class="button button_position"
                                           href="<%=basePath %>role/addInit?tab=tab5&tab5PageNum=${tab5PageNum}&tab5PerPage=${tab5PerPage}"
                                           title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png"
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
                                <th scope="col">角色名称</th>
                                <th scope="col">角色类型</th>
                                <th scope="col">角色描述</th>
                                <th scope="col" class="time">创建日期</th>
                                <th scope="col">备注信息</th>
                                <th scope="col" class="picture2">编辑</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="role" items="${roleList}" varStatus="status">
                                <tr>
                                    <td>
                                        <script type="text/javascript">
                                            var num = ${status.index+1}+tab5PageNum * tab5PerPage;
                                            document.write(num);
                                        </script>
                                    </td>
                                    <td>${role.role_name }</td>
                                    <td>${role.role_type }</td>
                                    <td>${role.role_desc }</td>
                                    <td><fmt:formatDate value="${role.create_date}" pattern="yyyy年MM月dd日"/></td>
                                    <td>${role.memo }</td>
                                    <td>
                                        <shiro:hasPermission name="leap:roleManagement:edit">
                                            <a href="<%=basePath %>role/editFind?tab=tab5&id=${role.id}&tab5PageNum=${tab5PageNum}&tab5PerPage=${tab5PerPage}"
                                               class="edit"><img src="<%=basePath %>static/images/icons/pencil.png"
                                                                 title="编辑"/></a>
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="leap:roleManagement:delete">
                                            <a href="javascript:void(0)"
                                               onClick="showdelete(${role.id},'tab5',${count})" class="delete"><img
                                                    src="<%=basePath %>static/images/icons/cross.png" title="删除"/></a>
                                        </shiro:hasPermission>
                                    </td>
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
            </c:if>
            <c:if test='${tab=="tab6" }'>
                <!-- tab6部分 -->
                <div class="tab-content" id="tab6">
                    <form id="form6" action="<%=basePath %>company/init/tab6" method="post">
                        <input type="hidden" id="tab6PageNum" name="tab6PageNum" value="0">
                        <input type="hidden" id="tab6PerPage" name="tab6PerPage" value="10">

                        <div class="search-actions">
                            <div class="search-condition">
                                <table class="seach-table">
                                    <tr>
                                        <td><label>权限名称:</label></td>
                                        <td><input name="powerName" type="text" value="${powerName }">&nbsp;</td>
                                    </tr>
                                </table>
                            </div>
                            <div class="search-button"><a class="button button_position"
                                                          onclick="document.getElementById('form6').submit();return false"
                                                          href="javascript:void(0)" title="查询"><img
                                    src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/></a> <a
                                    class="button button_position"
                                    href="<%=basePath %>power/addInit?tab=tab6&tab6PageNum=${tab6PageNum}&tab6PerPage=${tab6PerPage}"
                                    title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </form>
                    <table>
                        <thead>
                        <tr>
                            <th scope="col" class="chebox">项次</th>
                            <th scope="col">权限名称</th>
                            <th scope="col">权限类型</th>
                            <th scope="col">权限所属</th>
                            <th scope="col">权限url</th>
                            <th scope="col" class="time">备注</th>
                            <th scope="col" class="picture2">编辑</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="power" items="${powerList}" varStatus="status">
                            <tr>
                                <td>
                                    <script type="text/javascript">
                                        var num = ${status.index+1}+tab6PageNum * tab6PerPage;
                                        document.write(num);
                                    </script>
                                </td>
                                <td>${power.powerName }</td>
                                <td>${power.powerType }</td>
                                <td>${power.powerOwn }</td>
                                <td>${power.powerUrl }</td>
                                <td>${power.memo }</td>
                                <td>
                                    <a href="<%=basePath %>power/editFind?tab=tab6&id=${power.id}&tab6PageNum=${tab6PageNum}&tab6PerPage=${tab6PerPage}"
                                       class="edit"><img src="<%=basePath %>static/images/icons/pencil.png" title="编辑"/></a><a
                                        href="javascript:void(0)" onClick="showdelete(${power.id},'tab6',${count})"
                                        class="delete"><img src="<%=basePath %>static/images/icons/cross.png"
                                                            title="删除"/></a></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                        <tfoot>
                        <tr>
                            <td colspan="8">
                                <div class="bulk-actions align-left">
                                    <label>共有<b>${count}</b>条数据</label>
                                </div>
                                <div id="pagination6" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                            </td>
                        </tr>
                        </tfoot>
                    </table>
                </div>
                <!-- tab6end -->
            </c:if>
            <c:if test='${tab=="tab7" }'>
                <shiro:hasPermission name="leap:departmentManagement">
                    <div class="tab-content" id="tab7">
                        <form id="form7" action="<%=basePath %>company/init/tab7" method="post">
                            <input type="hidden" id="tab7PageNum" name="tab7PageNum" value="0">
                            <input type="hidden" id="tab7PerPage" name="tab7PerPage" value="10">

                            <div class="search-actions">
                                <div class="search-condition">
                                    <table class="seach-table">
                                        <tr>
                                            <td><label>部门名称:</label></td>
                                            <td><input name="department_name" value="${department_name}" type="text">&nbsp;
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="search-button">
                                    <shiro:hasPermission name="leap:departmentManagement:query">
                                        <a class="button button_position"
                                           onclick="document.getElementById('form7').submit();return false"
                                           href="javascript:void(0)" title="查询">
                                            <img src="<%=basePath %>static/images/icons/search_icon.png" class="px18"/>
                                        </a>
                                    </shiro:hasPermission>
                                    <shiro:hasPermission name="leap:departmentManagement:add">
                                        <a class="button button_position"
                                           href="<%=basePath %>company/department_add?tab=tab7&tab7PageNum=${tab7PageNum}&tab7PerPage=${tab7PerPage}"
                                           title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png"
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
                                <th scope="col">部门名称</th>
                                <th scope="col">部门代码</th>
                                <th scope="col">上级部门</th>
                                <th scope="col">所属公司</th>

                                <th scope="col" class="picture2">功能</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="department" items="${depts}" varStatus="status">
                                <tr>
                                    <td>
                                        <script type="text/javascript">
                                            var num = ${status.index+1}+tab7PageNum * tab7PerPage;
                                            document.write(num);
                                        </script>
                                    </td>
                                    <td>${department.department_name }</td>
                                    <td>${department.department_code }</td>
                                    <td>${department.Pdepartment_name }</td>
                                    <td>${department.company_name }</td>
                                    <td>
                                        <shiro:hasPermission name="leap:departmentManagement:edit">
                                            <a href="<%=basePath %>company/department_edit?id=${department.id }&tab=tab7&tab7PageNum=${tab7PageNum}&tab7PerPage=${tab7PerPage}"
                                               class="edit"><img src="<%=basePath %>static/images/icons/pencil.png"
                                                                 title="编辑"/></a>
                                        </shiro:hasPermission>
                                        <shiro:hasPermission name="leap:departmentManagement:delete">
                                            <a href="javascript:void(0)"
                                               onClick="showdelete(${department.id},'tab7',${count})"
                                               class="delete"><img
                                                    src="<%=basePath %>static/images/icons/cross.png" title="删除"/></a>
                                        </shiro:hasPermission>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="6">
                                    <div class="bulk-actions align-left">
                                        <label>共有<b>${count}</b>条数据</label>
                                    </div>
                                    <div id="pagination7" class="pagination" style="float: right"><!-- 这里显示分页 --></div>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </shiro:hasPermission>
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