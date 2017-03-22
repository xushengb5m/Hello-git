<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-佣金明细</title>
</head>
<body>
<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-lg-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h2>
							当月佣金明细列表
						</h2>
						<div class="ibox-tools">
							<a href="javascript:void(0)" onclick="addWebSite()" class="btn btn-primary"><i class="fa"></i>下载Excel</a>
						</div>
					</div>
					<div class="ibox-content">
						<table id="tbl"
							class="table table-striped table-bordered table-hover dataTables-example">
							<thead>
								<tr>
									<th>活动</th>
									<th>网站</th>
									<th>订单编号</th>
									<th>下单时间</th>
									<th>确认佣金</th>
									<th>确认时间</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="row" items="${requestScope.details}">
									<tr class="gradeX">
										<td class="center">${row.activity_id}</td>
										<td class="center">${row.website_id}</td>
										<td class="center">${row.order_no}</td>
										<td class="center">${row.order_time}</td>
										<td class="center">${row.settle_commission}</td>
										<td class="center">${row.settle_time}</td>
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
		var table = $('#tbl').DataTable();
		window.onload = function() {
			$('.dataTables-example').dataTable();
			switchLanguage(language_flag);

		}
	</script>

	<script src="/js/footer.js"></script>
</body>
</html>
