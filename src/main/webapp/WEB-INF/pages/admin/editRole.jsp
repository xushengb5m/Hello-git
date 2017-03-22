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
<title>编辑角色</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--[if gte IE 9]>
	<link rel="stylesheet" href="assets/stylesheets/ie9.css" type="text/css" />
<![endif]-->

<!--[if gte IE 8]>
	<link rel="stylesheet" href="assets/stylesheets/ie8.css" type="text/css" />
<![endif]-->
</head>
<body style="background:none;">

			<%@include file="/WEB-INF/pages/common/adserveScript.jsp"%>
			<div id="contentHeader">
			<div class="contentHeaderbor">
				<h1>编辑角色</h1>
			</div>
			</div> <!-- #contentHeader -->	
			<div class="container">
				<div class="grid-24">
					<div id="crudpublication" class="form uniformForm">
						<input type="hidden" name="add" value="1" />
						<div class="widpcontent">
							<div class="widparent">	
								<div class="num_pos">1</div>	
								<div class="widget">
									<div class="widget-header">
										<span class="icon-article"></span>
										<h3>编辑角色</h3>
									</div> <!-- .widget-header -->
									<div class="widget-content">
									<form id="createRoleForm" action="/admin/role/updateRole.do" method="post">
										<div class="field-group">
											<div class="field">
												<input id="role" name="role" type="text" value="${role.role}">	
												<label for="inv_type">角色名称</label>
											</div>
										</div> <!-- .field-group -->
										<div class="field-group">
											<div class="field">
												<input id="remark" name="remark" type="text" value="${role.remark}">
												<input id="resourceIds" name="resourceIds" type="hidden">
												<input id="id" name="id" type="hidden" value="${role.id}">	
												<label for="inv_type">角色备注</label>
											</div>	
										</div>
									</form>				
									</div> <!-- .widget-content -->
								</div> <!-- .widget -->
							</div>
						</div>
						<div class="widpcontent">
							<div class="widparent widparentlast">	
								<div class="num_pos">2</div>
								<div class="over_pos"></div>
								<div class="widget">
									<div class="widget-header">
										<span class="icon-article"></span>
										<h3>资源列表</h3>
									</div><!-- .widget-header -->
									<div class="widget-content">
										<div class="field-group control-group inline">	
											<ul class="easyui-tree" id="tt"></ul>
										</div>
									</div> <!-- .widget-content -->
								</div> <!-- .widget -->	                   
								<div class="actions">						
									<input id="createRoleButton" type="button" class="btn btn-quaternary btn-large" value="提交"/>
								</div> <!-- .actions -->
							</div>
						</div>
					</div>
				</div> <!-- .grid -->
			</div> <!-- .container -->
	
</body><script type="text/javascript" src="/js/common/footerjs.js"></script>
<script type="text/javascript">
$('#tt').tree({
    url:'/admin/role/getResource.do?selectedResourceIds=${resourceIds}',
    checkbox:'true',
    animate:'true',
    cascadeCheck:false,
    onLoadSuccess:function(node,data){
    	if("${resourceIds}"!=""){
    		var resourceIdArray = "${resourceIds}".split(",");
    		for(var i = 0; i < resourceIdArray.length; i++){
    			var treeNode = $('#tt').tree("find",resourceIdArray[i]);
    			$('#tt').tree('check',treeNode.target);
    		}
    	}
    }
});
$("#createRoleButton").click(function(){
	var nodes = $('#tt').tree('getChecked');
	if(nodes.length == 0){
		alert("请选择资源");
		return;
	}
	var resourceIds = "";
	for(var i = 0; i < nodes.length; i++){
		resourceIds += nodes[i].id;
		resourceIds +=",";
	}
	if(resourceIds.length > 0){
		resourceIds = resourceIds.substr(0, resourceIds.length-1);
	}
	$("#resourceIds").val(resourceIds);
	if($.trim($("#role").val()).length == 0){
		alert("角色名称不可为空");
		return;
	}
	if($.trim($("#remark").val()).length == 0){
		alert("角色备注不可为空");
		return;
	}
	$("#createRoleForm").submit();
});
</script>
</html>
