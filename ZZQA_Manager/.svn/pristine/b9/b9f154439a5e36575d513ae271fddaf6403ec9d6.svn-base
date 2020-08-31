<%@page import="com.zzqa.util.DataUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
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
	int deliver_id=0;
	if (session.getAttribute("deliver_id") != null) {
		deliver_id=(Integer)session.getAttribute("deliver_id");
	}
	String[] departmentArray=DataUtil.getdepartment();
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>出库单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css" href="css/deliverflow.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script src="js/showdate.js"></script>
		<script src="js/jquery.min.js"></script>
		<script src="js/jquery-ui.min.js"></script>
		<script src="js/dialog.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		<script src="js/deliverflow.js"></script>
		<script type="text/javascript">
		var uid=<%=uid%>;//当前用户id
		var deliver_id=<%=deliver_id%>;//修改的deliver_id
		var deliver_json;
		var flow_json;
		var items_json;
		var del_ids="";
		var flows;
		var now_show=false;//隐藏状态
		var username="<%=mUser.getTruename()%>";//本人
		var materialsArray=["请选择领料类型","生产领用","开发领用","工程领用","低耗品领用","维修领用","自制贴片领用","售后领用"];
		var departmentArray=[<%int len=departmentArray.length;for(int i=1;i<len;i++){
			if(i>0){
				out.write(",'"+departmentArray[i]+"'");
			}else{
				out.write("'"+departmentArray[i]+"'");
			}			
		}%>];//部门列表
		var nowTR;
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
						<div class="color_nodid">提交出库单</div>
						<div class="color_nodid">领导审批</div>
						<div class="color_nodid">仓库管理员审批</div>
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
					</div>
					<div class="title3_flow1" id="flow_title3">
						<div></div>
						<div></div>
						<div></div>
						<div></div>
					</div>
						<div class="td2_div2">出库申领单</div>
						<table class="td2_table">
							<colgroup class="table_tr2">
								<col class="table_tr2_td1">
								<col class="table_tr2_td2">
								<col class="table_tr2_td3">
								<col class="table_tr2_td4">
							</colgroup>
							<tr class="table_tr1">
								<td class="table_tr1_td1">项目名称</td>
								<td class="table_tr1_td2" colspan="3">
									<span id="project_name"></span>
								</td>
							</tr>
							<tr class="table_tr1">
								<td class="table_tr1_td1">项目编号</td>
								<td class="table_tr1_td2" colspan="3" >
									<span id="project_id"></span>
								</td>
							</tr>
							<tr class="table_tr2">
								<td class="table_tr2_td1">所属类型</td>
								<td class="table_tr2_td2" >
									<span id="material_type"></span>
								</td>
								<td class="table_tr2_td3">所属部门</td>
								<td class="table_tr2_td4" >
									<span id="department_index"></span>
								</td>
							</tr>
						</table>
						<div class="materials_title"><div></div><div>物料清单</div></div>
						<table class="materials_tab">
							<tr class="materials_tab_title">
								<td class="tab_title_td1">序号</td>
								<td class="tab_title_td2">物料编码</td>
								<td class="tab_title_td3">名称</td>
								<td class="tab_title_td4">规格</td>
								<td class="tab_title_td5">单位</td>
								<td class="tab_title_td6">数量</td>
								<td class="tab_title_td7">质证号</td>
								<td class="tab_title_td8">备注</td>
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
