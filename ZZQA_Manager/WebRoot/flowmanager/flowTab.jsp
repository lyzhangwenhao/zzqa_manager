<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%
	PermissionsManager permissionsManager = (PermissionsManager) WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("permissionsManager");
	UserManager userManager = (UserManager) WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("userManager");
	int index = Integer.parseInt(request.getParameter("index"));
	User mUser=userManager.getUserByID((Integer)session.getAttribute("uid"));
	int position_id=mUser.getPosition_id();
	if (session.getAttribute("canNewFlow")==null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	boolean canNewFlow=(Boolean)session.getAttribute("canNewFlow");
%>
<td class="table_center_td1">
	<ul>
		<li>
			<div class="<%=index==1?"divlang_press":"divlang_normal"%>" onclick="window.location.href='flowmanager/backlog.jsp'">
				<img src="images/backlog_press.png">
				<div class="div_word">待办事项</div>
				<div class="div_nav">></div>
			</div>
		</li>
		<li>
			<div class="<%=index==2?"divlang_press":"divlang_normal"%>" onclick="window.location.href='flowmanager/flowlist.jsp'">
				<img src="images/plist_press.png">
				<div class="div_word">流程列表</div>
				<div class="div_nav">></div>
			</div>
		</li>
		<%if(canNewFlow){ %>
		<li>
			<div class="<%=index==3?"divlang_press":"divlang_normal"%>" onclick="window.location.href='flowmanager/newflow.jsp'">
				<img src="images/new_press.png">
				<div class="div_word">新建流程</div>
				<div class="div_nav">></div>
			</div>
		</li>
		<%} %>
	</ul>
</td>