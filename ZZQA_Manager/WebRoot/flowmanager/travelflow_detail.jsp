<%@page import="com.zzqa.service.interfaces.travel.TravelManager"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.service.interfaces.travel.TravelManager"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%@page import="com.zzqa.pojo.travel.Travel"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%request.setCharacterEncoding("UTF-8");
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
	Position_userManager position_userManager = (Position_userManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("position_userManager");
	PermissionsManager permissionsManager = (PermissionsManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("permissionsManager");
	TravelManager travelManager = (TravelManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("travelManager");
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
	if (session.getAttribute("travel_id") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int travel_id=(Integer)session.getAttribute("travel_id");
	Travel travel=travelManager.getTravelByID(travel_id);
	Flow flow=flowManager.getNewFlowByFID(7, travel_id);
	if(travel==null||flow==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int operation=flow.getOperation();
	boolean isParent=false;
	User creater=userManager.getUserByID(travel.getCreate_id());
	if(creater!=null){
		Position_user position_user=position_userManager.getPositionByID(creater.getPosition_id());
		if(position_user!=null){
			isParent=position_user.getParent()==mUser.getPosition_id();
		}
	}
	Map<String,String> map=travelManager.getTravelFlowForDraw(travel,flow);
	List<Flow> reasonList=flowManager.getReasonList(7, travel_id);
	List<Flow> flowList=flowManager.getFlowListByCondition(7, travel_id);
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<title>出差流程</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css" href="css/travelflow_detail.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script  type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/showdate1.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
 		<script type="text/javascript" src="js/dialog.js"></script>
 		
		<!--[if IE]>
			<script src="http://libs.useso.com/js/html5shiv/3.7/html5shiv.min.js"></script>
		<![endif]-->
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
			function agreeNotBackup(){
				initdiglogtwo2("提示信息","您同意该出差单无需备案，且财务不负备案责任，是否确认？");
		   		$( "#confirm2" ).click(function() {
					$( "#twobtndialog" ).dialog( "close" );
					document.flowform.isagree.value=0;
					document.flowform.submit();
		   		});
			}
			function verifyFlow(isagree){
				if(<%=operation%>==1&&$("#reason").val().replace(/(^\s*)/g, "").length<1){
					initdiglog2("提示信息","请输入意见或建议！");
					return;
				}
				document.flowform.isagree.value=isagree;
				document.flowform.submit();
			}
			var startDate="<%=travel.getStartDate()%>".replace(/\//g, "-");
			var endDate="<%=travel.getEndDate()%>".replace(/\//g, "-");
			var alldays=1;
			function setTime(time,obj){
				var days=daysBetween(endDate,time)+0.5*($("#halfday2").val()-<%=travel.getHalfDay2()%>);
				//修改endday的时间
				if(days>0){
					$("#endday").text(time.replace(/-/g, "/"));
					$("#time1").val(time);
		    		getAllDays();
				}else{
					initdiglog2("提示信息","结束时间必须晚于<%=travel.getEndDate()+(travel.getHalfDay2()==0?"上午":"下午")%>！");
				}
			}
			function addFlow(){
				var days=daysBetween(endDate,$("#endday").text().replace(/\//g, "-"))+0.5*($("#halfday2").val()-<%=travel.getHalfDay2()%>);
				//修改endday的时间
				if(days>0){
					document.flowform.endDate.value=$("#endday").text();
					document.flowform.submit();
				}else{
					initdiglog2("提示信息","结束时间必须晚于<%=travel.getEndDate()+(travel.getHalfDay2()==0?"上午":"下午")%>！");
				}
			}
			function finishFlow(){
				initdiglogtwo2("提示信息","您确定要撤销该出差单吗？");
		   		$( "#confirm2" ).click(function() {
					$( "#twobtndialog" ).dialog( "close" );
					$.ajax({
						type:"post",//post方法
						url:"FlowManagerServlet",
						timeout : 15000, //超时时间设置，单位毫秒
						data:{"type":"deleteTravel","travel_id":<%=travel_id%>},
						//ajax成功的回调函数
						success:function(returnData){
							initdiglogtwo3("提示信息","撤销成功,需要重新创建出差单吗？");
							$( "#confirm2" ).click(function() {
								window.location.href='flowmanager/create_travelflow.jsp';
							});
						},
						complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
							if(status!='success'){//超时,status还有success,error等值的情况
								initdiglog2("提示信息","操作异常,请重试！");
							}
						}
					});
		   		});
			}
			var ifJump=true;
			//撤销成功，销毁对话框的回调方法
			function cancelBack(){
				window.location.reload();
			};
			function getAllDays(){
				alldays=daysBetween(startDate,$("#endday").text().replace(/\//g, "-"))+0.5*($("#halfday2").val()-<%=travel.getHalfDay1()%>)+0.5;
				$("#alldays").text("共"+alldays+"天");
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
							action="FlowManagerServlet?type=travelflow&travel_id=<%=travel.getId()%>&operation=<%=operation%>"
							method="post" name="flowform">
							<div class="td2_div">
								<div class="td2_div1">
								<%if(operation!=7){ %>
									<div class="td2_div1_1">
										<div class="<%=map.get("class11")%>">
											出差申请提交
										</div>
										<div class="<%=map.get("class12")%>">
											上级领导审批
										</div>
										<div class="<%=map.get("class13")%>">
											考勤备案
										</div>
										<div class="<%=map.get("class14")%>">
											财务备案
										</div>
										<div class="<%=map.get("class15")%>">
											结束
										</div>
									</div>
									<div class="td2_div1_2">
										<div class="td2_div2_img">
											<img src="images/<%=map.get("img1")%>">
										</div>
										<div class="<%=map.get("class21")%>"></div>

										<div class="td2_div2_img">
											<img src="images/<%=map.get("img2")%>">
										</div>
										<div class="<%=map.get("class22")%>"></div>

										<div class="<%=operation==3?"hide_css":"td2_div2_img" %>">
											<img src="images/<%=map.get("img3")%>">
										</div>
										<div class=" <%=map.get("class23")%>"></div>

										<div class="<%=operation==3?"hide_css":"td2_div2_img" %>">
											<img src="images/<%=map.get("img4")%>">
										</div>
										<div class="<%=map.get("class245")%>"></div>
										<div class="<%=map.get("class246")%>"></div>
										<div class="td2_div2_img">
											<img src="images/<%=map.get("img5")%>">
										</div>
									</div>
									<div class="td2_div1_3">
										<div class="td2_div31"><%=map.get("time1")%></div>
										<div class="<%=operation==3?"td2_div32_no":"td2_div32" %>"><%=map.get("time2")%></div>
										<div class="td2_div33"><%=map.get("time3")%></div>
										<div class="td2_div34"><%=map.get("time4")%></div>
										<div class="td2_div35"><%=map.get("time5")%></div>
									</div>
									<%}else{ %>
									<div class="<%=map.get("class1")%>">
										<div>
											出差申请提交
										</div>
										<div>
											上级领导审批
										</div>
										<div>
											考勤备案
										</div>
										<div>
											已撤销
										</div>
									</div>
									<div class="<%=map.get("class2")%>">
										<div>
											<img src="images/pass.png">
										</div>
										<div></div>

										<div>
											<img src="images/pass.png">
										</div>
										<div></div>

										<div>
											<img src="images/pass.png">
										</div>
										<div></div>

										<div>
											<img src="images/error.png">
										</div>
									</div>
									<div class="<%=map.get("class3")%>">
										<div><%=map.get("time1")%></div>
										<div><%=map.get("time2")%></div>
										<div><%=map.get("time3")%></div>
										<div><%=map.get("time4")%></div>
									</div>
									<%} %>
							</div>
							<div class="td2_div2">
								<div class="td2_div3">
									出差备注单
								</div>
								<div class="td2_div4">
										<div>申请人：<%=travel.getCreate_name()%></div>
										<div>考勤备案人：<%=travel.getAttendance_name()%></div>
										<div>财务备案人：<%=/* operation==5&&flowList.get(flowList.size()-2).getOperation()==8?"无需备案": */travel.getFinancial_name()%></div>
								</div>
								<table class="td2_table">
									<tr class="table_tr1">
										<td class="table_tr1_td1">部门</td>
										<td class="table_tr1_td2">
										<%=travel.getDepartment_name() %>
										</td>
										<td class="table_tr1_td3">出差地</td>
										<td class="table_tr1_td4"><%=travel.getAddress() %></td>
									</tr>
									<tr class="table_tr2">
										<input type="hidden" id="endDate" name="endDate" />
										<td class="table_tr2_td1">出差时间</td>
										<td class="table_tr2_td2"  colspan="3">
											<div><%=travel.getStartDate()+(travel.getHalfDay1()==0?"上午":"下午") %></div>
											<div>至</div>
											<%if(operation==6&&mUser.getId()==travel.getCreate_id()){ %>
											<div id="endday"><%=travel.getEndDate()%></div>
											<input type="text" id="time1" value="<%=travel.getEndDate().replace("/", "-") %>" class="input-hide-time"/><img src="images/calendar.png" id="img2" onclick="return Calendar('time1');">
											<select name="halfday2" id="halfday2" onchange="getAllDays()"><option value="0" <%=travel.getHalfDay2()==0?"selected":"" %>>上午</option><option value="1" <%=travel.getHalfDay2()==0?"":"selected" %>>下午</option></select>
											<%}else{ %>
											<div><%=travel.getEndDate()+(travel.getHalfDay2()==0?"上午":"下午") %></div>
											<%} %>
											<div id="alldays">（共<%=travel.getAlldays()%>天）</div>
										</td>
									</tr>
									<tr class="table_tr3">
										<td class="table_tr3_td1">出差事由</td>
										<td class="table_tr3_td2"  colspan="3">
											<%=travel.getReason() %>
										</td>
									</tr>
								</table>
								<%
									if (operation == 6&&mUser.getId()==travel.getCreate_id()) {
								%>
									<div class="td2_div6">
									注：考勤发现您本次出差未能按时返回，需要您修改出差结束时间。
								</div>
								<%
									}
								%>
								<%
									if (operation == 8||(operation==5&&flowList.get(flowList.size()-2).getOperation()==8)) {
								%>
									<div class="td2_div6">
									注：该出差单由财务认定无需备案，经本人同意后，财务将不负备案责任
								</div>
								<%
									}
								%>
								<%if(reasonList.size()>0){ %>
								<div class="td2_div5">
									领导审批
								</div>
								<table class="td2_table3">
										<%
											int reasonLen = reasonList.size();
											for (int i = 0; i < reasonLen; i++) {
												Flow reasonFlow = reasonList.get(i);if(reasonFlow.getOperation()==1)continue;
										%>
										<tr>
											<td class="td2_table3_left">
												<%=reasonFlow.getReason().replaceAll("\n\r","<br/>").replaceAll("\r\n","<br/>").replaceAll("\n","<br/>").replaceAll("\r","<br/>")%>
											</td>
											<td class="td2_table3_right">
												<div
													class="<%=reasonFlow.getOperation() ==2 ? "td2_div5_bottom_agree"
								: "td2_div5_bottom_disagree"%> ">
													<div style="height: 15px;"></div>
													<div class="td2_div5_bottom_right1"><%=reasonFlow.getUsername()%></div>
													<div class="td2_div5_bottom_right2"><%=reasonFlow.getCreate_date()%></div>
												</div>
											</td>
										</tr>
										<%
											}
										%>
									</table>
									<%
											}
										%>
							</div>
							<%
								if (operation == 1&&isParent) {
							%>
							<textarea name="reason" id="reason"  class="div_testarea" placeholder="请输入意见或建议" required="required" maxlength="500"></textarea>
							<%} %>
							<div class="div_btn">
								<input type="hidden" name="isagree">
								<%
									if (operation == 1&&isParent) {
								%><img src="images/agree_flow.png" class="btn_agree"
									onclick="verifyFlow(0);">
									<img src="images/disagree_flow.png" class="btn_disagree"
									onclick="verifyFlow(1);">
								<%
									}
								%>
								<%
									if (creater!=null&&operation == 2&&permissionsManager.checkPermission(mUser.getPosition_id(), 32)) {
								%>
									<img src="images/backup.png" class="btn_agree"
									onclick="verifyFlow(0);">
								<%
									}
								%>
								<%
									if (creater!=null&&operation == 4&&permissionsManager.checkPermission(mUser.getPosition_id(), 31)) {
								%><img src="images/backup.png" class="btn_agree"
									onclick="verifyFlow(0);">
									<img src="images/notneed_backup.png" class="btn_agree"
									onclick="verifyFlow(1);">
								<%
									}
								%>
								<%if(travel.getCreate_id()==mUser.getId()&&(operation==1||operation==2||operation==4)){ %>
									<img src="images/delete_travel.png" class="btn_disagree" onclick="finishFlow()">
								<%} %>
								<%if(travel.getCreate_id()==mUser.getId()&&operation==8){ %>
									<img src="images/agree_flow.png" class="btn_agree"
									onclick="agreeNotBackup();">
									<img src="images/disagree_flow.png" class="btn_agree"
									onclick="verifyFlow(1);">
								<%} %>
							</div>
						</form>
					</td>
				</tr>
			</table>

		</div>
	</body>
</html>
