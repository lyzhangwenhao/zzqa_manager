<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page
	import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page
	import="com.zzqa.service.interfaces.equipment.EquipmentManager"%>
<%@page import="com.zzqa.pojo.equipment.Equipment"%>
<%
	request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	EquipmentManager equipmentManager=(EquipmentManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("equipmentManager");
	Position_userManager position_userManager = (Position_userManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("position_userManager");
	if (session.getAttribute("uid") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int uid = (Integer) session.getAttribute("uid");
	User mUser = userManager.getUserByID(uid);
	if (mUser == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	List<Equipment> equipments=equipmentManager.getFreedomEquipmentList();
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>新建发货流程</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css"
			href="css/create_shipmentsflow.css">
		<link rel="stylesheet" type="text/css" href="css/custom.css">
  		<script  type="text/javascript" src="js/jquery.min.js"></script>
		
		<link rel="stylesheet" href="css/bootstrap/bootstrap.min.css">
		<script src="js/modernizr.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<script src="js/vendor/tabcomplete.min.js"></script>
		<script src="js/vendor/livefilter.min.js"></script>
		<script src="js/vendor/src/bootstrap-select.js"></script>
		<script src="js/vendor/src/filterlist.js"></script>
		<script src="js/plugins.js"></script>
		
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
 		<script  type="text/javascript" src="js/jquery-ui.min.js"></script>
 		<script  type="text/javascript" src="js/dialog.js"></script>
 		<script type="text/javascript" src="js/public.js"></script>
 		
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
			var dnum=0;//选中设备台数
			var deviceArray=[
				<%
				int dNum=equipments.size();
				for(int i=0;i<dNum;i++){
					if(i!=0){
						out.write(",");
					}
					//参数分别表示：下标-设备ID-是否被选中（0表示可选）
					out.write("["+i+",'"+equipments.get(i).getIdStr()+"',"+0+"]");
				}
				%>
			];
			function addFlow(){
				var k=0
				if($("#task_id_input").val().length<1){
					k++;
        			$("#select_task_error").text("请选择项目任务单");
    			}else {
        			$("#select_task_error").text("");
    			}
    			var text="";
    			$('input[name="right_ID"]').each(function(){
					var index=$(this).val();
					if(text!=""){
						 text += "-"+deviceArray[index][1];
					}else{
						 text += deviceArray[index][1];
					}
	            });
	            if(text==""){
	            	k++;
	            	initdiglog2("提示信息","您还没有选择任何设备！","确定");
	            }
    			if(k==0){
    				document.flowform.task_id.value=document.getElementById("task_id_input").value;
    				document.flowform.IDs.value=text;
    				document.flowform.submit();
    			}
			}
			function checkID(value){
				var temp="";
				var val=value.replace(/(\s*$)/g, "");
				for(var i=0;i<deviceArray.length;i++){
					if(deviceArray[i][2]==0&&(deviceArray[i][1].indexOf(val)>-1||val.length<1)){
						temp+="<li><label>ID:"+deviceArray[i][1]+"<input type='checkbox' name='left_ID'"+
								"value='"+deviceArray[i][0]+"' style='margin-left:100px;'/></label></li>";
					}
				}
				$("#ul_left").html(temp);
			}
			function choseDevice(){
				document.getElementById("transtoright").blur();
				var text="";
				$('input[name="left_ID"]:checked').each(function(){
					dnum++;
					var index=$(this).val();
					if(text!=""){
						 text += "-"+index;
					}else{
						 text += index;
					}
	            });
	            $("#dnum").text("已选设备（"+dnum+"台）");
	            $('input[name="left_ID"]:checked').parent().remove();
	            if(text!=""){
	            	var temp="";
	            	var selectedArray=text.split("-");
	            	for(var i=0;i<selectedArray.length;i++){
	            		var index=selectedArray[i];
						if(deviceArray[index][2]==0){
							deviceArray[index][2]=1;//标记为选中
							temp+="<li><label>ID："+deviceArray[index][1]+"<input type='checkbox' name='right_ID'"+
									"value='"+deviceArray[index][0]+"' style='margin-left:100px;'/></label></li>";
						}
					}
					$("#ul_right").append(temp);
	            }else{
	            	initdiglog2("提示信息","请选择设备！","确定");
	            }
			}
			function cancelDevice(){
				document.getElementById("transtoleft").blur();
				var text="";
				$('input[name="right_ID"]:checked').each(function(){
					var index=$(this).val();
					dnum--;
					if(text!=""){
						 text += "-"+index;
					}else{
						 text += index;
					}
					deviceArray[index][2]=0;//标记为可选
	            });
	            if(text!=""){
	            	checkID($("#searchID").val());
	            	$("#dnum").text("已选设备（"+dnum+"台）");
	            	$('input[name="right_ID"]:checked').parent().remove();
	            }else{
	            	initdiglog2("提示信息","请选择设备！","确定");
	            }
			}
		</script>
	</head>

	<body>
		<jsp:include page="/top.jsp">
			<jsp:param name="name" value="<%=mUser.getName()%>" />
			<jsp:param name="level" value="<%=mUser.getLevel() %>" />
			<jsp:param name="index" value="1" />
		</jsp:include>
		<div class="div_center">
			<table class="table_center">
				<tr>
					<jsp:include page="/flowmanager/flowTab.jsp">
						<jsp:param name="index" value="3" />
					</jsp:include>
					<td class="table_center_td2">
						<form
							action="FlowManagerServlet?type=addshipmentsflow&uid=<%=mUser.getId()%>&operation=0"
							method="post" name="flowform">
							<div class="td2_div">
								<div class="td2_div1">
									发货单
								</div>
								<table class="td2_table0">
									<tr class="table0_tr1">
										<td class="table0_tr1_td1">
											<span class="star">*</span>关联任务单
										</td>
										<td class="table0_tr1_td2">
											<div id="section4" class="section-white0">
												<jsp:include page="/flowmanager/drop_down.jsp" />
												<input type="hidden" name="task_id" value="">
											</div>
											<div class="section-white6">
												<span id="select_task_error"></span>
											</div>
										</td>
									</tr>
								</table>
								<div class="div_search">
									<div class="search_left">
										<div class="search_lefttop">
											<span >可选设备</span>
											<input type="text" id="searchID" maxlength="8"
												placeholder="筛选设备ID" onkeyup="value=value.replace(/[^\d]/g,'')"
												oninput="checkID(this.value);"/>
										</div>
										<div class="search_leftbottom">
											<div >
											<ul id="ul_left">
											<%
												for(int i=0;i<dNum;i++){
													%>
													<li>
													<label>
														ID:<%=equipments.get(i).getIdStr()%><input type="checkbox" name="left_ID" style="margin-left:100px;" value="<%=i %>"/>
													</label>
												</li>
												<%}%>
											</ul>
											</div>
										</div>

									</div>
									<div class="search_center">
										<input type="button" onclick="choseDevice()" id="transtoright" value="&gt;" class="search_input_top" title="选择设备"/>
										<input type="button" onclick="cancelDevice()" id="transtoleft" value="&lt;" class="search_input_bottom" title="取消"/>
									</div>
									<div class="search_right">
										<div class="search_righttop">
											<span id="dnum">已选设备（0台）</span>
										</div>
										<input type="hidden" name="IDs" value=""/>
										<div class="search_rightbottom">
											<div>
												<ul id="ul_right">
												</ul>
											</div>
										</div>
									</div>
								</div>
								<div class="div_btn">
									<img src="images/submit_flow.png" class="btn_agree1" onclick="addFlow();">
								</div>
							</div>
						</form>
					</td>
				</tr>
			</table>

		</div>
	</body>
</html>
