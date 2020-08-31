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
	String[][] sealArray=DataUtil.getSealArray();
	pageContext.setAttribute("departmentArray", departmentArray);
	pageContext.setAttribute("sealArray", sealArray);
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>新建用印申请流程</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/top.css">
<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
<link rel="stylesheet" type="text/css" href="css/seal.css">
<link rel="stylesheet" type="text/css" href="css/custom.css">
<link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
<link rel="stylesheet" type="text/css" href="css/default.css">
<link rel="stylesheet" type="text/css"
	href="css/jquery.filer-dragdropbox-theme.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script src="js/prettify.js" type="text/javascript"></script>
<script src="js/jquery.filer.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/showdate2.js"></script>
<script type="text/javascript" src="js/public.js"></script>
<script type="text/javascript" src="js/dialog.js"></script>
<script type="text/javascript" src="js/seal.js"></script>
<!-- 选将input加载到body再由custom.js渲染 -->
<script src="js/custom.js" type="text/javascript"></script>
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
		$(function(){
			var today=timeTransLongToStr(0, 4, "/",false);
			$("#apply_date").val(today);
		});
		function addFlow(){
			var department=$("#department").val();
			if(department==0){
				initdiglog2("提示信息","请选择部门");
				return;
			}
			var seal_reason=$("#seal_reason").val();
			if(seal_reason.trim().length==0){
				initdiglog2("提示信息", "请输入用印事由");
				return;
			}
			var seal_user=$("#seal_user").val();
			if(seal_user.trim().length==0){
				initdiglog2("提示信息", "请输入受印单位");
				return;
			}
			var num=$("#num").val();
			if(num.length==0){
				initdiglog2("提示信息", "请输入受印数量");
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
					<jsp:param name="index" value="3" />
				</jsp:include>
				<td class="table_center_td2_notfull">
					<div class="td2_div2">用印申请表</div>
					<form
							action="NewFlowServlet" method="post" name="flowform">
							<input type="hidden"  name="file_time"  value="<%=System.currentTimeMillis()%>"/>
							<input type="text"  name="hide"  style="display:none"/><!-- 防止按回车直接上传 -->
							<input type="hidden"  name="type" value="addsealflow"/>
					<table class="td2_table">
						<tr class="table_tr1">
							<td class="table_tr1_td1">申请部门</td>
							<td class="table_tr1_td2">
								<select name="department" id="department">
									<c:forEach items="${departmentArray}" var="department" varStatus="d_status">
									<c:if test="${d_status.index!=3}">
									<option value="<c:out value="${d_status.index}"></c:out>"><c:out value="${department}"></c:out></option>
									</c:if>
									</c:forEach>
								</select>
							</td>
							<td class="table_tr1_td3">使用印章</td>
							<td class="table_tr1_td4">
								<select name="sealType" id="sealType">
								<c:forEach items="${sealArray}" var="sealType" varStatus="seal_status">
								<option value="<c:out value="${seal_status.index}"></c:out>"><c:out value="${sealType[0]}"></c:out></option>
								</c:forEach>
							</select></td>
							<td class="table_tr1_td5">申请时间</td>
							<td class="table_tr1_td6">
								<input type="text" id="apply_date" name="apply_date" class="input-show-time" readonly="">
								<img src="images/calendar.png" id="img2" onclick="return Calendar('apply_date');">
							</td>
						</tr>
						<tr class="table_tr2">
							<td class="table_tr2_td1">用印事由</td>
							<td class="table_tr2_td2"  colspan="5">
								<textarea  id="seal_reason" name="seal_reason" placeholder="请输入用印事由" maxlength="500"></textarea>
							</td>
						</tr>
						<tr class="table_tr3">
							<td class="table_tr3_td1">受印单位</td>
							<td class="table_tr3_td2 tooltip_div"  colspan="3">
								<input type="text" name="seal_user" id="seal_user" maxlength="100" placeholder="请输入受印单位" >
							</td>
							<td class="table_tr3_td3">受印数量</td>
							<td class="table_tr3_td4" >
								<input type="text" name="num" id="num" maxlength="5" oninput="checkIntPosition(this)">
							</td>
						</tr>
						<tr class="table_tr2" style="background: #eaf7ff;">
							<td class="table_tr2_td1">附件</td>
							<td class="table_tr2_td2" colspan="5">
								<div class="div_file_list" id="div_file_list">
								</div>
							</td>
						</tr>
					</table>
					<div class="btn_group">
						<div class="div_file" onclick="$('#contract_file_div .jFiler-input').click()">添加附件</div>
						<div class="div_agree" onclick="addFlow();">提交</div>
						<div class="div_cancel" onclick="window.location.href='<%=basePath %>flowmanager/newflow.jsp'">取消</div>
					</div>
					</form>
				</td>
			</tr>
		</table>

	</div>
</body>
</html>
