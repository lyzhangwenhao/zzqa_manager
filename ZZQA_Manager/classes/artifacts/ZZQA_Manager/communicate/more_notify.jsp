<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.communicate.CommunicateManager"%>
<%@page import="com.zzqa.pojo.notify.Notify"%>
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
	Calendar calendar=Calendar.getInstance();
	int nowYear=calendar.get(Calendar.YEAR);
	int year;
	if(session.getAttribute("notifyyear")!=null){
		year=(Integer)session.getAttribute("notifyyear");
	}else{
		year=nowYear;
	}
	session.setAttribute("notify_index", 5);
%>

<!DOCTYPE HTML>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>更多通知</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/communicate.css">
		<link rel="stylesheet" type="text/css" href="css/mynotify.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
			function jumpToNotify(id){
				document.jumpform.jumpID.value=id;
				document.jumpform.jumpType.value=1;
				document.jumpform.submit();
			}
			function getNotify(year){
				$(".year_item_div_press").prop("class","year_auto_height year_item_div_normal");
				$("#yeardiv"+year).prop("class","year_auto_height year_item_div_press");
				$.ajax({
					type:"post",//post方法
					url:"CommunicateServlet",
					data:{"type":"getNotifyListByYear","year":year},
					timeout : 15000, 
					dataType:'json',
					//ajax成功的回调函数
					success:function(returnData){
						//加载成功
						if(returnData.length>0){
							var notify_index=0;
							var year_temp="";
							for(var i=12;i>0;i--){
								var month_temp="";
								while (notify_index<returnData.length) {
									var notify=returnData[notify_index];
									var month=new Date(notify.update_time).getMonth()+1;
									if(month<i){
										//同一个月的通知在该月份抬头下
										if(month_temp.length>0){
											year_temp+='<div class="notify_item_month"><div class="notify_month_title"><div></div><div>'+i+'月</div><div></div></div><div class="notify_list_more">'
												+month_temp+'</div></div>';
										}
										break;//到下一月
									}
									month_temp+='<div class="notify_item_more" onclick="jumpToNotify('+notify.id+')">'
										+'<div '+(notify.read?'':'class="point_notread"')+'></div><div class="tooltip_div">'+notify.title+'</div><div >'+notify.update_date
										+'</div><div class="tooltip_div">'+notify.publisher+'</div></div>';
									notify_index++;
									if(notify_index==returnData.length){
										year_temp+='<div class="notify_item_month"><div class="notify_month_title"><div></div><div>'+i+'月</div><div></div></div><div class="notify_list_more">'
										+month_temp+'</div></div>';
									}
								}
							}
							$(".no_notify_div").css("display","none");
							$(".notify_list_month").css("display","block");
							$(".notify_list_month").html(year_temp);
						}else{
							$(".no_notify_div").css("display","block");
							$(".notify_list_month").css("display","none");
						}
						resize();
					},
					complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
						if(status!='success'){//超时,status还有success,error等值的情况
							if(status=='timeout'){
								initdiglog2("提示信息","请求超时！");
							}else{
								initdiglog2("提示信息","操作异常,请重试！");
								$(".notify_list").html('<div class="no_notify_div">本年度您未发布通知</div>');
							}
						}
						showToolTip();
					}
				});
			}
			
			$(function(){
				getNotify(<%=year%>);
				resize();
			});		
			window.onresize=function(){
				resize();
			};
			function resize(){
				var array=$(".year_auto_height");
				var len=array.length;
				var h=150;//初始高度
				var hh=(window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight)-180;//可用高度
				if(h*len>hh){
					h=hh/len<40?40:hh/len;
					$(".year_auto_height").each(function (){
						$(this).css("line-height",h+"px");
					});
				}
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
			<jsp:param name="index" value="1" />
			</jsp:include>
			<div class="div_center_right1">
				<div class="notify_list_month">
					
				</div>
				<div class="no_notify_div">本年度未发布通知</div>
			</div>
		</div>
		<form action="CommunicateServlet" name="jumpform" method="post" >
			<input type="hidden" name="type" value="jumpUrl">
			<input type="hidden" name="jumpType">
			<input type="hidden" name="jumpID">
		</form>
		<div class="year_list_div">
			<%for(int i=nowYear;i>=2016;i--) {%>
				<div id="yeardiv<%=i %>" class="year_auto_height <%=year==i?"year_item_div_press":"year_item_div_normal"%>" onclick="getNotify(<%=i%>)"><div><%=i %></div></div>
			<%} %>
		</div>
	</body>
</html>
<!-- <div class="no_notify_div">本年度您未发布通知</div> -->