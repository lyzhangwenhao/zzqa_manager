<%@page import="com.zzqa.pojo.shipping.Shipping"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.task.TaskManager"%>
<%@page import="com.zzqa.pojo.task.Task"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page
	import="com.zzqa.service.interfaces.product_procurement.Product_procurementManager"%>
<%@page import="com.zzqa.pojo.product_procurement.Product_procurement"%>
<%@page
	import="com.zzqa.service.interfaces.project_procurement.Project_procurementManager"%>
<%@page import="com.zzqa.pojo.project_procurement.Project_procurement"%>
<%@page import="com.zzqa.service.interfaces.outsource_product.Outsource_productManager"%>
<%@page import="com.zzqa.pojo.outsource_product.Outsource_product"%>
<%@page import="com.zzqa.service.interfaces.manufacture.ManufactureManager"%>
<%@page import="com.zzqa.pojo.manufacture.Manufacture"%>
<%@page import="com.zzqa.service.interfaces.shipments.ShipmentsManager"%>
<%@page import="com.zzqa.pojo.shipments.Shipments"%>
<%@page import="com.zzqa.service.interfaces.travel.TravelManager"%>
<%@page import="com.zzqa.pojo.travel.Travel"%>
<%@page import="com.zzqa.service.interfaces.leave.LeaveManager"%>
<%@page import="com.zzqa.pojo.leave.Leave"%>
<%@page import="com.zzqa.service.interfaces.resumption.ResumptionManager"%>
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
<%@page import="com.zzqa.service.interfaces.task_updateflow.Task_updateflowManager"%>
<%@page import="com.zzqa.pojo.task_updateflow.Task_updateflow"%>
<%@page import="com.zzqa.service.interfaces.departmentPuchase.DepartPuchaseManager"%>
<%@page import="com.zzqa.pojo.departmentPuchase.DepartmentPuchase"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
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
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int backlog_type=0;
	if (session.getAttribute("backlog_type") != null) {
		backlog_type = (Integer) session
				.getAttribute("backlog_type");
	}
	int uid = (Integer) session.getAttribute("uid");
	User mUser = userManager.getUserByID(uid);
	if (mUser == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	String[] flowTypeArray=DataUtil.getFlowTypeArray();
	List<Task> taskList=taskManager.getTaskListByUID(mUser);
	List<Task> taskList2=taskManager.getStartupTaskListByUID(mUser);
	List<Product_procurement> product_pList=product_procurementManager.getProduct_procurementListByUID(mUser);
	List<Project_procurement> project_pList=project_procurementManager.getProject_procurementListByUID(mUser);
	List<Outsource_product> out_pList=outsource_productManager.getOutsourceByUID(mUser);
	//List<Manufacture> mList=manufactureManager.getManufactureListByUID(mUser);
	List<Shipments> shipList=shipmentsManager.getShipmentsListByUID(mUser);
	List<Travel> travelList=travelManager.getTravelListByUID(mUser);
	List<Leave> leaveList=leaveManager.getLeaveListByUID(mUser);
	List<Resumption> resumptionList=resumptionManager.getResumptionListByUID(mUser);
	List<Track> trackList=trackManager.getTrackListByUID(mUser);
	List<Sales_contract> salesList=sales_contractManager.getSalesListByUID(mUser);
	List<Purchase_contract> purchaseList=purchase_contractManager.getPurchaseListByUID(mUser);
	List<Aftersales_task> aftersales_tasks=aftersales_taskManager.getAftersales_taskByUID(mUser);
	List<Seal> seals=sealManager.getSealByUID(mUser);
	List<Vehicle> vehicles=vehicleManager.getVehicleByUID(mUser);
	List<Shipping> shippingList=shippingManager.getShippingListByUID(mUser);
	List<Performance> performances=performanceManager.getPerformanceListByUID(mUser);
	List<Deliver> delivers=deliverManager.getDeliverListByUID(mUser);
	List<Task_updateflow> task_updateflows=task_updateflowManager.getTask_updateflowListByUID(mUser);
	List<DepartmentPuchase> departPuchaseflows=departPuchaseManager.getDepartPuchaseListByUID(mUser);
	pageContext.setAttribute("flowTypeArray",flowTypeArray);
	int index=0;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>待办事项</title>
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
		var type=<%=backlog_type%>;//全部 
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
		function searchflows(t){
			if(arguments.length>0){
				type=t;
				window.location.href="FlowManagerServlet?type=saveBacklogType&index="+t;
				$('.div').trigger('mouseleave');
			}
			$(".selected_a").attr("class","unselected_a");
			var type_now=type;
			if(type>5){
				if(type>16){
					type_now=type-2;
				}else{
					type_now=type-1;
				}
			}
			$(".flowcontainer_div a:eq("+type_now+")").attr("class","selected_a");
			var keywords=$("#keywords_flows").val();
			var index=0;
			showTb0=false;
			$(".device_tab1 tr:gt(0)").each(function(){
				if(($(this).find("td:eq(0)").text().indexOf(keywords)!=-1||$(this).find("td:eq(1)").text().indexOf(keywords)!=-1
						||$(this).find("td:eq(2)").text().indexOf(keywords)!=-1||$(this).find("td:eq(3)").text().indexOf(keywords)!=-1||$(this).find("td:eq(4)").text().indexOf(keywords)!=-1)
						&&(type==0||$(this).attr("flow_type")==type)){
					var backid=$(this).attr("backid");
					if(backid&&backid>0){
						showTb0=true;
						$(this).find(".tab_tr1_td0 label").attr("style","display:block;");
					}
					$(this).attr("class","tab_tr2 tr_pointer");
					$(this).css({"display":"table-row","background":(index++%2==0?"#F5F9FD":"#EAEFF7")});
				}else{
					$(this).css("display","none");
				}
			});
			if(showTb0){
				$(".tab_tr1_td0").css({"display":"table-cell","padding":"0"});
				$(".selectAll_btn").css("display","block");
				$(".attendance_record").css("display","block");
			}else{
				$(".tab_tr1_td0").css("display","none");
				$(".selectAll_btn").css("display","none");
				$(".attendance_record").css("display","none");
			}
		}
		/****同一考勤备案****/
		function doRrecord(){
			var travel_ids="";
			var leave_ids="";
			var resumption_ids="";
			$("tr[backid] input:checked").each(function(){
				var $tr=$(this).parent().parent();
				var id=$tr.attr("backid");
				var type=$tr.attr("flow_type");
				if(type==7){
					travel_ids+="の"+id;
				}else if(type==8){
					leave_ids+="の"+id;
				}else if(type==9){
					resumption_ids+="の"+id;
				}
			});
			if(travel_ids.length==0&&leave_ids.length==0&&resumption_ids.length==0){
				initdiglog2("提示信息","请选择备案的流程");
				return;
			}
			travel_ids=travel_ids.replace("の","");
			leave_ids=leave_ids.replace("の","");
			resumption_ids=resumption_ids.replace("の","");
			$.ajax({
				type:"post",//post方法
				url:"FlowManagerServlet",
				data:{"type":"record","travel_ids":travel_ids,
					"leave_ids":leave_ids,"resumption_ids":resumption_ids},
				dataType:'json',
				success:function(returnData){
					location.reload();
				},
				error:function(returnData){
					initdiglog2("提示信息","请求异常，请刷新重试");
				}
			});
		}
		/**全选**/
		function selectAllFlows(){
			$("tr[backid]").each(function(){
				var $td=$(this).find(".tab_tr1_td0");
				if($(this).css("display")!="none"&&$td.css("display")!="none"&&
						$td.find("label").css("display")!="none"){
					$td.find("input").prop("checked",true);
				}
			});
		}
		/**反选**/
		function selectInvertFlows(){
			$("tr[backid]").each(function(){
				var $td=$(this).find(".tab_tr1_td0");
				if($(this).css("display")!="none"&&$td.css("display")!="none"&&
						$td.find("label").css("display")!="none"){
					$td.find("input").prop("checked",!$td.find("input").prop("checked"));
				}
			});
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
					<jsp:param name="index" value="1" />
				</jsp:include>
				<td class="table_center_td2">
						<div class="td2_div">
							<div class="td2_div1">
								<div class="selectAll_btn" onclick="selectAllFlows()">全选</div>
								<div class="selectAll_btn" onclick="selectInvertFlows()">反选</div>
								<img title="搜索" src="images/user_search.gif" id="img_search"
									onclick="searchflows();" class="serach_img1">
								<input type="text" name="keywords_flows" id="keywords_flows" oninput="searchflows();" maxlength="30" placeholder="关键词：编号、名称、姓名"
										onkeydown="if(event.keyCode==32) return false">
								<div class="attendance_record" onclick="doRrecord();"><img src="images/attendance_record.png">考勤备案</div>
							</div>
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
											<div class="div" style="width:120px;">
												<a href="javascript:void(0)">流程类别<img src="images/show_check.png"></a>
													<div class="flowcontainer_div">
													<div><a href="javascript:void(0)" onclick="searchflows(0)">全部流程</a></div>
													<c:forEach items="${flowTypeArray}" varStatus="flow_index" begin="1" var="flowName">
														<c:if test="${flow_index.index!=5&&flow_index.index!=16}"><%--生产单工时统计没有待办事项 --%>
														<div><a href="javascript:void(0)" onclick="searchflows(${flow_index.index})">${flowName}</a></div>
														</c:if>
													</c:forEach>
													</div>
											</div>
										</td>
										<td class="tab_tr1_td13" style="width:32%;">
											进度
										</td>
									</tr>
									<%int i=-1;for(Task task:taskList){ i++;%>
									<tr class="tab_tr<%=i % 2 + 2%> tr_pointer" flow_type="1" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=1&id=<%=task.getId() %>'">
										<td class="tab_tr1_td0"></td>
										<td class="tab_tr1_td1"><%=task.getProject_id() %></td>
										<td class="tab_tr1_td2 tooltip_div"><%=task.getProject_name()%></td>
										<td class="tab_tr1_td3"><%=task.getCreate_name()%></td>
										<td class="tab_tr1_td4"><%=flowTypeArray[1]%></td>
										<td class="tab_tr1_td13 tooltip_div"><%=task.getProcess() %></td>
									</tr>
									<%} %>
									<%for(Product_procurement pp:product_pList){  i++;%>
									<tr class="tab_tr<%=i % 2 + 2%> tr_pointer" flow_type="2" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=2&id=<%=pp.getId() %>'">
										<td class="tab_tr1_td0"></td>
										<td class="tab_tr1_td1"><%=pp.getId()%></td>
										<td class="tab_tr1_td2 tooltip_div"><%=pp.getName()%></td>
										<td class="tab_tr1_td3"><%=pp.getCreate_name()%></td>
										<td class="tab_tr1_td4"><%=flowTypeArray[2]%></td>
										<td class="tab_tr1_td13 tooltip_div"><%=pp.getProcess() %></td>
									</tr>
									<%} %>
									<%for(Project_procurement pp:project_pList){  i++;%>
									<tr class="tab_tr<%=i % 2 + 2%> tr_pointer" flow_type="3" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=3&id=<%=pp.getId() %>'">
										<td class="tab_tr1_td0"></td>
										<td class="tab_tr1_td1"><%=pp.getId()%></td>
										<td class="tab_tr1_td2 tooltip_div"><%=pp.getName()%></td>
										<td class="tab_tr1_td3"><%=pp.getCreate_name()%></td>
										<td class="tab_tr1_td4"><%=flowTypeArray[3]%></td>
										<td class="tab_tr1_td13 tooltip_div"><%=pp.getProcess() %></td>
									</tr>
									<%} %>
									<%for(Outsource_product op:out_pList){  i++;%>
									<tr class="tab_tr<%=i % 2 + 2%> tr_pointer" flow_type="4" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=4&id=<%=op.getId() %>'">
										<td class="tab_tr1_td0"></td>
										<td class="tab_tr1_td1"><%=op.getId()%></td>
										<td class="tab_tr1_td2 tooltip_div"><%=op.getName()%></td>
										<td class="tab_tr1_td3"><%=op.getCreate_name()%></td>
										<td class="tab_tr1_td4"><%=flowTypeArray[4]%></td>
										<td class="tab_tr1_td13 tooltip_div"><%=op.getProcess() %></td>
									</tr>
									<%} %>
									<%-- <%for(Manufacture mf:mList){  i++;%>
									<tr class="tab_tr<%=i % 2 + 2%> tr_pointer" flow_type="5" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=5&id=<%=mf.getId() %>'">
										<td class="tab_tr1_td1"><%=mf.getId()%></td>
										<td class="tab_tr1_td2 tooltip_div"><%=mf.getName()%></td>
										<td class="tab_tr1_td3"><%=mf.getCreate_name()%></td>
										<td class="tab_tr1_td4"><%=flowTypeArray[5]%></td>
										<td class="tab_tr1_td13 tooltip_div"><%=mf.getProcess() %></td>
									</tr>
									<%} %> --%>
									<%for(Shipments ship:shipList){  i++;%>
									<tr class="tab_tr<%=i % 2 + 2%> tr_pointer" flow_type="6" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=6&id=<%=ship.getId() %>'">
										<td class="tab_tr1_td0"></td>
										<td class="tab_tr1_td1"><%=ship.getId()%></td>
										<td class="tab_tr1_td2 tooltip_div"><%=ship.getName()%></td>
										<td class="tab_tr1_td3"><%=ship.getCreate_name()%></td>
										<td class="tab_tr1_td4"><%=flowTypeArray[6]%></td>
										<td class="tab_tr1_td13 tooltip_div"><%=ship.getProcess() %></td>
									</tr>
									<%} %>
									<%for(Travel travel:travelList){  i++;%>
									<tr class="tab_tr<%=i % 2 + 2%> tr_pointer" <%=travel.isCanBack()?("backid='"+travel.getId()+"'"):""%> flow_type="7" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=7&id=<%=travel.getId() %>'">
										<td class="tab_tr1_td0"><input type="checkbox" class="chk" id="checkbox_<%=++index %>"><label for="checkbox_<%=index %>" ></label></td>
										<td class="tab_tr1_td1"><%=travel.getId()%></td>
										<td class="tab_tr1_td2 tooltip_div"><%=travel.getName()%></td>
										<td class="tab_tr1_td3"><%=travel.getCreate_name()%></td>
										<td class="tab_tr1_td4"><%=flowTypeArray[7]%></td>
										<td class="tab_tr1_td13 tooltip_div"><%=travel.getProcess() %></td>
									</tr>
									<%} %>
									<%for(Leave leave:leaveList){  i++;%>
									<tr class="tab_tr<%=i % 2 + 2%> tr_pointer" <%=leave.isCanBack()?("backid='"+leave.getId()+"'"):"" %> flow_type="8" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=8&id=<%=leave.getId() %>'">
										<td class="tab_tr1_td0" ><input type="checkbox" class="chk" id="checkbox_<%=++index %>"><label for="checkbox_<%=index %>" ></label></td>
										<td class="tab_tr1_td1"><%=leave.getId()%></td>
										<td class="tab_tr1_td2 tooltip_div"><%=leave.getName()%></td>
										<td class="tab_tr1_td3"><%=leave.getCreate_name()%></td>
										<td class="tab_tr1_td4"><%=flowTypeArray[8]%></td>
										<td class="tab_tr1_td13 tooltip_div"><%=leave.getProcess() %></td>
									</tr>
									<%} %>
									<%for(Resumption resumption:resumptionList){  i++;%>
									<tr class="tab_tr<%=i % 2 + 2%> tr_pointer" <%=resumption.isCanBack()?("backid='"+resumption.getId()+"'"):"" %> flow_type="9" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=9&id=<%=resumption.getId() %>'">
										<td class="tab_tr1_td0" ><input type="checkbox" class="chk" id="checkbox_<%=++index %>"><label for="checkbox_<%=index %>" ></label></td>
										<td class="tab_tr1_td1"><%=resumption.getId()%></td>
										<td class="tab_tr1_td2 tooltip_div"><%=resumption.getName()%></td>
										<td class="tab_tr1_td3"><%=resumption.getCreate_name()%></td>
										<td class="tab_tr1_td4"><%=flowTypeArray[9]%></td>
										<td class="tab_tr1_td13 tooltip_div"><%=resumption.getProcess() %></td>
									</tr>
									<%} %>
									<%for(Track track:trackList){  i++;%>
									<tr class="tab_tr<%=i % 2 + 2%> tr_pointer" flow_type="10" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=17&id=<%=track.getId() %>'">
										<td class="tab_tr1_td0"></td>
										<td class="tab_tr1_td1"><%=track.getId()%></td>
										<td class="tab_tr1_td2 tooltip_div"><%=track.getName()%></td>
										<td class="tab_tr1_td3"><%=track.getCreate_name()%></td>
										<td class="tab_tr1_td4"><%=flowTypeArray[10]%></td>
										<td class="tab_tr1_td13 tooltip_div"><%=track.getProcess() %></td>
									</tr>
									<%} %>
									<%for(Sales_contract sales_contract:salesList){  i++;%>
									<tr class="tab_tr<%=i % 2 + 2%> tr_pointer" flow_type="11" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=19&id=<%=sales_contract.getId() %>'">
										<td class="tab_tr1_td0"></td>
										<td class="tab_tr1_td1 tooltip_div"><%=sales_contract.getContract_no()%></td>
										<td class="tab_tr1_td2 tooltip_div"><%=sales_contract.getName()%></td>
										<td class="tab_tr1_td3"><%=sales_contract.getCreate_name()%></td>
										<td class="tab_tr1_td4"><%=flowTypeArray[11]%></td>
										<td class="tab_tr1_td13 tooltip_div"><%=sales_contract.getProcess() %></td>
									</tr>
									<%} %>
									<%for(Purchase_contract purchase_contract:purchaseList){  i++;%>
									<tr class="tab_tr<%=i % 2 + 2%> tr_pointer" flow_type="12"  onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=20&id=<%=purchase_contract.getId() %>'">
										<td class="tab_tr1_td0"></td>
										<td class="tab_tr1_td1 tooltip_div"><%=purchase_contract.getContract_no()%></td>
										<td class="tab_tr1_td2 tooltip_div"><%=purchase_contract.getName()%></td>
										<td class="tab_tr1_td3"><%=purchase_contract.getCreate_name()%></td>
										<td class="tab_tr1_td4"><%=flowTypeArray[12]%></td>
										<td class="tab_tr1_td13 tooltip_div"><%=purchase_contract.getProcess() %></td>
									</tr>
									<%} %>
									<%for(Aftersales_task aftersales_task:aftersales_tasks){  i++;%>
									<tr class="tab_tr<%=i % 2 + 2%> tr_pointer" flow_type="13" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=21&id=<%=aftersales_task.getId() %>'">
										<td class="tab_tr1_td0"></td>
										<td class="tab_tr1_td1"><%=aftersales_task.getId()%></td>
										<td class="tab_tr1_td2 tooltip_div"><%=aftersales_task.getName()%></td>
										<td class="tab_tr1_td3"><%=aftersales_task.getCreate_name()%></td>
										<td class="tab_tr1_td4"><%=flowTypeArray[13]%></td>
										<td class="tab_tr1_td13 tooltip_div"><%=aftersales_task.getProcess() %></td>
									</tr>
									<%} %>
									<%for(Seal seal:seals){  i++;%>
									<tr class="tab_tr<%=i % 2 + 2%> tr_pointer" flow_type="14" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=22&id=<%=seal.getId() %>'">
										<td class="tab_tr1_td0"></td>
										<td class="tab_tr1_td1"><%=seal.getId()%></td>
										<td class="tab_tr1_td2 tooltip_div"><%=seal.getName()%></td>
										<td class="tab_tr1_td3"><%=seal.getCreate_name()%></td>
										<td class="tab_tr1_td4"><%=flowTypeArray[14]%></td>
										<td class="tab_tr1_td13 tooltip_div"><%=seal.getProcess() %></td>
									</tr>
									<%} %>
									<%for(Vehicle vehicle:vehicles){  i++;%>
									<tr class="tab_tr<%=i % 2 + 2%> tr_pointer" flow_type="15" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=23&id=<%=vehicle.getId() %>'">
										<td class="tab_tr1_td0"></td>
										<td class="tab_tr1_td1"><%=vehicle.getId()%></td>
										<td class="tab_tr1_td2 tooltip_div"><%=vehicle.getName()%></td>
										<td class="tab_tr1_td3"><%=vehicle.getCreate_name()%></td>
										<td class="tab_tr1_td4"><%=flowTypeArray[15]%></td>
										<td class="tab_tr1_td13 tooltip_div"><%=vehicle.getProcess() %></td>
									</tr>
									<%}%>
									<%for(Task task:taskList2){ i++;%>
									<tr class="tab_tr<%=i % 2 + 2%> tr_pointer" flow_type="17" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=25&id=<%=task.getId() %>'">
										<td class="tab_tr1_td0"></td>
										<td class="tab_tr1_td1"><%=task.getProject_id() %></td>
										<td class="tab_tr1_td2 tooltip_div"><%=task.getProject_name()%></td>
										<td class="tab_tr1_td3"><%=task.getCreate_name()%></td>
										<td class="tab_tr1_td4"><%=flowTypeArray[17]%></td>
										<td class="tab_tr1_td13 tooltip_div"><%=task.getProcess() %></td>
									</tr>
									<%} %>
									<%for(Shipping shipping:shippingList){ i++;%>
									<tr class="tab_tr<%=i % 2 + 2%> tr_pointer" flow_type="18" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=28&id=<%=shipping.getId() %>'">
										<td class="tab_tr1_td0"></td>
										<td class="tab_tr1_td1 tooltip_div"><%=shipping.getContract_no() %></td>
										<td class="tab_tr1_td2 tooltip_div"><%=shipping.getName()%></td>
										<td class="tab_tr1_td3"><%=shipping.getCreate_name()%></td>
										<td class="tab_tr1_td4"><%=flowTypeArray[18]%></td>
										<td class="tab_tr1_td13 tooltip_div"><%=shipping.getProcess() %></td>
									</tr>
									<%} %>
									<%for(Performance performance:performances){ i++;%>
									<tr class="tab_tr<%=i % 2 + 2%> tr_pointer" flow_type="19" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=32&id=<%=performance.getId() %>'">
										<td class="tab_tr1_td0"></td>
										<td class="tab_tr1_td1 tooltip_div"><%=performance.getId() %></td>
										<td class="tab_tr1_td2 tooltip_div"><%=performance.getName()%></td>
										<td class="tab_tr1_td3"><%=performance.getCreate_name()%></td>
										<td class="tab_tr1_td4"><%=flowTypeArray[19]%></td>
										<td class="tab_tr1_td13 tooltip_div"><%=performance.getProcess() %></td>
									</tr>
									<%} %>
									<%for(Deliver deliver:delivers){ i++;%>
									<tr class="tab_tr<%=i % 2 + 2%> tr_pointer" flow_type="20" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=33&id=<%=deliver.getId() %>'">
										<td class="tab_tr1_td0"></td>
										<td class="tab_tr1_td1 tooltip_div"><%=deliver.getProject_id() %></td>
										<td class="tab_tr1_td2 tooltip_div"><%=deliver.getProject_name()%></td>
										<td class="tab_tr1_td3"><%=deliver.getCreate_name()%></td>
										<td class="tab_tr1_td4"><%=flowTypeArray[20]%></td>
										<td class="tab_tr1_td13 tooltip_div"><%=deliver.getProcess() %></td>
									</tr>
									<%} %>
									<%for(Task_updateflow task_updateflow:task_updateflows){ i++;%>
									<tr class="tab_tr<%=i % 2 + 2%> tr_pointer" flow_type="21" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=41&id=<%=task_updateflow.getId() %>'">
										<td class="tab_tr1_td0"></td>
										<td class="tab_tr1_td1 tooltip_div"><%=task_updateflow.getId() %></td>
										<td class="tab_tr1_td2 tooltip_div"><%=task_updateflow.getName()%></td>
										<td class="tab_tr1_td3"><%=task_updateflow.getCreate_name()%></td>
										<td class="tab_tr1_td4"><%=flowTypeArray[21]%></td>
										<td class="tab_tr1_td13 tooltip_div"><%=task_updateflow.getProcess() %></td>
									</tr>
									<%} %>
									<%for(DepartmentPuchase departPuchase:departPuchaseflows){ i++;%>
									<tr class="tab_tr<%=i % 2 + 2%> tr_pointer" flow_type="22" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=36&id=<%=departPuchase.getId() %>'">
										<td class="tab_tr1_td0"></td>
										<td class="tab_tr1_td1 tooltip_div"><%=departPuchase.getId() %></td>
										<td class="tab_tr1_td2 tooltip_div"><%=departPuchase.getPurchaseNum()%></td>
										<td class="tab_tr1_td3"><%=departPuchase.getPurchaseName()%></td>
										<td class="tab_tr1_td4"><%=flowTypeArray[22]%></td>
										<td class="tab_tr1_td13 tooltip_div"><%=departPuchase.getProcess() %></td>
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
