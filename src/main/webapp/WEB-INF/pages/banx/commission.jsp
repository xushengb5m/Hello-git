<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-佣金支付标准</title>
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
							 <strong>佣金支付标准</strong>
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
								data-target="#myModal"><i class="fa fa-plus"></i>&nbsp;添加佣金支付标准</button>
						</div>
					</div>
					<div class="ibox-content">

						<table
							class="table table-striped table-bordered table-hover dataTables-example">
							<thead>
								<tr>
									<th>活动ID</th>
									<th>佣金类目名称</th>
									<th>佣金比例</th>
									<th>开始时间</th>
									<th>结束时间</th>
									<th>适用商品</th>
									<th>是否有效</th>
									<th>创建时间</th>								
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="row" items="${requestScope.rows}">
									<tr class="gradeX">
										<td class="center">${row.activity_name}</td>
										<td class="center">${row.name}</td>
										<td class="center">${row.commission}</td>
										<td class="center"><fmt:formatDate value="${row.start_date}" pattern="yyyy-MM-dd"/></td>
										<td class="center"><fmt:formatDate value="${row.end_date}" pattern="yyyy-MM-dd"/></td>
										<td class="center">${row.apply_goods}</td>
										<td class="center">&nbsp;&nbsp;&nbsp;
										<c:if test="${row.is_active==1 }">
											<button class="btn btn-info btn-circle btn-xs" type="button">
												<i class="fa fa-check"></i>
											</button>
										</c:if>
										<c:if test="${row.is_active==0 }">
											<button class="btn btn-warning btn-circle btn-xs"
												type="button">
												<i class="fa fa-times"></i>
											</button>
										</c:if>
										</td>
										<td class="center"><fmt:formatDate value="${row.create_time}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
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
						<span id="create_commission_info_span"></span>
					</h4>
				</div>

				<div class="modal-body">
					<div class="modal-body">
						<form class="form-horizontal m-t" id="create_form">
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="commission_info_activity_id_span"></span>：</label>
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
									style="color: red">*</font><span id="commission_info_name_span"></span>：</label>
								<div class="col-sm-8">
									<input id="name" name="name" class="form-control" type="text">
								</div>
							</div>

							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="commission_info_commission_span"></span>：</label>
								<div class="col-sm-8">
									<input id="commission" name="commission" class="form-control" type="text">
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="commission_info_apply_goods_span"></span>：</label>
								<div class="col-sm-8">
									<input id="apply_goods" name="apply_goods" class="form-control" type="text">
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="commission_info_note_span"></span>：</label>
								<div class="col-sm-8">
									<textarea class="form-control" id="note" name="note" rows="4"></textarea>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="commission_info_is_active_span"></span>：</label>
								<div class="col-sm-8">
									<label class="checkbox-inline"> <input type="radio"
										name="is_active" id="is_active" value="1"
										checked> YES
									</label> <label class="checkbox-inline"> <input type="radio"
										name="is_active" id="is_active" value="0">
										NO
									</label>
								</div>
							</div>
							
							<div class="form-group" id="date_picker">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="commission_info_start_end_date_span"></span>：</label>
								<div class="col-sm-8 input-daterange input-group" id="datepicker">
									<input type="text" class="input-sm form-control" id="start_date" name="start_date"
										value="2016-06-01" /> <span class="input-group-addon">TO</span>
									<input type="text" class="input-sm form-control" id="end_date" name="end_date"
										value="2017-05-31" />
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
						<span id="edit_commission_info_span"></span>
					</h4>
				</div>

				<div class="modal-body">
					<div class="modal-body">
						<form class="form-horizontal m-t" id="edit_form">
							<input type="hidden" id="id_edit">
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="commission_info_activity_id_edit_span"></span>：</label>
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
									style="color: red">*</font><span id="commission_info_name_edit_span"></span>：</label>
								<div class="col-sm-8">
									<input id="name_edit" name="name" class="form-control" type="text">
								</div>
							</div>

							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="commission_info_commission_edit_span"></span>：</label>
								<div class="col-sm-8">
									<input id="commission_edit" name="commission" class="form-control" type="text">
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="commission_info_apply_goods_edit_span"></span>：</label>
								<div class="col-sm-8">
									<input id="apply_goods_edit" name="apply_goods" class="form-control" type="text">
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="commission_info_note_edit_span"></span>：</label>
								<div class="col-sm-8">
									<textarea class="form-control" id="note_edit" name="note" rows="4"></textarea>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="commission_info_is_active_edit_span"></span>：</label>
								<div class="col-sm-8">
									<label class="checkbox-inline"> <input type="radio"
										name="is_active" id="is_active_edit" value="1"
										checked> YES
									</label> <label class="checkbox-inline"> <input type="radio"
										name="is_active" id="is_active_edit" value="0">
										NO
									</label>
								</div>
							</div>
							
							<div class="form-group" id="date_picker">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="commission_info_start_end_date_edit_span"></span>：</label>
								<div class="col-sm-8 input-daterange input-group" id="datepicker">
									<input type="text" class="input-sm form-control" id="start_date_edit" name="start_date"
										value="2016-06-01" /> <span class="input-group-addon">TO</span>
									<input type="text" class="input-sm form-control" id="end_date_edit" name="end_date"
										value="2017-05-31" />
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
				
			$('#date_picker .input-daterange').datepicker({
	        	keyboardNavigation: false,
	            forceParse: false,
	            autoclose: true
	        });
		}

		function create() {
			var activity_id = $("#activity_id").val();			
			var name = $("#name").val();
			var commission = $("#commission").val();
			var apply_goods = $("#apply_goods").val();
			var is_active = $("#is_active:checked").val();
			var start_date = $("#start_date").val();
			var end_date = $("#end_date").val();
			var note = $("#note").val();
			if(activity_id == "" || activity_id == null) {
				toastr.warning("活动ID不能为空！");
				return false;
			}
			if(name == "" || name == null) {
				toastr.warning("佣金类目名称不能为空！");
				return false;
			}
			if(commission == "" || commission == null) {
				toastr.warning("佣金比例不能为空！");
				return false;
			}
			if(apply_goods == "" || apply_goods == null) {
				toastr.warning("适用商品不能为空！");
				return false;
			}
			$.ajax({
				url : "<%=basePath%>/banx/comm/commission",
				type : "POST",
				data : {
					activity_id : activity_id,
					name : name,
					commission : commission,
					apply_goods : apply_goods,
					is_active : is_active,
					start_date : start_date,
					end_date : end_date,
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
				url : "<%=basePath%>/banx/comm/commission/"+id,
				type : "GET",
				dataType : "json",
				success : function(data) {
					$("#id_edit").val(id);					
					$("#activity_id_edit").val(data["activity_id"]);			
					$("#name_edit").val(data["name"]);
					$("#commission_edit").val(data["commission"]);
					$("#apply_goods_edit").val(data["apply_goods"]);
					$("input[id=is_active_edit][value="+data["is_active"]+"]").attr("checked", true);
					$("#start_date_edit").val(data["start_date"]);
					$("#end_date_edit").val(data["end_date"]);
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
			var activity_id = $("#activity_id_edit").val();			
			var name = $("#name_edit").val();
			var commission = $("#commission_edit").val();
			var apply_goods = $("#apply_goods_edit").val();
			var is_active = $("#is_active_edit:checked").val();
			var start_date = $("#start_date_edit").val();
			var end_date = $("#end_date_edit").val();
			var note = $("#note_edit").val();
			if(activity_id == "" || activity_id == null) {
				toastr.warning("活动ID不能为空！");
				return false;
			}
			if(name == "" || name == null) {
				toastr.warning("佣金类目名称不能为空！");
				return false;
			}
			if(commission == "" || commission == null) {
				toastr.warning("佣金比例不能为空！");
				return false;
			}
			if(apply_goods == "" || apply_goods == null) {
				toastr.warning("适用商品不能为空！");
				return false;
			}
			$.ajax({
				url : "<%=basePath%>/banx/comm/commission/" + id,
				type : "POST",
				data : {
					activity_id : activity_id,
					name : name,
					commission : commission,
					apply_goods : apply_goods,
					is_active : is_active,
					start_date : start_date,
					end_date : end_date,
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
