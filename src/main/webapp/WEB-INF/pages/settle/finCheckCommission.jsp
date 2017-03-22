<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-站点审核</title>
<script type="text/javascript">
var table = $('#tbl').DataTable();
window.onload = function() {
	$('.dataTables-example').dataTable();
}
function checkWebsite(obj){
	var table = $('#tbl').DataTable();
	var row = table.row(obj.parentNode.parentNode).data();
	var i=0;
	$("#ua_form").find("input,select").each(function(){
		$(this).val(row[i]);
		i++;
	});
	if(row[7]=="true"){
		$("#is_enable").attr("checked","checked");
	}
	$("#flag").val("update");
	$('#uaModal').modal('show');
}

</script>
</head>

<body>
<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-lg-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h2>
							佣金申请列表
						</h2>
						<div class="ibox-tools">
								<select id="pay_stat" name="pay_stat" class="form-control">
										<option value="2" >全部</option> 
										<option value="0">未支付</option> 
										<option value="1">已支付</option> 
								</select>
						</div>
					</div>
					<div class="ibox-content">
						<table id="tbl"
							class="table table-striped table-bordered table-hover dataTables-example">
							<thead>
								<tr>
									<th>网站主ID</th>
									<th>申请账户</th>
									<th>年月</th>
									<th>产生佣金</th>
									<th>申请时间</th>
									<th>申请提现金额</th>
									<th>支付扣税</th>
									<th>汇款手续费</th>
									<th>实付金额</th>
									<th>付款日期</th>
									<th>收款人</th>
									<th>审核状态</th>
									<th>支付状态</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="row" items="${requestScope.rows}">
									<tr class="gradeX">
										<td class="center">${row.user_id}</td>
										<td class="center">${row.email}</td>
										<td class="center">${row.the_date}</td>
										<td class="center">${row.commission}</td>
										<td class="center">${row.apply_date}</td>
										<td class="center">${row.apply_money}</td>
										<td class="center">${row.tax_money}</td>
										<td class="center">${row.charge_money}</td>
										<td class="center">${row.pay_money}</td>
										<td class="center">${row.pay_date}</td>
										<td class="center">${row.receiver}</td>
										<td class="center">
											<c:if test="${row.check_state==0 }">
												<a href="javascript:void(0)"><button
														class="btn btn-default btn-sm" type="button">
														<i class=" ">&nbsp;审核中</i>
													</button></a>
											</c:if>
											<c:if test="${row.check_state==1}">
												<a href="javaScript:void(0);"><button
														class="btn btn-default btn-sm" type="button">
														<i class=" ">审核通过</i>
													</button></a>
											</c:if>
											<c:if test="${row.check_state==2}">
												<a href="javaScript:void(0);"><button
														class="btn btn-default btn-sm" type="button">
														<i class=" ">审核不通过</i>
													</button></a>
											</c:if>
										<%-- <c:if test="${row.pay_state==1}">已支付
										</c:if>
										<c:if test="${row.pay_state==0}">未支付
										</c:if> --%>
										</td>
										<td class="center">
											<c:if test="${row.pay_state==0 }">
												<a href="/settle/pay/payCommission/${row.user_id}/${row.the_year}/${row.the_month}"><button
														class="btn btn-primary btn-sm" type="button">
														<i class="fa fa-edit">&nbsp;支付中</i>
													</button></a>
											</c:if>
											<c:if test="${row.pay_state==1}">
												<a href="javaScript:void(0);"><button
														class="btn btn-default btn-sm" type="button">
														<i class=" ">已支付</i>
													</button></a>
											</c:if>
											<c:if test="${row.pay_state==2}">
												<a href="javaScript:void(0);"><button
														class="btn btn-default btn-sm" type="button">
														<i class=" ">未支付</i>
													</button></a>
											</c:if>
										</td>
									</tr> 
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		</div>
	<script src="/js/footer.js"></script>
</body>
</html>
