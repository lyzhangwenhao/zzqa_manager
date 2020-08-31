<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.service.interfaces.leave.LeaveManager"%>
<%@page import="com.zzqa.service.interfaces.resumption.ResumptionManager"%>
<%@page import="com.zzqa.service.interfaces.file_path.File_pathManager"%>
<%@page import="com.zzqa.service.interfaces.travel.TravelManager"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%@page import="com.zzqa.pojo.leave.Leave"%>
<%@page import="com.zzqa.pojo.resumption.Resumption"%>
<%@page import="com.zzqa.pojo.file_path.File_path"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.zzqa.util.DataUtil"%>
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
	Position_userManager position_userManager = (Position_userManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("position_userManager");
	PermissionsManager permissionsManager = (PermissionsManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("permissionsManager");
	LeaveManager leaveManager = (LeaveManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("leaveManager");
	ResumptionManager resumptionManager=(ResumptionManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("resumptionManager");
	File_pathManager file_pathManager=(File_pathManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("file_pathManager");
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
	if (session.getAttribute("leave_id") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int leave_id=(Integer)session.getAttribute("leave_id");
	Leave leave=leaveManager.getLeaveByID(leave_id);
	Flow flow=flowManager.getNewFlowByFID(8, leave_id);
	if(leave==null||flow==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int operation=flow.getOperation();
	Map<String,String> map=leaveManager.getLeaveFlowForDraw(leave,flow);
	List<Flow> reasonList=flowManager.getReasonList(8, leave_id);
	//检查是否可以审批
	boolean flag=leaveManager.checkLeaveCan(operation, leave, mUser);
	Resumption resumption=resumptionManager.getFinishedResumption(2, leave.getId());
	List<File_path> flieList = file_pathManager.getAllFileByCondition(8, leave_id, 1, 0);
	boolean canDel=leave.getCreate_id()==mUser.getId()&&operation==1;
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<title>请假流程</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css" href="css/leaveflow_detail.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script  type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
 		<script type="text/javascript" src="js/dialog.js"></script>
 		<!-- 先将隐藏的上传控件加到body，再渲染 -->
 		
		<!--[if IE]>
			<script src="http://libs.useso.com/js/html5shiv/3.7/html5shiv.min.js"></script>
		<![endif]-->
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
			function verifyFlow(isagree){
				if($("#reason").val().replace(/(^\s*)/g, "").length<1){
					initdiglog2("提示信息","请输入意见或建议！");
					return;
				}
				document.flowform.isagree.value=isagree;
				document.flowform.type.value="leaveflow";
				document.flowform.submit();
			}
			function delLeave(){
				if($("#reason").val().replace(/(^\s*)/g, "").length<1){
					initdiglog2("提示信息","请输入意见或建议！");
					return;
				}
				document.flowform.type.value="delleave";
				document.flowform.submit();
			}
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
						<jsp:param name="index" value="0" />
					</jsp:include>
					<td class="table_center_td2">
						<div class="td2_div1">
							<div class="<%=map.get("class1_1")%>">
								<div <%= map.get("style11")%>>
									请假申请提交
								</div>
								<div <%= map.get("style12")%>>
									部门领导审批
								</div>
								<div <%= map.get("style13")%>>
									分管领导审批
								</div>
								<div <%= map.get("style14")%>>
									总经理审批
								</div>
								<div <%= map.get("style15")%>>
									考勤备案
								</div>
								<div <%= map.get("style16")%>>
									<%=operation==9?"已撤销":"结束"%>
								</div>
							</div>
							<div class="<%=map.get("class1_2")%>">
									<img src="<%= map.get("img1")%>">
									<div <%= map.get("style21")%>></div>
									
									<img src="<%= map.get("img2")%>">
									<div <%= map.get("style22")%>></div>
									
									<img src="<%= map.get("img3")%>">
									<div <%= map.get("style23")%>></div>
									
									<img src="<%= map.get("img4")%>">
									<div <%= map.get("style24")%>></div>

									<img src="<%= map.get("img5")%>">
									<div <%= map.get("style25")%>></div>

									<img src="<%= map.get("img6")%>">
								</div>
								<div class="<%=map.get("class1_3")%>">
									<div ><%= map.get("time1")%></div>
									<div ><%= map.get("time2")%></div>
									<div ><%= map.get("time3")%></div>
									<div ><%= map.get("time4")%></div>
									<div ><%= map.get("time5")%></div>
									<div ><%= map.get("time6")%></div>
								</div>
						</div>
						<form
							action="FlowManagerServlet?leave_id=<%=leave.getId()%>&operation=<%=operation%>"
							method="post" name="flowform">
							<input type="hidden" name="type" value="leaveflow">
							<div class="td2_div2">
								<div class="td2_div3">
									请假备注单
								</div>
								<div class="td2_div4">
										<div>申请人：<%=leave.getCreate_name()%></div>
										<div>考勤备案人：<%=leave.getAttendance_name()%></div>
									</div>
								<table class="td2_table">
									<tr class="table_tr1">
										<td class="table_tr1_td1">部门</td>
										<td class="table_tr1_td2">
										<%=leave.getDepartment_name() %>
										</td>
										<td class="table_tr1_td3">请假类型</td>
										<td class="table_tr1_td4"><%=leave.getLeaveType_name()%></td>
									</tr>
									<tr class="table_tr2">
										<input type="hidden" id="startDate" name="startDate" />
										<input type="hidden" id="endDate" name="endDate" />
										<td class="table_tr2_td1">请假时间</td>
										<td class="table_tr2_td2"  colspan="3">
											<%=leave.getStartDate() %>
											&nbsp;至&nbsp;
											<%=leave.getEndDate() %>
											&nbsp;（共<%=leave.getAlldays()%>天）
											<%if(resumption!=null){ %>
											已销假&nbsp;<br/><a href="FlowManagerServlet?type=flowdetail&flowtype=9&id=<%=resumption.getId()%>" target="_bank">
											<%=resumption.getStartdate() %>
											&nbsp;至&nbsp;
											<%=resumption.getReback_date() %>
											&nbsp;（共<%=DataUtil.subZeroAndDot(String.valueOf(DataUtil.getLeaveDays(resumption.getStarttime(), resumption.getReback_time()-43200000l, leave.getLeave_type())))%>天）
											</a>
											<%} %>
										</td>
									</tr>
									<tr class="table_tr3">
										<td class="table_tr3_td1">请假事由</td>
										<td class="table_tr3_td2"  colspan="3">
											<%=leave.getReason() %>
										</td>
									</tr>
									<tr class="table_tr4">
										<td class="table_tr4_td1">附件</td>
										<td class="table_tr4_td2"  colspan="3">
											<%for(File_path file_path:flieList){%>
												<a href="javascript:void()" onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%></a>
											<%}%>
										</td>
									</tr>
								</table>
								<%if(reasonList.size()>0){ %>
								<div class="td2_div3">
									领导审批
								</div>
								<table class="td2_table3">
										<%
											int reasonLen = reasonList.size();
											for (int i = 0; i < reasonLen; i++) {
												Flow reasonFlow = reasonList.get(i);
										%>
										<tr>
											<td class="td2_table3_left">
												<%=reasonFlow.getReason().replaceAll("\n","<br/>")%>
											</td>
											<td class="td2_table3_right">
												<div
													class="<%=reasonFlow.getOperation() ==2||reasonFlow.getOperation() ==4||reasonFlow.getOperation() ==7 ? "td2_div5_bottom_agree"
								: "td2_div5_bottom_disagree"%> ">
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
											}
										%>
							</div>
							<%
							if(flag||canDel){
							%>
							<textarea name="reason" id="reason"  class="div_testarea" placeholder="请输入意见或建议" required="required" maxlength="500"></textarea>
							<%} %>
							<div class="div_btn">
								<input type="hidden" name="isagree">
								<%
									if (flag) {
								%><img src="images/agree_flow.png" class="btn_agree"
									onclick="verifyFlow(0);">
									<img src="images/disagree_flow.png" class="btn_disagree"
									onclick="verifyFlow(1);">
								<%
									}
								%>
								<%
									if (canDel) {
								%><img src="images/delete_travel.png" class="btn_agree"
									onclick="delLeave();">
								<%
									}
								%>
								<%
									if (leaveManager.checkLeaveBackUp(operation,leave,mUser)) {
								%><img src="images/backup.png" class="btn_agree"
									onclick="submit();">
								<%
									}
								%>
							</div>
						</form>
					</td>
				</tr>
			</table>

		</div>
	</body>
</html>
