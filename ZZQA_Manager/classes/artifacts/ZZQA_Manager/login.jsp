<%@page import="com.zzqa.util.DataUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	String sessionString=request.getParameter("session");
	if("0".equals(sessionString)){
		session.invalidate();
	}
%>
<!DOCTYPE HTML >
<html>
	<head>
		<base href="<%=basePath%>">
		<title>登入</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/login.css">
		<script src="js/jquery.min.js" type="text/javascript"></script>
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
			function login(){
				var username=$("#username").val();
				var password=$("#password").val();
				$("#login_error").text("");
				if(username.length>0&&password.length>0){
					if(document.getElementById("memory").checked){
	    				localStorage.setItem("Manager_username",$("#username").val());
	    				localStorage.setItem("Manager_password",$("#password").val());
			    	}else{
			    		localStorage.setItem("Manager_username","");
			    		localStorage.setItem("Manager_password","");
			    	}
					$.ajax({
						type:"post",//post方法
						url:"UserManagerServlet",
						timeout : 5000, //超时时间设置，单位毫秒
						data:{"type":"login","username":username,"password":password},
						//ajax成功的回调函数
						complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
							if(status=='timeout'){//超时,status还有success,error等值的情况
								$("#login_error").text("请求超时，请重试！"); 
							}
						}, 
						success:function(returnData){
							if(returnData==0){
								//存在
								window.location.href="<%=basePath%>UserManagerServlet?type=home";
							}else if(returnData==1){
								//密码错误
								$("#login_error").text("用户名或密码错误");
								localStorage.setItem("Manager_username","");
				    			localStorage.setItem("Manager_password","");
				    			document.getElementById("memory").checked=false; 
				    			$("#password").val("");
							}else if(returnData==2){
								//不存在
								$("#login_error").text("用户名不存在");
								localStorage.setItem("Manager_username","");
				    			localStorage.setItem("Manager_password","");
				    			document.getElementById("memory").checked=false;
				    			$("#username").val(""); 
				    			$("#password").val(""); 
							}
						}
					});
				}else{
					if(username.length==0&&password.length==0){
						$("#login_error").text("请输入用户名和密码");
					}else if(username.length==0){
						$("#login_error").text("请输入用户名");
					}else if(password.length==0){
						$("#login_error").text("请输入密码");
					}
				}
			}
			$(function() {
	            var username=localStorage.getItem("Manager_username");
	            var password=localStorage.getItem("Manager_password");
	            if(username!=null&&username!=""){
	            	$("#username").val(username);
	            	$("#password").val(password);
	            	document.getElementById("memory").checked=true; 
	            }
	            $("#username").focus();
	        });
	        document.onkeydown = function(e){
		        if(!e) e = window.event;
		        if((e.keyCode || e.which) == 13){
		            login();
		        }
		    };
		</script>

	</head>

	<body scroll="no">
		<div class="logo_div">
			<a href="http://www.windit.com.cn/" target="_blank"><img
					src="images/logo_top.gif">
			</a>
		</div>
		<div class="login_div">
			<div class="login_div2">
				<img src="images/logo_title.png" class="login_img_title" />
				<div id="login_error" class="login_error"></div>
				<div class="login_div_name">
					<img src="images/login_name_bg.gif"  />
					<input type="text" id="username" name="username" placeholder="账号" value=""
						maxlength="25" onkeydown="if(event.keyCode==32) return false">
				</div>
				<div class="login_div_name">
					<img src="images/login_password_bg.gif" />
					<input type="password" id="password" name="password" placeholder="密码"
						maxlength="35" onkeydown="if(event.keyCode==32) return false">
				</div>
				<label class="login_lable">
					<input id="memory" type="checkbox" />
					记住密码
				</label>
				<a href="<%=basePath %>findpassword.jsp" class="findpassword">找回密码</a>
				<img src="images/login_img.png" class="login_img_btn" onclick="login();" />
			</div>
		</div>
		<div class="login_bottom">Copyright&nbsp;©&nbsp;2016-<%=DataUtil.getCurrentYear() %>&nbsp;&nbsp;浙江中自庆安新能源技术有限公司V3.8</div>
	</body>

</html>
