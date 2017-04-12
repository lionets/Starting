<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath =  path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>SuiNav</title>
<link rel="stylesheet" href="http://www.jq22.com/jquery/bootstrap-3.3.4.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>static/SuiNav20161023/css/sui.nav.css" />
<script src='http://libs.baidu.com/jquery/2.1.1/jquery.min.js'></script>
<script src="<%=basePath %>static/SuiNav20161023/js/sui.nav.min.js" type="text/javascript" charset="utf-8"></script>
		<style type="text/css">
			
			.container {
				margin: 10px auto;
			}
			
			.container .body {
				padding: 0px 10px;
				position: relative;
				padding-left: 220px;
			}
			.nav-second {
				position: relative;
				width: 210px;
				float: left;
			}
			@media only screen and (max-width: 768px) {
				.container .body {
					padding: 0px;
				}
			}
		</style>
</head>
<body>
		
		<br />
		<div class="container ">
			<div class="nav-second">
			<div id="sui_nav2" class="sui-nav">
			
			<div style="display: none;"><div id="sui_nav" class="sui-nav horizontal">
			<div class="sui-nav-wrapper nav-border nav-line">
				<ul>
					<li><a class="text-primary"><span class="glyphicon glyphicon-home"></span> Home</a></li>
					<li><a href="#"><span class="glyphicon glyphicon-comment"></span> About</a>
						<ul>
							<li><a href="#"><span class="glyphicon glyphicon-edit"></span> editor</a></li>
							<li><a href="#"><span class="glyphicon glyphicon-pencil"></span> pencil</a></li>
							<li><a href="#"><span class="glyphicon glyphicon-saved"></span> Level23</a>
								<span class="indicator">&gt;</span>
								<ul>
									<li><a href="#">Level31</a></li>
									<li><a href="#">Level32</a></li>
									<li class="hide-in-horizontal"><a href="#">Level33</a>
										<ul>
											<li><a href="#">Level331</a></li>
											<li><a href="#">Level332</a></li>
											<li><a href="#">Level333</a></li>
											<li><a href="#">Level334</a></li>
										</ul>
										<span class="indicator">&gt;</span>
									</li>
									<li><a href="#">Level34</a></li>
								</ul>
							</li>
							<li><a href="#"><span class="glyphicon glyphicon-save"></span> Level24</a></li>
						</ul>
					</li>
					<li><a class="text-danger"><span class="glyphicon glyphicon-fire"></span> Hello</a></li>
				</ul>

				<ul class="pull-right">
					<li><a class="text-success">Sign in</a></li>
					<li><a class="text-success">Sing up</a></li>
					<li><a class="text-warning">Others</a>
						<ul>
							<li><a>Right</a></li>
							<li><a>Right</a>
								<ul>
									<li><a>Right</a></li>
									<li><a>Right</a></li>
									<li><a>Right</a></li>
								</ul>
							</li>
							<li><a>Others</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div></div>
				<script type="text/javascript">
					//document.write(document.getElementById('sui_nav').innerHTML);
					var topbar;
					$(function() {
						topbar = $('#sui_nav').SuiNav({});
						var navbar = $('#sui_nav2').SuiNav({});
						$('.MenuToggle').click(function() {
							console.log("toggle");
							topbar.toggle();
						});
						$('.MenuOpen').click(function() {
							console.log("open");
							topbar.show();
						});
					});
				</script>
			</div>
			</div>
			<div class="body">
				<p>
					<button class="MenuToggle btn btn-default">单击此处显示/关闭导航</button>
					<button class="MenuOpen btn btn-success">单击此处显示导航</button>
				</p>
				<p class="alert alert-info">
					通过创建一个菜单，同步创建垂直导航、水平导航以及侧滑导航；<br />
					<code>.sui-nav</code>默认为垂直导航，为<code>.sui-nav</code>添加<code>.horizontal</code>后转为水平导航；<br />
					垂直导航、水平导航在分辨率&lt;=768px时自动隐藏，转为侧滑导航;<br />
					<code>.hide-in-horizontal</code>仅在垂直导航中显示，包括侧滑导航<br />
					<code>.show-in-horizontal</code>仅在水平导航中显示<br />
					<code>.hide-in-mobile</code>仅在&gt;768px的屏幕显示<br />
					<code>.show-in-mobile</code>仅在&lt;=768px的屏幕显示<br />
				</p>
				<p>介绍以及代码等待完善中，更多请查看源码</p>
				<pre>
&lt;script type="text/javascript"&gt;
    $('#sui_nav').SuiNav({
        toggleName: '.MenuToggle', // 控制菜单开关类
        direction: 'left', // 菜单切换方向
        trigger: 'click', // 展开方式，单击展示下层或是悬浮展示
        openingSpeed: 400, // 打开菜单动画时间
        closingSpeed: 400, // 关闭菜单动画时间
        closingCascade: true, // 级联关闭所有菜单，仅对垂直导航菜单有效
        destroy: true // 切换菜单时是否释放控件占用资源
    });
&lt;/script&gt;
&lt;div id="sui_nav" class="sui-nav horizontal">
    &lt;div class="sui-nav-wrapper nav-border nav-line">
        &lt;ul>
            &lt;li>&lt;a class="text-primary">&lt;span class="glyphicon glyphicon-home">&lt;/span> Home&lt;/a>&lt;/li>
            &lt;li>&lt;a href="#">&lt;span class="glyphicon glyphicon-comment">&lt;/span> About&lt;/a>
                &lt;ul>
                    &lt;li>&lt;a href="#">&lt;span class="glyphicon glyphicon-edit">&lt;/span> editor&lt;/a>&lt;/li>
                    &lt;li>&lt;a href="#">&lt;span class="glyphicon glyphicon-pencil">&lt;/span> pencil&lt;/a>&lt;/li>
                    &lt;li>&lt;a href="#">&lt;span class="glyphicon glyphicon-saved">&lt;/span> Level23&lt;/a>
                        &lt;span class="indicator">&gt;&lt;/span>
                        &lt;ul>
                            &lt;li>&lt;a href="#">Level31&lt;/a>&lt;/li>
                            &lt;li>&lt;a href="#">Level32&lt;/a>&lt;/li>
                            &lt;li>&lt;a href="#">Level33&lt;/a>
                                &lt;ul>
                                    &lt;li>&lt;a href="#">Level331&lt;/a>&lt;/li>
                                    &lt;li>&lt;a href="#">Level332&lt;/a>&lt;/li>
                                    &lt;li>&lt;a href="#">Level333&lt;/a>&lt;/li>
                                    &lt;li>&lt;a href="#">Level334&lt;/a>&lt;/li>
                                &lt;/ul>
                                &lt;span class="indicator">&gt;&lt;/span>
                            &lt;/li>
                            &lt;li>&lt;a href="#">Level34&lt;/a>&lt;/li>
                        &lt;/ul>
                    &lt;/li>
                    &lt;li>&lt;a href="#">&lt;span class="glyphicon glyphicon-save">&lt;/span> Level24&lt;/a>&lt;/li>
                &lt;/ul>
            &lt;/li>
            &lt;li>&lt;a class="text-danger">&lt;span class="glyphicon glyphicon-fire">&lt;/span> Hello&lt;/a>&lt;/li>
        &lt;/ul>

        &lt;ul class="pull-right">
            &lt;li>&lt;a class="text-success">Sign in&lt;/a>&lt;/li>
            &lt;li>&lt;a class="text-success">Sing up&lt;/a>&lt;/li>
            &lt;li>&lt;a class="text-warning">Others&lt;/a>
                &lt;ul>
                    &lt;li>&lt;a>Right&lt;/a>&lt;/li>
                    &lt;li>&lt;a>Right&lt;/a>
                        &lt;ul>
                            &lt;li>&lt;a>Right&lt;/a>&lt;/li>
                            &lt;li>&lt;a>Right&lt;/a>&lt;/li>
                            &lt;li>&lt;a>Right&lt;/a>&lt;/li>
                        &lt;/ul>
                    &lt;/li>
                    &lt;li>&lt;a>Others&lt;/a>&lt;/li>
                &lt;/ul>
            &lt;/li>
        &lt;/ul>
    &lt;/div>
&lt;/div>
				</pre>
			</div>
		</div>
	</body>
</html>