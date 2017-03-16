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
    <link rel="stylesheet" href="<%=basePath %>static/css/reset.css" type="text/css" media="screen" />
    <!-- Main Stylesheet -->
    <link rel="stylesheet" href="<%=basePath %>static/css/style.css" type="text/css" media="screen" />
    <!-- Invalid Stylesheet. This makes stuff look pretty. Remove it if you want the CSS completely valid -->
    <link rel="stylesheet" href="<%=basePath %>static/css/invalid.css" type="text/css" media="screen" />
    <link rel="stylesheet" href="<%=basePath %>static/css/select.css" type="text/css" media="screen" />
    <script type="text/javascript" src="<%=basePath %>static/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath %>static/js/facebox.js"></script>
    <script type="text/javascript" src="<%=basePath %>static/js/jquery.datePicker.js"></script>
    <script src="<%=basePath %>static/js/jQselect.js" type=text/javascript></script>
    <script src="<%=basePath %>static/js/jquery-easyui-1.4.1/easyloader.js" type=text/javascript></script>
    <script type="text/javascript" src="<%=basePath %>static/js/common.js"></script>
    <script type=text/javascript>
        $(document).ready(function() {
            //表单提交
            $("#submitButton").on("click",function(){
                if(tatongMethod.isChecked()){
                    tatongMethod.confirm("修改","确定要保存吗?",function(){
                        var params=[];
                        $(".oneLine").each(function(){
                            var nexts=$(this).parents('tr').find('input[type="checkbox"]:checked').not('.oneLine');
                            var ids=[];
                            nexts.each(function(){
                                ids.push($(this).val());
                            });
                            if(ids.length>0)
                                params.push(ids.join(':'));
                        });
                        if($('#tab22222').hasClass('current')){
                            $('#powerIds').val(params.join(','));
                            $('#powerIds').attr("name",'powerIds');
                        }else{
                            $('#powerIds').removeAttr("name");
                        }
                        $.ajax({
                            type: "POST",
                            url:'<%=basePath%>role/update',
                            async: true,
                            data:$('#form').serialize(),
                            error: function(request) {
                                tatongMethod.alert("系统提示",'保存失败');
                            },
                            dataType:'json',
                            success: function(data) {
                                var success = data.success;
                                if (success) {
                                        tatongMethod.confirm("系统提示",'修改成功,要返回到查询列表吗?',function(){
                                        	location.href="<%=basePath%>company/init/tab5";
                                        });
                                } else {
                                    tatongMethod.alert("系统提示",'保存失败');
                                }
                            }
                        });
                    })
                }
            })
            var powerIds="${powerIds}".split(",");
            if(powerIds.length>0){
                var dic={};
                for(var i=0;i<powerIds.length;i++){
                    dic[powerIds[i]]=1;
                }
                $('.alt-row input[type="checkbox"]').not('.oneLine').each(function(){
                    var id=$(this).val();
                    if(dic[id]==1)
                        $(this).prop('checked',true);
                });
                var cbx_checked=$('input[type="checkbox"]:checked').not('.oneLine').not("#allline");
                var cbx=$('input[type="checkbox"]').not('.oneLine').not("#allline");
                $("#allline").prop('checked',cbx_checked.length==cbx.length);
                $(".oneLine").each(function(){
                    var ids=[];
                    var tr=$(this).parents('tr');
                    var nexts_checked=tr.find('input[type="checkbox"]:checked').not('.oneLine');
                    var nexts=tr.find('input[type="checkbox"]').not('.oneLine');
                    nexts_checked.each(function(){
                        ids.push($(this).val());
                    });
                    var oneLine=tr.find('.oneLine');
                    oneLine.val(ids.join(':'));
                    oneLine.prop('checked',(nexts_checked.length==nexts.length));
                });
            }
            $(".oneLine").change(function(){
                var nexts=$(this).parents('tr').find('input[type="checkbox"]').not('.oneLine');
                var shouldChecked=$(this).prop('checked');
                nexts.prop('checked',shouldChecked);
                if(shouldChecked){
                    var ids=[];
                    nexts.each(function(){
                        ids.push($(this).val());
                    });
                    $(this).val(ids.join(':'));
                }else{
                    $(this).val(null);
                }
                $("#allline").prop('checked',$(".oneLine").length==$(".oneLine:checked").length);
            });
            $('.alt-row input[type="checkbox"]').not('.oneLine').change(function(){
                var ids=[];
                var tr=$(this).parents('tr');
                var nexts_checked=tr.find('input[type="checkbox"]:checked').not('.oneLine');
                var nexts=tr.find('input[type="checkbox"]').not('.oneLine');
                nexts_checked.each(function(){
                    ids.push($(this).val());
                });
                var oneLine=tr.find('.oneLine');
                oneLine.val(ids.join(':'));
                oneLine.prop('checked',(nexts_checked.length==nexts.length));
                var cbx_checked=$('input[type="checkbox"]:checked').not('.oneLine').not("#allline");
                var cbx=$('input[type="checkbox"]').not('.oneLine').not("#allline");
                $("#allline").prop('checked',cbx_checked.length==cbx.length);
            });
            $("#allline").change(function(){
                $(".oneLine").prop('checked',$(this).prop('checked'));
                $(".oneLine").trigger('change');
            });
        });

    </script>
</head><body>
<jsp:include page="../header-bar.jsp"/>
<div id="main-content" >
    <!-- Main Content Section with everything -->
    <div class="content-box">
        <!-- Start Content Box -->
        <div class="content-box-header">
            <h3>编辑角色信息</h3>
            <ul class="content-box-tabs" style=" float: right;">
                <li><a href="#tab1" class="default-tab"><h5>基本信息</h5></a></li>
                <!-- href must be unique and match the id of target div -->
                <li><a href="#tab2" id="tab22222"><h5>权限信息</h5></a></li>
            </ul>
            <div class="clear"></div>
        </div>
        <form id="form" action="<%=basePath %>role/update" method="post">
            <!-- End .content-box-header -->
            <div class="content-box-content" >
                <div class="tab-content default-tab" id="tab1">
                    <input type="hidden" name="tab" value="${tab}">
                    <input type="hidden" name="tab5PageNum" value="0">
                    <input type="hidden" name="tab5PerPage" value="10">
                    <input type="hidden" name="id" value="${role.id}">
                    <table border="0" class="edit-table">
                        <tr>
                            <th><label ><b>*</b>角色名称</label></th>
                            <td><input name="roleName" required="true" type="text"  value="${role.roleName }"/></td>
                            <td class="zhushi">&nbsp;</td>
                        </tr>
                        <tr>
                            <th scope="row"><label ><b>*</b>角色类型</label></th>
                            <td><input name="roleType" required="true" type="text"  value="${role.roleType }"/></td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <th scope="row">角色描述</th>
                            <td><textarea name="roleDesc" cols="" rows="" >${role.roleDesc }</textarea>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <th scope="row">备&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注</th>
                            <td><textarea name="memo" cols="" rows="" >${role.memo }</textarea>
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </div>
                <jsp:include page="role_rights.jsp"></jsp:include>
            </div>
        </form>
        <table>
            <tr>
                <td>&nbsp;</td>
                <td colspan="2">
                 <a class="button_new" href="javascript:self.location=document.referrer;" title="返回"><img src="<%=basePath %>static/images/icons/back_icon.png" class="px18"/></a>
                <a class="button_new" href="javascript:void(0)" id="submitButton" title="保存"><img src="<%=basePath %>static/images/icons/save-icon.png" class="px18"/></a> 
                </td>
            </tr>
        </table>
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