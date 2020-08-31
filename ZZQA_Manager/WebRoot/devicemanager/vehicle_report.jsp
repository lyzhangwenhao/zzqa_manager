<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.customer_data.Customer_dataManager"%>
<%@page import="com.zzqa.pojo.customer_data.Customer_data"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%@page import="com.zzqa.service.interfaces.vehicle.VehicleManager"%>
<%@page import="com.zzqa.pojo.vehicle.Vehicle"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	Customer_dataManager customer_dataManager=(Customer_dataManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("customer_dataManager");
	PermissionsManager permissionsManager=(PermissionsManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("permissionsManager");
	VehicleManager vehicleManager=(VehicleManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("vehicleManager");
	if (session.getAttribute("uid") == null) {
		response.sendRedirect("login.jsp");
		return;
	}
	int uid = (Integer) session.getAttribute("uid");
	User mUser = userManager.getUserByID(uid);
	if (mUser == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	String keywords="";
	if (session.getAttribute("keywords_vehicle") != null) {
		keywords = (String)session.getAttribute("keywords_vehicle");
	}
	String[] flowTypeArray=DataUtil.getFlowTypeArray();
	String[] departmentArray = DataUtil.getdepartment();
	List<Vehicle> vehicles=vehicleManager.getAllKeyList(keywords);
	if(vehicles!=null && vehicles.size()>0){
		for(Vehicle vehicle:vehicles){
			if(vehicle!=null){
				vehicle.setName(departmentArray[vehicle.getApply_department()]);
			}
		}
	}
	pageContext.setAttribute("vehicles",vehicles);
	pageContext.setAttribute("keywords",keywords);
	pageContext.setAttribute("departmentArray",departmentArray);
	pageContext.setAttribute("flowTypeArray",flowTypeArray);
	int index=0;
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>用车统计表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="rendere" content="webkit|ie-comp|ie-stand">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/statistical.css">
		<link rel="stylesheet" type="text/css" href="css/customer_report.css">
		<link rel="stylesheet" type="text/css" href="css/custom.css">
		<link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-filer.css">
		<link rel="stylesheet" type="text/css" href="css/default.css">
		<link rel="stylesheet" type="text/css"
			href="css/jquery.filer-dragdropbox-theme.css">
		<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/prettify.js"></script>
		<script type="text/javascript" src="js/jquery.filer.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		<!-- 现将隐藏的文件上传控件添加到body中，再渲染 -->
		<script type="text/javascript" src="js/custom1.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
		$(function(){
			 $("#keywords_vehicle").keydown(function(e){
				if(e.keyCode==13){
					searchVehicle();
				}
			});
		 });
		
		function searchVehicle(){
			document.filterform.submit();
		}
		
		function onExportTrack(){
			var temp='';
			var count=0;
			var firstRowTemp='';
			
			$("#table_vehicle tr").each(function(){
				var rowTemp='';
				if(count==0){
					count++;
					$("#tab_tr11").find("td").each(function(){
						firstRowTemp+='の'+$(this).text().trim();			
			    	});
					temp+="い"+firstRowTemp.replace('の','');
				}else{
					$(this).find("td").each(function(){
						if(count==1){
							rowTemp+='の'+$(this).text().trim();
							count++;
						}else{
							rowTemp+='の'+$(this).text().trim();
						}
			    	});
					temp+="い"+rowTemp.replace('の','');
				}
			});
			temp=temp.replace("い","");
			//导出excel
			var filename="用车统计表";
			
			$.ajax({
				type:"post",//post方法
				url:"HandelTempFileServlet",
				data:{"type":"exporttrack_out","data":temp},
				//ajax成功的回调函数
				success:function(returnData){
					if(returnData.length>1){
						window.location.href="FileDownServlet?type=loadtrackexcel&filePath="+returnData+"&filename="+filename;
					}else{
						//失败
						initdiglog2("提示信息", "导出失败！");
					}
				},
				error : function(){
					initdiglog2("提示信息","导出失败！");
				}
			});
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
			<form action="DeviceServlet?type=vehiclefilter" method="post"
				name="filterform">
				<input type="text" style="display:none">
				<div class="td1_div3">
					用车统计表
				</div>
				<div class="td1_div4" style='height: 32px; lien-hegiht: 32px;'>
					<img title="导出表格" src="images/export_track.png" id="img_export" onclick="onExportTrack();" style='float:right;margin: 6px'>
					&nbsp;&nbsp;
					<img title="搜索" src="images/user_search.gif" id="searchCustomer" 
						onclick="searchVehicle();" class="searchCustomer">
					<input type="text" name="keywords_vehicle" id="keywords_vehicle"  maxlength="30" placeholder="" value="<%=keywords%>" 
						onkeydown="if(event.keyCode==32) return false">
						
					
				</div>
				<div>&nbsp;&nbsp;&nbsp;&nbsp;</div>
				<table class="device_tab" id="table_vehicle">
					<tr class="tab_tr1" id="tab_tr11">
						<td class="tab_tr1_td1" style="width: 80px;">
							申请人
						</td>
						<td class="tab_tr1_td2" >
							部门
						</td>
						<td class="tab_tr1_td3" >
							出发地
						</td>
						<td class="tab_tr1_td4" >
							目的地
						</td>
						<td class="tab_tr1_td5" >
							出发时间	
						</td>
						<td class="tab_tr1_td6" >
							结束时间
						</td>
						<td class="tab_tr1_td7" >
							司机
						</td>
						<td class="tab_tr1_td8" >
							行驶里程
						</td>
						<td class="tab_tr1_td9" >
							车辆信息
						</td>
						<td class="tab_tr1_td10" >
							进度
						</td>
					<c:forEach items="${vehicles}" varStatus="status" var="customer">
					<tr id="tr<c:out value="${customer.id}"></c:out>" class="tab_tr2 tr_pointer" >
						<td class="tab_tr1_td1 tooltip_div">
							<c:out value="${customer.create_name}"></c:out>
						</td>
						<td class="tab_tr1_td2 tooltip_div" >
							<c:out value="${customer.name}"></c:out>
						</td>
						<td class="tab_tr1_td3 tooltip_div" >
							<c:out value="${customer.initial_address}"></c:out>
						</td>
						<td class="tab_tr1_td4 tooltip_div" >
							<c:out value="${customer.address}"></c:out>
						</td>
						<td class="tab_tr1_td5 tooltip_div" >
							<c:out value="${customer.start_driver_date}"></c:out>
						</td>
						<td class="tab_tr1_td6 tooltip_div" >
							<c:out value="${customer.end_driver_date}"></c:out>
						</td>
						<td class="tab_tr1_td7 tooltip_div" >
							<c:out value="${customer.driverName}"></c:out>
						</td>
						<td class="tab_tr1_td8 tooltip_div" >
							<c:out value="${customer.mileage_used}"></c:out>
						</td>
						<td class="tab_tr1_td9 tooltip_div" >
							<c:out value="${customer.car_info}"></c:out>
						</td>
						<td class="tab_tr1_td10 tooltip_div" >
							<c:out value="${customer.process}"></c:out>
						</td>
					</tr>
					</c:forEach>
				</table>
			</form>
		</div>
	</body>
</html>
