<%@page import="com.zzqa.util.DataUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.service.interfaces.file_path.File_pathManager"%>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.pojo.file_path.File_path"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	PermissionsManager permissionsManager = (PermissionsManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("permissionsManager");
	File_pathManager file_pathManager = (File_pathManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("file_pathManager");
	FlowManager flowManager = (FlowManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("flowManager");
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
	int departPuchase_id=0;
	if (session.getAttribute("departPuchase_id") != null) {
		departPuchase_id=(Integer)session.getAttribute("departPuchase_id");
	}
	List<File_path> flieList = file_pathManager.getAllFileByCondition(
			7, departPuchase_id, 7, 0);
	List<File_path> flieList_1 = file_pathManager.getAllFileByCondition(
			7, departPuchase_id, 8, 0);
	/* List<File_path> flieList = file_pathManager.getAllFileByCondition(
			2, departPuchase_id,3, 0);
	List<File_path> flieList_1 = file_pathManager.getAllFileByCondition(
			2, departPuchase_id, 1, 0); */
	Flow flow = flowManager.getNewFlowByFID(22, departPuchase_id);
	int operation_o=flow.getOperation();
	boolean isBuyer=permissionsManager.checkPermission(mUser.getPosition_id(), 21);
	boolean isChecker=permissionsManager.checkPermission(mUser.getPosition_id(), 22);
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>其他部门采购单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css" href="css/departmentPuchaseflow.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script src="js/showdate.js"></script>
		<script src="js/showdate1.js"></script>
		<script src="js/jquery.min.js"></script>
		<script src="js/jquery-ui.min.js"></script>
		<script src="js/dialog.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		<script src="js/departmentPuchaseflow.js"></script>
		<script type="text/javascript">
		var uid=<%=uid%>;//当前用户id
		var operation=<%=operation_o%>;
		var departPuchase_id=<%=departPuchase_id%>;//修改的departPuchase_id
		var departPurcahse_json;
		var flow_json;
		var items_json;
		var del_ids="";
		var flows;
		var now_show=false;//隐藏状态
		var username="<%=mUser.getTruename()%>";//本人
		var nowTR;
		
		function setTime(time,obj){
			if(obj.id.substring(0,3)=="pre"){
				var nowdate="<%=DataUtil.getTadayStr()%>";
		    	//修改time的时间
		    	if(compareTime1(nowdate,time)){
		    		obj.value=time;
		    		items_json[obj.id.slice(3)].predict_date = time;
		    	}else{
		    		initdiglogtwo2("提示信息","预计到货时间早于当前时间，请确认输入无误？");
			   		$( "#confirm2" ).click(function() {
						$( "#twobtndialog" ).dialog( "close" );
						obj.value=time;
						items_json[obj.id.slice(3)].predict_date = time;
					});
		    	}
			}else{
				obj.value=time;
				items_json[obj.id.slice(3)].aog_date = time;
			}
		}
		</script>		
	</head>

	<body>
		<jsp:include page="/top.jsp" >
	<jsp:param name="name" value="<%=mUser.getName() %>" />
	<jsp:param name="level" value="<%=mUser.getLevel() %>" />
	<jsp:param name="index" value="1" />
	</jsp:include>
		<div class="div_center">
			<table class="table_center">
				<tr>
					<jsp:include page="/flowmanager/flowTab.jsp">
						<jsp:param name="index" value="0" />
					</jsp:include>
					<td class="table_center_td2_notfull">
					<div class="title1_flow1" id="flow_title1">
						<div class="color_nodid">提交完成</div>
						<div class="color_nodid">上级领导审批</div>
						<div class="color_nodid">采购审批</div>
						<div class="color_nodid">采购执行</div>
						<div class="color_nodid">验收</div>
						<div class="color_nodid">结束</div>
					</div>
					<div class="title2_flow1" id="flow_title2">
						<img src="images/notdid.png">
						<div class="background_color_nodid"></div>
						<img src="images/notdid.png">
						<div class="background_color_nodid"></div>
						<img src="images/notdid.png">
						<div class="background_color_nodid"></div>
						<img src="images/notdid.png">
						<div class="background_color_nodid"></div>
						<img src="images/notdid.png">
						<div class="background_color_nodid"></div>
						<img src="images/notdid.png">
					</div>
					<div class="title3_flow1" id="flow_title3">
						<div></div>
						<div></div>
						<div></div>
						<div></div>
						<div></div>
						<div></div>
					</div>
						<div class="td2_div2">其他部门采购单</div>
						<table class="td2_table">
							<colgroup class="table_tr2">
								<col class="table_tr2_td1">
								<col class="table_tr2_td2">
								<col class="table_tr2_td3">
								<col class="table_tr2_td4">
							</colgroup>
							<tr class="table_tr2">
								<td class="table_tr2_td1">申购人:</td>
								<td class="table_tr2_td2" >
									<span id="purchaseName"></span>
								</td>
								<td class="table_tr2_td3">申购时间:</td>
								<td class="table_tr2_td4" >
									<span id="purchaseTime"></span>
								</td>
								<td class="table_tr2_td3">申购单号:</td>
								<td class="table_tr2_td4" >
									<span id="purchaseNum"></span>
								</td>
							</tr>
						</table>
						<div class="materials_title"><div></div><div>物料明细</div></div>
						<table class="materials_tab">
							<tr class="materials_tab_title">
								<td class="tab_title_td1">序号</td>
								<td class="tab_title_td2">庆安物料编码</td>
								<td class="tab_title_td3">物料名称</td>
								<td class="tab_title_td4">型号</td>
								<td class="tab_title_td5">工艺材料/封装</td>
								<td class="tab_title_td6">数量</td>
								<td class="tab_title_td7">特殊要求</td>
								<td class="tab_title_td8">涉及项目</td>
								<!-- <td class="tab_title_td8">预估单价(人民币)</td> -->
								<%
									if((operation_o>=5 && operation_o!=8) || (operation_o==8 && isBuyer)){
								%> 
								<td class="tab_title_td3">预计到货</td>
								<td class="tab_title_td3">实际到货</td>
								<%
									}
								%>
							</tr>
							<tr style="background:#799dd8">
								<%
									if((operation_o>=5 && operation_o!=8) || (operation_o==8 && isBuyer)){
								%> 
									<td colspan="10"></td>
								<%
									}else{
								%>
									<td colspan="8"></td>
								<%
									}
								%>
							</tr>
						</table>
						<table class="td2_table0">
							<tr class="table0_tr1">
								<td class="table0_tr1_td1">
									物料明细附件
								</td>
								<td class="table0_tr1_td2">
									<%
										for (File_path file_path : flieList_1) {
									%>
									<div class="state_add">
										<a href="javascript:void()"
											onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%></a>
									</div>
									<%
										}
									%>
								</td>
							</tr>
						</table>
						<table class="td2_table0">
							<tr class="table0_tr1">
								<td class="table0_tr1_td1">
									其它附件
								</td>
								<td class="table0_tr1_td2">
									<%
										for (File_path file_path : flieList) {
									%>
									<div class="state_add">
										<a href="javascript:void()"
											onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%></a>
									</div>
									<%
										}
									%>
								</td>
							</tr>
						</table>
						
						<div class="reason_parent">
							<div class="materials_title"><div></div><div>审批意见</div></div>
							<textarea name="reason" class="div_testarea"
								placeholder="请输入意见或建议" required="required" maxlength="500"
								onkeydown="if(event.keyCode==32) return false"></textarea>
						</div>
						<div class="btns_group">
						</div>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
