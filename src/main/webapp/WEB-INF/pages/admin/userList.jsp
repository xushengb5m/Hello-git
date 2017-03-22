<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js ie7 oldie" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js ie8 oldie" lang="en"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="en">
<!--<![endif]-->
<head>
<title>${requestScope.title }</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script>
  function delUser(userid,roleNumbers) {
	  if(window.confirm("确定删除此用户?")) {
		  $.get('/admin/delUser.do',{id:userid,roleNumbers:roleNumbers}, function(data){
				if(data=="success"){
					alert("删除成功！");
				}else if(data=="fail"){
					alert("删除失败！");
				}
				location.reload();
		  });
	  }
  }
  function queryUserByRole(){
	  var roleName = $("#roleName").val();
	  window.location = "/admin/toAccountMrg.do?roleName="+roleName;
  }
  window.onload=function(){
		$('.addnewuser').click(function(){
			top.addnewuser();
		});
		if("${query.roleName}" != ""){
			$("#roleName").val("${query.roleName}");
		}
  };
</script>
<!--[if gte IE 9]>
	<link rel="stylesheet" href="/css/adserver/ie9.css" type="text/css" />
	<![endif]-->

<!--[if gte IE 8]>
	<link rel="stylesheet" href="/css/adserver/ie8.css" type="text/css" />
	<![endif]-->

<script type="text/javascript">

</script>
</head>
<body style="background:none;min-height:770px;" class="mybody">
<%@include file="/WEB-INF/pages/common/adserveScript.jsp"%>
			<div id="contentHeader">
			<div class="contentHeaderbor">
				<h1>账户管理</h1>
			</div>
			</div> <!-- #contentHeader -->
			<div class="container">
				<div class="grid-24">
					<div class="widget widget-table">
						<div class="widget-header">
							<span class="icon-list"></span>
							<h3>账户列表</h3>
							<select name="roleName" id="roleName" onchange="queryUserByRole()" style="float: right;">
			                <option value="0">请选择角色</option>
							<c:forEach items="${roles}" var="role">
				            <option value="${role.remark}">${role.remark}</option>
				            </c:forEach>                                    								  
			             	</select>	
						</div>
						<div class="widget-content">	
							<div class="dataTables_wrapper" id="syslog_wrapper">
								<div class="fg-toolbar ui-toolbar ui-widget-header ui-corner-tl ui-corner-tr ui-helper-clearfix">
									<div id="syslog_length" class="dataTables_length">
										<label>Show <select size="1" name="syslog_length">
											<option value="10" selected="selected">10</option>
											<option value="25">25</option>
											<option value="50">50</option>
											<option value="100">100</option>
										</select> entries</label>
									</div><!-- <div class="dataTables_filter" id="syslog_filter"><label>Search: <input type="text" id="query_advertiser"></label></div> -->
								</div>
								<table id="syslog" class="table table-bordered table-striped data-table">
									<thead>
										<tr>
											<th rowspan="1" colspan="1"><span>用户ID</span></th>
											<th rowspan="1" colspan="1"><span>用户名</span></th>
											<th rowspan="1" colspan="1"><span>帐号</span></th>
											<th rowspan="1" colspan="1"><span>角色</span></th>
											<th rowspan="1" colspan="1">操作</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${empty requestScope.results }">
											<tr class="odd">
												<td valign="top" colspan="6" class="dataTables_empty">No data available in table</td>
											</tr>
										</c:if>	
										<c:if test="${requestScope.results !=null}">
										<c:forEach items="${requestScope.results}" var="row">
											<tr>
												<td>${row.id }</td>
												<td>${row.userName }</td>
												<td>${row.email }</td>
			 									<td>${row.roleName}</td>
												<td><span><a href="/admin/editUserView.do?id=${row.id }" style="color:#FFF; text-decoration:none;" class="ticket ticket-warning" title="编辑"></a></span>&emsp;
													<c:if test="${fn:contains(requestScope.cpsx_user_login.roleIds,1)}">
													<span id="userdel2"><a style="color:#FFF; text-decoration:none;" href="javascript:void(0)" onclick="delUser('${row.id}','${row.roleNumbers}')" title="删除" class="ticket ticket-important"></a></span>
													</c:if>
													<c:if test="${!fn:contains(requestScope.cpsx_user_login.roleIds,1)}">
														只有管理员有删除权限
													</c:if>
												</td>
											</tr>
										</c:forEach>
										</c:if>
									</tbody>
								</table>
						
								<div class="b5ma_page">
									共 ${requestScope.total} 条
									<pg:pager url="/admin/toAccountMrg.do" items="${total}" 
									index="center" maxPageItems ="10" maxIndexPages="5" 
									export ="pageNumber,currentPageNumber=pageNumber" scope = "request">
											<pg:first><a href="<%=pageUrl%>&roleName=${query.roleName}">首页</a></pg:first>
											<pg:prev><a href="<%=pageUrl%>&roleName=${query.roleName}">上一页</a></pg:prev>
											当前第${pageNo}页
											<pg:next><a href="<%=pageUrl%>&roleName=${query.roleName}">下一页</a></pg:next>
											<pg:last><a href="<%=pageUrl%>&roleName=${query.roleName}">末页</a></pg:last>
									</pg:pager>
								</div>
							</div>
						</div><!-- .widget-content -->
					</div> <!-- .widget -->
					<c:if test="${fn:contains(requestScope.cpsx_user_login.roleIds,1)}">
					<div class="actions">
						<a href="/admin/addUserView.do" class="btn btn-quaternary btn-large">添加账号</a>
					</div>
					</c:if>
				</div> <!-- .grid -->
			</div> <!-- .container -->
	
<script type="text/javascript" src="/js/common/footerjs.js"></script>
</body>
</html>

