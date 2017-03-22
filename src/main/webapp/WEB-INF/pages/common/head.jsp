<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
    String contextPath = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + contextPath + "/";
%>

<style>
        /* Additional style to fix warning dialog position */
        #alertmod_table_list_2 {
            top: 900px !important;
        }
</style>

<link href="<%=basePath%>/css/bootstrap.min.css" rel="stylesheet">
<link href="<%=basePath%>/font-awesome/css/font-awesome.css" rel="stylesheet">

<link href="<%=basePath%>/css/plugins/jQueryUI/jquery-ui-1.10.4.custom.min.css" rel="stylesheet">

<!-- Data Tables -->
<link href="<%=basePath%>/css/plugins/jqgrid/ui.jqgrid.css" rel="stylesheet">

<link href="<%=basePath%>/css/animate.css" rel="stylesheet">
<link href="<%=basePath%>/css/style.css" rel="stylesheet">
<!-- 自定义字体 -->
<link href="<%=basePath %>/css/main.css" rel="stylesheet">
<%--     <!-- Mainly scripts -->
<script type="text/javascript" src="<%=basePath%>/js/jquery-2.1.1.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

    <!-- Peity -->
<script type="text/javascript" src="<%=basePath%>/js/plugins/peity/jquery.peity.min.js"></script>

    <!-- jqGrid -->
<script type="text/javascript" src="<%=basePath%>/js/plugins/jqgrid/i18n/grid.locale-cn.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/plugins/jqgrid/jquery.jqGrid.min.js"></script>

    <!-- Custom and plugin javascript -->
<script type="text/javascript" src="<%=basePath%>/js/hplus.js"></script>
<script type="text/javascript" src="<%=basePath%>/js/plugins/pace/pace.min.js"></script>

<script type="text/javascript" src="<%=basePath%>/js/plugins/jquery-ui/jquery-ui.min.js"></script> --%>

 <!-- <link href="http://fonts.useso.com/css?family=Lato:100,300,400,700" media="all" rel="stylesheet" type="text/css" /> -->
    <link href="<%=basePath%>stylesheets/bootstrap.min.css" media="all" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>stylesheets/font-awesome.css" media="all" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>stylesheets/se7en-font.css" media="all" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>stylesheets/isotope.css" media="all" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>stylesheets/jquery.fancybox.css" media="all" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>stylesheets/fullcalendar.css" media="all" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>stylesheets/wizard.css" media="all" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>stylesheets/select2.css" media="all" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>stylesheets/morris.css" media="all" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>stylesheets/datatables.css" media="all" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>stylesheets/datepicker.css" media="all" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>stylesheets/timepicker.css" media="all" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>stylesheets/colorpicker.css" media="all" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>stylesheets/bootstrap-switch.css" media="all" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>stylesheets/daterange-picker.css" media="all" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>stylesheets/typeahead.css" media="all" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>stylesheets/summernote.css" media="all" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>stylesheets/pygments.css" media="all" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>stylesheets/style.css" media="all" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>stylesheets/color/green.css" media="all" rel="alternate stylesheet" title="green-theme" type="text/css" />
    <link href="<%=basePath%>stylesheets/color/orange.css" media="all" rel="alternate stylesheet" title="orange-theme" type="text/css" />
    <link href="<%=basePath%>stylesheets/color/magenta.css" media="all" rel="alternate stylesheet" title="magenta-theme" type="text/css" />
    <link href="<%=basePath%>stylesheets/color/gray.css" media="all" rel="alternate stylesheet" title="gray-theme" type="text/css" />
    <script src="<%=basePath %>/js/jquery-2.1.1.min.js"></script>
    <%-- <script src="<%=basePath %>/js/jquery-ui-1.10.4.min.js"></script> --%>
    <script src="<%=basePath%>js/bootstrap.min.js" type="text/javascript"></script>
   <%--  <script src="<%=basePath%>js/raphael.min.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/selectivizr-min.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/jquery.mousewheel.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/jquery.vmap.min.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/jquery.vmap.sampledata.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/jquery.vmap.world.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/jquery.bootstrap.wizard.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/fullcalendar.min.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/gcal.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/datatable-editable.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/jquery.easy-pie-chart.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/excanvas.min.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/jquery.isotope.min.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/isotope_extras.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/modernizr.custom.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/jquery.fancybox.pack.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/select2.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/styleswitcher.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/wysiwyg.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/summernote.min.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/jquery.inputmask.min.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/jquery.validate.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/bootstrap-fileupload.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/bootstrap-datepicker.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/bootstrap-timepicker.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/bootstrap-colorpicker.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/bootstrap-switch.min.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/typeahead.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/daterange-picker.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/date.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/morris.min.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/skycons.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/fitvids.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/jquery.sparkline.min.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/main.js" type="text/javascript"></script>
    <script src="<%=basePath%>js/respond.js" type="text/javascript"></script> --%>
	<!-- 国际化 -->
	<script src="<%=basePath %>/js/language-0.0.1.js"></script>
	<!-- 处理Cookie -->
	<script src="<%=basePath %>/js/handle-cookie.js"></script>
