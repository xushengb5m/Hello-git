<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-站点管理</title>
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

function addWebSite(){
	$("#ua_form").form('clear');
	$("#flag").val("add");
	$("#url").val("http://");
	$("#is_enable").prop("checked",true);
	$("#ta").prop("checked",true);
	$("#vma").prop("checked",true);
	$('#uaModal').modal('show');
}
function editWebSite(obj,type,appType,valType,state){
	var table = $('#tbl').DataTable();
	var row = table.row(obj.parentNode.parentNode).data();
	var i=0,j=0;
	$("#ua_form").find("input,select,textarea").each(function(){
		if(j==3||j==4){
			if(j==4){
				i++;
			}
		}else if(j==5){
			$(this).val(type);
			i++;
		}else if(j==6||j==7){
			if(j==7){
				i++;
			}
		}else{
			$(this).val(row[i]);
			i++;
		}
		j++;
	});
	if(appType==1){
		$("#ta").prop("checked",true);
	}
	if(appType==2){
		$("#tb").prop("checked",true);
	}
	if(valType==1){
		$("#vma").prop("checked",true);
	}
	if(valType==2){
		$("#vmb").prop("checked",true);
	}
	if(state==true){
			$("#is_default").prop("checked",true);
	}else{
			$("#is_default").prop("checked",false);
	}
	$("#flag").val("update");
	$('#uaModal').modal('show');
}
function validateWebsite(id,a,b){
	$("#rid").val(id);
	if(a==1){
		$("#vsa").prop("checked",true);
	}
	if(a==2){
		$("#vsb").prop("checked",true);
	}
	if(a==3){
		$("#vsc").prop("checked",true);
	}
	
	if(b==1){
		$("#asa").prop("checked",true);
	}
	if(b==2){
		$("#asb").prop("checked",true);
	}
	if(b==3){
		$("#asc").prop("checked",true);
	}
	$('#vaModal').modal('show');
	
}

function deleteWebSite(){
	if(!confirm("确定删除?")) {
		return;
	}
}
</script>
</head>

<body>
	<div class="wrapper wrapper-content animated fadeInRight">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h2> 站点列表</h2>
						<div class="ibox-tools">
                        <a href="javascript:void(0)" onclick="addWebSite()" class="btn btn-primary"><i class="fa fa-plus"></i>新增站点 </a>
						</div>
					</div>
					<div class="ibox-content">
						<table id="tbl"
							class="table table-striped table-bordered table-hover dataTables-example">
							<thead>
								<tr>
									<th>编号</th>
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
											<a href="javascrip:void(0)" onclick="editWebSite(this,${row.type},${row.app_type},${row.verification_mode},${row.is_default})"><button class="btn btn-success btn-sm" type="button">
												<i class="fa fa-pencil"></i>
											</button></a>
											<%-- <a href="javascrip:void(0)" onclick="deleteWebSite(${row.id})"><button class="btn btn-success btn-sm" type="button">
												<i class="fa fa-trash-o"></i>
											</button></a> --%>
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

	<!-- UrlAccount模态框（Modal） -->
	<div class="modal fade" id="uaModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">
						<span>新增站点</span>
					</h4>
				</div>

				<div class="modal-body">
					<div class="modal-body">
						<form class="form-horizontal m-t" id="ua_form"
							action="">
							<input id="ua_id" name="id" type="hidden"/>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="website_name_id_span"></span>：</label>
								<div class="col-sm-8">
									 <input id="name" name="name" class="form-control" rows="4"/>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="website_URL_id_span"></span>：</label>
								<div class="col-sm-8">
									<input id="url" name="url" class="form-control" rows="4"></input>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="website_application_type_id_span"></span>：</label>
								<div class="col-sm-8">
									<label class="checkbox-inline">
									<input type="radio"
										name="app_type" id="ta" value="1"> 
										PC
									</label> <label class="checkbox-inline">
									<input type="radio"
										name="app_type" id="tb" value="2">
										APP
									</label>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="website_type_id_span"></span>：</label>
								<div class="col-sm-8">
									<select id="type" name="type" class="form-control"  rows="4" placeholder="请选择网站类型">
										<c:forEach var="cat" items="${requestScope.cats}">
											<option value="${cat.id}">${cat.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="website_validation_way_id_span"></span>：</label>
								<div class="col-sm-8">
									<div class="radio">
									<label>
									<input type="radio"
										name="verification_mode" id="vma" value="1"
										> 自动验证  
										(如果您的网站不支持自动验证的方式，请选择人工验证后，等待系统的验证结果。)
									</label>
									<div class="radio"> 
									<label>
									<input type="radio"
										name="verification_mode" id="vmb" value="2">
										人工验证   
										(如需快速验证，您可以进行上传HTML文件或者插入代码的方式进行自助验证。)
									</label>
									</div>
								</div>
							</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="website_daily_visit_ip_id_span"></span>：</label>
								<div class="col-sm-8">
									<input id="ip_per_day" name="ip_per_day" class="form-control"  rows="4"></input>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="website_intro_id_span"></span>：</label>
								<div class="col-sm-8">
									<textarea id="about" name="about" class="form-control"  rows="4"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="website_backup_id_span"></span>：</label>
								<div class="col-sm-8">
									<textarea id="record_info" name="record_info" class="form-control"  rows="4"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font><span id="website_is_default_id_span"></span>：</label>
								<div class="col-sm-8">
									<input type="checkbox" class="checkbox" id="is_default" name="is_default">
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
		function saveWebSite() {
			if($("#name").val()=="" || $("#name").val()==null){
				toastr.warning("网站名称不能为空！");
				return false;
			}
			if($("#url").val()=="" || $("#url").val()==null){
				toastr.warning("网站URL不能为空！");
				return false;
			}
			
	 		if($("#type").val()=="" || $("#type").val()==null){
				toastr.warning("请选择网站类型！");
				return false;
			} 
	 		
			if($("#ip_per_day").val()=="" || $("#ip_per_day").val()==null){
				toastr.warning("日访问量不能为空！");
				return false;
			}
			if($("#about").val()=="" || $("#about").val()==null){
				toastr.warning("网站简介不能为空！");
				return false;
			}
			if($("#record_info").val()=="" || $("#record_info").val()==null){
				toastr.warning("网站备案不能为空！");
				return false;
			}
			var params = $("#ua_form").serializeToJson();
			var a = $("#is_default").prop("checked");
			params.is_default=(a==true?"1":"0");
			$.ajax({
				url : "/web/site/saveWebsite.do",
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
					
					/* $.messager.toastr.warning('提示', result.message, 'info'); */
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
