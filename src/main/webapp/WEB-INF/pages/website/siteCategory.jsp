<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-站点管理</title>
<script type="text/javascript">
function addWebSite(){
	$("#ua_form").form('clear');
	$("#flag").val("add");
	$('#uaModal').modal('show');
}

function editWebSite(obj){
	var row = table.row(obj.parentNode.parentNode).data();
	console.info(row)
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
function deleteWebSite(rowId){
	if(!confirm("确定删除?")) {
		return;
	}
	$.ajax({
		url : "/web/cat/deleteSiteCategory.do",
		type : "POST",
		data : {rowId:rowId},
		dataType : "json",
		success : function(result) {
			$('#eaModal').modal('hide');
			toastr.success(result.message);
			window.location.reload();
		},
		error : function(xhr, type, errorThrown) {
			toastr.error('提交失败: ' + errorThrown);
		}
	});
	
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
							站点类目列表
						</h2>
						<div class="ibox-tools">
							<a href="javascript:void(0)" onclick="addWebSite()" class="btn btn-primary"><i class="fa fa-plus"></i>新增站点类目</a>
						</div>
					</div>
					<div class="ibox-content">
						<table id="tbl"
							class="table table-striped table-bordered table-hover dataTables-example">
							<thead>
								<tr>
									<th>编号</th>
									<th>类目名称</th>
									<th>类目描述</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="row" items="${requestScope.rows}">
									<tr class="gradeX">
										<td class="center">${row.id}</td>
										<td class="center">${row.name}</td>
										<td class="center">${row.note}</td>
										<td class="center">
										<a href="javascrip:void(0)" onclick="editWebSite(this)"><button class="btn btn-success btn-sm" type="button">
												<i class="fa fa-pencil"></i>
											</button></a>
										<a href="javascrip:void(0)" onclick="deleteWebSite(${row.id})"><button class="btn btn-success btn-sm" type="button">
												<i class="fa fa-trash-o"></i>
										</button></a>
										</td>
									</tr> 
								</c:forEach>
							</tbody>
							<tfoot>
								<!-- <tr>
									<th>渲染引擎</th>
									<th>浏览器</th>
									<th>平台</th>
									<th>引擎版本</th>
									<th>CSS等级</th>
								</tr> -->
							</tfoot>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!-- 按钮触发模态框 -->

	<!-- UrlAccount模态框（Modal） -->
	<div class="modal fade" id="uaModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">
						<span>新增站点类目</span>
					</h4>
				</div>

				<div class="modal-body">
					<div class="modal-body">
						<form class="form-horizontal m-t" id="ua_form"
							action="">
							<input id="ua_id" name="id" type="hidden"/>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="website_category_name_id_span"></span>：</label>
								<div class="col-sm-8">
									 <input id="name" name="name" class="form-control" rows="4"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="website_category_desc_id_span"></span>：</label>
								<div class="col-sm-8">
									<input id="note" name="note" class="form-control"  rows="4"></input>
								</div>
							</div>
							<input id="flag" name="flag" type="hidden" />
						</form>
						<div class="modal-footer">
							<button id="test" type="submit" class="btn btn-primary" onclick="saveWebSite();">提交</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						</div>
					</div>
				</div>
				
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
</div>

<!-- Mainly scripts -->
<script type="text/javascript">
		var table = $('#tbl').DataTable();
		window.onload = function() {
			$('.dataTables-example').dataTable();
			switchLanguage(language_flag);
		}
		
		function saveWebSite() {
			if($("#name").val()=="" || $("#name").val()==null){
				toastr.warning("类目名称不能为空！");
				return false;
			}
			if($("#note").val()=="" || $("#note").val()==null){
				toastr.warning("类目描述不能为空！");
				return false;
			}
			var params = $("#ua_form").serializeToJson();
			var a = $("#is_default").prop("checked");
			var b = $("input[name=type]:checked")[0];
			params.is_enable=(a==true?"1":"0");
			$.ajax({
				url : "/web/cat/saveSiteCategory.do",
				type : "POST",
				data : params,
				dataType : "json",
				success : function(result) {
					$('#eaModal').modal('hide');
					toastr.success(result.message);
					window.location.reload();
				},
				error : function(xhr, type, errorThrown) {
					toastr.error('提交失败: ' + errorThrown);
				}
			});
		}

	</script>

	<script src="/js/footer.js"></script>
</body>
</html>
