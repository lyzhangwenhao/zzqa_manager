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
	int update_did=0;
	if (session.getAttribute("update_did") != null) {
		update_did=(Integer)session.getAttribute("update_did");
	}
	String[] departmentArray=DataUtil.getdepartment();
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>新建出库单</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css" href="css/create_deliverflow.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script src="js/showdate.js"></script>
		<script src="js/jquery.min.js"></script>
		<script src="js/jquery-ui.min.js"></script>
		<script src="js/dialog.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		<script src="js/create_deliverflow.js"></script>
		<script type="text/javascript">
		var deliver_id=<%=update_did%>;//修改的deliver_id
		var deliver_json;
		var flow_json;
		var items_json;
		var del_ids="";
		var username="<%=mUser.getTruename()%>";//本人
		var materialsArray=["请选择领料类型","生产领用","开发领用","工程领用","低耗品领用","维修领用","自制贴片领用","售后领用"];
		var departmentArray=[<%int len=departmentArray.length;for(int i=0;i<len;i++){
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
						<jsp:param name="index" value="3" />
					</jsp:include>
					<td class="table_center_td2_notfull">
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
									<input type="text" id="project_name" maxlength="100" placeholder="请输入项目名称">
								</td>
							</tr>
							<tr class="table_tr1">
								<td class="table_tr1_td1">项目编号</td>
								<td class="table_tr1_td2" colspan="3">
									<input type="text" id="project_id" maxlength="100" placeholder="请输入项目编号">
								</td>
							</tr>
							<tr class="table_tr2">
								<td class="table_tr2_td1">所属类型</td>
								<td class="table_tr2_td2">
									<select id="material_type"></select>
								</td>
								<td class="table_tr2_td3">所属部门</td>
								<td class="table_tr2_td4">
									<select id="department_index"></select>
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
							<tr class="materials_tab_add" title="添加清单" onclick="showDialog(0)">
								<td><div class="td_center"><div class="add_deliver_btn"><div></div></div><div class="add_deliver_word">添加</div></div></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</table>
						<div class="reason_parent">
							<div class="materials_title"><div></div><div>修改理由</div></div>
							<textarea name="reason" class="div_testarea"
								placeholder="请输入修改理由" required="required" maxlength="500"
								onkeydown="if(event.keyCode==32) return false"></textarea>
						</div>
						<div class="btns_group">
							<div class="cancel_div">取 消</div>
							<div class="submit_div">提 交</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div class="dialog_div">
			<div class="dialog_top"><span class="title_left"><span>：</span><div class="justify">序号<span></span></div></span><span></span></div>
			<div class="dialog_item"><span class="title_left"><span>：</span><div class="justify">物料编码<span></span></div><span class="star">*</span></span><input type="text" maxlength="100" id="material_id" placeholder="请输入物料编码"></div>
			<div class="dialog_item"><span class="title_left"><span>：</span><div class="justify">名 称<span></span></div><span class="star">*</span></span><input type="text" maxlength="100" id="material_name" placeholder="请输入名称"></div>
			<div class="dialog_item"><span class="title_left"><span>：</span><div class="justify">规 格<span></span></div><span class="star">*</span></span><input type="text" maxlength="100" id="model" placeholder="请输入规格"></div>
			<div class="dialog_item"><span class="title_left"><span>：</span><div class="justify">单 位<span></span></div><span class="star">*</span></span><input type="text" maxlength="10" id="unit" placeholder="请输入单位"></div>
			<div class="dialog_item"><span class="title_left"><span>：</span><div class="justify">数 量<span></span></div><span class="star">*</span></span><input type="text" maxlength="8" id="num" oninput="checkIntPosition(this)" placeholder="请输入数量"></div>
			<div class="dialog_item"><span class="title_left"><span>：</span><div class="justify">质 证 号<span></span></div></span><input type="text" maxlength="100" id="quality" placeholder="请输入质证号"></div>
			<div class="dialog_item"><span class="title_left"><span>：</span><div class="justify">备 注<span></span></div></span><input type="text" maxlength="100" id="remark" ></div>
			<div class="bottom_btn_group"></div>
		</div>
		<div class="dialog_bg"></div>
	</body>
</html>
