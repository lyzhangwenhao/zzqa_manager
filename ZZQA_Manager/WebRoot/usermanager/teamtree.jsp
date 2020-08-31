<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%
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
	List<Position_user> posiList=position_userManager.getPositionOrderByparent();
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
%>

<!DOCTYPE HTML>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>组织架构</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/usermanager.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<link rel="stylesheet" type="text/css" href="css/default.css">
		<link rel="stylesheet" type="text/css" href="css/bootstrap/bootstrap.min-3.2.css" >
		<script type="text/javascript" src="js/jquery.min-2.1.1.js"></script>
		<script type="text/javascript" src="js/bootstrap-treeview.js"></script>
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		
		<!--[if IE]>
			<script  type="text/javascript" src="js/html5shiv.min.js"></script>
		<![endif]-->
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		
	</head>

	<body>
		<jsp:include page="/top.jsp" >
	<jsp:param name="name" value="<%=mUser.getName() %>" />
	<jsp:param name="level" value="<%=mUser.getLevel() %>" />
	<jsp:param name="index" value="3" />
	</jsp:include>
		<div class="div_center">
			<jsp:include page="/usermanager/userTab.jsp">
			<jsp:param name="index" value="3" />
			</jsp:include>
			<div class="div_center_right">
				<div class="td2_div3">
					<form action="UserManagerServlet" method="post" name="userform">
						<div id="treeview" class=""></div>
					</form>
				</div>
			</div>
		</div>
	</body>
	<script type="text/javascript">
			var treeData=[
				<%boolean flag=false;for(Position_user position_user2:posiList){
					if(flag){
						out.write(",");
					}else{
						flag=true;
					}
					out.write("["+position_user2.getId()+",'"+position_user2.getPosition_name()+"',"+position_user2.getParent()+"]");
				}%>
			];
			$(function() {
				//查找子节点
				function searchChildren(id){
					var temp="";
					var flag=false;
					for(var i=0;i<<%=posiList.size()%>;i++){
						if(treeData[i][2]==id){
							if(id!=0&&temp==""){
								temp+=",'nodes':[";
							}
							if(flag){
								temp+=",";
							}else{
								flag=true;
							}
							temp+="{'text':'"+treeData[i][1]+"'";
							temp+=searchChildren(treeData[i][0]);
							temp+="}";
						}
					}
					if(id!=0&&temp!=""){
						temp+="]";
					}
					return temp;
				}
				
				var treeJson=eval("["+searchChildren(0)+"]");
		       
		        $('#treeview').treeview({
		        	data: treeJson
		        });
		        $("li.list-group-item").eq(0).click();//关闭
		        $("li.list-group-item").eq(0).click();//展开一级
			});
			var node_checkable=false;//防止再点击右边按钮时错误选中组织,在bootstrap.treeview.js中339行使用，用户标记是否选中
			function checkIconShow(){
				$("li.list-group-item").mouseover(function(e){
					if($("img.add_tree").length==0){
						var icon_tree="<img src='images/delete_tree.png' title='删除组织' class='add_tree' onclick='deleteTree($(this));'><img src='images/alter_tree.png' title='修改组织' class='alter_tree' onclick='alterTree($(this));'>"; //创建DIV元素
						$(this).append(icon_tree); //追加到文档中
					}
				}).mouseleave(function(){
					$("img.add_tree").remove(); //移除
					$("img.alter_tree").remove(); //移除
				});
			}
			function deleteTree(nodeObj){
				node_checkable=true;
				var position_name=nodeObj.parent().children('.node_text').text();
				initdiglogtwo2("提示信息","你确定要删除【"+position_name+"】吗？");
				$( "#confirm2" ).click(function() {
					$( "#twobtndialog" ).dialog( "close" );
					var position_id=0;
					for(var i=0;i<treeData.length;i++){
						if(position_name==treeData[i][1]){
							position_id=treeData[i][0];
							break;
						}
					}
					$.ajax({
						type:"post",//post方法
						url:"UserManagerServlet",
						timeout : 10000, //超时时间设置，单位毫秒
						data:{"type":"deletePosition","position_id":position_id},
						//ajax成功的回调函数
						success:function(returnData){
							if(returnData==1){
								window.location.reload();
							}else if(returnData==2){
								initdiglog2("提示信息","该组织存在子节点，无法删除！");
							}else if(returnData==3){
								initdiglog2("提示信息","已有用户绑定，无法删除！");
							}else{
								initdiglog2("提示信息","操作失败，请刷新页面后再试！");
							}
						},
						complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
							if(status=='timeout'){//超时,status还有success,error等值的情况
								initdiglog2("提示信息","请求超时，请重试！");
							}else if(status=='error'){
								initdiglog2("提示信息","操作失败，请刷新页面后再试！");
							}
						}
					});
				});
			}
			function alterTree(nodeObj){
				node_checkable=true;
				var position_name=nodeObj.parent().children('.node_text').text();
				var position_id=0;
				for(var i=0;i<treeData.length;i++){
					if(position_name==treeData[i][1]){
						position_id=treeData[i][0];
						break;
					}
				}
				window.location.href="UserManagerServlet?type=goToAlterPosition&position_id="+position_id;
			}
		</script>
</html>
