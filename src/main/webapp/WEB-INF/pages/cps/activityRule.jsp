<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-URL账户</title>
<script type="text/javascript">
function addActivityRule(){
	$("#ar_form").form('clear');
	$("#start_id").val(0);
	$("#end_id").val(100);
	$("#flag").val("add");
	$("#is_enable").prop("checked",true);
	$('#arModal').modal('show');
}
function editActivityRule(pid){
	$.ajax({
		url : "/cps/rule/getOneRuleById.do?pid="+pid,
		type : "GET",
		dataType : "json",
		success : function(data) {
			$("#id").val(pid);
			$("#activity_id").val(data["activity_id"]);			
			$("#account_id").val(data["account_id"]);
			$("#note").val(data["note"]);
			$("#start_id").val(data["start_id"]);
			$("#end_id").val(data["end_id"]);
			if(data["is_enable"]==true){
				$("#is_enable").prop("checked",true);
			}else{
				$("#is_enable").prop("checked",false);
			}
			$("#flag").val("update");
			$('#arModal').modal('show');
		},
		error : function(xhr, type, errorThrown) {
			toastr.error('Failure: ' + errorThrown);
		}
	});
	/* var row = table.row(obj.parentNode.parentNode).data();
	var i=0;
	$("#ar_form").find("input,select").each(function(){
		$(this).val(row[i]);
		i++;
	});
	if(state==true){
		$("#is_enable").prop("checked",true);
	}else{
		$("#is_enable").prop("checked",false);
	} 
	$("#flag").val("update");
	$('#arModal').modal('show');*/
}
function deleteActivityRule(obj){
	if(!confirm("确定删除?")) {
		return;
	}
	$.ajax({
		url : "/cps/rule/deleteActivityrule.do",
		type : "POST",
		data : {rowId:obj},
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
						<h2>CPS活动规则</h2>
						<div class="ibox-tools">
							<div class="ibox-tools">
	                        <a href="javascript:void(0)" onclick="addActivityRule()" class="btn btn-primary"><i class="fa fa-plus"></i>新增活动规则 </a>
							</div>
						</div>
					</div>
					<div class="ibox-content">
						<table id="tbl"
							class="table table-striped table-bordered table-hover dataTables-example">
							<thead>
								<tr>
									<th>编号</th>
									<th>活动ID</th>
									<th>联盟账户ID</th>
									<th>规则描述</th>
									<th>开始(默认0)</th>
									<th>结束(默认100)</th>
									<th>是否有效</th>
									<!-- <th>create_time</th>
									<th>create_by</th>
									<th>update_time</th> -->
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="row" items="${requestScope.rows}">
									<tr class="gradeX">
										<td class="center">${row.id}</td>
										<td class="center">${row.activity_id}</td>
										<td class="center">${row.account_id}</td>
										<td class="center">${row.note}</td>
										<td class="center">${row.start_id}</td>
										<td class="center">${row.end_id}</td>
										<td class="center">
										&nbsp;&nbsp;&nbsp;
										<c:if test="${row.is_enable=='true'}">
											<button class="btn btn-info btn-circle btn-xs" type="button">
												<i class="fa fa-check"></i>
											</button>
										</c:if>
										<c:if test="${row.is_enable=='false' }">
											<button class="btn btn-warning btn-circle btn-xs"
												type="button">
												<i class="fa fa-times"></i>
											</button>
										</c:if></td>
										<%-- <td class="center">${row.create_time}</td>
										<td class="center">${row.create_by}</td>
										<td class="center">${row.update_time}</td> --%>
										<td class="center" width="10%">
										<a href="javascrip:void(0)" onclick="editActivityRule(${row.id})"><button class="btn btn-success btn-sm" type="button">
												<i class="fa fa-pencil"></i>
											</button></a>
										<a href="javascrip:void(0)" onclick="deleteActivityRule(${row.id})"><button class="btn btn-success btn-sm" type="button">
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
		<!-- 按钮触发模态框 -->

		<!-- ActivityRule模态框（Modal） -->
	<div class="modal fade" id="arModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">

				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">
						<span>添加活动规则</span>
					</h4>
					
				</div>
				
				<div class="modal-body">
					<div class="modal-body">
						<form class="form-horizontal m-t" id="ar_form"
							action="">
							<input id="id" name="id" type="hidden"></input>
							
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="commission_info_activity_id_span"></span>：</label>
								<div class="col-sm-8">
									<select id="activity_id" name="activity_id" onchange="dynamic()" class="form-control">
										<c:forEach var="act" items="${requestScope.activities}">
											<option value="${act.id}">${act.id}||${act.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="activity_rule_union_account_id_span"></span>：</label>
								<div class="col-sm-8">
									<select id="account_id" name="account_id" class="form-control">
									<c:forEach var="rule" items="${requestScope.rules}">
										<option value="${rule.id}">${rule.union_account}||${rule.user_id}||${rule.host}</option>
									</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="activity_rule_desc_id_span"></span>：</label>
								<div class="col-sm-8">
									<input id="note" name="note"class="form-control"  rows="4"></input>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="activity_rule_default_start_id_span"></span>：</label>
								<div class="col-sm-8">
									<input id="start_id" name="start_id" class="form-control" value="0" rows="4"></input>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="activity_rule_default_end_id_span"></span>：</label>
								<div class="col-sm-8">
									<input id="end_id" name="end_id" class="form-control" value="100" rows="4"></input>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="activity_rule_is_enable_id_span"></span>：</label>
								<div class="col-sm-8">
									<input type="checkbox" class="checkbox" id="is_enable" name="is_enable" >
								</div>
							</div>
							<input id="flag" name="flag" type="hidden" />
						</form>
						<div class="modal-footer">
							<button id="test" type="submit" class="btn btn-primary" onclick="saveActivityRule();">提交</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						</div>
					</div>
				</div>
				
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
		
	</div>
</div>
	

<!-- Mainly scripts -->
<script type="text/javascript">
		var table = $('#tbl').DataTable();
		window.onload = function() {
			$('.dataTables-example').dataTable();
			switchLanguage(language_flag);
			$('#tbl tbody').on( 'click', 'td', function () {
			    var index = table.cell( this ).cell(this).index();
			    if(index.column==2){
			    	
			    }
			    if(index.column==1){
			    	
			    }
			    
			} );
			
			$('#tbl tbody').on('click', 'tr', function () {
		        var tr = $(this).closest('tr');
		        if ( $(this).hasClass('selected') ) {
		            $(this).removeClass('selected');
		        }
		        else {
		            table.$('tr.selected').removeClass('selected');
		            $(this).addClass('selected');
		        }
		    } );

		}
		
		function saveActivityRule() {
			if($("#activity_id").val()=="" || $("#activity_id").val()==null){
				toastr.warning("活动不能为空！");
				return false;
			}
			if($("#account_id").val()=="" || $("#account_id").val()==null){
				toastr.warning("账户不能为空！");
				return false;
			}
			if($("#note").val()=="" || $("#note").val()==null){
				toastr.warning("规则描述不能为空！");
				return false;
			}
			var params = $("#ar_form").serializeToJson();
			var a = $("#is_enable").prop("checked");
			params.is_enable=(a==true?"1":"0");
			$.ajax({
				url : "/cps/rule/saveActivityrule.do",
				type : "POST",
				data : params,
				dataType : "json",
				success : function(result) {
					if(result.statue==true){
						$('#arModal').modal('hide');
						toastr.success(result.message);
						window.location.reload();
					}else{
						toastr.warning(result.message);
					}
				},
				error : function(xhr, type, errorThrown) {
					toastr.warning('提交失败: ' + errorThrown);
				}
			});
		}

	</script>
	<script src="/js/footer.js"></script>
</body>
</html>
