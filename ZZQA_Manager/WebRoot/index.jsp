<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>欢迎页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!-- <link rel="stylesheet" type="text/css" href="styles.css"> -->

	<style type="text/css">
		body {
			text-align:center;
			margin:0;
		}
		.notice{
			background:url(./images/notice.gif);
		    width:1140px;
		    height:665px;
			margin:0 auto;
		}
		.content{
			color:#f1831d;
			line-height:50px;
			padding-top:350px;
			padding-left:100px;
			font-size:20;
			font-family:Microsoft YaHei;
			text-align:left;
		}
		a:link ,
		a:visited ,
		a:hover ,
		a:active {
		    color:#1253a4;
		}
	</style>
  </head>
  <script type="text/javascript">
  	var isChrome = window.navigator.userAgent.indexOf("Chrome") !== -1;
    if (isChrome) {
        window.location.href="flowmanager/backlog.jsp";
    }
  </script>
  <body>
  <div class="notice">
  	<div class="content">
  	尊敬的用户，我们检测到您使用的浏览器并不是本系统推荐的浏览器，可能会出现异常<br>
    本系统完美适配谷歌Chrome浏览器，请使用该浏览器打开，如果您的电脑没有安装，请点击此处<a href="chrome_installer.exe">下载并安装</a><br>
    如果您确定正在使用的浏览器支持HTML5协议，可以点击此处<a href="flowmanager/backlog.jsp">继续访问</a>（不推荐）
    </div>
   </div>
  </body>
</html>
