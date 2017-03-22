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
		<div class="col-lg-2"></div>
			<div class="col-lg-8">
				<div class="panel blank-panel">
					<div class="panel-heading">
						<div class="row">
							<div class="panel-title m-b-md col-lg-6">
								<h1>${row.name }
									<small><fmt:formatDate value="${row.start_date}"
											pattern="yyyy-MM-dd" /> 至 <fmt:formatDate
											value="${row.end_date}" pattern="yyyy-MM-dd" /></small>
								</h1>
							</div>
						</div>

						<div class="row">
							<div class="panel-title m-b-md col-lg-6">
								<p class="text-warning lead">佣金比例: ${row.commission }&nbsp;&nbsp;&nbsp;&nbsp;
								<c:if test="${approval.approval_status==1 }">
									<button type="button" class="btn btn-primary btn-rounded"
									data-toggle="modal" data-target="#myModal"><i class="fa fa-link"></i>&nbsp;获取链接</button>				
								</c:if>
								<c:if test="${approval.approval_status==0 }">
									<button type="button" class="btn btn-warning btn-rounded"><i class="fa fa-play"></i>&nbsp;审核中</button>				
								</c:if>
								<c:if test="${approval.approval_status==-1 }">
									<button type="button" class="btn btn-danger btn-rounded"><i class="fa fa-times"></i>&nbsp;审核未通过</button>				
								</c:if>
								<c:if test="${approval.approval_status==null }">
									<button type="button" class="btn btn-default btn-rounded"><i class="fa fa-stop"></i>&nbsp;未申请</button>				
								</c:if>
								
								<div class="modal inmodal" id="myModal" tabindex="-1"
									role="dialog" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content animated fadeIn">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal">
													<span aria-hidden="true">&times;</span><span
														class="sr-only">关闭</span>
												</button>
												<!-- <i class="fa fa-laptop modal-icon"></i> -->
												<h5 class="modal-title">获取自定义链接</h5>
											</div>

											<div class="modal-body">
												<div class="modal-body">
													<form class="form-horizontal m-t" id="">
														<input type="hidden" id="sid" value="${web.id }">
														<input type="hidden" id="uid" value="${web.supply_id }">
														<input type="hidden" id="aid" value="${row.activity_id }">
														
														<div class="form-group">
															<label class="col-sm-4 control-label"><font
																style="color: red"></font><span
																id="">推广站点</span>：</label>
															<div class="col-sm-8">
																<input id="web_name" class="form-control"
																	type="text" value="${web.name }-${web.url}" readonly>
															</div>
														</div>
														
														<div class="form-group">
															<label class="col-sm-4 control-label"><font
																style="color: red"></font><span
																id="">链接类型</span>：</label>
															<div class="col-sm-8">
																<select class="form-control" id="link_type">
																	<option value="urlLink">纯url</option>
																	<option value="wordLink">文字链</option>
																	<!-- <option value="photoLink">图片</option>
																	<option value="qrcode">二维码</option> -->
																</select>
															</div>
														</div>

														<%-- <div class="form-group">
															<label class="col-sm-4 control-label"><font
																style="color: red"></font><span
																id="">目标网址类型</span>：</label>
															<div class="col-sm-8">
																<select class="form-control" id="activity_id_edit"
																	name="activity_id">
																	<c:forEach var="activity"
																		items="${requestScope.activities }">
																		<option value="${activity.id }">${activity.name }</option>
																	</c:forEach>
																</select>
															</div>
														</div> --%>
														<div class="form-group">
															<label class="col-sm-4 control-label"><font
																style="color: red"></font><span
																id="">目标网址类型</span>：</label>
															<div class="col-sm-8">
																<input class="form-control" type="text" value="${row.name }" readonly>
															</div>
														</div>
														
														<div class="form-group">
															<label class="col-sm-4 control-label"><font
																style="color: red"></font><span
																id="">目标网址</span>：</label>
															<div class="col-sm-8">
																<textarea class="form-control" id="tu" rows="4">${row.domain }</textarea>
															</div>
														</div>

														<div class="form-group">
															<label class="col-sm-4 control-label"><font
																style="color: red"></font><span
																id="">反馈标签(fb)</span>：</label>
															<div class="col-sm-8">
																<input id="fb" class="form-control" type="text">
															</div>
														</div>

													</form>
												</div>
											</div>

											<div class="modal-footer">
												<button type="button" class="btn btn-primary" onclick="showCode();">生成链接</button>
											</div>
										</div>
									</div>
								</div>
								
								<div class="modal inmodal" id="myUrl" tabindex="-1"
									role="dialog" aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content animated fadeIn">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal">
													<span aria-hidden="true">&times;</span><span
														class="sr-only">关闭</span>
												</button>
												<!-- <i class="fa fa-laptop modal-icon"></i> -->
												<h5 class="modal-title">推广代码</h5>
											</div>

											<div class="modal-body">
												<div class="modal-body">
													<form class="form-horizontal m-t" id="">

														<div class="form-group">
															<div class="col-sm-12">
																<textarea class="form-control" id="my_url" rows="4"></textarea>
															</div>
														</div>
 
													</form>
												</div>
											</div>

											<div class="modal-footer">
												<a href="javascript:void(0)" id="cp-btn" class="btn btn-primary btn-rounded">复制代码</a>											 												
											</div>  
										</div>
									</div>
								</div>

							</div>
						</div>
						<div class="panel-options">

							<div class="row">
								<div class="panel-title m-b-md col-lg-2">
									<p class="text-default ">活动分类:&nbsp;&nbsp;&nbsp;&nbsp;${row.category_name }</p>
								</div>
								<div class="panel-title m-b-md col-lg-2">
									<p class="text-default ">计费类型:&nbsp;&nbsp;&nbsp;&nbsp;${row.charge_mode }</p>
								</div>
								<div class="panel-title m-b-md col-lg-2">
									<p class="text-default ">效果认定期:&nbsp;&nbsp;&nbsp;&nbsp;${row.rd}</p>
								</div>
							</div>

							<div class="row">
								<div class="panel-title m-b-md col-lg-2">
									<p class="text-default ">数据周期:&nbsp;&nbsp;&nbsp;&nbsp;下单时间</p>
								</div>
								<div class="panel-title m-b-md col-lg-2">
									<p class="text-default ">结算周期:&nbsp;&nbsp;&nbsp;&nbsp;${row.clearing_cycle }</p>
								</div>
								<div class="panel-title m-b-md col-lg-2">
									<p class="text-default ">反馈标签:&nbsp;&nbsp;&nbsp;&nbsp;
										<c:if test="${row.has_feedback==1 }">
											YES
										</c:if>
										<c:if test="${row.has_feedback==0 }">
											NO
										</c:if>
									</p>
								</div>
							</div>

							<div class="row">
								<div class="panel-title m-b-md col-lg-2">
									<p class="text-default ">自定义链接:&nbsp;&nbsp;&nbsp;&nbsp;
										<c:if test="${row.has_self_links==1 }">
											YES
										</c:if>
										<c:if test="${row.has_self_links==0 }">
											NO
										</c:if>
									</p>
								</div>
								<div class="panel-title m-b-md col-lg-2">
									<p class="text-default ">审核方式:&nbsp;&nbsp;&nbsp;&nbsp;
										<c:if test="${row.approval_mode==1 }">
											自动
										</c:if>
										<c:if test="${row.approval_mode==2 }">
											人工
										</c:if>
										<c:if test="${row.approval_mode==3 }">
											无需审核
										</c:if>
									</p>
								</div>
								<div class="panel-title m-b-md col-lg-2">
									<p class="text-default ">数据返回机制:&nbsp;&nbsp;&nbsp;&nbsp;${row.data_return_mode }</p>
								</div>
							</div>
						</div>

						<div class="panel-options">
							<ul class="nav nav-tabs">
								<li class=""><a data-toggle="tab" href="#tab-1">活动介绍</a></li>
								<li class=""><a data-toggle="tab" href="#tab-2">佣金标准</a></li>
								<li class=""><a data-toggle="tab" href="#tab-3">促销信息</a></li>
								<li class=""><a data-toggle="tab" href="#tab-4">限制条件</a></li>
								<!-- <li class=""><a data-toggle="tab" href="tabs_panels.html#tab-2">投放素材</a></li> -->
							</ul>
						</div>
					</div>

					<div class="panel-body">

						<div class="tab-content">
							<div id="tab-1" class="tab-pane active">
								<!-- <div class="col-lg-1"><strong><i class="fa fa-buysellads"></i></strong></div>
								<div class="col-lg-11"><strong>1萨芬撒法</strong></div> -->
								<div class="row">
									<div class="col-lg-6">
										<div class="panel panel-primary">
											<div class="panel-heading">
												<i class="fa fa-buysellads">&nbsp;&nbsp;商家信息</i>
											</div>
											<div class="panel-body">
												<div class="col-lg-4">
													<p>
														<img src="${row.image}" width="120" height="60">
													</p>
												</div>
												<div class="col-lg-8">
													<p>
														<i class="fa fa-home"></i>网址:&nbsp;${row.domain }
													</p>
												</div>
												<div class="col-lg-8">
													<p>
														<i class="fa fa-clock-o"></i>加入时间:&nbsp;<fmt:formatDate value="${row.create_time }" pattern="yyyy-MM-dd"/>
													</p>
												</div>
												<%-- <div class="col-lg-12"><p><i class="fa fa-archive"></i>:&nbsp;${row.note }</p></div> --%>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-lg-6">
										<div class="panel panel-primary">
											<div class="panel-heading">
												<i class="fa fa-archive">&nbsp;&nbsp;活动描述</i>
											</div>
											<div class="panel-body">
												<div class="col-lg-12">
													<p>${row.note }</p>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<div id="tab-2" class="tab-pane">
								<div class="row">
									<div class="col-lg-8">
										<div class="panel panel-success">
											<div class="panel-heading">
												<i class="fa fa-dollar">&nbsp;&nbsp;当前佣金支付标准</i>
											</div>
											<div class="panel-body">
												<table class="table table-striped">
													<thead>
														<tr>
															<th>佣金类目</th>
															<th>佣金</th>
															<th>佣金周期</th>
															<th>适用商品</th>
															<th>详细说明</th>
														</tr>
													</thead>
													<tbody>	
														<c:forEach var="commission" items="${requestScope.commissions}">
														<tr class="gradeX">
															<td class="center">${commission.name }</td>
															<td class="center">${commission.commission }</td>
															<td class="center"><fmt:formatDate value="${commission.start_date}" pattern="yyyy-MM-dd"/> 至 <fmt:formatDate value="${commission.end_date}" pattern="yyyy-MM-dd"/></td>
															<td class="center">${commission.apply_goods }</td>
															<td class="center">${commission.note }</td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
							</div>

							<div id="tab-3" class="tab-pane">
								<div class="col-lg-8">
									<div class="panel panel-info">
										<div class="panel-heading">
											<i class="fa fa-info-circle">&nbsp;&nbsp;促销信息</i>
										</div>
										<div class="panel-body">
											<table class="table table-striped">
												<thead>
													<tr>
														<th>通知标题</th>
														<th>通知类型</th>
														<th>通知信息</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="notification"
														items="${requestScope.notifications}">
														<tr class="gradeX">
															<td class="center">${notification.title }</td>
															<td class="center"><c:if
																	test="${notification.type==1 }">联盟公告</c:if> <c:if
																	test="${notification.type==2 }">商家奖励</c:if> <c:if
																	test="${notification.type==2 }">商家促销</c:if> </td>
															<td class="center">${notification.info }</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>

							<div id="tab-4" class="tab-pane">
								<div class="col-lg-6">
									<div class="panel panel-danger">
										<div class="panel-heading">
											<i class="fa fa-warning">&nbsp;&nbsp;限制条件</i>
										</div>
										<div class="panel-body">
											<p class="text-danger">${row.restrictions }</p>
										</div>
									</div>
								</div>
							</div>
						</div>

					</div>

				</div>
			</div>
			<div class="col-lg-2"></div>
		</div>
	</div>

	<!-- Mainly scripts -->
	<script type="text/javascript">

		window.onload = function() {
			$('.dataTables-example').dataTable();
			switchLanguage(language_flag);
		}

		var my_url = "";
		function showCode() {
			my_url = "http://cps.b5m.com/j.do?";
			var sid = $("#sid").val();
			var uid = $("#uid").val();
			var aid = $("#aid").val();
			var tu = $("#tu").val();
			var fb = $("#fb").val();
			my_url = my_url + "aid=" + aid + "&tu=" + encodeURIComponent(tu) + "&fb=" + fb
					+ "&sid=" + sid + "&uid=" + uid;
			$('#myModal').modal('hide');
			$("#my_url").val(my_url);
			$('#myUrl').modal('show');
			$("#myAlert").remove();
			$("#cp-btn").zclip({
				path : '<%=basePath%>/js/jqueryui/zclip/ZeroClipboard.swf', //记得把ZeroClipboard.swf引入到项目中 
				copy : function() {
					$("#myAlert").remove();
					$('<span id="myAlert"  class="alert alert-success"><strong> 复制成功！</strong></span>').insertBefore("#cp-btn");
					$("#myAlert").alert();
					return $('#my_url').val();
				}
			});

			

		/* 	<div id="myAlert" class="alert alert-success">
				<a href="#" class="close" data-dismiss="alert" d>&times;</a>
				<strong>成功！</strong>结果是成功的。
			</div> */
		}
	</script>

	<script src="<%=basePath%>/js/footer.js"></script>
</body>
</html>
