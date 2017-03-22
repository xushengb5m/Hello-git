<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../pages/common.jsp"%>

<html>
<head>
<title>帮5买CPS联盟-数据报表</title>
<script type="text/javascript">
var datasets = ${requestScope.dataArr};
var datasety = ${requestScope.dataYrr};
var datasetz = ${requestScope.dataZrr};
var datasetd = ${requestScope.dataDrr};
var datasete = ${requestScope.dataErr};
var datasetf = ${requestScope.dataFrr};
var datasetg = ${requestScope.dataGrr};
var dataseth = ${requestScope.dataHrr};
var dataseti = ${requestScope.dataIrr};
var dataAll=[datasets,datasety,datasetz,datasetd,datasete,datasetf,datasetg,dataseth,dataseti];
var labels=["点击量","点击IP量","收订订单数","收订订金额","收订佣金","确认订单数","确认订金额","确认佣金"];
</script>
<script type="text/javascript">
function formatDate(date) {
	var myyear = date.getFullYear(); 
	var mymonth = date.getMonth()+1; 
	var myweekday = date.getDate(); 

	if(mymonth < 10){ 
	mymonth = "0" + mymonth; 
	} 
	if(myweekday < 10){ 
	myweekday = "0" + myweekday; 
	} 
	return (myyear+"-"+mymonth + "-" + myweekday); 
}

//获得上月开始时间  
function getLastMonthStartDate(){
	var now = new Date();                    //当前日期     
	var nowYear = now.getFullYear();             //当前年     
    
	  
	var lastMonthDate = new Date();  //上月日期  
	lastMonthDate.setDate(1);  
	lastMonthDate.setMonth(lastMonthDate.getMonth()-1);  
	var lastMonth = lastMonthDate.getMonth();
	
    var lastMonthStartDate = new Date(nowYear, lastMonth, 1);  
    return formatDate(lastMonthStartDate);    
}  
  
//获得上月结束时间  
function getLastMonthEndDate(){
	var now = new Date();                    //当前日期     
	var nowYear = now.getFullYear();             //当前年     
	var lastMonthDate = new Date();  //上月日期  
	lastMonthDate.setDate(1);  
	lastMonthDate.setMonth(lastMonthDate.getMonth()-1);  
	var lastMonth = lastMonthDate.getMonth();
    var lastMonthEndDate = new Date(nowYear, lastMonth, getMonthDays(lastMonth));  
    return formatDate(lastMonthEndDate);    
}

function getMonthDays(myMonth){
	var now = new Date();                    //当前日期    
	var nowYear = now.getFullYear();             //当前年       
	var lastMonthDate = new Date();  //上月日期  
	lastMonthDate.setDate(1);  
	lastMonthDate.setMonth(lastMonthDate.getMonth()-1);  
	var lastMonth = lastMonthDate.getMonth();
    var monthStartDate = new Date(nowYear, myMonth, 1);      
    var monthEndDate = new Date(nowYear, myMonth + 1, 1);      
    var   days=(monthEndDate-monthStartDate)/(1000*60*60*24);      
    return  days;      
}  

function fillToday(){
	var day = formatDate(new Date());
	$("#q_start_date").val(day);
	$("#q_end_date").val(day);
}
function fillYesterday(){
	var day = new Date();
	day.setDate(day.getDate()-1);
	$("#q_start_date").val(formatDate(day));
	$("#q_end_date").val(formatDate(day));
}
function fillMonth(){
	var now = new Date();
	var nowMonth = now.getMonth(); 
	var nowYear = now.getFullYear(); 
	var monthStartDate = new Date(nowYear, nowMonth, 1);
	$("#q_start_date").val(formatDate(monthStartDate));
	$("#q_end_date").val(formatDate(now));
}
function fillLastMonth(){
	$("#q_start_date").val(getLastMonthStartDate());
	$("#q_end_date").val(getLastMonthEndDate());
}


function drawData(y1,y2){
	var keys=[],val_right=[],val_left=[];
	$.each(datasets, function(key, val) {
		keys.push([key,val]);
	});
	$.each(dataAll[y1], function(key, val) {
		val_left.push([key,val]);
	});
	$.each(dataAll[y2], function(key, val) {
		val_right.push([key,val]);
	});
	$.plot($("#flot-line-chart"),[
	    {label: labels[y1-1],data: val_left},
	    {label: labels[y2-1],data: val_right,yaxis: 2}],
	    {
	        series: { lines: { show: true }, points: { show: true} },
	        grid:{ hoverable: true, clickable: true },
       		xaxis: { ticks: keys, min: 1 },  //指定固定的显示内容
	        yaxes: [{ ticks: 5, min: 0 }, {gnTicksWithAxis: 1,position: 'right'}],
            legend: {
            	show:true,
                position: 'ne'
            }
		}
	);
	// 节点提示  
    function showTooltip(x, y, contents) {
        $('<div id="tooltip">' + contents + '</div>').css( {  
            position: 'absolute',  
            display: 'none',  
            top: y + 10,  
            left: x + 10,  
            border: '1px solid #fdd',  
            padding: '2px',  
            'background-color': '#dfeffc',  
            opacity: 0.80  
        }).appendTo("body").fadeIn(200);
    }  

    var previousPoint = null;  
    // 绑定提示事件  
    $("#flot-line-chart").bind("plothover", function (event, pos, item) { 
        if (item) {  
            if (previousPoint != item.dataIndex) {  
                previousPoint = item.dataIndex;  
                $("#tooltip").remove();  
                var y = item.datapoint[1].toFixed(0);  
                var tip = labels[item.seriesIndex==0?y1-1:y2-1]+":";  
                showTooltip(item.pageX, item.pageY,tip+y);  
            }  
        }  
        else {  
            $("#tooltip").remove();  
            previousPoint = null;  
        }  
    });  
}

var c=0,limit=2;
var arr=[0,0,0,0,0,0,0,0];
function doCheck(obj) {
	if(obj.checked){
		c++;
	}else{
		c--;
	}
	if(c>limit){ 
		obj.checked=false; 
		c--; 
	}
	if(obj.checked==true){
		arr[obj.value-1]=1;
	}else{
		arr[obj.value-1]=0;
	}
	if(c==limit){
		var coins=[];
		for(var i=0;i<arr.length;i++){
			if(arr[i]==1){
				coins.push(i+1);
			}
		}
		drawData(coins[0],coins[1]);
	}
} 

</script>
</head>
<body>
<div class="wrapper wrapper-content animated fadeInRight">
			<!-- <div class="col-lg-2"></div>
					    <div class="panel-heading"> -->
						<div class="panel-options">
							<ul class="nav nav-tabs">
								<li class="active"><a data-toggle="tab" href="#tab-1">业绩统计</a></li>
							</ul>
						</div>
						
						      <div class="row">
						      		<div class="col-lg-6">
			                        <div class="ibox float-e-margins">
			                            <div class="ibox-title">
			                                <h5>筛选条件</h5>
			                                <div class="ibox-tools">
			                                    <a class="collapse-link">
			                                        <i class="fa fa-chevron-up"></i>
			                                    </a>
			                                </div>
			                            </div>
			                            <div class="ibox-content">
											<div class="panel-options">
			                                        <form id="condition" method="GET">
													<table>
														<tr>
															<td>
															<div class="form-group" id="date_picker">
																<label class="col-sm-4 control-label">下单日期：</label>
																<div class="col-sm-8 input-daterange input-group" id="datepicker">
																	<input type="text" class="input-sm form-control" id="q_start_date" name="q_start_date"
																		value="${params.q_start_date}" /> <span class="input-group-addon">TO</span>
																	<input type="text" class="input-sm form-control" id="q_end_date" name="q_end_date"
																		value="${params.q_end_date}" />
																</div>
															</div>
															</td>
															<td>
															<div class="form-group">
																&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="fillToday()">今天</a>&nbsp;&nbsp;&nbsp;
																<a href="javascript:void(0)" onclick="fillYesterday()">昨天</a>&nbsp;&nbsp;&nbsp;
																<a href="javascript:void(0)" onclick="fillMonth()">本月</a>&nbsp;&nbsp;&nbsp;
																<a href="javascript:void(0)" onclick="fillLastMonth()">上月</a>
															</div>
															</td>
														</tr>
														<tr>
														</tr>
														<tr>
															<td>
															<div class="form-group">
															<label class="col-sm-4 control-label">请选择活动：</label>
																<input type="text" id="q_action" name="q_action" placeholder="活动id/名称"/>
															</div>
															</td>
														</tr>
														<tr>
															<td>
															<div class="form-group">
															<label class="col-sm-4 control-label">请选择网站：</label>
																<input type="text" id="q_website" name="q_website" placeholder="网站名称/域名"/>
															</div>
															</td>
														</tr>
														<tr>
															<td>
															<div class="form-group">
															<label class="col-sm-4 control-label">统计方式：</label>
															<div>
					                                               	<a href="javascript:void(0)" onclick="fuckData(1,this)">按日期</a>&nbsp;&nbsp;|&nbsp;
					                                                <a href="javascript:void(0)" onclick="fuckData(2,this)">按活动</a>&nbsp;&nbsp;|&nbsp;
					                                               	<a href="javascript:void(0)" onclick="fuckData(3,this)">按网站</a>
					                                        </div>
															</div>
															</td>
															<td><a href="javascript:void(0)" onclick="searchData()" class="btn btn-primary">查询 </a>
															<a href="javascript:void(0)" onclick="generateExcel()" class="btn btn-primary">导出EXCEL文件</a></td>
														</tr>
													</table>
													<input type="hidden" id="sum_style" name="sum_style" value="${params.sum_style}"/>
												</form>
												</div>
			                            </div>
			                        </div>
			                    </div>
			      		                 
					           <div class="col-lg-6">
		                        <div class="ibox float-e-margins">
				                            <div class="ibox-title">
				                                <h5>折线图</h5>
				                                <div class="ibox-tools">
				                                    <a href="javascript:void(0)">
				                                        <i><input type="checkbox" name="coins" value="1" onclick="doCheck(this)">点击量</i>&nbsp;
				                                        <i><input type="checkbox" name="coins" value="2" onclick="doCheck(this)">点击IP量</i>&nbsp;
				                                        <i><input type="checkbox" name="coins" value="3" onclick="doCheck(this)">收订订单数</i>&nbsp;
				                                        <i><input type="checkbox" name="coins" value="4" onclick="doCheck(this)">收订订金额</i>&nbsp;
				                                        <i><input type="checkbox" name="coins" value="5" onclick="doCheck(this)">收订佣金</i>&nbsp;
				                                        <i><input type="checkbox" name="coins" value="6" onclick="doCheck(this)">确认订单数</i>&nbsp;
				                                        <i><input type="checkbox" name="coins" value="7" onclick="doCheck(this)">确认订单金额</i>&nbsp;
				                                        <i><input type="checkbox" name="coins" value="8" onclick="doCheck(this)">确认佣金</i>
				                                    </a>
				                                    <a class="collapse-link">
				                                        <i class="fa fa-chevron-up"></i>
				                                    </a>
				                                </div>
				                            </div>
		                            		<div class="ibox-content">
				                            <div class="flot-chart">
												<div class="flot-chart-content" id="flot-line-chart"></div>
											</div>
				                            </div>
				                        </div>
				                    </div>
				                </div>
				                </div>
				                
								<div class="row">
									<div class="col-lg-12">
										<div class="panel panel-primary">
											<div class="panel-heading">
												<i class="fa fa-archive">&nbsp;&nbsp;业绩报表</i>
											</div>
											<div class="panel-body">
												<table id="tbl_total" class="table table-striped" border="1">
														<tr>
															<th id="th_1" rowspan="2" class="center">日期</th>
															<th id="th_2" rowspan="2" class="center">活动</th>
															<th id="th_3" rowspan="2" class="center">网站</th>
															<th rowspan="2" class="center">点击量</th>
															<th rowspan="2" class="center">点击IP数</th>
															<th colspan="3">收订订单</th>
															<th colspan="3">确认订单</th>
														</tr>
														<tr>
															<th>收订订单数</th>
															<th>收订订单金额</th>
															<th>预估佣金</th>
															<th>确认订单数</th>
															<th>收订订单金额</th>
															<th>确认佣金</th>
														</tr>
														<tr>
															<th class="center">汇总</th>
															<c:set value="0" var="sum_click_no" />
															<c:set value="0" var="sum_click_ip" /> 
															<c:set value="0" var="sum_pre_order_count" /> 
															<c:set value="0" var="sum_pre_order_money" /> 
															<c:set value="0" var="sum_pre_commission" /> 
															<c:set value="0" var="sum_confirm_order_count" /> 
															<c:set value="0" var="sum_confirm_order_money" /> 
															<c:set value="0" var="sum_confirm_commission" /> 
															    <c:forEach var="row" items="${requestScope.rows}">  
															        <c:set value="${sum_click_no + row.click_no}" var="sum_click_no" />
															        <c:set value="${sum_click_ip + row.click_ip}" var="sum_click_ip" />
															        <c:set value="${sum_pre_order_count + row.pre_order_count}" var="sum_pre_order_count" />
															        <c:set value="${sum_pre_order_money + row.pre_order_money}" var="sum_pre_order_money" />
															        <c:set value="${sum_pre_commission + row.pre_commission}" var="sum_pre_commission" />
															        <c:set value="${sum_confirm_order_count + row.confirm_order_count}" var="sum_confirm_order_count" />
															        <c:set value="${sum_confirm_order_money + row.confirm_order_money}" var="sum_confirm_order_money" />
															        <c:set value="${sum_confirm_commission + row.confirm_commission}" var="sum_confirm_commission" /> 
															    </c:forEach>
															<th class="center">${sum_click_no}</th>
															<th class="center">${sum_click_ip}</th>
															<th class="center">${sum_pre_order_count}</th>
															<th class="center">${sum_pre_order_money}</th>
															<th class="center">${sum_pre_commission}</th>
															<th class="center">${sum_confirm_order_count}</th>
															<th class="center">${sum_confirm_order_money}</th>
															<th class="center">${sum_confirm_commission}</th>
														</tr>
													<tbody>	
														<c:forEach var="row" items="${requestScope.rows}">
														<tr class="gradeX">
															<c:if test="${params.sum_style==null||params.sum_style eq '' || params.sum_style eq 1}"><td class="center">
															<fmt:formatDate value="${row.history_date}" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;<a href="/report/detail/detail.do?q_start_order_date=${row.history_date}&q_end_order_date=${row.history_date}">明细</a></td></c:if>
															<c:if test="${params.sum_style eq 2}"><td class="center">${row.id}-${row.name}&nbsp;&nbsp;<a href="/report/detail/detail.do?q_activity=${row.id}">明细</a></td></c:if>
															<c:if test="${params.sum_style eq 3}"><td class="center">${row.id}-${row.name}&nbsp;&nbsp;<a href="/report/detail/detail.do?q_website=${row.id}">明细</a></td></c:if>
															
															<td class="center">${row.click_no}</td>
															<td class="center">${row.click_ip}</td>
															<td class="center">${row.pre_order_count}</td>
															<td class="center">${row.pre_order_money}</td>
															<td class="center">${row.pre_commission}</td>
															<td class="center">${row.confirm_order_count}</td>
															<td class="center">${row.confirm_order_money}</td>
															<td class="center">${row.confirm_commission}</td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
	
	<div>
			<form id="dataForm" method="post" action="" accept-charset="UTF-8">  
				       <input type="hidden" name="content" id="content" value=""/>
				       <input type="hidden" name="dataArr" id="dataArr" value=""/>
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
			
			drawData(1,2);
			var action = "${params.q_action}";
			if(action){
				$("#q_action").val(action);
			}
			var website = "${params.q_website}";
			if(website){
				$("#q_website").val(website);
			}
			var obj = "${params.sum_style}";
			if(!obj || obj==1){
				$("#th_1").attr("style","display:show");
				$("#th_2").attr("style","display:none");
				$("#th_3").attr("style","display:none");
			}else if(obj==2){
				$("#th_1").attr("style","display:none");
				$("#th_2").attr("style","display:show");
				$("#th_3").attr("style","display:none");
			}else if(obj==3){
				$("#th_1").attr("style","display:none");
				$("#th_2").attr("style","display:none");
				$("#th_3").attr("style","display:show");
			}
		}
	    
		function searchData(){
			$("#condition").attr("action","/report/statistic/output.do").submit();
		}
		function fuckData(flag,obj){
			if(flag){
				$("#sum_style").val(flag);
			}
			searchData();
		}
		function generateExcel(){
			  var objTab = document.getElementById("tbl_total");
			  var tableData;
			  var st = $("#sum_style").val();
			  if(!st || st==1){
				  tableData = tableData + objTab.rows[1].cells[0].innerHTML+"\t"
			  }else if(st==2){
				  tableData = tableData + objTab.rows[1].cells[1].innerHTML+"\t"
			  }else if(st==3){
				  tableData = tableData + objTab.rows[1].cells[2].innerHTML+"\t"
			  }
			  
			  tableData= tableData + objTab.rows[1].cells[3].innerHTML+"\t";
			  tableData= tableData + objTab.rows[1].cells[4].innerHTML+"\t";
			  tableData= tableData + objTab.rows[2].cells[0].innerHTML+"\t";
			  tableData= tableData + objTab.rows[2].cells[1].innerHTML+"\t";
			  tableData= tableData + objTab.rows[2].cells[2].innerHTML+"\t";
			  tableData= tableData + objTab.rows[2].cells[3].innerHTML+"\t";
			  tableData= tableData + objTab.rows[2].cells[4].innerHTML+"\t";
			  tableData= tableData + objTab.rows[2].cells[5].innerHTML+"\t";
			  tableData = tableData + "\n";
			  
			  for (var i = 3; i < objTab.rows.length; i++)
			  {		
				 tableData = tableData + objTab.rows[i].cells[0].innerHTML.trim().split("&")[0]+"\t";
			 	 for (var j = 1; j < objTab.rows[i].cells.length; j++)
			     {
			 		tableData = tableData + objTab.rows[i].cells[j].innerHTML.replace("\n"," ")+"\t";
			   	 }
			 	tableData = tableData + "\n";
			  }
			  
			  for (var t = 0; t < objTab.rows[0].cells.length; t++)
			  {
			 		tableData = tableData + objTab.rows[0].cells[t].innerHTML.replace("\n"," ")+"\t";
			  }
			  $("#content").val(tableData);
			  $("#dataForm").attr("action","/report/statistic/generateTotalData.do");
			  $("#dataForm").submit();
		}

	</script>
	<script type="text/javascript">  
            window.onresize = function(){  
            	if(c==limit){
            		var coins=[];
            		for(var i=0;i<arr.length;i++){
            			if(arr[i]==1){
            				coins.push(i+1);
            			}
            		}
            		drawData(coins[0],coins[1]);
            	}else{
            		drawData(1,2);
            	}
            }  
            $(window).resize();  
    </script> 
	<script src="<%=basePath%>/js/footer.js"></script>
	
</body>
</html>
