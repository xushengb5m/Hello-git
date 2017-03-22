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
							站点汇总
						</h2>
						<div class="ibox-tools">
						</div>
					</div>
					<div class="ibox-content">
						<table id="tbl"
							class="table table-striped table-bordered table-hover dataTables-example">
							<thead>
								<tr>
									<th>编号</th>
									<th>所属网站主</th>
									<th>网站名称</th>
									<th>网站域名</th>
									<th>网站应用类型</th>
									<th>网站类型</th>
									<th>验证方式</th>
									<th>日访问量</th>
									<th>网站简介</th>
									<th>网站备案信息</th>
									<th>验证状态</th>
									<th>审核状态</th>
									<th>是否默认</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="row" items="${requestScope.rows}">
									<tr class="gradeX">
										<td class="center">${row.id}</td>
										<td class="center">${row.supply_id}</td>
										<td class="center">${row.name}</td>
										<td class="center">${row.url}</td>
										<td class="center">
											<c:if test="${row.app_type==1}">
												PC
											</c:if>
											<c:if test="${row.app_type==2}">
												APP
											</c:if>
										</td>
										<td class="center">${row.typeName}</td>
										<td class="center">
											<c:if test="${row.verification_mode==1}">
												自动验证
											</c:if>
											<c:if test="${row.verification_mode==2}">
												手动验证
											</c:if>
										</td>
										<td class="center">${row.ip_per_day}</td>
										<td class="center" width="15%">${row.about}</td>
										<td class="center" width="15%">${row.record_info}</td>
										
										<td class="center">
											<c:if test="${row.verification_status==1}">
												验证中
											</c:if>
											<c:if test="${row.verification_status==2}">
												验证未通过
											</c:if>
											<c:if test="${row.verification_status==3}">
												验证通过
											</c:if>
										</td>
										<td class="center">
											<c:if test="${row.approval_status==1}">
												审核中
											</c:if>
											<c:if test="${row.approval_status==2}">
												审核未通过
											</c:if>
											<c:if test="${row.approval_status==3}">
												审核通过
											</c:if>
										</td>
										<td class="center">
										<c:if test="${row.is_default=='true' }">
											<button class="btn btn-info btn-circle btn-xs" type="button">
												<i class="fa fa-check"></i>
											</button>
										</c:if>
										<c:if test="${row.is_default=='false' }">
											<button class="btn btn-warning btn-circle btn-xs"
												type="button">
												<i class="fa fa-times"></i>
											</button>
										</c:if>
										</td>
										<td class="center">
											<a href="/web/check/checkWebsiteView.do?wid=${row.id}"><button class="btn btn-success btn-sm" type="button">
												点击审核
											</button></a>
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
