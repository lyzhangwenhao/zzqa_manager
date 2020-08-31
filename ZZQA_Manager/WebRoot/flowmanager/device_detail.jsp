<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.device.DeviceManager"%>
<%@page import="com.zzqa.pojo.device.Device"%>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page import="com.zzqa.service.interfaces.material.MaterialManager"%>
<%@page import="com.zzqa.pojo.material.Material"%>
<%@page import="com.zzqa.pojo.file_path.File_path"%>
<%@page import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
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
	FlowManager flowManager = (FlowManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("flowManager");
	Position_userManager position_userManager=(Position_userManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("position_userManager");
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
		response.sendRedirect("../login.jsp");
		return;
	}
	int device_id=(Integer)session.getAttribute("device_id");
	Device device=deviceManager.getDeviceByID(device_id);
	List<Material> mlist=materialManager.getMaterialList(device_id);
	File_path file_path=device.getFile_path();
	int operation=flowManager.getNewFlowByFID(5,device.getM_id()).getOperation();
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
			href="css/device_detail.css">
		<script src="js/jquery.min.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
 		<script  type="text/javascript" src="js/jquery-ui.min.js"></script>
 		<script  type="text/javascript" src="js/dialog.js"></script>
 		<script  type="text/javascript" src="js/public.js"></script>
 		
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
			function deleteDevice(id){
		   		initdiglogtwo2("提示信息","你确定要删除该设备吗？");
		   		$( "#confirm2" ).click(function() {
					$( "#twobtndialog" ).dialog( "close" );
					$.ajax({
						type:"post",//post方法
						url:"CheckServlet",
						data:{"type":"delDevice","ID":id,"uid":<%=uid%>},
						//ajax成功的回调函数
						success:function(returnData){
							window.location.href="FlowManagerServlet?type=flowdetail&flowtype=5&id="+"<%=device.getM_id()%>";
						}
					});
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
						<jsp:param name="index" value="0" />
					</jsp:include>
					<td class="table_center_td2">
						<form
							action="FlowManagerServlet?type=updatedevice&uid=<%=mUser.getId()%>&device_id=<%=device_id %>"
							method="post" name="flowform" enctype="multipart/form-data">
							<div class="td2_div">
								<div class="td2_div1">
									设备详情
								</div>
								<table class="td2_table2">
									<tr class="table2_tr1">
										<td class="table2_tr1_td1">
											ID
										</td>
										<td class="table2_tr1_td2">
											<%=device.getIdStr() %>
										</td>
									</tr>
									<tr class="table2_tr1">
										<td class="table2_tr1_td1">
											批次号SN
										</td>
										<td class="table2_tr1_td2">
											<%=device.getSn() %>
										</td>
									</tr>
									<tr class="table2_tr2">
										<td class="table2_tr2_td1">
											所需器皿
										</td>
										<td class="table2_tr2_td2">
										<%int mlen=mlist.size();for(int i=0;i<mlen;i++){%>
										<span class="table2_span_left"><%=materialTypeArray[i+1] %>:</span>
											<span class="table2_span_right"><%="批次号："+mlist.get(i).getSn()%></span><br/>
										<%} %>
										</td>
									</tr>
									<tr class="table2_tr7">
										<td class="table2_tr7_td1">
											测试报告
										</td>
										<td class="table2_tr7_td2">
										<%if(file_path!=null){ %>
											<a class="img_a" href="javascript:void()" onclick="fileDown(<%=file_path.getId()%>)"
											><%=file_path.getFile_name()%></a>
											<%} %>
										</td>
									</tr>
									<tr class="table2_tr6">
										<td class="table2_tr6_td1">
											状态
										</td>
										<td class="table2_tr6_td2">
											<%=DataUtil.getQualifyArray()[device.getQualify()] %>
										</td>
									</tr>
								</table>
								<div class="div_btn">
									<%
										if (operation==2&&isAlter) {
									%>
									<a href="FlowManagerServlet?type=flowdetail&flowtype=11&id=<%=device_id %>"><img src="images/alter_flow.png" class="fistbutton"></a>
									<img class="fistbutton" src="images/delete_device.png" onclick="deleteDevice(<%=device.getId() %>)" >
									<%
										}
									%>
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
