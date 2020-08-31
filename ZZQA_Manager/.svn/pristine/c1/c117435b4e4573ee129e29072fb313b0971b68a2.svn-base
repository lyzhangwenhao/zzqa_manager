<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.travel.TravelManager"%>
<%@page import="com.zzqa.pojo.travel.Travel"%>
<%@page import="com.zzqa.service.interfaces.leave.LeaveManager"%>
<%@page import="com.zzqa.pojo.leave.Leave"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	TravelManager travelManager = (TravelManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("travelManager");
	LeaveManager leaveManager = (LeaveManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("leaveManager");
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
	int year_travel=DataUtil.getCurrentYear();
	int maxYear=year_travel+1;
	int month_travel=DataUtil.getCurrentMonth();
	if (session.getAttribute("year_travel") != null) {
		year_travel = (Integer)session.getAttribute("year_travel");
	}
	if (session.getAttribute("month_travel") != null) {
		month_travel= (Integer)session.getAttribute("month_travel");
	}
	List<Travel> travelList=travelManager.getTravelListReport(year_travel,month_travel);
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>出差月报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="rendere" content="webkit|ie-comp|ie-stand">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<link rel="stylesheet" href="css/bootstrap/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="css/statistical.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<%-- 放在bootstrap.min.js后面，防止对话框关闭按钮无法出初始化--%>
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		<script type="text/javascript" src="js/showdate1.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
	    function choseTravel(year,month,obj){
	    	obj.blur();
	    	document.travelform.year_travel.value=year;
	    	document.travelform.month_travel.value=month;
	    	document.travelform.submit();
	    }
		</script>
	</head>

	<body onload="">
		<jsp:include page="/top.jsp" >
	<jsp:param name="name" value="<%=mUser.getName() %>" />
	<jsp:param name="level" value="<%=mUser.getLevel() %>" />
	<jsp:param name="index" value="2" />
	</jsp:include>
		<div class="td1_device">
			<form action="DeviceServlet?type=travelfilter" method="post"
				name="travelform">
				<input type="hidden" name="year_travel" value="<%=year_travel%>">
				<input type="hidden" name="month_travel" value="<%=month_travel%>">
				<div class="td1_div1">
					出差月报表
				</div>
				<div class="td1_div2">
					<div class="btn-group btn-group1">
						<button type="button" class="btn btn-primary" onclick="choseTravel(<%=year_travel%>,<%=month_travel%>,this)"><%=year_travel %>年</button>
						<div class="between-div"></div>
						<button type="button" class="btn btn-primary dropdown-toggle" 
								data-toggle="dropdown">
							<span class="caret"></span>
							<span class="sr-only">切换年份</span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<%for(int i=2016;i<=maxYear;i++){ %>
							<li><a href="javascript:void(0)" onclick="choseTravel(<%=i%>,<%=month_travel%>,this)"><%=i%>年</a></li>
							<%} %>
						</ul>
					</div>
					<div class="btn-group btn-group1">
						<button type="button" class="btn btn-primary" onclick="choseTravel(<%=year_travel%>,<%=month_travel%>,this)"><%=month_travel %>月</button>
						<div class="between-div"></div>
						<button type="button" class="btn btn-primary dropdown-toggle" 
								data-toggle="dropdown">
							<span class="caret"></span>
							<span class="sr-only">切换月份</span>
						</button>
						<ul class="dropdown-menu" role="menu">
						<%for(int i=1;i<13;i++){ %>
							<li><a href="javascript:void(0)" onclick="choseTravel(<%=year_travel%>,<%=i%>,this)"><%=i%>月</a></li>
							<%} %>
						</ul>
					</div>
					<div class="td1_div2_div" onclick="loadDownReport(1,<%=travelList.size()%>,<%=year_travel%>,<%=month_travel%>)">
						<img src="images/downreport.png">
						<div>下载</div>
					</div>
				</div>
				<table class="device_tab">
					<tr class="tab_tr1">
						<td class="tab_tr1_td1 " style="width:150px;">
							部门
						</td>
						<td class="tab_tr1_td2" style="width:120px;">
							姓名
						</td>
						<td class="tab_tr1_td3" style="min-width:100px;">
							出差地点
						</td>
						<td class="tab_tr1_td4" style="width:120px;">
							开始时间
						</td>
						<td class="tab_tr1_td5" style="width:120px;">
							结束时间
						</td>
						<td class="tab_tr1_td6" style="width:60px;">
							天数
						</td>
						<td class="tab_tr1_td7" >
							事由
						</td>
					</tr>
					<%int travelLen=travelList.size();for(int i=0;i<travelLen;i++){ Travel travel=travelList.get(i);%>
					<tr class="tab_tr<%=i%2+2 %>" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=7&id=<%=travel.getId()%>'" style="cursor:pointer;">
						<td class="tab_tr1_td1 tooltip_div">
							<%=travel.getDepartment_name() %>
						</td>
						<td class="tab_tr1_td2 tooltip_div">
							<%=travel.getCreate_name() %>
						</td>
						<td class="tab_tr1_td3 tooltip_div">
							<%=travel.getAddress() %>
						</td>
						<td class="tab_tr1_td4" >
							<%=travel.getStartDate() %>
						</td>
						<td class="tab_tr1_td5" >
							<%=travel.getEndDate() %>
						</td>
						<td class="tab_tr1_td6">
							<%=travel.getAlldays() %>
						</td>
						<td class="tab_tr1_td7 tooltip_div">
							<%=travel.getReason() %>
						</td>
					</tr>
					<%} %>
				</table>
			</form>
		</div>
	</body>
</html>
