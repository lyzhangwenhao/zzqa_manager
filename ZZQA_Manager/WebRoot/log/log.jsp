<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.operation.OperationManager"%>
<%@page import="com.zzqa.pojo.operation.Operation"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	OperationManager operationManager = (OperationManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("operationManager");
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
	String keywords_log = null;
	if (session.getAttribute("keywords_log") != null) {
		keywords_log = (String) session.getAttribute("keywords_log");
	}else{
		keywords_log = new String("");
	}
	int nowpage_log = 1;
	if (session.getAttribute("nowpage_log") != null) {
		nowpage_log = Integer.parseInt((String) session
				.getAttribute("nowpage_log"));
	}
	String name_log = null;
	if (session.getAttribute("name_log") != null) {
		name_log = (String) session.getAttribute("name_log");
	}else{
		name_log=new String("");
	}
	int newtime_log = 0;
	if (session.getAttribute("newtime_log") != null) {
		newtime_log = (Integer) session.getAttribute("newtime_log");
	}
	String startDate = DataUtil.getYearStr();
	String starttime_log = startDate;
	if (newtime_log == 1
			&& session.getAttribute("starttime_log") != null) {
		starttime_log = (String) session.getAttribute("starttime_log");
	}
	String nowDate = DataUtil.getTadayStr();
	String endtime_log = nowDate;
	if (newtime_log == 1 && session.getAttribute("endtime_log") != null) {
		endtime_log = (String) session.getAttribute("endtime_log");
	}
	String[] flowTypeArray = DataUtil.getFlowTypeArray();
	List<Operation> opList = operationManager.getOperationList(name_log, newtime_log, starttime_log,endtime_log, keywords_log,nowpage_log);
	int num = operationManager.getOperationCount(name_log, newtime_log, starttime_log, endtime_log, keywords_log);
	int allpage = num % 20 == 0 ? num / 20 : num / 20 + 1;
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>操作日志</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/usermanager.css">
		<link rel="stylesheet" type="text/css" href="css/operation.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		<script type="text/javascript" src="js/showdate1.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
		var flag=0;//0：隐藏
		function adv_search(){
			$("#td2_div2").slideToggle();
			if(flag==0){
				//$("#td2_div2").css({display:"block"});
				$("#img_adv").attr("title","收起筛选");
				$("#img_adv").attr("src","images/search_press.jpg");
				flag=1;
			}else{
				//$("#td2_div2").css({display:"none"});
				$("#img_adv").attr("title","显示筛选");
				$("#img_adv").attr("src","images/search_normal.jpg");
				flag=0;
			}
		}
		function searchlog(){
			pageBegin();
		}
		function pageBegin(){
			document.logform.nowpage_log.value=1;
			logFilter();
		}
		function pageUP(){
			if(<%=nowpage_log > 1%>){
				document.logform.nowpage_log.value=<%=nowpage_log%>-1;
				logFilter();
			}else{
				initdiglog2("提示信息","已经是首页！");
			}
			
		}
		function pageDown(){
			if(<%=nowpage_log < allpage%>){
				document.logform.nowpage_log.value=<%=nowpage_log%>+1;
				logFilter();
			}else{
				initdiglog2("提示信息","已经是最后一页！");
			}
		}
		function pageLast(){
			document.logform.nowpage_log.value=<%=allpage%>;
			logFilter();
		}
   		function resetFilter(){
   			$("#keywords_log").val("");
   			$("#name_log").val("");
	    	//先重置时间，再重置按钮
	    	document.logform.starttime_log.value="<%=startDate%>";
			document.logform.endtime_log.value="<%=nowDate%>";
			$("input[name='newtime_log']").get(0).checked=false;
			$("#newtime_div").css({display:"none"});
			pageBegin();
	    }
	    function logFilter(){
	    	document.logform.submit();
	    }
	    $(function(){
	    	setTimeFilter();
	    });
	    function setTimeFilter(){
	    	if($("input[name='newtime_log']").get(0).checked){
				$("#newtime_div").css({display:"block"});
			}else{
				$("#newtime_div").css({display:"none"});
			}
	    }
	    function setTime(time,obj){
	    	if(obj==document.getElementById("time1")){
	    		//修改time1的时间
		    	if(compareTime1(time,document.getElementById("time2").value)){
		    		obj.value=time;
		    	}else{
		    		initdiglog2("提示信息","开始时间不能晚于结束时间！");
		    	}
	    	}else{
	    		//修改time2的时间
		    	if(compareTime1(document.getElementById("time1").value,time)){
		    		obj.value=time;
		    	}else{
		    		initdiglog2("提示信息","结束时间必须晚于开始时间！");
		    	}
	    	}
	    }
	    $(function(){
			$('#keywords_log').bind('keydown',function(event){
			    if(event.keyCode == "13"){
			    	searchlog();
			    }
			});
		    $('#name_log').bind('keydown',function(event){
			    if(event.keyCode == "13"){
			    	searchlog();
			    }
			});
		});
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
			<jsp:param name="index" value="6" />
			</jsp:include>
			<div class="div_center_right">
				<form action="OperationServlet?type=filter" method="post"
				name="logform">
				<div class="td2_div1">
					<img title="显示筛选" src="images/search_normal.jpg" id="img_adv"
						onclick="adv_search();" class="serach_img2">
					<img title="搜索" src="images/user_search.gif" id="img_search"
						onclick="searchlog();" class="serach_img1"
						onkeydown="if(event.keyCode==32) return false">
					<input type="text" name="keywords_log" id="keywords_log"  maxlength="30"
						placeholder="关键词：操作记录" value="<%=keywords_log%>">
				</div>
				<div class="td2_div2" id="td2_div2">
					<div class="td2_div2_a">
						操 作 者：
						<input type="text" name="name_log" id="name_log"  maxlength="10"
							placeholder="关键词：姓名"
							onkeydown="if(event.keyCode==32) return false"
							value="<%=name_log%>">
					</div>
						<div class="td2_div2_c">
							操作时间：
							<label>
								<input name="newtime_log" type="checkbox"
									onclick="setTimeFilter(2);" <%=newtime_log == 1 ? "checked" : ""%> />
								使用操作时间筛选
							</label>
							<div id="newtime_div" class="td2_div2_c_div">
								<input type="text" id="time1" name="starttime_log"
									value="<%=starttime_log%>" onClick="return Calendar('time1');"
									readonly="readonly" />
								-
								<input type="text" id="time2" name="endtime_log"
									value="<%=endtime_log%>" onClick="return Calendar('time2');"
									readonly="readonly" />
							</div>
						</div>
						<div class="td2_div2_d">
							<input type="button" value="筛选" class="search_left"
								onclick="searchlog();">
							<input type="button" value="重置" class="reset_right"
								onclick="resetFilter();">
						</div>
					</div>
					<input type="hidden" name="nowpage_log" value="<%=nowpage_log%>">
					<table class="device_tab">
						<tr class="tab_tr1">
							<td class="tab_tr1_td1" style="width:80px;">
								序号
							</td>
							<td class="tab_tr1_td2" style="width:80px;">
								操作者
							</td>
							<td class="tab_tr1_td4">
								操作
							</td>
							<td class="tab_tr1_td13" style="width:180px;">
								时间
							</td>
						</tr>
						<%
							int opLen = opList.size();
							for (int i = 0; i < opLen; i++) {
								Operation op = opList.get(i);
						%>
						<tr class="tab_tr<%=i % 2 + 2%>">
							<td class="tab_tr1_td1"><%=nowpage_log * 20 + i - 19%></td>
							<td class="tab_tr1_td2"><%=op.getUsername()%></td>
							<td class="tab_tr1_td4 tooltip_div" style="text-align: left;"><%=op.getContent()%></td>
							<td class="tab_tr1_td13"><%=op.getCreate_date()%></td>
						</tr>
						<%
							}
						%>
					</table>
					<div class="td2_div5">
						<%
							if (nowpage_log == 1) {
						%>
						<span class="span_nomal">首页</span>
						<span class="span_nomal"><</span>
						<%
							} else {
						%>
						<span class="span_press" onclick="pageBegin();">首页</span>
						<span class="span_press" onclick="pageUP();"><</span>
						<%
							}
						%>
						<span class="span_page"><%=num == 0 ? 0 : nowpage_log%>/<%=allpage%></span>
						<%
							if (allpage < 2 || nowpage_log == allpage) {
						%>
						<span class="span_nomal">></span>
						<span class="span_nomal">尾页</span>
						<%
							} else {
						%>
						<span class="span_press" onclick="pageDown();">></span>
						<span class="span_press" onclick="pageLast();">尾页</span>

						<%
							}
						%>

					</div>
			</form>
			</div>
			<div style="clear:both"></div>
		</div>
	</body>
</html>
