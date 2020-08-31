<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
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
	int year_leave=DataUtil.getCurrentYear();
	int maxYear=year_leave+1;//能算到下一年
	int month_leave=DataUtil.getCurrentMonth(); 
	if (session.getAttribute("year_leave") != null) {
		year_leave = (Integer)session.getAttribute("year_leave");
	}
	if (session.getAttribute("month_leave") != null) {
		month_leave= (Integer)session.getAttribute("month_leave");
	}
	List<Leave> leaveList=leaveManager.getLeaveListReport(year_leave,month_leave);
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>请假月报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<link rel="stylesheet" href="css/bootstrap/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="css/statistical.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<%-- 放在bootstrap.min.js后面，避免对话框关闭按钮无法出初始化--%>
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		<script type="text/javascript" src="js/showdate1.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
	    function choseLeave(year,month,obj){
	    	obj.blur();
	    	document.leaveform.year_leave.value=year;
	    	document.leaveform.month_leave.value=month;
	    	document.leaveform.submit();
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
			<form action="DeviceServlet?type=leavefilter" method="post"
				name="leaveform">
				<input type="hidden" name="year_leave" value="<%=year_leave%>">
				<input type="hidden" name="month_leave" value="<%=month_leave%>">
				<div class="td1_div1">
					请假月报表
				</div>
				<div class="td1_div2">
					<div class="btn-group btn-group1">
						<button type="button" class="btn btn-primary" onclick="choseLeave(<%=year_leave%>,<%=month_leave%>,this)"><%=year_leave %>年</button>
						<div class="between-div"></div>
						<button type="button" class="btn btn-primary dropdown-toggle" 
								data-toggle="dropdown">
							<span class="caret"></span>
							<span class="sr-only">切换年份</span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<%for(int i=2016;i<=maxYear;i++){ %>
							<li><a href="javascript:void(0)" onclick="choseLeave(<%=i%>,<%=month_leave%>,this)"><%=i%>年</a></li>
							<%} %>
						</ul>
					</div>
					<div class="btn-group btn-group1">
						<button type="button" class="btn btn-primary" onclick="choseLeave(<%=year_leave%>,<%=month_leave%>,this)"><%=month_leave %>月</button>
						<div class="between-div"></div>
						<button type="button" class="btn btn-primary dropdown-toggle" 
								data-toggle="dropdown">
							<span class="caret"></span>
							<span class="sr-only">切换月份</span>
						</button>
						<ul class="dropdown-menu" role="menu">
						<%for(int i=1;i<13;i++){ %>
							<li><a href="javascript:void(0)" onclick="choseLeave(<%=year_leave%>,<%=i%>,this)"><%=i%>月</a></li>
							<%} %>
						</ul>
					</div>
					<div class="td1_div2_div" onclick="loadDownReport(2,<%=leaveList.size()%>,<%=year_leave%>,<%=month_leave%>)">
						<img src="images/downreport.png">
						<div>下载</div>
					</div>
				</div>
				<table class="device_tab">
					<tr class="tab_tr1">
						<td class="tab_tr1_td1" style="width:150px;">
							部门
						</td>
						<td class="tab_tr1_td2" style="width:120px;">
							姓名
						</td>
						<td class="tab_tr1_td3" style="width:100px;">
							请假类型
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
					<% int leaveLen=leaveList.size();for(int i=0;i<leaveLen;i++){Leave leave=leaveList.get(i); %>
					<tr class="tab_tr<%=i%2+2%>" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=8&id=<%=leave.getId()%>'" style="cursor:pointer;">
						<td class="tab_tr1_td1 tooltip_div">
							<%=leave.getDepartment_name() %>
						</td>
						<td class="tab_tr1_td2 tooltip_div">
							<%=leave.getCreate_name() %>
						</td>
						<td class="tab_tr1_td3" >
							<%=leave.getLeaveType_name() %>
						</td>
						<td class="tab_tr1_td4" >
							<%=leave.getStartDate() %>
						</td>
						<td class="tab_tr1_td5" >
							<%=leave.getEndDate() %>
						</td>
						<td class="tab_tr1_td6">
							<%=leave.getAlldays() %>
						</td>
						<td class="tab_tr1_td7 tooltip_div">
							<%=leave.getReason() %>
						</td>
					</tr>
					<%} %>
				</table>
				</div>
			</form>
		</div>
	</body>
</html>
