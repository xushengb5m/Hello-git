<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-佣金申请</title>
<script type="text/javascript">
	function applyCash(){
		var today = new Date();
		var nowMonth = today.getMonth(); 
		var nowYear = today.getFullYear(); 
		var msDate = new Date(nowYear, nowMonth, 10);
		var esDate = new Date(nowYear, nowMonth, 15);
		if(today<msDate || today>esDate){
			toastr.warning("提款日期必须在每个月10号至15号之间!");
			return;
		}
		$("#cash_form").form('clear');
		$('#myModal').modal('show');
	}
	function reApply(userId,year,month){
		var target = "/settle/apply/reApplyCommission/"+userId+"/"+year+"/"+month;
		$.ajax({
			url : target,
			type : "POST",
			dataType : "json",
			success : function(result) {
				if (result.statue == true) {
					toastr.success(result.message);
					window.location.reload();
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
</head>

<style>
/*     #myModal
    {
        top:300px;
        right:500px;
    } */
</style>

<body>
	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-lg-6">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h2>佣金提现申请</h2>
						<div class="ibox-tools">
							<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
							</a>
						</div>
					</div>
					<div class="ibox-content">
						<div class="row">
							<div class="col-lg-6">
								<div class="jumbotron">
									<h4>余额:</h4>
									<p align="center">￥${applyInfo.remain}</p>
								</div>
							</div>
							<div class="col-lg-6">
								<div class="jumbotron">
									<h4>提现中:</h4>
									<p align="center">￥${applyfingMoney}</p>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-lg-6">
								<div class="jumbotron">
									<h4>可提现金额:</h4>
									<p align="center">
										￥${applyInfo.remain-applyfingMoney} <a href="javascript:void(0)" onclick="applyCash()">提现</a>
									</p>
								</div>
							</div>
							<div class="col-lg-6">
								<div class="jumbotron">
									<ol>
										<li><a href="/settle/apply/payAccount/${userId}">完善账户信息</a></li>
										<li><a href="/settle/apply/payPassword/${userId}">设置提现密码</a></li>
										<li>注意:每个月10号以后可以提现上个月及以前的佣金，未提现的佣金将累加到余额中，每月限提一次。</li>
									</ol>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="col-lg-6">
				<div class="row">
					<div class="panel-options">
						<ul class="nav nav-tabs">
							<li class="active"><a data-toggle="tab" href="#tab-1">申请中的佣金</a></li>
							<li class=""><a data-toggle="tab" href="#tab-2">佣金产生&申请</a></li>
						</ul>
					</div>
	
					<div class="panel-body">
						<div class="tab-content">
						<div id="tab-1" class="tab-pane active">
							<table class="table table-striped table-bordered table-hover dataTables-example">
								<thead>
									<tr>
										<th>申请时间</th>
										<th>申请结算的金额</th>
										<th>审核状态</th>
										<th>付款状态</th>
										<th>消息通知</th>
										<th>申请结果<th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="row" items="${requestScope.applying}">
										<tr class="gradeX">
											<td class="center"><fmt:formatDate value="${row.apply_date}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
											<td class="center">${row.apply_money}</td>
											<td class="center"><c:if test="${row.check_state==0 }">
												审核中
												</c:if>
												<c:if test="${row.check_state==1}">
												审核通过
												</c:if>
												<c:if test="${row.check_state==2}">
												审核不通过
												</c:if></td>
											<td class="center"><c:if test="${row.pay_state==0 }">
												待支付
												</c:if>
												<c:if test="${row.pay_state==1}">
												已支付
												</c:if>
												<c:if test="${row.pay_state==2}">
												未支付
												</c:if></td>
											<td class="center">${row.note}</td>
											<td class="center">
											  	<c:if test="${row.check_state==2  or row.pay_state==2}">
											  		申请失败,<a href="javascrip:void(0)" onclick="reApply(${row.user_id},${row.the_year},${row.the_month})">再次申请</a>
											  		/ <a href="javascrip:void(0)">撤销申请</a>
											  	</c:if>
											 </td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						
						<div id="tab-2" class="tab-pane">
							<table class="table table-striped table-bordered table-hover dataTables-example">
								<thead>
									<tr>
										<th>年月</th>
										<th>产生的佣金</th>
										<th>申请中的佣金</th>
										<th>已结算的佣金</th>
										<th>余额</th>
									</tr>
								</thead>
								<tbody>
										<c:forEach var="row" items="${requestScope.rows}">
												<tr class="gradeX">
													<td class="center">${row.the_date}</td>
													<td class="center">￥${row.commission==null?0:row.commission}</td>
													<td class="center">￥${row.pay_state==0?row.apply_money:0}</td>
													<td class="center">￥${row.pay_state==1?row.apply_money:0}</td>
													<td class="center">￥${row.remain==null?0:row.remain}</td>
												</tr>
										</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
				
				<%-- <div class="ibox float-e-margins">
					<div class="ibox-title">
						<h2>申请结算中</h2>
						<div class="ibox-tools">
							<a class="collapse-link"> <i class="fa fa-chevron-up"></i>
							</a>
						</div>
					</div>
					<div class="ibox-content">
						<table class="table table-striped table-bordered table-hover dataTables-example">
							<thead>
								<tr>
									<th>申请时间</th>
									<th>月份</th>
									<th>产生的佣金</th>
									<th>申请结算的金额</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="row" items="${requestScope.applying}">
									<tr class="gradeX">
										<td class="center"><fmt:formatDate value="${row.apply_date}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
										<td class="center">${row.the_month}</td>
										<td class="center">${row.commission}</td>
										<td class="center">${row.apply_money}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div> --%>
			</div>

		</div>

		<div class="row">
			<div class="col-lg-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h2>佣金结算历史</h2>
						<div class="ibox-tools">
								<select id="year" name="year" class="form-control">
									<option value="2016">2016</option>
									<option value="2015">2015</option>
									<option value="2014">2014</option>
								</select>
						</div>
					</div>
					<div class="ibox-content">
						<table id="tbl"
							class="table table-striped table-bordered table-hover dataTables-example">
							<thead>
								<tr>
									<th>月份</th>
									<th>产生的佣金</th>
									<th>申请佣金</th>
									<th>申请时间</th>
									<th>扣税金额</th>
									<th>汇款手续费</th>
									<th>实付金额</th>
									<th>收款人</th>
									<th>支付日期</th>
									<th>支付状态</th>
									<th>备注</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="row" items="${requestScope.applyHistory}">
									<tr class="gradeX">
										<td class="center">${row.the_date}</td>
										<td class="center">${row.commission}&nbsp;&nbsp;<a href="/settle/apply/detail/${applyInfo.user_id}/${row.the_year}/${row.the_month}">明细</a></td>
										<td class="center">${row.apply_money}</td>
										<td class="center"><fmt:formatDate value="${row.apply_date}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
										<td class="center">${row.tax_money}</td>
										<td class="center">${row.charge_money}</td>
										<td class="center">${row.pay_money}</td>
										<td class="center">${row.receiver}</td>
										<td class="center"><fmt:formatDate value="${row.pay_date}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
										<td class="center">
										<c:if test="${row.pay_state==1}">已支付
										</c:if>
										<c:if test="${row.pay_state==0}">未支付
										</c:if></td>
										<td class="center">${row.pay_note}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">
							<span>申请提现</span>
						</h4>
					</div>

					<div class="modal-body">
						<div class="modal-body">
							<form class="form-horizontal m-t" id="cash_form" action="">
								<div class="form-group">
									<label class="col-sm-4 control-label"><font
										style="color: red">*</font>请输入提现金额：</label>
									<div class="col-sm-8">
										<input id="cash" name="cash" onkeyup="value=value.replace(/[^\d]/g,'') " class="form-control" rows="4"></input>
									</div>
								</div>
								
								<div class="form-group">
									<label class="col-sm-4 control-label"><font
										style="color: red">*</font>请输入支付密码：</label>
									<div class="col-sm-8">
										<input id="pay_psw" name="pay_psw" type="password" class="form-control" rows="4"></input>
									</div>
								</div>
							</form>
							<div class="modal-footer">
								<button id="test" type="submit" class="btn btn-primary"
									onclick="saveApplyCash();">提交</button>
								<button type="button" class="btn btn-default"
									data-dismiss="modal">关闭</button>
							</div>
						</div>
					</div>

				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
	</div>


	<!-- Mainly scripts -->
	<script type="text/javascript">
		window.onload = function() {
			switchLanguage(language_flag);
			/* $('#tbl tbody').on('click', 'td', function() {
				var index = table.cell(this).cell(this).index();
				if (index.column == 2) {

				}
				if (index.column == 1) {

				}

			});

			$('#tbl tbody').on('click', 'tr', function() {
				var tr = $(this).closest('tr');
				if ($(this).hasClass('selected')) {
					$(this).removeClass('selected');
				} else {
					table.$('tr.selected').removeClass('selected');
					$(this).addClass('selected');
				}
			}); */
			var msg = "${msg}";
			if(msg){
				if(msg.status==true){
					toastr.success(msg.message);
				}else{
					toastr.warning(msg.message);
				}
				
			}
		}
		

		function saveApplyCash() {
			var cash = $("#cash").val();
			if (cash == "" || cash == null) {
				toastr.warning("请输入提现金额！");
				return false;
			}
			var limit = parseInt("${applyInfo.remain_sum}");
			if(cash>limit){
				toastr.warning("不能超过"+limit);
				return false;
			}
			if ($("#pay_psw").val() == "" || $("#pay_psw").val() == null) {
				toastr.warning("无提现密码不能操作！");
				return false;
			}
			var userId = "${applyInfo.user_id}";
			$.ajax({
				url : "/settle/apply/getCommission/"+userId,
				type : "POST",
				data : {
					cash:cash,
					pay_psw:$.md5($("#pay_psw").val())
				},
				dataType : "json",
				success : function(result) {
					if (result.statue == true) {
						toastr.success(result.message);
						window.location.reload();
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
