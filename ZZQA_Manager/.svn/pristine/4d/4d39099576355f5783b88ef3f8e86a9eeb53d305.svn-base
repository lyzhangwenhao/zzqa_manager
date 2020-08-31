<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	PermissionsManager permissionsManager=(PermissionsManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("permissionsManager");
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
	List<User> users=new ArrayList<User>();
	boolean canWatch="admin".equals(mUser.getName())||permissionsManager.checkPermission(mUser.getPosition_id(), 146);
	if(canWatch){
		users=userManager.getUserListByPermissionsID(145);
	}else{
		users=userManager.getSonListByParentUid(mUser.getPosition_id());
		if(permissionsManager.checkPermission(mUser.getPosition_id(), 145)){
			users.add(mUser);
		}
	}
	String[] departmentArray=DataUtil.getdepartment();
	
	int year_report=DataUtil.getCurrentYear();
	int maxYear=year_report+1;//能算到下一年
	int month_report=DataUtil.getCurrentMonth(); 
	if (session.getAttribute("year_report") != null) {
		year_report = (Integer)session.getAttribute("year_report");
	}
	if (session.getAttribute("month_report") != null) {
		month_report= (Integer)session.getAttribute("month_report");
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<title>考核统计</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="rendere" content="webkit|ie-comp|ie-stand">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/performance_report.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<link rel="stylesheet" href="css/bootstrap/bootstrap.min.css">
		<link rel="stylesheet" type="text/css" href="css/statistical.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		<script type="text/javascript" src="js/showdate1.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		<script type="text/javascript" src="js/performance_report.js"></script>
		
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
		var usersArray=[<%int user_len=users.size();for(int i=0;i<user_len;i++){User user=users.get(i);
			if(i==0){
				out.write("["+user.getId()+",'"+user.getTruename()+"']");
			}else{
				out.write(",["+user.getId()+",'"+user.getTruename()+"']");
			}
		}%>];
		var departmentArray=[<%int len=departmentArray.length;for(int i=0;i<len;i++){
			if(i>0){
				out.write(",'"+departmentArray[i]+"'");
			}
			else if(i==3){
				continue;
			}
			else{
				out.write("'"+departmentArray[i]+"'");
			}			
		}%>];//部门列表
		
		var arr_quotiety=["","A+","A","A-","B+","B","B-","C+","C","C-","D+","D","D-"];
		var arr_level=["第一档","第二档","第三档"];
		
		/**搜索条件**/
		var department_index = 0;//部门id
		var create_id = 0;//员工id
		var begin_time;//开始时间（月初时间戳）
		var end_time;//结束时间（月初时间戳）
		var begin_year=<%=year_report%>;
		var end_year=<%=year_report%>;
		var begin_month=<%=month_report%>;
		var end_month=<%=month_report%>;
		var staff_name="";
		
		var arr_month=[];//月份表（月初时间戳）
		var arr_data=[];//绩效表数据
		
		var arr_users_unsubmit=[];//未提交考核的用户
		
		/**初始化函数**/
		$(function(){
			var department_html='';
			$(departmentArray).each(function(i){
				department_html+='<option value="'+i+'">'+this+'</option>';
			});
			$("#sel_department").html(department_html);
			$("#sel_department").val(department_index);
			$("#sel_department").attr("title",departmentArray[department_index]);
	    });
		
		</script>
	</head>

	<body>
		<jsp:include page="/top.jsp" >
	<jsp:param name="name" value="<%=mUser.getName() %>" />
	<jsp:param name="level" value="<%=mUser.getLevel() %>" />
	<jsp:param name="index" value="2" />
	</jsp:include>
		<div class="td1_work">
			<div class="td1_div0">
				考核统计表
			</div>
			<div class="div_user">
				<div class="div_row1" style="width:24%">
					<span>所属部门：</span>
					<select id="sel_department" name="sel_department" onchange="onDepartmentChange()"></select>
				</div>
				<div class="div_row1" style="width:40%">
					<div class="btn-group">
						时间：
					</div>
					<div class="btn-group btn-group1">
						<button id="btn_begin_year" type="button" class="btn btn-primary" onclick="choseReport(begin_year,begin_month,this,1)"><%=year_report %>年</button>
						<div class="between-div"></div>
						<button type="button" class="btn btn-primary dropdown-toggle" 
								data-toggle="dropdown">
							<span class="caret"></span>
							<span class="sr-only">切换年份</span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<%for(int i=2016;i<=maxYear;i++){ %>
							<li><a href="javascript:void(0)" onclick="choseReport(<%=i%>,begin_month,this,1)"><%=i%>年</a></li>
							<%} %>
						</ul>
					</div>
					<div class="btn-group btn-group1">
						<button id="btn_begin_month" type="button" class="btn btn-primary" onclick="choseReport(begin_year,begin_month,this,1)"><%=month_report %>月</button>
						<div class="between-div"></div>
						<button type="button" class="btn btn-primary dropdown-toggle" 
								data-toggle="dropdown">
							<span class="caret"></span>
							<span class="sr-only">切换月份</span>
						</button>
						<ul class="dropdown-menu" role="menu">
						<%for(int i=1;i<13;i++){ %>
							<li><a href="javascript:void(0)" onclick="choseReport(begin_year,<%=i%>,this,1)"><%=i%>月</a></li>
							<%} %>
						</ul>
					</div>
					<div class="btn-group btn-group1" style="width:2em;">
						
					</div>				
					<div class="btn-group btn-group1">
						<button id="btn_end_year" type="button" class="btn btn-primary" onclick="choseReport(end_year,end_month,this,2)"><%=year_report %>年</button>
						<div class="between-div"></div>
						<button type="button" class="btn btn-primary dropdown-toggle" 
								data-toggle="dropdown">
							<span class="caret"></span>
							<span class="sr-only">切换年份</span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<%for(int i=2016;i<=maxYear;i++){ %>
							<li><a href="javascript:void(0)" onclick="choseReport(<%=i%>,end_month,this,2)"><%=i%>年</a></li>
							<%} %>
						</ul>
					</div>
					<div class="btn-group btn-group1">
						<button id="btn_end_month" type="button" class="btn btn-primary" onclick="choseReport(end_year,end_month,this,2)"><%=month_report %>月</button>
						<div class="between-div"></div>
						<button type="button" class="btn btn-primary dropdown-toggle" 
								data-toggle="dropdown">
							<span class="caret"></span>
							<span class="sr-only">切换月份</span>
						</button>
						<ul class="dropdown-menu" role="menu">
						<%for(int i=1;i<13;i++){ %>
							<li><a href="javascript:void(0)" onclick="choseReport(end_year,<%=i%>,this,2)"><%=i%>月</a></li>
							<%} %>
						</ul>
					</div>
				</div>				
				<div class="div_row1" style="width:20%">
					<span>员工姓名：</span>
					<input id="ipt_staff_name" class="ipt_row1" name="ipt_staff_name" oninput="onStaffChange()">
				</div>
				<div class="control_bottom" style="width:10%">
					<div class="div_button" style="background-color:#41c651" onclick="onSearch()">搜索</div>
					<img class="img_button" title="导出表格" src="images/export_track.png" onclick="onExportTrack();">					
				</div>
			</div>
			<div id="work_detail_report">				
				<div class="workreport_div" id="workreport_div">
					<table class="tab_table" id="tab_table">
						
					</table>
				</div>
			</div>
		</div>
		
		
		
	</body>
</html>
