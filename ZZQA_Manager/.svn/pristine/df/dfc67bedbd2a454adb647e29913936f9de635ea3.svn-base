<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page
	import="com.zzqa.service.interfaces.procurement.ProcurementManager"%>
<%@page import="com.zzqa.pojo.procurement.Procurement"%>
<%@page import="com.zzqa.service.interfaces.shipments.ShipmentsManager"%>
<%@page import="com.zzqa.pojo.shipments.Shipments"%>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page import="com.zzqa.service.interfaces.file_path.File_pathManager"%>
<%@page import="com.zzqa.pojo.file_path.File_path"%>
<%@page import="com.zzqa.service.interfaces.task.TaskManager"%>
<%@page import="com.zzqa.pojo.task.Task"%>
<%@page import="com.zzqa.service.interfaces.linkman.LinkmanManager"%>
<%@page import="com.zzqa.pojo.linkman.Linkman"%>
<%@page import="com.zzqa.service.interfaces.device.DeviceManager"%>
<%@page import="com.zzqa.pojo.device.Device"%>
<%@page import="com.zzqa.pojo.material.Material"%>
<%@page
	import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	ShipmentsManager shipmentsManager = (ShipmentsManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("shipmentsManager");
	FlowManager flowManager = (FlowManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("flowManager");
	File_pathManager file_pathManager = (File_pathManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("file_pathManager");
	TaskManager taskManager = (TaskManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("taskManager");
	Position_userManager position_userManager = (Position_userManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("position_userManager");
	LinkmanManager linkmanManager = (LinkmanManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("linkmanManager");
	DeviceManager deviceManager = (DeviceManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("deviceManager");
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
	if (session.getAttribute("ship_id") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	} 
	int ship_id = (Integer)session.getAttribute("ship_id");
	Shipments shipments = shipmentsManager.getShipmentsDetailByID(ship_id);
	Flow flow = flowManager.getNewFlowByFID(6, ship_id);
	if(shipments==null||flow==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	Task task = taskManager.getTaskByID(shipments.getTask_id());
	if(task==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int operation = flow.getOperation();
	Map<String, String> map = shipmentsManager
			.getShipFlowForDraw(shipments,flow);
	List<Linkman> linkmanList = linkmanManager.getLinkmanListLimit(6,
			ship_id, 1, 0);
	boolean isShiper=permissionsManager.checkPermission(mUser.getPosition_id(), 27);
	boolean isPuter=permissionsManager.checkPermission(mUser.getPosition_id(), 23);
	boolean isCreater=shipments.getCreate_id()==mUser.getId();
	boolean fileCheck=permissionsManager.checkPermission(mUser.getPosition_id(), 154);
	boolean isWatcher="admin".equals(mUser.getName())||task.getCreate_id()==mUser.getId();
	if(!isWatcher){
		isWatcher=(task.getType()==0&&permissionsManager.checkPermission(mUser.getPosition_id(), 10))||(task.getType()==1||permissionsManager.checkPermission(mUser.getPosition_id(), 115));
	}
	pageContext.setAttribute("shipments", shipments);
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>发货流程</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/shipmentsflow_detail.css">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css" href="css/custom.css">
		<link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-filer.css">
		<link rel="stylesheet" type="text/css" href="css/default.css">
		<link rel="stylesheet" type="text/css"
			href="css/jquery.filer-dragdropbox-theme.css">
		<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/showdate1.js"></script>
		<script type="text/javascript" src="js/prettify.js"></script>
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/jquery.filer.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		<script type="text/javascript" src="js/custom1.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		
		<!--[if IE]>
			<script src="http://libs.useso.com/js/html5shiv/3.7/html5shiv.min.js"></script>
		<![endif]-->
		<!--
		<link rel="stylesheet" type="text/css" href="styles.css">
		-->
		<script type="text/javascript">
			var linkman_num=0;
	   		function submitFiles(op){
	   			var k=0
	   			if(op==2){
	   				if(successUploadFileNum1==0){
	   					k++
	   					document.getElementById("file_input1_error").innerText="请选择文件";
	   				}else{
	   					document.getElementById("file_input1_error").innerText="";
	   				}
	   			}else if(op==7){
	   				if(successUploadFileNum2==0){
	   					k++
	   					document.getElementById("file_input2_error").innerText="请选择文件";
	   				}else{
	   					document.getElementById("file_input2_error").innerText="";
	   				}
	   				if(successUploadFileNum3==0){
	   					k++
	   					document.getElementById("file_input3_error").innerText="请选择文件";
	   				}else{
	   					document.getElementById("file_input3_error").innerText="";
	   				}
	   			}
	   			if(k==0){
    				document.flowform.submit();
    			}
	   		}
	   		function testPhoneNumber(phone){
	 			if(phone.length>0){
	   				var reg_phone=/^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
	   				var reg_mobile=/^1\d{10}$/;
	   				if(reg_phone.test(phone)||reg_mobile.test(phone)){
	     				return true;
	   				}
	     			return false;
	 			}else{
	    			return false;
	 			}
			}
	   		function deliver(){
	   			var k=0;
		   		if(document.flowform.address.value.replace(/[ ]/g,"").length<1){
		   			k++;
		   			document.getElementById("address_error").innerText="请输入收货地址";
		   		}else{
		   			document.getElementById("address_error").innerText="";
		   		}
		   		if(document.flowform.company.value.replace(/[ ]/g,"").length<1){
		   			k++;
		   			document.getElementById("company_error").innerText="请输入物流公司";
		   		}else{
		   			document.getElementById("company_error").innerText="";
		   		}
		   		var linkmans="";
		   		for(var i=1;i<linkman_num+1;i++){
		   			if(document.getElementById("linkman_div"+i)){
		   			    var linkman= document.getElementById("linkman"+i).value.replace(/[ ]/g, "");
		   			    var phone= document.getElementById("phone"+i).value.replace(/[ ]/g, "");
						if(linkman!=null&&linkman.length>0&&testPhoneNumber(phone)){
							document.getElementById("linkman"+i).value=linkman;
							document.getElementById("phone"+i).value=phone;
							document.getElementById("linkman_span"+i).innerText="";
							if(linkmans.length==0){
								linkmans=linkman+"の"+phone;
							}else{
								linkmans+="い"+linkman+"の"+phone;
							}
						}else{
							k++;
							if(linkman.length<1&&phone.length<1){
								document.getElementById("linkman_span"+i).innerText="请输入姓名和电话";
							}else if(linkman.length<1){
								document.getElementById("linkman_span"+i).innerText="请输入姓名";
							}else if(phone.length<1){
								document.getElementById("linkman_span"+i).innerText="请输入电话";
							}else if(!testPhoneNumber(phone)){
								document.getElementById("linkman_span"+i).innerText="电话格式不正确";
							}else{
								document.getElementById("linkman_span"+i).innerText="信息输入有误";
							}
						}
					}
		   		}
		   		var linkman= document.getElementById("linkman0").value.replace(/[ ]/g, "");
   			    var phone= document.getElementById("phone0").value.replace(/[ ]/g, "");
				if(linkman!=null&&linkman.length>0&&testPhoneNumber(phone)){
					document.getElementById("linkman0").value=linkman;
					document.getElementById("phone0").value=phone;
					document.getElementById("linkman_span0").innerText="";
					if(linkmans.length==0){
						linkmans=linkman+"の"+phone;
					}else{
						linkmans+="い"+linkman+"の"+phone;
					}
				}else{
					k++;
					if(linkman.length<1&&phone.length<1){
						document.getElementById("linkman_span0").innerText="请输入姓名和电话";
					}else if(linkman.length<1){
						document.getElementById("linkman_span0").innerText="请输入姓名";
					}else if(phone.length<1){
						document.getElementById("linkman_span0").innerText="请输入电话";
					}else if(!testPhoneNumber(phone)){
						document.getElementById("linkman_span0").innerText="电话格式不正确";
					}else{
						document.getElementById("linkman_span0").innerText="信息输入有误";
					}
				}
		   		document.flowform.linkmans.value=linkmans;
		   		if(k==0){
		   			document.flowform.submit();
		   		}
	   		}
	   		function aog(){
	   			if(strToDate(document.flowform.aog_time.value)){
		   			document.getElementById("time_error").innerText="时间格式不正确";
		   		}else{
		   			document.getElementById("time_error").innerText="";
		   			document.flowform.submit();
		   		}
	   		}
	   		function returnFile(){
	   			if(successUploadFileNum5==0) {
        				document.getElementById("file_input5_error").innerText="请选择文件";
    				}else {
        				document.getElementById("file_input5_error").innerText="";
        				document.flowform.submit();
    				}
	   		}
		   	function strToDate(str) {
		   		//判断日期格式符合YYYY-MM-DD标准
	 			var tempStrs = str.split("-");
	 			if(tempStrs.length==3&&validate(tempStrs[0])&&tempStrs[0].length==4&&validate(tempStrs[1])&&tempStrs[1]<13&&validate(tempStrs[2])&&tempStrs[2]<32){
					return false;
	 			}
	 			return true;
	 		}
	 		function validate(sDouble){
				//检验是否为正数
	  			var re = /^\d+(?=\.{0,1}\d+$|$)/;
	 		 	return re.test(sDouble)&&sDouble>0;
			}
	   		function addLinkman(){
	   			linkman_num++;
	   			var temp="";
	   			for(var i=1;i<linkman_num;i++){
	   				if(document.getElementById("linkman_div"+i)){
	   					var linkman=document.getElementById("linkman"+i).value;
		   				var phone=document.getElementById("phone"+i).value;
	   					temp+='<div class="div_padding" id="linkman_div'+i+'">'+
							'姓名：<input type="text" value="'+linkman+'"id="linkman'+i+'" maxlength="10" onkeydown="if(event.keyCode==32) return false">'+
							' 电话：<input type="phone" value="'+phone+'"id="phone'+i+'"  maxlength="20" onkeydown="if(event.keyCode==32) return false">'+
							' <img src="images/delete.png" title="删除" onclick="delLinkman('+i+');">'+
							' <span id="linkman_span'+i+'"></span></div>';
	   				}
	   			}
		   		var linkman=document.getElementById("linkman0").value;
		   		var phone=document.getElementById("phone0").value;
		   		var linkman_div = document.getElementById("linkman_div");
		   		temp+='<div class="div_padding" id="linkman_div'+linkman_num+'">'+
						'姓名：<input type="text" value="'+linkman+'"id="linkman'+linkman_num+'" maxlength="10" onkeydown="if(event.keyCode==32) return false">'+
						' 电话：<input type="phone" value="'+phone+'"id="phone'+linkman_num+'"  maxlength="20" onkeydown="if(event.keyCode==32) return false">'+
						' <img src="images/delete.png" title="删除" onclick="delLinkman('+linkman_num+');">'+
						' <span id="linkman_span'+linkman_num+'"></span></div>';
				document.getElementById("linkman0").value="";
				document.getElementById("phone0").value=""
		   		linkman_div.innerHTML = temp;
			}
	   		function delLinkman(name){
		   		var id="linkman_div"+name;
		   		var obj = document.getElementById(id);
				if (obj != null) {
					if(name == 0){
						for(var i=linkman_num;i>0;i--){
							if(document.getElementById("linkman_div"+i)){
								document.getElementById("linkman"+0).value = document.getElementById("linkman"+i).value;
								document.getElementById("phone"+0).value = document.getElementById("phone"+i).value;
								var lastId = "linkman_div"+i;
								var lastObj = document.getElementById(lastId);
								lastObj.parentNode.removeChild(lastObj);
								break;
							}
						}
						if(i == 0){
							initdiglog2("提示信息","至少保留一行！");
							return;
						}
					}
					else{
						obj.parentNode.removeChild(obj);
					}
				}
	   		}
	   		function setTime(time,obj){
				var deliverTime="<%=shipments.getShip_date()%>";
		    	//修改time的时间
		    	if(compareTime1(deliverTime,time)){
		    		obj.value=time;
		    	}else{
		    		initdiglog2("提示信息","到货时间不能早于发货时间！");
		    	}
		    }
	   		function deldiv(id){
		   		var obj = document.getElementById(id);
				if (obj != null) {
					obj.parentNode.removeChild(obj);
				}
	   		}
			function showDetail(detail){
				initdiglog4("印制板详情",detail);
			}
			function findNOTask(){
				initdiglog2("提示信息","抱歉，找不到任务单！");
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
							action="FlowManagerServlet?type=shipmentsflow&uid=<%=mUser.getId()%>&ship_id=<%=shipments.getId()%>&operation=<%=operation%>&file_time=<%=System.currentTimeMillis()%>"
							method="post" name="flowform">
							<div class="td2_div">
								<div class="td2_div1">
									<div class="td2_div1_1">
										<div class="<%=map.get("class11")%>">
											出库
										</div>
										<div class="<%=map.get("class12")%>">
											发货单据
										</div>
										<div class="<%=map.get("class13")%>">
											发货
										</div>
										<div class="<%=map.get("class14")%>">
											到货
										</div>
										<div class="<%=map.get("class15")%>">
											完成
										</div>
									</div>
									<div class="td2_div1_2">
										<div class="td2_div2_img">
											<img src="images/<%=map.get("img1")%>">
										</div>
										<div class="<%=map.get("class22")%>"></div>

										<div class="td2_div2_img">
											<img src="images/<%=map.get("img2")%>">
										</div>
										<div class="<%=map.get("class24")%>"></div>

										<div class="td2_div2_img">
											<img src="images/<%=map.get("img3")%>">
										</div>
										<div class="<%=map.get("class255")%>"></div>
										<div class="<%=map.get("class256")%>"></div>

										<div class="td2_div2_img">
											<img src="images/<%=map.get("img4")%>">
										</div>
										<div class="<%=map.get("class26")%>"></div>

										<div class="td2_div2_img">
											<img src="images/<%=map.get("img5")%>">
										</div>
									</div>
									<div class="td2_div1_3">
										<div class="td2_div31"><%=map.get("time1")%></div>
										<div class="td2_div32"><%=map.get("time2")%></div>
										<div class="td2_div33"><%=map.get("time3")%></div>
										<div class="td2_div34"><%=map.get("time4")%></div>
										<div class="td2_div35"><%=map.get("time5")%></div>
									</div>
								</div>
								<div class="td2_div2">
									<div class="td2_div0">
										发货单
									</div>
									<div class="td2_div3">
										<div class="td2_div3_1">
											项目名称：<%=task.getProject_name()%>
										</div>
										<div class="td2_div3_2">
											项目编号：<%=task.getProject_id()%>
										</div>
										<div class="td2_div3_2">
											提 交 人：<%=shipments.getCreate_name()%>
										</div>
										<div class="td2_div3_2">
											<a href="<%=isWatcher?"FlowManagerServlet?type=flowdetail&flowtype=1&id="+task.getId():"javascript:void(0)"%>" <%=isWatcher?"target='_bank'":"onclick='canNotSee();this.blur()'" %>>查看任务单</a>
										</div>
									</div>
									<div class="td2_table2_div">
										<span>设备台数：${fn:length(shipments.equipments)}台</span>
										</div>
											<table class="td2_table2">
												<tr class="td2_table2_tr1">
													<td class="table2_tr1_td1" style="min-width:75px;">
														ID
													</td>
													<td class="table2_tr1_td2" style="min-width:65px;">
														SN
													</td>
													<td class="table2_tr1_td3" style="min-width:65px;">
														印制版
													</td>
													<td class="table2_tr1_td4" style="min-width:75px;">
														测试报告
													</td>
													<td class="table2_tr1_td4" style="min-width:150px;">
														生产时间
													</td>
												</tr>
												<c:forEach items="${shipments.equipments }" var="equipment">
												<tr class="td2_table2_tr2">
													<td class="table2_tr2_td1">${equipment.idStr}</td>
													<td class="table2_tr2_td2">${equipment.sn}
													
													
													</td>
													<td class="table2_tr2_td3">
														<c:if test="${not empty equipment.circuit_cards}">
															<c:set var="card_str" value="<table class='tooltip_table'>"></c:set>
															<c:forEach items="${equipment.circuit_cards }" var="circuit_card">
															<c:set var="card_str"  value="${card_str}<tr><td>名称：</td><td>${circuit_card.name}</td><td>批次号:</td><td>${circuit_card.sn}</td><td></tr>"></c:set>
															</c:forEach>
															<c:set var="card_str"  value="${card_str}</table>"></c:set>
															<div id="link">
															<a class="device_detail link_tooltip" href="javascript:void(0)"
																onclick="this.blur();showDetail(&quot<c:out value="${card_str}"></c:out>&quot)"
																title="<c:out value="${card_str}" escapeXml="true"></c:out>">详细...</a>
															</div>
														</c:if>
													</td>
													<td class="table2_tr2_td4">
													<c:if test="${not empty equipment.file_path}">
														<a class="file_detail" href="javascript:void()"
															onclick="fileDown(${equipment.file_path.id})">测试报告</a>
													</c:if>
													</td>
													<td class="table2_tr2_td4">${equipment.update_date}</td>
												</tr>
												</c:forEach>
											</table>
											<%
												if (operation>2||(operation==2&&fileCheck)) {
													List<File_path> flist = file_pathManager.getAllFileByCondition(
															6, ship_id, 1, 0);
													File_path fiList1 = null;
													if (flist.size() > 0) {
														fiList1 = flist.get(0);
													}
													flist = file_pathManager
															.getAllFileByCondition(6, ship_id, 2, 0);
													File_path fiList2 = null;
													if (flist.size() > 0) {
														fiList2 = flist.get(0);
													}
													flist = file_pathManager
															.getAllFileByCondition(6, ship_id, 3, 0);
													File_path fiList3 = null;
													if (flist.size() > 0) {
														fiList3 = flist.get(0);
													}
													flist = file_pathManager
															.getAllFileByCondition(6, ship_id, 4, 0);
													File_path fiList4 = null;
													if (flist.size() > 0) {
														fiList4 = flist.get(0);
													}
													List<File_path> fiList5 = null;
													if (operation == 6) {
														fiList5 = file_pathManager.getAllFileByCondition(6, ship_id,5, 0);

													}
											%>
												<div class="td2_div4">
													单据
												</div>
												<table class="td2_table0">
													<tr class="table0_tr1">
														<td class="table0_tr1_td1">
															成品出厂检查记录表
														</td>
														<td class="table0_tr1_td2">
															<%
																if (fiList1 != null) {
															%>
															<div>
																<a href="javascript:void()"
																	onclick="fileDown(<%=fiList1.getId()%>)"><%=fiList1.getFile_name()%></a>
															</div>
															<%
																}
															%>
															<%if(operation==2&&fileCheck){ %>
															<div id="section4" class="section-white8">
																<input type="file" name="file1" id="file_input1"
																	multiple="multiple">
															</div>
															<div class="section-white9">
																<span id="file_input1_error"></span>
															</div>
															<%} %>
														</td>
													</tr>
													<%if(operation!=2&&(operation!=7||isCreater)){ %>
													<tr class="table0_tr1">
														<td class="table0_tr1_td1">
															设备装箱清单
														</td>
														<td class="table0_tr1_td2">
															<%
																if (fiList2 != null) {
															%>
															<div>
																<a href="javascript:void()"
																	onclick="fileDown(<%=fiList2.getId()%>)"><%=fiList2.getFile_name()%></a>
															</div>
															<%
																}
															%>
															<%if(operation==7&&isCreater){ %>
															<div id="section4" class="section-white8">
																<input type="file" name="file2" id="file_input2"
																	multiple="multiple">
															</div>
															<div class="section-white9">
																<span id="file_input2_error"></span>
															</div>
															<%} %>
														</td>
													</tr>
													<tr class="table0_tr1">
														<td class="table0_tr1_td1">
															现场开箱验货报告
														</td>
														<td class="table0_tr1_td2">
															<%
																if (fiList3 != null) {
															%>
															<div>
																<a href="javascript:void()"
																	onclick="fileDown(<%=fiList3.getId()%>)"><%=fiList3.getFile_name()%></a>
															</div>
															<%
																}
															%>
															<%if(operation==7&&isCreater){ %>
															<div id="section4" class="section-white8">
																<input type="file" name="file3" id="file_input3"
																	multiple="multiple">
															</div>
															<div class="section-white9">
																<span id="file_input3_error"></span>
															</div>
															<%} %>
														</td>
													</tr>
													<%if(fiList4 != null&&("admin".equals(mUser.getName())||shipments.getCreate_id()==mUser.getId()||permissionsManager.checkPermission(mUser.getPosition_id(), 38))){ %>
													<tr class="table0_tr1">
														<td class="table0_tr1_td1">
															财务发货清单
														</td>
														<td class="table0_tr1_td2">
															<div>
																<a href="javascript:void()"
																	onclick="fileDown(<%=fiList4.getId()%>)"><%=fiList4.getFile_name()%></a>
															</div>
														</td>
													</tr>
													<%} %>
													<%
														if (operation == 6) {
													%>
													<tr class="table0_tr1">
														<td class="table0_tr1_td1">
															现场开箱验货报告回执单
														</td>
														<td class="table0_tr1_td2">
														<%for(File_path file_path:fiList5){ %>
															<div>
																<a href="javascript:void()"
																	onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%></a>
															</div>
															<%
																}
															%>
														</td>
													</tr>
													<%
														}}
													%>
												</table>
												<%
													if (operation > 3&&operation!=7) {
												%>
												<div class="td2_div4">
													物流信息
												</div>
												<table class="td2_table1">
													<tr class="table1_tr2">
														<td class="table1_tr2_td1">
															联系人信息
														</td>
														<td class="table1_tr2_td2">
															<%
																for (Linkman linkman : linkmanList) {
															%>
															<span><%="姓名：" + linkman.getLinkman()%></span>&nbsp&nbsp
															<span><%="电话：" + linkman.getPhone()%></span>
															<br />
															<%
																}
															%>
														</td>
													</tr>
													<tr class="table1_tr3">
														<td class="table1_tr3_td1">
															收货地址
														</td>
														<td class="table1_tr3_td2">
															<%=shipments.getAddress()%>
														</td>
													</tr>
													<tr class="table1_tr3">
														<td class="table1_tr3_td1">
															订单号
														</td>
														<td class="table1_tr3_td2">
															<%=shipments.getOrder_id()%>
														</td>
													</tr>
													<tr class="table1_tr3">
														<td class="table1_tr3_td1">
															物流公司
														</td>
														<td class="table1_tr3_td2">
															<%=shipments.getLogistics_company()%>
														</td>
													</tr>
													<%
														if (operation > 4) {
													%>
													<tr class="table1_tr3">
														<td class="table1_tr3_td1">
															到货时间
														</td>
														<td class="table1_tr3_td2">
															<%=shipments.getAog_date()%>
														</td>
													</tr>
													<%
														}
													%>
												</table>
												<%
													}
												%>
											<%
												}
											%>
										</div>

										<%-- <%
											if (operation == 2 && fileCheck) {
										%>

										<div class="td2_div4">
											单据
										</div>
										<table class="td2_table00">
											<tr class="table0_tr1">
												<td class="table0_tr1_td1">
													<span class="star">*</span>成品出厂检查记录表
												</td>
												<td class="table0_tr1_td2">
													<div id="section4" class="section-white8">
														<input type="file" name="file1" id="file_input1"
															multiple="multiple">
													</div>
													<div class="section-white9">
														<span id="file_input1_error"></span>
													</div>
												</td>
											</tr>
											<tr class="table0_tr1">
												<td class="table0_tr1_td1">
													<span class="star">*</span>设备装箱清单
												</td>
												<td class="table0_tr1_td2">
													
												</td>
											<tr class="table0_tr1">
												<td class="table0_tr1_td1">
													<span class="star">*</span>现场开箱验货报告
												</td>
												<td class="table0_tr1_td2">
													<div id="section4" class="section-white8">
														<input type="file" name="file3" id="file_input3"
															multiple="multiple">
													</div>
													<div class="section-white9">
														<span id="file_input3_error"></span>
													</div>
												</td>
											</tr>
										</table>
										<%
											}
										%> --%>
										
										<%
											if (operation == 3
													&& isShiper) {
										%>
											<div class="td2_div4">
												物流信息
											</div>
											<table class="td2_table11">
												<tr class="table1_tr0">
													<td class="table1_tr0_td1">
														<span class="star">*</span>联系人信息
													</td>
													<td class="table1_tr0_td2">
														<input type="hidden" name="linkmans">
														<div id="linkman_div"></div>
														<div id="linkman_div0" class="div_padding">
															<!-- 回车会出现空格 -->
															姓名：<input type="text" id="linkman0" maxlength="10"
																onkeydown="if(event.keyCode==32) return false">									
															电话：<input type="phone" id="phone0" maxlength="20"
																onkeydown="if(event.keyCode==32) return false">
															<img src="images/delete.png" title="删除"
																onclick="delLinkman(0);">
															<img src="images/add_linkman.png" title="添加"
																onclick="addLinkman();">
															<span id="linkman_span0" style="margin-left: 5px;"></span>
														</div>
													</td>
												</tr>
												<tr class="table1_tr1">
													<td class="table1_tr1_td1">
														<span class="star">*</span>收货地址
													</td>
													<td class="table1_tr1_td2">
														<input type="text" name="address" maxlength="100">
														<span id="address_error"></span>
													</td>
												</tr>
												<tr class="table1_tr1">
													<td class="table1_tr1_td1">
														订单号
													</td>
													<td class="table1_tr1_td2">
														<input type="text" name="orderid" maxlength="30">
														<span id="orderid_error"></span>
													</td>
												</tr>
												<tr class="table1_tr1">
													<td class="table1_tr1_td1">
														<span class="star">*</span>物流公司
													</td>
													<td class="table1_tr1_td2">
														<input type="text" name="company" maxlength="100">
														<span id="company_error"></span>
													</td>
												</tr>
											</table>
										<%
											}
										%>
										<%
											if (operation == 4
													&& isShiper) {
										%>
											<table class="td2_table11">
												<tr class="table1_tr3">
													<td class="table1_tr3_td1">
														<span class="star">*</span>到货时间
													</td>
													<td class="table1_tr3_td2">
														<input type="text" id="time" name="aog_time"
															class="aog_time" readonly="readonly"
															value="<%=DataUtil.getTadayStr()%>"
															onClick="return Calendar('time');" />
														<span class="red_error" id="time_error"></span>
													</td>
												</tr>
											</table>
										<%
											}
										%>
										<%
											if (operation == 5
													&& isShiper) {
										%>
											<table class="td2_table00">
												<tr class="table0_tr1">
													<td class="table0_tr1_td1">
														<span class="star">*</span>现场开箱验货报告回执单
													</td>
													<td class="table0_tr1_td2">
														<div id="section4" class="section-white8">
															<input type="file" name="file5" id="file_input5"
																multiple="multiple">
														</div>
														<div class="section-white9">
															<span id="file_input5_error"></span>
														</div>
													</td>
												</tr>
											</table>
										<%
											}
										%>
										<div class="div_btn">
											<%
												if (operation == 1
														&& isPuter) {
											%><img src="images/putout.png" class="btn_agree"
												onclick="document.flowform.submit();">
											<%
												}
											%>
											<%
												if ((operation == 2&& fileCheck)||(operation == 7&& isCreater)) {
											%>

											<img src="images/submit_flow.png" class="btn_agree"
												onclick="submitFiles(<%=operation%>);">
											<%
												}
											%>
											<%
												if (operation == 3
														&& isShiper) {
											%>

											<img src="images/submit_flow.png" class="btn_agree"
												onclick="deliver();">
											<%
												}
											%>
											<%
												if (operation == 4
														&& isShiper) {
											%>

											<img src="images/submit_flow.png" class="btn_agree"
												onclick="aog();">
											<%
												}
											%>
											<%
												if (operation == 5
														&& isShiper) {
											%>

											<img src="images/submit_flow.png" class="btn_agree"
												onclick="returnFile();">
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
