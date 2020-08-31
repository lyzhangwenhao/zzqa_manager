<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.file_path.File_pathManager"%>
<%@page import="com.zzqa.pojo.file_path.File_path"%>
<%@page import="com.zzqa.pojo.advise.Advise"%>
<%@page import="com.zzqa.pojo.feedback.Feedback"%>
<%@page import="com.zzqa.pojo.notify.Notify"%>
<%@page
	import="com.zzqa.service.interfaces.communicate.CommunicateManager"%>
<%@page
	import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.service.interfaces.task.TaskManager"%>
<%@page import="com.zzqa.pojo.task.Task"%>
<%@page
	import="com.zzqa.service.interfaces.product_procurement.Product_procurementManager"%>
<%@page import="com.zzqa.pojo.product_procurement.Product_procurement"%>
<%@page
	import="com.zzqa.service.interfaces.project_procurement.Project_procurementManager"%>
<%@page import="com.zzqa.pojo.project_procurement.Project_procurement"%>
<%@page
	import="com.zzqa.service.interfaces.outsource_product.Outsource_productManager"%>
<%@page import="com.zzqa.pojo.outsource_product.Outsource_product"%>
<%@page
	import="com.zzqa.service.interfaces.manufacture.ManufactureManager"%>
<%@page import="com.zzqa.pojo.manufacture.Manufacture"%>
<%@page import="com.zzqa.service.interfaces.task_updateflow.Task_updateflowManager"%>
<%@page import="com.zzqa.pojo.task_updateflow.Task_updateflow"%>
<%@page import="com.zzqa.service.interfaces.shipments.ShipmentsManager"%>
<%@page import="com.zzqa.pojo.shipments.Shipments"%>
<%@page import="com.zzqa.service.interfaces.travel.TravelManager"%>
<%@page import="com.zzqa.pojo.travel.Travel"%>
<%@page import="com.zzqa.service.interfaces.leave.LeaveManager"%>
<%@page import="com.zzqa.pojo.leave.Leave"%>
<%@page
	import="com.zzqa.service.interfaces.resumption.ResumptionManager"%>
<%@page import="com.zzqa.pojo.resumption.Resumption"%>
<%@page import="com.zzqa.service.interfaces.track.TrackManager"%>
<%@page import="com.zzqa.pojo.track.Track"%>
<%@page import="com.zzqa.service.interfaces.sales_contract.Sales_contractManager"%>
<%@page import="com.zzqa.pojo.sales_contract.Sales_contract"%>
<%@page import="com.zzqa.service.interfaces.purchase_contract.Purchase_contractManager"%>
<%@page import="com.zzqa.pojo.purchase_contract.Purchase_contract"%>
<%@page import="com.zzqa.service.interfaces.aftersales_task.Aftersales_taskManager"%>
<%@page import="com.zzqa.pojo.aftersales_task.Aftersales_task"%>
<%@page import="com.zzqa.service.interfaces.seal.SealManager"%>
<%@page import="com.zzqa.pojo.seal.Seal"%>
<%@page import="com.zzqa.service.interfaces.vehicle.VehicleManager"%>
<%@page import="com.zzqa.pojo.vehicle.Vehicle"%>
<%@page import="com.zzqa.service.interfaces.shipping.ShippingManager"%>
<%@page import="com.zzqa.pojo.shipping.Shipping"%>
<%@page import="com.zzqa.service.interfaces.performance.PerformanceManager"%>
<%@page import="com.zzqa.pojo.performance.Performance"%>
<%@page import="com.zzqa.service.interfaces.deliver.DeliverManager"%>
<%@page import="com.zzqa.pojo.deliver.Deliver"%>
<%@page import="com.zzqa.service.interfaces.departmentPuchase.DepartPuchaseManager"%>
<%@page import="com.zzqa.pojo.departmentPuchase.DepartmentPuchase"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%@page import="com.zzqa.util.FormTransform"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("userManager");
	CommunicateManager communicateManager=(CommunicateManager)WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("communicateManager");
	File_pathManager file_pathManager=(File_pathManager)WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("file_pathManager");
	PermissionsManager permissionsManager=(PermissionsManager)WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("permissionsManager");
	TaskManager taskManager = (TaskManager) WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("taskManager");
	Product_procurementManager product_procurementManager = (Product_procurementManager) WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("product_procurementManager");
	Project_procurementManager project_procurementManager=(Project_procurementManager) WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("project_procurementManager");
	Outsource_productManager outsource_productManager=(Outsource_productManager)WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("outsource_productManager");
	ManufactureManager manufactureManager=(ManufactureManager)WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("manufactureManager");
	ShipmentsManager shipmentsManager=(ShipmentsManager)WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("shipmentsManager");
	TravelManager travelManager=(TravelManager)WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("travelManager");
	LeaveManager leaveManager=(LeaveManager)WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("leaveManager");
	ResumptionManager resumptionManager=(ResumptionManager)WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("resumptionManager");
	TrackManager trackManager=(TrackManager)WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("trackManager");
	Sales_contractManager sales_contractManager=(Sales_contractManager)WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("sales_contractManager");
	Purchase_contractManager purchase_contractManager=(Purchase_contractManager)WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("purchase_contractManager");
	Aftersales_taskManager aftersales_taskManager=(Aftersales_taskManager)WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("aftersales_taskManager");
	SealManager sealManager=(SealManager)WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("sealManager");
	VehicleManager vehicleManager=(VehicleManager)WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("vehicleManager");
	ShippingManager shippingManager=(ShippingManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("shippingManager");
	PerformanceManager performanceManager=(PerformanceManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("performanceManager");
	DeliverManager deliverManager=(DeliverManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("deliverManager");
	Task_updateflowManager task_updateflowManager=(Task_updateflowManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("task_updateflowManager");
	DepartPuchaseManager departPuchaseManager = (DepartPuchaseManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("departPuchaseManager");
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
	session.setAttribute("notify_index", 13);//决定关闭通知详情时跳转的页面
	session.setAttribute("feedback_index", 13);
	session.setAttribute("advise_index", 13);
	List<Flow> flowList=new ArrayList<Flow>();//使用flow存储待办事项
	int max_back_log=3;//待办事项只显示3条
	int back_num=0;//待办事项数量
	List<Task> taskList=taskManager.getTaskListByUID(mUser);
	if(taskList != null && taskList.size()>0){
		for(Task task:taskList){
			if(max_back_log>back_num++){
				Flow flow=new Flow();
				flow.setUsername(task.getCreate_name());
				flow.setType(1);
				flow.setReason(task.getProcess());
				flow.setFlowcode(Integer.toString(task.getId()));
				flow.setCreate_date(task.getProject_name());
				flowList.add(flow);
			}
		}
	}
	List<Product_procurement> product_pList=product_procurementManager.getProduct_procurementListByUID(mUser);
	for(Product_procurement pp:product_pList){
		if(max_back_log>back_num++){
			Flow flow=new Flow();
			flow.setUsername(pp.getCreate_name());
			flow.setType(2);
			flow.setReason(pp.getProcess());
			flow.setFlowcode(Integer.toString(pp.getId()));
			flow.setCreate_date(pp.getName());
			flowList.add(flow);
		}
	}
	List<Project_procurement> project_pList=project_procurementManager.getProject_procurementListByUID(mUser);
	if(project_pList !=null && project_pList.size()>0){
		for(Project_procurement pp:project_pList){
			if(max_back_log>back_num++){
				Flow flow=new Flow();
				flow.setUsername(pp.getCreate_name());
				flow.setType(3);
				flow.setReason(pp.getProcess());
				flow.setFlowcode(Integer.toString(pp.getId()));
				flow.setCreate_date(pp.getName());
				flowList.add(flow);
			}
		}
	}
	List<Outsource_product> out_pList=outsource_productManager.getOutsourceByUID(mUser);
	for(Outsource_product op:out_pList){
		if(max_back_log>back_num++){
			Flow flow=new Flow();
			flow.setUsername(op.getCreate_name());
			flow.setType(4);
			flow.setReason(op.getProcess());
			flow.setFlowcode(Integer.toString(op.getId()));
			flow.setCreate_date(op.getName());
			flowList.add(flow);
		}
	}
	List<Manufacture> mList=manufactureManager.getManufactureListByUID(mUser);
	for(Manufacture mf:mList){
		if(max_back_log>back_num++){
			Flow flow=new Flow();
			flow.setUsername(mf.getCreate_name());
			flow.setType(5);
			flow.setReason(mf.getProcess());
			flow.setFlowcode(Integer.toString(mf.getId()));
			flow.setCreate_date(mf.getName());
			flowList.add(flow);
		}
	}
	List<Shipments> shipList=shipmentsManager.getShipmentsListByUID(mUser);
	for(Shipments sp:shipList){
		if(max_back_log>back_num++){
			Flow flow=new Flow();
			flow.setUsername(sp.getCreate_name());
			flow.setType(6);
			flow.setReason(sp.getProcess());
			flow.setFlowcode(Integer.toString(sp.getId()));
			flow.setCreate_date(sp.getName());
			flowList.add(flow);
		}
	}
	List<Travel> travelList=travelManager.getTravelListByUID(mUser);
	for(Travel travel:travelList){
		if(max_back_log>back_num++){
			Flow flow=new Flow();
			flow.setUsername(travel.getCreate_name());
			flow.setType(7);
			flow.setReason(travel.getProcess());
			flow.setFlowcode(Integer.toString(travel.getId()));
			flow.setCreate_date(travel.getName());
			flowList.add(flow);
		}
	}
	List<Leave> leaveList=leaveManager.getLeaveListByUID(mUser);
	for(Leave leave:leaveList){
		if(max_back_log>back_num++){
			Flow flow=new Flow();
			flow.setUsername(leave.getCreate_name());
			flow.setType(8);
			flow.setReason(leave.getProcess());
			flow.setFlowcode(Integer.toString(leave.getId()));
			flow.setCreate_date(leave.getName());
			flowList.add(flow);
		}
	}
	List<Resumption> resumptionList=resumptionManager.getResumptionListByUID(mUser);
	for(Resumption resumption:resumptionList){
		if(max_back_log>back_num++){
			Flow flow=new Flow();
			flow.setUsername(resumption.getCreate_name());
			flow.setType(9);
			flow.setReason(resumption.getProcess());
			flow.setFlowcode(Integer.toString(resumption.getId()));
			flow.setCreate_date(resumption.getName());
			flowList.add(flow);
		}
	}
	List<Track> trackList=trackManager.getTrackListByUID(mUser);
	for(Track track:trackList){
		if(max_back_log>back_num++){
			Flow flow=new Flow();
			flow.setUsername(track.getCreate_name());
			flow.setType(17);//跳转页面对应的type
			flow.setReason(track.getProcess());
			flow.setFlowcode(Integer.toString(track.getId()));
			flow.setCreate_date(track.getName());
			flowList.add(flow);
		}
	}
	List<Sales_contract> salesList=sales_contractManager.getSalesListByUID(mUser);
	for(Sales_contract sales_contract:salesList){
		if(max_back_log>back_num++){
			Flow flow=new Flow();
			flow.setUsername(sales_contract.getCreate_name());
			flow.setType(19);//跳转页面对应的type
			flow.setReason(sales_contract.getProcess());
			flow.setFlowcode(Integer.toString(sales_contract.getId()));
			flow.setCreate_date(sales_contract.getName());
			flowList.add(flow);
		}
	}
	List<Purchase_contract> purchaseList=purchase_contractManager.getPurchaseListByUID(mUser);
	for(Purchase_contract purchase_contract:purchaseList){
		if(max_back_log>back_num++){
			Flow flow=new Flow();
			flow.setUsername(purchase_contract.getCreate_name());
			flow.setType(20);//跳转页面对应的type
			flow.setReason(purchase_contract.getProcess());
			flow.setFlowcode(Integer.toString(purchase_contract.getId()));
			flow.setCreate_date(purchase_contract.getName());
			flowList.add(flow);
		}
	}
	List<Aftersales_task> aftersales_tasks=aftersales_taskManager.getAftersales_taskByUID(mUser);
	for(Aftersales_task aftersales_task:aftersales_tasks){
		if(max_back_log>back_num++){
			Flow flow=new Flow();
			flow.setUsername(aftersales_task.getCreate_name());
			flow.setType(21);//跳转页面对应的type
			flow.setReason(aftersales_task.getProcess());
			flow.setFlowcode(Integer.toString(aftersales_task.getId()));
			flow.setCreate_date(aftersales_task.getName());
			flowList.add(flow);
		}
	}
	List<Seal> sealList=sealManager.getSealByUID(mUser);
	for(Seal seal:sealList){
		if(max_back_log>back_num++){
			Flow flow=new Flow();
			flow.setUsername(seal.getCreate_name());
			flow.setType(22);//跳转页面对应的type
			flow.setReason(seal.getProcess());
			flow.setFlowcode(Integer.toString(seal.getId()));
			flow.setCreate_date(seal.getName());
			flowList.add(flow);
		}
	}
	List<Vehicle> vehicleList=vehicleManager.getVehicleByUID(mUser);
	if(vehicleList!=null){
		for(Vehicle vehicle:vehicleList){
			if(max_back_log>back_num++){
				Flow flow=new Flow();
				flow.setUsername(vehicle.getCreate_name());
				flow.setType(23);//跳转页面对应的type
				flow.setReason(vehicle.getProcess());
				flow.setFlowcode(Integer.toString(vehicle.getId()));
				flow.setCreate_date(vehicle.getName());
				flowList.add(flow);
			}
		}
	}
	List<Task> taskList2=taskManager.getStartupTaskListByUID(mUser);
	for(Task task:taskList2){
		if(max_back_log>back_num++){
			Flow flow=new Flow();
			flow.setUsername(task.getCreate_name());
			flow.setType(25);
			flow.setReason(task.getProcess());
			flow.setFlowcode(Integer.toString(task.getId()));
			flow.setCreate_date(task.getProject_name());
			flowList.add(flow);
		}
	}
	
	List<Shipping> shippingList=shippingManager.getShippingListByUID(mUser);
	for(Shipping shipping:shippingList){
		if(max_back_log>back_num++){
			Flow flow=new Flow();
			flow.setUsername(shipping.getCreate_name());
			flow.setType(28);//跳转页面对应的type
			flow.setReason(shipping.getProcess());
			flow.setFlowcode(Integer.toString(shipping.getId()));
			flow.setCreate_date(shipping.getName());
			flowList.add(flow);
		}
	}
	List<Performance> performances=performanceManager.getPerformanceListByUID(mUser);
	for(Performance performance:performances){
		if(max_back_log>back_num++){
			Flow flow=new Flow();
			flow.setUsername(performance.getCreate_name());
			flow.setType(32);//跳转页面对应的type
			flow.setReason(performance.getProcess());
			flow.setFlowcode(Integer.toString(performance.getId()));
			flow.setCreate_date(performance.getName());
			flowList.add(flow);
		}
	}
	List<Deliver> delivers=deliverManager.getDeliverListByUID(mUser);
	for(Deliver deliver:delivers){
		if(max_back_log>back_num++){
			Flow flow=new Flow();
			flow.setUsername(deliver.getCreate_name());
			flow.setType(33);//跳转页面对应的type
			flow.setReason(deliver.getProcess());
			flow.setFlowcode(Integer.toString(deliver.getId()));
			flow.setCreate_date(deliver.getProject_name());
			flowList.add(flow);
		}
	}
	List<Task_updateflow> task_updateflows=task_updateflowManager.getTask_updateflowListByUID(mUser);
	for(Task_updateflow task_updateflow:task_updateflows){
		if(max_back_log>back_num++){
			Flow flow=new Flow();
			flow.setUsername(task_updateflow.getCreate_name());
			flow.setType(41);//跳转页面对应的type
			flow.setReason(task_updateflow.getProcess());
			flow.setFlowcode(Integer.toString(task_updateflow.getId()));
			flow.setCreate_date(task_updateflow.getName());
			flowList.add(flow);
		}
	}
	List<DepartmentPuchase> departPuchaseflows=departPuchaseManager.getDepartPuchaseListByUID(mUser);
	for(DepartmentPuchase departmentPuchase :departPuchaseflows){
		if(max_back_log>back_num++){
			Flow flow=new Flow();
			flow.setUsername(departmentPuchase.getPurchaseName());
			flow.setType(36);
			flow.setReason(departmentPuchase.getProcess());
			flow.setFlowcode(Integer.toString(departmentPuchase.getId()));
			flow.setCreate_date(departmentPuchase.getPurchaseNum());
			flowList.add(flow);
		}
	}
	List<Notify> notifyList=communicateManager.getNotifyListByYear(0, 6,uid);
	Notify notify=null;
	List<File_path> filList=null;
	if(notifyList!=null && notifyList.size()>0){
		notify=notifyList.get(0);
		FormTransform ft=new FormTransform();
		notify.setContent(ft.transRNToBR(ft.transHtml(notify.getContent())));
		filList=file_pathManager.getAllFileByCondition(23, notify.getId(), 1, 0);
	}
	List<Feedback> feedBackList=communicateManager.getNotReadFeedBackList(uid);
	List<Advise> adviseList=communicateManager.getNotReadAdviseList(uid);
	List<Flow> replylist=communicateManager.getNotReadReplyList(uid);//使用flow存储未读回复
	int position_id=mUser.getPosition_id();
	boolean canNewFlow=(Boolean)(session.getAttribute("canNewFlow")==null?false:session.getAttribute("canNewFlow"));
	boolean permission44=permissionsManager.checkPermission(position_id, 44);
	boolean permission46=permissionsManager.checkPermission(position_id, 46);
	boolean permission41="admin".equals(mUser.getName())||permissionsManager.checkPermission(mUser.getPosition_id(), 41)
			||permissionsManager.checkPermission(mUser.getPosition_id(), 42)||permissionsManager.checkPermission(mUser.getPosition_id(), 43)
			||permission44||permissionsManager.checkPermission(mUser.getPosition_id(), 45)||permission46
			||permissionsManager.checkPermission(mUser.getPosition_id(), 47);
	pageContext.setAttribute("back_num",back_num);
	pageContext.setAttribute("flowList", flowList);
	pageContext.setAttribute("feedBackList", feedBackList);
	pageContext.setAttribute("adviseList", adviseList);
	pageContext.setAttribute("replylist", replylist);
	pageContext.setAttribute("notify", notify);
	pageContext.setAttribute("notifyList", notifyList);
	pageContext.setAttribute("filList", filList);
	pageContext.setAttribute("canNewFlow", canNewFlow);
	pageContext.setAttribute("permission41", permission41);
	pageContext.setAttribute("permission44", permission44);
	pageContext.setAttribute("permission46", permission46);
	pageContext.setAttribute("vEnter1", "\r\n");
	pageContext.setAttribute("vEnter2", "\n\r");
	pageContext.setAttribute("vEnter3", "\r");
	pageContext.setAttribute("vEnter4", "\n");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>首页</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/top.css">
<link rel="stylesheet" type="text/css" href="css/home.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/dialog.js"></script>
<script type="text/javascript" src="js/public.js"></script>

<!-- <link rel="stylesheet" type="text/css" href="styles.css"> -->


</head>
<script type="text/javascript">
function jumpTo(type,id){
	document.jumpform.jumpID.value=id;
	document.jumpform.jumpType.value=type;
	document.jumpform.submit();
}
function jumpToFlow(type,id){
	window.location.href='<%=basePath%>FlowManagerServlet?type=flowdetail&flowtype='+type+'&id='+id;
}
document.onkeydown = function(e){
    if(!e) e = window.event;
    if((e.keyCode || e.which) == 13){
    	if($( "#onebtndialog" ).length>0){
    		$( "#confirm1" ).click();
    	}else if($( "#twobtndialog" ).length>0){
    		$( "#confirm2" ).click();
    	}
    }
};
var max_width=0;
$(function(){
	$(".window-top").find("div:first-child").each(function(){
		max_width=Math.max(max_width,parseInt($(this).css("width").replace("px","")));
	});
	$(".window-top").find("div:first-child").each(function(){
		$(this).css("width",max_width+"px");
	});
});
</script>
<body>
	<jsp:include page="/top.jsp">
		<jsp:param name="index" value="0" />
	</jsp:include>
	<div class="home-content">
		<div class="content-left">
			<c:if test="${back_num>0}">
			<div class="window">
				<div class="window-top click-top">
					<div onclick="window.location='<%=basePath%>flowmanager/backlog.jsp'">待办事项（${back_num}）</div>
					<div></div>
					<div></div>
				</div>
				<div class="window-list">
					<c:forEach items="${flowList}" end="2" var="flow"
							varStatus="flow_status">
							<c:if test="${flow_status.index!=0}">
								<div class="border-div"></div>
							</c:if>
							<div class="window-item1"
								onclick="jumpToFlow(${flow.type},${flow.flowcode})">
								<div class="tooltip_div">
									${flow.create_date}
								</div>
								<div class="tooltip_div">
									${flow.username}
								</div>
								<div class="tooltip_div">
									${flow.reason}
								</div>
							</div>
						</c:forEach>
				</div>
			</div>
			</c:if>
			<c:if test="${permission41}">
			<c:if test="${adviseList!= null && fn:length(adviseList) >0}">
				<div class="window">
					<div class="window-top click-top">
						<div class="tooltip_div"
							onclick="window.location='<%=basePath%>CommunicateServlet?type=jumpToAdvise'">
							未读建议（<c:out value="${fn:length(adviseList)}"></c:out>）
						</div>
						<div></div>
						<div></div>
					</div>
					<div class="window-list">
						<c:forEach items="${adviseList}" end="2" var="advise"
							varStatus="advise_status">
							<c:if test="${advise_status.index!=0}">
								<div class="border-div"></div>
							</c:if>
							<div class="window-item2"
								onclick="jumpTo(10,<c:out value="${advise.id}"></c:out>)">
								<div class="tooltip_div">
									<c:out value="${advise.title}"></c:out>
								</div>
								<div class="tooltip_div">
									<c:out value="${advise.create_name}"></c:out>
								</div>
								<div>
									<c:out value="${advise.update_date}"></c:out>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</c:if>
			<c:if test="${feedBackList!= null && fn:length(feedBackList) >0}">
				<div class="window">
					<div class="window-top click-top">
						<div class="tooltip_div"
							onclick="window.location='<%=basePath%>communicate/approve_feedback.jsp'">
							未读反馈（<c:out value="${fn:length(feedBackList)}"></c:out>）
						</div>
						<div></div>
						<div></div>
					</div>
					<div class="window-list">
						<c:forEach items="${feedBackList}" end="2" var="feedback"
							varStatus="feed_status">
							<c:if test="${feed_status.index!=0}">
								<div class="border-div"></div>
							</c:if>
							<div class="window-item2"
								onclick="jumpTo(9,<c:out value="${feedback.id}"></c:out>)">
								<div class="tooltip_div">
									<c:out value="${feedback.title}"></c:out>
								</div>
								<div class="tooltip_div">
									<c:out value="${feedback.create_name}"></c:out>
								</div>
								<div>
									<c:out value="${feedback.update_date}"></c:out>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</c:if>
			<c:if test="${replylist!= null && fn:length(replylist) >0}">
				<div class="window">
					<div class="window-top">
						<div class="tooltip_div">
							未读回复（<c:out value="${fn:length(replylist)}"></c:out>）
						</div>
						<div></div>
						<div></div>
					</div>
					<div class="window-list">
						<c:forEach items="${replylist}" end="2" var="flow"
							varStatus="feed_status">
							<c:if test="${feed_status.index!=0}">
								<div class="border-div"></div>
							</c:if>
							<div class="window-item2"
								onclick="jumpTo(<c:out value="${flow.type}"></c:out>,<c:out value="${flow.id}"></c:out>)">
								<div class="tooltip_div">
									<c:out value="${flow.reason}"></c:out>
								</div>
								<div class="tooltip_div">
									<c:out value="${flow.username}"></c:out>
								</div>
								<div>
									<c:out value="${flow.create_date}"></c:out>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</c:if>
			</c:if>
			<div class="window">
				<div class="window-top">
					<div>快捷窗口</div>
					<div></div>
					<div></div>
				</div>
				<div class="window-list">
					<div class="window-btn-group">
						<c:if test="${canNewFlow}">
							<div class="window-btn"
								onclick="window.location='<%=basePath%>flowmanager/newflow.jsp'">
								<img src="images/home-addflow.png">
								<div>新建流程</div>
							</div>
						</c:if>
						<c:if test="${permission44}">
							<div class="window-btn"
								onclick="window.location='<%=basePath%>communicate/publish_advise.jsp'">
								<img src="images/home-addfeedback.png">
								<div>提交建议</div>
							</div>
						</c:if>
						<c:if test="${permission46}">
							<div class="window-btn"
								onclick="window.location='<%=basePath%>communicate/publish_feedback.jsp'">
								<img src="images/home-addadvise.png">
								<div>提交反馈</div>
							</div>
						</c:if>
						<div class="window-btn" onclick="updatePassword();">
							<img src="images/home-alterpsw.png">
							<div>修改密码</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="content-right">
			<div class="content-right1">
				<div class="home-notify-top">
					<div>最新通知 &gt;&gt;&gt;</div>
					<div></div>
					<div></div>
				</div>
				<c:if test="${notify==null||!permission41}">
					<div class="no-notify">暂无通知</div>
				</c:if>
				<c:if test="${notify!=null&&permission41}">
					<div class="home-notify-title">
						${notify.title}
					</div>
					<div class="home-notify-dashed"></div>
					<div class="home-notify-content">
						${notify.content}
					</div>
					<div class="home-notify-bottom">
						<div>
							${notify.publisher}
						</div>
						<div>
							${notify.update_date}
						</div>
					</div>
					<div class="home-notify-filenum">
						附件
						<c:if test="${fn:length(filList)>0}">:（<c:out
								value="${fn:length(filList)}"></c:out>个）</c:if>
					</div>
					<div class="home-notify-filelist">
						<c:forEach items="${filList}" var="file">
							<div>
								<a
									href="javascript:fileDown(<c:out value="${file.id}"></c:out>);this.blur();"><c:out
										value="${file.file_name}"></c:out></a>
							</div>
						</c:forEach>
					</div>
				</c:if>
			</div>
			<div class="content-right2">
				<div class="home-notify-top">
					<div>近期通知 &gt;&gt;&gt;</div>
					<div></div>
					<div></div>
				</div>
				<c:if test="${notifyList!= null && fn:length(notifyList) >1&&permission41}">
					<div class="home-notifylist">
						<c:forEach items="${notifyList}" begin="1" var="recentnotify"
							varStatus="status">
							<div
								class="home-notifyitem <c:if test="${status.last}">lastnotify</c:if>"
								onclick="jumpTo(1,<c:out value="${recentnotify.id}"></c:out>)">
								<div class="tooltip_div">
									<c:out value="${recentnotify.title}"></c:out>
								</div>
								<div>
									<c:out value="${recentnotify.update_date}"></c:out>
								</div>
								<div class="tooltip_div">
									<c:out value="${recentnotify.publisher}"></c:out>
								</div>
							</div>
						</c:forEach>
					</div>
					<div class="home-notify-solid"></div>
					<div class="home-morenotify">
						<a href="<%=basePath%>communicate/more_notify.jsp">查询更多通知</a>
					</div>
				</c:if>
				<c:if test="${notifyList== null || fn:length(notifyList) <2||!permission41}">
					<div class="no-notify">暂无近期通知</div>
				</c:if>
			</div>
		</div>
		<form action="CommunicateServlet" name="jumpform" method="post">
			<input type="hidden" name="type" value="jumpUrl"> <input
				type="hidden" name="jumpType"> <input type="hidden"
				name="jumpID">
		</form>
	</div>
</body>
</html>
