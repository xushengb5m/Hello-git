<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@	taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String contextPath = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + contextPath;
%>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit">
<!-- <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="X-UA-Compatible" content="IE=9" /> -->
    
<link href="<%=basePath %>/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=basePath %>/font-awesome/css/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>/css/animate.css" rel="stylesheet">
<link href="<%=basePath %>/css/style.css" rel="stylesheet">
<link href="<%=basePath %>/css/plugins/iCheck/custom.css" rel="stylesheet">
<link href="<%=basePath %>/css/plugins/chosen/chosen.css" rel="stylesheet">
<link href="<%=basePath %>/css/plugins/switchery/switchery.css" rel="stylesheet">
<link href="<%=basePath %>/css/plugins/jasny/jasny-bootstrap.min.css" rel="stylesheet">
<link href="<%=basePath %>/css/plugins/nouslider/jquery.nouislider.css" rel="stylesheet">
<link href="<%=basePath %>/css/plugins/datapicker/datepicker3.css" rel="stylesheet">
<link href="<%=basePath %>/css/plugins/ionRangeSlider/ion.rangeSlider.css" rel="stylesheet">
<link href="<%=basePath %>/css/plugins/ionRangeSlider/ion.rangeSlider.skinFlat.css" rel="stylesheet">
<link href="<%=basePath %>/css/plugins/colorpicker/css/bootstrap-colorpicker.min.css" rel="stylesheet">
<!-- Data Tables -->
<link href="<%=basePath %>/css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
<!-- Toastr -->
<link href="<%=basePath %>/css/plugins/toastr/toastr.min.css" rel="stylesheet">
<!-- 自定义字体 -->
<link href="<%=basePath %>/css/main.css" rel="stylesheet">
<style>
body {
  font-size: 12px;
  line-height: 1.428571429;
  color: #333333;
  background-color: #ffffff;
}

/* .img-responsive {
  display: inline-block;
  height: auto;
  max-width: 100%;
} */

/* div{text-align:center;} 
div{ display:box; box-pack:center; box-align:center;} */
th{text-align:center;} 
.center{text-align:center;vertical-align: middle; } 
</style>

<script src="<%=basePath %>/js/jquery-2.1.1.min.js"></script>
<script src="<%=basePath %>/js/bootstrap.min.js"></script>
<script src="<%=basePath %>/js/hplus.js"></script>
<script src="<%=basePath %>/js/plugins/pace/pace.min.js"></script>
<!-- Chosen -->
<script src="<%=basePath %>/js/plugins/chosen/chosen.jquery.js"></script>
<!-- JSKnob -->
<script src="<%=basePath %>/js/plugins/jsKnob/jquery.knob.js"></script>
<!-- Input Mask-->
<script src="<%=basePath %>/js/plugins/jasny/jasny-bootstrap.min.js"></script>
<!-- Data picker -->
<script src="<%=basePath %>/js/plugins/datapicker/bootstrap-datepicker.js"></script>
<!-- NouSlider -->
<script src="<%=basePath %>/js/plugins/nouslider/jquery.nouislider.min.js"></script>
<!-- Switchery -->
<script src="<%=basePath %>/js/plugins/switchery/switchery.js"></script>
<!-- IonRangeSlider -->
<script src="<%=basePath %>/js/plugins/ionRangeSlider/ion.rangeSlider.min.js"></script>
<!-- iCheck -->
<script src="<%=basePath %>/js/plugins/iCheck/icheck.min.js"></script>
<!-- MENU -->
<script src="<%=basePath %>/js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="<%=basePath %>/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="<%=basePath %>/js/plugins/jeditable/jquery.jeditable.js"></script>
<!-- Data Tables -->
<script src="<%=basePath %>/js/plugins/dataTables/jquery.dataTables.js"></script>
<script src="<%=basePath %>/js/plugins/dataTables/dataTables.bootstrap.js"></script>
<!-- COLORPICKER -->
<script src="<%=basePath %>/js/plugins/colorpicker/bootstrap-colorpicker.min.js"></script>
<!-- 国际化 -->
<script src="<%=basePath %>/js/language-0.0.1.js"></script>
<!-- 处理Cookie -->
<script src="<%=basePath %>/js/handle-cookie.js"></script>

<script src="<%=basePath %>/js/jqueryui/jquery.easyui.min.js"></script>

<script src="<%=basePath %>/js/jqueryui/jquery.form.min.js"></script>
<!-- 复制粘贴 -->
<script src="<%=basePath %>/js/jqueryui/zclip/jquery.zclip.min.js"></script>
<!-- Toastr-->
<script src="<%=basePath %>/js/plugins/toastr/toastr.min.js"></script>
<!-- flotjs -->
<script src="<%=basePath %>/js/plugins/flot/jquery.flot.js"></script>
<!-- jQuery.md5 -->
<script src="<%=basePath %>/js/jQuery.md5.js"></script>
<script type="text/javascript">
/* form表单参数  */
$.fn.serializeToJson = function(notEmptyField) {
	var obj = {};
	$.each(this.serializeArray(), function(i, o) {
		var n = o.name, v = $.trim(o.value);
		if (!(notEmptyField && "" == v)) {
			obj[n] = (obj[n] === undefined) ? v
					: $.isArray(obj[n]) ? obj[n].concat(v) : [ obj[n], v ];
		}
	});
	return obj;
};
/* select框赋值 */
function selectValue(id,val){
	var count=$("#"+id).get(0).options.length;
	for(var i=0;i<count;i++){
		if($("#"+id).get(0).options[i].text == val)  
		{
			$("#"+id).get(0).options[i].selected = true;          
			break;
		}
	} 
}
/* 弹窗 */
toastr.options = {
		  "closeButton": true,
		  "debug": true,
		  "progressBar": false,
		  "positionClass": "toast-top-center",
		  "showDuration": "400",
		  "hideDuration": "1000",
		  "timeOut": "3000",
		  "extendedTimeOut": "1000",
		  "showEasing": "swing",
		  "hideEasing": "linear",
		  "showMethod": "fadeIn",
		  "hideMethod": "fadeOut"
}
</script>