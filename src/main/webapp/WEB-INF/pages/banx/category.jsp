<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-活动类型</title>
</head>

<style>
</style>

<body>

	<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-lg-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h2>
							 <strong>活动类型</strong>
						</h2>
						<div class="ibox-tools">
							<!-- <a class="collapse-link"> <i class="fa fa-chevron-up"></i>
							</a> <a class="dropdown-toggle" data-toggle="dropdown"
								href="table_data_tables.html#"> <i class="fa fa-wrench"></i>
							</a>
							<a class="close-link"> <i class="fa fa-times"></i>
							</a> -->
							<!-- 按钮触发模态框 -->
							<button class="btn btn-primary" data-toggle="modal"
								data-target="#myModal"><i class="fa fa-plus"></i>&nbsp;添加活动类型</button>
						</div>
					</div>
					<div class="ibox-content">

						<table
							class="table table-striped table-bordered table-hover dataTables-example">
							<thead>
								<tr>
									<th>活动类型名称</th>
									<th>活动类型描述</th>
									<th>创建时间</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="row" items="${requestScope.rows}">
									<tr class="gradeX">
										<td class="center">${row.name}</td>
										<td class="center">${row.note}</td>
										<td class="center"><fmt:formatDate value="${row.create_time}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
										<td class="center">&nbsp;&nbsp;&nbsp;<a href="javaScript:void(0);" onclick="editModal(${row.id});"><i class="fa fa-pencil"></i></a></td>
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
	</div>

	<!-- 添加模态框（Modal） -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">
						<span id="create_activity_category_span"></span>
					</h4>
				</div>

				<div class="modal-body">
					<div class="modal-body">
						<form class="form-horizontal m-t" id="create_form"
							action="<%=basePath%>/banx/cat/category">
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="category_name_span"></span>：</label>
								<div class="col-sm-8">
									<input id="name" name="name" class="form-control" type="text">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="category_note_span"></span>：</label>
								<div class="col-sm-8">
									<textarea class="form-control" id="note" name="note" rows="4"></textarea>
								</div>
							</div>
						</form>
					</div>
				</div>

				<div class="modal-footer">
					<button type="submit" class="btn btn-primary" onclick="create();">提交</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>

			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
	
	<!-- 修改模态框（Modal） -->
	<div class="modal fade" id="myModalEdit" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">
						<span id="edit_activity_category_span"></span>
					</h4>
				</div>

				<div class="modal-body">
					<div class="modal-body">
						<form class="form-horizontal m-t" id="edit_form"
							action="<%=basePath%>/banx/cat/category">
							<input type="hidden" id="id_edit">
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="category_name_edit_span"></span>：</label>
								<div class="col-sm-8">
									<input id="name_edit" name="name" class="form-control" type="text">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="category_note_edit_span"></span>：</label>
								<div class="col-sm-8">
									<textarea class="form-control" id="note_edit" name="note" rows="4"></textarea>
								</div>
							</div>
						</form>
					</div>
				</div>

				<div class="modal-footer">
					<button type="submit" class="btn btn-primary" onclick="update();">更新</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>

			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>

	<!-- Mainly scripts -->
	<script type="text/javascript">
		window.onload = function() {
			$('.dataTables-example').dataTable();
			switchLanguage(language_flag);
		}

		function create() {
			var name = $("#name").val();
			if(name == "" || name == null) {
				toastr.warning("活动种类名称不能为空！");
				return false;
			}
			var note = $("#note").val();
			$.ajax({
				url : "<%=basePath%>/banx/cat/category",
				type : "POST",
				data : {
					name : name,
					note : note
				},
				success : function(data) {
					toastr.success("Succeed");
					$('#myModal').modal('hide');
					window.location.reload();
				},
				error : function(xhr, type, errorThrown) {
					toastr.error('Failure: ' + errorThrown);
				}
			});
		}
		
		function editModal(id) {
			$.ajax({
				url : "<%=basePath%>/banx/cat/category/"+id,
				type : "GET",
				dataType : "json",
				success : function(data) {
					$("#id_edit").val(id);
					$("#name_edit").val(data["name"]);
					$("#note_edit").val(data["note"]);
					$('#myModalEdit').modal('show');
				},
				error : function(xhr, type, errorThrown) {
					toastr.error('Failure: ' + errorThrown);
				}
			});
		}
		
		function update() {
			var id = $("#id_edit").val();
			var name = $("#name_edit").val();
			if(name == "" || name == null) {
				toastr.warning("活动种类名称不能为空！");
				return false;
			}
			var note = $("#note_edit").val();
			$.ajax({
				url : "<%=basePath%>/banx/cat/category/" + id,
				type : "POST",
				data : {
					name : name,
					note : note
				},
				success : function(data) {
					toastr.success("Succeed");
					$('#myModalEdit').modal('hide');
					window.location.reload();
				},
				error : function(xhr, type, errorThrown) {
					toastr.error('Failure: ' + errorThrown);
				}
			});
		}
	</script>

	<script src="<%=basePath%>/js/footer.js"></script>
</body>
</html>
