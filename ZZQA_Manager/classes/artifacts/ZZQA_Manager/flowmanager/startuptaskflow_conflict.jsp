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
	List<Linkman> linkmanList1 = linkmanManager.getLinkmanListLimit(17,task_id, 1, 1);
	List<Linkman> linkmanList2 = linkmanManager.getLinkmanListLimit(17,task_id, 2, 1);
	List<Linkman> linkmanList3 = linkmanManager.getLinkmanListLimit(17,task_id, 3, 1);
	List<File_path> fpathList1 = file_pathManager.getAllFileByCondition(17, task_id, 1, 1);
	List<File_path> fpathList2 = file_pathManager.getAllFileByCondition(17, task_id, 2, 1);
	List<File_path> fpathList3 = file_pathManager.getAllFileByCondition(17, task_id, 3, 1);
	List<File_path> fpathList4 = file_pathManager.getAllFileByCondition(17, task_id, 4, 1);
	List<File_path> fpathList5 = file_pathManager.getAllFileByCondition(17, task_id, 5, 1);
	List<File_path> fpathList6 = file_pathManager.getAllFileByCondition(17, task_id, 6, 1);
	List<File_path> fpathList7 = file_pathManager.getAllFileByCondition(17, task_id, 7, 1);
	boolean[] ifchanged=task_conflictManager.checkConflict(task_id);
	FormTransform ftf=new FormTransform();
	task_conflict.setDescription(ftf.transRNToBR(ftf.transHtml(task_conflict.getDescription())));
	task_conflict.setOther(ftf.transRNToBR(ftf.transHtml(task_conflict.getOther())));
	task_conflict.setOther2(ftf.transRNToBR(ftf.transHtml(task_conflict.getOther2())));
	task_conflict.setOther3(ftf.transRNToBR(ftf.transHtml(task_conflict.getOther3())));
	task_conflict.setOther4(ftf.transRNToBR(ftf.transHtml(task_conflict.getOther4())));
	task_conflict.setOther5(ftf.transRNToBR(ftf.transHtml(task_conflict.getOther5())));
	task_conflict.setOther6(ftf.transRNToBR(ftf.transHtml(task_conflict.getOther6())));
	pageContext.setAttribute("task_conflict", task_conflict);
	pageContext.setAttribute("mUser", mUser);
	pageContext.setAttribute("pCase", DataUtil.getPCaseArray()[task_conflict.getProject_case()]);
	pageContext.setAttribute("stage", DataUtil.getStageArray2()[task_conflict.getStage()]);
	pageContext.setAttribute("pType", DataUtil.getPTypeArray()[task_conflict.getProject_type()]);
	pageContext.setAttribute("pCategory", DataUtil.getPCategoryArray2()[task_conflict.getProject_category()]);
	pageContext.setAttribute("productType", DataUtil.getProductTypeArray2()[task_conflict.getProduct_type()]);
	pageContext.setAttribute("linkmanList1", linkmanManager.getLinkmanListLimit(17,task_id, 1, 1));
	pageContext.setAttribute("linkmanList2", linkmanManager.getLinkmanListLimit(17,task_id, 2, 1));
	pageContext.setAttribute("linkmanList3", linkmanManager.getLinkmanListLimit(17,task_id, 3, 1));
	pageContext.setAttribute("fpathList1", fpathList1);
	pageContext.setAttribute("fpathList2", fpathList2);
	pageContext.setAttribute("fpathList3", fpathList3);
	pageContext.setAttribute("fpathList4", fpathList4);
	pageContext.setAttribute("fpathList5", fpathList5);
	pageContext.setAttribute("fpathList6", fpathList6);
	pageContext.setAttribute("fpathList7", fpathList7);
	pageContext.setAttribute("ifchanged", ifchanged);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>修改前项目启动任务单</title>
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
</head>

<body>
	<jsp:include page="/top.jsp">
		<jsp:param name="name" value="${mUser.name}" />
		<jsp:param name="level" value="${mUser.level}" />
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
						<div class="td2_div3">项目启动任务单 对比</div>
						<table class="td2_table1">
							<tr class="table1_tr1">
								<td class='${ifchanged[15]?"table1_tr1_td1":"table1_tr1_td1_red"}'>
									项目类型：</td>
								<td class="table1_tr1_td2">
									<div><%=DataUtil.getPCategoryArray2()[task_conflict.getProject_category()]%></div>
								</td>
							</tr>
							<tr class="table1_tr1">
								<td
									class='${ifchanged[15]?"table1_tr1_td1":"table1_tr1_td1_red" }'>
									产品类型：</td>
								<td class="table1_tr1_td2">
									<div>${productType}</div>
								</td>
							</tr>
							<tr class="table1_tr1">
								<td
									class='${ifchanged[0]?"table1_tr1_td1":"table1_tr1_td1_red"}'>
									项目名称：</td>
								<td class="table1_tr1_td2">
									<div>${task_conflict.project_name}</div>
								</td>
							</tr>
							<tr class="table1_tr2">
								<td
									class='${ifchanged[1]?"table1_tr2_td1":"table1_tr2_td1_red"}'>
									项目编号：</td>
								<td class="table1_tr2_td2"><span>${task_conflict.project_id}</span>
								</td>
							</tr>
							<tr class="table1_tr3">
								<td
									class='${ifchanged[2]?"table1_tr3_td1":"table1_tr3_td1_red"}'>
									项目情况：</td>
								<td class="table1_tr3_td2"><span>${pCase}</span>
								</td>
							</tr>
							<tr class="table1_tr4">
								<td
									class='${ifchanged[3]?"table1_tr4_td1":"table1_tr4_td1_red"}'>
									销售阶段：</td>
								<td class="table1_tr4_td2"><span>${stage}</span>
								</td>
							</tr>
							<tr class="table1_tr5">
								<td
									class='${ifchanged[4]?"table1_tr5_td1":"table1_tr5_td1_red"}'>
									工程类型：</td>
								<td class="table1_tr5_td2"><span>${pType}</span>
								</td>
							</tr>
						</table>
						<table class="td2_table2">
							<tr class="table2_tr1">
								<td
									class='${ifchanged[5]?"table2_tr1_td1":"table2_tr1_td1_red"}'>
									用户名称</td>
								<td class="table2_tr1_td2"><span>${task_conflict.customer}</span>
								</td>
							</tr>
							<tr class="table2_tr2">
								<td
									class='${ifchanged[6]?"table2_tr2_td1":"table2_tr2_td1_red"}'>
									用户联系人</td>
								<td class="table2_tr2_td2">
								<c:forEach items="${linkmanList1}" var="linkman">
									<div>
									<span>姓名：${linkman.linkman}</span>&nbsp&nbsp <span>电话：${linkman.phone}</span>
									</div>
								</c:forEach>
								</td>
							</tr>
							<tr class="table2_tr3">
								<td
									class='${ifchanged[7]?"table2_tr3_td1":"table2_tr3_td1_red"}'>
									发票接收人</td>
								<td class="table2_tr3_td2">
								<c:forEach items="${linkmanList2}" var="linkman">
								<div>
								<span>姓名：${linkman.linkman}</span>&nbsp&nbsp <span>电话：${linkman.phone}</span>
								</div>
								</c:forEach>
								</td>
							</tr>
							<tr class="table2_tr4">
								<td
									class='${ifchanged[8]?"table2_tr4_td1":"table2_tr4_td1_red"}'>
									设备联系人</td>
								<td class="table2_tr4_td2">
								<c:forEach items="${linkmanList3}" var="linkman">
								<div>
								<span>姓名：${linkman.linkman}</span>&nbsp&nbsp <span>电话：${linkman.phone}</span>
								</div>
								</c:forEach>
								</td>
							</tr>
							<tr class="table2_tr5">
								<td
									class='${ifchanged[9]?"table2_tr5_td1":"table2_tr5_td1_red"}'>
									要求发货时间</td>
								<td class="table2_tr5_td2"><span>${task_conflict.delivery_timestr}</span>
								</td>
							</tr>
							<tr class="table2_tr5">
								<td
									class='${ifchanged[16]?"table2_tr5_td1":"table2_tr5_td1_red"}'>
									合同生效时间</td>
								<td class="table2_tr5_td2"><span>${task_conflict.contract_timestr}</span>
								</td>
							</tr>
							<tr class="table2_tr6">
								<td
									class='${ifchanged[10]?"table2_tr6_td1":"table2_tr6_td1_red"}'>
									项目说明及特殊要求（含合同执行风险）
								</td>
								<td class="table2_tr6_td2">
								<c:if test="${task_conflict.inspection==0}">
								<div>1.要求施工前现场开箱验货</div>
								</c:if>
								<c:if test="${task_conflict.verify==0}">
								<div>${2 - task_conflict.inspection}.发货前需和销售经理确认</div>
								</c:if>
								<div>${task_conflict.description}</div>
								</td>
							</tr>
							<tr class="table2_tr7">
								<td
									class="${ifchanged[11]?"table2_tr7_td1":"table2_tr7_td1_red"}">
									项目成本核算表
								</td>
								<td class="table2_tr7_td2">
									<c:forEach items="${fpathList1}" var="file_path">
									<div>
									<a class="img_a" href="javascript:void"	
									onclick="fileDown(${file_path.id})">${file_path.file_name}</a>
									</div>
									</c:forEach>
								</td>
							</tr>
							<tr class="table2_tr8">
								<td
									class='${ifchanged[12]?"table2_tr8_td1":"table2_tr8_td1_red"}'>
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
										<c:if test="${not empty task_conflict.other}">
											<div>备注：${task_conflict.other}</div>
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
										<c:if test="${not empty task_conflict.other}">
											<div>备注：${task_conflict.other2}</div>
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
										<c:if test="${not empty task_conflict.other}">
											<div>备注：${task_conflict.other3}</div>
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
										<c:if test="${not empty task_conflict.other}">
											<div>备注：${task_conflict.other4}</div>
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
										<c:if test="${not empty task_conflict.other}">
											<div>备注：${task_conflict.other5}</div>
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
										<c:if test="${not empty task_conflict.other6}">
											<div>备注：${task_conflict.other6}</div>
										</c:if>
									</div>

								</td>
							</tr>
							<tr class="table2_tr9">
								<td
									class='${ifchanged[13]?"table2_tr9_td1":"table2_tr9_td1_red"}'>
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
