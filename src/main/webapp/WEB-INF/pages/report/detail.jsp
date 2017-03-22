<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-数据报表</title>
</head>

<script type="text/javascript">
function generateExcel(){
	  var objTab = document.getElementById("tbl_order");
	  var tableData;
	  for (var i = 0; i < objTab.rows.length; i++)
	  {
	 	 for (var j = 0; j < objTab.rows[i].cells.length; j++)
	     {
	 		tableData = tableData + objTab.rows[i].cells[j].innerHTML+"\t";
	   	 }
	 	tableData = tableData + "\n";
	   }
	  $("#content").val(tableData);
	  $("#dataForm").attr("action","/report/detail/generateExcelData.do");
	  $("#dataForm").submit();
}

</script>

<body>
<div class="wrapper wrapper-content animated fadeInRight">
		<div class="col-lg-2"></div>
					<div class="panel-heading">
						<div class="panel-options">
							<ul class="nav nav-tabs">
								<li class="active"><a data-toggle="tab" href="#tab-2">CPS明细</a></li>
							</ul>
						</div>

					<div class="panel-body">
						<div class="tab-content">
							<div class="tab-pane active">
								<div class="col-lg-8">
			                                <div class="ibox float-e-margins">
			                                    <div class="ibox-title">
													<i class="fa fa-buysellads">&nbsp;&nbsp;筛选条件</i>
			                                        <div class="ibox-tools">
			                                            <a class="collapse-link">
			                                                <i class="fa fa-chevron-up"></i>
			                                            </a>
			                                        </div>
			                                    </div>
			                                    <div class="ibox-content">
			                                    <form id="condition" method="GET">
												<table>
														<tr>
															<td>
															<div class="form-group" id="date_picker">
																<label class="col-sm-4 control-label">下单日期：</label>
																<div class="col-sm-8 input-daterange input-group" id="datepicker">
																	<input type="text" class="input-sm form-control" id="q_start_order_date" name="q_start_order_date"
																		/> <span class="input-group-addon">TO</span>
																	<input type="text" class="input-sm form-control" id="q_end_order_date" name="q_end_order_date"
																		/>
																</div>
															</div>
															</td>
															<td align="right">
															 <a href="javascript:void(0)" onclick="clearOrder()">清除</a>
															</td>
														</tr>
														<tr>
														<td>
															<div class="form-group" id="date_picker">
																<label class="col-sm-4 control-label">业绩确认时间：</label>
																<div class="col-sm-8 input-daterange input-group" id="datepicker">
																	<input type="text" class="input-sm form-control" id="q_start_confirm_time" name="q_start_confirm_time"
																		 /> <span class="input-group-addon">TO</span>
																	<input type="text" class="input-sm form-control" id="q_end_confirm_time" name="q_end_confirm_time"
																		 />
																</div>
															</div>
														</td>
														<td align="right">
															 <a href="javascript:void(0)" onclick="clearConfirm()">清除</a>
															</td>
														</tr>
														<tr>
															<td>
															<div class="form-group">
															<label class="col-sm-4 control-label">
															订单状态:
															</label>
															<label>
															<select id="q_order_status" name="q_order_status">
																	<option value="">-全部-</option>
																	<option value="1" <c:if test="${params.q_order_status eq 1}">selected</c:if>>未确认</option>
																	<option value="2" <c:if test="${params.q_order_status eq 2}">selected</c:if>>已结算</option>
																	<option value="3" <c:if test="${params.q_order_status eq 3}">selected</c:if>>无效</option>
															</select></label>
															</div>
															</td>
														</tr>
														<tr>
															<td>
																<div class="form-group">
																<label class="col-sm-4 control-label">请选择活动ID：</label>
																	<input type="text" id="q_activity" name="q_activity" placeholder="活动id" value="${params.q_activity}"/>
																</div>
																<div class="form-group">
																<label class="col-sm-4 control-label">请选择网站ID：</label>
																	<input type="text" id="q_website" name="q_website" placeholder="网站id" value="${params.q_website}"/>
																</div>
															</td>
														</tr>
														<tr>
															<td>
															<div class="form-group">
															<label class="col-sm-4 control-label">
															<select id="q_condition" name="q_condition">
																	<option value="1" <c:if test="${params.q_condition eq 1}">selected</c:if>>订单编号</option>
																	<option value="2" <c:if test="${params.q_condition eq 2}">selected</c:if>>反馈标签</option>
																	<option value="3" <c:if test="${params.q_condition eq 3}">selected</c:if>>商品编号</option>
															</select></label>
															<input type="text" id="keyword" name="keyword" value="${params.keyword}"/>
															</div>
															</td>
															<td><a href="javascript:void(0)" onclick="searchOrder()" class="btn btn-primary">查询 </a>
															<a href="javascript:void(0)" onclick="location.href='javascript:history.go(-1)'" class="btn btn-primary">返回 </a>
															<a href="javascript:void(0)" onclick="generateExcel()" class="btn btn-primary">导出EXCEL文件</a></td>
														</tr>
												</table>
												</form>
			                                    </div>
			                                    </div>
			                                    </div>
								
								<div class="row">
									<div class="col-lg-12">
										<div class="panel panel-primary">
											<div class="panel-heading">
												<i class="fa fa-archive">&nbsp;&nbsp;订单明细</i>
											</div>
											<div class="panel-body">
												<table id="tbl_order" class="table table-striped">
													<thead>
														<tr>
															<th>订单编号</th>
															<th>下单时间</th>
															<th>订单状态</th>
															<th>订单金额</th>
															<th>活动</th>
															<th>网站</th>
															<th>反馈标签</th>
															<th>商品类型</th>
															<th>商品编号</th>
															<th>商品数量</th>
															<th>商品单价</th>
															<th>预估佣金</th>
															<th>佣金比例</th>
															<th>确认时间</th>
															<th>商品链接</th>
															<th>结算时间</th>
															<th>结算金额</th>
															<th>结算佣金</th>
														</tr>
													</thead>
													<tbody>	
														<c:forEach var="row" items="${requestScope.rows}">
														<tr class="gradeX">
															<td class="center">${row.order_no}</td>
															<td class="center"><fmt:formatDate value="${row.order_time}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
															<td class="center"><c:if test="${row.order_status==1}">未确认</c:if><c:if test="${row.order_status==2}">已结算</c:if><c:if test="${row.order_status==3}">无效</c:if></td>
															<td class="center">${row.order_price}</td>
															<td class="center">${row.action_id}-${row.activity}</td>
															<td class="center">${row.website_id}-${row.website}</td>
															<td class="center">${row.feed_back}</td>
															<td class="center">${row.prod_type}</td>
															<td class="center">${row.prod_no}</td>
															<td class="center">${row.prod_count}</td>
															<td class="center">${row.prod_price}</td>
															<td class="center">${row.commission}</td>
															<td class="center">${row.commission_rate}</td>
															<td class="center"><fmt:formatDate value="${row.confirm_time}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
															<td class="center">${row.prod_link}</td>
															<td class="center"><fmt:formatDate value="${row.settle_time}" pattern="yyyy-MM-dd hh:mm:ss"/></td>
															<td class="center">${row.settle_money}</td>
															<td class="center">${row.settle_commission}</td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
								</div>
						</div>
					</div>

				</div>
			</div>
			<div class="col-lg-2"></div>
		</div>
	</div>
	</div>
	<div>
			<form id="dataForm" method="post" action="" accept-charset="UTF-8">  
				       <input type="hidden" name="content" id="content" value=""/>
			</form>
	</div>
	<!-- Mainly scripts -->
	<script type="text/javascript">

		window.onload = function() {
			
			$('#date_picker .input-daterange').datepicker({
		        	keyboardNavigation: false,
		            forceParse: false,
		            autoclose: true
		    });
			
			var start = "${params.q_start_order_date}";
			if(start){
				$("#q_start_order_date").val(start);
			}
			var end = "${params.q_end_order_date}";
			if(end){
				$("#q_end_order_date").val(end);
			}
			var confirm = "${params.q_start_confirm_time}";
			if(confirm){
				$("#q_start_confirm_time").val(confirm);
			}
			var cfm = "${params.q_end_confirm_time}";
			if(cfm){
				$("#q_end_confirm_time").val(cfm);
			}
		}
		
		function searchOrder(){
			var params = $("#condition").serializeToJson();
			$("#condition").attr("action","/report/detail/detail.do").submit();
		}
		
		function clearOrder(){
			$("#q_start_order_date").val("");
			$("#q_end_order_date").val("");
		}
		
		function clearConfirm(){
			$("#q_start_confirm_time").val("");
			$("#q_end_confirm_time").val("");
		}

	</script>

	<script src="<%=basePath%>/js/footer.js"></script>
</body>
</html>
