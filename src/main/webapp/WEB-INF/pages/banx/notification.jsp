<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-广告主通知</title>
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
							 <strong>广告主通知</strong>
						</h2>
						<div class="ibox-tools">
							<!-- <a class="collapse-link"> <i class="fa fa-chevron-up"></i>
							</a> <a class="dropdown-toggle" data-toggle="dropdown"
								href="table_data_tables.html#"> <i class="fa fa-wrench"></i>
							</a> -->
							<!-- <ul class="dropdown-menu dropdown-user">
								<li><a href="table_data_tables.html#">选项1</a></li>
								<li><a href="table_data_tables.html#">选项2</a></li>
							</ul> -->
							<!-- <a class="close-link"> <i class="fa fa-times"></i>
							</a> -->
							<!-- 按钮触发模态框 -->
							<button class="btn btn-primary" data-toggle="modal"
								data-target="#myModal"><i class="fa fa-plus"></i>&nbsp;添加广告主通知</button>
						</div>
					</div>
					<div class="ibox-content">

						<table
							class="table table-striped table-bordered table-hover dataTables-example">
							<thead>
								<tr>
									<th>活动ID</th>
									<th>通知标题</th>
									<th>通知类型</th>
									<th>通知信息</th>							
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="row" items="${requestScope.rows}">
									<tr class="gradeX">
										<td class="center">${row.activity_name}</td>
										<td class="center">${row.title}</td>
										<td class="center">
										<c:if test="${row.type==1 }">
											联盟公告
										</c:if>
										<c:if test="${row.type==2 }">
											商家奖励
										</c:if>
										<c:if test="${row.type==3 }">
											商家促销
										</c:if>
										</td>
										<td class="center">${row.info}</td>
										<td class="center">&nbsp;&nbsp;&nbsp;<a href="javaScript:void(0);" onclick="editModal(${row.id});"><button class="btn btn-success btn-sm" type="button">
												<i class="fa fa-pencil"></i>
											</button></a></td>
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
						<span id="create_notification_span"></span>
					</h4>
				</div>

				<div class="modal-body">
					<div class="modal-body">
						<form class="form-horizontal m-t" id="create_form">
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="notification_activity_id_span"></span>：</label>
								<div class="col-sm-8">
									<select class="form-control" id="activity_id" name="activity_id">
										<c:forEach var="activity" items="${requestScope.activities }">
											<option value="${activity.id }">${activity.name }</option> 
										</c:forEach>
									</select>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="notification_type_span"></span>：</label>
								<div class="col-sm-8">
									<label class="checkbox-inline"> <input type="radio"
										name="type" id="type" value="1"
										checked> 联盟公告
									</label> <label class="checkbox-inline"> <input type="radio"
										name="type" id="type" value="2">
										商家奖励
									</label> <label class="checkbox-inline"> <input type="radio"
										name="type" id="type" value="3">
										商家促销
									</label>
								</div>
							</div>

							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="notification_title_span"></span>：</label>
								<div class="col-sm-8">
									<input id="title" name="title" class="form-control" type="text">
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="notification_info_span"></span>：</label>
								<div class="col-sm-8">
									<textarea class="form-control" id="info" name="info" rows="4"></textarea>
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
						<span id="edit_notification_span"></span>
					</h4>
				</div>

				<div class="modal-body">
					<div class="modal-body">
						<form class="form-horizontal m-t" id="edit_form">
							<input type="hidden" id="id_edit">
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="notification_activity_id_edit_span"></span>：</label>
								<div class="col-sm-8">
									<select class="form-control" id="activity_id_edit" name="activity_id">
										<c:forEach var="activity" items="${requestScope.activities }">
											<option value="${activity.id }">${activity.name }</option> 
										</c:forEach>
									</select>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="notification_type_edit_span"></span>：</label>
								<div class="col-sm-8">
									<label class="checkbox-inline"> <input type="radio"
										name="type" id="type_edit" value="1"> 联盟公告
									</label> <label class="checkbox-inline"> <input type="radio"
										name="type" id="type_edit" value="2"> 商家奖励
									</label> <label class="checkbox-inline"> <input type="radio"
										name="type" id="type_edit" value="3"> 商家促销
									</label>
								</div>
							</div>

							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="notification_title_edit_span"></span>：</label>
								<div class="col-sm-8">
									<input id="title_edit" name="title" class="form-control" type="text">
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="notification_info_edit_span"></span>：</label>
								<div class="col-sm-8">
									<textarea class="form-control" id="info_edit" name="info" rows="4"></textarea>
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
			var activity_id = $("#activity_id").val();			
			var type = $("#type:checked").val();
			var title = $("#title").val();
			var info = $("#info").val();
			if(activity_id == "" || activity_id == null) {
				toastr.warning("活动ID不能为空！");
				return false;
			}
			
			if(title == "" || title == null) {
				toastr.warning("通知标题不能为空！");
				return false;
			}

			$.ajax({
				url : "<%=basePath%>/banx/noti/notification",
				type : "POST",
				data : {
					activity_id : activity_id,
					type : type,
					title : title,
					info : info
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
				url : "<%=basePath%>/banx/noti/notification/"+id,
				type : "GET",
				dataType : "json",
				success : function(data) {
					$("#id_edit").val(id);					
					$("#activity_id_edit").val(data["activity_id"]);			
					//$("#type_edit").val(data["type"]);
					$("input[id=type_edit][value="+data["type"]+"]").attr("checked", true);
					$("#title_edit").val(data["title"]);
					$("#info_edit").val(data["info"]);
					$('#myModalEdit').modal('show');
				},
				error : function(xhr, type, errorThrown) {
					toastr.error('Failure: ' + errorThrown);
				}
			});
		}
		
		function update() {
			var id = $("#id_edit").val();
			var activity_id = $("#activity_id_edit").val();			
			var type = $("#type_edit:checked").val();
			var title = $("#title_edit").val();
			var info = $("#info_edit").val();

			if(activity_id == "" || activity_id == null) {
				toastr.warning("活动ID不能为空！");
				return false;
			}
			
			if(title == "" || title == null) {
				toastr.warning("通知标题不能为空！");
				return false;
			}
			
			$.ajax({
				url : "<%=basePath%>/banx/noti/notification/" + id,
				type : "POST",
				data : {
					activity_id : activity_id,
					type : type,
					title : title,
					info : info
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
