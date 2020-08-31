<%@page import="com.zzqa.pojo.shipping.Shipping"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.project_procurement.Project_procurementManager"%>
<%@page import="com.zzqa.pojo.project_procurement.Project_procurement"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	Project_procurementManager project_procurementManager=(Project_procurementManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("project_procurementManager");
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
	if (session.getAttribute("task_id") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int task_id = (Integer)session.getAttribute("task_id");
	String[] flowTypeArray=DataUtil.getFlowTypeArray();
	List<Project_procurement> project_procurementList=project_procurementManager.getProject_procurementListByTaskID(task_id);
	pageContext.setAttribute("project_procurementList",project_procurementList);
	pageContext.setAttribute("flowTypeArray",flowTypeArray);
	int index=0;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>项目关联采购流程列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css" href="css/flowlist.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
		var type=0;//全部 
		var showTb0=false;
		$(function(){
			searchflows();
			$('#keywords_flows').bind('keydown',function(event){
			    if(event.keyCode == "13"){
			    	searchflows();
			    }
			});
			$('.div').hover(
				function () {
					if($(".flowcontainer_div").css("display")=="none"){
						if(showTb0){
							$(".div").css("margin-left","-20px");
							$(".div>a").css("margin-left","20px");
						}else{
							$(".div").css("margin-left","0px");
							$(".div>a").css("margin-left","0px");
						}
						$('.flowcontainer_div', this).toggle();
					}
				},
				function () {
					if($(".flowcontainer_div").css("display")!="none"){
						$('.flowcontainer_div', this).toggle();
					}
				}
			);
			$(".flowcontainer_div a:gt(0)").attr("class","unselected_a");
			$(".flowcontainer_div a:eq(0)").attr("class","selected_a");
			$(".chk").next().click(function(event){
				//防止冒泡
				$(this).prev().prop("checked",!$(this).prev().prop("checked"));
				return false;
			});
			$(".tab_tr1_td0").click(function(event){
				$(this).find("input").prop("checked",!$(this).find("input").prop("checked"));
				//防止冒泡
				return false;
			});
		});
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
					<jsp:param name="index" value="1" />
				</jsp:include>
				<td class="table_center_td2">
					<div class="td2_div">
						<table class="device_tab1">
								<tr class="tab_tr1">
									<td class="tab_tr1_td0" style="width: 40px;">
									</td>
									<td class="tab_tr1_td1" style="width:15%;width: 140px;">
										流程编号
									</td>
									<td class="tab_tr1_td2" style="width:30%;">
										流程名称
									</td>
									<td class="tab_tr1_td3" style="width:8%;">
										创建者
									</td>
									<td class="tab_tr1_td4" style="width:120px">
										流程类别
									</td>
									<td class="tab_tr1_td13" style="width:32%;">
										进度
									</td>
								</tr>
								<%int i=-1;for(Project_procurement pp:project_procurementList){  i++;%>
								<tr class="tab_tr<%=i % 2 + 2%> tr_pointer" flow_type="3" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=3&id=<%=pp.getId() %>'">
									<td class="tab_tr1_td0"></td>
									<td class="tab_tr1_td1"><%=pp.getId()%></td>
									<td class="tab_tr1_td2 tooltip_div"><%=pp.getName()%></td>
									<td class="tab_tr1_td3"><%=pp.getCreate_name()%></td>
									<td class="tab_tr1_td4"><%=flowTypeArray[3]%></td>
									<td class="tab_tr1_td13 tooltip_div"><%=pp.getProcess() %></td>
								</tr>
								<%} %>
							</table>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
