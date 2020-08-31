<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page import="com.zzqa.service.interfaces.task.TaskManager"%>
<%@page import="com.zzqa.pojo.task.Task"%>
<%@page
	import="com.zzqa.service.interfaces.task_conflict.Task_conflictManager"%>
<%@page import="com.zzqa.pojo.task_conflict.Task_conflict"%>
<%@page import="com.zzqa.service.interfaces.linkman.LinkmanManager"%>
<%@page import="com.zzqa.pojo.linkman.Linkman"%>
<%@page import="com.zzqa.service.interfaces.file_path.File_pathManager"%>
<%@page import="com.zzqa.pojo.file_path.File_path"%>
<%@page
	import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%@page import="com.zzqa.util.FormTransform"%>
<%request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	FlowManager flowManager = (FlowManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("flowManager");
	TaskManager taskManager = (TaskManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("taskManager");
	LinkmanManager linkmanManager = (LinkmanManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("linkmanManager");
	File_pathManager file_pathManager = (File_pathManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("file_pathManager");
	Position_userManager position_userManager = (Position_userManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("position_userManager");
	Task_conflictManager task_conflictManager = (Task_conflictManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("task_conflictManager");
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
	Task_conflict task_conflict = task_conflictManager
			.getTask_conflictByTaskID(task_id);
	if(task_conflict==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	String[] pCaseArray = DataUtil.getPCaseArray();
	String[] stageArray = DataUtil.getStageArray();
	String[] pTypeArray = DataUtil.getPTypeArray();
	List<Linkman> linkmanList1 = linkmanManager.getLinkmanListLimit(1,
			task_id, 1, 1);
	List<Linkman> linkmanList2 = linkmanManager.getLinkmanListLimit(1,
			task_id, 2, 1);
	List<Linkman> linkmanList3 = linkmanManager.getLinkmanListLimit(1,
			task_id, 3, 1);
	List<File_path> fpathList1 = file_pathManager
			.getAllFileByCondition(1, task_id, 1, 1);
	List<File_path> fpathList2 = file_pathManager
			.getAllFileByCondition(1, task_id, 2, 1);
	boolean[] ifchanged=task_conflictManager.checkConflict(task_id);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>修改前任务单流程</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/top.css">
<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
<link rel="stylesheet" type="text/css" href="css/taskflow_conflict.css">
<script src="js/jquery.min.js" type="text/javascript"></script>

<script type="text/javascript" src="js/public.js"></script>
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript">
			function choseflow(index){
				if(index==1){
					window.location.href="flowmanager/backlog.jsp";
				}else if(index==2){
					window.location.href="flowmanager/flowlist.jsp";
				}else if(index==3){
					window.location.href="flowmanager/newflow.jsp";
				}
			}
		</script>
</head>

<body>
	<jsp:include page="/top.jsp">
		<jsp:param name="name" value="<%=mUser.getName() %>" />
		<jsp:param name="level" value="<%=mUser.getLevel() %>" />
		<jsp:param name="index" value="1" />
	</jsp:include>
	<div class="div_center">
		<table class="table_center">
			<tr>
				<jsp:include page="/flowmanager/flowTab.jsp">
						<jsp:param name="index" value="0" />
					</jsp:include>
				<td class="table_center_td2">
					<div class="td2_div">
						<div class="td2_div3">项目任务单 对比</div>
						<table class="td2_table1">
							<tr class="table1_tr1">
								<td
									class="<%=ifchanged[14]?"table1_tr1_td1":"table1_tr1_td1_red" %>">
									项目类型：</td>
								<td class="table1_tr1_td2">
									<div><%=DataUtil.getPCategoryArray()[task_conflict.getProject_category()]%></div>
								</td>
							</tr>
							<tr class="table1_tr1">
								<td
									class="<%=ifchanged[15]?"table1_tr1_td1":"table1_tr1_td1_red" %>">
									产品类型：</td>
								<td class="table1_tr1_td2">
<%--									<div><%=DataUtil.getProductTypeArray()[task_conflict.getProduct_type()]%></div>--%>
									<%if(task_conflict.getProject_category()==0 && "1".equals(task_conflict.getIs_new_data())){ %>
										<div><%=task_conflict.getFan_product_type()%></div>
									<%} else { %>
										<div><%=DataUtil.getProductTypeArray()[task_conflict.getProduct_type()]%></div>
									<%} %>
								</td>
							</tr>
							<tr class="table1_tr1">
								<td
									class="<%=ifchanged[0]?"table1_tr1_td1":"table1_tr1_td1_red" %>">
									项目序号：</td>
								<td class="table1_tr1_td2">
									<div><%=task_conflict.getProject_name()%></div>
								</td>
							</tr>
							<tr class="table1_tr2">
								<td
									class="<%=ifchanged[1]?"table1_tr2_td1":"table1_tr2_td1_red" %>">
									项目编号：</td>
								<td class="table1_tr2_td2"><span><%=task_conflict.getProject_id()%></span>
								</td>
							</tr>
<%--							<tr class="table1_tr2">--%>
<%--								<td class="<%=ifchanged[17]?"table1_tr2_td1":"table1_tr2_td1_red" %>">--%>
<%--									项目质保期：--%>
<%--								</td>--%>
<%--								<td class="table1_tr2_td2">--%>
<%--									<span id="project_life"><%=task_conflict.getProject_life() == null?"/" : task_conflict.getProject_life()%></span>--%>
<%--								</td>--%>
<%--							</tr>--%>
<%--							<tr class="table1_tr2">--%>
<%--								<td class="<%=ifchanged[18]?"table1_tr2_td1":"table1_tr2_td1_red" %>">--%>
<%--								            项目诊断      </br>--%>
<%--									报告周期：--%>
<%--								</td>--%>
<%--								<td class="table1_tr2_td2">--%>
<%--									<span id="project_report_peried"> <%=task_conflict.getProject_report_peried() == null?"/" : task_conflict.getProject_report_peried()%></span>--%>
<%--								</td>--%>
<%--							</tr>--%>
<%--							<tr class="table1_tr3">--%>
<%--								<td--%>
<%--									class="<%=ifchanged[2]?"table1_tr3_td1":"table1_tr3_td1_red" %>">--%>
<%--									项目情况：</td>--%>
<%--								<td class="table1_tr3_td2"><span><%=pCaseArray[task_conflict.getProject_case()]%></span>--%>
<%--								</td>--%>
<%--							</tr>--%>
<%--							<tr class="table1_tr4">--%>
<%--								<td--%>
<%--									class="<%=ifchanged[3]?"table1_tr4_td1":"table1_tr4_td1_red" %>">--%>
<%--									销售阶段：</td>--%>
<%--								<td class="table1_tr4_td2"><span><%=stageArray[task_conflict.getStage()]%></span>--%>
<%--								</td>--%>
<%--							</tr>--%>
<%--							<tr class="table1_tr5">--%>
<%--								<td--%>
<%--									class="<%=ifchanged[4]?"table1_tr5_td1":"table1_tr5_td1_red" %>">--%>
<%--									工程类型：</td>--%>
<%--								<td class="table1_tr5_td2"><span><%=pTypeArray[task_conflict.getProject_type()]%></span>--%>
<%--								</td>--%>
<%--							</tr>--%>
							<%if ("1".equals(task_conflict.getIs_new_data())) { %>
								<tr class="table1_tr2">
									<td class="<%=ifchanged[20]?"table1_tr1_td1":"table1_tr1_td1_red" %>">
										风机数量：
									</td>
									<td class="table1_tr2_td2">
										<span id="fan_num"><%=task_conflict.getFan_num()%></span>
									</td>
								</tr>
								<tr class="table1_tr2">
									<td class="<%=ifchanged[21]?"table1_tr1_td1":"table1_tr1_td1_red" %>">
										项目名称及主机厂家：
									</td>
									<td class="table1_tr2_td2">
										<span id="factory"><%=task_conflict.getFactory()%></span>
									</td>
								</tr>
								<tr class="table1_tr2">
									<td class="<%=ifchanged[22]?"table1_tr1_td1":"table1_tr1_td1_red" %>">
										项目交期：
									</td>
									<td class="table1_tr2_td2">
										<span id="submit_date"><%=task_conflict.getSubmit_date()%>周</span>
									</td>
								</tr>
								<tr class="table1_tr2">
									<td class="<%=ifchanged[23]?"table1_tr1_td1":"table1_tr1_td1_red" %>">
										合同类型：
									</td>
									<td class="table1_tr2_td2">
										<span id="contract_type"><%=task_conflict.getContract_type()%></span>
									</td>
								</tr>
								<tr class="table1_tr2">
									<td class="<%=ifchanged[24]?"table1_tr1_td1":"table1_tr1_td1_red" %>">
										设备类型：
									</td>
									<td class="table1_tr2_td2">
										<span id="equipment_type"><%=task_conflict.getEquipment_type()%></span>
									</td>
								</tr>
							<%} else {%>
								<tr class="table1_tr2">
									<td class="<%=ifchanged[17]?"table1_tr2_td1":"table1_tr2_td1_red" %>">
										项目质保期：
									</td>
									<td class="table1_tr2_td2">
										<span id="project_life"><%=task_conflict.getProject_life() == null?"/" : task_conflict.getProject_life()%></span>
									</td>
								</tr>
								<tr class="table1_tr2">
									<td class="<%=ifchanged[18]?"table1_tr2_td1":"table1_tr2_td1_red" %>">
										项目诊断      </br>
										报告周期：
									</td>
									<td class="table1_tr2_td2">
										<span id="project_report_peried"> <%=task_conflict.getProject_report_peried() == null?"/" : task_conflict.getProject_report_peried()%></span>
									</td>
								</tr>
								<tr class="table1_tr3">
									<td class="<%=ifchanged[2]?"table1_tr3_td1":"table1_tr3_td1_red" %>">
										项目情况：
									</td>
									<td class="table1_tr3_td2">
										<span id="project_case"><%=pCaseArray[task_conflict.getProject_case()]%></span>
									</td>
								</tr>
								<tr class="table1_tr4">
									<td class="<%=ifchanged[3]?"table1_tr4_td1":"table1_tr4_td1_red" %>">
										销售阶段：
									</td>
									<td class="table1_tr4_td2">
										<span><%=stageArray[task_conflict.getStage()]%></span>
									</td>
								</tr>
								<tr class="table1_tr5">
									<td class="<%=ifchanged[4]?"table1_tr5_td1":"table1_tr5_td1_red" %>">
										工程类型：
									</td>
									<td class="table1_tr5_td2">
										<span><%=pTypeArray[task_conflict.getProject_type()]%></span>
									</td>
								</tr>
							<%} %>
						</table>
						<table class="td2_table2">
							<tr class="table2_tr1">
								<td
									class="<%=ifchanged[5]?"table2_tr1_td1":"table2_tr1_td1_red" %>">
									用户名称</td>
								<td class="table2_tr1_td2"><span><%=task_conflict.getCustomer()%></span>
								</td>
							</tr>
							<tr class="table2_tr2">
								<td
									class="<%=ifchanged[6]?"table2_tr2_td1":"table2_tr2_td1_red" %>">
									用户联系人</td>
								<td class="table2_tr2_td2">
									<%
											for (Linkman linkman : linkmanList1) {
										%> <span><%="姓名：" + linkman.getLinkman()%></span>&nbsp&nbsp <span><%="电话：" + linkman.getPhone()%></span>
									<br /> <%
											}
										%>
								</td>
							</tr>
							<%if (!"1".equals(task_conflict.getIs_new_data())) {%>
								<tr class="table2_tr3">
									<td
											class="<%=ifchanged[7]?"table2_tr3_td1":"table2_tr3_td1_red" %>">
										发票接收人</td>
									<td class="table2_tr3_td2">
										<%
											for (Linkman linkman : linkmanList2) {
										%> <span><%="姓名：" + linkman.getLinkman()%></span>&nbsp&nbsp <span><%="电话：" + linkman.getPhone()%></span>
										<br /> <%
										}
									%>
									</td>
								</tr>
							<%}%>

							<tr class="table2_tr4">
								<td
									class="<%=ifchanged[8]?"table2_tr4_td1":"table2_tr4_td1_red" %>">
									设备联系人</td>
								<td class="table2_tr4_td2">
									<%
											for (Linkman linkman : linkmanList3) {
										%> <span><%="姓名：" + linkman.getLinkman()%></span>&nbsp&nbsp <span><%="电话：" + linkman.getPhone()%></span>
									<br /> <%
											}
										%>

								</td>
							</tr>
							<tr class="table2_tr5">
								<td
									class="<%=ifchanged[9]?"table2_tr5_td1":"table2_tr5_td1_red" %>">
									要求发货时间</td>
								<td class="table2_tr5_td2"><span><%=task_conflict.getDelivery_timestr()%></span>
								</td>
							</tr>
							<tr class="table2_tr1">
								<td class="<%=ifchanged[19]?"table2_tr2_td1":"table2_tr2_td1_red" %>">
									发货地址
								</td>
								<td class="table2_tr1_td2">
									<span><%=task_conflict.getAddress() == null?"/" : task_conflict.getAddress()%></span>
								</td>
							</tr>
							<%if ("1".equals(task_conflict.getIs_new_data())) {%>
								<tr class="table2_tr1">
									<td class="<%=ifchanged[25]?"table1_tr1_td1":"table1_tr1_td1_red" %>">
										收货人
									</td>
									<td class="table2_tr1_td2">
										<span><%=task_conflict.getConsignee()%></span>
									</td>
								</tr>
							<% } %>

							<tr class="table2_tr6">
								<td
									class="<%=ifchanged[10]?"table2_tr6_td1":"table2_tr6_td1_red" %>">
									项目说明及 <br /> 特殊要求
								</td>
								<td class="table2_tr6_td2">
									<%
											if (task_conflict.getInspection() == 0) {
										%>
									<div>1.要求施工前现场开箱验货</div> <%
											}
										%> <%
											if (task_conflict.getVerify() == 0) {
										%>
									<div><%=2 - task_conflict.getInspection()
						- task_conflict.getVerify()%>.发货前需和销售经理确认
									</div> <%
											}
										%>
									<div>
										<%=task_conflict.getDescription()
							.replaceAll("\n", "<br/>")%>
									</div>
								</td>
							</tr>
							<tr class="table2_tr7">
								<td
									class="<%=ifchanged[11]?"table2_tr7_td1":"table2_tr7_td1_red" %>">
									供货清单</td>
								<td class="table2_tr7_td2">
									<%
											for (File_path file_path : fpathList1) {
										%> <a class="img_a" href="javascript:void"
									onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%></a>
									<br /> <%
											}
										%>

								</td>
							</tr>
							<tr class="table2_tr8">
								<td
									class="<%=ifchanged[12]?"table2_tr8_td1":"table2_tr8_td1_red" %>">
									移交项目中心<br />技术附件
								</td>
								<td class="table2_tr8_td2">
									<%
											if (task_conflict.getProtocol() == 0) {
												for (File_path file_path : fpathList2) {
										%> <a class="img_a" href="javascript:void"
									onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%></a>
									<br /> <%
												}
											}
										%> <%
											if (task_conflict.getOther().length() > 0) {
										%><span> <%="其他："
						+ task_conflict.getOther().replaceAll("\n", "<br/>")%></span> <%
											}
										%>

								</td>
							</tr>
							<tr class="table2_tr9">
								<td
									class="<%=ifchanged[13]?"table2_tr9_td1":"table2_tr9_td1_red" %>">
									备注</td>
								<td class="table2_tr9_td2"><%=task_conflict.getRemarks() != null ? task_conflict
					.getRemarks().replaceAll("\n", "<br/>") : ""%></td>
							</tr>

						</table>
					</div>
				</td>
			</tr>
		</table>

	</div>
</body>
</html>
