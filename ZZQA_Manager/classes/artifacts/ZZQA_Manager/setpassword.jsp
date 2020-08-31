<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html style="background:#EDEDED;height:100%">
<head>
<base href="<%=basePath%>">

<title>找回密码</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/login.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/dialog.js"></script>
<script type="text/javascript" src="js/public.js"></script>
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript">
function updatePassword(){
	var pw=$("#pw").val();
	var pw_confirm=$("#pw_confirm").val();
	if(pw.length==0){
		initdiglog2("提示信息", "请输入密码！");
		return;
	}
	if(pw!=pw_confirm){
		initdiglog2("提示信息", "两次密码不一致！");
		return;
	}
	document.pwform.submit();
}
</script>
</head>

<body style="background:#EDEDED;height:100%">
<div class="findpw-body">
	<div class="findpw-top">
		<a href="http://www.windit.com.cn/" target="_blank"><img
			src="images/logo_top.gif"> </a>
	</div>
	<form action="UserManagerServlet" method="post" name="pwform">
		<input type="hidden" name="type" value="resetpw">
		<input type="hidden" name="uid" value="<%=request.getAttribute("uid")%>">
		<div class="findpw-content">
		<div class="findpw-title">找回密码</div>
		<div class="findpw-title1"><span>1.填写邮箱 》2.邮箱验证 》</span><span>3.重置密码</span></div>
		<div class="findpw-div">
				<div class="data-div">
				<label>重置密码：</label><input type="password" id="pw" name="pw" maxlength="35">
			</div>
			<div class="data-div">
				<label>确认密码：</label><input type="password" id="pw_confirm" name="pw_confirm" maxlength="35">
			</div>
			<div class="findpw-btn2" onclick="updatePassword();">确认</div>
			</div>
			</div>
	</form>
	</div>
</body>
</html>
