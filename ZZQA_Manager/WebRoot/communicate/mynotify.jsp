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
	int nowYear=DataUtil.getCurrentYear();
	int year;
	if(session.getAttribute("notifyyear")!=null){
		year=(Integer)session.getAttribute("notifyyear");
	}else{
		year=nowYear;
	}
	List<Notify> notifies=communicateManager.getNotifyListByCreateID(uid,year);
	session.setAttribute("notify_index", 3);
%>

<!DOCTYPE HTML>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>发布通知</title>
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
			function delNotify(id){
				initdiglogtwo2("提示信息","你确定要删除该条通知吗？");
		   		$( "#confirm2" ).click(function() {
					$( "#twobtndialog" ).dialog( "close" );
					Lock_CheckForm();
					$.ajax({
						type:"post",//post方法
						url:"CommunicateServlet",
						data:{"type":"delNotify","ID":id},
						timeout : 15000, 
						//ajax成功的回调函数
						success:function(returnData){
							//删除成功
							initdiglog2("提示信息","删除成功！");
							$("#notify_item"+id).remove();
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
			function getNotify(year){
				$(".year_item_div_press").prop("class","year_auto_height year_item_div_normal");
				$("#yeardiv"+year).prop("class","year_auto_height year_item_div_press");
				$.ajax({
					type:"post",//post方法
					url:"CommunicateServlet",
					data:{"type":"getNotify","year":year},
					timeout : 15000, 
					dataType:'json',
					//ajax成功的回调函数
					success:function(returnData){
						//加载成功
						if(returnData.length>0){
							var html="";
							for(var i=0;i<returnData.length;i++){
								var notify=returnData[i];
								html+='<div class="notify_item" id="notify_item'+notify.id+'">'
									+'<div class="notify_title tooltip_div" onclick="jumpToNotify('+notify.id+')">'+notify.title+'</div>'
									+'<div class="notify_date" onclick="jumpToNotify('+notify.id+')">'+notify.update_date+'</div>'
									+'<a href="javascript:delNotify('+notify.id+');blur()"  title="删除">删除</a>'
									+'<div class="div_line"></div><a href="javascript:alterNotify('+notify.id+');"  title="修改">修改</a></div>';
							}
							$(".notify_list").html(html);
						}else{
							$(".notify_list").html('<div class="no_notify_div">本年度您未发布通知</div>');
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
					}
				});
			}
			function alterNotify(id){
				document.jumpform.jumpID.value=id;
				document.jumpform.jumpType.value=2;
				document.jumpform.submit();
			}
			$(function(){
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
			<jsp:param name="index" value="4" />
			</jsp:include>
			<div class="div_center_right1">
				<div class="div_title">
				已发布的通知
				</div>
				<a class="add_notify_btn" href="communicate/publish_notify.jsp">发布通知</a>
				<div class="div_dashed"></div>
				<div class="notify_list">
				<%if(notifies.size()>0){for(Notify notify:notifies){ %>
					<div class="notify_item" id="notify_item<%=notify.getId() %>">
						<div class="notify_title tooltip_div" onclick="jumpToNotify(<%=notify.getId()%>)"><%=notify.getTitle() %></div>
						<div class="notify_date" onclick="jumpToNotify(<%=notify.getId()%>)"><%=notify.getUpdate_date()%></div>
						<a href="javascript:delNotify(<%=notify.getId() %>);blur()"  title="删除">删除</a>
						<div class="div_line"></div>
						<a href="javascript:alterNotify(<%=notify.getId() %>);"  title="修改">修改</a>
					</div>
				<%}}else{ %>
					<div class="no_notify_div">本年度您未发布通知</div>
				<%} %>
				
				</div>
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
