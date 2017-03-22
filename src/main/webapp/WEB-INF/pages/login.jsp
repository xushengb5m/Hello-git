<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../pages/common.jsp"%>

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
  padding-top:13%;
}

/* .modal-content {
  height: 50% !important;
}

.modal-body {
  height: 80%;
}  
 */
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

											<a id="submit_id" href="javascript:void(0);" class="btn btn-success btn-block full-width m-b" onclick="submitForm();">
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

		<div id="myCarousel" class="carousel slide">
			<!-- 轮播（Carousel）指标 -->
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>
			<!-- 轮播（Carousel）项目 -->
			<div class="carousel-inner">
				<div class="item active center">
					<a href="http://banx.b5m.com/c.do?code=DhKe0wi&mid=5773398345ce224a01964e54&sid=&aid=223&adp=5&uid=7095df6c3264438ba618727ee5c77581&adl=2&tty=ty1" target="_blank"> <img alt="First Slide" height="350" width="1920" 
						src="<%=basePath%>/img/banner/test1.jpg" style="display: inline;">
					</a>
				</div>
				<div class="item center">
					<a href="http://banx.b5m.com/c.do?code=CVUHIJC&mid=5773398345ce224a01964e54&sid=&aid=221&adp=5&uid=7095df6c3264438ba618727ee5c77581&adl=3&tty=ty1" target="_blank"> <img alt="Second Slide" height="350" width="1920"
						src="<%=basePath%>/img/banner/test2.jpg" style="display: inline;">
					</a>
				</div>
				<div class="item center">
					<a href="http://banx.b5m.com/c.do?code=DOuxpzp&mid=5773398345ce224a01964e54&sid=&aid=226&adp=5&uid=7095df6c3264438ba618727ee5c77581&adl=1&tty=ty1" target="_blank"> <img alt="Third Slide" height="350" width="1920"
						src="<%=basePath%>/img/banner/test3.jpg" style="display: inline;">
					</a>
				</div>
			</div>
			<!-- 轮播（Carousel）导航 -->
			<!-- <a class="carousel-control left" href="#myCarousel"
					data-slide="prev">&lsaquo;</a> <a class="carousel-control right"
					href="#myCarousel" data-slide="next">&rsaquo;</a> -->
		</div>

		<div class="row" style="margin-top: 50px;">
		
			<div class="col-lg-2">
			</div>
			
			<div class="row  col-lg-9">
				<div class="col-md-4">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h2>
								<strong>联盟公告</strong><small></small>
							</h2>
						</div>
						<div class="panel-body">
							<c:forEach var="notice" items="${requestScope.notices}">
							<div align="left">
								<a class="limit_number" href="<%=basePath%>/banx/home/notification/${notice.id}" target="_blank">【${notice.activity_name}】 ${notice.title }</a>
							</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h2>
								<strong>商家奖励</strong><small></small>
							</h2>
						</div>
						<div class="panel-body">
							<c:forEach var="reward" items="${requestScope.rewards}">
							<div align="left">
								<a class="limit_number" href="<%=basePath%>/banx/home/notification/${reward.id}" target="_blank">【${reward.activity_name}】 ${reward.title }</a>
							</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h2>
								<strong>商家促销</strong><small></small>
							</h2>
						</div>
						<div class="panel-body">
							<c:forEach var="sale" items="${requestScope.sales}">
							<div align="left">
								<a class="limit_number" href="<%=basePath%>/banx/home/notification/${sale.id}" target="_blank">【${sale.activity_name}】 ${sale.title }</a>
							</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-1"></div>
		</div>

		<%-- <div class="row">
			<div class="col-lg-2"></div>
			<div class="row col-lg-9">
				<div class="col-md-12">
					<div class="page-header">
						<h1>
							<strong>商家优惠活动</strong><small></small>
						</h1>
						<div>
							<div id="img_group" class="img_content">
								<ul id="#mTS_1_container">
									<li><a href="#"> <img alt="Second Slide" width="275"
											height="225" src="<%=basePath%>/img/banner/t1.jpg"
											style="display: inline;"></a></li>
									<li><a href="#"> <img alt="Second Slide" width="275"
											height="225" src="<%=basePath%>/img/banner/t2.jpg"
											style="display: inline;"></a></li>
									<li><a href="#"> <img alt="Second Slide" width="275"
											height="225" src="<%=basePath%>/img/banner/t3.jpg"
											style="display: inline;"></a></li>
									<li><a href="#"> <img alt="Second Slide" width="275"
											height="225" src="<%=basePath%>/img/banner/t4.jpg"
											style="display: inline;"></a></li>
									<li><a href="#"> <img alt="Second Slide" width="275"
											height="225" src="<%=basePath%>/img/banner/t5.jpg"
											style="display: inline;"></a></li>
									<li><a href="#"> <img alt="Second Slide" width="275"
											height="225" src="<%=basePath%>/img/banner/t6.jpg"
											style="display: inline;"></a></li>
									<li><a href="#"> <img alt="Second Slide" width="275"
											height="225" src="<%=basePath%>/img/banner/t7.jpg"
											style="display: inline;"></a></li>
									<li><a href="#"> <img alt="Second Slide" width="275"
											height="225" src="<%=basePath%>/img/banner/t8.jpg"
											style="display: inline;"></a></li>
								</ul>
							</div>
						</div>
					</div>

				</div>
			</div>
			<div class="col-lg-1"></div>
		</div> --%>

		<div class="row">
			<div class="col-lg-2"></div>
			<div class="row col-lg-9">
				<div class="panel-options">
					<ul class="nav nav-tabs">
						<li class=""><a data-toggle="tab" class="btn btn-outline btn-primary btn-lg" href="#tab-1"><strong>广告主</strong></a></li>
						<!-- <li class=""><a data-toggle="tab" href="#tab-2"><strong>最新广告主</strong></a></li> -->
					</ul>
				</div>
				
				<div class="panel-body">

						<div class="tab-content">
							<div id="tab-1" class="tab-pane active">
								<!-- <div class="col-lg-1"><strong><i class="fa fa-buysellads"></i></strong></div>
								<div class="col-lg-11"><strong>1萨芬撒法</strong></div> -->
								<div class="row">
								<c:forEach var="advertiser" items="${requestScope.advertisers}">
									<div class="col-lg-3 col-md-4 col-sm-6">
									<div class="panel panel-default">
										<div class="panel-heading">
												<p>
													<c:if test="${login_user==null}">
														<img src="${advertiser.image}" width="120" height="60">
													</c:if>
													<c:if test="${login_user!=null}">
														<img src="${advertiser.image}" width="120" height="60">
														<%-- <a
															href="<%=basePath%>/earner/act/activity/${row.id}/${web.id}"><img
															src="${advertiser.image}" width="120" height="60"></a> --%>
													</c:if>
												</p>
											</div>
										<div class="panel-body">
											<div class="col-lg-12">名称：${advertiser.name }</div>
											<div class="col-lg-12">类型：${advertiser.charge_mode }</div>
											<div class="col-lg-12">佣金：${advertiser.commission }</div>
										</div></div>
									</div>
								</c:forEach>
							</div>
							</div>
						</div>
					</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-lg-2"></div>
			<div class="row col-lg-9"><ul class="nav nav-tabs"></ul></div>
			<div class="row col-lg-1"></div>
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
