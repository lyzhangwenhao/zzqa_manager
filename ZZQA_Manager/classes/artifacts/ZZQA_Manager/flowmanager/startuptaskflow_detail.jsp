<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page import="com.zzqa.service.interfaces.task.TaskManager"%>
<%@page import="com.zzqa.pojo.task.Task"%>
<%@page import="com.zzqa.service.interfaces.linkman.LinkmanManager"%>
<%@page import="com.zzqa.pojo.linkman.Linkman"%>
<%@page import="com.zzqa.service.interfaces.file_path.File_pathManager"%>
<%@page import="com.zzqa.pojo.file_path.File_path"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%@page
	import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%@page import="com.zzqa.util.FormTransform"%>
<%@page import="com.zzqa.service.interfaces.task_updateflow.Task_updateflowManager"%>
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
	PermissionsManager permissionsManager = (PermissionsManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("permissionsManager");
	Task_updateflowManager task_updateflowManager = (Task_updateflowManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("task_updateflowManager");
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
	boolean canUpdate=false;
	boolean canAudit=false;
	boolean updating=false;
	boolean canNotUpdate=false;
	boolean updated=false;
	int operation1=-1;
	Flow flow1 = null;
	Task_updateflow task_updateflow = task_updateflowManager.getTask_updateflowByTaskId(task_id);
	if(task_updateflow==null){
		canAudit=true;
	}else{
		if(task_updateflow.getCount()>0){
			updated=true;
		}
		flow1 = flowManager.getNewFlowByFID(21, task_updateflow.getId());
		if(flow1!=null ){
			operation1 = flow1.getOperation();
			if(operation1==3 || operation1==5 || operation1==7 || operation1==9 || operation1==10){
				canNotUpdate=true;
			}else if(operation1==11){
				canUpdate=true;
			}else{
				updating=true;
				
			}
		}
	}
	String[] flowTypeArray = DataUtil.getFlowTypeArray();
	Flow flow = flowManager.getNewFlowByFID(17, task_id);
	Task task = taskManager.getTaskByID(task_id);
	if(flow==null||task==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int operation = flow.getOperation();
	String[] pCaseArray = DataUtil.getPCaseArray();
	String[] stageArray = DataUtil.getStageArray2();
	String[] pTypeArray = DataUtil.getPTypeArray();
	List<Linkman> linkmanList1 = linkmanManager.getLinkmanListLimit(17,
			task_id, 1, 0);
	List<Linkman> linkmanList2 = linkmanManager.getLinkmanListLimit(17,
			task_id, 2, 0);
	List<Linkman> linkmanList3 = linkmanManager.getLinkmanListLimit(17,
			task_id, 3, 0);
	List<File_path> fpathList1 = file_pathManager
			.getAllFileByCondition(17, task_id, 1, 0);
	List<File_path> fpathList2 = file_pathManager
			.getAllFileByCondition(17, task_id, 2, 0);
	List<File_path> fpathList3 = file_pathManager
			.getAllFileByCondition(17, task_id, 3, 0);
	List<File_path> fpathList4 = file_pathManager
			.getAllFileByCondition(17, task_id, 4, 0);
	List<File_path> fpathList5 = file_pathManager
			.getAllFileByCondition(17, task_id, 5, 0);
	List<File_path> fpathList6 = file_pathManager
			.getAllFileByCondition(17, task_id, 6, 0);
	List<File_path> fpathList7 = file_pathManager
			.getAllFileByCondition(17, task_id, 7, 0);
	List<File_path> fpathList8 = file_pathManager
			.getAllFileByCondition(17, task_id, 8, 0);
	Map<String, String> map= taskManager.getStartUpTaskFlowForDraw(task,flow);
	List<Flow> reasonList = flowManager.getReasonList(17,task_id);
	int position_id=mUser.getPosition_id();
	boolean canApprove=flowManager.checkCanDo(17, mUser, operation);
	FormTransform ftf=new FormTransform();
	task.setDescription(ftf.transRNToBR(ftf.transHtml(task.getDescription())));
	task.setOther2(ftf.transRNToBR(ftf.transHtml(task.getOther2())));
	task.setOther3(ftf.transRNToBR(ftf.transHtml(task.getOther3())));
	task.setOther4(ftf.transRNToBR(ftf.transHtml(task.getOther4())));
	task.setOther5(ftf.transRNToBR(ftf.transHtml(task.getOther5())));
	task.setOther6(ftf.transRNToBR(ftf.transHtml(task.getOther6())));
	pageContext.setAttribute("operation", operation);
	pageContext.setAttribute("task", task);
	pageContext.setAttribute("mUser", mUser);
	pageContext.setAttribute("canUpdate", canUpdate);
	pageContext.setAttribute("canAudit", canAudit);
	pageContext.setAttribute("updating", updating);
	pageContext.setAttribute("updated", updated);
	pageContext.setAttribute("canNotUpdate", canNotUpdate);
	pageContext.setAttribute("canApprove", canApprove);
	pageContext.setAttribute("pCaseArray", pCaseArray);
	pageContext.setAttribute("stageArray", stageArray);
	pageContext.setAttribute("pTypeArray", pTypeArray);
	pageContext.setAttribute("linkmanList1", linkmanList1);
	pageContext.setAttribute("linkmanList2", linkmanList2);
	pageContext.setAttribute("linkmanList3", linkmanList3);
	pageContext.setAttribute("fpathList1", fpathList1);
	pageContext.setAttribute("fpathList2", fpathList2);
	pageContext.setAttribute("fpathList3", fpathList3);
	pageContext.setAttribute("fpathList4", fpathList4);
	pageContext.setAttribute("fpathList5", fpathList5);
	pageContext.setAttribute("fpathList6", fpathList6);
	pageContext.setAttribute("fpathList7", fpathList7);
	pageContext.setAttribute("fpathList8", fpathList8);
	pageContext.setAttribute("map", map);
	pageContext.setAttribute("reasonList", reasonList);
	pageContext.setAttribute("canDelFile", (operation==10||operation==12)&&mUser.getId()==task.getCreate_id());
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		
		<title>项目启动任务单流程</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css" href="css/startuptaskflow_detail.css">
		<link rel="stylesheet" type="text/css" href="css/custom.css">
		<link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-filer.css">
		<link rel="stylesheet" type="text/css" href="css/default.css">
		<link rel="stylesheet" type="text/css"
			href="css/jquery.filer-dragdropbox-theme.css">
		<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
		<script src="js/prettify.js" type="text/javascript"></script>
		<script src="js/jquery.min.js" type="text/javascript"></script>
		<script src="js/jquery.filer.min.js" type="text/javascript"></script>
		<script src="js/custom.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		
		<script type="text/javascript" src="js/startuptask_detail.js"></script>
		<style>
		body {
			font-size: 62.5%;
		}
		</style>
	<script type="text/javascript">
		var remark="<%=task.getRemarks() != null ? task.getRemarks().replaceAll("\r\n", "<br/>").replaceAll("\n\r", "<br/>").replaceAll("\r", "<br/>").replaceAll("\n", "<br/>") : ""%>";
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
					<form action="NewFlowServlet" method="post" name="flowform2">
						<input type="hidden" name="reason">
						<input type="hidden" name="type">
						<input type="hidden" name="task_id" value=<%=task_id %>>
					</form>
						<form
							action="NewFlowServlet" method="post" name="flowform">
							<input type="hidden" name="isagree" value="">
							<input type="hidden" name="task_id" value=<%=task_id %>>
							<input type="hidden" name="operation" value="${operation}">
							<input type="hidden" name="type" value="verifystartuptaskflow">
							<input type="hidden" name="file_time" value="<%=System.currentTimeMillis() %>">
							<div class="td2_div">
								<div class="td2_div1">
									<div class="${map.title1_flow}">
										<div class="${map.color1}">提交任务单</div>
										<div class="${map.color2}">技术负责人审批</div>
										<div class="${map.color3}">部门经理审批</div>
										<div class="${map.color4}">总经理审批</div>
										<div class="${map.color5}"><%=operation==8?"已撤销":(task.getStage()==4?"上传合同":"已完成") %></div>
										<div class="${map.color6}">合同审批</div>
										<div class="${map.color7}">已完成</div>
									</div>
									<div class="${map.title2_flow}">
										<img src="images/${map.img1}">
										<div class='${map.bg_color1}'></div>
										<img src="images/${map.img2}">
										<div class='${map.bg_color2}'></div>
										<img src="images/${map.img3}">
										<div class='${map.bg_color3}'></div>
										<img src="images/${map.img4}">
										<div class='${map.bg_color4}'></div>
										<img src="images/${map.img5}">
										<div class='${map.bg_color5}'></div>
										<img src="images/${map.img6}">
										<div class='${map.bg_color6}'></div>
										<img src="images/${map.img7}">
									</div>
									<div class="${map.title3_flow}">
										<div><c:out value="${map.time1}" escapeXml="false"></c:out></div>
										<div><c:out value="${map.time2}" escapeXml="false"></c:out></div>
										<div><c:out value="${map.time3}" escapeXml="false"></c:out></div>
										<div><c:out value="${map.time4}" escapeXml="false"></c:out></div>
										<div><c:out value="${map.time5}" escapeXml="false"></c:out></div>
										<div><c:out value="${map.time6}" escapeXml="false"></c:out></div>
										<div><c:out value="${map.time7}" escapeXml="false"></c:out></div>
									</div>									
								</div>
								<div class="td2_div2" id="printContent">
								<!--startprint1-->
									<div class="td2_div3">
										项目启动任务单
									</div>
									<table class="td2_table1">
										<tr class="table1_tr1">
											<td class="table1_tr1_td1">
												项目类型：
											</td>
											<td class="table1_tr1_td2">
												<div ><%=DataUtil.getPCategoryArray2()[task.getProject_category()]%></div>
											</td>
											<td class="table1_tr1_td1">
												<input type="button" value="绑定采购流程" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=42&id=${task.id}'">
											</td>
										</tr>
										<tr class="table1_tr1">
											<td class="table1_tr1_td1">
												产品类型：
											</td>
											<td class="table1_tr1_td2">
												<div ><%=DataUtil.getProductTypeArray2()[task.getProduct_type()]%></div>
											</td>
										</tr>
										<tr class="table1_tr1">
											<td class="table1_tr1_td1">
												项目名称：
											</td>
											<td class="table1_tr1_td2">
												<span id="project_name">${task.project_name}</span>
											</td>
										</tr>
										<tr class="table1_tr2">
											<td class="table1_tr2_td1">
												项目编号：
											</td>
											<td class="table1_tr2_td2">
												<span id="project_id">${task.project_id}</span>
											</td>
										</tr>
										<tr class="table1_tr3">
											<td class="table1_tr3_td1">
												项目情况：
											</td>
											<td class="table1_tr3_td2">
												<span id="project_case">${pCaseArray[task.project_case]}</span>
											</td>
										</tr>
										<tr class="table1_tr4">
											<td class="table1_tr4_td1">
												销售阶段：
											</td>
											<td class="table1_tr4_td2">
												<span>${stageArray[task.stage]}</span>
											</td>
										</tr>
										<tr class="table1_tr5">
											<td class="table1_tr5_td1">
												工程类型：
											</td>
											<td class="table1_tr5_td2">
												<span>${pTypeArray[task.project_type]}</span>
											</td>
										</tr>
									</table>
									<table class="td2_table2">
										<tr class="table2_tr1">
											<td class="table2_tr1_td1">
												用户名称
											</td>
											<td class="table2_tr1_td2">
												<span>${task.customer}</span>
											</td>
										</tr>
										<tr class="table2_tr2">
											<td class="table2_tr2_td1">
												用户联系人
											</td>
											<td class="table2_tr2_td2">
												<c:forEach items="${linkmanList1}" var="linkman">
													<div>
													<span>姓名：${linkman.linkman}</span>&nbsp&nbsp
													<span>电话：${linkman.phone}</span>
													</div>
												</c:forEach>
											</td>
										</tr>
										<tr class="table2_tr3">
											<td class="table2_tr3_td1">
												发票接收人
											</td>
											<td class="table2_tr3_td2">
												<c:forEach items="${linkmanList2}" var="linkman">
													<div>
													<span>姓名：${linkman.linkman}</span>&nbsp&nbsp
													<span>电话：${linkman.phone}</span>
													</div>
												</c:forEach>
											</td>
										</tr>
										<tr class="table2_tr4">
											<td class="table2_tr4_td1">
												设备联系人
											</td>
											<td class="table2_tr4_td2">
												<c:forEach items="${linkmanList3}" var="linkman">
													<div>
													<span>姓名：${linkman.linkman}</span>&nbsp&nbsp
													<span>电话：${linkman.phone}</span>
													</div>
												</c:forEach>
											</td>
										</tr>
										<tr class="table2_tr5">
											<td class="table2_tr5_td1">
												要求发货时间
											</td>
											<td class="table2_tr5_td2">
												<span>${task.delivery_timestr}</span>
											</td>
										</tr>
										<tr class="table2_tr5">
											<td class="table2_tr5_td1">
												合同生效时间
											</td>
											<td class="table2_tr5_td2">
												<span>${task.contract_timestr}</span>
											</td>
										</tr>
										<tr class="table2_tr6">
											<td class="table2_tr6_td1">
												项目说明及
												<br />
												特殊要求(含合同执行风险)
											</td>
											<td class="table2_tr6_td2">
												<c:if test="${task.inspection==0}">
													<div>
														1.要求施工前现场开箱验货
													</div>
												</c:if>
												<c:if test="${task.verify==0}">
													<span><%=2 - task.getInspection() - task.getVerify()%>.发货前需和销售经理确认
												</span>
												</c:if>
												<div>
													${task.description}
												</div>
											</td>
										</tr>
										<tr class="table2_tr7">
											<td class="table2_tr7_td1">
												项目成本核算表
											</td>
											<td class="table2_tr7_td2">
												<c:forEach items="${fpathList1}" var="file_path">
												<div>
													<a class="img_a" href="javascript:void()"
													onclick="fileDown(${file_path.id})">${file_path.file_name}</a>
												</div>
												</c:forEach>
											</td>
										</tr>
										<tr class="table2_tr8">
											<td class="table2_tr8_td1">
												项目技术附件
											</td>
											<td class="table2_tr8_td2">
												<div>
													<div class="file_title_remark">附件1：合同及技术协议扫描件</div>
													<c:forEach items="${fpathList2}" var="file_path">
													<div>
														<a class="img_a" href="javascript:void()" 
														onclick="fileDown(${file_path.id})">${file_path.file_name}</a>
													</div>
													</c:forEach>
													<c:if test="${not empty task.other && fn:length(task.other) >0}">
														<div>备注：${task.other}</div>
													</c:if>
												</div>
												<div>
													<div class="file_title_remark">附件2：项目商务、技术评审邮件记录（虚拟打印PDF版）</div>
													<c:forEach items="${fpathList3}" var="file_path">
													<div>
														<a class="img_a" href="javascript:void()" 
														onclick="fileDown(${file_path.id})">${file_path.file_name}</a>
													</div>
													</c:forEach>
													<c:if test="${not empty task.other2 && fn:length(task.other2) >0}">
														<div>备注：${task.other2}</div>
													</c:if>
												</div>
												<div>
													<div class="file_title_remark">附件3：外部采购设备询价邮件记录</div>
													<c:forEach items="${fpathList4}" var="file_path">
													<div>	
														<a class="img_a" href="javascript:void()" 
														onclick="fileDown(${file_path.id})">${file_path.file_name}</a>
													</div>
													</c:forEach>
													<c:if test="${not empty task.other3 && fn:length(task.other3) >0}">
														<div>备注：${task.other3}</div>
													</c:if>
												</div>
												<div>
													<div class="file_title_remark">附件4：外包服务供应商信息及报价表（供应商评审表）</div>
													<c:forEach items="${fpathList5}" var="file_path">
													<div>	
														<a class="img_a" href="javascript:void()" 
														onclick="fileDown(${file_path.id})">${file_path.file_name}</a>
													</div>
													</c:forEach>
													<c:if test="${not empty task.other4 && fn:length(task.other4) >0}">
														<div>备注：${task.other4}</div>
													</c:if>
												</div>
												<div>
													<div class="file_title_remark">附件5：投标报价表</div>
													<c:forEach items="${fpathList6}" var="file_path">
													<div>	
														<a class="img_a" href="javascript:void()" 
														onclick="fileDown(${file_path.id})">${file_path.file_name}</a>
													</div>
													</c:forEach>
													<c:if test="${not empty task.other5 && fn:length(task.other5) >0}">
														<div>备注：${task.other5}</div>
													</c:if>
												</div>
												<div>
													<div class="file_title_remark">附件6：其他与项目执行相关文档</div>
													<c:forEach items="${fpathList7}" var="file_path">
													<div>	
														<a class="img_a" href="javascript:void()" 
														onclick="fileDown(${file_path.id})">${file_path.file_name}</a>
													</div>
													</c:forEach>
													<c:if test="${not empty task.other6 && fn:length(task.other6) >0}">
														<div>备注：${task.other6}</div>
													</c:if>
												</div>
											</td>
										</tr>
										<tr class="table2_tr9">
											<td class="table2_tr9_td1">
												备注
												<br />
												<br />
												<div style="font: 11px/15px 'SimSun';">
													( 注：修改简单信息请用备注，无需重新审核 )
												</div>
											</td>
											<td class="table2_tr9_td2">
											<!--startprint0-->
												<c:if test="${task.create_id == mUser.id}">
													<textarea id="remarks" name="remarks" placeholder="此处输入备注"
													required="required" maxlength="2000">${task.remarks}</textarea>
													<input type="button" onclick="alertRemarks();" value="保存">
												</c:if>
												<c:if test="${task.create_id != mUser.id}">
													<div><%=ftf.transRNToBR(task.getRemarks()) %></div>
												</c:if>
												<!--endprint0-->
											</td>
										</tr>
										<c:if test="${(fn:length(fpathList8)>0)||(operation==10&&mUser.id==task.create_id)}">
										<tr class="table2_tr9">
											<td class="table2_tr9_td1">
												合同
											</td>
											<td class="table2_tr9_td2">
												<input type="hidden" name="fids_del" id="fids_del">
												<ul class="files_ul ">
												<c:forEach items="${fpathList8}" var="file_path8">
													<li id="file_li_${file_path8.id}">
													<a href="javascript:void(0)" class="img_a" onclick="fileDown(${file_path8.id})">${file_path8.file_name}</a>
													<c:if test="${canDelFile}">
													<a href="javascript:void(0)" class="img_a" onclick="delFile(${file_path8.id},'${file_path8.file_name}')">[删除]</a>
													</c:if>
													</li>
												</c:forEach>
												</ul>
												<c:if test="${canDelFile}">
												<div class="section-white">
													<input type="file" name="file_technical8" id="file_input8" multiple="multiple">												
												</div>
												</c:if>
											</td>
										</tr>
										</c:if>
									</table>

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
											<%if(reasonOperation==2||reasonOperation==4||reasonOperation==7||reasonOperation==9||reasonOperation==10){ %>
												<div class="td2_div5_bottom_agree">
											<%}else if(reasonOperation==3||reasonOperation==5||reasonOperation==6||reasonOperation==12){ %>
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
									<!--endprint1-->
								</div>
								
								<c:if test="${canApprove||(mUser.id==task.create_id&&operation!=8)}">
									<textarea name="reason" class="div_testarea"
									placeholder="请输入意见或建议" required="required" maxlength="500"
									onkeydown="if(event.keyCode==32) return false"></textarea>
								</c:if>
								<c:if test="${!updating}">
									<div class="div_btn">
										<c:if test="${task.create_id == mUser.id&& ((operation != 7&& operation != 8&& operation != 9&& operation != 10&&(!canUpdate))||(operation == 10 && canUpdate)) && !updated}">
											<img src="images/alter_flow.png" class="fistbutton"
											onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=26&id=${task.id}'">
										</c:if>
										<c:if test="${task.create_id == mUser.id && operation == 10 && canAudit && !updated}">
											<img src="images/alter_flow.png" class="btn_agree" onclick="alterFlow();">
										</c:if>
										<c:if test="${canAudit || canNotUpdate || canUpdate}">
											<c:if test="${mUser.id==task.create_id&&operation!=8}">
												<img src="images/delete_travel.png" class="btn_agree" onclick="cancleTask(0)">
											</c:if>
											<c:if test="${canApprove}">
												<img src="images/agree_flow.png" class="btn_agree" onclick="verifyFlow(0);">
												<c:if test="${operation ==1||operation ==2||operation==4||operation==11}">
													<img src="images/disagree_flow.png" class="btn_disagree" onclick="verifyFlow(1);">
												</c:if>
											</c:if>
											<c:if test="${task.isedited == 1}">
												<a href="FlowManagerServlet?type=flowdetail&flowtype=27&id=${task.id}"
												target="_blank"><img src="images/contrast.png" class="btn_disagree"> </a>
											</c:if>
											<c:if test="${operation==7||operation==9}">
												<img src="images/print.jpg" class="btn_agree" onclick="preview();">
											</c:if>
											<c:if test="${operation==8&&task.create_id==mUser.id}">
												<img src="images/recover.png" class="btn_agree" onclick="cancleTask(1);">
											</c:if>
											<c:if test="${((operation==10||operation==12)&&mUser.id==task.create_id)}">
											<img src="images/submit_flow.png" class="btn_agree" onclick="addfile();">
											</c:if>
										</c:if>
									</div>
								</c:if>
							</div>
						</form>
					</td>
				</tr>
			</table>

		</div>
	</body>
</html>
