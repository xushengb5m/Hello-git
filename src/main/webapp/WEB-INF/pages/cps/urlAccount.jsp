<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-URL账户</title>
<script type="text/javascript">
function addUrlAccount(){
	$("#ua_form").form('clear');
	$("#pattern_id").val("${patternId}");
	$("#flag").val("add");
	$("#is_enable").prop("checked",true);
	$('#uaModal').modal('show');
}
function editUrlAccount(obj,state){
	var row = table.row(obj.parentNode.parentNode).data();
	var i=0;
	$("#ua_form").find("input,select").each(function(){
		$(this).val(row[i]);
		i++;
	});
	if(state==true){
		$("#is_enable").prop("checked",true);
	}else{
		$("#is_enable").prop("checked",false);
	}
	$("#flag").val("update");
	$('#uaModal').modal('show');
	
/* 	var i=0;
	var table = $('#tbl').DataTable();
	var row = table.row('.selected').data();
	if(!row){
		toastr.warning("请选择行!");
	}
	$("#ua_form input").each(function(){
		$(this).val(row[i]);
		i++;
	});
	$("#flag").val("update");
	$('#uaModal').modal('show'); */
}
function deleteUrlAccount(){
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
		<div class="row">
			<div class="col-lg-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h2>
							URL账户
						</h2>
						<div class="ibox-tools">
							<div class="ibox-tools">
	                        <a href="javascript:void(0)" onclick="addUrlAccount()" class="btn btn-primary"><i class="fa fa-plus"></i>新增规则 </a>
						</div>
						</div>
					</div>
					<div class="ibox-content">
						<table id="tbl"
							class="table table-striped table-bordered table-hover dataTables-example">
							<thead>
								<tr>
									<th>编号</th>
									<th>跳转规则ID</th>
									<c:forEach var="tm" items="${requestScope.tms}">
									<th>${tm.val}</th>
									</c:forEach>
									<th>联盟账号</th>
									<th>联盟用户ID</th>
									<th>关联域名</th>
									<th>是否有效</th>
									<!-- <th>创建时间</th>
									<th>创建用户</th>
									<th>更新时间</th> -->
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="row" items="${requestScope.rows}">
									<tr class="gradeX">
										<td class="center">${row.id}</td>
										<td class="center" width="5%">${row.pattern_id}</td>
										<c:forEach var="jst" items="${row.jsonList}">
											<td class="center">${jst}</td>
										</c:forEach>
										<td class="center" width="10%">${row.union_account}</td>
										<td class="center" width="10%">${row.user_id}</td>
										<td class="center">${row.host}</td>
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
										<a href="javascrip:void(0)" onclick="editUrlAccount(this,${row.is_enable})"><button class="btn btn-success btn-sm" type="button">
												<i class="fa fa-pencil"></i>
											</button></a>
										<%-- <a href="/cpsp/exchangePatternById.do?id=${row.pattern_id}">所属规则</a>
										<a href="javascrip:void(0)" onclick="deleteUrlAccount()">删除</a> --%>
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
						<span>添加URL账户</span>
					</h4>
				</div>

				<div class="modal-body">
					<div class="modal-body">
						<form class="form-horizontal m-t" id="ua_form"
							action="">
							<input id="ua_id" name="id" type="hidden"/>
							<input id="pattern_id" name="pattern_id" type="hidden"/>
							<c:forEach var="qq" items="${requestScope.tms}">
								<div class="form-group">
									<label class="col-sm-4 control-label"><font
										style="color: red">*</font><span>${qq.val}</span>：</label>
									<div class="col-sm-8">
										<input id="${qq.key}" name="${qq.key}" class="form-control"  rows="4"></input>
									</div>
								</div>
							</c:forEach>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span>联盟账号</span>：</label>
								<div class="col-sm-8">
									<input id="union_account" name="union_account" class="form-control"  rows="4"></input>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span>联盟用户ID</span>：</label>
								<div class="col-sm-8">
									<input id="user_id" name="user_id" class="form-control"  rows="4"></input>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span>关联域名</span>：</label>
								<div class="col-sm-8">
									<input id="host" name="host" class="form-control"  rows="4"></input>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span>是否有效</span>：</label>
								<div class="col-sm-8">
									<input type="checkbox" class="checkbox" id="is_enable" name="is_enable"/>
								</div>
							</div>
							<input id="flag" name="flag" type="hidden" />
						</form>
						<div class="modal-footer">
							<button id="test" type="submit" class="btn btn-primary" onclick="saveUrlAccount();">提交</button>
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
		            /* var rowId = table.row('.selected').data()[0]; */
		    } );
		 
		    $('#button').click( function () {
		        table.row('.selected').remove().draw( false );
		    } );

		}
		
		function saveUrlAccount() {
			if($("#union_account").val()=="" || $("#union_account").val()==null){
				toastr.warning("联盟账号不能为空！");
				return false;
			}
			if($("#user_id").val()=="" || $("#user_id").val()==null){
				toastr.warning("联盟账户ID不能为空！");
				return false;
			}
			if($("#host").val()=="" || $("#host").val()==null){
				toastr.warning("关联域名不能为空！");
				return false;
			}
			var params = $("#ua_form").serializeToJson();
			var a = $("#is_enable").prop("checked");
			params.is_enable=(a==true?"1":"0");
			$.ajax({
				url : "/cps/act/saveUrlAccount.do",
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
