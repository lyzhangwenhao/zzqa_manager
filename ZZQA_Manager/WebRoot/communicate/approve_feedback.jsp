<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.communicate.CommunicateManager"%>
<%@page import="com.zzqa.pojo.feedback.Feedback"%>
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
	int appfeedback_nowpage=1;
	if(session.getAttribute("appfeedback_nowpage")!=null){
		appfeedback_nowpage=(Integer)session.getAttribute("appfeedback_nowpage");
	}
	int count=communicateManager.getFeedbackCountByCondition(0);
	int allpage=count==0?1:(count/10+(count%10==0?0:1));
	if(appfeedback_nowpage>allpage){
		appfeedback_nowpage=allpage;
	}
	session.setAttribute("feedback_index", 6);
%>

<!DOCTYPE HTML>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>审核反馈</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/communicate.css">
		<link rel="stylesheet" type="text/css" href="css/feedback.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
		var nowpage=<%=appfeedback_nowpage%>;
		var allpage=<%=allpage%>;
		function jumpToFeedback(id){
			document.jumpform.jumpID.value=id;
			document.jumpform.jumpType.value=9;
			document.jumpform.submit();
		}
		function beginPage(){
			if(nowpage==1){
				//initdiglog2("提示信息","已经是首页！");
			}else{
				nowpage=1;
			}
			getFeedback();
		}
		function beforePage(){
			if(nowpage==1){
				//initdiglog2("提示信息","已经是首页！");
			}else{
				nowpage--;
			}
			getFeedback();
		}
		function nextPage(){
			if(nowpage==allpage){
				//initdiglog2("提示信息","已经是最后一页！");
			}else{
				nowpage++;
			}
			getFeedback();
		}
		function lastPage(){
			if(nowpage==allpage){
				//initdiglog2("提示信息","已经是最后一页！");
			}else{
				nowpage=allpage;
			}
			getFeedback();
		}
		function getFeedback(){
			$.ajax({
				type:"post",//post方法
				url:"CommunicateServlet",
				data:{"type":"getFeedback","nowpage":nowpage,"create_id":0},
				timeout : 15000, 
				dataType:'json',
				//ajax成功的回调函数
				success:function(returnData){
					//加载成功
					if(returnData.length>0){
						var html="";
						for(var i=0;i<returnData.length;i++){
							var feedback=returnData[i];
							html+='<div class="feedback_item_common" onclick="jumpToFeedback('+feedback.id+')">'
									+'<div '+(feedback.read?'':' class="point_notread"')+'></div><div class="tooltip_div">'+feedback.title+'</div><div >'+feedback.update_date
									+'</div><div class="tooltip_div">'+feedback.create_name+'</div></div>';
						}
						$(".feedback_list_common").html(html);
					}else{
						initdiglog2("提示信息","没有更多反馈");
						allpage--;
						nowpage--;
					}
					var page_temp=(nowpage<=1?'<div class="page_normal" >首页</div><div class="page_normal">&lt;</div>':'<div class="page_press" onclick="beginPage()">首页</div><div class="page_press" onclick="beforePage()">&lt;</div>')
						+'<div>'+nowpage+'/'+allpage+'</div>'
						+(nowpage>=allpage?'<div class="page_normal">&gt;</div><div class="page_normal">尾页</div>':'<div class="page_press" onclick="nextPage()">&gt;</div><div class="page_press" onclick="lastPage()">尾页</div>');
					$(".page_div").html(page_temp);
				},
				complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
					if(status!='success'){//超时,status还有success,error等值的情况
						if(status=='timeout'){
							initdiglog2("提示信息","请求超时！");
						}else{
							initdiglog2("提示信息","操作异常,请重试！");
						}
					}
					showToolTip();
				}
			});
		}
		$(function(){
			if(<%=count==0%>){
				$(".feedback_list_common").html('<div class="no_feedback_div">没有反馈</div>');
			}else{
				getFeedback();
			}
		});
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
			<jsp:param name="index" value="5" />
			</jsp:include>
			<div class="div_center_right">
				<div class="div_title">
					审核反馈
					</div>
					<div class="div_dashed"></div>
					<div class="feedback_list_common">
					
					</div>
					<div class="page_div"></div>
			</div>
		</div>
		<form action="CommunicateServlet" name="jumpform" method="post" >
			<input type="hidden" name="type" value="jumpUrl">
			<input type="hidden" name="jumpType">
			<input type="hidden" name="jumpID">
		</form>
	</body>
</html>
