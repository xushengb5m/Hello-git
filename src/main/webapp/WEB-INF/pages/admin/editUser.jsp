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
<title>${requestScope.title }</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@include file="/WEB-INF/pages/common/adserveScript.jsp"%>
<script>
$(function(){
	$("#userType").val('${requestScope.cpsxUserDetail.userType}');
	var roleIdList = ${requestScope.cpsxUserDetail.roleIds};
});
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
	
	var userType = $("#userType").val();
	if(email.length<6||email.length>50){
		alert("输入的用户名必须是邮箱且在6~50字符之间！");
		return ;
	}else{
		var emailReg=/^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;		
		if(!emailReg.test(email)){
			alert("请输入正确的邮箱格式！");
			return ;
		}
	}
	
	if(password.length<4||password.length>50){
		alert("输入的密码必须在4~50字符之间！");
		return ;
	}
	
	if(userName.length<2||userName.length>20){
		alert("输入的用户名必须在2~20字符之间！");
		return ;
	}
	
	
	if(roleIdList==""){
		alert("请选择用户角色！");
		return ;
	}
	
	if(userType=="0"){
		alert("请选择用户类型");
		return;
	}
	password = hex_md5(hex_md5(password)+hex_md5(email));
	
	$.post('/admin/editUser.do', 
		{id:$("#uid").val(),email: email, password: password, userName: userName, realName:realName,accountType:accountType,
			mobTel:mobTel,fixTel:fixTel,qq:qq,address:address,zipCode:zipCode,introduction:introduction,
			roleNumbers: roleIdList, userType:userType},
	    function(data){
			if(data=="success"){
				alert("处理成功！");
				location.href="/admin/toAccountMrg.do";
			}else if(data=="email_exist"){
				alert("用户邮箱已经存在！");
				return ;
			}else if(data=="no_Privilege"){
				alert("您无权进行帐号操作！");
			}else{
				alert("处理失败！");
			}
	    }
	);
}
function userInfoForm_reset(){
	location.href="/admin/toAccountMrg.do";
}
</script>
<!--[if gte IE 9]>
	<link rel="stylesheet" href="/css/adserver/ie9.css" type="text/css" />
	<![endif]-->

<!--[if gte IE 8]>
	<link rel="stylesheet" href="/css/adserver/ie8.css" type="text/css" />
	<![endif]-->
</head>
<body style="background:none;">

			<div id="contentHeader">
				<div class="contentHeaderbor">
				<h1>账户信息</h1>
				<div id="contentHeaderBevel"></div>
				</div>
			</div> <!-- #contentHeader -->
			<div class="container">	
				<div class="grid-24 addnewid">
					<div class="widpcontent">
						<div class="widparent widparentlast">	
							<div class="num_pos"></div>
							<div class="over_pos"></div>
							<div class="widget">
								<div class="widget-header">
									<span class="icon-article"></span>
									<h3>${requestScope.title }</h3>
								</div>
								<form action="/admin/editUser.do" method="post" name="userInfoForm" class="form" style="margin-bottom:0;">
									<input type="hidden" id="uid" name="uid" value="${requestScope.cpsxUserDetail.id }<c:if test="${empty requestScope.cpsxUserDetail.id}">0</c:if>" readonly="readonly"/>
			                   		<div class="widget-content">
			                   			<div class="field-group">			
									    	<div class="field">
									    		<label for="email">邮箱</label>
												<input name="email"  autocomplete="off" type="text" class="addinp" value="${requestScope.cpsxUserDetail.email }" readonly="readonly">
									  		</div>
										</div>
										<div class="field-group">			
									  		<div class="field">
									  			<label for="password">密&nbsp;&nbsp;&nbsp;码</label>
												<input name="password" autocomplete="off" type="password" class="addinp"  value='******' placeholder="请输入密码" />
											</div>
										</div>
										<div class="field-group">	
											<div class="field">
												<label for="userName">用户名</label>
												<input name="userName" autocomplete="off" type="text" class="addinp" value="${requestScope.cpsxUserDetail.userName }">
											</div>
										</div>
										<div class="field-group">	
											<div class="field">
												<label for="realName">真实姓名</label>
												<input name="realName" autocomplete="off" type="text" class="addinp" value="${requestScope.cpsxUserDetail.realName }">
											</div>
										</div>
										<div class="field-group">	
											<div class="field">
											<label for="accountType">请选择账户类型</label>
													<select id="accountType" name="accountType" <c:if test="${!fn:contains(requestScope.cpsxUserDetail.roleIds,3)}"> readonly</c:if>>
														<option value="0" >请选择账户类型</option>
														<option value="1" <c:if test="${cpsxUserDetail.accountType eq 1 }"> selected </c:if>>公司</option>
														<option value="2" <c:if test="${cpsxUserDetail.accountType eq 2 }"> selected </c:if>>个人</option>
													</select>
											</div>
										</div>
										<div class="field-group">	
											<div class="field">
												<label for="mobTel">联系方式</label>
												<input name="mobTel" autocomplete="off" type="text" class="addinp" value="${requestScope.cpsxUserDetail.mobTel }">
											</div>
										</div>
										<div class="field-group">	
											<div class="field">
												<label for="fixTel">传真</label>
												<input name="fixTel" autocomplete="off" type="text" class="addinp" value="${requestScope.cpsxUserDetail.fixTel }">
											</div>
										</div>
										<div class="field-group">	
											<div class="field">
												<label for="qq">QQ</label>
												<input name="qq" autocomplete="off" type="text" class="addinp" value="${requestScope.cpsxUserDetail.qq }">
											</div>
										</div>
										<div class="field-group">	
											<div class="field">
												<label for="address">地址</label>
												<input name="address" autocomplete="off" type="text" class="addinp" value="${requestScope.cpsxUserDetail.address }">
											</div>
										</div>
										<div class="field-group">	
											<div class="field">
												<label for="zipCode">邮编</label>
												<input name="zipCode" autocomplete="off" type="text" class="addinp" value="${requestScope.cpsxUserDetail.zipCode }">
											</div>
										</div>
										<div class="field-group">	
											<div class="field">
												<label for="introduction">说明</label>
												<textarea name="introduction" autocomplete="off" type="text" class="addinp" value="${requestScope.cpsxUserDetail.introduction }"></textarea>
											</div>
										</div>
										<c:if test="${fn:contains(cpsx_user_login.roleIds,1)}">
										<div class="field-group">	
											<div class="field">
												 <label for="type">请选择用户类型</label>
													<select id="userType" name="userType" <c:if test="${!fn:contains(requestScope.cpsxUserDetail.roleIds,3)}"> readonly</c:if>>
														<option value="0">请选择用户类型</option>
														<option <c:if test="${cpsxUserDetail.userType eq 1 }"> selected </c:if> value="1">网站主</option>
														<option <c:if test="${cpsxUserDetail.userType eq 2 }"> selected </c:if> value="2">广告主</option>
														<option <c:if test="${cpsxUserDetail.userType eq 3 }"></c:if> value="3">管理员</option>
														<option <c:if test="${cpsxUserDetail.userType eq 4 }"> selected </c:if> value="4">运营</option>
														<option <c:if test="${cpsxUserDetail.userType eq 5 }"> selected </c:if> value="5">客户经理</option>
													</select>
											</div>
										</div>
										</c:if>
										
										<div class="field-group">
											<c:if test="${fn:contains(cpsx_user_login.roleIds,1) }">
												<div class="field">
													<label for="roleId">角&nbsp;&nbsp;&nbsp;色</label>
													<c:forEach items="${roles}" var="role">
													<input name="roleId" type="checkbox" value="${role.id}" <c:if test="${fn:contains(requestScope.cpsxUserDetail.roleIds,role.id)}">checked</c:if>>${role.remark}&nbsp;&nbsp;&nbsp;
													</c:forEach>
												</div>	
											</c:if>
										</div>
								</div>
							</form>
						</div> <!-- .grid -->
						<div class="actions">
							<a href="javascript:void(0);" class="btn btn-quaternary btn-large" onclick="saveUser()">${requestScope.btnLetter }</a>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="javascript:void(0);" class="btn btn-export btn-large" onclick="userInfoForm_reset()">取消</a>
						</div>
					</div>
				</div>
			</div> <!-- .container -->
		</div>

</body><script type="text/javascript" src="/js/common/footerjs.js"></script>
</html>