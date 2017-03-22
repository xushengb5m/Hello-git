<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../pages/common.jsp"%>	

<html>
<head>
</head>
<body class="gray-bg">


    <div class="middle-box text-center animated fadeInDown">
        <h1>Register Failed</h1>
        <h3 class="font-bold">Sorry！注册好像出了点问题</h3>

        <div class="error-desc">
            	请联系管理员...
            <br/>您可以返回主页看看，5秒后为您跳转至主页
            <br/><a href="/" class="btn btn-warning m-t">主页</a>
        </div>
    </div>

</body>

<script type="text/javascript">

	
	window.onload = function() {

		setInterval(function() {
			window.location.href = "/"; 
		}, 5000);

		
	}
</script>

</html>