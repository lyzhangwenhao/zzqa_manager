<%@page import="org.aspectj.weaver.Iterators.Getter"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page
	import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page
	import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page
	import="com.zzqa.service.interfaces.work.WorkManager"%>
	<%@page import="com.zzqa.pojo.work.Work"%>
<%@page import="com.zzqa.pojo.project.Project"%>
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
	WorkManager workManager=(WorkManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("workManager");
	PermissionsManager permissionsManager=(PermissionsManager)WebApplicationContextUtils
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
	long workmonth =0;
	if (session.getAttribute("workmonth") != null) {
		workmonth = (Long) session.getAttribute("workmonth");
		session.removeAttribute("workmonth");
	}else{
		Calendar calendar=Calendar.getInstance();
		workmonth=new SimpleDateFormat("yyyy-M-dd").parse(calendar.get(Calendar.YEAR)+"-"+(calendar.get(Calendar.MONTH)+1)+"-1").getTime();
	}
	Work w=workManager.getWorkByMonthAndUID2(workmonth, uid);
	if(w!=null){
		session.setAttribute("work_id", w.getId());
		response.sendRedirect("workflow_detail.jsp");
		return;
	}else{
		session.removeAttribute("workmonth");//由详情页跳转到指定月份，刷新不需要保留
	}
	List<Project> projects=workManager.getProjects();
	boolean hasPM=permissionsManager.checkPermission(mUser.getPosition_id(), 105);//项目管理权限
	pageContext.setAttribute("hasPM",hasPM);
	pageContext.setAttribute("projects", projects);
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>创建工时统计表</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/top.css">
<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
<link rel="stylesheet" type="text/css" href="css/workflow.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
<script src="js/jquery.min.js" type="text/javascript"></script>
<script  type="text/javascript" src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/dialog.js"></script>
<script type="text/javascript" src="js/public.js"></script>
<script type="text/javascript" src="js/work.js"></script>
<!--[if IE]>
			<script src="js/html5shiv.min.js" type="text/javascript"></script>
		<![endif]-->
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript">
	var uid=<%=mUser.getId()%>;
	var create_id=<%=mUser.getId()%>;//本人
	var canAlter=false;//是否可修改
	var isparent=false;
	var canApprove=false;
	var createNow=true;
	var projectArray=[
			<%for(int i=0,plen=projects.size();i<plen;i++){Project project=projects.get(i);
				if(i>0){
					out.write(",");
				}
				out.write("["+project.getId()+",'"+project.getProject_name()+"',"+true+"]");
			}%>
	        ];
	$(function(){
		initSelect(new Date(<%=workmonth%>));
		$(".work_date>div").click(function(event){
			event.stopPropagation();//防止冒泡
			if(stopTop){
				stopTop=!stopTop;
				return;
			}
			recoverBgColor();
			selectedIndex=parseInt($(this).attr('id').replace("date",""));
			//if(monthArray[selectedIndex-1][1]){
			if($(this).css("cursor")=="pointer"){
				$(this).css("background","#D1EEFF");
				showWorkSetDialog(parseInt($(this).find("div").text()));
			}else{
				selectedIndex=-1;//不可点击
			}
		});
		$(".work_time select").change(function(){
			initTime();
		});
		$("body").click(function(){
			recoverBgColor();
		});
	});
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
				<td class="table_center_td2_full">
					<form
						action="FlowManagerServlet?type=addflow"
						method="post" name="flowform">
						<input type="hidden" name="data">
						<div class="td2_div">
							<div class="td2_div1">工时统计安排表</div>
							<div class="work_time">
							<c:if test="${hasPM}">
							<div class="pm_div" onclick="showPMDialog();">
									项目管理
								</div>
							</c:if>
								<div>
									<select id="work_year" name="work_year">
									</select> 年
								</div>
								<div>
									<select id="work_month" name="work_month">
									</select> 月
								</div>
							</div>
							<div class="work_week">
								<div>周日</div>
								<div>周一</div>
								<div>周二</div>
								<div>周三</div>
								<div>周四</div>
								<div>周五</div>
								<div>周六</div>
							</div>
							<div class="work_date">
								<div id="date1"><div></div></div>
								<div id="date2"><div></div></div>
								<div id="date3"><div></div></div>
								<div id="date4"><div></div></div>
								<div id="date5"><div></div></div>
								<div id="date6"><div></div></div>
								<div id="date7"><div></div></div>
							</div>
							<div class="work_date">
								<div id="date8"><div></div></div>
								<div id="date9"><div></div></div>
								<div id="date10"><div></div></div>
								<div id="date11"><div></div></div>
								<div id="date12"><div></div></div>
								<div id="date13"><div></div></div>
								<div id="date14"><div></div></div>
							</div>
							<div class="work_date">
								<div id="date15"><div></div></div>
								<div id="date16"><div></div></div>
								<div id="date17"><div></div></div>
								<div id="date18"><div></div></div>
								<div id="date19"><div></div></div>
								<div id="date20"><div></div></div>
								<div id="date21"><div></div></div>
							</div>
							<div class="work_date">
								<div id="date22"><div></div></div>
								<div id="date23"><div></div></div>
								<div id="date24"><div></div></div>
								<div id="date25"><div></div></div>
								<div id="date26"><div></div></div>
								<div id="date27"><div></div></div>
								<div id="date28"><div></div></div>
							</div>
							<div class="work_date">
								<div id="date29"><div></div></div>
								<div id="date30"><div></div></div>
								<div id="date31"><div></div></div>
								<div id="date32"><div></div></div>
								<div id="date33"><div></div></div>
								<div id="date34"><div></div></div>
								<div id="date35"><div></div></div>
							</div>
							<div class="work_date">
								<div id="date36"><div></div></div>
								<div id="date37"><div></div></div>
								<div id="date38"><div></div></div>
								<div id="date39"><div></div></div>
								<div id="date40"><div></div></div>
								<div id="date41"><div></div></div>
								<div id="date42"><div></div></div>
							</div>
						</div>
					</form>
				</td>
			</tr>
		</table>
	</div>
	<div class="dialog_pm">
		<div class="dialog_pm_title">
			<div>项目管理</div>
			<div title="关闭" onclick="closePMDialog()"></div>
		</div>
		<div class="dialog_pm_list">
		</div>
		<div class="dialog_pm_btns">
			<div onclick="addProject()">添 加</div>
			<div onclick="saveProject()">提 交</div>
			<div onclick="canclePMDialog()">取 消</div>
		</div>
	</div>
	<div class="dialog_workday">
		<div class="dialog_workday_title">
			<div title="关闭" onclick="closeWorkSetDialog()"></div>
		</div>
		<div class="dialog_workday_date">日期：2017/16/11</div>
		<div class="dialog_workday_list">
		</div>
		<div class="dialog_workday_content">
			<div>内容：</div>
			<textarea maxlength="1000"></textarea>
			<div></div>
			<div class="clearfloat_div"></div>
		</div>
		<div class="dialog_workday_remark">
			<div>批注：</div>
			<textarea maxlength="1000"></textarea>
			<div></div>
			<div class="clearfloat_div"></div>
		</div>
		<div class="dialog_workday_btns">
			<div onclick="saveWorkDayProject()">提 交</div>
		</div>
	</div>
</body>
</html>
