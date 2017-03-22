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
  height: 80% !important;
  padding-top:10%;
}

.modal-content {
  height: 50% !important;
}

.modal-body {
  height: 80%;
}  
</style>
<script src="<%=basePath %>/js/thumbnail-scroller/jquery.mThumbnailScroller.js"></script>
</head>

<body class="top-navigation">

	<div id="" class="gray-bg">
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
					<a href="#"> <img alt="First Slide" width="1920" height="350"
						src="<%=basePath%>/img/banner/test1.jpg" style="display: inline;">
					</a>
				</div>
				<div class="item center">
					<a href="#"> <img alt="Second Slide" width="1920" height="350"
						src="<%=basePath%>/img/banner/test2.jpg" style="display: inline;">
					</a>
				</div>
				<div class="item center">
					<a href="#"> <img alt="Third Slide" width="1920" height="350"
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
			<div class="col-lg-2"></div>
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
								<a class="limit_number" href="<%=basePath%>/banx/home/notification/${notice.id}">【${notice.activity_name}】 ${notice.title }</a>
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
								<a class="limit_number" href="<%=basePath%>/banx/home/notification/${reward.id}">【${reward.activity_name}】 ${reward.title }</a>
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
								<a class="limit_number" href="<%=basePath%>/banx/home/notification/${sale.id}">【${sale.activity_name}】 ${sale.title }</a>
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
												<img src="${advertiser.image}" width="120" height="60">
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
			var password = $("#password").val();
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

