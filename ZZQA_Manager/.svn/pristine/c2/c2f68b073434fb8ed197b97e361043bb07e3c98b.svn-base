<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%request.setCharacterEncoding("UTF-8");
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
	String[] pCategoryArray=DataUtil.getPCategoryArray2();
	String[] productTypeArray=DataUtil.getProductTypeArray2();
	String[] pCaseArray=DataUtil.getPCaseArray();
	String[] stageArray=DataUtil.getStageArray2();
	String[] pTypeArray=DataUtil.getPTypeArray();
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>新建项目启动任务单流程</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css" href="css/create_taskflow.css">
		
		<link rel="stylesheet" type="text/css" href="css/custom.css">
		<link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-filer.css">
		<link rel="stylesheet" type="text/css" href="css/default.css">
		<link rel="stylesheet" type="text/css"
			href="css/jquery.filer-dragdropbox-theme.css">
		<link rel="stylesheet" type="text/css"
			href="css/font-awesome.min.css">
		<script src="js/showdate1.js" type="text/javascript"></script>
		<script src="js/prettify.js" type="text/javascript"></script>
		<script src="js/jquery.min.js" type="text/javascript"></script>
		<script src="js/jquery.filer.min.js" type="text/javascript"></script>
		<script src="js/custom.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
 		<script  type="text/javascript" src="js/jquery-ui.min.js"></script>
 		<script  type="text/javascript" src="js/dialog.js"></script>
 		<script type="text/javascript" src="js/public.js"></script>
 		<script type="text/javascript" src="js/startuptask.js"></script>
		<!--[if IE]>
			<script src="http://libs.useso.com/js/html5shiv/3.7/html5shiv.min.js"></script>
		<![endif]-->
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
		var linkman_user_num=0;
		var linkman_bill_num=0;
		var linkman_device_num=0;
		var nowdate="<%=DataUtil.getTadayStr()%>";
	   	
		
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
						<jsp:param name="index" value="3" />
					</jsp:include>
					<td class="table_center_td2">
						<form action="NewFlowServlet?type=addstartuptaskflow&file_time=<%=System.currentTimeMillis() %>" method="post"
							name="flowform">
							<input type="hidden" name="aa" value="1">
							<div class="td2_div">
								<div class="td2_div1">
									项目启动任务单
								</div>
								<table class="td2_table1">
									<tr class="table1_tr1">
										<td class="table1_tr1_td1">
											<span class="star">*</span>项目类型
										</td>
										<td class="table1_tr1_td2">
											<select name="pCategory">
												<%for(int i=0;i<pCategoryArray.length;i++){ %>
													<option value="<%=i%>" ><%=pCategoryArray[i]%></option>
												<%} %>
											</select>
										</td>
									</tr>
									<tr class="table1_tr1">
										<td class="table1_tr1_td1">
											<span class="star">*</span>产品类型
										</td>
										<td class="table1_tr1_td2">
											<select name="productType">
												<%for(int i=0;i<productTypeArray.length;i++){ %>
													<option value="<%=i%>" ><%=productTypeArray[i]%></option>
												<%} %>
											</select>
										</td>
									</tr>
									<tr class="table1_tr1">
										<td class="table1_tr1_td1">
											<span class="star">*</span>项目名称
										</td>
										<td class="table1_tr1_td2">
											<input type="text" name="project_name" maxlength="100" required="required">
											<span id="pname_error"></span>
										</td>
									</tr>
									<tr class="table1_tr2">
										<td class="table1_tr2_td1">
											<span class="star">*</span>项目编号
										</td>
										<td class="table1_tr2_td2">
											<input type="text" name="project_id" maxlength="50" oninput="checkNum(this)">
											<span id="pid_error"></span>
										</td>
									</tr>
									<tr class="table1_tr3">
										<td class="table1_tr3_td1">
											<span class="star">*</span>项目情况
										</td>
										<td class="table1_tr3_td2">
											<%for(int i=0;i<pCaseArray.length;i++){ %>
												<label><input name="project_case" type="radio" value="<%=i %>" <%=i==0?"checked":"" %>/><%=pCaseArray[i] %></label>
											<%} %>
										</td>
									</tr>
									<tr class="table1_tr4">
										<td class="table1_tr4_td1">
											<span class="star">*</span>销售阶段
										</td>
										<td class="table1_tr4_td2">
											<%for(int i=1;i<stageArray.length;i++){ %>
												<label><input name="stage" type="radio" value="<%=i %>" <%=i==1?"checked":"" %>/><%=stageArray[i] %></label>
											<%} %>
										</td>
									</tr>
									<tr class="table1_tr5">
										<td class="table1_tr5_td1">
											<span class="star">*</span>工程类型
										</td>
										<td class="table1_tr5_td2">
										<%for(int i=0;i<pTypeArray.length;i++){ %>
											<label><input name="project_type" type="radio" value="<%=i %>" <%=i==0?"checked":"" %>/><%=pTypeArray[i] %></label>
										<%} %>
										</td>
									</tr>
								</table>
								<table class="td2_table2">
									<tr class="table2_tr1">
										<td class="table2_tr1_td1">
											<span class="star">*</span>用户名称
										</td>
										<td class="table2_tr1_td2">
											<input type="text" name="customer" maxlength="100">
											<span id="customer_error"></span>
										</td>
									</tr>
									<tr class="table2_tr2">
										<td class="table2_tr2_td1">
											<span class="star">*</span>用户联系人
										</td>
										<input type="hidden" name="linkman_user">
										<td class="table2_tr2_td2">
											<div id="linkman_user_div"></div>
											<div id="linkman_user_div0" class="div_padding">
												姓名：<input type="text" id="linkman_user0" maxlength="10" onkeydown="if(event.keyCode==32) return false">
												电话：<input type="phone" id="phone_user0" maxlength="20" onkeydown="if(event.keyCode==32) return false">
												<img src="images/delete.png" title="删除" onclick="delLinkman(1,0);">
												<img src="images/add_linkman.png" style="margin-left: 10px" title="添加" onclick="addLinkman(1);">
												<span id="linkman_user_span0" style="margin-left: 10px"></span>
											</div>
										</td>
									</tr>
									<tr class="table2_tr3">
										<td class="table2_tr3_td1">
											<span class="star">*</span>发票接收人
										</td>
										<input type="hidden" name="linkman_bill">
										<td class="table2_tr3_td2">
											<div id="linkman_bill_div"></div>
											<div id="linkman_bill_div0" class="div_padding">
												姓名：<input type="text" id="linkman_bill0" maxlength="10" onkeydown="if(event.keyCode==32) return false">
												电话：<input type="phone" id="phone_bill0" maxlength="20" onkeydown="if(event.keyCode==32) return false">
												<img src="images/delete.png" title="删除" onclick="delLinkman(2,0);">
												<img src="images/add_linkman.png" style="margin-left: 10px" title="添加" onclick="addLinkman(2);">
												<span id="linkman_bill_span0" style="margin-left: 10px"></span>
											</div>
										</td>
									</tr>
									<tr class="table2_tr4">
										<td class="table2_tr4_td1">
											<span class="star">*</span>设备接收人
										</td>
										<input type="hidden" name="linkman_device">
										<td class="table2_tr4_td2" id="linkman_device_td">
											<div id="linkman_device_div"></div>
											<div id="linkman_device_div0" class="div_padding">
												姓名：<input type="text" id="linkman_device0" maxlength="10" onkeydown="if(event.keyCode==32) return false">
												电话：<input type="phone" id="phone_device0" maxlength="20" onkeydown="if(event.keyCode==32) return false">
												<img src="images/delete.png" title="删除" onclick="delLinkman(3,0);">
												<img src="images/add_linkman.png" style="margin-left: 10px" title="添加" onclick="addLinkman(3);">
												<span id="linkman_device_span0" style="margin-left: 10px"></span>
											</div>
										</td>
									</tr>
									<tr class="table2_tr5">
										<td class="table2_tr5_td1">
											<span class="star">*</span>要求发货时间
										</td>
										<td class="table2_tr5_td2">
											<input type="text" id="time" name="delivery_time" value="<%=DataUtil.getTadayStr() %>" onClick="return Calendar('time');" readonly="readonly"/>
											<span id="time_error"></span>
										</td>
									</tr>
									<tr class="table2_tr5">
										<td class="table2_tr5_td1">
											<span class="star">*</span>合同生效时间
										</td>
										<td class="table2_tr5_td2">
											<input type="text" id="time1" name="contract_time" value="<%=DataUtil.getTadayStr() %>" onClick="return Calendar('time1');" readonly="readonly"/>
											<span id="time_error2"></span>
										</td>
									</tr>
									<tr class="table2_tr6">
										<td class="table2_tr6_td1">
											<span class="star">*</span>项目说明及<br/>特殊要求（含合同执行风险）
										</td>
										<td class="table2_tr6_td2">
											<span>1.是否要求施工前现场开箱验货&nbsp</span>
											<label><input name="inspection" type="radio" value="0" checked/>是</label>
											<label><input name="inspection" type="radio" value="1" />否</label><br/>
											<span>2.发货前是否要求需和销售经理确认&nbsp</span>
											<label><input name="verify" type="radio" value="0" checked/>是</label>
											<label><input name="verify" type="radio" value="1" />否</label><br/>
											<textarea name="description" placeholder="此处输入项目说明、特殊要求和合同执行风险(可选)" 
											onkeydown="limitLength(this,1800);" onkeyup="limitLength(this,1800);"
											maxlength="1800"></textarea>
										</td>
									</tr>
									<tr class="table2_tr7">
										<td class="table2_tr7_td1">
											<span class="star">*</span>项目成本核算表
										</td>
										<td class="table2_tr7_td2">
											<div id="section4" class="section-white">
												<input type="file" name="file_list" id="file_input1"
												multiple="multiple">
											</div>
											<div class="section-white2">
												<span id="file_input1_error"></span>
											</div>
										</td>
									</tr>
									<tr class="table2_tr8">
										<td class="table2_tr8_td1">
											<span class="star">*</span>项目技术附件
										</td>
										<td class="table2_tr8_td2">
											<div style="display:block">
												<div class="file_title_remark">附件1：合同及技术协议扫描件</div>
													<div id="section5" class="section-white">
													<input type="file" name="file_technical2" id="file_input2" multiple="multiple">												
												</div>
												<textarea name="other" placeholder="附件1：合同及技术协议扫描件" maxlength="500"
												onkeydown="limitLength(this,500);" onkeyup="limitLength(this,500);" 
												style="height:30px;"></textarea>
											</div>
											<div style="display:block">
												<div class="file_title_remark">附件2：项目商务、技术评审邮件记录（虚拟打印PDF版）</div>
													<div class="section-white">
													<input type="file" name="file_technical3" id="file_input3" multiple="multiple">												
												</div>
												<textarea name="other2" placeholder="附件2：项目商务、技术评审邮件记录（虚拟打印PDF版）" maxlength="500"
												onkeydown="limitLength(this,500);" onkeyup="limitLength(this,500);" 
												style="height:30px;"></textarea>
											</div>
											<div style="display:block">
												<div class="file_title_remark">附件3（如有）：外部采购设备询价邮件记录</div>
												<div class="section-white">
													<input type="file" name="file_technical4" id="file_input4" multiple="multiple">												
												</div>
												<textarea name="other3" placeholder="附件3（如有）：外部采购设备询价邮件记录" maxlength="500"
												onkeydown="limitLength(this,500);" onkeyup="limitLength(this,500);" 
												style="height:30px;"></textarea>
											</div>
											<div style="display:block">
												<div class="file_title_remark">附件4：外包服务供应商信息及报价表（供应商评审表）</div>
												<div class="section-white">
													<input type="file" name="file_technical5" id="file_input5" multiple="multiple">												
												</div>
													<textarea name="other4" placeholder="附件4：外包服务供应商信息及报价表（供应商评审表）" 
													maxlength="500" onkeydown="limitLength(this,500);" onkeyup="limitLength(this,500);" 
													style="height:30px;"></textarea>
												</div>
											<div style="display:block">
												<div class="file_title_remark">附件5：投标报价表</div>
												<div class="section-white">
													<input type="file" name="file_technical6" id="file_input6" multiple="multiple">												
												</div>
												<textarea name="other5" placeholder="附件5：投标报价表" maxlength="500"
													onkeydown="limitLength(this,500);" onkeyup="limitLength(this,500);" 
												style="height:30px;"></textarea>
											</div>
											<div style="display:block">
												<div class="file_title_remark">附件6：其他与项目执行相关文档</div>
												<div class="section-white">
													<input type="file" name="file_technical7" id="file_input7" multiple="multiple">												
												</div>
												<textarea name="other6" placeholder="附件6：其他与项目执行相关文档" maxlength="500"
													onkeydown="limitLength(this,500);" onkeyup="limitLength(this,500);" 
												style="height:30px;"></textarea>
											</div>
										</td>
									</tr>
									
								</table>
								<div class="div_btn"><img src="images/submit_flow.png" onclick="addFlow();"></div>
							</div>
						</form>
					</td>
				</tr>
			</table>

		</div>
	</body>
</html>
