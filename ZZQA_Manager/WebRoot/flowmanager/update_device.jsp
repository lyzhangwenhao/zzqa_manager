<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.device.DeviceManager"%>
<%@page import="com.zzqa.pojo.device.Device"%>
<%@page import="com.zzqa.service.interfaces.material.MaterialManager"%>
<%@page import="com.zzqa.pojo.material.Material"%>
<%@page import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page import="com.zzqa.pojo.file_path.File_path"%>
<%@page
	import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	DeviceManager deviceManager = (DeviceManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("deviceManager");
	MaterialManager materialManager = (MaterialManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("materialManager");
	Position_userManager position_userManager=(Position_userManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("position_userManager");
	FlowManager flowManager=(FlowManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("flowManager");
	PermissionsManager permissionsManager=(PermissionsManager) WebApplicationContextUtils
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
	if(session.getAttribute("device_id")==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int device_id=(Integer)session.getAttribute("device_id");
	Device device=deviceManager.getDeviceByID(device_id);
	Flow flow=flowManager.getNewFlowByFID(5,device.getM_id());
	if(flow==null||device==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int operation=flow.getOperation();
	List<Material> mlist=materialManager.getMaterialList(device_id);
	File_path file_path=device.getFile_path();
	String[] materialTypeArray=DataUtil.getMaterialArray();
	boolean isAlter=permissionsManager.checkPermission(mUser.getPosition_id(), 24);
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>修改设备</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css"
			href="css/add_device.css">
		<link rel="stylesheet" type="text/css" href="css/custom.css">
		<link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-filer.css">
		<link rel="stylesheet" type="text/css" href="css/default.css">
		<link rel="stylesheet" type="text/css"
			href="css/jquery.filer-dragdropbox-theme.css">
		<link rel="stylesheet" type="text/css"
			href="css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script src="js/showdate.js" type="text/javascript"></script>
		<script src="js/prettify.js" type="text/javascript"></script>
		<script src="js/jquery.min.js" type="text/javascript"></script>
		<script src="js/jquery.filer.min.js" type="text/javascript"></script>
		<script src="js/custom1.js" type="text/javascript"></script>
		<script  type="text/javascript" src="js/jquery-ui.min.js"></script>
 		<script  type="text/javascript" src="js/dialog.js"></script>
 		<script  type="text/javascript" src="js/public.js"></script>
 		
		<!--[if IE]>
			<script src="http://libs.useso.com/js/html5shiv/3.7/html5shiv.min.js"></script>
		<![endif]-->
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
			function addFlow(){
		   		var k=0;
		   		var sn=document.flowform.sn.value.replace(/[ ]/g,"");
		   		if(sn.length<1){
		   			k++;
		   			document.getElementById("sn_error").innerText="请输入设备批次号";
		   		}else{
		   			document.getElementById("sn_error").innerText="";
		   		}
		   		for(var i=0;i<6;i++){
		   			var sn=document.getElementById("sn"+i).value.replace(/[ ]/g,"");
			   		if(sn.length<1){
			   			k++;
			   			document.getElementById("material"+i).innerText="请输入批次号";
			   		}else{
			   			document.getElementById("material"+i).innerText="";
			   		}
		   		}
		   		if(k==0){
		   			document.flowform.submit();
		   		}
	   		}
	   		function initauto() {
				$("#sn").autocomplete({
					source: "./Autocomplete?typename=device"
				});
				$("#sn0").autocomplete({
					source: "./Autocomplete?typename=material&type=1"
				});
				$("#sn1").autocomplete({
					source: "./Autocomplete?typename=material&type=3"
				});
				$("#sn2").autocomplete({
					source: "./Autocomplete?typename=material&type=5"
				});
				$("#sn3").autocomplete({
					source: "./Autocomplete?typename=material&type=7"
				});
				$("#sn4").autocomplete({
					source: "./Autocomplete?typename=material&type=9"
				});
				$("#sn5").autocomplete({
					source: "./Autocomplete?typename=material&type=11"
				});
			}
			$(function(){
				initauto();
			});
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
						<form
							action="FlowManagerServlet?type=updatedevice&uid=<%=mUser.getId()%>&device_id=<%=device_id %>&file_time=<%=System.currentTimeMillis()%>"
							method="post" name="flowform" enctype="multipart/form-data">
							<div class="td2_div">
								<div class="td2_div1">
									修改设备
								</div>
								<table class="td2_table2">
									<tr class="table2_tr1">
										<td class="table2_tr1_td1">
											<span class='star'>*</span>ID
										</td>
										<td class="table2_tr1_td2">
											<%=device.getIdStr() %>
										</td>
									</tr>
									<tr class="table2_tr1">
										<td class="table2_tr1_td1">
											<span class='star'>*</span>批次号SN
										</td>
										<td class="table2_tr1_td2">
											<input type="text" name="sn" id="sn" onkeydown="if(event.keyCode==32) return false" maxlength="20" value="<%=device.getSn() %>">
											<span id="sn_error"></span>
										</td>
									</tr>
									<tr class="table2_tr2">
										<td class="table2_tr2_td1">
											<span class='star'>*</span>所需器皿
										</td>
										<td class="table2_tr2_td2">
											<div class="div_padding">
												<span class="table2_tr2_td2_span"><%=materialTypeArray[1] %>:</span>
												批次号：<input type="text" name="sn0" onkeydown="if(event.keyCode==32) return false" id="sn0" maxlength="50" value="<%=mlist.get(0).getSn() %>">
												<span class="error_span" id="material0"></span>
											</div>
											<div class="div_padding">
												<span class="table2_tr2_td2_span"><%=materialTypeArray[2] %>:</span>
												批次号：<input type="text" name="sn1" onkeydown="if(event.keyCode==32) return false" id="sn1" maxlength="50" value="<%=mlist.get(1).getSn() %>">
												<span class="error_span" id="material1"></span>
											</div>
											<div class="div_padding">
												<span class="table2_tr2_td2_span"><%=materialTypeArray[3] %>:</span>
												批次号：<input type="text" name="sn2" onkeydown="if(event.keyCode==32) return false" id="sn2" maxlength="50" value="<%=mlist.get(2).getSn() %>">
												<span class="error_span" id="material2"></span>
											</div>
											<div class="div_padding">
												<span class="table2_tr2_td2_span"><%=materialTypeArray[4] %>:</span>
												批次号：<input type="text" name="sn3" onkeydown="if(event.keyCode==32) return false" id="sn3" maxlength="50" value="<%=mlist.get(3).getSn() %>">
												<span class="error_span" id="material3"></span>
											</div>
											<div class="div_padding">
												<span class="table2_tr2_td2_span"><%=materialTypeArray[5] %>:</span>
												批次号：<input type="text" name="sn4" onkeydown="if(event.keyCode==32) return false" id="sn4" maxlength="50" value="<%=mlist.get(4).getSn() %>">
												<span class="error_span" id="material4"></span>
											</div>
											<div class="div_padding">
												<span class="table2_tr2_td2_span"><%=materialTypeArray[5] %>:</span>
												批次号：<input type="text" name="sn5" onkeydown="if(event.keyCode==32) return false" id="sn5" maxlength="50" value="<%=mlist.get(5).getSn() %>">
												<span class="error_span" id="material5"></span>
											</div>
										</td>
									</tr>
									<tr class="table2_tr7">
										<td class="table2_tr7_td1">
											测试报告
										</td>
										<td class="table2_tr7_td2">
										<div class="tr7_div1">
										<%if(file_path!=null){ %>
											<a class="img_a"
												href="javascript:void()" onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%></a>
											<%} %>
											</div>
											<div class="tr7_div1">
											<div id="section4" class="section-white8">
												<input type="file" name="file_list" id="file_input1"
												multiple="multiple">
											</div>
											<div class="section-white9">
												<span id="file_input1_error"></span>
											</div>
											</div>
										</td>
									</tr>
									<tr class="table2_tr6">
										<td class="table2_tr6_td1">
											状态
										</td>
										<td class="table2_tr6_td2">
											<span>是否合格&nbsp</span>
											<label><input name="qualify" type="radio" value="1" <%=device.getQualify()==1?"checked":""%>/>是</label>
											<label><input name="qualify" type="radio" value="2" <%=device.getQualify()==2?"checked":""%>/>否</label><br/>
										</td>
									</tr>
								</table>
								<div class="div_btn">
									<%if(operation==2&&isAlter){ %>
										<img src="images/submit_flow.png" class="fistbutton" onclick="addFlow();">
									<%} %>
									 <a href="javascript:history.back(-1)">
									 	<img src="images/returnback.png" class="btn_agree">
									 </a>
								</div>
							</div>
						</form>
					</td>
				</tr>
			</table>

		</div>
	</body>
</html>
