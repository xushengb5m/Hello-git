<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-活动基本信息</title>
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
							<strong>活动基本信息</strong>
						</h2>
						<div class="ibox-tools">
							<!-- 按钮触发模态框 -->
							<button class="btn btn-primary" data-toggle="modal"
								data-target="#myModal"><i class="fa fa-plus"></i>&nbsp;添加活动基本信息</button>
							
						</div>
					</div>
					<div class="ibox-content">

						<table
							class="table table-striped table-bordered table-hover dataTables-example">
							<thead>
								<tr>
									<th>商家ID</th>
									<th>活动名称</th>
									<th>活动ID</th>
									<th>活动类型</th>
									<th>计费类型</th>
									<th>网站域名</th>
									<th>活动分类</th>
									<th>是否有效</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="row" items="${requestScope.rows}">
									<tr class="gradeX">
										<td class="center">${row.merchant_id}</td>
										<td class="center">${row.name}</td>
										<td class="center">${row.id}</td>
										<td class="center">&nbsp;&nbsp;&nbsp;
										<c:if test="${row.type==1 }">
											<i class="fa fa-desktop"></i>
										</c:if>
										<c:if test="${row.type==2 }">
											<i class="fa fa-tablet"></i>
										</c:if>
										</td>
										<td class="center">${row.charge_mode}</td>
										<td class="center">${row.domain}</td>
										<td class="center">${row.category_name}</td>
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
						<span id="basic_activity_span"></span>
					</h4>
				</div>

				<div class="modal-body">
					<div class="modal-body">
						<form class="form-horizontal m-t" id="create_form"
							action="<%=basePath%>/banx/cat/category">
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="basic_activity_merchant_id_span"></span>：</label>
								<div class="col-sm-8">
									<select class="form-control" id="merchant_id" name="merchant_id">
										<c:forEach var="mc" items="${requestScope.merchants }">
											<option value="${mc.id}">${mc.id}-${mc.userName}</option> 
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="basic_activity_name_span"></span>：</label>
								<div class="col-sm-8">
									<input id="name" name="name" class="form-control" type="text">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="basic_activity_type_span"></span>：</label>
								<div class="col-sm-8">
									<label class="checkbox-inline"> <input type="radio"
										name="type" id="type" value="1"
										checked> PC
									</label> <label class="checkbox-inline"> <input type="radio"
										name="type" id="type" value="2">
										APP
									</label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="basic_activity_charge_mode_span"></span>：</label>
								<div class="col-sm-8">
									<label class="checkbox-inline"> <input type="radio"
										name="charge_mode" id="charge_mode" value="CPS"
										checked>CPS
									</label> <label class="checkbox-inline"> <input type="radio"
										name="charge_mode" id="charge_mode" value="CPC">
										CPC
									</label> <label class="checkbox-inline"> <input type="radio"
										name="charge_mode" id="charge_mode" value="CPA">
										CPA
									</label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="basic_activity_domain_span"></span>：</label>
								<div class="col-sm-8">
									<textarea class="form-control" id="domain" name="domain" rows="3"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="basic_activity_category_span"></span>：</label>
								<div class="col-sm-8">
									<select class="form-control" id="category" name="category">
										<c:forEach var="category" items="${requestScope.categories }">
											<option value="${category.id }">${category.name }</option> 
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="basic_activity_is_active_span"></span>：</label>
								<!-- <div class="col-sm-8">
									<input id="name" name="name" class="form-control" type="text">
								</div> -->
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
						<span id="basic_activity_edit_span"></span>
					</h4>
				</div>

				<div class="modal-body">
					<div class="modal-body">
						<form class="form-horizontal m-t" id="create_form"
							action="<%=basePath%>/banx/cat/category">
							<input type="hidden" id="id_edit">
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="basic_activity_merchant_id_edit_span"></span>：</label>
								<div class="col-sm-8">
									<input id="merchant_id_edit" name="merchant_id" class="form-control" type="text">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="basic_activity_name_edit_span"></span>：</label>
								<div class="col-sm-8">
									<input id="name_edit" name="name" class="form-control" type="text">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="basic_activity_type_edit_span"></span>：</label>
								<!-- <div class="col-sm-8">
									<input id="name" name="name" class="form-control" type="text">
								</div> -->
								<div class="col-sm-8">
									<label class="checkbox-inline"> <input type="radio"
										name="type" id="type_edit" value="1"
										> PC
									</label> <label class="checkbox-inline"> <input type="radio"
										name="type" id="type_edit" value="2">
										APP
									</label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="basic_activity_charge_mode_edit_span"></span>：</label>
								<!-- <div class="col-sm-8">
									<input id="name" name="name" class="form-control" type="text">
								</div> -->
								<div class="col-sm-8">
									<label class="checkbox-inline"> <input type="radio"
										name="charge_mode" id="charge_mode_edit" value="CPS"
										checked>CPS
									</label> <label class="checkbox-inline"> <input type="radio"
										name="charge_mode" id="charge_mode_edit" value="CPC">
										CPC
									</label> <label class="checkbox-inline"> <input type="radio"
										name="charge_mode" id="charge_mode_edit" value="CPA">
										CPA
									</label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="basic_activity_domain_edit_span"></span>：</label>
								<div class="col-sm-8">
									<textarea class="form-control" id="domain_edit" name="domain" rows="3"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="basic_activity_category_edit_span"></span>：</label>
								<div class="col-sm-8">
									<select class="form-control" id="category_edit" name="category">
										<c:forEach var="category" items="${requestScope.categories }">
											<option value="${category.id }">${category.name }</option> 
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="basic_activity_is_active_edit_span"></span>：</label>
								<!-- <div class="col-sm-8">
									<input id="name" name="name" class="form-control" type="text">
								</div> -->
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
			var merchant_id = $("#merchant_id").val();
			if(merchant_id == "" || merchant_id == null) {
				toastr.warning("广告主ID不能为空！");
				return false;
			}
			var name = $("#name").val();
			if(name == "" || name == null) {
				toastr.warning("活动名称不能为空！");
				return false;
			}
			var type = $("#type:checked").val();
			if(type == "" || type == null) {
				toastr.warning("活动类型不能为空！");
				return false;
			}
			var charge_mode = $("#charge_mode:checked").val();
			if(charge_mode == "" || charge_mode == null) {
				toastr.warning("计费类型不能为空！");
				return false;
			}
			var domain = $("#domain").val();
			if(domain == "" || domain == null) {
				toastr.warning("网站域名不能为空！");
				return false;
			}
			var category = $("#category").val();
			if(category == "" || category == null) {
				toastr.warning("广告主ID不能为空！");
				return false;
			}
			var is_active = $("#is_active:checked").val();
			if(is_active == "" || is_active == null) {
				toastr.warning("是否激活必须选择！");
				return false;
			}
			$.ajax({
				url : "<%=basePath%>/banx/act/basic-activity",
				type : "POST",
				data : {
					merchant_id : merchant_id,
					name : name,
					type : type,
					charge_mode : charge_mode,
					domain : domain,
					category : category,
					is_active : is_active
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
				url : "<%=basePath%>/banx/act/basic-activity/"+id,
				type : "GET",
				dataType : "json",
				success : function(data) {
					$("#id_edit").val(id);
					$("#merchant_id_edit").val(data["merchant_id"]);
					$("#name_edit").val(data["name"]);
					//$("#type_edit").val(data["type"]);
					$("input[id=type_edit][value="+data["type"]+"]").attr("checked", true);
					$("input[id=charge_mode_edit][value="+data["charge_mode"]+"]").attr("checked", true);
					//$("#charge_mode_edit").val(data["charge_mode"]);
					$("#domain_edit").val(data["domain"]);
					$("#category_edit").val(data["category"]);
					$("option[id=category_edit][value="+data["category"]+"]").attr("selected", true);
					//$("#is_active_edit").val(data["is_active"]);
					$("input[id=is_active_edit][value="+data["is_active"]+"]").attr("checked", true);
					$('#myModalEdit').modal('show');
				},
				error : function(xhr, type, errorThrown) {
					toastr.error('Failure: ' + errorThrown);
				}
			});
		}
		
		function update() {
			var id = $("#id_edit").val();
			var merchant_id = $("#merchant_id_edit").val();
			if(merchant_id == "" || merchant_id == null) {
				toastr.warning("广告主ID不能为空！");
				return false;
			}
			var name = $("#name_edit").val();
			if(name == "" || name == null) {
				toastr.warning("活动名称不能为空！");
				return false;
			}
			var type = $("#type_edit:checked").val();
			if(type == "" || type == null) {
				toastr.warning("活动类型不能为空！");
				return false;
			}
			var charge_mode = $("#charge_mode_edit:checked").val();
			if(charge_mode == "" || charge_mode == null) {
				toastr.warning("计费类型不能为空！");
				return false;
			}
			var domain = $("#domain_edit").val();
			if(domain == "" || domain == null) {
				toastr.warning("网站域名不能为空！");
				return false;
			}
			var category = $("#category_edit").val();
			if(category == "" || category == null) {
				toastr.warning("广告主ID不能为空！");
				return false;
			}
			var is_active = $("#is_active_edit:checked").val();
			if(is_active == "" || is_active == null) {
				toastr.warning("是否激活必须选择！");
				return false;
			}
			$.ajax({
				url : "<%=basePath%>/banx/act/basic-activity/" + id,
				type : "POST",
				data : {
					merchant_id : merchant_id,
					name : name,
					type : type,
					charge_mode : charge_mode,
					domain : domain,
					category : category,
					is_active : is_active
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
