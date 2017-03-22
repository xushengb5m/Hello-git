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
	function editPayPsw() {
		var id = $("#idEdit").val();
		var email = $("#emailEdit").val();
		$.ajax({
			url : "/settle/apply/payPassword/" + id,
			type : "POST",
			data : {
				id:id,
				email:email,
				pay_psw:$.md5($("#pay_psw").val()),
				login_psw:$.md5($.md5($("#login_psw").val())+$.md5(email))
			},
			success : function(data) {
				alert(data.message);
				if(data.statue==true){
					window.location.href="/settle/apply/commission";
				}
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
							<div class="col-lg-2">
							</div>
							<div class="col-lg-8 animated fadeInRight">
								<div class="ibox-content">
									<form class="form-horizontal m-t bv-form" id="psw_form">
										<input type="hidden" id="idEdit" value="${userInfo.id}">
										<input type="hidden" id="emailEdit" value="${userInfo.email}">
										<div class="form-group">
											<label class="col-sm-4 control-label"><font
												style="color: red">*</font>提现密码：</label>
											<div class="col-sm-8">
												<input id="pay_psw" name="pay_psw" class="form-control" type="password">
											</div>
										</div>

										<div class="form-group">
											<label class="col-sm-4 control-label"><font
												style="color: red">*</font>确认提现密码：</label>
											<div class="col-sm-8">
												<input id="confirm_pay_psw" name="confirm_pay_psw" type="password" class="form-control">
											</div>
										</div>

										<div class="form-group">
											<label class="col-sm-4 control-label"><font
												style="color: red">*</font>登录密码：</label>
											<div class="col-sm-8">
												<input id="login_psw" name="login_psw" class="form-control" type="password">
											</div>
										</div>
									</form>
									<div>
										<div align="center">
											<button class="btn btn-success" onclick="editPayPsw()">完成设置</button>
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

			$('#psw_form').bootstrapValidator(
					{
						message : '该值无效',
						feedbackIcons : {
							valid : 'fa fa-check',
							invalid : 'fa fa-times',
							validating : 'fa fa-refresh'
						},
						fields : {
							pay_psw : {
								message : 'The pay_psw is not valid',
								validators : {
									notEmpty : {
										message : 'The pay_psw is required and cannot be empty'
									}
								},
								stringLength : {
									min : 5,
									max : 18,
									message : '密码长度必须在5~18之间'
								},
								identical : {
									field : 'confirm_pay_psw',
									message : '前后密码不一致'
								}
							},
							confirm_pay_psw : {
								message : 'The confirm_pay_psw is not valid',
								validators : {
									notEmpty : {
										message : 'The confirm_pay_psw is required and cannot be empty'
									},
									stringLength : {
										min : 5,
										max : 18,
										message : '确认密码长度必须在5~18之间'
									},
									identical : {
										field : 'pay_psw',
										message : '前后密码不一致'
									}
								}
							},
							login_psw : {
								message : 'The login_psw is not valid',
								validators : {
									notEmpty : {
										message : 'The login_psw is required and cannot be empty'
									}
								}
							}
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

	<script src="/js/footer.js"></script>
</body>
</html>
