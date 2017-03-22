<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-详细活动</title>
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
							 <strong>详细活动</strong>
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
								data-target="#myModal"><i class="fa fa-plus"></i>&nbsp;添加详细活动</button>
						</div>
					</div>
					<div class="ibox-content">

						<table
							class="table table-striped table-bordered table-hover dataTables-example">
							<thead>
								<tr>
									<th>活动ID</th>
									<th>活动名称</th>
									<th>活动图片</th>
									<th>佣金比例</th>
									<th>Cookie有效期</th>										
									<th>开始时间</th>
									<th>结束时间</th>
									<th>结算周期</th>
									<th>审核方式</th>
									<th>是否支持反馈标签方式</th>
									<th>是否支持自定义链接</th>									
									<th>是否有效</th>																
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="row" items="${requestScope.rows}">
									<tr class="gradeX">
										<td class="center">${row.activity_id}</td>
										<td class="center">${row.activity_name}</td>
										<td class="center"><img src="${row.image}"></td>
										<td class="center">${row.commission}</td>
										<td class="center">${row.rd}</td>
										<td class="center"><fmt:formatDate value="${row.start_date}" pattern="yyyy-MM-dd"/></td>
										<td class="center"><fmt:formatDate value="${row.end_date}" pattern="yyyy-MM-dd"/></td>
										<td class="center">${row.clearing_cycle}</td>
										<td class="center">&nbsp;&nbsp;&nbsp;
										<c:if test="${row.approval_mode==1 }">
											自动
										</c:if>
										<c:if test="${row.approval_mode==2 }">
											人工
										</c:if>
										<c:if test="${row.approval_mode==3 }">
											无需审核
										</c:if>
										</td>
										<td class="center">&nbsp;&nbsp;&nbsp;
										<c:if test="${row.has_feedback==1 }">
											<button class="btn btn-info btn-circle btn-xs" type="button">
												<i class="fa fa-check"></i>
											</button>
										</c:if>
										<c:if test="${row.has_feedback==0 }">
											<button class="btn btn-warning btn-circle btn-xs"
												type="button">
												<i class="fa fa-times"></i>
											</button>
										</c:if>
										</td>
										<td class="center">&nbsp;&nbsp;&nbsp;
										<c:if test="${row.has_self_links==1 }">
											<button class="btn btn-info btn-circle btn-xs" type="button">
												<i class="fa fa-check"></i>
											</button>
										</c:if>
										<c:if test="${row.has_self_links==0 }">
											<button class="btn btn-warning btn-circle btn-xs"
												type="button">
												<i class="fa fa-times"></i>
											</button>
										</c:if>
										</td>
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
						<span id="create_detailed_activity_span"></span>
					</h4>
				</div>

				<div class="modal-body">
					<div class="modal-body">
						<form class="form-horizontal m-t" id="create_form">
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_activity_id_span"></span>：</label>
								<div class="col-sm-8">
									<select class="form-control" id="activity_id" name="activity_id">
										<c:forEach var="activity" items="${requestScope.activities }">
											<option value="${activity.id }">${activity.name }</option> 
										</c:forEach>
									</select>
								</div>
							</div>
							
							<!-- <div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_image_span"></span>：</label>
								<div class="col-sm-8">
									<textarea class="form-control" id="image" name="image" rows="3"></textarea>
								</div>
							</div> -->
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_image_span"></span>：</label>
								<div class="col-sm-8">
									<!-- <input id="image" name="image" class="form-control" type="text"> -->
									<textarea class="form-control" id="image" name="image" rows="3"></textarea>
									<a class="btn btn-success btn-sm" href='javascript:void(0)' onclick="clickImage('create');"><span>上传图片</span></a>
								</div>
							</div>

							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_commission_span"></span>：</label>
								<div class="col-sm-8">
									<input id="commission" name="commission" class="form-control" type="text">
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_rd_span"></span>：</label>
								<div class="col-sm-8">
									<input id="rd" name="rd" class="form-control" type="text">
								</div>
							</div>
				
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_approval_mode_span"></span>：</label>
								<div class="col-sm-8">
									<label class="checkbox-inline"> <input type="radio"
										name="approval_mode" id="approval_mode" value="1"
										checked> 自动
									</label> <label class="checkbox-inline"> <input type="radio"
										name="approval_mode" id="approval_mode" value="2">
										人工
									</label> <label class="checkbox-inline"> <input type="radio"
										name="approval_mode" id="approval_mode" value="3">
										无需审核
									</label>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_clearing_cycle_id_span"></span>：</label>
								<div class="col-sm-8">
									<select class="form-control" id="clearing_cycle_id" name="clearing_cycle_id">
										<c:forEach var="clearingCycle" items="${requestScope.clearingCycles }">
											<option value="${clearingCycle.id }">${clearingCycle.clearing_cycle }</option> 
										</c:forEach>
									</select>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_data_return_mode_span"></span>：</label>
								<div class="col-sm-8">
									<input id="data_return_mode" name="data_return_mode" class="form-control" type="text">
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_has_feedback_span"></span>：</label>
								<div class="col-sm-8">
									<label class="checkbox-inline"> <input type="radio"
										name="has_feedback" id="has_feedback" value="1"
										checked> YES
									</label> <label class="checkbox-inline"> <input type="radio"
										name="has_feedback" id="has_feedback" value="0">
										NO
									</label>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_has_self_links_span"></span>：</label>
								<div class="col-sm-8">
									<label class="checkbox-inline"> <input type="radio"
										name="has_self_links" id="has_self_links" value="1"
										checked> YES
									</label> <label class="checkbox-inline"> <input type="radio"
										name="has_self_links" id="has_self_links" value="0">
										NO
									</label>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_prohibited_sites_types_span"></span>：</label>
								<div class="col-sm-8">
									<textarea class="form-control" id="prohibited_sites_types" name="prohibited_sites_types" rows="3"></textarea>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_restrictions_span"></span>：</label>
								<div class="col-sm-8">
									<textarea class="form-control" id="restrictions" name="restrictions" rows="3"></textarea>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_note_span"></span>：</label>
								<div class="col-sm-8">
									<textarea class="form-control" id="note" name="note" rows="3"></textarea>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_is_active_span"></span>：</label>
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
									style="color: red">*</font><span id="detailed_activity_start_end_date_span"></span>：</label>
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
						<span id="edit_detailed_activity_span"></span>
					</h4>
				</div>

				<div class="modal-body">
					<div class="modal-body">
						<form class="form-horizontal m-t" id="edit_form">
							<input type="hidden" id="id_edit">
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_activity_id_edit_span"></span>：</label>
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
									style="color: red">*</font><span id="detailed_activity_image_edit_span"></span>：</label>
								<div class="col-sm-8">
									<!-- <input id="image_edit" name="image" class="form-control" type="text"> -->
									<textarea class="form-control" id="image_edit" name="image" rows="3"></textarea>
									<a class="btn btn-success btn-sm" href='javascript:void(0)' onclick='clickImage("edit");'><span>上传图片</span></a>
								</div>
							</div>

							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_commission_edit_span"></span>：</label>
								<div class="col-sm-8">
									<input id="commission_edit" name="commission" class="form-control" type="text">
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_rd_edit_span"></span>：</label>
								<div class="col-sm-8">
									<input id="rd_edit" name="rd" class="form-control" type="text">
								</div>
							</div>
				
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_approval_mode_edit_span"></span>：</label>
								<div class="col-sm-8">
									<label class="checkbox-inline"> <input type="radio"
										name="approval_mode" id="approval_mode_edit" value="1"
										checked> 自动
									</label> <label class="checkbox-inline"> <input type="radio"
										name="approval_mode" id="approval_mode_edit" value="2">
										人工
									</label> <label class="checkbox-inline"> <input type="radio"
										name="approval_mode" id="approval_mode_edit" value="3">
										无需审核
									</label>
								</div>
							</div>
							
							<!-- <div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_clearing_cycle_id_edit_span"></span>：</label>
								<div class="col-sm-8">
									<input id="clearing_cycle_id_edit" name="clearing_cycle_id" class="form-control" type="text">
								</div>
							</div> -->
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_clearing_cycle_id_edit_span"></span>：</label>
								<div class="col-sm-8">
									<select class="form-control" id="clearing_cycle_id_edit" name="clearing_cycle_id">
										<c:forEach var="clearingCycle" items="${requestScope.clearingCycles }">
											<option value="${clearingCycle.id }">${clearingCycle.clearing_cycle }</option> 
										</c:forEach>
									</select>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_data_return_mode_edit_span"></span>：</label>
								<div class="col-sm-8">
									<input id="data_return_mode_edit" name="data_return_mode" class="form-control" type="text">
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_has_feedback_edit_span"></span>：</label>
								<div class="col-sm-8">
									<label class="checkbox-inline"> <input type="radio"
										name="has_feedback" id="has_feedback_edit" value="1"
										checked> YES
									</label> <label class="checkbox-inline"> <input type="radio"
										name="has_feedback" id="has_feedback_edit" value="0">
										NO
									</label>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_has_self_links_edit_span"></span>：</label>
								<div class="col-sm-8">
									<label class="checkbox-inline"> <input type="radio"
										name="has_self_links" id="has_self_links_edit" value="1"
										checked> YES
									</label> <label class="checkbox-inline"> <input type="radio"
										name="has_self_links" id="has_self_links_edit" value="0">
										NO
									</label>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_prohibited_sites_types_edit_span"></span>：</label>
								<div class="col-sm-8">
									<textarea class="form-control" id="prohibited_sites_types_edit" name="prohibited_sites_types" rows="3"></textarea>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_restrictions_edit_span"></span>：</label>
								<div class="col-sm-8">
									<textarea class="form-control" id="restrictions_edit" name="restrictions" rows="3"></textarea>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_note_edit_span"></span>：</label>
								<div class="col-sm-8">
									<textarea class="form-control" id="note_edit" name="note" rows="3"></textarea>
								</div>
							</div>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="detailed_activity_is_active_edit_span"></span>：</label>
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
									style="color: red">*</font><span id="detailed_activity_start_end_date_edit_span"></span>：</label>
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

	<form method="post" id="uploadImage" action=""
		enctype="multipart/form-data" style="display: none">
		<input type="file" id="imgFile" name="imgFile" value=""
			onchange="getImgUrl();" />
	</form>

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
			var image = $("#image").val();
			var commission = $("#commission").val();
			var rd = $("#rd").val();
			var approval_mode = $("#approval_mode").val();
			var clearing_cycle_id = $("#clearing_cycle_id").val();
			var data_return_mode = $("#data_return_mode").val();
			var has_feedback = $("#has_feedback:checked").val();
			var has_self_links = $("#has_self_links:checked").val();
			var prohibited_sites_types = $("#prohibited_sites_types").val();
			var restrictions = $("#restrictions").val();
			var is_active = $("#is_active:checked").val();
			var start_date = $("#start_date").val();
			var end_date = $("#end_date").val();
			var note = $("#note").val();
			if(activity_id == "" || activity_id == null) {
				toastr.warning("活动ID不能为空！");
				return false;
			}
			if(commission == "" || commission == null) {
				toastr.warning("佣金比例不能为空！");
				return false;
			}
			$.ajax({
				url : "<%=basePath%>/banx/activity/detailed-activity",
				type : "POST",
				data : {
					activity_id : activity_id,
					image : image,
					commission : commission,
					rd : rd,
					approval_mode : approval_mode,
					clearing_cycle_id : clearing_cycle_id,
					data_return_mode : data_return_mode,
					has_feedback : has_feedback,
					has_self_links : has_self_links,
					prohibited_sites_types : prohibited_sites_types,
					restrictions : restrictions,
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
				url : "<%=basePath%>/banx/activity/detailed-activity/"+id,
				type : "GET",
				dataType : "json",
				success : function(data) {
					$("#id_edit").val(id);
					$("#activity_id_edit").val(data["activity_id"]);
					$("#image_edit").html(data["image"]);
					$("#commission_edit").val(data["commission"]);
					$("#rd_edit").val(data["rd"]);
					$("#approval_mode_edit").val(data["approval_mode"]);
					$("#clearing_cycle_id_edit").val(data["clearing_cycle_id"]);
					$("#data_return_mode_edit").val(data["data_return_mode"]);
					$("input[id=has_feedback_edit][value="+data["has_feedback"]+"]").attr("checked", true);
					$("input[id=has_self_links_edit][value="+data["has_self_links"]+"]").attr("checked", true);
					$("#prohibited_sites_types_edit").val(data["prohibited_sites_types"]);
					$("#restrictions_edit").val(data["restrictions"]);
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
			var image = $("#image_edit").val();
			var commission = $("#commission_edit").val();
			var rd = $("#rd_edit").val();
			var approval_mode = $("#approval_mode_edit:checked").val();
			var clearing_cycle_id = $("#clearing_cycle_id_edit").val();
			var data_return_mode = $("#data_return_mode_edit").val();
			var has_feedback = $("#has_feedback_edit:checked").val();
			var has_self_links = $("#has_self_links_edit:checked").val();
			var prohibited_sites_types = $("#prohibited_sites_types_edit").val();
			var restrictions = $("#restrictions_edit").val();
			var is_active = $("#is_active_edit:checked").val();
			var start_date = $("#start_date_edit").val();
			var end_date = $("#end_date_edit").val();
			var note = $("#note_edit").val();
			if(activity_id == "" || activity_id == null) {
				toastr.warning("活动ID不能为空！");
				return false;
			}
			if(commission == "" || commission == null) {
				toastr.warning("佣金比例不能为空！");
				return false;
			}
			$.ajax({
				url : "<%=basePath%>/banx/activity/detailed-activity/" + id,
				type : "POST",
				data : {
					activity_id : activity_id,
					image : image,
					commission : commission,
					rd : rd,
					approval_mode : approval_mode,
					clearing_cycle_id : clearing_cycle_id,
					data_return_mode : data_return_mode,
					has_feedback : has_feedback,
					has_self_links : has_self_links,
					prohibited_sites_types : prohibited_sites_types,
					restrictions : restrictions,
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
		
		var imageFlag = "";
		function clickImage(imageStatus) {
			$("#imgFile").click();
			imageFlag = imageStatus;
		}
		
		function getImgUrl() {
			var option = {
					url:"<%=basePath%>/banx/img/image",
					success:function(data) {
						var imgUrl = data[1];
						if(imageFlag == "create") {
							$("#image").html(imgUrl);
						} else if(imageFlag == "edit") {
							$("#image_edit").html(imgUrl);
						}
						
					},
					error: function(e) { 
						toastr.error(e); 
					} 
			};
			$("#uploadImage").ajaxSubmit(option);
		}
    </script>

	<script src="<%=basePath%>/js/footer.js"></script>
</body>
</html>
