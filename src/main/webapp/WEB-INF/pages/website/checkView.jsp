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
						<h2>审核站点</h2>
						<div class="ibox-tools">
						</div>
					</div>
					<div class="ibox-content">
						<table id="tbl"
							class="table table-striped table-bordered table-hover dataTables-example">
							<tr class="gradeX">
								<td width="20%">网站名称</td>
								<td>${data.name}</td>
							</tr>
							<tr class="gradeX">
								<td width="20%">URL</td>
								<td>${data.url}</td>
							</tr>
							<tr class="gradeX">
								<td width="20%">网站应用类型</td>
								<td>${data.app_type==1?'PC':'APP'}</td>
							</tr>
							<tr class="gradeX">
								<td width="20%">网站类型</td>
								<td>${data.type}</td>
							</tr>
							<tr class="gradeX">
								<td width="20%">验证方式</td>
								<td>${data.verification_mode==1?'自动验证':'手动验证'}</td>
							</tr>
							<tr class="gradeX">
								<td width="20%">日访问量</td>
								<td>${data.ip_per_day}</td>
							</tr>
							<tr class="gradeX">
								<td width="20%">网站简介</td>
								<td>${data.about}</td>
							</tr>
							<tr class="gradeX">
								<td width="20%">网站备案信息</td>
								<td>${data.record_info}</td>
							</tr>
							<tr class="gradeX">
								<td width="20%">是否当前默认网站</td>
								<td>${data.is_default}</td>
							</tr>
						</table>
					</div>
					<div class="ibox-content">
					<form class="form-horizontal m-t" id="check_form"
							action="">
						<input id="rid" name="rid" type="hidden" value="${data.id}">
						<table id="tbl"
							class="table table-striped table-bordered table-hover dataTables-example">
							<tr class="gradeX">
								<td width="20%">验证状态</td>
								<td>
									<label class="checkbox-inline">
									<input type="radio"
										name="validate" id="t" <c:if test="${data.verification_status==1}">checked="checked"</c:if>  value="1"> 
										验证中
									</label> 
									<label class="checkbox-inline">
									<input type="radio"
										name="validate" id="ta" <c:if test="${data.verification_status==2}">checked="checked"</c:if> value="2"> 
										验证未通过
									</label> <label class="checkbox-inline">
									<input type="radio"
										name="validate" id="tb" <c:if test="${data.verification_status==3}">checked="checked"</c:if> value="3">
										验证通过
									</label>
								</td>
							</tr>
							<tr class="gradeX">
								<td width="20%">审核状态</td>
								<td>
									<label class="checkbox-inline">
									<input type="radio"
										name="check" id="s" <c:if test="${data.approval_status==1}">checked="checked"</c:if> value="1"> 
										审核中
									</label> 
									<label class="checkbox-inline">
									<input type="radio"
										name="check" id="sa" <c:if test="${data.approval_status==2}">checked="checked"</c:if> value="2"> 
										审核未通过
									</label> <label class="checkbox-inline">
									<input type="radio"
										name="check" id="sb" <c:if test="${data.approval_status==3}">checked="checked"</c:if> value="3">
										审核通过
									</label>
								</td>
							</tr>
						</table>
						</form>
					</div>
				</div>
			</div>
			</div>
		<div>
		<div class="text-center">
			<button class="btn btn-primary" onclick="validateWebsite()">提交审核</button>
			<button class="btn btn-primary" onclick="history.back()">返回</button>
		</div>
 </div>
 </div>
		
	<script type="text/javascript">
		function validateWebsite(){
			$("#check_form").attr("action","/web/check/checkWebsite.do").submit();
		}
	</script>
	<script src="/js/footer.js"></script>
</body>
</html>
