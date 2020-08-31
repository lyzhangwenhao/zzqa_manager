<%@page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page
	import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	Position_userManager position_userManager = (Position_userManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("position_userManager");
	PermissionsManager permissionsManager = (PermissionsManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("permissionsManager");

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
	String[] flowTypeArray = DataUtil.getFlowTypeArray();
	boolean[] newFLowArray=(boolean[])session.getAttribute("newFLowArray");
	List<Integer> flowList=new ArrayList<Integer>();
	if((Boolean)session.getAttribute("newflow_task")){
		flowList.add(1);
	}
	if((Boolean)session.getAttribute("newflow_product")){
		flowList.add(2);
	}
	if((Boolean)session.getAttribute("newflow_project")){
		flowList.add(3);
	}
	if((Boolean)session.getAttribute("newflow_out")){
		flowList.add(4);
	}
	/* if((Boolean)session.getAttribute("newflow_manufacture")){
		flowList.add(5);
	} */
	if((Boolean)session.getAttribute("newflow_shipments")){
		flowList.add(6);
	}
	if((Boolean)session.getAttribute("newflow_travel")){
		flowList.add(7);
	}
	if((Boolean)session.getAttribute("newflow_leave")){
		flowList.add(8);
	}
	if((Boolean)session.getAttribute("newflow_resumption")){
		flowList.add(9);
	}
	if((Boolean)session.getAttribute("newflow_track")){
		flowList.add(10);
	}
	if((Boolean)session.getAttribute("newflow_sale")){
		flowList.add(11);
	}
	if((Boolean)session.getAttribute("newflow_purchase")){
		flowList.add(12);
	}
	if((Boolean)session.getAttribute("newflow_after")){
		flowList.add(13);
	}
	if((Boolean)session.getAttribute("newflow_seal")){
		flowList.add(14);
	}
	if((Boolean)session.getAttribute("newflow_vechile")){
		flowList.add(15);
	}
	if((Boolean)session.getAttribute("newflow_work")){
		flowList.add(16);
	}
	if((Boolean)session.getAttribute("newflow_startupTask")){
		flowList.add(17);
	}
	if((Boolean)session.getAttribute("newflow_shipping")){
		flowList.add(18);
	}
	if((Boolean)session.getAttribute("new_device")){
		pageContext.setAttribute("new_device", true);
	}
	if((Boolean)session.getAttribute("newflow_performance")){
		flowList.add(19);
	}
	if((Boolean)session.getAttribute("newflow_deliver")){
		flowList.add(20);
	}
	if((Boolean)session.getAttribute("newflow_oDepartment")){
		flowList.add(22);
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">
		<title>新建流程</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css" href="css/newflow.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
		$(function(){
			/* if(${new_device}){
				if($(".fieldset>div").length>0&&$(".fieldset>div:last div").length<3){
					$(".fieldset>div:last").append('<div onclick="addFlow(10000)">添加产品</div>');
				}else{
					$(".fieldset").append('<div><div onclick="addFlow(10000)">添加产品</div></div>');
				}
			} */
		});
		function addFlow(index){
			document.flowform.selectflowtype.value=index;
			document.flowform.submit();
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
					<td class="table_center_td2_center">
						<form action="FlowManagerServlet?type=addflow" method="post"
							name="flowform">
							<input type="hidden" name="selectflowtype">
							<div class="td2_div">
								<fieldset class="fieldset">
									<legend>
										请选择流程类型
									</legend>
									<%int num=flowList.size();int rows=num/3+(num%3==0?0:1);for(int i=0;i<rows;i++){%>
									<div>
										<div onclick="addFlow(<%=flowList.get(i*3) %>)">
											<%=flowTypeArray[flowList.get(i*3)] %>
										</div>
										<%if(i*3+1<num){%>
										<div onclick="addFlow(<%=flowList.get(i*3+1)%>)">
											<%=flowTypeArray[flowList.get(i*3+1)] %>
										</div>
										<%} %>
										<%if(i*3+2<num){%>
										<div onclick="addFlow(<%=flowList.get(i*3+2) %>)">
											<%=flowTypeArray[flowList.get(i*3+2)] %>
										</div>
										<%} %>
									</div>
									<%} %>
									
								</fieldset>
							</div>
						</form>
					</td>
				</tr>
			</table>

		</div>
	</body>
</html>
