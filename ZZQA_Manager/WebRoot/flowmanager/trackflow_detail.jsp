<%@page import="com.zzqa.util.DataUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page import="com.zzqa.service.interfaces.track.TrackManager"%>
<%@page import="com.zzqa.pojo.track.Track"%>
<%@page import="com.zzqa.service.interfaces.linkman.LinkmanManager"%>
<%@page import="com.zzqa.pojo.linkman.Linkman"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%@page
	import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
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
	FlowManager flowManager = (FlowManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("flowManager");
	LinkmanManager linkmanManager = (LinkmanManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("linkmanManager");
	PermissionsManager permissionsManager = (PermissionsManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("permissionsManager");
	TrackManager trackManager = (TrackManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("trackManager");
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
	if (session.getAttribute("track_id") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int track_id = (Integer)session.getAttribute("track_id");
	String[][] stateTrackArray = DataUtil.getStateTrackArray();
	Flow flow = flowManager.getNewFlowByFID(10, track_id);
	Track track = trackManager.getTrackByID(track_id);
	if(flow==null||track==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	List<Linkman> linkList=linkmanManager.getLinkmanListLimit(10, track_id, 0, 0);
	Map<String, String> map= trackManager.getTrackFlowForDraw(track,flow);
	List<Flow> reasonList = flowManager.getReasonList(10,track_id);
	int operation = flow.getOperation();
	boolean canagree=false;
	List<User> parentList=userManager.getParentListByChildUid(track.getCreate_id());
	if(parentList.size()>0){
		canagree=parentList.get(0).getId()==mUser.getId()&&(operation==1||operation==3);
	}
	pageContext.setAttribute("mUser", mUser);
	pageContext.setAttribute("map", map);
	pageContext.setAttribute("operation", operation);
	pageContext.setAttribute("track", track);
	pageContext.setAttribute("reasonList", reasonList);
	pageContext.setAttribute("canagree", canagree);
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>状态跟踪流程</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/top.css">
<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
<link rel="stylesheet" type="text/css" href="css/create_trackflow.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
<script src="js/jquery.min.js" type="text/javascript"></script>
<script  type="text/javascript" src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/dialog.js"></script>
<script type="text/javascript" src="js/public.js"></script>
<!--[if IE]>
			<script src="js/html5shiv.min.js" type="text/javascript"></script>
		<![endif]-->
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript">
	var stateTrackArray=[
	      <%for(int i=0;i<stateTrackArray.length;i++){
	      if(i!=0){
	    	  out.write(",");
	      }
	      out.write("'"+stateTrackArray[i][1]+"'");
	      }%>
	  ];
	var dateArray=[
			<%for(int i=0;i<linkList.size();i++){
				Linkman linman=linkList.get(i);
			    if(i!=0){
			  	  out.write(",");
			    }
			    out.write("["+linman.getCreate_time()+","+(linman.getLinkman_case()-2)+"]");
		    }%>  
	  ];
	var nowDate=timeTransLongToStr(<%=track.getState_time()%>);//当前月份
	function initDateArray(){
		for(var i=0;i<dateArray.length;i++){
			var day=timeTransLongToStr(dateArray[i][0],3);
			dateArray[i][0]=parseInt(day);
			dateArray[i][1]=dateArray[i][1]==-1?"":stateTrackArray[dateArray[i][1]];
		}
	}
	$(function(){
		initDateArray();
		initTime();
	});
	function findDate(day){//在当前月内根据日期找到状态
		for(var i=0;i<dateArray.length;i++){
			if(dateArray[i][0]==day){
				return dateArray[i][1];
			}
		}
		return "";
	}
	var MonthDNum = new Array(0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	var monthArray;
	function initMonthArray(){
		monthArray=new Array();
		for(var i=0;i<42;i++){
			monthArray[i]=new Array();
			monthArray[i][0]=0;//显示的日期
			monthArray[i][1]=false;//是否为可选日期
			monthArray[i][2]=false;//是否为可选日期中的周末
		}
	}
	function initTime(){
		initMonthArray();
		var nowdateArray=nowDate.split("-");
		nowdateArray[0]=parseInt(nowdateArray[0]);
		nowdateArray[1]=parseInt(nowdateArray[1]);
		nowdateArray[2]=parseInt(nowdateArray[2]);
		var DayNum = (IsLeapYear(nowdateArray[0]) && nowdateArray[1] == 2) ? MonthDNum[nowdateArray[1]] + 1 : MonthDNum[nowdateArray[1]];
		var lastDayNum=31;//上个月为去年12月
		if(nowdateArray[1]!=1){//上月为1-11月
			lastDayNum=(IsLeapYear(nowdateArray[0]) && nowdateArray[1] == 3) ? MonthDNum[nowdateArray[1]-1] + 1 : MonthDNum[nowdateArray[1]-1];
		}
		var date = new Date(nowdateArray[0]+"-"+nowdateArray[1]+"-1");//当前月1号
		var oneWeekIndex=date.getDay();//当前月份一号为星期几 0-6 周日-周六
		for(var i=0;i<oneWeekIndex;i++){
			//0 1 2 3 4 5 6
			monthArray[oneWeekIndex-i-1][0]=lastDayNum-i;//填充上个月
		}
		for(var i=1;i<=DayNum;i++){
			monthArray[i+oneWeekIndex-1][0]=i;//填充下个月
			monthArray[i+oneWeekIndex-1][1]=true;//本月才可操作
			if((oneWeekIndex+i)%7==0||(oneWeekIndex+i)%7==1){
				monthArray[i+oneWeekIndex-1][2]=true;//可选日期的周末
			}
		}
		if((DayNum+oneWeekIndex)<36){
			//只显示5行
			$("#date36").parent().css("display","none");
			if((DayNum+oneWeekIndex)<29){
				//只显示4行
				$("#date30").parent().css("display","none");
			}
		}else{
			$("#date36").parent().css("display","block");
		}
		date = new Date(nowdateArray[0]+"-"+nowdateArray[1]+"-"+DayNum);//当前月最后一天
		var endWeekIndex=date.getDay();//当前月份最后一天为星期几 0-6 周日-周六
		for(var i=endWeekIndex;i<6;i++){
			monthArray[DayNum+oneWeekIndex+(5-i)][0]=6-i;//填充下个月
		}
		showDate();
	}
	function showDate(){
		$(".track_date label").css("visibility","hidden");
		for(var i=0;i<monthArray.length;i++){
			$("#date"+(i+1)+" div:eq(0)").text(monthArray[i][0]);
			if(monthArray[i][0]!=0){
				if(monthArray[i][1]){//当前月内
					if(monthArray[i][2]){//周末
						$("#date"+(i+1)+" div:eq(0)").css("color","#FE018F");
					}else{
						$("#date"+(i+1)+" div:eq(0)").css("color","#000");
					}
					$("#date"+(i+1)+" div:eq(1)").text(findDate(monthArray[i][0]));
				}else{
					$("#date"+(i+1)+" div:eq(0)").css("color","#b3b3b3");
				}
			}
		}
	}
	/*是否润年*/
	function IsLeapYear(y) {
		if (0 == y % 4 && ((y % 100 != 0) || (y % 400 == 0))) {
			return true;
		} else {
			return false;
		}
	}
	function verifyFlow(isagree){
		document.flowform.isagree.value=isagree;
		var reason=document.flowform.reason.value.replace(/[ ]/g, "");
		if(reason.length==0){
			initdiglog2("提示信息","请输入意见或建议！");
			return;
		}
		document.flowform.submit();
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
				<td class="table_center_td2_full">
					<form
						action="FlowManagerServlet" method="post" name="flowform">
						<input type="hidden" name="type" value="trackflow">
						<input type="hidden" name="track_id" value="${track.id}">
						<input type="hidden" name="operation" value="${operation}">
						<input type="hidden" name="isagree">
						<div class="td2_div0">
							<div class="td2_div0_1">
								<div class="<c:out value='${map.class11}'></c:out>">提交状态单</div>
								<div class="<c:out value='${map.class12}'></c:out>">领导审批</div>
								<div class="<c:out value='${map.class13}'></c:out>">完成审批</div>
							</div>
							<div class="td2_div0_2">
								<div class="td2_div21">
									<img src="images/<c:out value='${map.img1}'></c:out>">
								</div>
								<div class="<c:out value='${map.class22}'></c:out>"></div>
								<div class="td2_div21">
									<img src="images/<c:out value='${map.img2}'></c:out>">
								</div>
								<div class="<c:out value='${map.class24}'></c:out>"></div>
								<div class="td2_div21">
									<img src="images/<c:out value='${map.img3}'></c:out>">
								</div>
							</div>
							<div class="td2_div0_3">
								<div class="td2_div31"><c:out value='${map.time1}' escapeXml="false"></c:out></div>
								<div class="td2_div32"><c:out value='${map.time2}' escapeXml="false"></c:out></div>
								<div class="td2_div33"><c:out value='${map.time3}' escapeXml="false"></c:out></div>
							</div>
						</div>
						<div class="td2_div1">现场服务人员状态表</div>
						<div class="td2_div2"><div>提交人：<c:out value="${track.create_name}"></c:out></div><div>时间：<c:out value="${track.state_date}"></c:out></div></div>
						<div class="track_top_bg"></div>
						<div class="track_week">
							<div>周日</div>
							<div>周一</div>
							<div>周二</div>
							<div>周三</div>
							<div>周四</div>
							<div>周五</div>
							<div>周六</div>
						</div>
						<div class="track_date">
							<div id="date1"><input type="checkbox" id="checkbox_a1" class="chk_1" /><label for="checkbox_a1"></label><div></div><div></div></div>
							<div id="date2"><input type="checkbox" id="checkbox_a2" class="chk_1" /><label for="checkbox_a2"></label><div></div><div></div></div>
							<div id="date3"><input type="checkbox" id="checkbox_a3" class="chk_1" /><label for="checkbox_a3"></label><div></div><div></div></div>
							<div id="date4"><input type="checkbox" id="checkbox_a4" class="chk_1" /><label for="checkbox_a4"></label><div></div><div></div></div>
							<div id="date5"><input type="checkbox" id="checkbox_a5" class="chk_1" /><label for="checkbox_a5"></label><div></div><div></div></div>
							<div id="date6"><input type="checkbox" id="checkbox_a6" class="chk_1" /><label for="checkbox_a6"></label><div></div><div></div></div>
							<div id="date7"><input type="checkbox" id="checkbox_a7" class="chk_1" /><label for="checkbox_a7"></label><div></div><div></div></div>
						</div>
						<div class="track_date">
							<div id="date8"><input type="checkbox" id="checkbox_a8" class="chk_1" /><label for="checkbox_a8"></label><div></div><div></div></div>
							<div id="date9"><input type="checkbox" id="checkbox_a9" class="chk_1" /><label for="checkbox_a9"></label><div></div><div></div></div>
							<div id="date10"><input type="checkbox" id="checkbox_a10" class="chk_1" /><label for="checkbox_a10"></label><div></div><div></div></div>
							<div id="date11"><input type="checkbox" id="checkbox_a11" class="chk_1" /><label for="checkbox_a11"></label><div></div><div></div></div>
							<div id="date12"><input type="checkbox" id="checkbox_a12" class="chk_1" /><label for="checkbox_a12"></label><div></div><div></div></div>
							<div id="date13"><input type="checkbox" id="checkbox_a13" class="chk_1" /><label for="checkbox_a13"></label><div></div><div></div></div>
							<div id="date14"><input type="checkbox" id="checkbox_a14" class="chk_1" /><label for="checkbox_a14"></label><div></div><div></div></div>
						</div>
						<div class="track_date">
							<div id="date15"><input type="checkbox" id="checkbox_a15" class="chk_1" /><label for="checkbox_a15"></label><div></div><div></div></div>
							<div id="date16"><input type="checkbox" id="checkbox_a16" class="chk_1" /><label for="checkbox_a16"></label><div></div><div></div></div>
							<div id="date17"><input type="checkbox" id="checkbox_a17" class="chk_1" /><label for="checkbox_a17"></label><div></div><div></div></div>
							<div id="date18"><input type="checkbox" id="checkbox_a18" class="chk_1" /><label for="checkbox_a18"></label><div></div><div></div></div>
							<div id="date19"><input type="checkbox" id="checkbox_a19" class="chk_1" /><label for="checkbox_a19"></label><div></div><div></div></div>
							<div id="date20"><input type="checkbox" id="checkbox_a20" class="chk_1" /><label for="checkbox_a20"></label><div></div><div></div></div>
							<div id="date21"><input type="checkbox" id="checkbox_a21" class="chk_1" /><label for="checkbox_a21"></label><div></div><div></div></div>
						</div>
						<div class="track_date">
							<div id="date22"><input type="checkbox" id="checkbox_a22" class="chk_1" /><label for="checkbox_a22"></label><div></div><div></div></div>
							<div id="date23"><input type="checkbox" id="checkbox_a23" class="chk_1" /><label for="checkbox_a23"></label><div></div><div></div></div>
							<div id="date24"><input type="checkbox" id="checkbox_a24" class="chk_1" /><label for="checkbox_a24"></label><div></div><div></div></div>
							<div id="date25"><input type="checkbox" id="checkbox_a25" class="chk_1" /><label for="checkbox_a25"></label><div></div><div></div></div>
							<div id="date26"><input type="checkbox" id="checkbox_a26" class="chk_1" /><label for="checkbox_a26"></label><div></div><div></div></div>
							<div id="date27"><input type="checkbox" id="checkbox_a27" class="chk_1" /><label for="checkbox_a27"></label><div></div><div></div></div>
							<div id="date28"><input type="checkbox" id="checkbox_a28" class="chk_1" /><label for="checkbox_a28"></label><div></div><div></div></div>
						</div>
						<div class="track_date">
							<div id="date29"><input type="checkbox" id="checkbox_a29" class="chk_1" /><label for="checkbox_a29"></label><div></div><div></div></div>
							<div id="date30"><input type="checkbox" id="checkbox_a30" class="chk_1" /><label for="checkbox_a30"></label><div></div><div></div></div>
							<div id="date31"><input type="checkbox" id="checkbox_a31" class="chk_1" /><label for="checkbox_a31"></label><div></div><div></div></div>
							<div id="date32"><input type="checkbox" id="checkbox_a32" class="chk_1" /><label for="checkbox_a32"></label><div></div><div></div></div>
							<div id="date33"><input type="checkbox" id="checkbox_a33" class="chk_1" /><label for="checkbox_a33"></label><div></div><div></div></div>
							<div id="date34"><input type="checkbox" id="checkbox_a34" class="chk_1" /><label for="checkbox_a34"></label><div></div><div></div></div>
							<div id="date35"><input type="checkbox" id="checkbox_a35" class="chk_1" /><label for="checkbox_a35"></label><div></div><div></div></div>
						</div>
						<div class="track_date">
							<div id="date36"><input type="checkbox" id="checkbox_a29" class="chk_1" /><label for="checkbox_a36"></label><div></div><div></div></div>
							<div id="date37"><input type="checkbox" id="checkbox_a30" class="chk_1" /><label for="checkbox_a37"></label><div></div><div></div></div>
							<div id="date38"><input type="checkbox" id="checkbox_a31" class="chk_1" /><label for="checkbox_a38"></label><div></div><div></div></div>
							<div id="date39"><input type="checkbox" id="checkbox_a32" class="chk_1" /><label for="checkbox_a39"></label><div></div><div></div></div>
							<div id="date40"><input type="checkbox" id="checkbox_a33" class="chk_1" /><label for="checkbox_a40"></label><div></div><div></div></div>
							<div id="date41"><input type="checkbox" id="checkbox_a34" class="chk_1" /><label for="checkbox_a41"></label><div></div><div></div></div>
							<div id="date42"><input type="checkbox" id="checkbox_a35" class="chk_1" /><label for="checkbox_a42"></label><div></div><div></div></div>
						</div>
						<c:if test="${reasonList!= null && fn:length(reasonList) >0}">
						<div class="approve_div">
							<div>领导审批</div>
							<table class="td2_table3">
							<c:forEach items="${reasonList}" var="reasonFlow">
								<tr>
								<td class="td2_table3_left">
									<c:out value="${reasonFlow.reason}" escapeXml="false"></c:out>
								</td>
								<td class="td2_table3_right">
								<c:if test="${reasonFlow.operation!=2&&reasonFlow.operation!=3}">
									<div class="td2_div5_bottom_noimg">
								</c:if>
								<c:if test="${reasonFlow.operation==2}">
									<div class="td2_div5_bottom_agree">
								</c:if>
								<c:if test="${reasonFlow.operation==3}">
									<div class="td2_div5_bottom_disagree">
								</c:if>
										<div style="height: 15px;"></div>
										<div class="td2_div5_bottom_right1"><c:out value="${reasonFlow.username}"></c:out></div>
										<div class="td2_div5_bottom_right2"><c:out value="${reasonFlow.create_date}"></c:out></div>
									</div>
								</td>
							</tr>
							</c:forEach>
						</table>
						</div>
						</c:if>
						<c:if test="${canagree}">
							<textarea name="reason" class="div_testarea"
								placeholder="请输入意见或建议" required="required" maxlength="500"></textarea>
						</c:if>
						<div class="div_btn">
								<c:if test="${track.create_id==mUser.id}">
									<img src="images/alter_flow.png" class="fistbutton"
										onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=18&id=<%=track_id%>'">
								</c:if>
								<c:if test="${canagree}">
									<img src="images/agree_flow.png" class="btn_agree"
										onclick="verifyFlow(0);">
										<c:if test="${operation==1}">
											<img src="images/disagree_flow.png" class="btn_disagree"
										onclick="verifyFlow(1);">
										</c:if>
								</c:if>
						</div>
					</form>
				</td>
			</tr>
		</table>

	</div>
</body>
</html>
