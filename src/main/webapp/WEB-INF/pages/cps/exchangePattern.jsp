<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-规则模式</title>
<script type="text/javascript">
function addExchangePattern(){
	$("#ea_form").form('clear');
	$("#flag").val("add");
	$("#is_enable").prop("checked",true);
	$('#eaModal').modal('show');
}
function editExchangePattern(pid){
	$.ajax({
		url : "/cps/pattern/getOnePatternById.do?pid="+pid,
		type : "GET",
		dataType : "json",
		success : function(data) {
			console.info(data)
			$("#ua_id").val(pid);					
			$("#union_name").val(data["union_name"]);			
			$("#union_type").val(data["union_type"]);
			$("#handle_type").val(data["handle_type"]);
			$("#click_type").val(data["click_type"]);
			$("#url_pattern_note").val(data["url_pattern_note"]);
			$("#url_pattern_addr").val(data["url_pattern_addr"]);
			$("#url_param_fb").val(data["url_param_fb"]);
			$("#url_param_to").val(data["url_param_to"]);
			$("#url_param_ac").val(data["url_param_ac"]);
			if(data["is_url_to_encode"]==true){
				$("#is_url_to_encode").prop("checked",true);
			}else{
				$("#is_url_to_encode").prop("checked",false);
			}
			$("#url_account_pattern").val(data["url_account_pattern"]);
			if(data["is_enable"]==true){
				$("#is_enable").prop("checked",true);
			}else{
				$("#is_enable").prop("checked",false);
			}
			$("#flag").val("update");
			$('#eaModal').modal('show');
		},
		error : function(xhr, type, errorThrown) {
			toastr.error('Failure: ' + errorThrown);
		}
	});
	
	/* var row = table.row(obj.parentNode.parentNode).data();
	var i=0;
	$("#ea_form").find("input,select,textarea").each(function(){
		row[i] = row[i].replace("&amp;","&");
		$(this).val(row[i]);
		i++;
	});
	selectValue("union_type",row[2]);
	selectValue("handle_type",row[3]);
	selectValue("click_type",row[4]);
	if(encode==true){
		$("#is_url_to_encode").prop("checked",true);
	}else{
		$("#is_url_to_encode").prop("checked",false);
	}
	if(state==true){
		$("#is_enable").prop("checked",true);
	}else{
		$("#is_enable").prop("checked",false);
	}
	 */
	
}
function deleteExchangePattern(){
	var table = $('#tbl').DataTable();
	var row = table.row('.selected').data();
	if(!row){
		toastr.warning("请选择行!");
	}
	toastr.warning("确认删除选中项?")
	
}

</script>
</head>

<style>
/*     #myModal
    {
        top:300px;
        right:500px;
    } */
</style>

<body>
<div class="wrapper wrapper-content animated fadeInRight">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h2>
							CPS规则模式
						</h2>
						<div class="ibox-tools">
							<div class="ibox-tools">
	                        <a href="javascript:void(0)" onclick="addExchangePattern()" class="btn btn-primary"><i class="fa fa-plus"></i>新增规则 </a>
							</div>
						</div>
					</div>
					<div class="ibox-content">
						<table id="tbl"
							class="table table-striped table-bordered table-hover dataTables-example">
								<tr>
									<th>编号</th>
									<th>联盟名称</th>
									<th>联盟类型</th>
									<th>url处理类型(PDSI)</th>
									<th>点击结算类型</th>
									<th>跳转规则说明</th>
									<th>跳转规则地址</th>
									<th>反馈标签字段</th>
									<th>目的地址字段</th>
									<th>联盟账号字段</th>
									<th>是否encode</th>
									<th>链接账号规则</th>
									<th>是否有效</th>
									<th>操作</th>
								</tr>
								<c:forEach var="row" items="${requestScope.rows}">
									<tr class="gradeX">
										<td>${row.id}</td>
										<td>${row.union_name}</td>
										<td>
											<c:if test="${row.union_type eq 1 }">自营</c:if>
											<c:if test="${row.union_type eq 2 }">第三方联盟</c:if>
										</td>
										<td>
											<c:if test="${row.handle_type eq 1 }">参数拼接</c:if>
											<c:if test="${row.handle_type eq 2 }">字符格式化</c:if>
											<c:if test="${row.handle_type eq 3 }">MF字符格式化</c:if>
											<c:if test="${row.handle_type eq 4 }">自跳转</c:if>
											<c:if test="${row.handle_type eq 5 }">IUnionHandler</c:if>
										</td>
										<td>
											<c:if test="${row.click_type eq 1 }">CPS</c:if>
											<c:if test="${row.click_type eq 2 }">CPC</c:if>
											<c:if test="${row.click_type eq 3 }">CPA</c:if>
										</td>
										<td><textarea disabled="disabled" style="margin: 0px; height: 85px; width: 196px;">${row.url_pattern_note}</textarea></td>
										<td><textarea disabled="disabled" style="margin: 0px; height: 85px; width: 196px;">${row.url_pattern_addr}</textarea></td>
										<td>${row.url_param_fb}</td>
										<td>${row.url_param_to}</td>
										<td>${row.url_param_ac}</td>
										<td>
											<c:if test="${row.is_url_to_encode=='true' }">
											<button class="btn btn-info btn-circle btn-xs" type="button">
												<i class="fa fa-check"></i>
											</button>
										</c:if>
										<c:if test="${row.is_url_to_encode=='false' }">
											<button class="btn btn-warning btn-circle btn-xs"
												type="button">
												<i class="fa fa-times"></i>
											</button>
										</c:if>
										</td>
										<td><textarea disabled="disabled" style="margin: 0px; height: 85px; width: 196px;">${row.url_account_pattern}</textarea></td>
										<td>
										<c:if test="${row.is_enable=='true' }">
											<button class="btn btn-info btn-circle btn-xs" type="button">
												<i class="fa fa-check"></i>
											</button>
										</c:if>
										<c:if test="${row.is_enable=='false' }">
											<button class="btn btn-warning btn-circle btn-xs"
												type="button">
												<i class="fa fa-times"></i>
											</button>
										</c:if>
										</td>
										<td>
											<a href="javascrip:void(0)" onclick="editExchangePattern(${row.id})"><button class="btn btn-success btn-sm" type="button">
												<i class="fa fa-pencil"></i>
											</button></a>
											<a href="/cps/act/urlaccountById.do?id=${row.id}"><button class="btn btn-success btn-sm" type="button">
												<i class="fa fa-share"></i>
											</button></a>
										</td>
									</tr>
								</c:forEach>
						</table>
					</div>
				</div>
		<!-- 按钮触发模态框 -->

	<!-- UrlAccount模态框（Modal） -->
	<div class="modal fade" id="eaModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">
						<span>添加规则模式</span>
					</h4>
				</div>

				<div class="modal-body">
					<div class="modal-body">
						<form class="form-horizontal m-t" id="ea_form"
							action="">
							<input id="ua_id" name="id" type="hidden"/>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span>联盟名称</span>：</label>
								<div class="col-sm-8">
									<input id="union_name" name="union_name" class="form-control" type="text">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span>联盟类型</span>：</label>
								<div class="col-sm-8">
									<select id="union_type" name="union_type" class="form-control" rows="4">
										<option value="1">自营</option>
										<option value="2">第三方联盟</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span>url处理类型</span>：</label>
								<div class="col-sm-8">
									<select id="handle_type" name="handle_type" class="form-control"  rows="4">
										<option value="1">参数拼接</option>
										<option value="2">字符格式化</option>
										<option value="3">MF字符格式化</option>
										<option value="4">自跳转</option>
										<option value="5">IUnionHandler</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span>点击结算类型</span>：</label>
								<div class="col-sm-8">
									<select id="click_type" name="click_type" class="form-control"  rows="4">
										<option value="1">CPS</option>
										<option value="2">CPC</option>
										<option value="3">CPA</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span>跳转规则说明</span>：</label>
								<div class="col-sm-8">
									<textarea id="url_pattern_note" name="url_pattern_note" class="form-control"  rows="4"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span>跳转规则地址</span>：</label>
								<div class="col-sm-8">
									<textarea id="url_pattern_addr" name="url_pattern_addr" class="form-control"  rows="4"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span>反馈标签字段</span>：</label>
								<div class="col-sm-8">
									<input id="url_param_fb" name="url_param_fb" class="form-control"  rows="4"></input>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span>目的地址字段</span>：</label>
								<div class="col-sm-8">
									<input id="url_param_to" name="url_param_to" class="form-control"  rows="4"></input>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span>联盟账号字段</span>：</label>
								<div class="col-sm-8">
									<input id="url_param_ac" name="url_param_ac" class="form-control"  rows="4"></input>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span>是否encode</span>：</label>
								<div class="col-sm-8">
									<input id="is_url_to_encode" name="is_url_to_encode" type="checkbox" class="checkbox">
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span>链接账号规则</span>：</label>
								<div class="col-sm-8">
									<textarea id="url_account_pattern" name="url_account_pattern" class="form-control"  rows="4"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span>是否有效</span>：</label>
								<div class="col-sm-8">
									<input type="checkbox" class="checkbox" id="is_enable" name="is_enable" />
								</div>
							</div>
							<input id="flag" name="flag" type="hidden" />
						</form>
						<div class="modal-footer">
							<button id="test" type="submit" class="btn btn-primary" onclick="saveExchangePattern();">提交</button>
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
			
			$('#tbl tbody').on( 'click', 'tr', function () {
		            table.$('tr.selected').removeClass('selected');
		            $(this).addClass('selected');
		    } );
		 
		    $('#button').click( function () {
		        table.row('.selected').remove().draw( false );
		    } );

		}
		
		function saveExchangePattern() {
			if($("#union_name").val()=="" || $("#union_name").val()==null){
				toastr.warning("联盟名称不能为空！");
				return false;
			}
			
			if($("#union_type").val()=="" || $("#union_type").val()==null){
				toastr.warning("联盟类型不能为空！");
				return false;
			}
			
			if($("#handle_type").val()=="" || $("#handle_type").val()==null){
				toastr.warning("url处理类型不能为空！");
				return false;
			}
			
			if($("#click_type").val()=="" || $("#click_type").val()==null){
				toastr.warning("点击结算类型不能为空！");
				return false;
			}
			
			if($("#url_pattern_note").val()=="" || $("#url_pattern_note").val()==null){
				toastr.warning("跳转规则说明不能为空！");
				return false;
			}
			
			if($("#url_pattern_addr").val()=="" || $("#url_pattern_addr").val()==null){
				toastr.warning("跳转规则地址不能为空！");
				return false;
			}
			
			var params = $("#ea_form").serializeToJson();
			var a = $("#is_url_to_encode").prop("checked");
			params.is_url_to_encode=(a==true?"1":"0");
			var b = $("#is_enable").prop("checked");
			params.is_enable=(b==true?"1":"0");
			
			var jsonConfig = $("#url_account_pattern").val();
			try{
				var jsonArray = $.parseJSON(jsonConfig);
			}catch (e) {
				toastr.warning("输入的JSON格式有误!");
				return false;
			}
			$.ajax({
				url : "/cps/pattern/saveExchangePattern.do",
				type : "POST",
				data : params,
				dataType : "json",
				success : function(result) {
					if(result.statue==true){
						$('#eaModal').modal('hide');
						toastr.success(result.message);
						window.location.reload();
					}else{
						toastr.warning(result.message);
					}
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
