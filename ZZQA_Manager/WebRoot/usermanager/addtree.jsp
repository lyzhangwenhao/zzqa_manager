<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page
	import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
	+ request.getServerName() + ":" + request.getServerPort()
	+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
	.getRequiredWebApplicationContext(getServletContext())
	.getBean("userManager");
	Position_userManager position_userManager = (Position_userManager) WebApplicationContextUtils
	.getRequiredWebApplicationContext(getServletContext())
	.getBean("position_userManager");
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
	List<Position_user> posiList=position_userManager.getPositionOrderByparent();
	String[] permissionsArray=DataUtil.getPermissionsArray();
%>

<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">

<title>添加组织</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/top.css">
<link rel="stylesheet" type="text/css" href="css/usermanager.css">
<link rel="stylesheet" type="text/css" href="css/teamtree.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
<link rel="stylesheet" type="text/css" href="css/jquery.searchableSelect.css">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/dialog.js"></script>
<script type="text/javascript" src="js/public.js"></script>

<script type="text/javascript" src="js/jquery.searchableSelect.js"></script>
<!--
		<link rel="stylesheet" type="text/css" href="styles.css">
		-->
<script type="text/javascript">
	$(function() {
		var index = 1;
		$(".tree_row fieldset label :checkbox").each(function() {
			index=$(this).val();
			if (index == 7 || index == 8 || index == 39 || index == 41|| index == 43 || index == 44 || index == 46 
					|| index == 80 || index == 84|| index == 145|| index == 147 || index == 164) {
				$(this).prop("checked", true);
			}
			index++;
		});
		$("#select_parent").searchableSelect();
		$(".searchable-select").css("width","224px");
	});
	function checkPermissions() {
		var position_name = $("#position_name").val();
		if (position_name.length < 1) {
			initdiglog2("提示信息", "请输入组织名称！");
			return;
		}
		$.ajax({
			type : "post",//post方法
			url : "UserManagerServlet",
			timeout : 10000, //超时时间设置，单位毫秒
			data : {
				"type" : "checkPermissionName",
				"position_name" : position_name
			},
			//ajax成功的回调函数
			success : function(returnData) {
				if (returnData == 1) {
					addPermissions();
				} else if (returnData == 2){
					initdiglog2("提示信息", "该组织名称已存在，请修改后再试！");
				} else if (returnData == 3)  {
					var parent_id=$("#select_parent").next(".searchable-select").find(".searchable-select-item.selected").attr("data-value");
					if(parent_id!=0){
						addPermissions();
					}else{
						initdiglog2("提示信息", "最高职位只能有一个！");
					}
				}
			},
			complete : function(XMLHttpRequest, status) { //请求完成后最终执行参数
				if (status == 'timeout') {//超时,status还有success,error等值的情况
					initdiglog2("提示信息", "请求超时，请重试！");
				} else if (status == 'error') {
					initdiglog2("提示信息", "操作失败，请刷新页面后再试！");
				}
			}
		});
	}
	function addPermissions() {
		var parent_id=$("#select_parent").next(".searchable-select").find(".searchable-select-item.selected").attr("data-value");
		$("#parent").val(parent_id);
		var permissionsIDs = "";
		var canFinished=true;
		$("input[name='permission_id']:checked").each(function() {
			var pid=$(this).val();
			if(parent_id==0&&(pid==7||pid==8||pid==39||pid==57||pid==68||pid==52||pid==103||pid==145||pid==147)){
				initdiglog2("提示信息", "最高领导因无上级审批人，以下权限【新建请假单】、【新建出差单】、【新建销假单】、【新建销售合同】、【新建采购合同】、【新建状态跟踪表】、【工时统计新建权限】、【新建考核权限】、【新建出库权限】无效！");
				canFinished=false;
				return false;
			}
			if (permissionsIDs == "") {
				permissionsIDs = pid;
			} else {
				permissionsIDs += "の" + pid;
			}
		});
		if(!canFinished){
			return;
		}
		$("#permissionsIDs").val(permissionsIDs);
		document.userform.submit();
	}
</script>
</head>

<body>
	<jsp:include page="/top.jsp">
		<jsp:param name="name" value="<%=mUser.getName()%>" />
		<jsp:param name="level" value="<%=mUser.getLevel()%>" />
		<jsp:param name="index" value="3" />
	</jsp:include>
	<div class="div_center">
		<jsp:include page="/usermanager/userTab.jsp">
			<jsp:param name="index" value="4" />
		</jsp:include>
		<div class="div_center_right">
			<form action="UserManagerServlet?type=addPosition" method="post"
				name="userform">
				<input type="hidden" name="permissionsIDs" id="permissionsIDs">
				<input type="hidden" name="parent" id="parent">
				<div class="td2_div11">
					<div class="tree_title1_parent">
						<span class="tree_title1">组织名称：</span>
						<input type="text" name="position_name" id="position_name" maxlength="50">
						<input type="text" name="hidden_pname" style="display:none">
					</div>
					<div class="tree_title2_parent">
						<span class="tree_title2">上级组织：</span>
						<select id="select_parent">
							<option value="0">顶级组织</option>
							<%
								for (Position_user position_user : posiList) {
							%>
							<option value="<%=position_user.getId()%>"><%=position_user.getPosition_name()%></option>
							<%
								}
							%>
						</select>
					</div>
				</div>
				<div class="tree_title">权限分类</div>
				<div class="tree_div">
				<div class="tree_row">
					<div class="tree_task">
						<fieldset>
							<legend> 项目任务单 </legend>
							<div>
								<label><input type="checkbox" name="permission_id" value="1"><span class="tooltip_div"><%=permissionsArray[1]%></span></label>
								<label><input type="checkbox" name="permission_id" value="112"><span class="tooltip_div"><%=permissionsArray[112]%></span></label>
								<label><input type="checkbox" name="permission_id" value="10"><span class="tooltip_div"><%=permissionsArray[10]%></span></label>
								<label><input type="checkbox" name="permission_id" value="13"><span class="tooltip_div"><%=permissionsArray[13]%></span></label>
								<fieldset style="height: 160px;width: 385px;">
									<legend style="color: black;">商务助理审核权限</legend>
									<div>
										<label><input type="checkbox" name="permission_id" value="11"><span class="tooltip_div"><%=permissionsArray[11]%></span></label>
										<label><input type="checkbox" name="permission_id" value="55"><span class="tooltip_div"><%=permissionsArray[55]%></span></label>
										<label><input type="checkbox" name="permission_id" value="56"><span class="tooltip_div"><%=permissionsArray[56]%></span></label>
										<label><input type="checkbox" name="permission_id" value="109"><span class="tooltip_div"><%=permissionsArray[109]%></span></label>
										<label><input type="checkbox" name="permission_id" value="151"><span class="tooltip_div"><%=permissionsArray[151]%></span></label>
										<label><input type="checkbox" name="permission_id" value="169"><span class="tooltip_div"><%=permissionsArray[169]%></span></label>
									</div>
								</fieldset>
								<fieldset style="height: 160px;width: 385px;">
									<legend style="color: black;">任务单销售经理审核权限</legend>
									<div>
										<label><input type="checkbox" name="permission_id" value="48"><span class="tooltip_div"><%=permissionsArray[48]%></span></label>
										<label><input type="checkbox" name="permission_id" value="49"><span class="tooltip_div"><%=permissionsArray[49]%></span></label>
										<label><input type="checkbox" name="permission_id" value="51"><span class="tooltip_div"><%=permissionsArray[51]%></span></label>
										<label><input type="checkbox" name="permission_id" value="108"><span class="tooltip_div"><%=permissionsArray[108]%></span></label>
										<label><input type="checkbox" name="permission_id" value="150"><span class="tooltip_div"><%=permissionsArray[150]%></span></label>
										<label><input type="checkbox" name="permission_id" value="170"><span class="tooltip_div"><%=permissionsArray[170]%></span></label>
									</div>
								</fieldset>
								<fieldset style="height: 160px;width: 385px;">
									<legend style="color: black;">项目启动任务单权限</legend>
									<div>
										<label><input type="checkbox" name="permission_id" value="165"><span class="tooltip_div"><%=permissionsArray[165]%></span></label>
										<label><input type="checkbox" name="permission_id" value="160"><span class="tooltip_div"><%=permissionsArray[160]%></span></label>
										<label><input type="checkbox" name="permission_id" value="161"><span class="tooltip_div"><%=permissionsArray[161]%></span></label>
										<label><input type="checkbox" name="permission_id" value="162"><span class="tooltip_div"><%=permissionsArray[162]%></span></label>
										<label><input type="checkbox" name="permission_id" value="115"><span class="tooltip_div"><%=permissionsArray[115]%></span></label>
									</div>
								</fieldset>



								<label><input type="checkbox" name="permission_id" value="9"><span class="tooltip_div"><%=permissionsArray[9]%></span></label>
								<label><input type="checkbox" name="permission_id" value="110"><span class="tooltip_div"><%=permissionsArray[110]%></span></label>
								<label><input type="checkbox" name="permission_id" value="113"><span class="tooltip_div"><%=permissionsArray[113]%></span></label>
								<label><input type="checkbox" name="permission_id" value="114"><span class="tooltip_div"><%=permissionsArray[114]%></span></label>
								<label><input type="checkbox" name="permission_id" value="155"><span class="tooltip_div"><%=permissionsArray[155]%></span></label>
								<label><input type="checkbox" name="permission_id" value="50"><span class="tooltip_div"><%=permissionsArray[50]%></span></label>
								<label><input type="checkbox" name="permission_id" value="173"><span class="tooltip_div"><%=permissionsArray[173]%></span></label>
								<label><input type="checkbox" name="permission_id" value="171"><span class="tooltip_div"><%=permissionsArray[171]%></span></label>
								<label><input type="checkbox" name="permission_id" value="157"><span class="tooltip_div"><%=permissionsArray[157]%></span></label>
								<label><input type="checkbox" name="permission_id" value="158"><span class="tooltip_div"><%=permissionsArray[158]%></span></label>
								<label><input type="checkbox" name="permission_id" value="163"><span class="tooltip_div"><%=permissionsArray[163]%></span></label>
							</div>
						</fieldset>
					</div>
					<div class="tree_task">
					<fieldset>
					<legend>项目采购单</legend>
					<div>
						<label><input type="checkbox" name="permission_id" value="3"><span class="tooltip_div"><%=permissionsArray[3]%></span></label>
						<label><input type="checkbox" name="permission_id" value="18"><span class="tooltip_div"><%=permissionsArray[18]%></span></label>
						<label><input type="checkbox" name="permission_id" value="107"><span class="tooltip_div"><%=permissionsArray[107]%></span></label>
						<fieldset style="height: 190px;width: 385px;">
						<legend style="color: black;">预算单审核权限</legend>
						<div>
							<label><input type="checkbox" name="permission_id" value="14"><span class="tooltip_div"><%=permissionsArray[14]%></span></label>
							<label><input type="checkbox" name="permission_id" value="122"><span class="tooltip_div"><%=permissionsArray[122]%></span></label>
							<label><input type="checkbox" name="permission_id" value="123"><span class="tooltip_div"><%=permissionsArray[123]%></span></label>
							<label><input type="checkbox" name="permission_id" value="124"><span class="tooltip_div"><%=permissionsArray[124]%></span></label>
							<label><input type="checkbox" name="permission_id" value="152"><span class="tooltip_div"><%=permissionsArray[152]%></span></label>
							<label><input type="checkbox" name="permission_id" value="172"><span class="tooltip_div"><%=permissionsArray[172]%></span></label>
							<label><input type="checkbox" name="permission_id" value="167"><span class="tooltip_div"><%=permissionsArray[167]%></span></label>
						</div>
						</fieldset>

						<%-- <label><input type="checkbox" name="permission_id" value="15"><span class="tooltip_div"><%=permissionsArray[15]%></span></label>
						<label><input type="checkbox" name="permission_id" value="138"><span class="tooltip_div"><%=permissionsArray[138]%></span></label>
						<label><input type="checkbox" name="permission_id" value="139"><span class="tooltip_div"><%=permissionsArray[139]%></span></label>
						<label><input type="checkbox" name="permission_id" value="140"><span class="tooltip_div"><%=permissionsArray[140]%></span></label>
						<label><input type="checkbox" name="permission_id" value="153"><span class="tooltip_div"><%=permissionsArray[153]%></span></label> --%>


						<fieldset style="height: 190px;width: 385px;">
							<legend style="color: black;">预算单销售经理审核权限</legend>
							<div>
								<label><input type="checkbox" name="permission_id" value="174"><span class="tooltip_div"><%=permissionsArray[174]%></span></label>
								<label><input type="checkbox" name="permission_id" value="175"><span class="tooltip_div"><%=permissionsArray[175]%></span></label>
								<label><input type="checkbox" name="permission_id" value="176"><span class="tooltip_div"><%=permissionsArray[176]%></span></label>
								<label><input type="checkbox" name="permission_id" value="177"><span class="tooltip_div"><%=permissionsArray[177]%></span></label>
								<label><input type="checkbox" name="permission_id" value="178"><span class="tooltip_div"><%=permissionsArray[178]%></span></label>
								<label><input type="checkbox" name="permission_id" value="179"><span class="tooltip_div"><%=permissionsArray[179]%></span></label>
								<label><input type="checkbox" name="permission_id" value="180"><span class="tooltip_div"><%=permissionsArray[180]%></span></label>
							</div>
						</fieldset>

						<label><input type="checkbox" name="permission_id" value="16"><span class="tooltip_div"><%=permissionsArray[16]%></span></label>
						<label><input type="checkbox" name="permission_id" value="17"><span class="tooltip_div"><%=permissionsArray[17]%></span></label>
						<label><input type="checkbox" name="permission_id" value="21"><span class="tooltip_div"><%=permissionsArray[21]%></span></label>
						<label><input type="checkbox" name="permission_id" value="22"><span class="tooltip_div"><%=permissionsArray[22]%></span></label>
						<label><input type="checkbox" name="permission_id" value="2"><span class="tooltip_div"><%=permissionsArray[2]%></span></label>
						<label><input type="checkbox" name="permission_id" value="19"><span class="tooltip_div"><%=permissionsArray[19]%></span></label>
						<label><input type="checkbox" name="permission_id" value="164"><span class="tooltip_div"><%=permissionsArray[164]%></span></label>
						<label><input type="checkbox" name="permission_id" value="166"><span class="tooltip_div"><%=permissionsArray[166]%></span></label>
						<label><input type="checkbox" name="permission_id" value="181"><span class="tooltip_div"><%=permissionsArray[181]%></span></label>
						<label><input type="checkbox" name="permission_id" value="182"><span class="tooltip_div"><%=permissionsArray[182]%></span></label>
					</div>
					</fieldset>
					</div>
				</div>
				<div class="tree_row">
					<div class="tree_leave">
					<fieldset>
					<legend>请假流程</legend>
					<div>
						<label><input type="checkbox" name="permission_id" value="8"><span class="tooltip_div"><%=permissionsArray[8]%></span></label>
						<label><input type="checkbox" name="permission_id" value="28"><span class="tooltip_div"><%=permissionsArray[28]%></span></label>
						<label><input type="checkbox" name="permission_id" value="30"><span class="tooltip_div"><%=permissionsArray[30]%></span></label>
						<label><input type="checkbox" name="permission_id" value="36"><span class="tooltip_div"><%=permissionsArray[36]%></span></label>
						<label><input type="checkbox" name="permission_id" value="39"><span class="tooltip_div"><%=permissionsArray[39]%></span></label>
						<label><input type="checkbox" name="permission_id" value="40"><span class="tooltip_div"><%=permissionsArray[40]%></span></label>
					</div>
					</fieldset>
					</div>
					<div class="tree_leave">
					<fieldset>
					<legend> 出差流程</legend>
					<div>
						<label><input type="checkbox" name="permission_id" value="7"><span class="tooltip_div"><%=permissionsArray[7]%></span></label>
						<label><input type="checkbox" name="permission_id" value="29"><span class="tooltip_div"><%=permissionsArray[29]%></span></label>
						<label><input type="checkbox" name="permission_id" value="31"><span class="tooltip_div"><%=permissionsArray[31]%></span></label>
						<label><input type="checkbox" name="permission_id" value="32"><span class="tooltip_div"><%=permissionsArray[32]%></span></label>
						<label><input type="checkbox" name="permission_id" value="37"><span class="tooltip_div"><%=permissionsArray[37]%></span></label>
					</div>
					</fieldset>
					</div>
				</div>
				<div class="tree_row">
					<div class="tree_manufacture">
					<fieldset>
					<legend>生产流程</legend>
					<div>
						<label><input type="checkbox" name="permission_id" value="5"><span class="tooltip_div"><%=permissionsArray[5]%></span></label>
						<label><input type="checkbox" name="permission_id" value="25"><span class="tooltip_div"><%=permissionsArray[25]%></span></label>
						<label><input type="checkbox" name="permission_id" value="24"><span class="tooltip_div"><%=permissionsArray[24]%></span></label>
						<label><input type="checkbox" name="permission_id" value="33"><span class="tooltip_div"><%=permissionsArray[33]%></span></label>
						<label><input type="checkbox" name="permission_id" value="4"><span class="tooltip_div"><%=permissionsArray[4]%></span></label>
						<label><input type="checkbox" name="permission_id" value="20"><span class="tooltip_div"><%=permissionsArray[20]%></span></label>
						<label><input type="checkbox" name="permission_id" value="23"><span class="tooltip_div"><%=permissionsArray[23]%></span></label>
						<label><input type="checkbox" name="permission_id" value="136"><span class="tooltip_div"><%=permissionsArray[136]%></span></label>
						<label><input type="checkbox" name="permission_id" value="137"><span class="tooltip_div"><%=permissionsArray[137]%></span></label>
					</div>
					</fieldset>
					</div>
					<div class="tree_manufacture">
					<fieldset>
					<legend> 交流平台</legend>
					<div>
						<label><input type="checkbox" name="permission_id" value="41"><span class="tooltip_div"><%=permissionsArray[41]%></span></label>
						<label><input type="checkbox" name="permission_id" value="42"><span class="tooltip_div"><%=permissionsArray[42]%></span></label>
						<label><input type="checkbox" name="permission_id" value="43"><span class="tooltip_div"><%=permissionsArray[43]%></span></label>
						<label><input type="checkbox" name="permission_id" value="44"><span class="tooltip_div"><%=permissionsArray[44]%></span></label>
						<label><input type="checkbox" name="permission_id" value="45"><span class="tooltip_div"><%=permissionsArray[45]%></span></label>
						<label><input type="checkbox" name="permission_id" value="46"><span class="tooltip_div"><%=permissionsArray[46]%></span></label>
						<label><input type="checkbox" name="permission_id" value="47"><span class="tooltip_div"><%=permissionsArray[47]%></span></label>
					</div>
					</fieldset>
					</div>
				</div>
				<div class="tree_row">
					<div class="tree_contract">
					<fieldset>
					<legend>销售合同流程</legend>
					<div>
						<label><input type="checkbox" name="permission_id" value="57"><span class="tooltip_div"><%=permissionsArray[57]%></span></label>
						<label><input type="checkbox" name="permission_id" value="63"><span class="tooltip_div"><%=permissionsArray[63]%></span></label>
						<label><input type="checkbox" name="permission_id" value="59"><span class="tooltip_div"><%=permissionsArray[59]%></span></label>
						<label><input type="checkbox" name="permission_id" value="60"><span class="tooltip_div"><%=permissionsArray[60]%></span></label>
						<label><input type="checkbox" name="permission_id" value="61"><span class="tooltip_div"><%=permissionsArray[61]%></span></label>
						<label><input type="checkbox" name="permission_id" value="62"><span class="tooltip_div"><%=permissionsArray[62]%></span></label>
						<label><input type="checkbox" name="permission_id" value="58"><span class="tooltip_div"><%=permissionsArray[58]%></span></label>
						<label><input type="checkbox" name="permission_id" value="117"><span class="tooltip_div"><%=permissionsArray[117]%></span></label>
					</div>
					</fieldset>
					</div>
					<div class="tree_contract">
					<fieldset>
					<legend>采购合同平台</legend>
					<div>
						<label><input type="checkbox" name="permission_id" value="68"><span class="tooltip_div"><%=permissionsArray[68]%></span></label>
						<label><input type="checkbox" name="permission_id" value="69"><span class="tooltip_div"><%=permissionsArray[69]%></span></label>
						<label><input type="checkbox" name="permission_id" value="72"><span class="tooltip_div"><%=permissionsArray[72]%></span></label>
						<label><input type="checkbox" name="permission_id" value="73"><span class="tooltip_div"><%=permissionsArray[73]%></span></label>
						<label><input type="checkbox" name="permission_id" value="74"><span class="tooltip_div"><%=permissionsArray[74]%></span></label>
						<label><input type="checkbox" name="permission_id" value="75"><span class="tooltip_div"><%=permissionsArray[75]%></span></label>
						<label><input type="checkbox" name="permission_id" value="118"><span class="tooltip_div"><%=permissionsArray[118]%></span></label>
						<label><input type="checkbox" name="permission_id" value="119"><span class="tooltip_div"><%=permissionsArray[119]%></span></label>
						<label><input type="checkbox" name="permission_id" value="120"><span class="tooltip_div"><%=permissionsArray[120]%></span></label>
					</div>
					</fieldset>
					</div>
				</div>
				<div class="tree_row">
					<div class="tree_materials">
					<fieldset>
					<legend>资料库操作</legend>
					<div>
						<label><input type="checkbox" name="permission_id" value="67"><span class="tooltip_div"><%=permissionsArray[67]%></span></label>
						<label><input type="checkbox" name="permission_id" value="66"><span class="tooltip_div"><%=permissionsArray[66]%></span></label>
						<label><input type="checkbox" name="permission_id" value="65"><span class="tooltip_div"><%=permissionsArray[65]%></span></label>
						<label><input type="checkbox" name="permission_id" value="64"><span class="tooltip_div"><%=permissionsArray[64]%></span></label>
						<label><input type="checkbox" name="permission_id" value="71"><span class="tooltip_div"><%=permissionsArray[71]%></span></label>
						<label><input type="checkbox" name="permission_id" value="70"><span class="tooltip_div"><%=permissionsArray[70]%></span></label>
					</div>
					</fieldset>
					<fieldset>
					<legend> 系统权限</legend>
					<div>
						<label><input type="checkbox" name="permission_id" value="34"><span class="tooltip_div"><%=permissionsArray[34]%></span></label>
						<label><input type="checkbox" name="permission_id" value="35"><span class="tooltip_div"><%=permissionsArray[35]%></span></label>
						<label><input type="checkbox" name="permission_id" value="111"><span class="tooltip_div"><%=permissionsArray[111]%></span></label>
						<label><input type="checkbox" name="permission_id" value="116"><span class="tooltip_div"><%=permissionsArray[116]%></span></label>
					</div>
					</fieldset>
					</div>
					<div class="tree_ship">
					<fieldset>
					<legend> 发货流程</legend>
					<div>
						<label><input type="checkbox" name="permission_id" value="6"><span class="tooltip_div"><%=permissionsArray[6]%></span></label>
						<label><input type="checkbox" name="permission_id" value="26"><span class="tooltip_div"><%=permissionsArray[26]%></span></label>
						<label><input type="checkbox" name="permission_id" value="27"><span class="tooltip_div"><%=permissionsArray[27]%></span></label>
						<label><input type="checkbox" name="permission_id" value="154"><span class="tooltip_div"><%=permissionsArray[154]%></span></label>
					</div>
					</fieldset>
					<fieldset>
					<legend>状态跟踪流程</legend>
					<div>
						<label><input type="checkbox" name="permission_id" value="52"><span class="tooltip_div"><%=permissionsArray[52]%></span></label>
						<label><input type="checkbox" name="permission_id" value="54"><span class="tooltip_div"><%=permissionsArray[54]%></span></label>
					</div>
					</fieldset>
					</div>
				</div>
				<div class="tree_row">
					<div class="tree_vehicle">
					<fieldset>
					<legend> 售后任务单流程</legend>
					<div>
						<label><input type="checkbox" name="permission_id" value="76"><span class="tooltip_div"><%=permissionsArray[76]%></span></label>
						<label><input type="checkbox" name="permission_id" value="77"><span class="tooltip_div"><%=permissionsArray[77]%></span></label>
						<label><input type="checkbox" name="permission_id" value="130"><span class="tooltip_div"><%=permissionsArray[130]%></span></label>
						<label><input type="checkbox" name="permission_id" value="131"><span class="tooltip_div"><%=permissionsArray[131]%></span></label>
						<label><input type="checkbox" name="permission_id" value="132"><span class="tooltip_div"><%=permissionsArray[132]%></span></label>
						<label><input type="checkbox" name="permission_id" value="143"><span class="tooltip_div"><%=permissionsArray[143]%></span></label>
						<label><input type="checkbox" name="permission_id" value="78"><span class="tooltip_div"><%=permissionsArray[78]%></span></label>
						<label><input type="checkbox" name="permission_id" value="133"><span class="tooltip_div"><%=permissionsArray[133]%></span></label>
						<label><input type="checkbox" name="permission_id" value="134"><span class="tooltip_div"><%=permissionsArray[134]%></span></label>
						<label><input type="checkbox" name="permission_id" value="135"><span class="tooltip_div"><%=permissionsArray[135]%></span></label>
						<label><input type="checkbox" name="permission_id" value="144"><span class="tooltip_div"><%=permissionsArray[144]%></span></label>
						<label><input type="checkbox" name="permission_id" value="79"><span class="tooltip_div"><%=permissionsArray[79]%></span></label>
					</div>
					</fieldset>
					<fieldset>
					<legend> 用车申请流程</legend>
					<div>
						<label><input type="checkbox" name="permission_id" value="80"><span class="tooltip_div"><%=permissionsArray[80]%></span></label>
						<label><input type="checkbox" name="permission_id" value="81"><span class="tooltip_div"><%=permissionsArray[81]%></span></label>
						<label><input type="checkbox" name="permission_id" value="82"><span class="tooltip_div"><%=permissionsArray[82]%></span></label>
						<label><input type="checkbox" name="permission_id" value="83"><span class="tooltip_div"><%=permissionsArray[83]%></span></label>
						<label><input type="checkbox" name="permission_id" value="168"><span class="tooltip_div"><%=permissionsArray[168]%></span></label>
					</div>
					</fieldset>
					</div>
					<div class="tree_seal">
					<fieldset>
					<legend>用印申请流程</legend>
					<div>
						<label><input type="checkbox" name="permission_id" value="84"><span class="tooltip_div"><%=permissionsArray[84]%></span></label>
						<label><input type="checkbox" name="permission_id" value="85"><span class="tooltip_div"><%=permissionsArray[85]%></span></label>
						<label><input type="checkbox" name="permission_id" value="86"><span class="tooltip_div"><%=permissionsArray[86]%></span></label>
						<label><input type="checkbox" name="permission_id" value="87"><span class="tooltip_div"><%=permissionsArray[87]%></span></label>
						<label><input type="checkbox" name="permission_id" value="88"><span class="tooltip_div"><%=permissionsArray[88]%></span></label>
						<label><input type="checkbox" name="permission_id" value="89"><span class="tooltip_div"><%=permissionsArray[89]%></span></label>
						<label><input type="checkbox" name="permission_id" value="90"><span class="tooltip_div"><%=permissionsArray[90]%></span></label>
						<label><input type="checkbox" name="permission_id" value="91"><span class="tooltip_div"><%=permissionsArray[91]%></span></label>
						<label><input type="checkbox" name="permission_id" value="92"><span class="tooltip_div"><%=permissionsArray[92]%></span></label>
						<label><input type="checkbox" name="permission_id" value="159"><span class="tooltip_div"><%=permissionsArray[159]%></span></label>
						<label><input type="checkbox" name="permission_id" value="93"><span class="tooltip_div"><%=permissionsArray[93]%></span></label>
						<label><input type="checkbox" name="permission_id" value="94"><span class="tooltip_div"><%=permissionsArray[94]%></span></label>
						<label><input type="checkbox" name="permission_id" value="95"><span class="tooltip_div"><%=permissionsArray[95]%></span></label>
						<label><input type="checkbox" name="permission_id" value="121"><span class="tooltip_div"><%=permissionsArray[121]%></span></label>
						<label><input type="checkbox" name="permission_id" value="106"><span class="tooltip_div"><%=permissionsArray[106]%></span></label>
						<label><input type="checkbox" name="permission_id" value="141"><span class="tooltip_div"><%=permissionsArray[141]%></span></label>
						<label><input type="checkbox" name="permission_id" value="142"><span class="tooltip_div"><%=permissionsArray[142]%></span></label>
						<label><input type="checkbox" name="permission_id" value="156"><span class="tooltip_div"><%=permissionsArray[156]%></span></label>
						<label><input type="checkbox" name="permission_id" value="96"><span class="tooltip_div"><%=permissionsArray[96]%></span></label>
						<label><input type="checkbox" name="permission_id" value="97"><span class="tooltip_div"><%=permissionsArray[97]%></span></label>
						<label><input type="checkbox" name="permission_id" value="98"><span class="tooltip_div"><%=permissionsArray[98]%></span></label>
						<label><input type="checkbox" name="permission_id" value="99"><span class="tooltip_div"><%=permissionsArray[99]%></span></label>
						<label><input type="checkbox" name="permission_id" value="100"><span class="tooltip_div"><%=permissionsArray[100]%></span></label>
						<label><input type="checkbox" name="permission_id" value="101"><span class="tooltip_div"><%=permissionsArray[101]%></span></label>
						<label><input type="checkbox" name="permission_id" value="102"><span class="tooltip_div"><%=permissionsArray[102]%></span></label>
					</div>
					</fieldset>
					</div>
				</div>
				<div class="tree_row">
					<div class="tree_shipping">
					<fieldset>
					<legend> 工时统计流程</legend>
					<div>
						<label><input type="checkbox" name="permission_id" value="103"><span class="tooltip_div"><%=permissionsArray[103]%></span></label>
						<label><input type="checkbox" name="permission_id" value="104"><span class="tooltip_div"><%=permissionsArray[104]%></span></label>
						<label><input type="checkbox" name="permission_id" value="105"><span class="tooltip_div"><%=permissionsArray[105]%></span></label>
					</div>
					</fieldset>
					</div>
					<div class="tree_shipping">
					<fieldset>
					<legend>出货流程</legend>
					<div>
						<label><input type="checkbox" name="permission_id" value="125"><span class="tooltip_div"><%=permissionsArray[125]%></span></label>
						<label><input type="checkbox" name="permission_id" value="126"><span class="tooltip_div"><%=permissionsArray[126]%></span></label>
						<label><input type="checkbox" name="permission_id" value="127"><span class="tooltip_div"><%=permissionsArray[127]%></span></label>
						<label><input type="checkbox" name="permission_id" value="128"><span class="tooltip_div"><%=permissionsArray[128]%></span></label>
						<label><input type="checkbox" name="permission_id" value="129"><span class="tooltip_div"><%=permissionsArray[129]%></span></label>
					</div>
					</fieldset>
					</div>
				</div>
				<div class="tree_row">
					<div class="tree_performance">
					<fieldset>
					<legend> 考核流程</legend>
					<div>
						<label><input type="checkbox" name="permission_id" value="145"><span class="tooltip_div"><%=permissionsArray[145]%></span></label>
						<label><input type="checkbox" name="permission_id" value="146"><span class="tooltip_div"><%=permissionsArray[146]%></span></label>
					</div>
					</fieldset>
					</div>
					<div class="tree_performance">
					<fieldset>
					<legend> 出库流程</legend>
					<div>
						<label><input type="checkbox" name="permission_id" value="147"><span class="tooltip_div"><%=permissionsArray[147]%></span></label>
						<label><input type="checkbox" name="permission_id" value="148"><span class="tooltip_div"><%=permissionsArray[148]%></span></label>
						<label><input type="checkbox" name="permission_id" value="149"><span class="tooltip_div"><%=permissionsArray[149]%></span></label>
					</div>
					</fieldset>
					</div>
				</div>
			</div>
			
			<div class="div_btn">
				<img src="images/add_permissions.png" class="btn_agree1"
					onclick="checkPermissions();">
			</div>
		</form>
	</div>
</div>
</body>
</html>
