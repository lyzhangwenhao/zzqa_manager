<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page import="com.zzqa.service.interfaces.file_path.File_pathManager"%>
<%@page import="com.zzqa.pojo.file_path.File_path"%>
<%@page import="com.zzqa.service.interfaces.seal.SealManager"%>
<%@page import="com.zzqa.pojo.seal.Seal"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%@page import="com.zzqa.util.FormTransform"%>
<%
	request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	PermissionsManager permissionsManager=(PermissionsManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("permissionsManager");
	SealManager sealManager=(SealManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("sealManager");
	File_pathManager file_pathManager=(File_pathManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("file_pathManager");
	FlowManager flowManager=(FlowManager)WebApplicationContextUtils
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
	if (session.getAttribute("seal_id") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int seal_id = (Integer) session.getAttribute("seal_id");
	Seal seal=sealManager.getSealByID(seal_id);
	Flow flow=flowManager.getNewFlowByFID(14, seal_id);
	if(flow==null||seal==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int apply_d = seal.getApply_department();
	int seall_type=seal.getType();
	boolean flag=(apply_d>8 && apply_d<16 && apply_d!=14 && (seall_type==0 || seall_type==1));
	List<File_path> files=file_pathManager.getAllFileByCondition(14, seal_id, 1, 0);
	seal.setReason(new FormTransform().transRNToBR(seal.getReason()));
	int operation=flow.getOperation();
	Map drawMap=sealManager.getSealFlowForDraw(seal, flow);
	boolean canApprove=(((operation==1||operation==3)&&sealManager.canApproveSeal(mUser, seal))||(flag&&(operation==2||operation==7)&&permissionsManager.checkPermission(mUser.getPosition_id(),9)));
	boolean canConfirm=((!flag && operation==2) || (flag&& operation==6))&&permissionsManager.checkPermission(mUser.getPosition_id(),DataUtil.getSealManagerPermission(seal.getType()));
	List<Flow> reasonList = flowManager.getReasonList(14, seal_id);
	String[] departmentArray = DataUtil.getdepartment();
	String[][] sealArray=DataUtil.getSealArray();
	pageContext.setAttribute("mUser", mUser);
	pageContext.setAttribute("departmentArray", departmentArray);
	pageContext.setAttribute("sealArray", sealArray);
	pageContext.setAttribute("drawMap", drawMap);
	pageContext.setAttribute("operation",operation);
	pageContext.setAttribute("seal", seal);
	pageContext.setAttribute("reasonList", reasonList);
	pageContext.setAttribute("canApprove", canApprove);
	pageContext.setAttribute("canConfirm", canConfirm);
	pageContext.setAttribute("files", files);
	pageContext.setAttribute("flag", flag);
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>用印申请流程</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/top.css">
<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
<link rel="stylesheet" type="text/css" href="css/seal.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/showdate2.js"></script>
<script type="text/javascript" src="js/public.js"></script>
<script type="text/javascript" src="js/dialog.js"></script>
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
		$(function(){
			$(".table_tr1_td6").text(timeTransLongToStr(<%=seal.getApply_time()%>, 4, "/",false));
			$(".td2_table td:odd").css({"text-align":"left","padding":"0 5px"});
			$(".table_tr2_td2").css("line-height","18px");
		});
		function verifyFlow(isagree){
			if($(".div_testarea").val().trim().length==0){
				initdiglog2("提示信息","请输入意见或建议");
				return;
			}
			document.flowform.type.value="sealflow";
			document.flowform.isagree.value=isagree;
			document.flowform.submit();
		}
		function confirm(){
			if($(".div_testarea").val().trim().length==0){
				initdiglog2("提示信息","请输入意见或建议");
				return;
			}
			document.flowform.type.value="sealflow";
			document.flowform.submit();
		}
		function deleteSeal(){
			initdiglogtwo2("提示信息","你确定要撤销本次用印申请吗？");
	   		$( "#confirm2" ).click(function() {
	   			$( "#twobtndialog" ).dialog( "close" );
	   			if($(".div_testarea").val().trim().length>0){
	   				document.flowform.type.value="deleteSeal";
	   				document.flowform.submit();
				}else{
					initdiglog2("提示信息","请输入撤销原因");
					return;
				}
	   		});
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
				<td class="table_center_td2_notfull">
					<%--不加总经理审核 --%>
					<%-- <div class='<c:out value="${drawMap.title1_flow}"></c:out>'>
						<div class='<c:out value="${drawMap.color1}"></c:out>'>提交用印单</div>
						<div class='<c:out value="${drawMap.color2}"></c:out>'>用印审批</div>
						<div class='<c:out value="${drawMap.color3}"></c:out>'>印章管理人执行</div>
						<div class='<c:out value="${drawMap.color4}"></c:out>'><c:out value='${operation==5?"已撤销":"结束"}'></c:out></div>
					</div>
					<div class='<c:out value="${drawMap.title2_flow}"></c:out>'>
						<img src="images/<c:out value="${drawMap.img1}"></c:out>">
						<div class='<c:out value="${drawMap.bg_color1}"></c:out>'></div>
						<img src="images/<c:out value="${drawMap.img2}"></c:out>">
						<div class='<c:out value="${drawMap.bg_color2}"></c:out>'></div>
						<img src="images/<c:out value="${drawMap.img3}"></c:out>">
						<div class='<c:out value="${drawMap.bg_color3}"></c:out>'></div>
						<img src="images/<c:out value="${drawMap.img4}"></c:out>">
					</div>
					<div class='<c:out value="${drawMap.title3_flow}"></c:out>'>
						<div><c:out value="${drawMap.time1}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time2}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time3}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time4}" escapeXml="false"></c:out></div>
					</div> --%>
					<%--加总经理审核后的流程 --%>
					<c:if test="${flag}">
						<div class='<c:out value="${drawMap.title1_flow}"></c:out>'>
							<div class='<c:out value="${drawMap.color1}"></c:out>'>提交用印单</div>
							<div class='<c:out value="${drawMap.color2}"></c:out>'>用印审批</div>
							<div class='<c:out value="${drawMap.color3}"></c:out>'>总经理审批</div>
							<div class='<c:out value="${drawMap.color4}"></c:out>'>印章管理人执行</div>
							<div class='<c:out value="${drawMap.color5}"></c:out>'><c:out value='${operation==5?"已撤销":"结束"}'></c:out></div>
						</div>
						<div class='<c:out value="${drawMap.title2_flow}"></c:out>'>
							<img src="images/<c:out value="${drawMap.img1}"></c:out>">
							<div class='<c:out value="${drawMap.bg_color1}"></c:out>'></div>
							<img src="images/<c:out value="${drawMap.img2}"></c:out>">
							<div class='<c:out value="${drawMap.bg_color2}"></c:out>'></div>
							<img src="images/<c:out value="${drawMap.img3}"></c:out>">
							<div class='<c:out value="${drawMap.bg_color3}"></c:out>'></div>
							<img src="images/<c:out value="${drawMap.img4}"></c:out>">
							<div class='<c:out value="${drawMap.bg_color4}"></c:out>'></div>
							<img src="images/<c:out value="${drawMap.img5}"></c:out>">
						</div>
						<div class='<c:out value="${drawMap.title3_flow}"></c:out>'>
							<div><c:out value="${drawMap.time1}" escapeXml="false"></c:out></div>
							<div><c:out value="${drawMap.time2}" escapeXml="false"></c:out></div>
							<div><c:out value="${drawMap.time3}" escapeXml="false"></c:out></div>
							<div><c:out value="${drawMap.time4}" escapeXml="false"></c:out></div>
							<div><c:out value="${drawMap.time5}" escapeXml="false"></c:out></div>
						</div>
					</c:if>
					<c:if test="${!flag}">
						<div class='<c:out value="${drawMap.title1_flow}"></c:out>'>
							<div class='<c:out value="${drawMap.color1}"></c:out>'>提交用印单</div>
							<div class='<c:out value="${drawMap.color2}"></c:out>'>用印审批</div>
							<div class='<c:out value="${drawMap.color3}"></c:out>'>印章管理人执行</div>
							<div class='<c:out value="${drawMap.color4}"></c:out>'><c:out value='${operation==5?"已撤销":"结束"}'></c:out></div>
						</div>
						<div class='<c:out value="${drawMap.title2_flow}"></c:out>'>
							<img src="images/<c:out value="${drawMap.img1}"></c:out>">
							<div class='<c:out value="${drawMap.bg_color1}"></c:out>'></div>
							<img src="images/<c:out value="${drawMap.img2}"></c:out>">
							<div class='<c:out value="${drawMap.bg_color2}"></c:out>'></div>
							<img src="images/<c:out value="${drawMap.img3}"></c:out>">
							<div class='<c:out value="${drawMap.bg_color3}"></c:out>'></div>
							<img src="images/<c:out value="${drawMap.img4}"></c:out>">
						</div>
						<div class='<c:out value="${drawMap.title3_flow}"></c:out>'>
							<div><c:out value="${drawMap.time1}" escapeXml="false"></c:out></div>
							<div><c:out value="${drawMap.time2}" escapeXml="false"></c:out></div>
							<div><c:out value="${drawMap.time3}" escapeXml="false"></c:out></div>
							<div><c:out value="${drawMap.time4}" escapeXml="false"></c:out></div>
						</div>
					</c:if>
					<div class="td2_div2">用印申请表</div>
					<form
							action="NewFlowServlet" method="post" name="flowform">
							<input type="text"  name="display"  style="display:none"/><!-- 防止按回车直接上传 -->
							<input type="hidden"  name="type" value="sealflow"/>
							<input type="hidden"  name="operation" value="<%=operation%>"/>
							<input type="hidden"  name="isagree"/>
					<div class="td2_div3">
						<div>申请人：<c:out value="${seal.create_name}"></c:out></div>
						<div>审批人：<c:out value="${seal.approve_name}"></c:out></div>
						<div>执行人：<c:out value="${seal.executor_name}"></c:out></div>
					</div>
					<table class="td2_table">
						<tr class="table_tr1">
							<td class="table_tr1_td1">申请部门</td>
							<td class="table_tr1_td2">
								<c:out value="${departmentArray[seal.apply_department]}"></c:out>
							</td>
							<td class="table_tr1_td3">使用印章</td>
							<td class="table_tr1_td4">
								<c:out value="${sealArray[seal.type][0]}"></c:out>
							</td>
							<td class="table_tr1_td5">申请时间</td>
							<td class="table_tr1_td6">
								
							</td>
						</tr>
						<tr class="table_tr2">
							<td class="table_tr2_td1">用印事由</td>
							<td class="table_tr2_td2"  colspan="5">
								<c:out value="${seal.reason}" escapeXml="false"></c:out>
							</td>
						</tr>
						<tr class="table_tr3">
							<td class="table_tr3_td1">受印单位</td>
							<td class="table_tr3_td2 tooltip_div"  colspan="3">
								<c:out value="${seal.seal_user}"></c:out>
							</td>
							<td class="table_tr3_td3">受印数量</td>
							<td class="table_tr3_td4" >
								<c:out value="${seal.num}"></c:out>
							</td>
						</tr>
						<tr class="table_tr2">
							<td class="table_tr2_td1">附件</td>
							<td class="table_tr2_td2"  colspan="5">
								<div class="div_file_list" id="div_file_list">
								<c:forEach items="${files}" var="file_path">
									<div class="div_file_item">
										<a href="javascript:void()" onclick="fileDown(<c:out value="${file_path.id}"></c:out>)"><c:out value="${file_path.file_name}"></c:out></a>
									</div>
								</c:forEach>
								</div>
							</td>
						</tr>
					</table>
					<c:if test="${reasonList!= null && fn:length(reasonList) >0}">
					<table class="td2_table8">
					<c:forEach items="${reasonList}" var="reasonFlow">
					<tr>
						<td class="td2_table8_left">
							<div>
								<c:out value="${reasonFlow.reason}" escapeXml="false"></c:out>
							</div>
						</td>
						<td class="td2_table8_right">
								<c:if test="${reasonFlow.operation!=2&&reasonFlow.operation!=3&&reasonFlow.operation!=4}">
									<div class="td2_div5_bottom_noimg">
								</c:if>
								<c:if test="${reasonFlow.operation==2 || reasonFlow.operation==6}">
									<div class="td2_div5_bottom_agree">
								</c:if>
								<c:if test="${reasonFlow.operation==3 || reasonFlow.operation==7}">
									<div class="td2_div5_bottom_disagree">
								</c:if>
								<c:if test="${reasonFlow.operation==4}">
									<div class="td2_div5_bottom_confirm">
								</c:if>
								<div style="height: 15px;"></div>
								<div class="td2_div5_bottom_right1"><c:out value="${reasonFlow.username}"></c:out></div>
								<div class="td2_div5_bottom_right2"><c:out value="${reasonFlow.create_date}"></c:out></div>
							</div>
						</td>
					</tr>
					</c:forEach>
					</table>
					</c:if>
					<c:if test="${canApprove||(mUser.id==seal.create_id&&operation<4||canConfirm)}">
					<textarea name="reason" class="div_testarea" placeholder="请输入意见或建议" required="required" maxlength="500"></textarea>
					</c:if>
					<div class="btn_group">
						<c:if test="${mUser.id==seal.create_id&&operation!=4}">
							<div class="div_disagree" onclick="deleteSeal()">撤销</div>
						</c:if>
						<c:if test="${mUser.id==seal.create_id&&(operation==1||operation==3||operation==7)}">
							<div class="div_agree" onclick="window.location.href='<%=basePath %>flowmanager/update_sealflow.jsp'">修改</div>
						</c:if>
						<c:if test="${canApprove}">
							<div class="div_agree" onclick="verifyFlow(0)">同意</div>
							<c:if test="${operation==1 || (operation==2 && flag)}">
							<div class="div_disagree" onclick="verifyFlow(1)">不同意</div>
						</c:if>
						</c:if>
						<c:if test="${canConfirm}">
							<div class="div_agree" onclick="confirm();">确认</div>
						</c:if>
					</div>
					</form>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
