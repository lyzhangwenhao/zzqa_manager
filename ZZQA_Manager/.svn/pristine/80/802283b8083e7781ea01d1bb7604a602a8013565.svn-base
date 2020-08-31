<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page
	import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%
	request.setCharacterEncoding("UTF-8");
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
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>新建生产流程</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/top.css">
<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
<link rel="stylesheet" type="text/css"
	href="css/create_manufactureflow.css">
<link rel="stylesheet" type="text/css" href="css/custom.css">
		<link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
		<link rel="stylesheet" type="text/css" href="css/default.css">
		<link rel="stylesheet" type="text/css"
			href="css/jquery.filer-dragdropbox-theme.css">
		<link rel="stylesheet" type="text/css"
			href="css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<link rel="stylesheet" href="css/bootstrap/bootstrap.min.css">
		
		<script src="js/showdate.js" type="text/javascript"></script>
		<script src="js/prettify.js" type="text/javascript"></script>
		<script src="js/jquery.min.js" type="text/javascript"></script>
		<script src="js/jquery.filer.min.js" type="text/javascript"></script>
		<script src="js/custom.js" type="text/javascript"></script>
		
		<script src="js/modernizr.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/vendor/tabcomplete.min.js"></script>
		<script src="js/vendor/livefilter.min.js"></script>
		<script src="js/vendor/src/bootstrap-select.js"></script>
		<script src="js/vendor/src/filterlist.js"></script>
		<script src="js/plugins.js"></script>
		<script  type="text/javascript" src="js/jquery-ui.min.js"></script><!-- 必须放后面，否则无法显示dialog的叉叉 -->
		<script  type="text/javascript" src="js/dialog.js"></script>
		<script src="js/public.js"></script>
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript">
			function addNum(){
				if($("#task_id_input").val().length<1){
        			initdiglog2("提示信息","请选择项目任务单!");
        			return;
    			}
				document.flowform.task_id.value=$("#task_id_input").val();
				var num=document.flowform.num.value;
				if(num.length==0&&num==0){
					initdiglog2("提示信息","请输入设备台数!");
					return;
				}
				document.flowform.submit();
			}
			function setTime(time,obj){
		    	//修改time的时间
		    	if(compareTime1("<%=DataUtil.getTadayStr()%>", time)) {
					obj.value = time;
				} else {
					initdiglogtwo2("提示信息", "计划时间早于当前时间，请确认输入无误？");
					$("#confirm2").click(function() {
						$("#twobtndialog").dialog("close");
						obj.value = time;
						Lock_CheckForm();
					});
				}
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
					<jsp:param name="index" value="3" />
				</jsp:include>
				<td class="table_center_td2">
					<form
						action="FlowManagerServlet?type=addmanufactureflow&uid=<%=mUser.getId()%>"
						method="post" name="flowform">
						<div class="td2_div">
							<div class="td2_div1">生产单</div>
							<table class="td2_table0">
								<tr class="table0_tr1">
										<td class="table0_tr1_td1"><span class="star">*</span>关联任务单</td>
										<td class="table0_tr1_td2" >
											<div id="section4" class="section-white5">
												<jsp:include page="/flowmanager/drop_down.jsp" />
												<input type="hidden" name="task_id" value="">
											</div>
											<div class="section-white6">
												<span id="select_task_error"></span>
											</div>
											
										</td>
									</tr>
								<tr class="table0_tr1">
									<td class="table0_tr1_td1"><span class="star">*</span>设备台数
									</td>
									<td class="table0_tr1_td2"><input type="text" name="num" class="table0_input"
										 oninput="checkIntPosition(this)" maxlength="9"></td>
								</tr>
								<tr class="table0_tr1">
									<td class="table0_tr1_td1"><span class="star">*</span>计划完成时间
									</td>
									<td class="table0_tr1_td2"><input type="text" id="time" class="table0_input"
										name="predict_time" value="<%=DataUtil.getTadayStr()%>"
										onClick="return Calendar('time');" readonly="readonly" /></td>
								</tr>
							</table>
							<div class="div_btn">

								<img src="images/complete.png" class="btn_agree"
									onclick="addNum();"> <a
									href="flowmanager/newflow.jsp"><img
									src="images/goprocurement.png" class="btn_disagree" onclick=""></a>
							</div>
						</div>
					</form>
				</td>
			</tr>
		</table>

	</div>
</body>
</html>
