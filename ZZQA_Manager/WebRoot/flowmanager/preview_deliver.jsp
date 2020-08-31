<%@page import="com.zzqa.util.DataUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
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

		<title>打印出库单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css" href="css/preview_deliver.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script src="js/showdate.js"></script>
		<script src="js/jquery.min.js"></script>
		<script src="js/jquery-ui.min.js"></script>
		<script src="js/dialog.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		<script src="js/preview_deliver.js"></script>
		<script type="text/javascript">
		var uid=<%=uid%>;//当前用户id
		var deliver_id=<%=deliver_id%>;//修改的deliver_id
		var deliver_json;
		var username="<%=mUser.getTruename()%>";//本人
		var materialsArray=["请选择领料类型","生产领用","开发领用","工程领用","低耗品领用","维修领用","自制贴片领用","售后领用"];
		var departmentArray=[<%int len=departmentArray.length;for(int i=1;i<len;i++){
			if(i>0){
				out.write(",'"+departmentArray[i]+"'");
			}else{
				out.write("'"+departmentArray[i]+"'");
			}			
		}%>];//部门列表
		</script>		
	</head>

	<body>
		<div class="parent_div">
			<div class="td2_div1">浙江中自庆安新能源技术有限公司</div>
			<div class="td2_div1_center">出 库 申 领 单</div>
	   		<div class="td2_div1_right">SC-04(B)</div>
	   		<table class="picking_table">
	   			<colgroup class="table_tr2">
					<col style="width:15%">
					<col style="width:35%">
					<col style="width:15%">
					<col style="width:35%">
				</colgroup>
				<tr><td>项目名称：</td><td colspan="3" id="project_name"></td></tr>
				<tr><td>领料类型：</td><td id="material_type"></td><td>领料部门：</td><td id="department_index"></td></tr>
				<tr><td>项目编号：</td><td id="project_id"></td><td>出库时间：</td><td id="create_time"></td></tr>
				<tr><td colspan="4">物  料  清  单</td></tr>
			</table>
			<table class="picking_table picking_table2">
				<colgroup class="table_tr2">
					<col style="width:5%">
					<col style="width:20%">
					<col style="width:25%">
					<col style="width:15%">
					<col style="width:7%">
					<col style="width:7%">
					<col style="width:12%">
					<col style="width:9%">
				</colgroup>
				<tr class="picking_tr_title">
					<td index_td="index">序号</td>
					<td index_td="materials_id">物料号</td>
					<td index_td="name">名称</td>
					<td index_td="model">规格</td>
					<td index_td="unit">单位</td>
					<td index_td="num">数量</td>
					<td index_td="quality_no">质证号</td>
					<td index_td="remark">备注</td>
				</tr>
			</table>
			<div class="bottom_group">
				<div class="bottom_div">
					<div>领料人/日期：</div><div><span id="material_uname"></span><span id="material_time"></span></div>
				</div>
				<div class="bottom_div">
					<div>批准人/日期：</div><div><span id="approve_uname"></span><span id="approve_time"></span></div>
				</div>
				<div class="bottom_div">
					<div>仓管/日期：</div><div><span id="keeper_uname"></span><span id="keeper_time"></span></div>
				</div>
			</div>
			<div class="div_dashed" id="div_dashed"><div></div><div>分割线</div><div></div></div>
			<div class="div_btn">
				<div class="preview_btn" onclick="history.back(-1);">返 回</div>
				<div class="preview_btn" onclick="preview();">打 印</div>
			</div>
		</div>
	</body>
</html>
