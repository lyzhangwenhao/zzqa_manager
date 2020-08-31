<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
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
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>新建销假流程</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css"
			href="css/create_resumptionflow.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script src="js/jquery.min.js"></script>
		<script src="js/jquery.filer.min.js"></script>
		<script  src="js/jquery-ui.min.js"></script>
		<script  src="js/dialog.js"></script>
		<link rel="stylesheet" href="css/bootstrap/bootstrap.min.css">
		<script src="js/modernizr.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/vendor/tabcomplete.min.js"></script>
		<script src="js/vendor/livefilter.min.js"></script>
		<script src="js/vendor/src/bootstrap-select.js"></script>
		<script src="js/vendor/src/filterlist.js"></script>
		<script src="js/plugins.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		
		<!--[if IE]>
			<script src="http://libs.useso.com/js/html5shiv/3.7/html5shiv.min.js"></script>
		<![endif]-->
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
	   	function addFlow(){
	   		//请假
   			if($("#leave_id").val().length<1){
   				$("#resumption_error").text("请选择请假单");
   			}else{
   				$("#resumption_error").text("");
   				document.flowform.foreign_id.value=$("#leave_id").val();
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
						<form action="FlowManagerServlet?type=addResumption" method="post" name="flowform">
							<div class="td2_div">
								<div class="td2_div1">销假单</div>
								<table class="td2_table0">
									<tr class="table0_tr0">
										<td class="table0_tr0_td1"><span class="star">*</span>选择类型</td>
										<td class="table0_tr0_td2">
											<div class="table0_div_left">
												<select name="resumptionType" id="resumptionType">
													<option value="2">请假单</option>
												</select>
											</div>
											<div class="table0_div_right">
												<span id="type_error"></span>
											</div>
										</td>
									</tr>
									<tr class="table0_tr1">
										<td class="table0_tr1_td1"><span class="star">*</span>关联单</td>
										<td class="table0_tr1_td2">
											<jsp:include page="/flowmanager/drop_down_resumption.jsp" />
												<input type="hidden" name="foreign_id" id="foreign_id"  value="">
											<div class="table0_div_right">
												<span id="resumption_error"></span>
											</div>
										</td>
									</tr>
								</table>
								<div class="div_btn">
									<img src="images/submit_flow.png" class="btn_agree" onclick="addFlow();">
								</div>
							</div>
						</form>
					</td>
				</tr>
			</table>

		</div>
	</body>
</html>
