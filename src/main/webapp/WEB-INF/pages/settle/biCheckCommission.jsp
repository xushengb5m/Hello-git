<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-站点审核</title>
<script type="text/javascript">
var table = $('#tbl').DataTable();
window.onload = function() {
	$('.dataTables-example').dataTable();
}
function checkWebsite(obj){
	var table = $('#tbl').DataTable();
	var row = table.row(obj.parentNode.parentNode).data();
	var i=0;
	$("#ua_form").find("input,select").each(function(){
		$(this).val(row[i]);
		i++;
	});
	if(row[7]=="true"){
		$("#is_enable").attr("checked","checked");
	}
	$("#flag").val("update");
	$('#uaModal').modal('show');
}

(function ($) {
	  window.Ewin = function () {
	    var html = '<div id="[Id]" class="modal fade" role="dialog" aria-labelledby="modalLabel">' +
	               '<div class="modal-dialog modal-sm">' +
	                 '<div class="modal-content">' +
	                   '<div class="modal-header">' +
	                     '<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>' +
	                     '<h4 class="modal-title" id="modalLabel">[Title]</h4>' +
	                   '</div>' +
	                   '<div class="modal-body">' +
	                   '<p>[Message]</p>' +
	                   '</div>' +
	                    '<div class="modal-footer">' +
	    '<button type="button" class="btn btn-default cancel" data-dismiss="modal">[BtnCancel]</button>' +
	    '<button type="button" class="btn btn-primary ok" data-dismiss="modal">[BtnOk]</button>' +
	  '</div>' +
	                 '</div>' +
	               '</div>' +
	             '</div>';
		var dialogdHtml = '<div id="[Id]" class="modal fade" role="dialog" aria-labelledby="modalLabel">' +
		'<div class="modal-dialog">' +
		  '<div class="modal-content">' +
		    '<div class="modal-header">' +
		      '<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>' +
		      '<h4 class="modal-title" id="modalLabel">[Title]</h4>' +
		    '</div>' +
		    '<div class="modal-body">' +
		    '</div>' +
		  '</div>' +
		'</div>' +
		'</div>';
		var reg = new RegExp("\\[([^\\[\\]]*?)\\]", 'igm');
		var generateId = function () {
		var date = new Date();
		return 'mdl' + date.valueOf();
		}
		var init = function (options) {
			options = $.extend({}, {
			title: "操作提示",
			message: "提示内容",
			btnok: "确定",
			btncl: "取消",
			width: 200,
			auto: false
			}, options || {});
		var modalId = generateId();
		var content = html.replace(reg, function (node, key) {
		return {
			Id: modalId,
			Title: options.title,
			Message: options.message,
			BtnOk: options.btnok,
			BtnCancel: options.btncl
			}[key];
		});
		$('body').append(content);
		$('#' + modalId).modal({
			width: options.width,
			backdrop: 'static'
		});
		$('#' + modalId).on('hide.bs.modal', function (e) {
		$('body').find('#' + modalId).remove();
		});
			return modalId;
		}
		
		return {
		alert: function (options) {
		if (typeof options == 'string') {
			options = {
			message: options
		};
		}
		var id = init(options);
		var modal = $('#' + id);
		modal.find('.ok').removeClass('btn-success').addClass('btn-primary');
		modal.find('.cancel').hide();
		
		return {
			id: id,
			on: function (callback) {
			if (callback && callback instanceof Function) {
			modal.find('.ok').click(function () { callback(true); });
		}
		},
		hide: function (callback) {
		if (callback && callback instanceof Function) {
			modal.on('hide.bs.modal', function (e) {
			callback(e);
		});
		}
		}
		};
		},
		confirm: function (options) {
		var id = init(options);
		var modal = $('#' + id);
			modal.find('.ok').removeClass('btn-primary').addClass('btn-success');
			modal.find('.cancel').show();
		return {
		id: id,
		on: function (callback) {
		if (callback && callback instanceof Function) {
			modal.find('.ok').click(function () { callback(true); });
			modal.find('.cancel').click(function () { callback(false); });
		}
		},
		hide: function (callback) {
		if (callback && callback instanceof Function) {
			modal.on('hide.bs.modal', function (e) {
			callback(e);
		});
		}
		}
		};
		},
			dialog: function (options) {
			options = $.extend({}, {
			title: 'title',
			url: '',
			width: 800,
			height: 550,
			onReady: function () { },
			onShown: function (e) { }
		}, options || {});
		var modalId = generateId();
		
		var content = dialogdHtml.replace(reg, function (node, key) {
		return {
			Id: modalId,
			Title: options.title
			}[key];
		});
		$('body').append(content);
		var target = $('#' + modalId);
			target.find('.modal-body').load(options.url);
		if (options.onReady())
			options.onReady.call(target);
			target.modal();
			target.on('shown.bs.modal', function (e) {
		if (options.onReady(e))
			options.onReady.call(target, e);
		});
			target.on('hide.bs.modal', function (e) {
		$('body').find(target).remove();
		});
		}
		}
		}();
})(jQuery);

function checkDo(){
	Ewin.confirm({ message: "确认审核通过吗？" }).on(function (e) {
		if (!e) {
			return;
		}
	});
}
</script>
</head>

<body>
<div class="wrapper wrapper-content animated fadeInRight">
		<div class="row">
			<div class="col-lg-12">
				<div class="ibox float-e-margins">
					<div class="ibox-title">
						<h2>
							佣金申请列表
						</h2>
						<div class="ibox-tools">
								<select id="pay_stat" name="pay_stat" class="form-control">
										<option value="2" >全部</option> 
										<option value="0">未支付</option> 
										<option value="1">已支付</option> 
								</select>
						</div>
					</div>
					<div class="ibox-content">
						<table id="tbl"
							class="table table-striped table-bordered table-hover dataTables-example">
							<thead>
								<tr>
									<th>网站主ID</th>
									<th>申请账户</th>
									<th>年月</th>
									<th>申请时间</th>
									<th>申请提现金额</th>
									<th>支付状态</th>
									<th>审核状态</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="row" items="${requestScope.rows}">
									<tr class="gradeX">
										<td class="center">${row.user_id}</td>
										<td class="center">${row.email}</td>
										<td class="center">${row.the_date}</td>
										<td class="center">${row.apply_date}</td>
										<td class="center">${row.apply_money}</td>
										<td class="center">
											<c:if test="${row.pay_state==0 }">
												<a href="javascript:void(0)"><button
														class="btn btn-default btn-sm" type="button">
														<i class=" ">&nbsp;待支付</i>
													</button></a>
											</c:if>
											<c:if test="${row.pay_state==1}">
												<a href="javaScript:void(0);"><button
														class="btn btn-default btn-sm" type="button">
														<i class=" ">已支付</i>
													</button></a>
											</c:if>
											<c:if test="${row.pay_state==2}">
												<a href="javaScript:void(0);"><button
														class="btn btn-default btn-sm" type="button">
														<i class="">未支付</i>
													</button></a>
											</c:if>
										</td>
										<td class="center">
											<c:if test="${row.check_state==0 }">
												<a href="/settle/bi/checkView/${row.user_id}/${row.the_year}/${row.the_month}" ><button
														class="btn btn-primary btn-sm" type="button">
														<i class="fa fa-edit">&nbsp;审核中</i>
													</button></a>
											</c:if>
											<c:if test="${row.check_state==1}">
												<a href="javaScript:void(0);"><button
														class="btn btn-default btn-sm" type="button">
														<i class=" ">审核通过</i>
													</button></a>
											</c:if>
											<c:if test="${row.check_state==2}">
												<a href="/settle/bi/checkView/${row.user_id}/${row.the_year}/${row.the_month}"><button
														class="btn btn-primary btn-sm" type="button">
														<i class="fa fa-edit">审核不通过</i>
													</button></a>
											</c:if>
										<%-- <c:if test="${row.pay_state==1}">已支付
										</c:if>
										<c:if test="${row.pay_state==0}">未支付
										</c:if> --%>
										</td>
										
									</tr> 
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		</div>
	<script src="/js/footer.js"></script>
</body>
</html>
