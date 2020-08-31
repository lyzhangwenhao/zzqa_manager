<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.communicate.CommunicateManager"%>
<%@page import="com.zzqa.pojo.notify.Notify"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%@page import="java.text.DecimalFormat"%>
<%request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	CommunicateManager communicateManager=(CommunicateManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("communicateManager");
	if (session.getAttribute("uid") == null) {
		response.sendRedirect("login.jsp");
		return;
	}
	int uid = (Integer) session.getAttribute("uid");
	User mUser = userManager.getUserByID(uid);
	if (mUser == null) {
		response.sendRedirect("login.jsp");
		return;
	}
	session.setAttribute("notify_index", 4);//决定关闭通知详情时跳转的页面
	List<Notify> notifyList=communicateManager.getNotifyListByYear(0, 10,uid);
%>

<!DOCTYPE HTML>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>通知</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/communicate.css">
		<link rel="stylesheet" type="text/css" href="css/mynotify.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
		function jumpToNotify(id){
			document.jumpform.jumpID.value=id;
			document.jumpform.jumpType.value=1;
			document.jumpform.submit();
		}
		</script>
	</head>

	<body>
		<jsp:include page="/top.jsp" >
	<jsp:param name="name" value="<%=mUser.getName() %>" />
	<jsp:param name="level" value="<%=mUser.getLevel() %>" />
	<jsp:param name="index" value="4" />
	</jsp:include>
		<div class="div_center">
			<jsp:include page="/communicate/communicateTab.jsp">
			<jsp:param name="index" value="1" />
			</jsp:include>
			<div class="div_center_right">
				<div class="div_title">通 知</div>
				<div class="div_dashed3"></div>
				<div class="notify_list_common">
				<%for(Notify notify:notifyList){ %>
					<div class="notify_item_common" onclick="jumpToNotify(<%=notify.getId()%>)">
						<div <%=notify.isRead()?"":" class=\"point_notread\"" %>"></div><div class="tooltip_div"><%=notify.getTitle() %></div><div ><%=notify.getUpdate_date() %></div><div class="tooltip_div"><%=notify.getPublisher() %></div>
					</div>
				<%} %>
				</div>
				<div class="div_solid"></div>
				<div class="div_morenotify">
					<a href="javascript:window.location.href='communicate/more_notify.jsp'" >查看更多通知</a>
				</div>
			</div>
		</div>
		<form action="CommunicateServlet" name="jumpform" method="post" >
			<input type="hidden" name="type" value="jumpUrl">
			<input type="hidden" name="jumpType">
			<input type="hidden" name="jumpID">
		</form>
	</body>
</html>
