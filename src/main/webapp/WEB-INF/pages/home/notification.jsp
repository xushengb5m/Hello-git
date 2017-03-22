<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-CPS广告联盟平台_中国最好的电子商务效果营销广告联盟</title>
<meta name="keywords" content="帮5买CPS联盟,帮5买,CPS,海淘,联盟,海淘联盟,B5M,Union,CPS Union">
<meta name="description" content="帮5买CPS联盟">
<link href="<%=basePath %>/css/thumbnail-scroller/normalize.css" rel="stylesheet">
<link href="<%=basePath %>/css/thumbnail-scroller/default.css" rel="stylesheet">
<link href="<%=basePath %>/css/thumbnail-scroller/jquery.mThumbnailScroller.css" rel="stylesheet">
<style>
.img_content {
	overflow: auto;
	position: relative;
	padding: 10px;
	background-color: #333;
	margin: 20px;
	width: 88%;
	height: auto;
	float: left;
}

.img_content li {
	margin: 4px;
	overflow: hidden;
}

.img_content li a {
	display: inline-block;
	border: 7px solid rgba(255, 255, 255, .1);
}

.img_content.light, .img_content.light .mTSButton {
	background-color: #c2beb2;
}

.img_content.light li a {
	border: 7px solid rgba(255, 255, 255, .4);
}

#img_group {
	background-color: transparent;
}

#img_group .mTSButton {
	background-color: rgba(0, 0, 0, .7);
	-moz-border-radius: 48px;
	-webkit-border-radius: 48px;
	border-radius: 48px;
}

#img_group .mTSButtonLeft {
	left: 5px;
}

#img_group .mTSButtonRight {
	right: 5px;
}

.modal-dialog {
  height: 80% !important;
  padding-top:10%;
}

.modal-content {
  height: 50% !important;
}

.modal-body {
  height: 80%;
}  

body {
  font-size: 14px;
  line-height: 1.428571429;
  color: #333333;
  background-color: #ffffff;
}

</style>
<script src="<%=basePath %>/js/thumbnail-scroller/jquery.mThumbnailScroller.js"></script>
</head>

<body class="top-navigation">

	<div id="" class="gray-bg">
	
		<c:if test="${login_user==null}">
			<div class="row border-bottom white-bg">
			<nav class="navbar navbar-static-top" role="navigation">
				<div class="navbar-header">
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
						href="<%=basePath%>/"><img alt=""
						src="<%=basePath%>/img/icon/b5m_large.png"></a>
				</div>
				<div class="navbar-collapse collapse" id="navbar">
					<ul class="nav navbar-nav">
						<!-- <li class="active">
                                <a aria-expanded="false" role="button" href="layouts.html">首页</a>
                            </li> -->
						<li class="dropdown"><a aria-expanded="false" role="button"
							href="<%=basePath%>/registration/toRegister"></a> <!-- <span id="advertising_client_or_site_master_span"></span> --></li>
					</ul>
					<ul class="nav navbar-top-links navbar-right">
						<li><button type="button" class="btn btn-outline btn-primary" onclick="toLogin();"><span id="login_homepage_span"></span></button><!-- <a data-toggle="modal"
							class="btn btn-outline btn-success"
							href="#login-form" style="margin-top: 10px;">
							<span id="login_homepage_span"></span></a> --></li>
						<li><button type="button" class="btn btn-outline btn-warning" onclick="toRegister();"><span id="register_link_homepage_span"></span></button><%-- <a class="btn btn-outline btn-success"
							href="<%=basePath%>/registration/toRegister" style="margin-top: 10px;">
							<span id="register_link_homepage_span"></span></a> --%></li>
						<li><a href="javascript:void(0);" style="margin-top: 10px;" onclick="changeLanguage();">
							<span id="language_link_version_span" style="text-decoration:underline;"></span></a></li>
					</ul>
				</div>

				<div id="login-form" class="modal fade" style="" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-body">
								<div class="row">
									<div class="col-sm-6 b-r">
										<h3 class="m-t-none m-b"><span id="login_title_span">登录</span></h3>

										<form id="login_form" role="form" action="<%=basePath%>/cpsx/login.do"
											method="post">
											<div class="form-group">
												<div class="input-group">
													<label class="input-group-addon"><span
														id="email_span"></span></label> <input type="email" name="email" id="email"
														class="form-control" placeholder="@" required>
												</div>
											</div>

											<div class="form-group">
												<div class="input-group">
													<label class="input-group-addon"><span
														id="password_span"></span></label> <input type="password" id="password"
														name="password" class="form-control"
														placeholder="" required>
												</div>
											</div>

											<div class="form-group">
												<div class="row">
													<div class="col-md-5">
														<input type="text" name="authCode" id="authCode" value=""
															class="form-control"
													 placeholder="" maxlength="4">
													</div>
													<div class="col-md-5">
														<img id="loginAuthImg"
															src="<%=basePath%>/checkCode/service.do?type=cpsx"
															onclick="changeValidateCode(this,'cpsx')" title="Refsh"
															style="cursor: hand; position: absolute; z-index: 999; height: 34px"
															class="img-responsiv" />
													</div>
												</div><span class="text-center text-danger" id="msg"><br></span>
											</div>

											<a href="javascript:void(0);" class="btn btn-success btn-block full-width m-b" onclick="submitForm();">
												<span id="login_span"></span>
											</a><!-- <span class="text-center text-danger" id="msg"></span> -->

											<p class="text-muted text-center">
												<!-- <a href="login.html"><small>忘记密码了？</small></a> | -->
												<%-- <a href="<%=basePath%>/registration/toRegister"><span
												id="register_link_span"></span></a> --%>
											</p>
										</form>
									</div>
									<div class="col-sm-6">
										<h4><span id="no_account_span">还没有账户？</span></h4>
										<p><span id="u_can_register_span">您可以注册一个账户</span></p>
										<p class="text-center">
											<a href="<%=basePath%>/registration/toRegister"><i
												class="fa fa-sign-in big-icon"></i></a>
										</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</nav>
		</div>
		</c:if>

		<div class="row">
			<div class="col-lg-1"></div>
			<div class="col-lg-1">
				<!-- <ul class="nav nav-pills nav-stacked">
					<li class="active"><a href="#">Home</a></li>
					<li><a href="#">SVN</a></li>
					<li><a href="#">iOS</a></li>
					<li><a href="#">VB.Net</a></li>
					<li><a href="#">Java</a></li>
					<li><a href="#">PHP</a></li>
				</ul> -->
			</div>
			<div class="col-lg-8">
				<div class="panel panel-info">
					<div class="panel-heading"><h1><strong>【${row.activity_name}】${row.title }${login_user.id }</strong></h1></div>
					<div class="panel-body">
						<div class=""><br>
							<ul>
								<li><h3>【活动主题】${row.title }</h3><br></li>
								<li><h3>【活动时间】<fmt:formatDate value="${row.start_date}" pattern="yyyy/MM/dd"/> - <fmt:formatDate value="${row.end_date}" pattern="yyyy/MM/dd"/></h3><br></li>
								<li><h3>【活动链接】<a href="javascript:void(0);">${row.domain }</a></h3><br></li>
								<li><h3>【活动佣金】${row.commission }</h3><br></li>
								<li><h3>【推荐理由】${row.info }</h3><br></li>
								<li><h3>欢迎广大联盟会员投放推广！</h3></li>
							</ul>
						</div>
					</div>
					<div class="panel-footer text-right"><b>b5m.com<br><fmt:formatDate value="${row.create_time}" pattern="yyyy-MM-dd"/></b></div>
				</div>
			</div>
		</div><br>
		
		<div class="row">
			<div class="col-lg-2"></div>
			<div class="row col-lg-9"><ul class="nav nav-tabs"></ul></div>
		</div>

		<div class="row">
			<div class="col-lg-2"></div>
			<div class="row col-lg-9">
				<a target="_blank" class="item" href="http://www.b5m.com/about">关于帮5买</a>
				|<a target="_blank" class="item"
					href="http://www.b5m.com/about/contact">联系我们</a> |<a
					target="_blank" class="item"
					href="http://www.b5m.com/about/quanqiugou">全球购招商</a> |<a
					target="_blank" class="item" href="http://www.b5m.com/about/links">友情链接</a>
				|<a target="_blank" class="item" href="http://job.b5m.com/">加入我们</a>
				|<a target="_blank" class="item" href="http://app.b5m.com">移动应用</a>
				|<a style="margin: 0 0 0 10px;" target="_blank" class="item"
					href="http://www.b5m.com/zixunhot.html">热门</a> |<a target="_blank"
					class="item" href="http://u.b5m.com">广告联盟</a> |<a target="_blank"
					class="item" href="http://www.b5m.com/agreement.html">使用条款</a>
			</div>
		</div>

		<div class="row">
			<div class="col-lg-2"></div>
			<div class="row col-lg-9 cneter">
				Copyright &copy; 2011-2015 B5M.COM. All rights reserved. Powered by
				B5Msoft Co.,Ltd.<br /> 增值电信业务经营许可证：沪B2-20130065号 |
				中华人民共和国互联网药品信息服务资格证书（沪）-非经营性-2013-0034 沪卫(中医)网审【2015】10032号
				沪ICP备11034776号-3 | 食品流通许可证：SP3101151410301755
				<br><br><br><br>
			</div>
		</div>

		<div class="row">
			<div class="col-lg-2"></div>
		</div>
		
	</div>

	<!-- Mainly scripts -->
	<script type="text/javascript">
	
		window.onload=function() {
			var elem = document.querySelector('.js-switch');
			var switchery = new Switchery(elem, {
				color : '#1c84c6'
			});
			
			$("#img_group").mThumbnailScroller({
				type:"click-50",
				theme:"buttons-in"
			});

			switchLanguage(language_flag);
			
			//限制字符个数
		    $(".limit_number").each(function(){
		        var maxwidth=23;
		        if($(this).text().length>maxwidth){
		            $(this).text($(this).text().substring(0,maxwidth));
		            $(this).html($(this).html()+'...');
		        }
		    });
		}

		function changeLanguage() {
			if (language_flag == 0) {
				language_flag = 1;
				switchLanguage(language_flag);
				setCookie("b5m_cpsx_zero_or_one", language_flag, 1);
				$("#language_version_span").html("English Version");
			} else {
				language_flag = 0;
				switchLanguage(language_flag);
				setCookie("b5m_cpsx_zero_or_one", language_flag, 1);
				$("#language_version_span").html("中文版");
			}
		}

		function changeValidateCode(obj, type) {
			var now = new Date().getTime();
			if (obj.src.indexOf("?") != -1) {
				if (type == "cpsx") {
					obj.src = obj.src.substr(0, obj.src.indexOf("?"))
							+ "?type=cpsx&time=" + now;
				}
			} else {
				if (type == "cpsx") {
					obj.src = obj.src + "?type=cpsx&time=" + now;
				}
			}
		}
		
		function submitForm() {
			var authCode = $("#authCode").val();
			var email = $("#email").val();
			var password = $.md5($.md5($("#password").val()) + $.md5($("#email").val()));
			$.ajax({
				url : "<%=basePath%>/cpsx/checkValidation.do",
				type : "POST",
				data : {
					authCode : authCode,
					email : email,
					password : password
				},
				success : function(data) {
	 				var msg0 = data["msg0"];
	 				var msg1 = data["msg1"];
					if(msg0 == "Success") {
						$("#password").val(password);
						$("#login_form").submit();
					} else {
						if (language_flag == 0) {
							$("#msg").html(msg0);
						} else {
							$("#msg").html(msg1);
						}
						$("#loginAuthImg").click();
						return false;
					}
				},
				error : function(xhr, type, errorThrown) {
					alert('Failure: ' + errorThrown);
				}
			});
		}
		
		function toLogin() {
			$("#login-form").modal("show");
		    document.onkeydown = function(e) {
				if ((e.keyCode || e.which) == 13) {
					$("#submit_id").click();
				}
			}
		}
		
		function toRegister() {
			window.location.href = "<%=basePath%>/registration/toRegister";
		}
	</script>

	<script src="<%=basePath %>/js/footer.js"></script>
</body>
</html>
