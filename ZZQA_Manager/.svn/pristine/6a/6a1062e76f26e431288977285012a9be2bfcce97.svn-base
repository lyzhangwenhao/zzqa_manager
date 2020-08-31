<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
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
	String keywords_device = "";
	if (session.getAttribute("keywords_device") != null) {
		keywords_device = (String) session
				.getAttribute("keywords_device");
	}
	int nowpage_device = 1;//当前页码
	if (session.getAttribute("nowpage_device") != null) {
		nowpage_device = Integer.parseInt((String) session
				.getAttribute("nowpage_device"));
	}
	String state_device = null;
	if (session.getAttribute("keywords_device") != null) {
		state_device = (String) session
				.getAttribute("state_device");
	}else{
		state_device="1111";
	}
	int newtime_device=0;//1：按生产时间搜索
	if (session.getAttribute("newtime_device") != null) {
		newtime_device = (Integer) session
				.getAttribute("newtime_device");
	}
	long starttime_device=0l;
	if (newtime_device==1&&session.getAttribute("starttime_device") != null) {
		starttime_device = (Long) session
				.getAttribute("starttime_device");
	}
	long endtime_device=0l;
	if (newtime_device==1&&session.getAttribute("endtime_device") != null) {
		endtime_device = (Long) session
				.getAttribute("endtime_device");
	}
	Object device_pageTypeObj=session.getAttribute("device_pageType");
	int device_pageType=5;//1：模板管理；2：添加模板；3：我的添加的产品；4：添加产品；5：产品管理表
	if(device_pageTypeObj!=null){
		device_pageType=(Integer)device_pageTypeObj;
	}
	pageContext.setAttribute("device_pageType", device_pageType);
	pageContext.setAttribute("nowpage_device", nowpage_device);
	pageContext.setAttribute("keywords_device", keywords_device);
	pageContext.setAttribute("state_device", state_device);
	pageContext.setAttribute("newtime_device", newtime_device);
	pageContext.setAttribute("starttime_device", starttime_device);
	pageContext.setAttribute("endtime_device", endtime_device);
	pageContext.setAttribute("template_manager", (Boolean)session.getAttribute("template_manager"));
	pageContext.setAttribute("new_device", (Boolean)session.getAttribute("new_device"));
	pageContext.setAttribute("watch_device", (Boolean)session.getAttribute("watch_device"));//只有新建权限的用户只能查看自己添加的产品
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>产品管理表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/bootstrap/bootstrap.min-3.2.css">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/custom.css">
		<link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-filer.css">
		<link rel="stylesheet" type="text/css" href="css/default.css">
		<link rel="stylesheet" type="text/css"
			href="css/jquery.filer-dragdropbox-theme.css">
		<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<link rel="stylesheet" type="text/css" href="css/device.css">
		<script type="text/javascript" src="js/showdate1.js"></script>
		<script src="js/prettify.js" type="text/javascript"></script>
		<script  type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script src="js/jquery.filer.min.js" type="text/javascript"></script>
		<script  type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script  type="text/javascript" src="js/dialog.js"></script>
		<script  type="text/javascript" src="js/public.js"></script>
		<script type="text/javascript" src="js/devicemanager.js"></script>
		<!-- 选将input加载到body再由custom.js渲染 -->
		<script src="js/custom1.js" type="text/javascript"></script>
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
			var flag=0;//0：隐藏
			var device_change=false;//添加或删除产品操作需要刷新产品管理表
			var pageRow=20;//每页显示的个数
			var allpage=0;//页数
			var nowpage_device=${nowpage_device};
			var device_pageType=${device_pageType};//页面类型  1：模板管理；2：我添加的产品；3：添加产品；4:产品管理表
			var state_device="${state_device}";//1111产品状态是否选中
			var keywords_device="${keywords_device}";
			var starttime_device=${starttime_device};
			var endtime_device=${endtime_device};
			var nowTempJson;//选中的模板 if(nowTempJson){//表示修改}else{//新建}
			var nowDeviceJson;//选中的产品if(nowDeviceJson){//表示修改}else{//新建}
			var deviceJson;//产品管理表的数据
			var myDeviceJson;//我新建的产品
			var tempJson;//产品管理表的数据
			var stateArray = ["入库","出库","发货","到货"];
			var watch_device=${watch_device};
		    var save_time=0;
		</script>
	</head>

	<body>
		<jsp:include page="/top.jsp" >
	<jsp:param name="index" value="2" />
	</jsp:include>
				<div class="td1_device">
				<div class="device_top_btns">
				<div class="btn-group" role="group" aria-label="...">
				  <c:if test="${template_manager}">
				  	 <button type="button" class="btn btn-default" onclick="setPage(1)">模板管理</button>
				  	 <button type="button" class="btn btn-default" onclick="setPage(2)">添加模板</button>
				  </c:if>
				  <c:if test="${new_device}">
				  	<button type="button" class="btn btn-default" onclick="setPage(3)">我新建的</button>
				  	<button type="button" class="btn btn-default" onclick="setPage(4)">添加产品</button>
				  </c:if>
				   <button type="button" class="btn btn-default" onclick="setPage(5)">产品管理表</button>
				</div>
				</div>
				<div class="td1_div0">
					产品管理表
				</div>
				<div id="modules_1">
					<table class="device_tab" id="tempmanager_tab">
						<tr class="tab_tr1">
							<td class="tab_tr1_td1">
								别名
							</td>
							<td class="tab_tr1_td5">
								印制版
							</td>
						</tr>
					</table>
				</div>
				<div id="modules_2">
					<div class="td2_div1">
						<img title="搜索" src="images/user_search.gif" id="img_search"
							onclick="getDevice();" class="serach_img1">
						<input type="text" id="keywords_mydevice"  maxlength="30" placeholder="关键词：ID、批次号、"
							onkeydown="if(event.keyCode==32) return false">
					</div>
					<table class="device_tab" id="mydevicemanager_tab">
						<tr class="tab_tr1">
							<td class="tab_tr1_td1" style="min-width:78px;">
								ID
							</td>
							<td class="tab_tr1_td2">
								批次号
							</td>
							<td class="tab_tr1_td5" style="width:65px;">
								印制版
							</td>
							<td class="tab_tr1_td6" style="width:78px;">
								测试报告
							</td>
							<td class="tab_tr1_td7">
								合格
							</td>
							<td class="tab_tr1_td8">
								生产时间
							</td>
						</tr>
					</table>
				</div>
				<div id="modules_4">
					<div class="device_allnum" style="top:0">
						台数统计：0台
					</div>
					<div class="td2_div1">
						<img title="显示筛选" src="images/search_press.jpg" id="img_adv"
											onclick="adv_search();" class="serach_img2">
						<img title="搜索" src="images/user_search.gif" id="img_search"
							onclick="pageBegin(true);" class="serach_img1">
						<input type="text" id="keywords_device"  maxlength="30" placeholder="关键词：ID、批次号、项目名称..."
							value="${keywords_device}" onkeydown="if(event.keyCode==32) return false" >
					</div>
					<div class="td2_div2" id="td2_div2">
						<div class="td2_div2_b" id="state_parent">
						</div>
						<div class="td2_div2_c">
							操作时间：<label><input id="newtime_device" type="checkbox" onclick="setTimeFilter();" ${newtime_device==1?"checked":""}/>使用新建时间筛选
							</label>
							<div id="newtime_div" class="td2_div2_c_div">
							<input type="text" id="starttime_device" onClick="return Calendar('starttime_device');" 
								readonly="readonly"/> - <input type="text" id="endtime_device"
								onClick="return Calendar('endtime_device');" readonly="readonly"/></div>
						</div>
						<div class="td2_div2_d">
							<input type="button" value="筛选" class="search_left" onclick="pageBegin(true);adv_search();">
							<input type="button" value="重置" class="reset_right" onclick="resetFilter();adv_search();">
						</div>
					</div>
					<table class="device_tab" id="devicemanager_tab">
						<tr class="tab_tr1">
							<td class="tab_tr1_td1" style="min-width:78px;">
								ID
							</td>
							<td class="tab_tr1_td2">
								批次号
							</td>
							<td class="tab_tr1_td3" style="width:90px;">
								项目编号
							</td>
							<td class="tab_tr1_td4" style="width:90px;">
								项目名称
							</td>
							<td class="tab_tr1_td5" style="width:65px;">
								印制版
							</td>
							<td class="tab_tr1_td6" style="width:78px;">
								测试报告
							</td>
							<td class="tab_tr1_td7" style="width:55px;">
								合格
							</td>
							<td class="tab_tr1_td8" style="width:80px;">
								生产时间
							</td>
							<td class="tab_tr1_td10" style="min-width:40px;">
								地址
							</td>
							<td class="tab_tr1_td11" style="width:80px;">
								发货时间
							</td>
							<td class="tab_tr1_td12" style="width:80px;">
								到货时间
							</td>
							<td class="tab_tr1_td13" style="width:70px;">
								状态
							</td>
						</tr>
					</table>
					<div class="device_allnum">
						台数统计：0台
					</div>
					<div class="td2_div5">
					</div>
				</div>
				
		</div>
		<div class="temp_dialog">
			<div class="alias_div">
				<span>
					<span class="star">*</span>别名：
				</span>
				<input type="text" maxlength="50" id="alias">
			</div>
			<div class="temp_dialog_add"><span>印制板</span><div class="addtemp_btn" onclick="addCard();" title="添加"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></div></div>
			<div class="temp_dialog_content">
				
			</div>
			<div class="temp_dialog_btns">
				<img src="images/cancle_materials.png" onclick="closeDialog(0)">
				<img src="images/del_materials.png" onclick="closeDialog(1)">
				<img src="images/submit_materials.png" onclick="closeDialog(2)">
			</div>
		</div>
		<div class="device_dialog">
			<div class="alias_div" id="id_parent">
				<span>
					<span class="star">*</span>ID：
				</span>
				<input type="text" maxlength="8" id="id" oninput="checkNum(this)">
			</div>
			<div class="alias_div">
				<span>
					<span class="star">*</span>SN：
				</span>
				<input type="text" maxlength="50" id="sn">
			</div>
			<div class="alias_div">
				<span>
					模板：
				</span>
				<select id="temp_select"></select>
			</div>
			<div class="temp_dialog_add"><span>印制板</span></div>
			<div class="device_dialog_content">
				
			</div>
			<div class="temp_dialog_title"><span>测试报告</span></div>
			<div class="device_dialog_filelist"></div>
			<div class="device_dialog_btns">
				<img src="images/cancle_materials.png" onclick="closeDialog(0)">
				<img src="images/del_materials.png" onclick="closeDialog(1)">
				<img src="images/submit_materials.png" onclick="closeDialog(2)">
				<div class="device_dialog_addfile" onclick="$('#device_file_parent .jFiler-input').click()">添加附件</div>
			</div>
		</div>
		<div class="device_dialog_bg"></div>
	</body>
</html>
