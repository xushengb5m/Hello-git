<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-审核站点</title>
</head>
<body>
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-lg-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h2>支付佣金</h2>
						<div class="ibox-tools"></div>
					</div>
					<div class="ibox-content">
					<div class="row">
						<div class="panel-options">
							<ul class="nav nav-tabs">
								<li class="active"><a data-toggle="tab" href="#tab-1">申请中的佣金</a></li>
								<li class=""><a data-toggle="tab" href="#tab-2">佣金申请一览</a></li>
							</ul>
						</div>
		
						<div class="panel-body">
							<div class="tab-content">
								<div id="tab-2" class="tab-pane">
									<table class="table table-striped table-bordered table-hover dataTables-example">
										<thead>
											<tr>
												<th>日期</th>
												<th>产生的佣金</th>
												<th>申请的佣金</th>
												<th>余额</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="row" items="${requestScope.rows}">
												<tr class="gradeX">
													<td class="center">${row.the_date}</td>
													<td class="center">￥${row.commission==null?0:row.commission}</td>
													<td class="center">￥${row.apply_money==null?0:row.apply_money}</td>
													<td class="center">￥${row.remain==null?0:row.remain}</td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
								
								<div id="tab-1" class="tab-pane active">
									<table class="table table-striped table-bordered table-hover dataTables-example">
										<thead>
											<tr>
												<th>年月</th>
												<th>申请结算的金额</th>
												<th>账户余额</th>
												<th>审核不通过说明</th>
											</tr>
										</thead>
										<tbody>
												<tr class="gradeX">
													<td class="center">${applying.the_date}</td>
													<td class="center">${applying.apply_money}</td>
													<td class="center">${applying.remain}</td>
													<td class="center"><input type="text" id=note name="note" value="${applying.note}" class="form-control"></td>
												</tr>
										</tbody>
									</table>
								</div>
								
							</div>
						</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div>
			<div class="text-center">
				<button class="btn btn-primary" onclick="checkSuccess()">审核通过</button>
				<button class="btn btn-primary" onclick="checkFail()">审核不通过</button>
				<button class="btn btn-primary" onclick="history.back()">返回</button>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		function checkSuccess() {
			$.ajax({
				url : "/settle/bi/checkApply/${applying.user_id}/${applying.the_year}/${applying.the_month}",
				type : "POST",
				data : {
					check_state:1
				},
				dataType : "json",
				success : function(result) {
					if (result.statue == true) {
						toastr.success(result.message);
						window.location.href="/settle/bi/commission";
					} else {
						toastr.warning(result.message);
					}
				},
				error : function(xhr, type, errorThrown) {
					toastr.warning('提交失败: ' + errorThrown);
				}
			});
		}
		
		function checkFail() {
			$.ajax({
				url : "/settle/bi/checkApply/${applying.user_id}/${applying.the_year}/${applying.the_month}",
				type : "POST",
				data : {
					check_state:2,
					note:$("#note").val()
				},
				dataType : "json",
				success : function(result) {
					if (result.statue == true) {
						toastr.success(result.message);
						window.location.href="/settle/bi/commission";
					} else {
						toastr.warning(result.message);
					}
				},
				error : function(xhr, type, errorThrown) {
					toastr.warning('提交失败: ' + errorThrown);
				}
			});
			
		}
	</script>
	<script src="/js/footer.js"></script>
</body>
</html>
