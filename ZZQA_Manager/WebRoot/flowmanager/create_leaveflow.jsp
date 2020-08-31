<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
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
	String[] departmentArray = DataUtil.getdepartment();
	String[] leaveType=DataUtil.getLeaveType();
	pageContext.setAttribute("departmentArray", departmentArray);
	pageContext.setAttribute("leaveType", leaveType);
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>新建请假流程</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/top.css">
<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
<link rel="stylesheet" type="text/css" href="css/create_leaveflow.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
<link rel="stylesheet" type="text/css" href="css/custom.css">
<link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
<link rel="stylesheet" type="text/css" href="css/jquery-filer.css">
<link rel="stylesheet" type="text/css" href="css/default.css">
<link rel="stylesheet" type="text/css"
	href="css/jquery.filer-dragdropbox-theme.css">
<link rel="stylesheet" type="text/css"
	href="css/font-awesome.min.css">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script src="js/prettify.js" type="text/javascript"></script>
<script src="js/jquery.filer.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/showdate1.js"></script>
<script type="text/javascript" src="js/public.js"></script>
<script type="text/javascript" src="js/dialog.js"></script>
<script src="js/custom.js" type="text/javascript"></script>

<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
		var holiday=[
		          <%
		          String[][] holiday=DataUtil.getHoliday();
					for(int i=0;i<holiday.length;i++){
						String[] monthArray=holiday[i];
						if(i>0){
							out.write(",");
						}
						out.write("['"+monthArray[0]+"','"+monthArray[1]+"','"+monthArray[2]+"','"+monthArray[3]+"','"+monthArray[4]+"','"+monthArray[5]+"','"
								+monthArray[6]+"','"+monthArray[7]+"','"+monthArray[8]+"','"+monthArray[9]+"','"+monthArray[10]+"','"+monthArray[11]+"']");
					}  
		          %>   
		          ];
		var dates=0;
		var alldays1=1;//全部时间
		var alldays2=1;//工作日
		function setTime(time,obj){
			if(obj==document.getElementById("time1")){
				//修改startday的时间
				dates=daysBetween(time,$("#endday").text().replace(/\//g, "-"));
		    	if(dates<0){
		    		initdiglog2("提示信息","开始时间不能晚于结束时间！");
		    	}else{
		    		$("#startday").text(time.replace(/-/g, "/"));
		    		$("#time1").val(time);
		    		getAllDays();
		    	}
			}else{
				dates=daysBetween($("#startday").text().replace(/\//g, "-"),time);
				//修改endday的时间
				if(dates<0){
					initdiglog2("提示信息","结束时间不能早于开始时间！");
		    	}else{
		    		$("#endday").text(time.replace(/-/g, "/"));
		    		$("#time2").val(time);
		    		getAllDays();
		    	}
			}
		}
		function addFlow(){
			if(alldays2<0.5){
				initdiglog2("提示信息","请假时间不正确！");
				return;
			}
			var starttime=timeTransStrToLong2($("#time1").val().replace(/-/g,"/"))+43200000*parseInt($("#day1").val());
			var endtime=timeTransStrToLong2($("#time2").val().replace(/-/g,"/"))+43200000*parseInt($("#day2").val());
			$.ajax({
    			type:"post",//post方法
    			url:"FlowManagerServlet",
    			data:{"type":"checkTimeScope","flowType":8,"starttime":starttime,"endtime":endtime},
    			timeout : 15000, 
    			//ajax成功的回调函数
    			success:function(returnData){
    				if(returnData==1){
    					if($("#department").val()==0){
    						initdiglog2("提示信息","请选择部门！");
    						return;
    					}
    					if($("#leaveType").val()==0){
    						initdiglog2("提示信息","请选择请假类型！");
    						return;
    					}
    					if($("#reason").val().replace(/(^\s*)/g, "").length<1){
    						initdiglog2("提示信息","请输入请假事由！");
    						return;
    					}
    					document.flowform.startDate.value=$("#startday").text();
    					document.flowform.endDate.value=$("#endday").text();
    					document.flowform.submit();
    				}else{
    					//失败
    					initdiglog2("提示信息", "该时间段有已提交的请假单，请检查并修改时间后再提交！");
    				}
    			},
    			complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
					if(status!='success'){//超时,status还有success,error等值的情况
						if(status=='timeout'){
							initdiglog2("提示信息","请求超时！");
						}else{
							initdiglog2("提示信息","操作异常,请重试！");
						}
					}
				}
    		});
		}
		function setLeaveType(){
			var leaveType=parseInt($("#leaveType").val());
			if(leaveType==4||leaveType==6){
				$("#alldays").text("共"+alldays1+"天");
			}else{
				$("#alldays").text("共"+alldays2+"天");
			}
		}
		function getAllDays(){
			alldays1=dates+0.5*($("#day2").val()-$("#day1").val())+0.5;
			alldays2=sumHoliday($("#time1").val(),$("#day1").val(),$("#time2").val(),$("#day2").val());
			setLeaveType();
		}
		function sumHoliday(day1,half1,day2,half2){
			 var workdays=0;
			var date1 = new Date(Date.parse(day1));
			var date2 = new Date(Date.parse(day2));
			if(date1.getTime()==date2.getTime()&&half1==half2){//只请了半天,且为工作日,需要去掉0.5
				if(!checkHoliday(date1)){
					workdays-=0.5;
				}
			}else{
				//起始只请了半天且为工作日的，减去重复的半天，下同
				if(half1==1&&!checkHoliday(date1)){
					workdays-=0.5;
				}
				if(half2==0&&!checkHoliday(date2)){
					workdays-=0.5;
				}
			}
			while(date1.getTime()<=date2.getTime()){
				if(!checkHoliday(date1)){
					workdays++;
				}
				date1=new Date((date1/1000+86400)*1000);
			}
			return workdays;
		}
		function checkHoliday(date){
			var yearIndex=date.getFullYear()-2016;
			if(yearIndex<0||yearIndex>=holiday.length){
				return false;//未记录节假日时间段内全部作为工作日计算
			}
			var monthIndex=date.getMonth();
			if(holiday[yearIndex][monthIndex].indexOf("-"+date.getDate()+"-")!=-1){
				return true;
			}
			return false;
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
					<div class="td2_div1">请假备注单</div>
					<form
							action="FlowManagerServlet?type=addleaveflow&file_time=<%=System.currentTimeMillis() %>" method="post" name="flowform" enctype="multipart/form-data">
							<input type="text"  name="hide"  style="display:none"/><!-- 防止按回车直接上传 -->
					<table class="td2_table">
						<tr class="table_tr1">
							<td class="table_tr1_td1"><span class="star">*</span>部门</td>
							<td class="table_tr1_td2">
								<select name="department" id="department">
									<c:forEach items="${departmentArray}" var="department" varStatus="d_status">
									<c:if test="${d_status.index!=3}">
									<option value="<c:out value="${d_status.index}"></c:out>"><c:out value="${department}"></c:out></option>
									</c:if>
									</c:forEach>
								</select>
							</td>
							<td class="table_tr1_td3"><span class="star">*</span>请假类型</td>
							<td class="table_tr1_td4">
								<select name="leaveType" id="leaveType" onchange="setLeaveType()">
								<c:forEach items="${leaveType}" var="lType" varStatus="leave_status">
								<option value="<c:out value="${leave_status.index}"></c:out>"><c:out value="${lType}"></c:out></option>
								</c:forEach>
							</select></td>
						</tr>
						<tr class="table_tr2">
							<input type="hidden" id="startDate" name="startDate" />
							<input type="hidden" id="endDate" name="endDate" />
							<td class="table_tr2_td1"><span class="star">*</span>请假时间</td>
							<td class="table_tr2_td2"  colspan="3">
								<div id="startday"><%=DataUtil.getTadayStr2() %></div>
								<input type="text" id="time1" value="<%=DataUtil.getTadayStr() %>" class="input-hide-time"/><img src="images/calendar.png" id="img1" onclick="return Calendar('time1');">
								<select name="day1" id="day1" onchange="getAllDays()"><option value="0">上午</option><option value="1" >下午</option></select>
								<div>至</div><div id="endday"><%=DataUtil.getTadayStr2() %></div>
								<input type="text" id="time2" value="<%=DataUtil.getTadayStr() %>" class="input-hide-time"/><img src="images/calendar.png" id="img2" onclick="return Calendar('time2');">
								<select name="day2" id="day2" onchange="getAllDays()"><option value="0">上午</option><option value="1" selected>下午</option></select>
								<div id="alldays">（共1天）</div>
							</td>
						</tr>
						<tr class="table_tr3">
							<td class="table_tr3_td1"><span class="star">*</span>请假事由</td>
							<td class="table_tr3_td2"  colspan="3">
								<textarea  id="reason" name="reason" placeholder="输入请假事由" maxlength="500"></textarea>
							</td>
						</tr>
						<tr class="table_tr4">
							<td class="table_tr4_td1">附件</td>
							<td class="table_tr4_td2"  style="padding:10px;"colspan="3">
								<div id="section4" class="section-white5">
									<input type="file" name="file_budget" id="file_input1"
									multiple="multiple">
								</div>
							</td>
						</tr>
					</table>
					<div class="div_btn"><img src="images/submit_flow.png" onclick="addFlow();"></div>
					</form>
				</td>
			</tr>
		</table>

	</div>
</body>
</html>
