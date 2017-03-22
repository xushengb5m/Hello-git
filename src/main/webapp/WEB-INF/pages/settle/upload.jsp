<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-结算订单列表</title>
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


function importFileData(){
	$('#uaModal').modal('show');
}

function downloadTemplate(){
	$("#miss_form").attr("action","/settle/data/template").attr("method","get").submit();
}

function submitAttachment(){
	var file = $("#imgFile").val();
	var ext=file.replace(/.+\./,"");
	console.info(ext)
	if(ext!='xls' && ext!='xlsx'){
		alert("文件格式不对，请上传Excel文件!");
		return;
	}

	$('#miss_form').attr("method","post").form('submit',{
        url: '/settle/data/upload',
        onSubmit: function(){
        	if ($(this).form('validate')) {
        		$('#save').linkbutton('enable');
        		return true;
        	} else {
        		$('#save').linkbutton('enable');
        		return false;
        	}
        },
        success: function(result){
            var result = eval('('+result+')');
            if(result.status==true){
            	$('#uaModal').modal('hide');
            	alert(result.message);
            }else{
            	alert(result.message);
            }
			window.location.reload();
        }
    });
}
</script>
</head>

<body>
	<div class="wrapper wrapper-content animated fadeInRight">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h2>结算订单列表</h2>
						<div class="ibox-tools">
                        <a href="javascript:void(0)" onclick="importFileData()" class="btn btn-primary"><i class="fa"></i>上传Excel文件</a>
						</div>
					</div>
					<div class="ibox-content">
						<table id="tbl"
							class="table table-striped table-bordered table-hover dataTables-example">
							<thead>
								<tr>
									<th>唯一编号</th>
									<th>订单编号</th>
									<th>网站名称</th>
									<th>活动名称</th>
									<th>下单时间</th>
									<th>订单金额</th>
									<th>产品编号</th>
									<th>产品名称</th>
									<th>结算时间</th>
									<th>结算金额</th>
									<th>结算佣金</th>
									<th>币种</th>
									<th>操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="row" items="${requestScope.rows}">
									<tr class="gradeX">
										<td class="center" width="10%">${row.unique_id}</td>
										<td class="center" width="10%">${row.order_no}</td>
										<td class="center" width="5%">${row.website_id}</td>
										<td class="center" width="5%">${row.activity_id}</td>
										<td class="center" width="10%"><fmt:formatDate value="${row.order_time}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
										<td class="center" width="5%">${row.order_price}</td>
										<td class="center" width="5%">${row.prod_id}</td>
										<td class="center" width="10%">${row.prod_name}</td>
										<td class="center" width="10%"><fmt:formatDate value="${row.settle_time}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
										<td class="center" width="5%">${row.settle_money}</td>
										<td class="center" width="5%">${row.settle_commission}</td>
										<td class="center" width="10%">${row.currency}</td>
										<td class="center">
											<a href="javascrip:void(0)" onclick=""><button class="btn btn-success btn-sm" type="button">
												<i class="fa fa-pencil"></i>
											</button></a>
											<a href="javascrip:void(0)" onclick=""><button class="btn btn-info btn-circle btn-xs" type="button">
												<i class="fa fa-check"></i>
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

	<!-- UrlAccount模态框（Modal） -->
	<div class="modal fade" id="uaModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">
						<span>Excel上传</span>
					</h4>
				</div>
				<div class="modal-body">
					<div class="modal-body">
						<form class="form-horizontal m-t" id="miss_form"
							method='post' enctype="multipart/form-data">
							<input id="ua_id" name="id" type="hidden"/>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font>模板下载：</label>
								<div class="col-sm-8">
									 <button id="template" onclick="downloadTemplate()" class="form-control" rows="4">模板下载</button>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label"><font
									style="color: red">*</font>文件上传：</label>
								<div class="col-sm-8">
									<input id="imgFile" name="imgFile" type="file" class="form-control" rows="4"></input>
								</div>
							</div>
						</form>
						<div class="modal-footer">
							<button id="test" type="submit" class="btn btn-primary" onclick="submitAttachment();">提交</button>
							<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						</div>
					</div>
				</div>
				
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
		
		<form id="hiddenForm"></form>
	</div>	

<!-- Mainly scripts -->
<script src="/js/footer.js"></script>
</body>
</html>
