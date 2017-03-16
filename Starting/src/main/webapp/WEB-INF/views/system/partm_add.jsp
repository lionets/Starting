<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <script type="text/javascript">
        var mainPartId = 0;
        var toglepid = "";
        using(['combobox']);//加载window插件  
        using(['combobox']);//加载window插件 
        using(['window'], function () {
        });//加载window插件
        function showParts(id) {
            //filterlever3Date(id);
            var tbodyId = "levelTow" + id;
            $("#" + tbodyId).show();
            $("#" + tbodyId).siblings("tbody").hide();
        }

        function deleteParts(id) {
            var tbodyId = "levelTow" + id;
            $("#" + tbodyId).remove();
        }

        //数组中是否包含
        function iscontains(array, value) {
            var flag = false;
            for (var i = 0; i < array.length; i++) {
                if (array[i] == value) {
                    flag = true;
                }
            }
            return flag;
        }

        var level2PartListJson = $.parseJSON('${level2PartListJson}');
        var level2Options = "<option></option>";
        for (var i = 0; i < level2PartListJson.length; i++) {
            var id = level2PartListJson[i].id;
            var partName = level2PartListJson[i].part_name;
            var pid = level2PartListJson[i].pid;
            var partModel = "";
            if (JSON.stringify(level2PartListJson[i]).split(",").length != 3) {
                partModel = level2PartListJson[i].part_model==null?"":level2PartListJson[i].part_model;
            }
            level2Options += "<option value='" + id + "' pid='" + pid + "' partModel='" + partModel + "'>" + partName + "</option>";
        }
        var level3PartListJson = $.parseJSON('${level3PartListJson}');

        var level3Options = "";
        function filterlever3Date(partid) {
            level3Options = "<option></option>";
            for (var i = 0; i < level3PartListJson.length; i++) {
                if (level3PartListJson[i].pid == partid) {
                    var id = level3PartListJson[i].id;
                    var partName = level3PartListJson[i].part_name;
                    var partModel = "";
                    if (JSON.stringify(level3PartListJson[i]).split(",").length != 3) {
                        partModel = level3PartListJson[i].part_model==null?"":level3PartListJson[i].part_model;
                    }
                    var pid = level3PartListJson[i].pid;
                    level3Options += "<option value='" + id + "' pid='" + pid + "' partModel='" + partModel + "'>" + partName + "</option>";
                }
            }
        }


        function refreshIndex(trs) {
            var i = 1;
            trs.each(function () {
                $(this).children(":first").children(":first").text(i++);
            })
        }

        //左侧添加时右侧同步添加隐藏的html代码
        function dynamicHtml(id) {
            var tbodyId = "levelTow" + id;
            var temp = "<tbody id='" + tbodyId + "'  class='tbody' style='display:none'>" +
                    "<tr>" +
                    "<td><a class='button button_position addOneLevelThree'  title='新增'><img src='<%=basePath %>static/images/icons/add_icon.png' class='px18'/></a></td>" +
                    "<td colspan='6'></td>" +
                    "</tr>" +
                    "</tbody>";
            $("#partTable").append(temp);
            addOne();
        }

        function deleteOneTr() {
            //解除原来的事件
            $(".deleteOne").unbind("click");
            //删除一行
            $(".deleteOne").on("click", function (index) {
                var thisTr = $(this).parent().parent();
                var siblings = thisTr.siblings().not(":last");
                thisTr.remove();
                //更新索引
                refreshIndex(siblings);
            })
        }


        function deleteLevel2OneTr() {
            //解除原来的事件
            $(".deleteLevel2One").unbind("click");
            //删除一行
            $(".deleteLevel2One").on("click", function (index) {
                var thisTr = $(this).parent().parent();
                var siblings = thisTr.siblings().not(":last");
                var partid = thisTr.attr("partid");
                deleteParts(partid);
                thisTr.remove();
                //更新索引
                refreshIndex(siblings);
            })
        }

        function addOne() {
            //filterlever3Date(toglepid);
            //解除原来的事件
            $(".addOneLevelThree").unbind("click");
            //右侧新增按钮添加点击事件
            $(".addOneLevelThree").on("click", function () {
                var thisTr = $(this).parent().parent();
                var html = "<tr pid='' partid=''>" +
                        "<td><div align='center'>" +
                        "</div></td>" +
                        "<td width='100px;'><select class='level3Combobox easyui-datebox' style='float:left;width:120px;margin-bottom:0px;height:23px;'>" + level3Options + "</select></td>" +
                        "<td><select class='level3ModelCombobox' style='float:left;width:120px;margin-bottom:0px;height:23px;'></select></td>" +
                        "<td><div align='center'><input   name='Input' type='text' value='0' class='picture2r'/></div></td>" +
                        "<td><div align='center'></div></td>" +
                        "<td align='center'><a href='javascript:void(0)' class='deleteOne'><img src='<%=basePath %>static/images/icons/cross.png' alt='删除' title='删除'/></a></td>" +
                        "</tr>"
                thisTr.before(html);
                //更新索引
                refreshIndex(thisTr.siblings());
                //添加删除事件
                deleteOneTr();
                using(['combobox'],function(){
			    	 $(".level3Combobox").combobox({
			    		    required:true,
			    		    onSelect:function (r) {
			    		    	var text = r.text;
			    		    	var value = r.value;
			                    //根据value发送ajax请求
			                    var modelTd = $(this).parent().parent().children(":eq(2)").children();
			    		    	$(this).combobox("hidePanel");
			    		    	$(this).parent().html(text);
			    		    	  $.ajax({
			                          dataType: "JSON",
			                          type: "POST",
			                          url: "<%=basePath %>part/ajaxPartModel",
			                          data: "id=" + value,
			                          success: function (jsonStr) {
			                              var tempOption = "<option value='-1'></option>";
			                              for (var i = 0; i < jsonStr.length; i++) {
			                                  var part_model = jsonStr[i]["part_model"]==null?"":jsonStr[i]["part_model"];
			                                  var part_unit = jsonStr[i]["part_unit"];
			                                  var id = jsonStr[i]["id"];
			                                  tempOption += "<option value='" + id + "' part_unit='"+part_unit+"'>" + part_model + "</option>";
			                              }
			                              modelTd.append(tempOption);
			                              level3ModelComboboxChange();
			                          },
			                          error: function (html) {
			                              tatongMethod.alert("错误", "加载型号数据错误");
			                          }
			                      });
			                }
			    	 });
			    });  
                
                
                /*
                $(".level3Combobox").on("change", function () {
                    var text = $(this).find('option:selected').text();
                    var value = $(this).val();
                    var pid = $(this).find('option:selected').attr("pid");
                    var partModel = $(this).find('option:selected').attr("partModel");
                    //不要有重复的
                    var siblings = $(this).parent().parent().siblings().not(":last");
                    //根据value发送ajax请求
                    var modelTd = $(this).parent().parent().children(":eq(2)").children();
                    $.ajax({
                        dataType: "JSON",
                        type: "POST",
                        url: "<%=basePath %>part/ajaxPartModel",
                        data: "id=" + value,
                        success: function (jsonStr) {
                            var tempOption = "<option></option>";
                            for (var i = 0; i < jsonStr.length; i++) {
                                var part_model = jsonStr[i]["part_model"]==null?"":jsonStr[i]["part_model"];
                                var id = jsonStr[i]["id"];
                                tempOption += "<option value='" + id + "'>" + part_model + "</option>";
                            }
                            modelTd.append(tempOption);
                            level3ModelComboboxChange();
                        },
                        error: function (html) {
                            tatongMethod.alert("错误", "加载型号数据错误");
                        }
                    });

                    //设置本行的属性
                    $(this).parent().parent().attr("pid", pid);
                    $(this).parent().parent().attr("partid", value);
                    //设置型号
                    //$(this).parent().parent().find("input").first().val(partModel);
                    $(this).parent().html(text);
                })*/

            })
        }


        function level2ModelComboboxChange() {
            $(".level2ModelCombobox").on("change", function () {
                var text = $(this).children(":selected").text();
                var value = $(this).children(":selected").val();
            	var part_unit = $(this).children(":selected").attr("part_unit");
                var modelLeft = $(".modelLeft");
                var partids = [];
                var m = 0;
                for (var i = 0; i < modelLeft.length; i++) {
                    var partid = $(modelLeft[i]).attr("partModelId");
                    if (partid != null && partid != "") {
                        partids[m] = partid;
                        m++;
                    }
                }
                ;
                if (iscontains(partids, value)) {
                    tatongMethod.alert("提示", "已经存在的主部件！", function (r) {
                    });
                    $(this).val("");
                    return;
                }
                $(this).parent().parent().attr("partid", value);//这只改行的属性
               var  prevText = $(this).parent().prev().text();
               $(this).parent().next().next().children().html(part_unit);
                $(this).parent().prev().html( prevText);
                $(this).parent().html("<a href='javascript:showParts(" + value + ")' partModelId='" + value + "' class='chick_a default-tab modelLeft'>" + text + "</a>");
                dynamicHtml(value);
                showParts(value);
            })
            
        }
        function level3ModelComboboxChange() {
            $(".level3ModelCombobox").on("change", function () {
                var partModelPid = $(this).parent().parent().parent().attr("id").substring(8);
                var text = $(this).children(":selected").text();
                var value = $(this).children(":selected").val();
                var part_unit = $(this).children(":selected").attr("part_unit");
                var modelRight = $(".modelRight");
                var partids = [];
                var m = 0;
                for (var i = 0; i < modelRight.length; i++) {
                    var partid = $(modelRight[i]).attr("partModelId");
                    if (partid != null && partid != "") {
                        partids[m] = partid;
                        m++;
                    }
                }
                ;
                if (iscontains(partids, value)) {
                    if ($("[partmodelid='" + value + "']").attr("partmodelpid") == partModelPid) {
                        tatongMethod.alert("提示", "已经存在的零部件！", function (r) {
                        });
                        $(this).val("");
                        return;
                    }
                    ;
                }
                $(this).parent().next().next().children().html(part_unit);
                $(this).parent().html("<div partModelPid='" + partModelPid + "' partModelId='" + value + "' class='chick_a default-tab modelRight'>" + text + "</div>");
                dynamicHtml(value);
            })
        }


        $(function () {
            //更新数据
            filterlever3Date($("#mainPartTable").find("tr:eq(1)").attr("partid"));
            //提交表单数据
            $("#submitButton").on("click", function () {
            	var tower_model ="";
        	    using(['combobox'],function(){
                     tower_model =$("#tower_model").combobox('getValue');
                });  
                var jsonDate = {};
                jsonDate.templeteId = "${template.id }";
                jsonDate.templeteName = $("#templeteName").val();
                jsonDate.tower_model = $("[name='tower_model']").val();
                jsonDate.companyId = $("#companyid").combobox('getValue');
                jsonDate.description = $("#description").val();
                var parts = [];
                var data = $("[partmodelid]");
                for (var i = 0; i < data.length; i++) {
                    var one = {};
                    var partmodelid = $(data[i]).attr("partmodelid");
                    var partmodelpid = $(data[i]).attr("partmodelpid");
                    var num = $(data[i]).parent().parent().find("input").val();
                    if (!/^(([0-9]*[1-9][0-9]*$)|(0))$/.test(num)) {
                        tatongMethod.alert("提示", "请正确输入数字!");
                        return;
                    }
                    one.partmodelid = partmodelid;
                    one.partmodelpid = partmodelpid;
                    one.num = num;
                    parts[i] = one;
                }
                jsonDate.parts = parts;
                $("#data").val(JSON.stringify(jsonDate));
                if(tatongMethod.isChecked()){
                    //ajax请求将表单域直接序列化
                    $.ajax( {
                            dataType : "JSON",
                            type : "POST",
                            url : "<%=basePath %>part/queryTemplateByTowerModel",
                            data : "tower_model="+tower_model,
                            success : function(countJson) {
                            	if(countJson[0].count ==0){
                                    tatongMethod.confirm("提示","确定要保存吗?",function(){
                            			$("form").submit();
                            		})
                            	}else{
                               	 tatongMethod.alert("提示","该塔机型号已存在模版，请更换!");
                           		}
                            },
                            error : function(html) {
                                tatongMethod.alert("错误","服务器遇到问题");
                            }
                        })
                	
                	

                }
            })
            //左侧新增按钮添加点击事件
            $(".addOneLevelTow").on("click", function () {
                var thisTr = $(this).parent().parent();
                var html = "<tr pid='' partid=''>" +
                        "<td><div align='center'>" +
                        "</div></td>" +
                        "<td width='100'><select class='level2Combobox easyui-datebox' style='float:left;width:120px;margin-bottom:0px;height:23px;'>" + level2Options + "</select></td>" +
                        "<td ><select class='level2ModelCombobox' style='float:left;width:120px;margin-bottom:0px;height:23px;'></select></td>" +
                        "<td ><div align='center'><input name='Input' type='text' value='0' class='picture2r'></div></td>" +
                        "<td><div align='center'></div></td>" +
                        "<td align='center'><a href='javascript:void(0)' class='deleteLevel2One'><img src='/leap/static/images/icons/cross.png' alt='删除' title='删除'></a></td>" +
                        "</tr>"
                thisTr.before(html);
				    using(['combobox'],function(){
				    	 $(".level2Combobox").combobox({
				    		    required:true,
				    		    onSelect:function (r) {
				    		    	var text = r.text;
				    		    	var value = r.value;
				                    //根据value发送ajax请求
				                    var modelTd = $(this).parent().parent().children(":eq(2)").children();
				    		    	$(this).combobox("hidePanel");
				    		    	$(this).parent().html(text);
				    		    	  $.ajax({
				                          dataType: "JSON",
				                          type: "POST",
				                          url: "<%=basePath %>part/ajaxPartModel",
				                          data: "id=" + value,
				                          success: function (jsonStr) {
				                              var tempOption = "<option value='-1'></option>";
				                              for (var i = 0; i < jsonStr.length; i++) {
				                                  var part_model = jsonStr[i]["part_model"]==null?"":jsonStr[i]["part_model"];
				                                  var part_unit = jsonStr[i]["part_unit"];
				                                  var id = jsonStr[i]["id"];
				                                  tempOption += "<option value='" + id + "' part_unit='"+part_unit+"'>" + part_model + "</option>";
				                              }
				                              modelTd.append(tempOption);
				                              level2ModelComboboxChange();
				                          },
				                          error: function (html) {
				                              tatongMethod.alert("错误", "加载型号数据错误");
				                          }
				                      });
				                }
				    	 });
				    });  

                //更新索引
                refreshIndex(thisTr.siblings());
                //添加删除事件
                deleteLevel2OneTr();
                addOne();
            })
            //绑定两边的删除
            //deleteOneTr();
            deleteLevel2OneTr();
        })

    </script>
</head>
<body>
<jsp:include page="../header-bar.jsp"/>
<div id="main-content">
    <div class="clear"></div>
    <!-- End .clear -->
    <div class="content-box">
        <form method="post" action="<%=basePath %>part/insertTemplate" style="display:none">
            <input type="hidden" name="data" id="data">
        </form>
        <!-- Start Content Box -->
        <div class="content-box-header">
            <h3> 新增部件模块</h3>
        </div>
        <div class="content-box-content">
            <table border="0" class="edit-table">
                <tr>
                    <th><label><b>*</b>模块名称：</label></th>
                    <td><input type="text" id="templeteName" name="templeteName" required="true" value="${template.template_name }"/>
                    </td>
                    <th><label><b>*</b>塔机型号:</label></th>
                    <td>
                        <select name="tower_model" class="easyui-combobox" id="tower_model">
                            <c:forEach var="oneTowerModel" items="${towerModelList}" varStatus="status">
                                <c:choose>
                                    <c:when test="${oneTowerModel.dict_value==template.tower_model}">
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
                    <th><label><b>*</b>所属公司:</label></th>
                    <td>
                        <select name="companyid" class="easyui-combobox" id="companyid">
                            <c:forEach var="company" items="${companyList}" varStatus="status">
                                <c:choose>
                                    <c:when test="${company.id==template.companyId}">
                                        <option value="${company.id }"
                                                selected="selected">${company.companyShortName }</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${company.id }">${company.companyShortName }</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th scope="row">描述</th>
                    <td colspan="5"><textarea name="textarea" name="description" id="description" cols=""
                                              rows="">${template.description }</textarea></td>
                </tr>

            </table>
            <div style="width:100%">
                <div style="float:left;clear:left;overflow:auto; overflow-x:hidden;height:480px; width:600px;">
                    <p>
                        <label> <b>主要部件</b></label>
                    </p>

                    <div>
                        <div id="tab1" class="tab-content default-tab">
                            <table id="mainPartTable">
                                <thead>
                                <tr>
                                    <th width="60px;" scope="col" class="picture2"></th>
                                    <th width="160px;" scope="col">部件名称</th>
                                    <th width="160px;" scope="col">型号</th>
                                    <th width="160px;" scope="col">数量</th>
                                    <th width="39px;" scope="col">单位</th>
                                    <th width="30px;" scope="col"></th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="part" items="${part2Detail}" varStatus="status">
                                    <tr pid="${part.pid }" partid="${part.id }">
                                        <td>
                                            <div align="center">
                                                <script type="text/javascript">
                                                    var num =    ${status.index+1};
                                                    document.write(num);
                                                </script>
                                            </div>
                                        </td>
                                        <td><a href="javascript:showParts(${part.id})"
                                               class="chick_a default-tab">${part.part_name }</a></td>
                                        <td><input type="text" disabled name="part_model" value="${part.part_model}"/>
                                        </td>
                                        <td><input name="partNumber" type="text" value="${part.partNumber}"
                                                   class="picture2r"/></td>
                                        <td>&nbsp;</td>
                                        <td align="center"><a href="javascript:void(0)" class='deleteLevel2One'><img
                                                src="<%=basePath %>static/images/icons/cross.png" alt="删除" title="删除"/></a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <tr>
                                    <td><a class="button button_position addOneLevelTow" href="javascript:void(0)"
                                           title="新增"><img src="<%=basePath %>static/images/icons/add_icon.png"
                                                           class="px18"/></a></td>
                                    <td colspan="6"></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="lefttable" style="float:left; margin-left:10px;overflow:auto; overflow-x:hidden; height:40%;">
                <p>
                    <label> <b>零部件</b></label></p>
                <table id="partTable">
                    <thead>
                    <tr>
                        <th width="60px;" scope="col" class="picture2"></th>
                        <th width="60px;" scope="col">部件名称</th>
                        <th width="160px;" scope="col">型号</th>
                        <th width="160px;" scope="col">数量</th>
                        <th width="48px;" scope="col">单位</th>
                        <th width="32px;" scope="col"></th>
                    </tr>
                    </thead>
                    <c:forEach var="partTow" items="${part2Detail}" varStatus="status">

                        <script type="text/javascript">
                            var num = 1;
                        </script>
                        <tbody id="levelTow${partTow.id }" class="tbody"
                               <c:if test="${status.index!=0}">style="display:none"</c:if>>
                        <c:forEach var="partThree" items="${part3Detail}" varStatus="status">
                            <c:choose>
                                <c:when test="${partThree.pid==partTow.id}">
                                    <tr class="dataTr" pid="${partThree.pid }" partid="${partThree.id }">
                                        <td>
                                            <div align="center">
                                                <script type="text/javascript">
                                                    document.write(num++);
                                                </script>
                                            </div>
                                        </td>
                                        <td>${partThree.part_name }</td>
                                        <td><input disabled name=part_model type="text"
                                                   value="${partThree.part_model }"/></td>
                                        <td><input name="partNumber" type="text" value="${partThree.partNumber }"
                                                   class="picture2r"/></td>
                                        <td>
                                            <div align="center">${partThree.part_unit }</div>
                                        </td>
                                        <td align="center"><a href="javascript:void(0)" class='deleteOne'><img
                                                src="<%=basePath %>static/images/icons/cross.png" alt="删除" title="删除"/></a>
                                        </td>
                                    </tr>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                        <tr>
                            <td><a class="button button_position addOneLevelThree" title="新增"><img
                                    src="<%=basePath %>static/images/icons/add_icon.png" class="px18"/></a></td>
                            <td colspan="6"></td>
                        </tr>
                        </tbody>
                    </c:forEach>
                </table>
            </div>
            <table border="0" class="edit-table">
                <tr>
                    <td>&nbsp;</td>
                    <td colspan="3"><a class="button_new" href="javascript:history.go(-1)" title="返回"><img
                            src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a><a
                            class="button_new" id="submitButton" href="javascript:void(0)" title="保存"><img
                            src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a></td>
                </tr>
            </table>
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