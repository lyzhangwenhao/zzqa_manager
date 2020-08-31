<%@page import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
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
	Position_userManager position_userManager= (Position_userManager) WebApplicationContextUtils
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
	List<User> userList = userManager
			.getUserListByKeywords("");
	List<Position_user> positionList=position_userManager.getPositionOrderByparent();
%>

<!DOCTYPE HTML>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>用户管理</title>
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
		<script type="text/javascript">
			var flag=0;//0：隐藏
			var ifCheckAll=true;//是否全选
			var positionArray=[
		          <%for(int i=0,pLen=positionList.size();i<pLen;i++){Position_user position_user=positionList.get(i);
		        	  if(i>0){
		        		  out.write(",");
		        	  }
		        	  out.write("["+position_user.getId()+",'"+position_user.getPosition_name()+"',"+true+"]");
		          }%>
		      ];
			function deleteUser(index,uid){
			   	initdiglogtwo2("提示信息","你确定要删除该用户吗？");
		   		$( "#confirm2" ).click(function() {
					$( "#twobtndialog" ).dialog( "close" );
					$.ajax({
						type:"post",//post方法
						url:"UserManagerServlet",
						data:{"type":"deluser","user_id":uid},
						//ajax成功的回调函数
						success:function(returnData){
							if(returnData==1){
								initdiglog2("提示信息","删除成功！");
								var name="#tab_tr"+index;
								$(name).remove();
							}
						}
					});
				});
			}
			function adv_search(f){
				if(arguments.length!=0){
					if(f&&$("#td2_div2").css("display")=="none"){
						adv_search();
					}else if(!f&&$("#td2_div2").css("display")=="block"){
						//强制关闭
						adv_search();
					}
				}else{
					event.stopPropagation();//防止冒泡
					$("#td2_div2").slideToggle();
					if(flag==0){
						$("#img_adv").attr("title","收起筛选");
						$("#img_adv").attr("src","images/search_normal.jpg");
						flag=1;
						initPosition();
					}else{
						$("#img_adv").attr("title","显示筛选");
						$("#img_adv").attr("src","images/search_press.jpg");
						flag=0;
					}
				}
			}
			$(function(){
				$('#keywords_user').bind('keydown',function(event){
				    if(event.keyCode == "13") searchUser(false);
				});
				$('html').click(function(event){
					adv_search(false);
				});
				$("#td2_div2").click(function(){
					event.stopPropagation();//防止冒泡
				});
				initPosition();
			});
			function initPosition(){
				if($(".td2_div2_usergroup").children().length==0){
					var num=positionArray.length;
					var rows=(num%3==0?0:1)+Math.floor(num/3);
					var temp='';
					for(var i=0;i<rows;i++){
						if((i*3)<num){
							temp+='<div><input type="checkbox" id="user_checkbox'+(i*3)+'" class="chk_2" onchange="userCheckedChange('+i*3+')"/><label for="user_checkbox'+(i*3)+'"></label>'
								+'<div onclick="sameClick('+(i*3)+');" title="'+positionArray[i*3][1]+'" id="userdiv'+positionArray[i*3][0]+'">'+positionArray[i*3][1]+'</div>';
						}
						if((i*3+1)<num){
							temp+='<input type="checkbox" id="user_checkbox'+(i*3+1)+'" class="chk_2" onchange="userCheckedChange('+(i*3+1)+')"/><label for="user_checkbox'+(i*3+1)+'"></label>'
								+'<div onclick="sameClick('+(i*3+1)+');" title="'+positionArray[i*3+1][1]+'" id="userdiv'+positionArray[i*3+1][0]+'">'+positionArray[i*3+1][1]+'</div>';
						}
						if((i*3+2)<num){
							temp+='<input type="checkbox" id="user_checkbox'+(i*3+2)+'" class="chk_2" onchange="userCheckedChange('+(i*3+2)+')"/><label for="user_checkbox'+(i*3+2)+'"></label>'
								+'<div onclick="sameClick('+(i*3+2)+');" title="'+positionArray[i*3+2][1]+'" id="userdiv'+positionArray[i*3+2][0]+'">'+positionArray[i*3+2][1]+'</div>';
						}
						temp+='</div>';
					}
					$(".td2_div2_usergroup").html(temp);
				}
				$("#multi_checkbox").prop("checked",ifCheckAll);
				for(var i=0;i<positionArray.length;i++){
					$("#user_checkbox"+i).prop("checked",positionArray[i][2]);
				}
			}
			function sameClick(id){
		    	event.stopPropagation();//防止冒泡
		    	$("#user_checkbox"+id).prop("checked",!($("#user_checkbox"+id).prop("checked")));
		    }
		    function userCheckedChange(id){
		    
		    }
		    function multiChecked(){
		    	var f=$('.chk_1').prop('checked');
		    	for(var i=0;i<positionArray.length;i++){
	    			$("#user_checkbox"+i).prop("checked",f);
		    	}
		    }
		    function selectAll(){
		    	var f=!$('.chk_1').prop('checked');
		    	$('.chk_1').prop('checked',f);
		    	for(var i=0;i<positionArray.length;i++){
	    			$("#user_checkbox"+i).prop("checked",f);
		    	}
		    }
		    function searchUser(justKW){
		    	if(justKW){
		    		for(var i=0;i<positionArray.length;i++){
						positionArray[i][2]=$("#user_checkbox"+i).prop("checked");
					}
		    		ifCheckAll=$("#multi_checkbox").prop("checked");
		    		adv_search(false);
		    	}
				var kw=$("#keywords_user").val();
				var index=0;//用于隔行颜色处理
				$(".device_tab tr:gt(0)").each(function(){
					if(checkPositionSelected(parseInt($(this).attr("position_id")))&&($(this).find("td:eq(0)").text().trim().indexOf(kw)!=-1
							||$(this).find("td:eq(1)").text().trim().indexOf(kw)!=-1
							||$(this).find("td:eq(2)").text().indexOf(kw)!=-1
							||$(this).find("td:eq(3)").text().indexOf(kw)!=-1)){
						$(this).css({"display":"table-row","background":(index++%2==0?"#F5F9FD":"#EAEFF7")});
					}else{
						$(this).css("display","none");
					}
				});
			}
		    function checkPositionSelected(p_id){
		    	for(var i=0;i<positionArray.length;i++){
		    		if(positionArray[i][0]==p_id&&positionArray[i][2]){
		    			return true;
		    		}
		    	}
		    	return false;
		    }
		</script>
	</head>

	<body>
		<jsp:include page="/top.jsp" >
	<jsp:param name="name" value="<%=mUser.getName() %>" />
	<jsp:param name="level" value="<%=mUser.getLevel() %>" />
	<jsp:param name="index" value="3" />
	</jsp:include>
		<div class="div_center" style="overflow: inherit;">
			<jsp:include page="/usermanager/userTab.jsp">
			<jsp:param name="index" value="1" />
			</jsp:include>
			<div class="div_center_right">
				<form action="UserManagerServlet" method="post" name="userform">
				<input type="hidden" name="type" value="searchuser">
				<input type="text" name="hidden" style="display:none">
				<div class="td2_div1">
					<img title="显示筛选" src="images/search_press.jpg" id="img_adv"
										onclick="adv_search();" class="serach_img2">
					<img title="搜索" src="images/user_search.gif" id="img_search"
						onclick="searchUser(false);">
					<input type="text" name="keywords_user"  id="keywords_user" class="search-user-kw" 
					onkeydown="if(event.keyCode==32) return false" placeholder="关键词：用户名、姓名、职位">
					<div class="td2_div2_parent">
						<div class="user_div2" id="td2_div2">
							<div class="td2_div2_btns">
								<input type="checkbox" id="multi_checkbox" class="chk_1" onchange="multiChecked()" checked/><label for="multi_checkbox"></label>
								<div onclick="selectAll();">全选</div>
								<div onclick="searchUser(true);">筛选</div>
							</div>
							<div class="td2_div2_usergroup">
							</div>
						</div>
					</div>
				</div>
				<table class="device_tab">
					<tr class="tab_tr1" id="table">
						<td class="tab_tr1_td1" style="min-width:50px;">
							用户编号
						</td>
						<td class="tab_tr1_td2">
							用户名
						</td>
						<td class="tab_tr1_td3">
							姓名
						</td>
						<td class="tab_tr1_td4" style="width:160px;">
							职位
						</td>
						<td class="tab_tr1_td13">
							设置
						</td>
					</tr>
					<%
						int i = -1;
						for (User user : userList) {
							//admin可以看其他所有人
							if("admin".equals(user.getName())||mUser.getId()==user.getId()){
								continue;
							}
							i++;
					%>
					<tr class="tab_tr2" id="tab_tr<%=i%>" position_id="<%=user.getPosition_id()%>">
						<td class="tab_tr1_td1" id="tab_tr<%=i%>_index">
							<%=user.getId()%>
						</td>
						<td class="tab_tr1_td2">
							<%=user.getName()%>
						</td>
						<td class="tab_tr1_td3">
							<%=user.getTruename()%>
						</td>
						<td class="tab_tr1_td4 tooltip_div" >
							<%=user.getPosition_name()==null?("职位"+user.getPosition_id()):user.getPosition_name()%>
						</td>
						<td class="tab_tr1_td13">
							<div>
								<a href="UserManagerServlet?type=gotoalteruser&user_id=<%=user.getId()%>"><img class="tab_img_left" src="images/alter.png" title="修改"></a>
								<img class="tab_img_right" src="images/delete.png" onclick="deleteUser(<%=i%>,<%=user.getId() %>)" title="删除">
							</div>
						</td>
					</tr>
					<%
						}
					%>
				</table>
			</form>
			</div>
			<div style="clear:both"></div>
		</div>
	</body>
</html>
