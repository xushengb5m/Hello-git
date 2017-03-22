<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-活动审核</title>
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
							 活动审核
						</h2>
						<div class="ibox-tools">
						</div>
					</div>
					<div class="ibox-content">
						<table
							class="table table-striped table-hover dataTables-example">
							<thead>
								<tr>
									<!-- <th>选择</th> -->
									<th>网站主ID</th>
									<th>网站主</th>
									<th>活动Logo</th>
									<th>活动名称</th>
									<th>计费类型</th>
									<th>活动分类</th>
									<th>佣金</th>
									<th>RD</th>										
									<th>开始时间</th>
									<th>结束时间</th>
									<th>佣金比例</th> 
									<th>审核状态</th>  														
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="row" items="${requestScope.rows}">
									<tr class="gradeX">
										<%-- <td class="center"><input name="apply_batch" value="${row.id }" type="checkbox"></td> --%>
										<td class="center">${row.website_id }</td>
										<td class="center">${row.website_name }</td>
										<td class="center"><img src="${row.activity_image}" width="120" height="60"></td>
										<td class="center">${row.activity_name }</td>
										<td class="center">${row.activity_charge_mode }</td>
										<td class="center">${row.activity_category_name }</td>
										<td class="center">${row.activity_commission}</td>
										<td class="center">${row.activity_rd}</td>
										<td class="center"><fmt:formatDate value="${row.activity_start_date}" pattern="yyyy-MM-dd"/></td>
										<td class="center"><fmt:formatDate value="${row.activity_end_date}" pattern="yyyy-MM-dd"/></td>
										<td class="center">
										<c:if test="${row.approval_status!=1 }">
															<select id="rate${row.id}" class="form-control">
																<option <c:if test="${row.commission_rate eq 1 }"> selected </c:if> value="1" selected="selected">80%</option>
																<option <c:if test="${row.commission_rate eq 2 }"> selected </c:if> value="2">70%</option>
																<option <c:if test="${row.commission_rate eq 3 }"> selected </c:if> value="3">60%</option>
																<option <c:if test="${row.commission_rate eq 4 }"> selected </c:if> value="4">50%</option>			
											                </select>
										</c:if>
										<c:if test="${row.approval_status==1 }">
															<select id="rate${row.id}" disabled="disabled" class="form-control">
																<option <c:if test="${row.commission_rate eq 1 }"> selected </c:if> value="1">80%</option>
																<option <c:if test="${row.commission_rate eq 2 }"> selected </c:if> value="2">70%</option>
																<option <c:if test="${row.commission_rate eq 3 }"> selected </c:if> value="3">60%</option>
																<option <c:if test="${row.commission_rate eq 4 }"> selected </c:if> value="4">50%</option>			
											  				</select>
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
										<td class="center">
											<c:if test="${row.approval_status==1 }">
												<a href="javaScript:void(0);"
													onclick="reset(${row.id});"><button
														class="btn btn-warning btn-sm" type="button">
														<i class="fa fa-lock"></i>
													</button></a>&nbsp;&nbsp;&nbsp;&nbsp;
												<a href="javaScript:void(0);"
													onclick="decline(${row.id});"><button
														class="btn btn-danger btn-sm" type="button">
														<i class="fa fa-thumbs-o-down"></i>
													</button></a>
											</c:if> 
											
											<c:if test="${row.approval_status==0 }">
												<a href="javaScript:void(0);"
													onclick="approval(${row.id});"><button
														class="btn btn-primary btn-sm" type="button">
														<i class="fa fa-thumbs-o-up"></i>
													</button></a>&nbsp;&nbsp;&nbsp;&nbsp;
												<a href="javaScript:void(0);"
													onclick="decline(${row.id});"><button
														class="btn btn-danger btn-sm" type="button">
														<i class="fa fa-thumbs-o-down"></i>
													</button></a>
											</c:if> 
											
											<c:if test="${row.approval_status==-1 }">
												<a href="javaScript:void(0);"
													onclick="approval(${row.id});"><button
														class="btn btn-primary btn-sm" type="button">
														<i class="fa fa-thumbs-o-up"></i>
													</button></a>&nbsp;&nbsp;&nbsp;&nbsp;
												<a href="javaScript:void(0);"
													onclick="reset(${row.id});"><button
														class="btn btn-warning btn-sm" type="button">
														<i class="fa fa-lock"></i>
													</button></a>
											</c:if>
										</td>
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
		
		function approval(id) {
			var approval_status = 1;
			changeStatus(id, approval_status);
		}
		
		function reset(id) {
			var approval_status = 0;
			changeStatus(id, approval_status);
		}
		
		function decline(id) {
			var approval_status = -1;
			changeStatus(id, approval_status);
		}
		
		function changeStatus(id, approval_status) {
			var rate = $("#rate"+id).val();
			$.ajax({
				url : "<%=basePath%>/earner/app/approval/"+id+"/"+approval_status+"/"+rate,
				type : "PUT",
				success : function(data) {
					toastr.success('You Act Successfully', 'Contradulations!');
					setInterval(function(){
						window.location.reload();
						},1000);
				},
				error : function(xhr, type, errorThrown) {
					toastr.error('You Failed', 'Sorry!');
				}
			});
		}
		function changeRate(obj){
			console.info(obj);
			console.info(obj.val());
		}
    </script>

	<script src="<%=basePath%>/js/footer.js"></script>
</body>
</html>
