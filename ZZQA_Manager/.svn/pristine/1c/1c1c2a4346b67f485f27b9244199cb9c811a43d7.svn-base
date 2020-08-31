<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	PermissionsManager permissionsManager=(PermissionsManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("permissionsManager");
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
	if(!permissionsManager.checkPermission(mUser.getPosition_id(), 76)){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	String[] pCategoryArray=DataUtil.getPCategoryArray();
	String[] productTypeArray=DataUtil.getProductTypeArray();
	String[] pCaseArray=DataUtil.getPCaseArray();
	pageContext.setAttribute("pCategoryArray", pCategoryArray);
	pageContext.setAttribute("productTypeArray", productTypeArray);
	pageContext.setAttribute("pCaseArray", pCaseArray);
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>售后任务单</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/top.css">
<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
<link rel="stylesheet" type="text/css" href="css/aftersalestaskflow.css">
<link rel="stylesheet" type="text/css" href="css/custom.css">
<link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
<link rel="stylesheet" type="text/css" href="css/default.css">
<link rel="stylesheet" type="text/css"
	href="css/jquery.filer-dragdropbox-theme.css">
<script src="js/showdate1.js" type="text/javascript"></script>
<script src="js/prettify.js" type="text/javascript"></script>
<script  type="text/javascript" src="js/jquery.min.js"></script>
<script src="js/jquery.filer.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
<script  type="text/javascript" src="js/jquery-ui.min.js"></script>
<script  type="text/javascript" src="js/dialog.js"></script>
<script  type="text/javascript" src="js/public.js"></script>
<script type="text/javascript" src="js/aftersales_task.js"></script>
<!-- 选将input加载到body再由custom.js渲染 -->
<script src="js/custom.js" type="text/javascript"></script>
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
		var file_num=0;
		function addFlow(){
			var project_name=document.flowform.project_name.value;
			if(project_name.trim().length==0){
				initdiglog2("提示信息", "项目名称不能为空");
				return;
			}
			var project_id=document.flowform.project_id.value;
			if(project_id.trim().length==0){
				initdiglog2("提示信息", "项目编号不能为空");
				return;
			}
			if(successUploadFileNum1==0){
				initdiglog2("提示信息", "请上传附件");
				return;
			}
			var project_category=document.flowform.project_category.value;
			if(project_category==5){
				initdiglog2("提示信息", "新产品试装项目没有售后服务");
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
				<div class="td2_div0">
				<form
						action="NewFlowServlet?type=addaftersales_task&file_time=<%=System.currentTimeMillis() %>"
						method="post" name="flowform">
					<div class="td2_div1">售后任务单</div>
					<div class="div_dashed"></div>
					<div class="td2_div2">
						<div class="div_ptype">
							<div>
							<span>项目类型：</span>
							<select name="project_category">
							<c:forEach items="${pCategoryArray}" var="pcategory" varStatus="pc_status">
								<option value="<c:out value='${pc_status.index}'></c:out>"><c:out value='${pcategory}'></c:out></option>
							</c:forEach>
							</select>
							</div>
							<div>
							<span>产品类型：</span>
							<select name="product_type">
							<c:forEach items="${productTypeArray}" var="productType" varStatus="pt_status">
								<option value="<c:out value='${pt_status.index}'></c:out>"><c:out value='${productType}'></c:out></option>
							</c:forEach>
							</select>
							</div>
						</div>
						<div class="div_name">
							<span>项目名称：</span>
							<input type="text" name="project_name" maxlength="100">
						</div>
						<div class="div_ptype">
							<div>
							<span>任务单编号：</span>
							<input type="text" name="project_id" maxlength="50" oninput="checkNum(this)">
							</div>
							<div>
							<span>项目情况：</span>
							<select name="project_case">
							<c:forEach items="${pCaseArray}" var="pCase" varStatus="p_status">
								<option value="<c:out value='${p_status.index}'></c:out>"><c:out value='${pCase}'></c:out></option>
							</c:forEach>
							</select>
							</div>
						</div>
					</div>
					</form>
					<div class="div_dashed"></div>
					<div class="file_num" id="file_num">附件</div>
					<div class="div_file_list" id="div_file_list">
					</div>
					</div>
					<div class="btn_group">
						<div class="div_file"  onclick="$('#contract_file_div .jFiler-input').click()">添加附件</div>
						<div class="div_agree" onclick="addFlow()">提交</div>
						<div class="div_cancel" onclick="window.location.href='<%=basePath%>flowmanager/newflow.jsp'">取消</div>
					</div>
				</td>
			</tr>
		</table>
		
	</div>
</body>
</html>
