<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-支付账户信息</title>
<link
	href="<%=basePath%>/css/plugins/bootstrapvalidator/bootstrapValidator.min.css"
	rel="stylesheet">
<script
	src="<%=basePath%>/js/plugins/bootstrapvalidator/bootstrapValidator.min.js"></script>
<meta name="keywords"
	content="帮5买CPS联盟,帮5买,CPS,海淘,联盟,海淘联盟,B5M,Union,CPS Union">
<meta name="description" content="帮5买CPS联盟">
<script type="text/javascript">
	function editBankInfo() {
		var id = $("#idEdit").val();
		$.ajax({
			url : "/settle/apply/payAccount/" + id,
			type : "POST",
			data : $("#bank_form").serializeToJson(),
			success : function(data) {
				alert(data.message);
				window.location.href="/settle/apply/commission";
			},
			error : function(xhr, type, errorThrown) {
				toastr.error('Failure: ' + errorThrown);
			}
		});
	}

	function editAlipay() {
		var id = $("#idEdit").val();
		$.ajax({
			url : "/settle/apply/payAccount/" + id,
			type : "POST",
			data : $("#alipay_form").serializeToJson(),
			success : function(data) {
				alert(data.message);
				window.location.href="/settle/apply/commission";
			},
			error : function(xhr, type, errorThrown) {
				toastr.error('Failure: ' + errorThrown);
			}
		});
	}
</script>
</head>

<body>
	<div class="wrapper wrapper-content">
		<div class="container">
			<div class="row">
				<div class="panel-options">
					<ul class="nav nav-tabs">
						<li class="active"><a data-toggle="tab" href="#tab-1">银行卡</a></li>
						<li class=""><a data-toggle="tab" href="#tab-2">支付宝</a></li>
					</ul>
				</div>

				<div class="panel-body">
					<div class="tab-content">
						<input type="hidden" id="idEdit" value="${user_id}">
						<div id="tab-1" class="tab-pane active">
							<div class="col-lg-2"></div>
							<div class="col-lg-8 animated fadeInRight">
								<div class="ibox-content">
									<form class="form-horizontal m-t bv-form" id="bank_form">
										<div class="form-group">
											<label class="col-sm-4 control-label"><font
												style="color: red">*</font>银行名称：</label>
											<div class="col-sm-8">
												<input id="bank_name" name="bank_name" class="form-control"
													value="${payAccount.bank_name}">
											</div>
										</div>

										<div class="form-group">
											<label class="col-sm-4 control-label"><font
												style="color: red">*</font>银行开户地址：</label>
											<div class="col-sm-8">
												<input id="bank_address" name="bank_address"
													class="form-control" value="${payAccount.bank_address}">
											</div>
										</div>

										<div class="form-group">
											<label class="col-sm-4 control-label"><font
												style="color: red">*</font>银行账号：</label>
											<div class="col-sm-8">
												<input id="bank_account" name="bank_account"
													class="form-control" value="${payAccount.bank_account}">
											</div>
										</div>

										<div class="form-group">
											<label class="col-sm-4 control-label"><font
												style="color: red">*</font>收款人：</label>
											<div class="col-sm-8">
												<input id="register_name" name="register_name" class="form-control"
													value="${payAccount.register_name}">
											</div>
										</div>

										<div class="form-group">
											<label class="col-sm-4 control-label"><font
												style="color: red">*</font>绑定的手机号：</label>
											<div class="col-sm-8">
												<input id="bank_tel_no" name="bank_tel_no"
													class="form-control" value="${payAccount.bank_tel_no}">
											</div>
										</div>

										<div class="form-group">
											<label class="col-sm-4 control-label"><font
												style="color: red">*</font>身份证号：</label>
											<div class="col-sm-8">
												<input id="identify_no" name="identify_no"
													class="form-control" type="text"
													value="${payAccount.identify_no}">
											</div>
										</div>
									</form>
									<div>
										<div align="center">
											<button class="btn btn-success" onclick="editBankInfo()">提交账户</button>
										</div>
									</div>
								</div>
							</div>
						</div>

						<div id="tab-2" class="tab-pane">
							<div class="col-lg-2"></div>
							<div class="col-lg-8 animated fadeInRight">
								<div class="ibox-content">
									<form class="form-horizontal m-t bv-form" id="alipay_form">
										<div class="form-group">
											<label class="col-sm-4 control-label"><font
												style="color: red">*</font>支付宝账户：</label>
											<div class="col-sm-8">
												<input id="alipay_account" name="alipay_account"
													class="form-control" value="${payAccount.alipay_account}">
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-4 control-label"><font
												style="color: red">*</font>支付宝昵称：</label>
											<div class="col-sm-8">
												<input id="alipay_name" name="alipay_name"
													class="form-control" value="${payAccount.alipay_name}">
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-4 control-label"><font
												style="color: red">*</font>绑定的手机号：</label>
											<div class="col-sm-8">
												<input id="alipay_tel_no" name="alipay_tel_no"
													class="form-control" value="${payAccount.alipay_tel_no}">
											</div>
										</div>

										<div class="form-group">
											<label class="col-sm-4 control-label"><font
												style="color: red">*</font>身份证号：</label>
											<div class="col-sm-8">
												<input id="identify_no" name="identify_no"
													class="form-control" type="text"
													value="${payAccount.identify_no}">
											</div>
										</div>
										<div class="form-group">
											<div align="center">
												<button class="btn btn-success" type="submit"
													onclick="editAlipay()">提交账户</button>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		
	</div>

	<!-- Mainly scripts -->
	<script type="text/javascript">
		window.onload = function() {
			switchLanguage(language_flag);

			$('#bank_form').bootstrapValidator(
							{
								message : '该值无效',
								feedbackIcons : {
									valid : 'fa fa-check',
									invalid : 'fa fa-times',
									validating : 'fa fa-refresh'
								},
								fields : {
									bank_name : {
										message : 'The bank_name is not valid',
										validators : {
											notEmpty : {
												message : 'The bank_name is required and cannot be empty'
											}
										}
									},
									bank_address : {
										message : 'The bank_address is not valid',
										validators : {
											notEmpty : {
												message : 'The bank_address is required and cannot be empty'
											}
										}
									},
									bank_account : {
										message : 'The bank_account is not valid',
										validators : {
											notEmpty : {
												message : 'The bank_account is required and cannot be empty'
											},
											stringLength : {
												min : 16,
												max : 19,
												message : 'bank_account must be more than 16 and less than 19 characters long'
											},
											regexp : {
												regexp : /^[0-9]+$/,
												message : 'The bank_account can only consist of numbers'
											}
										}
									},
									register_name:{
										message : 'The register_name is not valid',
										validators : {
											notEmpty : {
												message : 'The register_name is required and cannot be empty'
											}
										}
									},
									bank_tel_no : {
										validators : {
											notEmpty : {
												message : 'The mobile phone is required and cannot be empty'
											},
											stringLength : {
												min : 8,
												max : 15,
												message : 'The mobile phone must be more than 8 and less than 15 characters long'
											},
											regexp : {
												regexp : /^[0-9]+$/,
												message : 'The mobile phone can only consist of numbers'
											}
										}
									},
									identify_no : {
										message : 'The identify_no is not valid',
										validators : {
											notEmpty : {
												message : 'The identify_no is required and cannot be empty'
											},
											stringLength : {
												min : 18,
												max : 18,
												message : 'The identify_no must be 18 characters long'
											}
										}
									},
								}
							}).on('success.field.fv', function(e, data) {
						if (data.fv.getInvalidFields().length > 0) {
							//There is invalid Field
							data.fv.disableSubmitButtons(true);
						}
					}).on('success.form.bv', function(e, data) {
						//Prevent From Submission
						//e.printDefault();
						var $form = $(e.target);
						//You can get the form instance
						var fv = $form.data('formValidation');
						//Do whatever you want here...
					});
			
			$('#alipay_form').bootstrapValidator(
					{
						message : '该值无效',
						feedbackIcons : {
							valid : 'fa fa-check',
							invalid : 'fa fa-times',
							validating : 'fa fa-refresh'
						},
						fields : {
							alipay_account : {
								message : 'The alipay_account is not valid',
								validators : {
									notEmpty : {
										message : 'The alipay_account is required and cannot be empty'
									}
								}
							},
							alipay_name : {
								message : 'The alipay_name is not valid',
								validators : {
									notEmpty : {
										message : 'The alipay_name is required and cannot be empty'
									}
								}
							},
							alipay_tel_no : {
								validators : {
									notEmpty : {
										message : 'The mobile phone is required and cannot be empty'
									},
									stringLength : {
										min : 8,
										max : 15,
										message : 'The mobile phone must be more than 8 and less than 15 characters long'
									},
									regexp : {
										regexp : /^[0-9]+$/,
										message : 'The mobile phone can only consist of numbers'
									}
								}
							},
							identify_no : {
								message : 'The identify_no is not valid',
								validators : {
									notEmpty : {
										message : 'The identify_no is required and cannot be empty'
									},
									stringLength : {
										min : 18,
										max : 18,
										message : 'The identify_no must be 18 characters long'
									}
								}
							},
						}
					}).on('success.field.fv', function(e, data) {
				if (data.fv.getInvalidFields().length > 0) {
					//There is invalid Field
					data.fv.disableSubmitButtons(true);
				}
			}).on('success.form.bv', function(e, data) {
				//Prevent From Submission
				//e.printDefault();
				var $form = $(e.target);
				//You can get the form instance
				var fv = $form.data('formValidation');
				//Do whatever you want here...
			});
		}
	</script>

	<script src="<%=basePath%>/js/footer.js"></script>
</body>
</html>
