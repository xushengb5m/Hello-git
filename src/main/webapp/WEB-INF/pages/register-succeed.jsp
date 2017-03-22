<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../pages/common.jsp"%>
	
<html>
<head>
</head>
<body class="gray-bg">

    <div class="middle-box text-center animated fadeInDown">
        <h2>Register Succeed</h2>
        <h3 class="font-bold">恭喜你 注册成功！</h3>

        <div class="error-desc">
            	3秒后为您跳转至主页
            <br/><a href="/" class="btn btn-primary m-t">主页</a>
        </div>
    </div>

</body>

<script type="text/javascript">

	
	window.onload = function() {

		setInterval(function() {
			window.location.href = "/"; 
		}, 3000);

		
	}
</script>

</html>