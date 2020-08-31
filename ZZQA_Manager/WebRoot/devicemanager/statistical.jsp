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
	String[] statisticalArray = DataUtil.getStatisticalArray();
	List<Integer>statisticalList=new ArrayList<Integer>();
	if(session.getAttribute("statistics_device")==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	if((Boolean)session.getAttribute("statistics_device")){
		statisticalList.add(1);
	}
	if((Boolean)session.getAttribute("statistics_travel")){
		statisticalList.add(2);
	}
	if((Boolean)session.getAttribute("statistics_leave")){
		statisticalList.add(3);
	}
	if((Boolean)session.getAttribute("statistics_track")){
		statisticalList.add(4);
	}
	if((Boolean)session.getAttribute("statistics_customer")){
		statisticalList.add(5);
	}
	if((Boolean)session.getAttribute("statistics_supplier")){
		statisticalList.add(6);
	}
	if((Boolean)session.getAttribute("statistics_material")){
		statisticalList.add(7);
	}
	if((Boolean)session.getAttribute("statistics_work")){
		statisticalList.add(8);
	}
	if((Boolean)session.getAttribute("statistics_sale")){
		statisticalList.add(9);
	}
	if((Boolean)session.getAttribute("statistics_purchase")){
		statisticalList.add(10);
	}
	if((Boolean)session.getAttribute("statistics_shipping")){
		statisticalList.add(11);
	}
	if((Boolean)session.getAttribute("statistics_performance")){
		statisticalList.add(12);
	}
	if((Boolean)session.getAttribute("statistics_vehicle")){
		statisticalList.add(13);
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>统计报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/statistical.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
		$(function(){
			var pagerow=20;
			var screen_height=screen.height;
			if(screen_height>1200){
				pagerow=30;
			}else if(screen_height>950){
				pagerow=25;
			}
			document.flowform.pagerow.value=pagerow;
		});
		function addFlow(index){
			document.flowform.selecttype.value=index;
			document.flowform.submit();
		}
	</script>
	</head>

	<body>
		<jsp:include page="/top.jsp" >
	<jsp:param name="name" value="<%=mUser.getName() %>" />
	<jsp:param name="level" value="<%=mUser.getLevel() %>" />
	<jsp:param name="index" value="2" />
	</jsp:include>
		<div class="td1_device">
			<form action="DeviceServlet?type=statistical" method="post" name="flowform">
				<input type="hidden" name="selecttype">
				<input type="hidden" name="pagerow" value="16">
				<div class="td1_div">
					<fieldset class="fieldset">
						<legend>
							请选择报表类型
						</legend>
						<%int num=statisticalList.size();int rows=(num%3==0?0:1)+num/3;for(int i=0;i<rows;i++){%>
						<div>
							<div onclick="addFlow(<%=statisticalList.get(i*3) %>)">
								<%=statisticalArray[statisticalList.get(i*3)] %>
							</div>
							<%if(num>(i*3+1)){%>
							<div onclick="addFlow(<%=statisticalList.get(i*3+1)%>)">
								<%=statisticalArray[statisticalList.get(i*3+1)] %>
							</div>
							<%} %>
							<%if(num>(i*3+2)){%>
							<div onclick="addFlow(<%=statisticalList.get(i*3+2) %>)">
								<%=statisticalArray[statisticalList.get(i*3+2)] %>
							</div>
							<%} %>
						</div>
						<%} %>
					</fieldset>
				</div>
			</form>

		</div>
	</body>
</html>
