<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%@page import="com.zzqa.service.interfaces.aftersales_task.Aftersales_taskManager"%>
<%@page import="com.zzqa.pojo.aftersales_task.Aftersales_task"%>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page import="com.zzqa.service.interfaces.file_path.File_pathManager"%>
<%@page import="com.zzqa.pojo.file_path.File_path"%>
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
	Aftersales_taskManager aftersales_taskManager=(Aftersales_taskManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("aftersales_taskManager");
	FlowManager flowManager=(FlowManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("flowManager");
	File_pathManager file_pathManager=(File_pathManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("file_pathManager");
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
	if (session.getAttribute("aftersales_tid") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int aftersales_tid = (Integer) session.getAttribute("aftersales_tid");
	Aftersales_task aftersales_task=aftersales_taskManager.getAlterSales_TaskByID(aftersales_tid);
	if(aftersales_task==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	Flow flow=flowManager.getNewFlowByFID(13, aftersales_tid);
	int operation=flow.getOperation();
	if(aftersales_task.getCreate_id()!=uid||(operation!=1&&operation!=3)){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	List<File_path> file_paths=file_pathManager.getAllFileByCondition(13, aftersales_tid, 1, 0);
	String[] pCategoryArray=DataUtil.getPCategoryArray();
	String[] productTypeArray=DataUtil.getProductTypeArray();
	String[] pCaseArray=DataUtil.getPCaseArray();
	pageContext.setAttribute("pCategoryArray", pCategoryArray);
	pageContext.setAttribute("productTypeArray", productTypeArray);
	pageContext.setAttribute("pCaseArray", pCaseArray);
	pageContext.setAttribute("aftersales_task", aftersales_task);
	pageContext.setAttribute("file_paths", file_paths);
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
<!--[if IE]>
	<script src="js/html5shiv.min.js" type="text/javascript"></script>
<![endif]-->
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
		var file_num=<%=file_paths.size()%>; 
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
			var n=file_num+successUploadFileNum1;
			if(n==0){
				initdiglog2("提示信息","请上传附件");
				return;
			}
			if($(".div_testarea").val().replace(/[ ]/g, "").length==0){
				initdiglog2("提示信息","请输入备注");
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
						action="NewFlowServlet" method="post" name="flowform">
						<input type="hidden" name="type" value="alteraftersales_task">
						<input type="hidden" name="delFileIDs" value="">
						<input type="hidden" name="operation" value="<%=operation%>">
					<div class="td2_div1">售后任务单</div>
					<div class="div_dashed"></div>
					<div class="td2_div2">
						<div class="div_ptype">
							<div>
							<span>项目类型：</span>
							<select name="project_category">
							<c:forEach items="${pCategoryArray}" var="pcategory" varStatus="pc_status">
								<option value="<c:out value='${pc_status.index}'></c:out>" <c:out value='${pc_status.index==aftersales_task.project_category?"selected":""}'></c:out>><c:out value='${pcategory}'></c:out></option>
							</c:forEach>
							</select>
							</div>
							<div>
							<span>产品类型：</span>
							<select name="product_type">
							<c:forEach items="${productTypeArray}" var="productType" varStatus="pt_status">
								<option value="<c:out value='${pt_status.index}'></c:out>" <c:out value='${pt_status.index==aftersales_task.product_type?"selected":""}'></c:out>><c:out value='${productType}'></c:out></option>
							</c:forEach>
							</select>
							</div>
						</div>
						<div class="div_name">
							<span>项目名称：</span>
							<input type="text" name="project_name" maxlength="100" value="<c:out value='${aftersales_task.project_name}'></c:out>">
						</div>
						<div class="div_ptype">
							<div>
							<span>任务单编号：</span>
							<input type="text" name="project_id" maxlength="50" oninput="checkNum(this)" value="<c:out value='${aftersales_task.project_id}'></c:out>">
							</div>
							<div>
							<span>项目情况：</span>
							<select name="project_case">
							<c:forEach items="${pCaseArray}" var="pCase" varStatus="p_status">
								<option value="<c:out value='${p_status.index}'></c:out>"  <c:out value='${p_status.index==aftersales_task.project_case?"selected":""}'></c:out> ><c:out value='${pCase}'></c:out></option>
							</c:forEach>
							</select>
							</div>
						</div>
					</div>
					<div class="div_dashed"></div>
					<div class="file_num" id="file_num">附件（<c:out value='${ fn:length(file_paths)}'></c:out>个）</div>
					<div class="div_file_list" id="div_file_list">
						 <c:forEach items="${file_paths}" var="file_path">
						<div id="file_item<c:out value='${file_path.id}'></c:out>" class="div_file_item">
							<a href="javascript:void()" onclick="fileDown(<c:out value='${file_path.id}'></c:out>)"><c:out value="${file_path.file_name}"></c:out></a>
							<a class="img_a" href="javascript:void(0);" onclick="delFile(<c:out value='${file_path.id}'></c:out>,'<c:out value='${file_path.file_name}'></c:out>');this.blur();">[删除]</a>
						</div>
						</c:forEach>
					</div>
					</div>
					<textarea name="reason" class="div_testarea" placeholder="请输入备注" required="required" maxlength="500"></textarea>
					<div class="btn_group">
						<div class="div_file"  onclick="$('#contract_file_div .jFiler-input').click()">添加附件</div>
						<div class="div_agree" onclick="addFlow()">提交</div>
						<div class="div_cancel" onclick="window.location.href='<%=basePath%>flowmanager/aftersalestaskflow_detail.jsp'">取消</div>
					</div>
					</form>
				</td>
			</tr>
		</table>
		
	</div>
</body>
</html>
