<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- <%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager" %> --%>
<!doctype html>
<html class="no-js" lang="en">
<head>
<title>角色列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>
<body style="background:none;">

		<%@include file="/WEB-INF/pages/common/adserveScript.jsp"%>
	
			<div id="contentHeader">
			<div class="contentHeaderbor">
				<h1>角色列表</h1>
			</div>
			</div>
			<!-- #contentHeader -->
			<div class="container">
				<div class="grid-24">
					<div class="widget widget-table">
						<div class="widget-header">
							<span class="icon-list"></span>
							<h3>角色列表</h3>
						</div>
						<div class="widget-content">
							<table class="table table-bordered table-striped">
								<thead>
									<tr>
										<th><div align="center">角色名称</div></th>
										<th><div align="center">角色备注</div></th>			
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${roles}" var="role">
										<tr class="gradeA">
											<td>${role.role}</td>
											<td class="center">${role.remark}</td>
											<td class="center">
												<a href="/admin/role/updateRoleView.do?id=${role.id}" title="编辑" class="ticket ticket-warning"></a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						<!-- .widget-content -->
					</div>
					<!-- .widget -->
					<!-- .actions -->
				</div>
				<!-- .grid -->
			</div>
			<!-- .container -->
	
</body><script type="text/javascript" src="/js/common/footerjs.js"></script>
</html>