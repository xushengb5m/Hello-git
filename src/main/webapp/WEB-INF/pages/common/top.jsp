<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>帮5买CPS联盟-CPS广告联盟平台_中国最好的电子商务效果营销广告联盟</title>
<meta charset="utf-8">
<meta
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"
	name="viewport">
<%@include file="/WEB-INF/pages/common/head.jsp"%>
</head>
<script type="text/javascript">
window.onload = function() {
	$(".spring").each(function(){
		if($(this).attr("href")==getCookie("cookie_url")){
			$(".current").removeClass("current");
			$(this).parent("li").parent("ul").parent("li").find("a").first().addClass("current");
			$(this).addClass("current");
		}
	});
	
	$(".spring").click(function(e){
		$(".current").removeClass("current");
		$(this).parent("li").parent("ul").parent("li").find("a").first().addClass("current");
		$(this).addClass("current");
		var url=$(this).attr("href");
		document.cookie="cookie_url="+url;
	})
	
	$('#ifrObj').hover(
			function () {
				$(".dropdown").removeClass("open");
			}
	);
}

function getCookie(name)
{
	var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
	if(arr=document.cookie.match(reg))
	return unescape(arr[2]);
	else
	return null;
}
</script>
<body>
<div id="wrapper" class="gray-bg">
<div class="row">
	<div class="modal-shiftfix">
		<!-- Navigation -->
		<div class="navbar navbar-fixed-top scroll-hide">
			<div class="container-fluid top-bar">
				<div class="pull-left">
					<a class="logo" href="/cpsx/index.do"></a>
				</div>
				<div class="pull-right">
					<ul class="nav navbar-nav pull-right">
						<!-- <li class="dropdown settings hidden-xs"><a
							class="dropdown-toggle" data-toggle="dropdown" href="#"><span
								aria-hidden="true" class="se7en-gear"></span></a>
							<ul class="dropdown-menu">
								<li><a class="settings-link blue"
									href="javascript:chooseStyle('none', 30)"><span></span>蓝色</a></li>
								<li><a class="settings-link green"
									href="javascript:chooseStyle('green-theme', 30)"><span></span>绿色</a>
								</li>
								<li><a class="settings-link orange"
									href="javascript:chooseStyle('orange-theme', 30)"><span></span>橘黄色</a>
								</li>
								<li><a class="settings-link magenta"
									href="javascript:chooseStyle('magenta-theme', 30)"><span></span>品红</a>
								</li>
								<li><a class="settings-link gray"
									href="javascript:chooseStyle('gray-theme', 30)"><span></span>灰色</a>
								</li>
							</ul></li> -->
						  <li><a href="/cpsx/timeLine.do?userId=${cpsx_user_login.id}" target="ifrObj" data-toggle="tooltip" title="Go to your timeline!">
	                      <i class="icon-calendar"></i>
	                      <c:if test="${cookie.b5m_cpsx_zero_or_one.value==1}">
	                      		进入时间轴
	                      </c:if>
	                      <c:if test="${cookie.b5m_cpsx_zero_or_one.value==0}">
	                      		GO INTO YOUR TIMELINE!
	                      </c:if></a>
			              </li>
						  <li><a href="/cpsx/userAccount.do?userId=${cpsx_user_login.id}" target="ifrObj" data-toggle="tooltip" title="Edit Your Account!">
	                      <i class="icon-user"></i>
	                      <c:if test="${cookie.b5m_cpsx_zero_or_one.value==1}">
	                      		欢迎
	                      </c:if>
	                      <c:if test="${cookie.b5m_cpsx_zero_or_one.value==0}">
	                      		Welcome
	                      </c:if>
	                      ,${cpsx_user_login.userName}</a>
			              </li>
			              <li><a href="/cpsx/mrgLogout.do?toUrl=/" data-toggle="tooltip" title="Exit!">
			                    <i class="icon-signout"></i>
			              <c:if test="${cookie.b5m_cpsx_zero_or_one.value==1}">
	                      		退出
	                      </c:if>
			              <c:if test="${cookie.b5m_cpsx_zero_or_one.value==0}">
	                      		Logout
	                      </c:if></a>
			              </li>
					</ul>
				</div>
			</div>
			<div class="container-fluid main-nav clearfix">
				<div class="nav-collapse">
					<ul class="nav">
						<li><a class="current spring" href="/cpsx/home.do" target="ifrObj">
						<span aria-hidden="true" class="icon-home"></span><strong>
								<c:if test="${cookie.b5m_cpsx_zero_or_one.value==1}">首页</c:if>
								<c:if test="${cookie.b5m_cpsx_zero_or_one.value==0}">Home</c:if></strong></a></li>

						<c:forEach items="${applicationScope.cpsx_menu_top}" var="topmenu">
							<c:if test="${topmenu.ismenu eq 'y' }">
								<li class="dropdown"><a data-toggle="dropdown" href="#" >
										<span aria-hidden="true" class="${topmenu.clsname}"></span><strong> ${cookie.b5m_cpsx_zero_or_one.value==1?topmenu.resourceName:topmenu.engName}</strong> 
										<b class="caret"></b>
								</a>
									<ul class="dropdown-menu ">
										<c:forEach items="${requestScope.cpsx_menu}" var="menuItem">
											<c:if test="${menuItem.key eq topmenu.id }">
												<c:forEach items="${menuItem.value}" var="row">
													<c:if test="${row.ismenu eq 'y' }">
													<li><a href="${row.resourceUrl }" class="spring" target="ifrObj">${cookie.b5m_cpsx_zero_or_one.value==1?row.resourceName:row.engName}</a></li>
													</c:if>
												</c:forEach>
											</c:if>
										</c:forEach>
									</ul>
									</li>
							</c:if>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
		<!-- End Navigation -->
		<div id="content"
			style="overflow: hidden; padding: 0; margin-right: 0px;">
			<iframe id="ifrObj" name="ifrObj" src="${cookie.cookie_url==null?'/cpsx/home.do':cookie.cookie_url.value}"
				onloadeddata="$('#content').toggleLoading();"
				style="border: none; overflow-y: scroll;" width="100%" height="auto"
				allowtransparency="true"></iframe>
		</div>
	</div>
    </div>
    </div>
</body>
<script type="text/javascript" src="<%=basePath%>/js/common/footerjs.js"></script>
</html>