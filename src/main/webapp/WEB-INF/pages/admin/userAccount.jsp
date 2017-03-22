<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="pg" uri="http://jsptags.com/tags/navigation/pager" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js ie7 oldie" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js ie8 oldie" lang="en"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="en">
<!--<![endif]-->
<head>
<title>${requestScope.title}</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@include file="/WEB-INF/pages/common.jsp"%>
<script>
function saveUser(){
	var email=$.trim($("input[name='email']").val());
	var password=$.trim($("input[name='password']").val());
	var confirmPossword = $.trim($("input[name='password_confirm']").val());
	var userName=$.trim($("input[name='userName']").val());
	var realName=$.trim($("input[name='realName']").val());
	var accountType=$.trim($("#accountType").val());
	var mobTel=$.trim($("input[name='mobTel']").val());
	var fixTel=$.trim($("input[name='fixTel']").val());
	var qq=$.trim($("input[name='qq']").val());
	var address=$.trim($("input[name='address']").val());
	var zipCode=$.trim($("input[name='zipCode']").val());
	var introduction=$.trim($("input[name='introduction']").val());
	var roleIdList="";
	$("input:checkbox[name='roleId']:checked").each(function() {
		roleIdList += $(this).val() + ",";
	});
	var userType = $("input[name='userType']").val();
	if(email.length<6||email.length>50){
		toastr.warning("请输入账户邮箱且在6~50字符之间！");
		return ;
	}else{
		var emailReg=/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;		
		if(!emailReg.test(email)){
			toastr.warning("请输入正确的邮箱格式！");
			return ;
		}
	}
	if(userName==null || userName==""){
		toastr.warning("请输入用户名！");
		return ;
	}
	if(password.length<4||password.length>50){
		toastr.warning("输入的密码必须在4~50字符之间！");
		return ;
	}else if(password != confirmPossword){
		toastr.warning("两次密码输入不一致请重新输入");
		return;
	}

	if(userName.length<2||userName.length>20){
		toastr.warning("输入的用户名必须在2~20字符之间！");
		return ;
	}
	if(userType == "0"){
		toastr.warning("请选择用户类型");
		return
	}
	if(password!="******"){
		password = $.md5($.md5($("#password").val()) + $.md5($("#email").val()));
	}
	$.post('/cpsx/editUserAccount.do', 
			{id:$("#uid").val(),email: email, password: password, userName: userName, realName:realName,accountType:accountType,
				mobTel:mobTel,fixTel:fixTel,qq:qq,address:address,zipCode:zipCode,introduction:introduction,
				roleNumbers: roleIdList, userType:userType},
		    function(data){
				if(data=="success"){
					toastr.success('处理成功！');
				}else{
					toastr.error("处理失败！");
					return;
				}
		    }
	);
}
</script>
</head>
<body style="background:none;">

<div id="page-wrapper" class="gray-bg">
 <div class="wrapper wrapper-content animated fadeInRight">
          <div class="wrapper wrapper-content">
				<div class="container">
					<div class="row">
						<div class="col-lg-8 animated fadeInRight">
                           			<input id="uid" name="uid" type="hidden" value="${loginUser.id}">
			                   		<div class="form-group">			
									    	<div class="col-sm-8">
									    		<label for="email">账户邮箱(邮箱地址)</label>
												<input id="email"  name="email"  class="form-control" readonly="readonly" value="${loginUser.email}">
									  		</div>
									</div>
									
			                   		<div class="form-group">			
									    	<div class="col-sm-8">
									    		<label for="userName">用户名</label>
												<input id="userName"  name="userName"  class="form-control" value="${loginUser.userName}">
									  		</div>
									</div>
										
                                    <div class="form-group">
                                        <label class="col-sm-8">密码：</label>
                                        <div class="col-sm-8">
                                            <input id="password" name="password" class="form-control" type="password" value="******">
                                        </div>
                                    </div>
                                    
                                    <div class="form-group">
                                        <label class="col-sm-8">确认密码：</label>
                                        <div class="col-sm-8">
                                            <input id="password_confirm" name="password_confirm" class="form-control" type="password" value="******">
                                        </div>
                                    </div>
                                    
                                    <div class="form-group">	
											<div class="col-sm-8">
												<label for="realName">真实姓名</label>
												<input id="realName" name="realName" class="form-control" value="${loginUser.realName}">
											</div>
									</div>
									
                                    <div class="form-group">
											<div class="col-sm-8">
													<label for="realName">账户类型</label>
													<select id="accountType" name="accountType" class="form-control">
														<option value="0">请选择账户类型</option>
														<option <c:if test="${loginUser.accountType eq 1 }"> selected </c:if> value="1">公司</option>
														<option <c:if test="${loginUser.accountType eq 2 }"> selected </c:if> value="2">个人</option>
													</select>
											</div>
                                    </div>
                                    
                                    <div class="form-group">	
											<div class="col-sm-8">
												<label for="mobTel">联系方式</label>
												<input id="mobTel" name="mobTel" class="form-control" value="${loginUser.mobTel}">
											</div>
									</div>
										
									<div class="form-group">	
											<div class="col-sm-8">
												<label for="fixTel">传真</label>
												<input id="fixTel" name="fixTel" class="form-control" value="${loginUser.fixTel}">
											</div>
									</div>
									
									<div class="form-group">	
											<div class="col-sm-8">
												<label for="qq">QQ</label>
												<input id="qq" name="qq" class="form-control" value="${loginUser.qq}">
											</div>
									</div>
									
									<div class="form-group">	
											<div class="col-sm-8">
												<label for="address">地址</label>
												<input id="address" name="address" class="form-control" value="${loginUser.address}">
											</div>
									</div>
									
										
									<div class="form-group">	
											<div class="col-sm-8">
												<label for="zipCode">邮编</label>
												<input id="zipCode" name="zipCode" class="form-control" value="${loginUser.zipCode}">
											</div>
									</div>
									
									<div class="form-group">	
											<div class="col-sm-8">
												<label for="introduction">说明</label>
												<textarea id="introduction" name="introduction" class="form-control" value="${loginUser.introduction}"></textarea>
											</div>
									</div>
										
                                    <div class="form-group">
                                        <div class="col-sm-8 col-sm-offset-3">
                                            <button class="btn btn-primary" onclick="saveUser()">修改</button>
                                        </div>
                                    </div>
                            </div>
				</div>
				</div>
			</div>
		</div>
		</div>

</body><script type="text/javascript" src="/js/common/footerjs.js"></script>
</html>