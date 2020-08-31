<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.pojo.advise.Advise"%>
<%@page import="com.zzqa.service.interfaces.communicate.CommunicateManager"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
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
	PermissionsManager permissionsManager=(PermissionsManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("permissionsManager");
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
	if(session.getAttribute("adviseyear")!=null){
		year=(Integer)session.getAttribute("adviseyear");
	}else{
		year=nowYear;
	}
	int advise_tab=1;
	if (session.getAttribute("advise_tab") != null) {
		advise_tab= (Integer) session.getAttribute("advise_tab");
	}
	boolean permission44=permissionsManager.checkPermission(mUser.getPosition_id(), 44);
	int privatenum=communicateManager.getNotReadAdviseCount(2, uid);
	int minenum=communicateManager.getNotReadAdviseCount(0, uid);
	session.setAttribute("advise_index",11);
%>

<!DOCTYPE HTML>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>建议</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/advise.css">
		<link rel="stylesheet" type="text/css" href="css/communicate.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
		var year="<%=year%>";
		var advise_tab=<%=advise_tab%>;
		var privatenum=<%=privatenum%>;
		var minenum=<%=minenum%>;
		$(function(){
			getAdvise(advise_tab);
			resize();
		});
		function setBtnDiv(){
			var temp='<div class="topbtn1" onclick="getAdvise(1)">公开</div><div class="topbtn2" onclick="getAdvise(2)">私信<span>'+ (privatenum==0?'':('('+privatenum+')'))+'</span></div>';
			if(<%=permission44%>){
				temp+='<div class="topbtn3" onclick="getAdvise(3)">我的'+(minenum==0?'':('<span>('+minenum+')</span>'))+'</div>'
					+'<div onclick="window.location.href=&quot;communicate/publish_advise.jsp&quot;">提交建议</div>';
			}
			$(".td_righttop_btngroup").html(temp);
		}
		window.onresize=function(){
			resize();
		};
		function jumpToAdvise(id){
			document.jumpform.jumpID.value=id;
			document.jumpform.jumpType.value=10;
			document.jumpform.submit();
		}
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
		function setYear(y){
			year=y;
			$(".year_item_div_press").prop("class","year_auto_height year_item_div_normal");
			$("#yeardiv"+year).prop("class","year_auto_height year_item_div_press");
			getAdvise(advise_tab);
		}
		function getAdvise(tab_index){
			advise_tab=tab_index;
			var notfindtext="";
			if(tab_index==1){
				$(".div_title").text("公开建议");
				notfindtext="本年度未发布公开建议";
			}else if(tab_index==2){
				$(".div_title").text("私信建议");
				notfindtext="本年度没有您的私信";
			}else if(tab_index==3){
				$(".div_title").text("我的建议");
				notfindtext="本年度您未发布建议";
			}
			setBtnDiv();
			$(".topbtn"+advise_tab).css({"color":"#fff","background":"#2ABDFF"});
			$.ajax({
				type:"post",//post方法
				url:"CommunicateServlet",
				data:{"type":"getAdvise","year":year,"advise_tab":advise_tab},
				timeout : 15000, 
				dataType:'json',
				//ajax成功的回调函数
				success:function(returnData){
					//加载成功
					if(returnData.length>0){
						var html="";
						for(var i=0;i<returnData.length;i++){
							var advise=returnData[i];
							if(tab_index==3){
								html+='<div class="advise_item" id="advise_item'+advise.id+'">'+'<div '+(advise.read?'':'class="point_notread"')+'></div>'
								+'<div class="advise_title tooltip_div" onclick="jumpToAdvise('+advise.id+')">'+advise.title+'</div>'
								+'<div class="advise_date" onclick="jumpToAdvise('+advise.id+')">'+advise.update_date+'</div>'
								+'<a href="javascript:delAdvise('+advise.id+');blur()"  title="删除">删除</a>'
								+'<div class="div_line"></div><a href="javascript:alterAdvise('+advise.id+');"  title="修改">修改</a></div>';
							}else{
								html+='<div class="advise_item_common" onclick="jumpToAdvise('+advise.id+')">'
								+'<div '+(advise.read?'':'class="point_notread"')+'></div><div class="tooltip_div">'+advise.title+'</div><div >'+advise.update_date
								+'</div><div class="tooltip_div">'+advise.create_name+'</div></div>';
							}
						}
						$(".advise_list_common").html(html);
					}else{
						$(".advise_list_common").html('<div class="no_advise_div">'+notfindtext+'</div>');
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
					showToolTip();
				}
			});
		}
		function delAdvise(id){
			initdiglogtwo2("提示信息","你确定要删除该条建议吗？");
	   		$( "#confirm2" ).click(function() {
				$( "#twobtndialog" ).dialog( "close" );
				Lock_CheckForm();
				$.ajax({
					type:"post",//post方法
					url:"CommunicateServlet",
					data:{"type":"delAdvise","ID":id},
					timeout : 15000, 
					//ajax成功的回调函数
					success:function(returnData){
						//删除成功
						initdiglog2("提示信息","删除成功！");
						$("#advise_item"+id).remove();
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
		function alterAdvise(id){
			document.jumpform.jumpID.value=id;
			document.jumpform.jumpType.value=12;
			document.jumpform.submit();
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
			<jsp:param name="index" value="2" />
			</jsp:include>
			<div class="div_center_right2">
				<div class="td_righttop_btngroup">
				</div>
				<div class="td_righttop_content">
					<div class="div_title">公开建议</div>
					<div class="advise_list_common">
					
					</div>
				</div>
			</div>
		</div>
		<form action="CommunicateServlet" name="jumpform" method="post" >
			<input type="hidden" name="type" value="jumpUrl">
			<input type="hidden" name="jumpType">
			<input type="hidden" name="jumpID">
		</form>
		<div class="year_list_div newtop">
			<%for(int i=nowYear;i>=2016;i--) {%>
				<div id="yeardiv<%=i %>" class="year_auto_height <%=year==i?"year_item_div_press":"year_item_div_normal"%>" onclick="setYear(<%=i%>)"><div><%=i %></div></div>
			<%} %>
		</div>
	</body>
</html>
