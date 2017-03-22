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
								<li class="active"><a data-toggle="tab" href="#tab-1">网站主信息</a></li>
								<li class=""><a data-toggle="tab" href="#tab-2">银行卡</a></li>
								<li class=""><a data-toggle="tab" href="#tab-3">支付宝</a></li>
							</ul>
						</div>
		
						<div class="panel-body">
							<div class="tab-content">
								<div id="tab-1" class="tab-pane active">
									<div class="col-sm-6">
										<div class="jumbotron">
											<p align="center">用户ID:${payInfo.user_id}</p>
											<p align="center">身份证:${payInfo.identify_no}</p>
											<p align="center">绑定手机号:${payInfo.alipay_tel_no}</p>
										</div>
									</div>
								</div>
								
								<div id="tab-2" class="tab-pane">
									<div class="col-sm-6">
										<div class="jumbotron">
											<p align="center">银行名称:${payInfo.bank_name}</p>
											<p align="center">银行开户地址:${payInfo.bank_address}</p>
											<p align="center">银行账户:${payInfo.bank_account}</p>
											<p align="center">收款人:${payInfo.register_name}</p>
											<p align="center">绑定手机号:${payInfo.bank_tel_no}</p>
										</div>
									</div>
								</div>
								
								<div id="tab-3" class="tab-pane">
									<div class="col-sm-6">
										<div class="jumbotron">
											<p align="center">支付宝昵称:${payInfo.alipay_name}</p>
											<p align="center">支付宝账户:${payInfo.alipay_account}</p>
											<p align="center">绑定手机号:${payInfo.alipay_tel_no}</p>
										</div>
									</div>
								</div>
							</div>
						</div>
						</div>
					</div>

					<div class="ibox-content">
						<form class="form-horizontal m-t" id="check_form" action="">
							<table id="tbl" class="table table-striped table-bordered table-hover dataTables-example">
								<tr class="gradeX">
									<td width="20%">申请时间</td>
									<td><fmt:formatDate value="${payInfo.apply_date}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
								</tr>
								<tr class="gradeX">
									<td width="20%">年月</td>
									<td>${payInfo.the_year}-${payInfo.the_month}</td>
								</tr>
								<tr class="gradeX">
									<td width="20%">产生的佣金</td>
									<td>${payInfo.commission}</td>
								</tr>
								<tr class="gradeX">
									<td width="20%">申请金额</td>
									<td>${payInfo.apply_money}</td>
								</tr>
								<tr class="gradeX">
									<td width="20%">支付扣税</td>
									<td><input id="tax_money" name="tax_money" class="form-control" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"></td>
								</tr>
								<tr class="gradeX">
									<td width="20%">汇款手续费</td>
									<td><input id="charge_money" name="charge_money" class="form-control" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"></td>
								</tr>
								<tr class="gradeX">
									<td width="20%">实际支付</td>
									<td><input id="pay_money" name="pay_money" class="form-control" onkeyup="value=value.replace(/[^\d{1,}\.\d{1,}|\d{1,}]/g,'')"></td>
								</tr>
								<tr class="gradeX">
									<td width="20%">收款人</td>
									<td><input id="receiver" name="receiver" class="form-control"></td>
								</tr>
								<tr class="gradeX">
									<td width="20%">说明</td>
									<td width="50%"><input id="note" name="note" value="${payInfo.note }" class="form-control"></td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div>
			<div class="text-center">
				<button class="btn btn-primary" onclick="completePay()">完成支付</button>
				<button class="btn btn-primary" onclick="failPay()">通知用户</button>
				<button class="btn btn-primary" onclick="history.back()">返回</button>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		function completePay() {
			var pay_money = $("#pay_money").val();
			if(pay_money==null || pay_money==""){
				toastr.warning("请输入实际支付金额！");
				return false;
			}
			var id = "${payInfo.user_id}";
			$.ajax({
				url : "/settle/pay/payCommission/${payInfo.user_id}/${payInfo.the_year}/${payInfo.the_month}",
				type : "POST",
				data : {
					tax_money:$("#tax_money").val(),
					charge_money:$("#charge_money").val(),
					pay_money:$("#pay_money").val(),
					receiver:$("#receiver").val(),
					pay_state:1,
					note:$("#note").val()
				},
				dataType : "json",
				success : function(result) {
					if (result.statue == true) {
						toastr.success(result.message);
						window.location.href="/settle/pay/payCommission";
					} else {
						toastr.warning(result.message);
					}
				},
				error : function(xhr, type, errorThrown) {
					toastr.warning('提交失败: ' + errorThrown);
				}
			});
			
		}
		
		function failPay() {
			$.ajax({
				url : "/settle/pay/payCommission/${payInfo.user_id}/${payInfo.the_year}/${payInfo.the_month}",
				type : "POST",
				data : {
					pay_state:0,
					note:$("#note").val()
				},
				dataType : "json",
				success : function(result) {
					if (result.statue == true) {
						toastr.success(result.message);
						window.location.href="/settle/pay/payCommission";
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
