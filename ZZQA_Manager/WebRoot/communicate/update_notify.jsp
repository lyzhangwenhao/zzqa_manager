<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.pojo.notify.Notify"%>
<%@page import="com.zzqa.pojo.file_path.File_path"%>
<%@page import="com.zzqa.service.interfaces.file_path.File_pathManager"%>
<%@page import="com.zzqa.service.interfaces.communicate.CommunicateManager"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%@page import="java.text.DecimalFormat"%>
<%request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	CommunicateManager communicateManager=(CommunicateManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("communicateManager");
	File_pathManager file_pathManager=(File_pathManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("file_pathManager");
	if (session.getAttribute("uid") == null) {
		response.sendRedirect("login.jsp");
		return;
	}
	int uid = (Integer) session.getAttribute("uid");
	User mUser = userManager.getUserByID(uid);
	if (mUser == null) {
		response.sendRedirect("login.jsp");
		return;
	}
	if (session.getAttribute("notify_id") == null) {
		response.sendRedirect("login.jsp");
		return;
	}
	int notify_id = (Integer) session.getAttribute("notify_id");
	Notify notify=communicateManager.getNotifyByID(notify_id);
	List<File_path> filList=file_pathManager.getAllFileByCondition(23, notify_id, 1, 0);
%>

<!DOCTYPE HTML>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>修改通知</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/mynotify.css">
		<link rel="stylesheet" type="text/css" href="css/communicate.css">
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
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script src="js/prettify.js" type="text/javascript"></script>
		<script src="js/jquery.filer.min.js" type="text/javascript"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		<script type="text/javascript" src="js/communicate.js"></script>
		<!-- 现将隐藏的文件上传控件添加到body中，再渲染 -->
		<script src="js/custom.js" type="text/javascript"></script>
		
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
			successUploadFileNum20=<%=filList.size()%>;
			function publish(){
				if(document.notifyform.notify_title.value.replace(/\s/g,"").length==0){
					initdiglog2("提示信息", "标题不能为空！");
					return;
				}
				if(document.notifyform.notify_content.value.replace(/\s/g,"").length==0){
					initdiglog2("提示信息", "通知内容不能为空！");
					return;
				}
				document.notifyform.submit();
			}
			//删除图片
		   	function delFile(id,name){
		   		initdiglogtwo2("提示信息","你确定要删除图片<br/>【"+""+name+"】吗？");
		   		$( "#confirm2" ).click(function() {
					$( "#twobtndialog" ).dialog( "close" );
					Lock_CheckForm();
					$.ajax({
						type:"post",//post方法
						url:"DeleteFileServlet",
						data:{"id":id,"type":"delcommunicatefile"},
						//ajax成功的回调函数
						success:function(returnData){
							if(returnData==1){
								initdiglog2("提示信息","删除成功！");
								var na="#file_div"+id;
								$(na).remove();
								updateFileNum(--successUploadFileNum20);
							}else{
								initdiglog2("提示信息","删除失败！");
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
				});
		   	}
		</script>
	</head>

	<body>
		<jsp:include page="/top.jsp" >
	<jsp:param name="name" value="<%=mUser.getName() %>" />
	<jsp:param name="level" value="<%=mUser.getLevel() %>" />
	<jsp:param name="index" value="4" />
	</jsp:include>
		<div class="div_center">
			<jsp:include page="/communicate/communicateTab.jsp">
			<jsp:param name="index" value="4" />
			</jsp:include>
			<div class="div_center_right">
				<form action="CommunicateServlet?type=updatenotify&notify_id=<%=notify_id %>&file_time=<%=System.currentTimeMillis() %>" method="post" name="notifyform">
					<div class="notify_border">
						<input type="text" class="notify_title_input" name="notify_title" placeholder="填写标题"  maxlength="100" value="<%=notify.getTitle()%>">
						<div class="div_dashed2"></div>
						<textarea class="notify_content_textarea" placeholder="内容"  maxlength="2000" name="notify_content" ><%=notify.getContent()%></textarea>
						<div class="div_dashed2"></div>
						<div class="notify_publisher_div" >
							<input type="text" placeholder="匿名（选填）" name="notify_publisher"  maxlength="20" value="<%=notify.getPublisher()%>">
						</div>
						<div class="communicate_file_num">附件<%=filList.size()>0?("：（"+filList.size()+"个）"):"" %></div>
						<div class="communicate_file_publish_list">
						<%for(File_path file_path:filList){ %>
							<div id="file_div<%=file_path.getId()%>"><a href="javascript:fileDown(<%=file_path.getId() %>)" style="margin-left:0px"><%=file_path.getFile_name()%></a><a href="javascript:delFile(<%=file_path.getId() %>,'<%=file_path.getFile_name()%>')">删除</a></div>
							<%} %>
						</div>
					</div>
					<div class="notify_btngroup_div">
						<div class="add_file_div" onclick="$('#communicate_file_div .jFiler-input').click();">添加附件</div>
						<div class="add_notify_div" onclick="publish()">确定</div>
						<div class="cancel_notify_div" onclick="window.location.href='communicate/mynotify.jsp'">取 消</div>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>