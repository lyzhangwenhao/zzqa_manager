<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page
	import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
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
	Position_userManager position_userManager = (Position_userManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("position_userManager");
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
	String[] flowArray=DataUtil.getFlowTypeArray();
	pageContext.setAttribute("flowArray", flowArray);
	pageContext.setAttribute("flowLen", flowArray.length);
	pageContext.setAttribute("mUser", mUser);
%>
<!DOCTYPE HTML>
<html>
	<head>
		<base href="<%=basePath%>">
		<title>用户详情</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/usermanager.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script language="javascript">
		var m=0;//表示用户名验证通过
		$(function(){
			var sendEmial="${mUser.sendEmail}";
			if(sendEmial=="null"||sendEmial==""){
				$(".sendMail_div input").prop("checked",true);
			}else{
				var array=sendEmial.split(";");
				var len=array.length;
				$(".sendMail_div input").each(function(i){
					if(len>i&&array[i]==1){
						$(this).prop("checked",false);
					}else{
						$(this).prop("checked",true);
					}
				});
			}
		}); 
		document.onkeydown = function(e){
	        if(!e) e = window.event;
	        if((e.keyCode || e.which) == 13){
	        	if($( "#onebtndialog" ).length>0){
	        		$( "#confirm1" ).click();
	        	}else if($( "#twobtndialog" ).length>0){
	        		$( "#confirm2" ).click();
	        	}
	        }
	    };
	    function saveEmail(){
	    	var sendEmail='';
	   		$(".sendMail_div label").each(function(i){
	   			if(i>0){
	   				sendEmail+=";";
	   			}
	   			sendEmail+=$(this).find("input").prop("checked")?0:1;
	   		});
	   		$.ajax({
				type:"post",//post方法
				url:"UserManagerServlet",
				timeout:15000,
				data:{"type":"receiveEmail","sendEmail":sendEmail},
				//ajax成功的回调函数
				success:function(returnData){
					if(returnData==1){
						initdiglog2("提示信息","保存成功！");
					}else{
						initdiglog2("提示信息","保存失败！");
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
	    }
	    $(function(){
	    	 $("input:radio[name='isEmail']").change(function () {
	    		 $("input:radio[name='isEmail']").blur();
	 	    	var isEmail=$("input[name='isEmail']:checked").val();
	 	    	
	 	    }); 	
	    });
	</script>
	</head>

	<body>
		<jsp:include page="/top.jsp">
			<jsp:param name="name" value="<%=mUser.getName()%>" />
			<jsp:param name="level" value="<%=mUser.getLevel()%>" />
			<jsp:param name="index" value="3" />
		</jsp:include>
		<div class="div_center">
			<jsp:include page="/usermanager/userTab.jsp">
			<jsp:param name="index" value="5" />
			</jsp:include>
			<div class="div_center_right">
				<div class="td2_div2">
					<fieldset class="fieldset">
						<legend>
							个人信息
						</legend>
						<table class="tab_user">
							<tr>
								<td class="tab_user_td1">
									用户名：
								</td>
								<td class="tab_user_td2">
									<%=mUser.getName()%>
								</td>
							</tr>
							<tr>
								<td class="tab_user_td1">
									密&nbsp&nbsp&nbsp码：
								</td>
								<td class="tab_user_td2">
									<div class="changepass" onclick="updatePassword()">修改密码</div>
								</td>
							</tr>
							<tr>
								<td class="tab_user_td1">
									邮&nbsp&nbsp&nbsp箱：
								</td>
								<td class="tab_user_td2">
									<%
										String mail = mUser.getEmail();
										if (mail != null && mail.length() > 0) {
											out.write(mail);
										} else {
											out.write("无");
										}
									%>
								</td>
							</tr>
							<tr>
								<td class="tab_user_td1">
									姓&nbsp&nbsp&nbsp名：
								</td>
								<td class="tab_user_td2">
									<%=mUser.getTruename()%>
								</td>
							</tr>
							<tr>
								<td class="tab_user_td1">
									职&nbsp&nbsp&nbsp位：
								</td>
								<td class="tab_user_td2">
									<%=mUser.getPosition_name()%>
								</td>
							</tr>
							<c:if test='${mUser.name!="admin"}'>
							<tr>
								<td class="tab_user_td1">
									提&nbsp&nbsp&nbsp醒：
								</td>
								<td class="tab_user_td2">
									<c:forEach begin="1"  end="${flowLen}"  step="3"  varStatus="flow_status">
								<div class="sendMail_div">
									<c:if test="${flow_status.index<flowLen}">
									<label title="${flowArray[flow_status.index]}">
										<input name="flowType" type="checkbox">
										${flowArray[flow_status.index]}
									</label>
									</c:if>
									<c:if test="${(flow_status.index+1)<flowLen}">
									<label title="${flowArray[flow_status.index+1]}">
										<input name="flowType" type="checkbox">
										${flowArray[flow_status.index+1]}
									</label>
									</c:if>
									<c:if test="${(flow_status.index+2)<flowLen}">
									<label title="${flowArray[flow_status.index+2]}">
										<input name="flowType" type="checkbox">
										${flowArray[flow_status.index+2]}
									</label>
									</c:if>
									</div>
								</c:forEach>
								</td>
							</tr>
							</c:if>
						</table>
						
					</fieldset>
					<c:if test='${mUser.name!="admin"}'>
					<div class="div_btn"><img src="images/submit_flow.png" onclick="saveEmail();"></div>
					</c:if>
				</div>
			</div>
	</body>
</html>
