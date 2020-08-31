<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	FlowManager flowManager = (FlowManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("flowManager");
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
	String keywords_flows = null;
	if (session.getAttribute("keywords_flows") != null) {
		keywords_flows = (String) session
				.getAttribute("keywords_flows");
	}else{
		keywords_flows=new String("");
	}
	int nowpage_flows = 1;
	if (session.getAttribute("nowpage_flows") != null) {
		nowpage_flows = (Integer) session
				.getAttribute("nowpage_flows");
	}
	String[] flowTypeArray = DataUtil.getFlowTypeArray();
	int flowTLen=flowTypeArray.length;
	String type_flows = null;
	if (session.getAttribute("type_flows") != null) {
		type_flows = (String) session
				.getAttribute("type_flows");
	}else{
		StringBuilder sb=new StringBuilder();
		for (int i = 1; i < flowTLen; i++) {
			if(i==5){
				sb.append(0);//隐藏生产单
			}else{
				sb.append(1);
			}
		}
		type_flows=sb.toString();
	}
	char[] flowTypeChecked=type_flows.toCharArray();
	int newtime_flows=0;
	if (session.getAttribute("newtime_flows") != null) {
		newtime_flows = (Integer) session
				.getAttribute("newtime_flows");
	}
	String startYear=DataUtil.getYearStr();
	String startDate=startYear;
	String starttime1_flows=DataUtil.getYearStr();
	if (newtime_flows==1&&session.getAttribute("starttime1_flows") != null) {
		starttime1_flows = (String) session
				.getAttribute("starttime1_flows");
	}
	String nowDate=DataUtil.getTadayStr();
	String endtime1_flows=nowDate;
	if (newtime_flows==1&&session.getAttribute("endtime1_flows") != null) {
		endtime1_flows = (String) session
				.getAttribute("endtime1_flows");
	}
	int nowtime_flows=0;
	if (session.getAttribute("nowtime_flows") != null) {
		nowtime_flows = (Integer) session
				.getAttribute("nowtime_flows");
	}
	String starttime2_flows=startYear;
	if (nowtime_flows==1&&session.getAttribute("starttime2_flows") != null) {
		starttime2_flows = (String) session
				.getAttribute("starttime2_flows");
	}
	String endtime2_flows=nowDate;
	if (nowtime_flows==1&&session.getAttribute("endtime2_flows") != null) {
		endtime2_flows = (String) session
				.getAttribute("endtime2_flows");
	}
	int isjoin=1;
	if (session.getAttribute("isjoin") != null) {
		isjoin = (Integer) session
				.getAttribute("isjoin");
	}
	int process=1;
	if (session.getAttribute("process") != null) {
		process = (Integer) session
				.getAttribute("process");
	}
	int hangUp=1;
	if (session.getAttribute("hangUp") != null) {
		hangUp = (Integer) session
				.getAttribute("hangUp");
	}
	int stage=0;
	if (session.getAttribute("stage") != null) {
		stage = (Integer) session
				.getAttribute("stage");
	}
	Map<String,Object> dataMap=flowManager.getFlowPaging(nowpage_flows,keywords_flows,newtime_flows,nowtime_flows,
			type_flows,starttime1_flows,endtime1_flows,starttime2_flows,endtime2_flows,isjoin,process,hangUp,stage,mUser);
	List<Flow> fList=(List<Flow>)dataMap.get("data");
	int num =(Integer)dataMap.get("num");
	int allpage = num % 20 == 0 ? num / 20 : num / 20 + 1;
	String[] stageArray2=DataUtil.getStageArray2();
	pageContext.setAttribute("flowTypeArray",flowTypeArray);
	pageContext.setAttribute("stageArray2",stageArray2);
	pageContext.setAttribute("stage",stage);
%>
<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>流程列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css" href="css/flowlist.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		<script src="js/showdate1.js" type="text/javascript"></script>
		<script src="js/public.js" type="text/javascript"></script>
		
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript"><!--
		var flag=0;//0：隐藏
		var nowpage_flows=<%=nowpage_flows%>;
		var allpage=<%=allpage%>;
		$(function(){
			$('#keywords_flows').bind('keydown',function(event){
			    if(event.keyCode == "13"){
			    	searchflows();
			    }
			});
			$(".flowcontainer_div a").attr("class","unselected_a");
			$('.div').hover(
				function () {
					$('.flowcontainer_div', this).toggle();
				},
				function () {
					$('.flowcontainer_div', this).toggle();
				}
			);
			initView();
		});
		function searchflows(){
			pageBegin();
		}
		function adv_search(){
			$("#td2_div2").slideToggle();
			if(flag==0){
				//$("#td2_div2").css({display:"block"});
				$("#img_adv").attr("title","收起筛选");
				$("#img_adv").attr("src","images/search_normal.jpg");
				flag=1;
			}else{
				//$("#td2_div2").css({display:"none"});
				$("#img_adv").attr("title","显示筛选");
				$("#img_adv").attr("src","images/search_press.jpg");
				flag=0;
			}
		}
		function pageBegin(){
			document.flowform.nowpage_flows.value=1;
			flowFilter();
		}
		function pageUP(){
			if(nowpage_flows>1){
				document.flowform.nowpage_flows.value=nowpage_flows-1;
				flowFilter();
			}else{
				initdiglog2("提示信息","已经是首页！");
			}
			
		}
		function pageDown(){
			if(nowpage_flows<allpage){
				document.flowform.nowpage_flows.value=nowpage_flows+1;
				flowFilter();
			}else{
				initdiglog2("提示信息","已经是最后一页！");
			}
		}
		function pageLast(){
			document.flowform.nowpage_flows.value=allpage;
			flowFilter();
		}
	    function resetFilter(index){
			window.location.href="FlowManagerServlet?type=reset&index="+index;
	    }
	    function flowFilter(){
	    	var k=0;
	    	var type_flows="";
	   		var flowType= document.getElementsByName("flowType");
	    	var flag = false;//true表示非第一次，区分是否加-
			for(var i=0;i<flowType.length;i++){
				//1表示选中，0为选中
				if(i==4){
					type_flows+="0";
				}
				type_flows+=flowType[i].checked?"1":"0";
			 }
			 if(type_flows.indexOf("1")==-1){
				initdiglog2("提示信息","请至少选择一个流程！");
			 	k++;
			 }else{
			 	document.flowform.type_flows.value=type_flows;
			 }
			 if(k==0){
			 	document.flowform.submit();
			 }
	    }
	    function initView(){
	    	setTimeFilter(1);
	    	setTimeFilter(2);
	    }
	    function setTimeFilter(index){
	    	if(index==1){
	    		if($("input[name='newtime_flows']").get(0).checked){
					$("#newtime_div").css({display:"block"});
				}else{
					$("#newtime_div").css({display:"none"});
				}
	    	}else if(index==2){
	    		if($("input[name='nowtime_flows']").get(0).checked){
					$("#nowtime_div").css({display:"block"});
				}else{
					$("#nowtime_div").css({display:"none"});
				}
	    	}
	    }
	    function typeFilter(obj,index){
	   	 	var flag=false;
	    	var flowType= document.getElementsByName("flowType");
	    	for(var i=0;i<flowType.length;i++){
	    		if(flowType[i].checked){
	    			flag=true;
	    		}
	    	}
	    	if(!flag){
	    		obj.checked=true;
	    		initdiglog2("提示信息","请至少选择一个流程！");
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
	    	}else if(obj==document.getElementById("time2")){
	    		//修改time2的时间
		    	if(compareTime1(document.getElementById("time1").value,time)){
		    		obj.value=time;
		    	}else{
		    		initdiglog2("提示信息","结束时间不能早于开始时间！");
		    	}
	    	}else if(obj==document.getElementById("time3")){
	    		//修改time1的时间
		    	if(compareTime1(time,document.getElementById("time4").value)){
		    		obj.value=time;
		    	}else{
		    		initdiglog2("提示信息","开始时间不能晚于结束时间！");
		    	}
	    	}else if(obj==document.getElementById("time4")){
	    		//修改time2的时间
		    	if(compareTime1(document.getElementById("time3").value,time)){
		    		obj.value=time;
		    	}else{
		    		initdiglog2("提示信息","结束时间不能早于开始时间！");
		    	}
	    	}
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
						<jsp:param name="index" value="2" />
					</jsp:include>
					<td class="table_center_td2">
						<form action="FlowManagerServlet?type=allfilter" method="post"
							name="flowform">
							<input type="hidden" name="nowpage_flows"
								value="<%=nowpage_flows%>">
							<div class="td2_div">
								<div class="td2_div1">
									<img title="显示筛选" src="images/search_press.jpg" id="img_adv"
										onclick="adv_search();" class="serach_img2">
									<img title="搜索" src="images/user_search.gif" id="img_search"
										onclick="searchflows();" class="serach_img1">
									<input type="text" name="keywords_flows" id="keywords_flows" maxlength="30" placeholder="关键词：编号、名称、姓名"
										value="<%=keywords_flows%>" onkeydown="if(event.keyCode==32) return false">
								</div>
								<div class="td2_div2" id="td2_div2">
								<input type="hidden" name="type_flows" value="<%=type_flows %>">
									<div class="td2_div2_a" id="flow_items">
										<div>流程类型：</div>
										<div>
										<%for(int i=1;i<flowTLen;i++){ if(i!=5){%>
										<label>
											<input name="flowType" type="checkbox" <%='1'==flowTypeChecked[i-1]?"checked":"" %> onclick="typeFilter(this,<%=i-1 %>);"/>
											<%=flowTypeArray[i]%>
											</label>
										<%}} %>
										</div>
									</div>
									<div class="td2_div2_b">
									进度过滤：
										<label>
											<input name="process" type="radio" value="1" <%=process==1?"checked":"" %>/>
											全部
										</label>
										<label>
											<input name="process" type="radio" value="2" <%=process==2?"checked":"" %>/>
											进行中
										</label>
										<label title="显示完成或撤销">
											<input name="process" type="radio" value="3" <%=process==3?"checked":"" %>/>
											结束
										</label>
										<label title="不含已撤销">
											<input name="process" type="radio" value="4" <%=process==4?"checked":"" %>/>
											已完成
										</label>
									</div>
									<div class="td2_div2_b" title="仅对售后任务单有效，挂起属于未完成状态">
										挂起过滤：
										<label>
											<input name="hangUp" type="radio" value="1" <%=hangUp==1?"checked":"" %>/>
											全部
										</label>
										<label>
											<input name="hangUp" type="radio" value="2" <%=hangUp==2?"checked":"" %>/>
											挂起
										</label>
										<label>
											<input name="hangUp" type="radio" value="3" <%=hangUp==3?"checked":"" %>/>
											其他
										</label>
									</div>
									<div class="td2_div2_b" title="仅对项目启动任务单有效">
										销售阶段：
										<c:forEach items="${stageArray2}" var="stage_str" varStatus="status">
											<label>
												<input name="stage" type="radio" value="${status.index}" <c:if test="${status.index==stage}">checked</c:if>/>
												${stage_str}
											</label>
										</c:forEach>
									</div>
									<div class="td2_div2_c">
										新建时间：
										<label>
											<input name="newtime_flows" type="checkbox" onclick="setTimeFilter(1);" <%=newtime_flows==1?"checked":"" %>/>
											使用新建时间筛选
										</label>
										<div id="newtime_div" class="td2_div2_c_div">
										<input type="text" id="time1" name="starttime1_flows" value="<%=starttime1_flows %>" 
											onClick="return Calendar('time1');" 
											readonly="readonly"/> - <input type="text" id="time2" name="endtime1_flows" value="<%=endtime1_flows%>" 
											onClick="return Calendar('time2');" readonly="readonly"/></div>
									</div>
									<div class="td2_div2_c">
										当前时间：
										<label>
											<input name="nowtime_flows" type="checkbox" onclick="setTimeFilter(2);" <%=nowtime_flows==1?"checked":"" %>/>
											使用当前时间筛选
										</label>
										<div id="nowtime_div" class="td2_div2_c_div">
										<input type="text" id="time3" name="starttime2_flows" value="<%=starttime2_flows %>" 
											onClick="return Calendar('time3');" 
											readonly="readonly"/> - <input type="text" id="time4" name="endtime2_flows" value="<%=endtime2_flows %>" 
											onClick="return Calendar('time4');" readonly="readonly"/></div>
									</div>
									<div class="td2_div2_b">
										是否参与：
										<label>
											<input name="isjoin" type="radio" value="1" <%=isjoin==1?"checked":"" %>/>
											全部
										</label>
										<label>
											<input name="isjoin" type="radio" value="2" <%=isjoin==2?"checked":"" %>/>
											我参与
										</label>
										<label>
											<input name="isjoin" type="radio" value="3" <%=isjoin==3?"checked":"" %>/>
											未参与
										</label>
									</div>
									<div class="td2_div2_d">
										<input type="button" value="筛选" class="search_left" onclick="searchflows();">
										<input type="button" value="重置" class="reset_right" onclick="resetFilter(0);">
									</div>
								</div>
								<table class="device_tab1">
									<tr class="tab_tr1">
										<td class="tab_tr1_td1" style="width:15%;width:140px;">
											流程编号
										</td>
										<td class="tab_tr1_td2" style="width:30%;">
											流程名称
										</td>
										<td class="tab_tr1_td3" style="width:8%;">
											创建者
										</td>
										<td class="tab_tr1_td4" style="width:120px;">
											<div class="div" style="width:120px;">
												<a href="javascript:void(0)">流程类别<img src="images/show_check.png"></a>
													<div class="flowcontainer_div">
													<%for(int i=1;i<flowTypeArray.length;i++){if(i!=5){ %>
													<div><a href="javascript:void(0)" onclick="resetFilter(<%=i%>)"><%=flowTypeArray[i]%></a></div>
													<%} }%>
													</div>	
											</div>
										</td>
										<td class="tab_tr1_td13" style="width:32%;">
											进度
										</td>
									</tr>
									<%
										int i = -1;
										for (Flow flow : fList) {
											i++;
									%>
									<tr class="tab_tr<%=i % 2 + 2%> tr_pointer" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=<%=flow.getId()%>&id=<%=flow.getJump_id()%>'">
										<td class="tab_tr1_td1 tooltip_div">
											<%=flow.getFlowcode()%>
										</td>
										<td class="tab_tr1_td2 tooltip_div"><%=flow.getFlowname()%></td>
										<td class="tab_tr1_td3"><%=flow.getUsername()%></td>
										<td class="tab_tr1_td4"><%=flowTypeArray[flow.getType()]%></td>
										<td class="tab_tr1_td13 tooltip_div"><%=flow.getReason()%></td>
									</tr>
									<%}%>
								</table>
								<div class="td2_div5">
									<%
										if (nowpage_flows == 1) {
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
									<span class="span_page"><%=allpage==0?0:nowpage_flows%>/<%=allpage%></span>
									<%
										if (allpage < 2 || nowpage_flows == allpage) {
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
							</div>
						</form>
					</td>
				</tr>
			</table>

		</div>
	</body>
</html>
