<%@page import="com.zzqa.pojo.resumption.Resumption"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.service.interfaces.product_procurement.Product_procurementManager"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.service.interfaces.resumption.ResumptionManager"%>
<%@page import="com.zzqa.pojo.resumption.Resumption"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
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
	Product_procurementManager product_procurementManager = (Product_procurementManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("product_procurementManager");
	PermissionsManager permissionsManager = (PermissionsManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("permissionsManager");
	ResumptionManager resumptionManager=(ResumptionManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("resumptionManager");
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
	if (session.getAttribute("resumption_id") == null) {
		response.sendRedirect("../login.jsp");
		return;
	}
	int resumption_id=(Integer)session.getAttribute("resumption_id");
	Resumption resumption=resumptionManager.getResumptionByID(resumption_id);
	if (resumption == null) {
		response.sendRedirect("../login.jsp");
		return;
	}
	Flow flow = flowManager.getNewFlowByFID(9, resumption_id);
	if(resumption==null||flow==null){
		response.sendRedirect("../login.jsp");
		return;
	}
	int operation = flow.getOperation();
	Map<String, String> map = resumptionManager
			.getResumptionFlowForDraw(resumption,flow);
	if(map==null){
		response.sendRedirect("../login.jsp");
		return;
	}
	List<Flow> reasonList=flowManager.getReasonList(9,resumption_id);
	boolean isWatcher="admin".equals(mUser.getName())||mUser.getId()==resumption.getCreate_id()||permissionsManager.checkPermission(mUser.getPosition_id(), (resumption.getType()==1?29:28));
	boolean isCreater=mUser.getId()==resumption.getCreate_id();
	boolean isNewVersion=true;//老版本没有上级审批，兼容旧版本的出差销假单，老旧版本分开处理
	if(reasonList.size()>0&&(reasonList.get(0).getOperation()==3||reasonList.get(0).getOperation()==4)){
		isNewVersion=false;
	}
	//检查是否可以审批
	boolean flag=resumptionManager.checkResumptionCan(operation, resumption, mUser);
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<title>销假流程</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css"
			href="css/resumption_flow_detail.css">
		<script src="js/showdate1.js" type="text/javascript"></script>
		<script src="js/jquery.min.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
 		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
 		<script type="text/javascript" src="js/dialog.js"></script>
 		<script type="text/javascript" src="js/public.js"></script>
 		
		<!--[if IE]>
			<script src="http://libs.useso.com/js/html5shiv/3.7/html5shiv.min.js"></script>
		<![endif]-->
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
		var minDate="<%=resumption.getForeign_name()%>".substring(4, 17);<%-- 出差单-2016年08月31日上午至2016年08月31日下午--%>
		var maxDate="<%=resumption.getForeign_name()%>".substring(18, 31);
		function setTime(time,obj){
			if(obj.id=="time1"){
				$("#rebackday").text(time.replace(/-/g, "/"));
				$("#time1").val(time);
			}else{
				$("#startday").text(time.replace(/-/g, "/"));
				$("#time0").val(time);
			}
			
		}
		function addFlow(){
			var leaveStartDate="<%=resumption.getMinDate()%>";
			var leaveEndDate="<%=resumption.getMaxDate()%>";
			var startResump=$("#startday").text().replace(/\//g,"-");
			var rebackResump=$("#rebackday").text().replace(/\//g,"-");
			var days1=daysBetween(leaveStartDate,startResump)+0.5*($("#halfDay0").val()-<%=resumption.getHalfDay1()%>);
			var days2=daysBetween(startResump,leaveEndDate)+0.5*(<%=resumption.getHalfDay2()%>-$("#halfDay0").val());
			if(days1<0||days2<0){
				initdiglog2("提示信息","起始时间必须在请假时间范围内！");
				return;
			}
			days1=daysBetween(leaveStartDate,rebackResump)+0.5*($("#halfDay").val()-<%=resumption.getHalfDay1()%>);
			days2=daysBetween(rebackResump,leaveEndDate)+0.5*(<%=resumption.getHalfDay2()%>-$("#halfDay").val());
			if((days1<0||days2<-0.5)){//最晚
				initdiglog2("提示信息","返回时间不符合销假规则！");
				return;
			}
			day1=daysBetween(startResump,rebackResump)+0.5*($("#halfDay").val()-$("#halfDay0").val());
			//销假时间区间要比原请假时间区间小，下面满足区间差值大于0
			day2=daysBetween(leaveStartDate,leaveEndDate)+0.5*(<%=resumption.getHalfDay2()-resumption.getHalfDay1()+1%>)-daysBetween(startResump,rebackResump)-0.5*($("#halfDay").val()-$("#halfDay0").val());
			if(day1<0||day2<=0){
				initdiglog2("提示信息","销假时间有误！");
				return;
			}
			if($("#resumption_reason").val().replace(/\s/g,"").length<1){
				initdiglog2("提示信息","请输入销假事由！");
				return;
			}
			$("#start_date").val($("#startday").text());
			$("#reback_date").val($("#rebackday").text());
			document.flowform.submit();
		}
		function cancelFlow(){
			initdiglogtwo2("提示信息","您确定要取消本次销假吗，删除销假单后系统不做保留，是否继续？");
	   		$( "#confirm2" ).click(function() {
				$( "#twobtndialog" ).dialog( "close" );
				$.ajax({
					type:"post",//post方法
					url:"FlowManagerServlet",
					timeout : 15000, //超时时间设置，单位毫秒
					data:{"type":"deleteResumption","resumption_id":<%=resumption_id%>},
					//ajax成功的回调函数
					success:function(returnData){
						if(returnData==0){
							initdiglog2("提示信息","撤销失败，请刷新页面！");
						}else{
							window.location.href='flowmanager/backlog.jsp';
						}
					},
					complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
						if(status!='success'){//超时,status还有success,error等值的情况
							initdiglog2("提示信息","操作异常,请重试！");
						}
					}
				});
	   		});
		}
		function verifyFlow(flag){
			if($("#reason").val().replace(/\s/g,"").length<1){
				initdiglog2("提示信息","请输入建议或意见！");
				return;
			}
			document.flowform.isagree.value=flag;
			document.flowform.submit();
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
						<form action="FlowManagerServlet?type=resumptionflow&resumption_id=<%=resumption.getId()%>&operation=<%=operation%>"
							method="post" name="flowform">
							<input type="text" name="hide_input" style="display:none">
							<input type="hidden" name="isagree" value="1">
							<div class="td2_div">
								<div class="td2_div1">
								<%if(isNewVersion){ %>
									<!-- 新版本 -->
								<div class="<%=map.get("class1_1")%>">
									<div <%= map.get("style11")%>>
										关联单据
									</div>
									<div <%= map.get("style12")%>>
										填写销假
									</div>
									<div <%= map.get("style13")%>>
										部门领导审批
									</div>
									<div <%= map.get("style14")%>>
										分管领导审批
									</div>
									<div <%= map.get("style15")%>>
										总经理审批
									</div>
									<div <%= map.get("style16")%>>
										考勤备案
									</div>
									<div <%= map.get("style17")%>>
										结束
									</div>
								</div>
								<div class="<%=map.get("class1_2")%>">
									<img src="<%= map.get("img1")%>">
									<div <%= map.get("style21")%>></div>
									
									<img src="<%= map.get("img2")%>">
									<div <%= map.get("style22")%>></div>
									
									<img src="<%= map.get("img3")%>">
									<div <%= map.get("style23")%>></div>
									
									<img src="<%= map.get("img4")%>">
									<div <%= map.get("style24")%>></div>

									<img src="<%= map.get("img5")%>">
									<div <%= map.get("style25")%>></div>
									
									<img src="<%= map.get("img6")%>">
									<div <%= map.get("style26")%>></div>
									
									<img src="<%= map.get("img7")%>">
								</div>
								<div class="<%=map.get("class1_3")%>">
									<div ><%= map.get("time1")%></div>
									<div ><%= map.get("time2")%></div>
									<div ><%= map.get("time3")%></div>
									<div ><%= map.get("time4")%></div>
									<div ><%= map.get("time5")%></div>
									<div ><%= map.get("time6")%></div>
									<div ><%= map.get("time7")%></div>
								</div>
									<%}else{ %>
									<!-- 老版本没有审批 -->
									<div class="td2_div1_1">
										<div class="<%=map.get("class11")%>">
											关联单据
										</div>
										<div class="<%=map.get("class12")%>">
											填写销假
										</div>
										<div class="<%=map.get("class13")%>">
											行政审批
										</div>
										<div class="<%=map.get("class14")%>">
											结束
										</div>
									</div>
									<div class="td2_div1_2">
										<div class="td2_div2_img">
											<img src="images/<%=map.get("img1")%>">
										</div>
										<div class="<%=map.get("class22")%>"></div>

										<div class="td2_div2_img">
											<img src="images/<%=map.get("img2")%>">
										</div>
										<div class="<%=map.get("class24")%>"></div>

										<div class="td2_div2_img">
											<img src="images/<%=map.get("img3")%>">
										</div>
										<div class="<%=map.get("class26")%>"></div>

										<div class="td2_div2_img">
											<img src="images/<%=map.get("img4")%>">
										</div>
									</div>
									<div class="td2_div1_3">
										<div class="td2_div31"><%=map.get("time1")%></div>
										<div class="td2_div32"><%=map.get("time2")%></div>
										<div class="td2_div33"><%=map.get("time3")%></div>
										<div class="td2_div34"><%=map.get("time4")%></div>
									</div>
									<%} %>
								</div>
								<div class="td2_div2">
									<div class="td2_div3">
										销假单
									</div>
									<table class="td2_table0">
										<tr class="table0_tr1">
											<td class="table0_tr1_td1">
												提交人
											</td>
											<td class="table0_tr1_td2">
												<%=resumption.getCreate_name() %>
											</td>
										</tr>
										<tr class="table0_tr1">
											<td class="table0_tr1_td1">
												关联单据
											</td>
											<td class="table0_tr1_td2">
											<a href="FlowManagerServlet?type=flowdetail&flowtype=<%=resumption.getType()+6%>&id=<%=resumption.getForeign_id()%>"
													target="_bank'"> <%=resumption.getForeign_name()%> </a>
											</td>
										</tr>
										<%if(operation>1){ %>
											<tr class="table0_tr1">
												<td class="table0_tr1_td1">
													起始时间<br/>
													<span style="font:12px/12px 'Simsun';"></span>
												</td>
												<td class="table0_tr1_td2">
													<%=resumption.getStartdate() %>
												</td>
											</tr>
											<tr class="table0_tr1">
												<td class="table0_tr1_td1">
													返回时间<br/>
													<span style="font:12px/12px 'Simsun';">（注:开始上班时间）</span>
												</td>
												<td class="table0_tr1_td2">
													<%=resumption.getReback_date() %>
												</td>
											</tr>
											<tr class="table0_tr1">
												<td class="table0_tr1_td1">
													销假事由
												</td>
												<td class="table0_tr1_td2">
													<%=resumption.getReason() %>
												</td>
											</tr>
										<%} %>
										</table>
										<table class="td2_table3">
									<%int reasonLen=reasonList.size(); for(int i=0;i<reasonLen;i++){ Flow reasonFlow=reasonList.get(i);int opera=reasonFlow.getOperation();%>
										<tr>
											<td class="td2_table3_left">
												<%=reasonFlow.getReason().replaceAll("\r\n", "<br/>") %>
											</td>
											<td class="td2_table3_right">
												<div class="<%=opera==3||opera==5||opera==7||opera==9?"td2_div5_bottom_agree":"td2_div5_bottom_disagree"%>">
													<div style="height:15px;"></div>
													<div class="td2_div5_bottom_right1"><%=reasonFlow.getUsername() %></div>
													<div class="td2_div5_bottom_right2"><%=reasonFlow.getCreate_date() %></div>
												</div>
											</td>
										</tr>
										<%} %>
									</table>
								</div>
								<%if (operation == 1&& isCreater) {%>
								<input type="hidden" name="start_date" id="start_date" value="">
								<input type="hidden" name="reback_date" id="reback_date" value="">
								<div class="td2_div3">
									填写销假信息
								</div>
								<table class="td2_table4">
									<tr class="table4_tr1">
										<td class="table4_tr1_td1">
											起始时间
										</td>
										<td class="table4_tr1_td2">
											<div id="startday"><%=resumption.getMinDate().replace("-", "/") %></div>
											<input type="text" id="time0" value="<%=resumption.getMinDate() %>" class="input-hide-time"/><img src="images/calendar.png" id="img_start" onclick="return Calendar('time0');" title="选择起始日期">
											<select name="halfDay0" id="halfDay0" ><option value="0">上午</option><option value="1" <%=resumption.getHalfDay1()==1?"selected":"" %>>下午</option></select>
										</td>
									</tr>
									<tr class="table4_tr1">
										<td class="table4_tr1_td1">
											返回时间
										</td>
										<td class="table4_tr1_td2">
											<div id="rebackday"><%=resumption.getMaxDate().replace("-", "/") %></div>
											<input type="text" id="time1" value="<%=resumption.getMaxDate() %>" class="input-hide-time"/><img src="images/calendar.png" id="img_reback" onclick="return Calendar('time1');" title="选择返回日期">
											<select name="halfDay" id="halfDay" ><option value="0">上午</option><option value="1" <%=resumption.getHalfDay2()==1?"selected":"" %>>下午</option></select>
										</td>
									</tr>
									<tr class="table4_tr2">
										<td class="table4_tr2_td1">
											销假事由
										</td>
										<td class="table4_tr2_td2">
											<textarea id="resumption_reason" name="resumption_reason" placeholder="输入销假事由" maxlength="500"></textarea>
										</td>
									</tr>
								</table>
								<div class="td2_div4">注：返回时间为您回到公司上班的时间</div>
								<%} %>
								<%
								if(flag){
								%>
								<textarea name="reason" id="reason"  class="div_testarea" placeholder="请输入意见或建议" required="required" maxlength="500"></textarea>
								<%} %>
								<div class="div_btn">
								<%
									if (flag) {
								%><img src="images/agree_flow.png" class="btn_agree"
									onclick="verifyFlow(0);">
									<img src="images/disagree_flow.png" class="btn_disagree"
									onclick="verifyFlow(1);">
								<%
									}
								%>
								<%
									if (resumptionManager.checkResumptionBackUp(operation,resumption,mUser)) {
								%><img src="images/backup.png" class="btn_agree"
									onclick="submit();">
								<%
									}
								%>
								<%
									if (operation==1&& isCreater) {
								%>
								<img src="images/submit_flow.png" class="btn_agree"
										onclick="addFlow();">
								<%} %>
								<%
									if (operation<3&& isCreater) {
								%>
								<!-- 未审批过的才能撤销 -->
									<img src="images/delete_travel.png" class="btn_disagree"
										onclick="cancelFlow();">
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
