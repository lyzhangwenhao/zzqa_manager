<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
UserManager userManager = (UserManager) WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("userManager");
PermissionsManager permissionsManager = (PermissionsManager) WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("permissionsManager");
int uid = (Integer) session.getAttribute("uid");
User mUser = userManager.getUserByID(uid);
if (mUser == null) {
	request.getRequestDispatcher("/login.jsp").forward(request,
			response);
	return;
}
String name=mUser.getTruename();
String index=request.getParameter("index");
int level=mUser.getLevel();
if (session.getAttribute("communicate")==null) {
	request.getRequestDispatcher("/login.jsp").forward(request,
			response);
	return;
}
if (session.getAttribute("communicate")==null||session.getAttribute("statistics")==null||session.getAttribute("sys")==null) {
	request.getRequestDispatcher("/login.jsp").forward(request,
			response);
	return;
}
boolean communicate=(Boolean)session.getAttribute("communicate");
boolean statistics=(Boolean)session.getAttribute("statistics");
boolean sys=(Boolean)session.getAttribute("sys");
boolean sys_log=(Boolean)session.getAttribute("sys_log");
boolean sys_user=(Boolean)session.getAttribute("sys_user");
%>
    <div class="div_top">
			<div class="div_top1">
				<a href="http://www.windit.com.cn/" target="_blank">
					<img src="images/logo.gif" class="div_top1_img">
				</a>
				<a href="login.jsp?session=0" class="div_top1_span2">退出</a>
				<a href="usermanager/user_detail.jsp" class="div_top1_span" title="<%=name%>"><%=name%></a>
				<span>您好，</span>
			</div>
			<div class="div_top2">
				<div class="title"><a href="<%=basePath%>home.jsp"><img src="images/title_word.png" class="img-ltop"></a>
							<table class="table_headline">
								<tr>
								<td class="<%="1".equals(index)?"headline_press":"headline_normal" %>">
										<a href="flowmanager/backlog.jsp">
												<span>
													流程管理
												</span>
										</a>
									</td>
									<%if(communicate){ %>
										<td class="<%="4".equals(index)?"headline_press":"headline_normal" %>">
										<a href="communicate/more_notify.jsp">
											<span>
												交流平台
											</span>
										</a>
									</td>
									<%} %>
									<%if(statistics){ %>
									<td class="<%="2".equals(index)?"headline_press":"headline_normal" %>">
										<a href="devicemanager/statistical.jsp">
											<span>
												统计报表
											</span>
										</a>
									</td>
									<%} %>
									<%if(sys){ %>
									<td class="<%="3".equals(index)?"headline_press":"headline_normal" %>">
										<a href="<%=sys_user?"usermanager/usermanager.jsp":"log/log.jsp" %>">
											<span>
												系统管理
											</span>
										</a>
									</td>
									<%} %>
								</tr>
							</table>
				</div>
			</div>
		</div>
