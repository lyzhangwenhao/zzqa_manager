<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page
	import="com.zzqa.service.interfaces.product_procurement.Product_procurementManager"%>
<%@page import="com.zzqa.pojo.product_procurement.Product_procurement"%>
<%@page import="com.zzqa.service.interfaces.outsource_product.Outsource_productManager"%>
<%@page import="com.zzqa.pojo.outsource_product.Outsource_product"%>
<%@page import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	Product_procurementManager product_procurementManager = (Product_procurementManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("product_procurementManager");
	Outsource_productManager outsource_productManager = (Outsource_productManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("outsource_productManager");
	Position_userManager position_userManager = (Position_userManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("position_userManager");
	if (session.getAttribute("uid") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int uid = (Integer) session.getAttribute("uid");
	User mUser = userManager.getUserByID(uid);
	if (mUser == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	List<Product_procurement> ppList=product_procurementManager.getFinishedProduct_procurement();
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>新建外协生产流程</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css" href="css/custom.css">
		<link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-filer.css">
		<link rel="stylesheet" type="text/css" href="css/default.css">
		<link rel="stylesheet" type="text/css"
			href="css/jquery.filer-dragdropbox-theme.css">
		<link rel="stylesheet" type="text/css"
			href="css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script src="js/showdate.js"></script>
		<script src="js/prettify.js"></script>
		<script src="js/jquery.min.js"></script>
		<script src="js/jquery.filer.min.js"></script>
		<script  src="js/jquery-ui.min.js"></script>
		<script  src="js/dialog.js"></script>
		<script  src="js/custom.js"></script>
		<link rel="stylesheet" href="css/bootstrap/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="css/create_outproductflow.css">
		<script src="js/modernizr.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/vendor/tabcomplete.min.js"></script>
		<script src="js/vendor/livefilter.min.js"></script>
		<script src="js/vendor/src/bootstrap-select.js"></script>
		<script src="js/vendor/src/filterlist.js"></script>
		<script src="js/plugins.js"></script>
		
		<!--[if IE]>
			<script src="http://libs.useso.com/js/html5shiv/3.7/html5shiv.min.js"></script>
		<![endif]-->
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
		var procurement_num=0;
	   	function addFlow(){
	   		var k=0;
	   		if($("#task_id_input").val().length<1){
				k++;
        		$("#select_productpro_error").text("请选择生产采购单");
    		}else{
    			$("#select_productpro_error").text("");
    		}
    		if(k==0){
    			document.flowform.product_pid.value=$("#task_id_input").val();
	   			document.flowform.submit();
	   		}
	   	}
	</script>
	</head>

	<body>
		<jsp:include page="/top.jsp" >
	<jsp:param name="name" value="<%=mUser.getName() %>" />
	<jsp:param name="level" value="<%=mUser.getLevel() %>" />
	<jsp:param name="index" value="1" />
	</jsp:include>
		<div class="div_center">
			<table class="table_center">
				<tr>
					<jsp:include page="/flowmanager/flowTab.jsp">
						<jsp:param name="index" value="3" />
					</jsp:include>
					<td class="table_center_td2">
						<form action="FlowManagerServlet?type=outproductflow&uid=<%=mUser.getId()%>&operation=0&file_time=<%=System.currentTimeMillis()%>"
							method="post" name="flowform" enctype="multipart/form-data">
							<div class="td2_div">
								<div class="td2_div1">外协生产</div>
								<table class="td2_table0">
									<tr class="table0_tr1">
										<td class="table0_tr1_td1"><span class="star">*</span>关联生产采购</td>
										<td class="table0_tr1_td2">
											<div class="table_div_left">
												<jsp:include page="/flowmanager/drop_down_out.jsp" />
												<input type="hidden" name="product_pid" value="">
											</div>
											<div class="table0_div_right">
												<span id="select_productpro_error"></span>
											</div>
										</td>
									</tr>
									<tr class="table0_tr2">
										<td class="table0_tr2_td1"><div>外协生产附件<br/>（可选）</div></td>
										<td class="table0_tr2_td2">
											<div id="section4" class="section-white5">
												<input type="file" name="file_budget" id="file_input1"
												multiple="multiple">
											</div>
										</td>
									</tr>
								</table>
								<div class="div_btn">
									<img src="images/submit_flow.png" onclick="addFlow();">
								</div>
							</div>
						</form>
					</td>
				</tr>
			</table>

		</div>
	</body>
</html>
