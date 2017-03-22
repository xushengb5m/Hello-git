<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-时间轴</title>
</head>

<style>
/*     #myModal
    {
        top:300px;
        right:500px;
    } */
</style>

<body>
	<div id="vertical-timeline"
		class="vertical-container dark-timeline center-orientation">
			<div class="vertical-timeline-block">
				<div class="vertical-timeline-icon blue-bg">
					<i class="fa fa-briefcase"></i>
				</div>
	
				<div class="vertical-timeline-content">
					<h2>注册</h2>
					<p>你在系统中成功注册邮箱:${userInfo.email};账户名:${userInfo.userName}</p>
					<span
						class="vertical-date"><fmt:formatDate value="${userInfo.createTime}" pattern="yyyy-MM-dd"/><br> <small><fmt:formatDate value="${userInfo.createTime}" pattern="hh:mm:ss"/></small>
					</span>
				</div>
			</div>
			<c:forEach items="${requestScope.records}" var="row">
			<div class="vertical-timeline-block">
				<div class="vertical-timeline-icon blue-bg">
					<i class="fa fa-briefcase"></i>
				</div>
	
				<div class="vertical-timeline-content">
					<h2>${row.target}</h2>
					<p>你${row.message}</p>
					<span
						class="vertical-date">${row.the_date} <br> <small>${row.the_time}</small>
					</span>
				</div>
			</div>
			</c:forEach>

	</div>
	<script src="/js/footer.js"></script>
</body>
</html>
