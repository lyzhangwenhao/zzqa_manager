<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page
	import="com.zzqa.service.interfaces.procurement.ProcurementManager"%>
<%@page import="com.zzqa.service.interfaces.task_updateflow.Task_updateflowManager"%>
<%@page
	import="com.zzqa.service.interfaces.project_procurement.Project_procurementManager"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.service.interfaces.file_path.File_pathManager"%>
<%@page import="com.zzqa.service.interfaces.task.TaskManager"%>
<%@page import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.project_procurement.Project_procurement"%>
<%@page import="com.zzqa.pojo.procurement.Procurement"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page import="com.zzqa.pojo.file_path.File_path"%>
<%@page import="com.zzqa.pojo.task.Task"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.zzqa.pojo.task.Task"%>
<%@page import="com.zzqa.pojo.task_updateflow.Task_updateflow"%>
<%
	request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	ProcurementManager procurementManager = (ProcurementManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("procurementManager");
	Project_procurementManager project_procurementManager = (Project_procurementManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("project_procurementManager");
	FlowManager flowManager = (FlowManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("flowManager");
	File_pathManager file_pathManager = (File_pathManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("file_pathManager");
	TaskManager taskManager = (TaskManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("taskManager");
	Task_updateflowManager task_updateflowManager = (Task_updateflowManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("task_updateflowManager");
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
	if (session.getAttribute("task_updateflow_id") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	} 
	if (session.getAttribute("task_id") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	} 
	int task_updateflow_id = (Integer)session.getAttribute("task_updateflow_id");
	int task_id = (Integer)session.getAttribute("task_id");
	Task_updateflow task_updateflow = task_updateflowManager.getTask_updateflowById(task_updateflow_id);
	Flow flow = flowManager.getNewFlowByFID(21, task_updateflow_id);
	Task task = taskManager.getTaskByID(task_id);
	if(flow==null || task==null || task_updateflow==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	Map<String, String> map = task_updateflowManager.getTask_updateflow(flow);
	String budgetSubmiter="隐匿用户";//预算提交人
	if(task_id>0){
		User user=userManager.getUserByID(task.getCreate_id());
		if(user==null){
			budgetSubmiter="用户"+task.getCreate_id();
		}else{
			budgetSubmiter=user.getTruename();
		}
	}
	List<Flow> reasonList = flowManager.getReasonList(21,task_updateflow_id);
	int operation=flow.getOperation();
	boolean havePemission=false;
	if(operation==1){
		havePemission=permissionsManager.checkPermission(mUser.getPosition_id(),160);
	}else if(operation==2){
		havePemission=permissionsManager.checkPermission(mUser.getPosition_id(),161);
	}else if(operation==4){
		havePemission=permissionsManager.checkPermission(mUser.getPosition_id(),162);
	}else if(operation==6){
		havePemission=permissionsManager.checkPermission(mUser.getPosition_id(),9);
	}
	pageContext.setAttribute("havePemission", havePemission);
	boolean canSubmit=operation != 11 && operation != 3 && operation != 5 && operation != 7 && operation != 9 && havePemission;
	pageContext.setAttribute("canSubmit", canSubmit);
	/* if(operation!=17 && operation!=10){
		canDel=isCreater;//创建人才能撤销
	} */
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>项目启动任务单修改申请流程</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css"
			href="css/task_updateflow.css">
		<link rel="stylesheet" type="text/css" href="css/custom.css">
		<link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-filer.css">
		<link rel="stylesheet" type="text/css" href="css/default.css">
		<link rel="stylesheet" type="text/css"
			href="css/jquery.filer-dragdropbox-theme.css">
		<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
		<script src="js/showdate1.js" type="text/javascript"></script>
		<script src="js/prettify.js" type="text/javascript"></script>
		<script src="js/jquery.min.js" type="text/javascript"></script>
		<script src="js/jquery.filer.min.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		<script type="text/javascript" src="js/refresh_scroll.js"></script>
		<!-- 先将隐藏的上传控件加到body，再渲染 -->
		<script type="text/javascript" src="js/custom.js"></script>
		
		<script type="text/javascript">
		
		function verifyFlow(isagree){
			document.flowform.isagree.value=isagree;
			var reason=document.flowform.reason.value.replace(/\s/g,"");
			if(reason.length==0){
				initdiglog2("提示信息","请输入意见或建议！");
				return;
			}
			document.flowform.type.value="taskupdateflow";
			document.flowform.submit();
		}
		
		function cancleUpdateFlow(){
			//撤销
			initdiglogtwo2("提示信息","您确定要撤销该任务单吗？");
	   		$( "#confirm2" ).click(function() {
				$( "#twobtndialog" ).dialog( "close" );
				var reason=document.flowform.reason.value.replace(/\s/g,"");
				if(reason.length==0){
					initdiglog2("提示信息","请输入意见或建议！");
					return;
				}
				document.flowform.type.value="cancleUpdateFlow";
				document.flowform.submit();
	   		});
		}
		
	</script>
	</head>

	<body>
		<jsp:include page="/top.jsp">
			<jsp:param name="name" value="<%=mUser.getName()%>" />
			<jsp:param name="level" value="<%=mUser.getLevel()%>" />
			<jsp:param name="index" value="1" />
		</jsp:include>
		<div class="div_center">
			<table class="table_center">
				<tr>
					<jsp:include page="/flowmanager/flowTab.jsp">
						<jsp:param name="index" value="0" />
					</jsp:include>
					<td class="table_center_td2">
							<form
							action="FlowManagerServlet"	method="post" name="flowform" >
							<input type="hidden" name="isagree" value="0">
							<input type="hidden" name="operation" value="<%=operation%>">
							<input type="hidden" name="task_updateflow_id" value="<%=task_updateflow_id%>">
							<input type="hidden" name="task_id" value="<%=task_id%>">
							<input type="hidden" name="type" value="">
							<div class="td2_div">
								<div class="td2_div1">
								<%if(operation==3 || operation==5 || operation==7 || operation==9 ||operation==10){ %>
								<div class="<%=map.get("td2_div1_1")%>">
									<div class="<%=map.get("class11")%>">
										项目启动任务单修改申请
									</div>
									<div></div>
									<div></div>
									<div></div>
									<div></div>
									<div></div>
									<div></div>
									<div></div>
									<div class="<%=map.get("class110")%>">
									<%if(operation==10){ %>已撤销<%} %>
									<%if(operation==3 || operation==5 || operation==7 || operation==9){ %>已驳回<%} %>
									</div>
								</div>
								<div class="<%=map.get("td2_div1_2")%>">
									<img src="images/<%=map.get("img1")%>" >
									<div class="<%=map.get("class29")%>"></div>
									
									<img src="images/<%=map.get("img10")%>" >
								</div>
								<div class="<%=map.get("td2_div1_3")%>">
									<div><%=map.get("time1")%></div>
									<div></div>
									<div></div>
									<div></div>
									<div></div>
									<div></div>
									<div></div>
									<div></div>
									<div><%=map.get("time10")%></div>
								</div>
								<%}else{ %>
								<div class="<%=map.get("td2_div1_1")%>">
									<div class="<%=map.get("class11")%>">
										项目启动任务单修改申请
									</div>
									<div class="<%=map.get("class12")%>">
										财务审核
									</div>
									<div class="<%=map.get("class13")%>">
										生产审核
									</div>
									<div class="<%=map.get("class14")%>">
										部门审核
									</div>
									<div class="<%=map.get("class15")%>">
										总经理审核
									</div>
									<div class="<%=map.get("class16")%>">
										已完成
									</div>
								</div>
								<div class="<%=map.get("td2_div1_2")%>">
									<img src="images/<%=map.get("img1")%>" >
									<div class="<%=map.get("class21")%>"></div>
									
									<img src="images/<%=map.get("img2")%>" >
									<div class="<%=map.get("class22")%>"></div>

									<img src="images/<%=map.get("img3")%>" >
									<div class="<%=map.get("class23")%>"></div>

									<img src="images/<%=map.get("img4")%>" >
									<div class="<%=map.get("class24")%>"></div>

									<img src="images/<%=map.get("img5")%>" >
									<div class="<%=map.get("class25")%>"></div>

									<img src="images/<%=map.get("img6")%>" >
								</div>
								<div class="<%=map.get("td2_div1_3")%>">
									<div><%=map.get("time1")%></div>
									<div><%=map.get("time2")%></div>
									<div><%=map.get("time3")%></div>
									<div><%=map.get("time4")%></div>
									<div><%=map.get("time5")%></div>
									<div><%=map.get("time6")%></div>
								</div>
							<%}%>
							</div>
								<div class="td2_div2">
									<div class="td2_div0">
										项目启动任务单修改申请
									</div>
									<div class="td2_div3">
										<div class="td2_div3_1">
											项目名称：<%=task.getProject_name()%>
										</div>
										<div class="td2_div3_2">
											项目编号：<%=task.getProject_id()%>
										</div>
										<div class="td2_div3_3">
											<a href="FlowManagerServlet?type=flowdetail&flowtype=1&id=<%=task.getId()%>" target='_bank'>查看项目启动任务单</a>
										</div>
										<div class="td2_div3_2">
											修改申请人：<%=budgetSubmiter %>
										</div>
									</div>
									
									<table class="td2_table3">
										<%
											int reasonLen = reasonList.size();
											for (int i = 0; i < reasonLen; i++) {
												Flow reasonFlow = reasonList.get(i);
												int reasonOperation=reasonFlow.getOperation();
										%>
										<tr>
											<td class="td2_table3_left">
												<%=reasonFlow.getReason().replaceAll("\n\r","<br/>").replaceAll("\r\n","<br/>").replaceAll("\n","<br/>").replaceAll("\r","<br/>")%>
											</td>
											<td class="td2_table3_right">
											<%if(reasonOperation==2||reasonOperation==4||reasonOperation==6||reasonOperation==8){ %>
												<div class="td2_div5_bottom_agree">
											<%}else if(reasonOperation==3||reasonOperation==5||reasonOperation==7||reasonOperation==9){ %>
											<div class="td2_div5_bottom_disagree">
											<%}else{ %>
											<div class="td2_div5_bottom_noimg">
											<% }%>
													<div style="height: 15px;"></div>
													<div class="td2_div5_bottom_right1"><%=reasonFlow.getUsername()%></div>
													<div class="td2_div5_bottom_right2"><%=reasonFlow.getCreate_date()%></div>
												</div>
											</td>
										</tr>
										<%
											}
										%>
									</table>
									
									<%
										if (canSubmit || (task_updateflow.getCreate_id()==mUser.getId() && (operation==2 || operation==4 || operation==6 || operation==8))) {
									%>
										<textarea name="reason" class="div_testarea"
										placeholder="请输入意见或建议" required="required" maxlength="500"
										onkeydown="if(event.keyCode==32) return false"></textarea>
										<%
										if (task_updateflow.getCreate_id()==mUser.getId() && (operation==1 || operation==2 || operation==4 || operation==6 || operation==8)) {
										%>
										<div class="div_btn">
										<img src="images/delete_travel.png" class="btn_agree" onclick="cancleUpdateFlow();">
										</div>
										<%
										}else{
										%>
										<div class="div_btn">
											<img src="images/agree_flow.png" class="btn_agree"
												onclick="verifyFlow(0);">
											<img src="images/disagree_flow.png" class="btn_disagree"
												onclick="verifyFlow(1);">
										</div>
										<%
											}
										%>
									<%
										}
									%>
								</div>
							</div>
						</form>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
