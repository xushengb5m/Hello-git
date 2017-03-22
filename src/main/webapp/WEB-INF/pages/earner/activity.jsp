<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-详细活动</title>
</head>

<style>
</style>

<body>

	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-lg-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h2>
							 详细活动
						</h2>
						<div class="ibox-tools">
							<!-- <select class="form-control m-b" name="account">
								<option>选项 1</option>
								<option>选项 2</option>
								<option>选项 3</option>
								<option>选项 4</option>
							</select> -->
							<label class="col-sm-5 control-label">请选择申请的网站：</label>
								<div class="col-sm-7">
									<select class="form-control" id="website_id" name="website_id" onchange="changeWebsite();">
										<c:forEach var="website" items="${requestScope.websites }">
										<c:if test="${web.id == website.id }">
										<option value="${website.id }" selected="selected">${website.name}-${website.url }</option> 
										</c:if>
										<c:if test="${web.id != website.id}">
										<option value="${website.id }">${website.name}-${website.url }</option> 
										</c:if>	
										</c:forEach>
									</select>
								</div> <!-- <a class="collapse-link"> <i class="fa fa-chevron-up"></i></a> -->
							<!-- <a class="dropdown-toggle" data-toggle="dropdown" href="table_data_tables.html#"> <i class="fa fa-wrench"></i></a>
							<ul class="dropdown-menu dropdown-user">
								<li><a href="table_data_tables.html#">选项1</a></li>
								<li><a href="table_data_tables.html#">选项2</a></li>
							</ul> -->
							<!-- <a class="close-link"> <i class="fa fa-times"></i></a> -->
						</div>
					</div>
					<div class="ibox-content">
						<input type="hidden" id="user_id" value="${requestScope.user_id }">
						<table
							class="table table-striped table-hover dataTables-example">
							<thead>
								<tr>
									<!-- <th>选择</th> -->
									<th>Logo</th>
									<th>活动名称</th>
									<th>活动ID</th>
									<th>计费类型</th>
									<th>活动分类</th>
									<th>佣金</th>
									<th>RD</th>										
									<th>开始时间</th>
									<th>结束时间</th> 
									<th>审核方式</th>
									<th>审核状态</th>  														
									<th >操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="row" items="${requestScope.rows}">
									<tr class="gradeX">
										<%-- <td class="center"><input name="apply_batch" value="${row.id }" type="checkbox"></td> --%>
										<td class="center"><a
											href="<%=basePath%>/earner/act/activity/${row.id}/${web.id}"><img src="${row.image}" width="120" height="60"></a></td>
										<td class="center">${row.name }</td>
										<td class="center">${row.id }</td>
										<td class="center">${row.charge_mode }</td>
										<td class="center">${row.category_name }</td>
										<td class="center">${row.commission}</td>
										<td class="center">${row.rd}</td>
										<td class="center"><fmt:formatDate value="${row.start_date}" pattern="yyyy-MM-dd"/></td>
										<td class="center"><fmt:formatDate value="${row.end_date}" pattern="yyyy-MM-dd"/></td>
										<td class="center">
										<c:if test="${row.approval_mode==1 }">
											自动
										</c:if>
										<c:if test="${row.approval_mode==2 }">
											人工
										</c:if>
										<c:if test="${row.approval_mode==3 }">
											无需审核
										</c:if>
										</td>
										<td class="center">
										<c:if test="${row.approval_status==1 }">
											审核通过
										</c:if>
										<c:if test="${row.approval_status==0 }">
											审核中
										</c:if>
										<c:if test="${row.approval_status==-1 }">
											审核不通过
										</c:if>
										<c:if test="${row.approval_status==null }">
											未申请
										</c:if>
										</td>
										<td class="center"><a
											href="<%=basePath%>/earner/act/activity/${row.id}/${web.id}"><button
													class="btn btn-success btn-sm" type="button">
													<i class="fa fa-search"></i>
												</button></a>&nbsp;&nbsp;<c:if
												test="${row.approval_status==null }">
												<a href="javaScript:void(0);"
													onclick="applyActivity(${row.id});"><button
														class="btn btn-primary btn-sm" type="button">
														<i class="fa fa-edit">&nbsp;申请</i>
													</button></a>
											</c:if><c:if
												test="${row.approval_status != null }">
												<a href="javaScript:void(0);"><button
														class="btn btn-default btn-sm" type="button">
														<i class=" ">已申请</i>
													</button></a>
											</c:if></td>
									</tr>
								</c:forEach>
							</tbody>
							<tfoot>
								<!-- <tr>
									<th>渲染引擎</th>
									<th>浏览器</th>
									<th>平台</th>
									<th>引擎版本</th>
									<th>CSS等级</th>
								</tr> -->
							</tfoot>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>	

	<!-- Mainly scripts -->
	<script type="text/javascript">
		window.onload = function() {
			$('.dataTables-example').dataTable();
			switchLanguage(language_flag);
		}
		
		function applyActivity(activity_id) {
			var user_id = $("#user_id").val();
			var website_id = $("#website_id").val();
			$.ajax({
				url : "<%=basePath%>/earner/act/activity",
				type : "POST",
				data : {
					activity_id : activity_id,
					user_id : user_id,
					website_id : website_id
				},
				success : function(data) {
					toastr.success('You Apply Successfully', 'Contradulations!');
					setInterval(function(){
						window.location.reload();
						},1000);
				},
				error : function(xhr, type, errorThrown) {
					toastr.error('You Failed', 'Sorry!');
				}
			});
		}

		function changeWebsite() {
			var website_id = $("#website_id").val();
			window.location.href = "<%=basePath%>/earner/act/activity?website_id=" + website_id;
		}
    </script>

	<script src="<%=basePath%>/js/footer.js"></script>
</body>
</html>
