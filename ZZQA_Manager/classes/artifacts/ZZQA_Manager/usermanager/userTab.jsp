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
	boolean sys=(Boolean)session.getAttribute("sys");
	boolean sys_log=(Boolean)session.getAttribute("sys_log");
	boolean sys_user=(Boolean)session.getAttribute("sys_user");
%>
   <div class="div_center_left">
		<ul>
		<%if(sys){ %>
		<%if(sys_user){ %>
			<li>
				<div class="<%=index==1?"divlang_press":"divlang_normal"%>" onclick="window.location.href='usermanager/usermanager.jsp'">
					<img src="images/userlist.png">
					<div class="div_word">
						用户列表
					</div>
					<div class="div_nav">
						>
					</div>
				</div>
			</li>
			<li>
				<div class="<%=index==2?"divlang_press":"divlang_normal"%>" onclick="window.location.href='usermanager/create_user.jsp'">
					<img src="images/add_user.png">
					<div class="div_word">
						添加用户
					</div>
					<div class="div_nav">
						>
					</div>
				</div>
			</li>
			<%if("admin".equals(username)){ %>
			<li>
				<div class="<%=index==3?"divlang_press":"divlang_normal"%>" onclick="window.location.href='usermanager/teamtree.jsp'">
					<img src="images/teamtree.png">
					<div class="div_word">
						组织架构
					</div>
					<div class="div_nav">
						>
					</div>
				</div>
			</li>
			<li>
				<div class="<%=index==4?"divlang_press":"divlang_normal"%>" onclick="window.location.href='usermanager/addtree.jsp'">
					<img src="images/add_tree.png">
					<div class="div_word">
						添加组织
					</div>
					<div class="div_nav">
						>
					</div>
				</div>
			</li>
			<%} if(sys_log){%>
			<li>
			<div class="<%=index==6?"divlang_press":"divlang_normal"%>" onclick="window.location.href='log/log.jsp'">
				<img src="images/log.png">
				<div class="div_word">
					操作日志
				</div>
				<div class="div_nav">
					>
				</div>
			</div>
		</li>
			<%}}}else if(index==5){ %>
			<li>
				<div class="divlang_press" onclick="window.location.href='usermanager/user_detail.jsp'">
					<img src="images/personInfo.png">
					<div class="div_word">
						个人信息
					</div>
					<div class="div_nav">
						>
					</div>
				</div>
			</li>
			<%}%>
		</ul>
	</div>