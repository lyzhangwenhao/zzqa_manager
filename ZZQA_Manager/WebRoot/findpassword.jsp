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
     function reload(){  
        document.getElementById("image").src="<%=basePath%>ImageServlet?date="+new Date().getTime();  
        $("#checkcode").val("");   // 将验证码清空
        flag=false;
     }
     function verificationcode(){  
         var text=$.trim($("#checkcode").val());  
         $.post("<%=basePath%>ImageServlet",{type:'check',code:text},function(data){  
             data=parseInt($.trim(data));
             if(data==0){  
                 $("#span").text("验证成功!").css("color","green");
                 flag=true;
             }else{  
                 $("#span").text("验证失败!").css("color","red");
                 reload();
             }  
         });  
     }
     $(function(){
    	 $('#checkcode').bind('input propertychange', function() {
    		 if($("#checkcode").val().length==4){
    			 verificationcode();
    		 }else{
    			 $("#span").text("");
                 flag=false;
    		 }
         });
     });
     var flag=false;
     function updatePassword(){
    	 if(!flag){
    		 initdiglog2("提示信息", "请输入正确的验证码！");
    		 return;
    	 }
    	 var mail=$.trim($("#mail").val());
    	 if(mail.length==0||!testEmail(mail)){
    		 initdiglog2("提示信息", "请输入正确的邮箱地址！");
    		 return;
    	 }
    	 reload();
    	 $("#span").text("");
		 $.post("<%=basePath%>ImageServlet", {
			type : 'sendmail',
			"mail" : mail
		}, function(data) {
			data = parseInt($.trim(data));
			if (data == 0) {
				initdiglog2("提示信息", "邮件已发送，请及时修改密码");
			} else {
				initdiglog2("提示信息", "找不到该邮箱！");
			}
		});
	}
</script>
</head>

<body style="background:#EDEDED;height:100%">
<div class="findpw-body">
	<div class="findpw-top">
		<a href="http://www.windit.com.cn/" target="_blank"><img
			src="images/logo_top.gif"> </a>
	</div>
	<form action="UserManagerServlet" method="post">
		<input type="hidden" name="type" value="findpassword">
		<div class="findpw-content">
		<div class="findpw-title">找回密码</div>
		<div class="findpw-div">
				<div class="data-div">
				<label>邮箱号：</label><input type="text" id="mail" name="mail"><span></span>
			</div>
			<div class="verificationcode">
				<label>验证码：</label><input type="text" name="checkcode"
					id="checkcode" maxlength="4" /> <img
					src="<%=basePath%>ImageServlet" alt="验证码" id="image"
					onclick="reload();" title="换一换" /><a href="javascript:reload();">换一换</a><span id="span"></span>
			</div>
			<div class="findpw-btn1" onclick="updatePassword();">找回密码</div>
			</div>
			</div>
	</form>
	</div>
</body>
</html>
