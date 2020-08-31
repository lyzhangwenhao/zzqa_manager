<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%
	UserManager userManager = (UserManager) WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("userManager");
	PermissionsManager permissionsManager = (PermissionsManager) WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("permissionsManager");
	int uid = (Integer) session.getAttribute("uid");
	User mUser = userManager.getUserByID(uid);
	String username=mUser.getName();
	int index=Integer.parseInt(request.getParameter("index"));
%>
   <div class="div_center_left">
		<ul>
			<li>
				<div class="<%=index==1?"divlang_press":"divlang_normal"%>" onclick="window.location.href='communicate/more_notify.jsp'">
					<img src="images/notify.png">
					<div class="div_word">
						通知
					</div>
					<div class="div_nav">
						>
					</div>
				</div>
			</li>
			<li>
				<div class="<%=index==2?"divlang_press":"divlang_normal"%>" onclick="window.location.href='communicate/advise.jsp'">
					<img src="images/advise.png">
					<div class="div_word">
						建议
					</div>
					<div class="div_nav">
						>
					</div>
				</div>
			</li>
			<%if(permissionsManager.checkPermission(mUser.getPosition_id(), 46)){ %>
			<li>
				<div class="<%=index==3?"divlang_press":"divlang_normal"%>" onclick="window.location.href='communicate/feedback.jsp'">
					<img src="images/feedback.png">
					<div class="div_word">
						反馈
					</div>
					<div class="div_nav">
						>
					</div>
				</div>
			</li>
			<%} %>
			<%if(permissionsManager.checkPermission(mUser.getPosition_id(), 42)){ %>
			<li>
				<div class="<%=index==4?"divlang_press":"divlang_normal"%>" onclick="window.location.href='communicate/mynotify.jsp'">
					<img src="images/publish_notify.png">
					<div class="div_word">
						发布通知
					</div>
					<div class="div_nav">
						>
					</div>
				</div>
			</li>
			<%} %>
			<li>
				<div class="<%=index==5?"divlang_press":"divlang_normal"%>" onclick="window.location.href='communicate/approve_feedback.jsp'">
					<img src="images/approve_feedback.png">
					<div class="div_word">
						审核反馈
					</div>
					<div class="div_nav">
						>
					</div>
				</div>
			</li>
		</ul>
	</div>