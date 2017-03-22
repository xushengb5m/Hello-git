<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js ie7 oldie" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js ie8 oldie" lang="en"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang="en">
<!--<![endif]-->
<head>
<title>资源管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--[if gte IE 9]>
	<link rel="stylesheet" href="assets/stylesheets/ie9.css" type="text/css" />
<![endif]-->

<!--[if gte IE 8]>
	<link rel="stylesheet" href="assets/stylesheets/ie8.css" type="text/css" />
<![endif]-->

<style type="text/css">
.tree li{list-style-type: none;}
.form .field-group .field {margin: 0 .65em .65em 0;}
</style>
</head>
<body style="background:none;">

		<%@include file="/WEB-INF/pages/common/adserveScript.jsp"%>
			<div id="contentHeader">
			<div class="contentHeaderbor">
				<h1>资源管理</h1>
			</div>
			</div> <!-- #contentHeader -->
			<div class="container">
				<div class="grid-24">
							<div id="addDiv" class="easyui-window" title="添加资源" data-options="iconCls:'icon-save'" style="width: 400px; height: 440px; padding: 10px;">
								<div id="crudcampaign" class="form uniformForm">
									<form action="/admin/role/addResource.do" method="post">
										<div class="field-group" id="adTypeDiv">
											<div class="field">
												<input id="resourceName" name="resourceName" type="text"/><br/>
												<label for="campaign_type">资源名称</label>
											</div>
										</div>
										<div class="field-group" id="adTypeDiv">
											<div class="field">
												<input id="resourceUrl" name="resourceUrl" type="text"/><br/>
												<label for="campaign_type">资源路径</label>
											</div>
										</div>
										<div class="field-group" id="adTypeDiv">
											<div class="field">
												<input id="clsname" name="clsname" type="text"/><br/>
												<label for="campaign_type">clsname</label>
											</div>
										</div>
										<div class="field-group" id="adTypeDiv">
											<div class="field">
												<input id="engName" name="engName" type="text"/><br/>
												<label for="campaign_type">英文名称</label>
											</div>
										</div>
										<div class="field-group" id="adTypeDiv">
											<div class="field">
												<input id="posorder" name="posorder" type="text"/><br/>
												<label for="campaign_type">菜单显示顺序</label>
											</div>
										</div>
										<div class="field-group" id="adTypeDiv">
											<div class="field">
												<select name="ismenu">
													<option value="y">显示</option>
													<option value="n">不显示</option>
												</select><br/>
												<label for="campaign_type">是否显示</label>
											  </div>
										</div>
										<div class="field-group" id="adTypeDiv">
											<div class="field">
												<select id="topid" name="topid">
															
												</select><br/>
												<label for="campaign_type">与当前资源的关系</label>
											</div>
										</div>			
										<input type="submit" value="确定">
										<input type="reset" value="取消" onclick="$('#addDiv').window('close')">
									</form>
								</div>
							</div>
							<div id="editDiv" class="easyui-window" title="添加资源" data-options="iconCls:'icon-save'" style="width: 400px; height: 440px; padding: 10px;">
								<div id="crudcampaign" class="form uniformForm">			
									<form action="/admin/role/editResource.do" method="post">
										<div class="field-group" id="adTypeDiv">
											<div class="field">
												<input id="resourceNameEdit" name="resourceName" type="text"/><br/>
												<label for="campaign_type">资源名称</label>
											</div>
										</div>
										<div class="field-group" id="adTypeDiv">
											<div class="field">
												<input id="resourceUrlEdit" name="resourceUrl" type="text"/><br/>
												<label for="campaign_type">资源路径</label>
											</div>
										</div>
										<div class="field-group" id="adTypeDiv">
											<div class="field">
												<input id="clsnameEdit" name="clsname" type="text"/><br/>
												<label for="campaign_type">clsname</label>
											</div>
										</div>
										<div class="field-group" id="adTypeDiv">
											<div class="field">
												<input id="engNameEdit" name="engName" type="text"/><br/>
												<label for="campaign_type">英文名称</label>
											</div>
										</div>
										<div class="field-group" id="adTypeDiv">
											<div class="field">
												<input id="posorderEdit" name="posorder" type="text"/><br/>
												<label for="campaign_type">菜单显示顺序</label>
											</div>
										</div>
										<div class="field-group" id="adTypeDiv">
											<div class="field">
												<select id="ismenuEdit" name="ismenu">
													<option value="y">显示</option>
													<option value="n">不显示</option>
												</select><br/>
												<label for="campaign_type">是否显示</label>
											  </div>
										</div>
										<div class="field-group" id="adTypeDiv">
											<div class="field">
												<select id="topidEdit" name="topid">
													<option value="0">无父节点</option>
													<c:forEach items="${resources}" var="resource">
														<option value="${resource.id}">${resource.resourceName}</option>
													</c:forEach>
												</select><br/>
												<label for="campaign_type">父节点</label>
											  </div>
										</div>
									    <input id="idedit" name="id" type="hidden">
										<input type="submit" value="确定">
										<input type="reset" value="取消" onclick="$('#editDiv').window('close')">
									</form>
								</div>
							</div>
						 <!-- .widget -->
						<div class="widget">
							<div class="widget-header">
								<span class="icon-article"></span>
								<h3>资源列表</h3>
							</div><!-- .widget-header -->
							<div class="widget-content">
								${delErrorReason}
								<div class="toolbar">
									<a href="javascript:void(0)" class="easyui-linkbutton l-btn" data-options="iconCls:'icon-add'" id="add">添加</a>
									<a href="javascript:void(0)" class="easyui-linkbutton l-btn" data-options="iconCls:'icon-remove'" id="edit">编辑</a>
									<a href="javascript:void(0)" class="easyui-linkbutton l-btn" data-options="iconCls:'icon-no'" id="del">删除</a>
								</div>
								<br/>
								<div class="field-group control-group inline">	
									<ul class="easyui-tree" id="tt"></ul>
								</div>
							</div> <!-- .widget-content -->
						</div> <!-- .widget -->	                   
						<div class="actions">						
						</div> <!-- .actions -->
				</div> <!-- .grid -->
			</div> <!-- .container -->
		
</body><script type="text/javascript" src="/js/common/footerjs.js"></script>
<script type="text/javascript">
$('#addDiv').window({
	top:400,
	closed:true
});
$('#editDiv').window({
	top:400,
	closed:true
});
$('#tt').tree({
    url:'/admin/role/getResource.do',
    animate:'true'
});

function del(id){
	window.location.href="/admin/role/deleteResource.do?id="+id;
}
function edit(id){
	var node = $('#tt').tree('find', id);
	$("#resourceNameEdit").val(node.attributes.resourceName);
	$("#resourceUrlEdit").val(node.attributes.resourceUrl);
	$("#posorderEdit").val(node.attributes.posorder);
	$("#ismenuEdit").val(node.attributes.ismenu);
	$("#clsnameEdit").val(node.attributes.clsname);
	$("#engNameEdit").val(node.attributes.engName);
	$("#idedit").val(id);
	$("#topidEdit").val(node.attributes.topid);
	$("#editDiv").window("setTitle","编辑资源");
	$('#editDiv').window('open');
}
function add(id){
	var node = $('#tt').tree('find', id);
	var parentNode = $('#tt').tree('getParent',node.target);
	$('#addDiv').window('setTitle','添加资源('+node.resourceName+')');
	var optionStr = '<option value="'+id+'">当前资源的子资源</option>';
	if(parentNode != null){
		optionStr += '<option value="'+parentNode.id+'">与当前资源平级</option>';
	}else{
		optionStr += '<option value="0">与当前资源平级</option>';
	}
	$("#topid").html(optionStr);
	$('#addDiv').window('open');
}
$("#add").click(function(){
	var node = $('#tt').tree('getSelected');
	if(node == null){
		alert("请选择一个资源节点");
		return;
	}
	add(node.id);
});
$("#edit").click(function(){
	var node = $('#tt').tree('getSelected');
	if(node == null){
		alert("请选择一个资源节点");
		return;
	}
	edit(node.id);
});
$("#del").click(function(){
	var node = $('#tt').tree('getSelected');
	if(node == null){
		alert("请选择一个资源节点");
		return;
	}
	del(node.id);
});
</script>
</html>
