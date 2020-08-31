<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page
	import="com.zzqa.service.interfaces.procurement.ProcurementManager"%>
<%@page
	import="com.zzqa.service.interfaces.project_procurement.Project_procurementManager"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.service.interfaces.file_path.File_pathManager"%>
<%@page import="com.zzqa.service.interfaces.task.TaskManager"%>
<%@page import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.project_procurement.Project_procurement"%>
<%@page import="com.zzqa.pojo.procurement.Procurement"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page import="com.zzqa.pojo.file_path.File_path"%>
<%@page import="com.zzqa.pojo.task.Task"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.zzqa.pojo.task.Task"%>
<%
	request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	ProcurementManager procurementManager = (ProcurementManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("procurementManager");
	Project_procurementManager project_procurementManager = (Project_procurementManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("project_procurementManager");
	FlowManager flowManager = (FlowManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("flowManager");
	File_pathManager file_pathManager = (File_pathManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("file_pathManager");
	TaskManager taskManager = (TaskManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("taskManager");
	Position_userManager position_userManager = (Position_userManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("position_userManager");
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
	if (session.getAttribute("project_pid") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	} 
	int project_pid = (Integer)session.getAttribute("project_pid");
	Project_procurement project_procurement = project_procurementManager
			.getProject_procurementByID(project_pid);
	Flow flow = flowManager.getNewFlowByFID(3, project_pid);
	if(project_procurement==null||flow==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int operation = flow.getOperation();
	List<Procurement> procurementList = procurementManager
			.getProcurementListLimit(2, project_pid);
	//控制页面流程进度显示
	Map<String, String> map = project_procurementManager
			.getProjectPFlowForDraw(project_procurement,flow);
	List<File_path> flieList1=null;
	String budgetSubmiter="";//预算提交人
	if(project_procurement.getProject_pid()>0){
		flieList1 = file_pathManager.getAllFileByCondition(
				3, project_procurement.getProject_pid(), 1, 0);
		Project_procurement project_procurement2 = project_procurementManager
				.getProject_procurementByID(project_procurement.getProject_pid());
		if(project_procurement2==null){
			budgetSubmiter="匿名用户";
		}else{
			User user=userManager.getUserByID(project_procurement2.getCreate_id());
			if(user==null){
				budgetSubmiter="用户"+project_procurement2.getCreate_id();
			}else{
				budgetSubmiter=user.getTruename();
			}
		}
	}else{
		budgetSubmiter=project_procurement.getCreate_name();
		flieList1 = file_pathManager.getAllFileByCondition(
				3, project_pid, 1, 0);
	}
	List<File_path> flieList = file_pathManager.getAllFileByCondition(
			3, project_pid, 4, 0);
	List<File_path> flieList2 = file_pathManager.getAllFileByCondition(
			3, project_pid, 2, 0);
	List<File_path> flieList3 = file_pathManager.getAllFileByCondition(
			3, project_pid, 3, 0);
	List<Flow> reasonList = flowManager.getReasonList(3, project_pid);
	Task task = taskManager.getTaskByID(project_procurement
			.getTask_id());
	if(task==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int reasonLen = reasonList.size();
	boolean isCreater=mUser.getId()==project_procurement.getCreate_id();
	boolean isBuyer=permissionsManager.checkPermission(mUser.getPosition_id(), 21);
	boolean isChecker=permissionsManager.checkPermission(mUser.getPosition_id(), 22);
	boolean isPuter=permissionsManager.checkPermission(mUser.getPosition_id(), 23);
	boolean flag_pro=false;//有输入框时显示保存按钮
	boolean canDel=false;
	//if(operation!=3||operation==13||operation==15){
	//2019-2-13 修改：撤消状态和完成状态不可以显示撤销按钮其他状态均可
	if(operation!=17 && operation!=10){
		canDel=isCreater;//创建人才能撤销
	}
	boolean isWatcher="admin".equals(mUser.getName())||task.getCreate_id()==mUser.getId();
	if(!isWatcher){
		isWatcher=(task.getType()==0&&permissionsManager.checkPermission(mUser.getPosition_id(), 10))||(task.getType()==1||permissionsManager.checkPermission(mUser.getPosition_id(), 115));
	}
	boolean product_submiter=false;//该项目采购单关联的生产主管（未填采购单时有普通提交权限亦可），可编辑采购单，并接受邮件
	Flow flow4=flowManager.getFlowByOperation(3, project_pid, 4);//是否填过采购单
	String productSubmiter="";//采购单提交人
	if(flow4==null){
		product_submiter=permissionsManager.checkPermission(mUser.getPosition_id(), 3);
	}else{
		product_submiter=mUser.getId()==flow4.getUid();
		User user=userManager.getUserByID(flow4.getUid());
		if(user==null){
			productSubmiter="用户"+flow4.getUid();
		}else{
			productSubmiter=user.getTruename();
		}
	}
	boolean budget_submiter=mUser.getId()==project_procurement.getCreate_id();//判断预算表提交者，可修改预算表
	pageContext.setAttribute("flieList", flieList);
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>项目采购流程</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css"
			href="css/projectp_flow_detail.css">
		<link rel="stylesheet" type="text/css" href="css/custom.css">
		<link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-filer.css">
		<link rel="stylesheet" type="text/css" href="css/default.css">
		<link rel="stylesheet" type="text/css"
			href="css/jquery.filer-dragdropbox-theme.css">
		<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
		<script src="js/showdate1.js" type="text/javascript"></script>
		<script src="js/prettify.js" type="text/javascript"></script>
		<script src="js/jquery.min.js" type="text/javascript"></script>
		<script src="js/jquery.filer.min.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		<script type="text/javascript" src="js/refresh_scroll.js"></script>
		<!-- 先将隐藏的上传控件加到body，再渲染 -->
		<script type="text/javascript" src="js/custom.js"></script>
		
		<!--[if IE]>
			<script src="http://libs.useso.com/js/html5shiv/3.7/html5shiv.min.js"></script>
		<![endif]-->
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
		var pass_percent="";
		<%if(procurementList!=null && procurementList.size()!=0) {%>
			var procurement_num = <%=procurementList.size()%>+1;
		<%} else{%>
			var procurement_num=1;
		<%}%>
		var flag=<%=(operation>4&&operation<12)||operation==14||operation==16?0:1%>;//0:隐藏状态
		$(function(){
			if($("#procurement_finished").length>0){
				checkCover(1);
			}
			if($("#check_finished").length>0){
				checkCover(2);
			}
			if($("#save_procurement").length>0){
				checkCover(3);
			}
			$(".td2_table_hide").click(function(){
				hideApprove(flag);
			});
			if($(".td2_table_hide").length>0&&flag==1){
				$(".td2_table_hide span").text("隐藏预算审批");
				$(".td2_table_hide img").attr("src","images/show_check.png");
				$(".td2_table8").toggle();
			}
			initauto();
		});
		$(".td2_table_hide").click(function(){
			hideApprove();
		});
		function hideApprove(){
			if(flag==0){
				$(".td2_table_hide span").text("隐藏预算审批");
				$(".td2_table_hide img").attr("src","images/show_check.png");
				flag=1;
			}else{
				$(".td2_table_hide span").text("显示预算审批");
				$(".td2_table_hide img").attr("src","images/hide_check.png");
				flag=0;
			}
			$(".td2_table8").toggle();
		}
		var procurementIDArray =[ 
			<%
			int m=procurementList.size();
			for(int i=0;i<m;i++){
				if(i!=0){
					out.write(",");
				}
				out.write("'"+procurementList.get(i).getId()+"'");
			}
			%>
			];
		function deleteProject(){
			initdiglogtwo2("提示信息","你确定要撤销该项目采购单吗？");
	   		$( "#confirm2" ).click(function() {
	   			$( "#twobtndialog" ).dialog( "close" );
	   			if($(".div_testarea").val().replace(/[ ]/g, "").length>0){
	   				document.flowform.type.value="deleteProject";
	   				document.flowform.submit();
				}else{
					initdiglog2("提示信息","请输入撤销原因");
					return;
				}
	   		});
		}
	   	function verifyFlow(isagree){
			document.flowform.isagree.value=isagree;
			var reason=document.flowform.reason.value.replace(/[ ]/g, "");
			if(reason.length==0){
				initdiglog2("提示信息","请输入意见或建议！");
				return;
			}
			document.flowform.submit();
		}
		function addProcurement(flag){
			var k=1;
	   		var product_value="";
	   		for(var i=1;i<procurement_num;i++){
	   			if(document.getElementById("table1_tr"+i)){
	   			    var name=document.getElementById("name"+i).value;
			   		var agent=document.getElementById("agent"+i).value;
			   		var model=document.getElementById("model"+i).value;
			   		var materials_code=document.getElementById("materials_code"+i).value;
			   		var num=document.getElementById("num"+i).value;
			   		var unit=document.getElementById("unit"+i).value;
					if(name!=null&&name.length>0&&agent!=null&&agent.length>0&&model!=null&&model.length>0
							&&materials_code!=null&&materials_code.length>0&&unit!=null&&unit.length>0){
						if(!validate(num)){
							initdiglog2("提示信息","第 "+k+"行【数量】输入有误！");
							return;
						}
						if(k==1){
							product_value=name+"の"+agent+"の"+model+"の"+materials_code+"の"+num+"の"+unit;
						}else{
							product_value+="い"+name+"の"+agent+"の"+model+"の"+materials_code+"の"+num+"の"+unit;
						}
					}else{
						initdiglog2("提示信息","第 "+k+" 行信息不正确！");
						return;
					}
					k++;
				}
	   		}
	   		var name=document.getElementById("name0").value;
	   		var agent=document.getElementById("agent0").value;
	   		var model=document.getElementById("model0").value;
	   		var materials_code=document.getElementById("materials_code0").value;
	   		var num=document.getElementById("num0").value;
	   		var unit=document.getElementById("unit0").value;
			if(name!=null&&name.length>0&&agent!=null&&agent.length>0
					&&materials_code!=null&&materials_code.length>0&&unit!=null&&unit.length>0){
				if(!validate(num)){
					initdiglog2("提示信息","第 "+k+"行【数量】输入有误！");
					return;
				}
				if(product_value.length<1){
					product_value=name+"の"+agent+"の"+model+"の"+materials_code+"の"+num+"の"+unit;
				}else{
					product_value+="い"+name+"の"+agent+"の"+model+"の"+materials_code+"の"+num+"の"+unit;
				}
			}else{
				initdiglog2("提示信息","第 "+k+" 行信息不正确！");
				return;
			}
	   		document.flowform.product_value.value=product_value;
			if (flag){//提交
				document.flowform.isSave.value=true;
			}else {//暂存
				document.flowform.isSave.value=false;
				document.flowform.type.value="saveProjectproflow";
			}
	   		document.flowform.submit();
		}
		function restr(name){
	   		name.value=name.value.replace(/\D/g,"");
	   	}
		function submitPass(){
			for(var j=0;j<procurementIDArray.length;j++){
				var name="pass"+j;
				var pass_value=document.getElementById(name).value;
				if(!validate_pass(pass_value)){
    				initdiglog2("提示信息","第"+(j+1)+"行【合格率】输入有误！");
    				return;
  				}
  				if(j==0){
  					pass_percent=procurementIDArray[j]+"の"+pass_value;
  				}else{
  					pass_percent+="い"+procurementIDArray[j]+"の"+pass_value;
  				}
			}
			document.flowform.pass_percent.value=pass_percent;
			document.flowform.submit();
		}
		function addTitle(){
			resetRefresh();//重置刷新
			var temp = '<tr class="table1_tr1"><td class="table1_tr1_td1">产品名称</td>'
				+ '<td class="table1_tr1_td2">品牌/制造商</td>'
				+ '<td class="table1_tr1_td3">规格/型号</td>'
				+ '<td class="table1_tr1_td7">物料编码</td>'
				+ '<td class="table1_tr1_td4">数量</td>'
				+ '<td class="table1_tr1_td5">单位</td>'
				+ '<td class="table1_tr1_td6">操作</td></tr>';
			for (var i = 1; i < procurement_num; i++) {
				if (document.getElementById("table1_tr" + i)) {
					var name = document.getElementById("name" + i).value;
					var agent = document.getElementById("agent" + i).value;
					var model = document.getElementById("model" + i).value;
					var materials_code = document.getElementById("materials_code" + i).value;
					var num = document.getElementById("num" + i).value;
					var unit = document.getElementById("unit" + i).value;
					temp += '<tr class="table1_tr2" id="table1_tr'+i+'">'
							+ '<td class="table1_tr2_td1"><input type="text" id="name'+i+'" value="'+name+'" maxlength="50"></td>'
							+ '<td class="table1_tr2_td2"><input type="text" id="agent'+i+'" value="'+agent+'" maxlength="50"></td>'
							+ '<td class="table1_tr2_td3"><input type="text" id="model'+i+'" value="'+model+'" maxlength="50"></td>'
							+ '<td class="table1_tr2_td7"><input type="text" id="materials_code'+i+'" value="'+materials_code+'" maxlength="50"></td>'
							+ '<td class="table1_tr2_td4"><input type="text" id="num'+ i+ '" value="'+ num+ '" maxlength="9"'+ 'onkeyup="restr(this)" onafterpaste="restr(this)"></td>'
							+ '<td class="table1_tr2_td5"><input type="text" id="unit'+i+'" value="'+unit+'" maxlength="10"></td>'
							+ '<td class="table1_tr2_td6"><img src="images/delete.png" title="删除" onclick="del('
							+ i + ')"></td></tr>';
				}
			}
			return temp;
		}
		function addNew(){
			var name = document.getElementById("name0").value;
			var agent = document.getElementById("agent0").value;
			var model = document.getElementById("model0").value;
			var materials_code = document.getElementById("materials_code0").value;
			var num = document.getElementById("num0").value;
			var unit = document.getElementById("unit0").value;
			var temp = '<tr class="table1_tr2" id="table1_tr'+procurement_num+'">'
					+ '<td class="table1_tr2_td1"><input type="text" id="name'+procurement_num+'" value="'+name+'" maxlength="50"></td>'
					+ '<td class="table1_tr2_td2"><input type="text" id="agent'+procurement_num+'" value="'+agent+'" maxlength="50"></td>'
					+ '<td class="table1_tr2_td3"><input type="text" id="model'+procurement_num+'" value="'+model+'" maxlength="50"></td>'
					+ '<td class="table1_tr2_td7"><input type="text" id="materials_code'+procurement_num+'" value="'+materials_code+'" maxlength="50"></td>'
					+ '<td class="table1_tr2_td4"><input type="text" id="num'+ procurement_num+'" value="'+ num+ '" maxlength="9"'
					+ 'onkeyup="restr(this)" onafterpaste="restr(this)"></td>'
					+ '<td class="table1_tr2_td5"><input type="text" id="unit'+procurement_num+'" value="'+unit+'" maxlength="10"></td>'
					+ '<td class="table1_tr2_td6"><img src="images/delete.png" title="删除" onclick="del('+ procurement_num+ ')"></td></tr>';
			return temp; 
		}
		function addLast() {
			var temp='<tr class="table1_tr2" id="table1_tr0">'
					+ '<td class="table1_tr2_td1"><input type="text" id="name0" maxlength="50"></td>'
					+ '<td class="table1_tr2_td2"><input type="text" id="agent0" maxlength="50"></td>'
					+ '<td class="table1_tr2_td3"><input type="text" id="model0" maxlength="50"></td>'
					+ '<td class="table1_tr2_td7"><input type="text" id="materials_code0" maxlength="50"></td>'
					+ '<td class="table1_tr2_td4"><input type="text" id="num0" maxlength="9" onkeyup="restr(this)" onafterpaste="restr(this)"></td>'
					+ '<td class="table1_tr2_td5"><input type="text" id="unit0" maxlength="10"></td>'
					+ '<td class="table1_tr2_td6"><img src="images/delete.png" title="删除" onclick="del(0)">'
					+ '<img src="images/add_linkman.png" title="添加" onclick="add();"></td></tr>';
				procurement_num++;
				return temp;
		}
		function add() {
			var temp=addTitle();
			temp+=addNew();
			temp+=addLast();
			var docTable = document.getElementById("td2_table1");
			docTable.innerHTML = temp;
			initauto();
		}
	   	function del(n){
	   		resetRefresh();
	   		var id="table1_tr"+n;
	   		var obj = document.getElementById(id);
			if (obj != null) {
				if(n == 0){
					for(var i=procurement_num-1;i>=0;i--){
						if(document.getElementById("table1_tr"+i)){
							if(i == 0){
								initdiglog2("提示信息","至少保留一行！");
								return;
							}
							document.getElementById("name0").value = document.getElementById("name"+i).value;
							document.getElementById("agent0").value = document.getElementById("agent"+i).value;
							document.getElementById("model0").value = document.getElementById("model"+i).value;
							document.getElementById("materials_code0").value = document.getElementById("materials_code"+i).value;
							document.getElementById("num0").value = document.getElementById("num"+i).value;
							document.getElementById("unit0").value = document.getElementById("unit"+i).value;
							var lastId = "table1_tr"+ i;
							var lastObj = document.getElementById(lastId);
							lastObj.parentNode.removeChild(lastObj);
							break;
						}
					}
				}
				else{
					obj.parentNode.removeChild(obj);
				}
			}
	   	}
	   	function exportExcel() {
			var excel_data = "";
			var k=0;
			for (var i = 1; i < procurement_num + 1; i++) {
				if (document.getElementById("table1_tr" + i)) {
					k++;
					var name = document.getElementById("name" + i).value;
					var agent = document.getElementById("agent" + i).value;
					var model = document.getElementById("model" + i).value;
					var materials_code = document.getElementById("materials_code" + i).value;
					var num = document.getElementById("num" + i).value;
					var unit = document.getElementById("unit" + i).value;
					if (name != null && name.length > 0 && agent != null
							&& agent.length > 0 && model != null
							&& model.length > 0 && num != null && unit != null
							&& unit.length > 0) {
						if(!validate(num)){
							initdiglog2("提示信息", "第 " + k + "行【数量】输入有误！");
							return;
						}
						if (excel_data == "") {
							excel_data = name + "の" + agent + "の" + model + "の"+materials_code+ "の"
									+ num + "の" + unit;
						} else {
							excel_data += "い" + name + "の" + agent + "の" + model+ "の"+materials_code
									+ "の" + num + "の" + unit;
						}
					} else {
						initdiglog2("提示信息", "第 " + k + "行信息不完整！");
						return;
					}
				}
			}
			k++;
			var name = document.getElementById("name0").value;
			var agent = document.getElementById("agent0").value;
			var model = document.getElementById("model0").value;
			var materials_code = document.getElementById("materials_code0").value;
			var num = document.getElementById("num0").value;
			var unit = document.getElementById("unit0").value;
			if (name != null && name.length > 0 && agent != null&& agent.length > 0 
					&& model != null && model.length > 0&& materials_code != null && materials_code.length > 0
					&& num != null && unit != null && unit.length > 0) {
				if(!validate(num)){
					initdiglog2("提示信息", "第 " + k + "行【数量】输入有误！");
					return;
				}
				if (excel_data.length < 1) {
					excel_data = name + "の" + agent + "の" + model + "の" + materials_code + "の" + num
							+ "の" + unit;
				} else {
					excel_data += "い" + name + "の" + agent + "の" + model + "の"+ materials_code + "の"
							+ num + "の" + unit;
				}
			} else {
				initdiglog2("提示信息", "第 " + k + "行信息不完整！");
				return;
			}
			if (excel_data == "") {
				initdiglog2("提示信息", "没有数据！");
				return;
			}
			excelDown(excel_data,3);
		}
	   	function exportExcel2() {
	   		excelExportOut(2,<%=project_procurement.getId()%>);
		}
		function importExcel(data){
			var myobj=eval(data);  
			if(myobj.length<1){
				initdiglog2("提示信息","没有数据！");
				return;
			}
			var temp=addTitle();
			
			//最后一行特殊处理
			var name0 = document.getElementById("name0").value;
			var agent0 = document.getElementById("agent0").value;
			var model0 = document.getElementById("model0").value;
			var materials_code0 = document.getElementById("materials_code0").value;
			var num0 = document.getElementById("num0").value;
			var unit0 = document.getElementById("unit0").value;
			if (name0.length > 0 || agent0.length > 0 || model0.length > 0||materials_code0.length>0||num0.length>0|| unit0.length > 0) {
				temp += '<tr class="table1_tr2" id="table1_tr'+procurement_num+'">'
				+ '<td class="table1_tr2_td1"><input type="text" id="name'+procurement_num+'" value="'+name0+'" maxlength="50"></td>'
				+ '<td class="table1_tr2_td2"><input type="text" id="agent'+procurement_num+'" value="'+agent0+'" maxlength="50"></td>'
				+ '<td class="table1_tr2_td3"><input type="text" id="model'+procurement_num+'" value="'+model0+'" maxlength="50"></td>'
				+ '<td class="table1_tr2_td7"><input type="text" id="materials_code'+procurement_num+'" value="'+materials_code0+'" maxlength="50"></td>'
				+ '<td class="table1_tr2_td4"><input type="text" id="num'+ procurement_num+ '" value="'+num0+ '" maxlength="9"'+ 'onkeyup="restr(this)" onafterpaste="restr(this)"></td>'
				+ '<td class="table1_tr2_td5"><input type="text" id="unit'+procurement_num+'" value="'+unit0+'" maxlength="10"></td>'
				+ '<td class="table1_tr2_td6"><img src="images/delete.png" title="删除" onclick="del('+procurement_num + ')"></td></tr>';
				procurement_num++;
			}
			for(var i=0;i<myobj.length;i++){
				var name=myobj[i].name;
				var agent=myobj[i].agent;
				var model=myobj[i].model;
				var materials_code=myobj[i].materials_code;
				if(materials_code==null){
					materials_code="";
				}
				var num=myobj[i].num;
				var unit=myobj[i].unit;
				if(i==myobj.length-1){
					temp+='<tr class="table1_tr2" id="table1_tr0">'
						+ '<td class="table1_tr2_td1"><input type="text" id="name0" value="'+name+'" maxlength="50"></td>'
						+ '<td class="table1_tr2_td2"><input type="text" id="agent0" value="'+agent+'" maxlength="50"></td>'
						+ '<td class="table1_tr2_td3"><input type="text" id="model0" value="'+model+'" maxlength="50"></td>'
						+ '<td class="table1_tr2_td7"><input type="text" id="materials_code0" value="'+materials_code+'" maxlength="50"></td>'
						+ '<td class="table1_tr2_td4"><input type="text" id="num0" value="'+num+'" maxlength="9" onkeyup="restr(this)" onafterpaste="restr(this)"></td>'
						+ '<td class="table1_tr2_td5"><input type="text" id="unit0" value="'+unit+'" maxlength="10"></td>'
						+ '<td class="table1_tr2_td6"><img src="images/delete.png" title="删除" onclick="del(0)">'
						+ '<img src="images/add_linkman.png" title="添加" onclick="add();"></td></tr>';
				}else{
					temp += '<tr class="table1_tr2" id="table1_tr'+procurement_num+'">'
					+ '<td class="table1_tr2_td1"><input type="text" id="name'+procurement_num+'" value="'+name+'" maxlength="50"></td>'
					+ '<td class="table1_tr2_td2"><input type="text" id="agent'+procurement_num+'" value="'+agent+'" maxlength="50"></td>'
					+ '<td class="table1_tr2_td3"><input type="text" id="model'+procurement_num+'" value="'+model+'" maxlength="50"></td>'
					+ '<td class="table1_tr2_td7"><input type="text" id="materials_code'+procurement_num+'" value="'+materials_code+'" maxlength="50"></td>'
					+ '<td class="table1_tr2_td4"><input type="text" id="num'+ procurement_num+ '" value="'+ num+ '" maxlength="9"'
					+ 'onkeyup="restr(this)" onafterpaste="restr(this)"></td>'
					+ '<td class="table1_tr2_td5"><input type="text" id="unit'+procurement_num+'" value="'+unit+'" maxlength="10"></td>'
					+ '<td class="table1_tr2_td6"><img src="images/delete.png" title="删除" onclick="del('+procurement_num + ')"></td></tr>';
				}
				procurement_num++;
			}
			var docTable = document.getElementById("td2_table1");
			docTable.innerHTML = temp;
			initauto();
			initdiglog2("提示信息","导入成功！");
		}
	   	function validate_pass(sDouble){
	   		//检验是否为大于等于0
  			var re = /^\d+(?=\.{0,1}\d+$|$)/;
 		 	return re.test(sDouble)&&(!(sDouble>100));
		}
 		function validate(sDouble){
			//检验是否为正整数
  			var re = /^\+?[1-9][0-9]*$/;
 		 	return re.test(sDouble)&&sDouble>0;
		}
		function checkCover(flag){
			if(flag==1){
				if(isFinish("pre")){//是否可点击-完成采购
					$("#procurement_finished").attr("src","images/procurement_finished.png");
					$("#procurement_finished").css("cursor","pointer");
				}else{
					$("#procurement_finished").attr("src","images/procurement_finished_disabled.png");
					$("#procurement_finished").css("cursor","default");
				}
			}else if(flag==2){//判断是否可点击-完成验货
				if(isFinish("aog")&&isFinish("pass")){
					$("#check_finished").attr("src","images/check_finished.png");
					$("#check_finished").css("cursor","pointer");
				}else{
					$("#check_finished").attr("src","images/check_finished_disabled.png");
					$("#check_finished").css("cursor","default");
				}
			}else if(flag==3){//判断是否可点击-保存
				if(checkSave("pre")||checkSave("aog")){
					$("#save_procurement").attr("src","images/save.png");
					$("#save_procurement").css("cursor","pointer");
				}else{
					$("#save_procurement").attr("src","images/save_disabled.png");
					$("#save_procurement").css("cursor","default");
				}
			}
		}
		//检查是否填完
		function isFinish(id){
			for(var i=0;i<<%=procurementList.size()%>;i++){
				if($("#"+id+i).val().length==0){//未填写完整或存在非input,td的val()返回“”
					return false;
				}
			}
			return true;
		}
		//检查是否有值，有值时显示保存按钮
		function checkSave(id){
			for(var i=0;i<<%=procurementList.size()%>;i++){
				if($("#"+id+i).val().length>0){
					return true;
				}
			}
			return false;
		}

		function updateProcurement(finished){
			var flag=finished>0?true:false;
			var pre_time="";
			//判断用户是否可编辑
			if(document.getElementById("pre0").nodeName=="INPUT"){
				for(var i=0;i<<%=procurementList.size()%>;i++){
					if(i>0){
						pre_time+="の";
					}
					if($("#pre"+i).val().length>0){
						pre_time+=$("#pre"+i).val();
					}else{
						if(finished==1){
							initdiglog2("提示信息","第"+(i+1)+"行预计时间未填写！");
							return;
						}
						pre_time+="@";
					}
				}
			}
			var aog_time="";
			var pass_percent="";
			if(<%=isChecker%>){
				for(var i=0;i<<%=procurementList.size()%>;i++){
					if(aog_time.length>0){
						aog_time+="の";
					}
					if(pass_percent.length>0){
						pass_percent+="の";
					}
					//判断用户是否可编辑
					if(document.getElementById("aog"+i).nodeName=="INPUT"){
						if($("#aog"+i).val().length>0){
							aog_time+=$("#aog"+i).val();
						}else{
							aog_time+="@";
						}
						if($("#pass"+i).val().length>0){//td的val()返回“”
							if($("#aog"+i).val().length==0){
								initdiglog2("提示信息","第"+(i+1)+"行到货时间未填写！");
								return;
							}
							if(!validate_pass($("#pass"+i).val())){
								initdiglog2("提示信息","第"+(i+1)+"行合格率输入有误！");
								return;
							}
							pass_percent+=$("#pass"+i).val();
						}else{
							if(finished==2){
								initdiglog2("提示信息","第"+(i+1)+"行合格率未填写！");
								return;
							}
							pass_percent+="@";
						}
					}else{
						if(finished==2){
							initdiglog2("提示信息","第"+(i+1)+"行到货时间未填写！");
							return;
						}
						aog_time+="@";
						pass_percent+="@";
					}
				}
			}
			$.ajax({
				type:"post",//post方法
				url:"FlowManagerServlet",
				data:{"type":"projectproflow","project_pid":<%=project_procurement.getId()%>,"operation":<%=operation%>,"finished":flag,"pre_time":pre_time,"aog_time":aog_time,"pass_percent":pass_percent},
				timeout : 20000, //超时时间设置，单位毫秒
				complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
					if(status=='timeout'){//超时,status还有success,error等值的情况
						initdiglog2("提示信息","请求超时，请重试!"); 
					}
				}, 
				//ajax成功的回调函数
				success:function(returnData){
					if(returnData==1){
						initdiglog2("提示信息","保存成功！");
					}else if(returnData==2){
						window.location.href="FlowManagerServlet?type=flowdetail&flowtype=3&id=<%=project_procurement.getId()%>";
					}else{
						initdiglog2("提示信息","保存失败！");						
					}
				}
			});
		}
		function initauto() {
			$(".table1_tr2_td1 input").autocomplete({
				source: "./Autocomplete?typename=procure&type=1"
			});
			$(".table1_tr2_td2 input").autocomplete({
				source: "./Autocomplete?typename=procure&type=2"
			});
			$(".table1_tr2_td3 input").autocomplete({
				source: "./Autocomplete?typename=procure&type=3"
			});
			$(".table1_tr2_td5 input").autocomplete({
				source: "./Autocomplete?typename=procure&type=4"
			});
		}
		function setTime(time,obj){
			if(obj.id.substring(0,3)=="pre"){
				var nowdate="<%=DataUtil.getTadayStr()%>";
		    	//修改time的时间
		    	if(compareTime1(nowdate,time)){
		    		obj.value=time;
		    		checkCover(1);//input设为readonly没有监听事件了，只能加在这
		    		checkCover(3);
		    	}else{
		    		initdiglogtwo2("提示信息","预计到货时间早于当前时间，请确认输入无误？");
			   		$( "#confirm2" ).click(function() {
						$( "#twobtndialog" ).dialog( "close" );
						obj.value=time;
						checkCover(1);//input设为readonly没有监听事件了，只能加在这
			    		checkCover(3);
					});
		    	}
			}else{
				obj.value=time;
				checkCover(2);//input设为readonly没有监听事件了，只能加在这
				checkCover(3);
			}
	    }
	</script>
	</head>

	<body>
		<jsp:include page="/top.jsp">
			<jsp:param name="name" value="<%=mUser.getName()%>" />
			<jsp:param name="level" value="<%=mUser.getLevel()%>" />
			<jsp:param name="index" value="1" />
		</jsp:include>
		<div class="div_center">
			<table class="table_center">
				<tr>
					<jsp:include page="/flowmanager/flowTab.jsp">
						<jsp:param name="index" value="0" />
					</jsp:include>
					<td class="table_center_td2">
							<form
							action="FlowManagerServlet"	method="post" name="flowform" >
							<input type="hidden" name="isagree" value="0">
							<input type="hidden" name="type" value="projectproflow">
							<input type="hidden" name="project_pid" value="<%=project_pid%>">
							<input type="hidden" name="operation" value="<%=flow.getOperation()%>">
							<input type="hidden" name="isSave" value="true">
							<div class="td2_div">
								<div class="td2_div1">
								<%if(operation==17){ %>
									<div class="td2_div1_1_delete_1">
										<div>提交项目单</div>
										<div>已撤销</div>
									</div>
									<div class="td2_div1_2_delete_1">
										<div>
											<img src="images/pass.png">
										</div>
										<div></div>
										<div>
											<img src="images/error.png">
										</div>
									</div>
									<div class="td2_div1_3_delete_1">
										<div><%=map.get("time1")%></div>
										<div><%=map.get("time10")%></div>
									</div>
<%--								<%}else if (!"1".equals(task.getIs_new_data()) && operation!=1 && operation!=18) { %>--%>
									<%}else if (false) { %>		<%--直接按照新的流程显示--%>
									<div class="<%=map.get("td2_div1_1")%>">
										<div class="<%=map.get("class11")%>">
											采购预算表
										</div>
										<div class="<%=map.get("class12")%>">
											部门审核
										</div>
										 <%--<div class="<%=map.get("class13")%>">
											销售经理确认
										</div>--%>
										<div class="<%=map.get("class14")%>">
											总经理批准
										</div>
										<div class="<%=map.get("class15")%>">
											项目采购单
										</div>
										<div class="<%=map.get("class16")%>">
											采购单审核
										</div>
										<div class="<%=map.get("class17")%>">
											采购
										</div>
										<div class="<%=map.get("class19")%>">
											验货
										</div>
										<div class="<%=map.get("class110")%>">
											入库
										</div>
									</div>
									<div class="<%=map.get("td2_div1_2")%>">
										<img src="images/<%=map.get("img1")%>" >
										<div class="<%=map.get("class21")%>"></div>
										
										<img src="images/<%=map.get("img2")%>" >
										<div class="<%=map.get("class22")%>"></div>

										 <%--<img src="images/<%=map.get("img3")%>" >
                                        <div class="<%=map.get("class23")%>"></div>--%>

										<img src="images/<%=map.get("img4")%>" >
										<div class="<%=map.get("class24")%>"></div>

										<img src="images/<%=map.get("img5")%>" >
										<div class="<%=map.get("class25")%>"></div>

										<img src="images/<%=map.get("img6")%>" >
										<div class="<%=map.get("class26")%>"></div>

										<img src="images/<%=map.get("img7")%>" >
										<div class="<%=map.get("class275")%>"></div>
										<div class="<%=map.get("class276")%>"></div>

										<img src="images/<%=map.get("img9")%>" >
										<div class="<%=map.get("class29")%>"></div>
										<img src="images/<%=map.get("img10")%>" >
									</div>
									<div class="<%=map.get("td2_div1_3")%>">
										<div><%=map.get("time1")%></div>
										<div><%=map.get("time2")%></div>
										<%--新加--%>
										 <%--<div><%=map.get("time3")%></div>--%>
										<div><%=map.get("time4")%></div>
										<div><%=map.get("time5")%></div>
										<div><%=map.get("time6")%></div>
										<div><%=map.get("time7")%></div>
										<div><%=map.get("time9")%></div>
										<div><%=map.get("time10")%></div>
									</div>
                                <% } else {%>
                                    <div class="<%=map.get("td2_div1_1")%>">
                                        <div class="<%=map.get("class11")%>">
                                            采购预算表
                                        </div>
                                        <div style="margin-left: 30px;" class="<%=map.get("class12")%>">
                                            部门审核
                                        </div>
                                        <div style="margin-left: 25px;" class="<%=map.get("class13")%>">
                                           销售经理确认
                                       </div>
                                        <div style="margin-left: 15px;" class="<%=map.get("class14")%>">
                                            总经理批准
                                        </div>
                                        <div style="margin-left: 20px;" class="<%=map.get("class15")%>">
                                            项目采购单
                                        </div>
                                        <div style="margin-left: 35px;" class="<%=map.get("class16")%>">
                                            采购单审核
                                        </div>
                                        <div style="margin-left: 40px;" class="<%=map.get("class17")%>">
                                            采购
                                        </div>
                                        <div style="margin-left: 65px;" class="<%=map.get("class19")%>">
                                            验货
                                        </div>
                                        <div style="margin-left: 65px;" class="<%=map.get("class110")%>">
                                            入库
                                        </div>
                                    </div>
                                    <div class="<%=map.get("td2_div1_2")%>">
                                        <img src="images/<%=map.get("img1")%>" >
                                        <div style="width: 8%;" class="<%=map.get("class21")%>"></div>

                                        <img src="images/<%=map.get("img2")%>" >
                                        <div style="width: 8%;" class="<%=map.get("class22")%>"></div>

                                        <img src="images/<%=map.get("img3")%>" >
                                       <div style="width: 8%;" class="<%=map.get("class23")%>"></div>

                                        <img src="images/<%=map.get("img4")%>" >
                                        <div style="width: 8%;" class="<%=map.get("class24")%>"></div>

                                        <img src="images/<%=map.get("img5")%>" >
                                        <div style="width: 8%;" class="<%=map.get("class25")%>"></div>

                                        <img src="images/<%=map.get("img6")%>" >
                                        <div style="width: 8%;" class="<%=map.get("class26")%>"></div>

                                        <img src="images/<%=map.get("img7")%>" >
                                        <div style="width: 8%;" class="<%=map.get("class275")%>"></div>

                                        <img src="images/<%=map.get("img9")%>" >
                                        <div style="width: 8%;" class="<%=map.get("class29")%>"></div>
                                        <img src="images/<%=map.get("img10")%>" >
                                    </div>
                                    <div class="<%=map.get("td2_div1_3")%>">
                                        <div><%=map.get("time1")%></div>
										<%if ("1970-01-01<br/>08:00:00".equals(map.get("time2"))) {%>
											<div style="margin-left: 35px;"><%=map.get("time3")%></div>
										<%} else {%>
											<div style="margin-left: 35px;"><%=map.get("time2")%></div>
										<%}%>
                                        <%--新加--%>
                                        <div style="margin-left: 30px;"><%=map.get("time3")%></div>
                                        <div style="margin-left: 40px;"><%=map.get("time4")%></div>
                                        <div style="margin-left: 35px;"><%=map.get("time5")%></div>
                                        <div style="margin-left: 35px;"><%=map.get("time6")%></div>
                                        <div style="margin-left: 35px;"><%=map.get("time7")%></div>
                                        <div style="margin-left: 35px;"><%=map.get("time9")%></div>
                                        <div style="margin-right: 60px;"><%=map.get("time10")%></div>
                                    </div>
								<%}%>
								</div>
								<div class="td2_div2">
									<div class="td2_div0">
										项目采购单
									</div>
									<div class="td2_div3">
										<div class="td2_div3_1">
											项目名称：<%=task.getProject_name()%>
										</div>
										<div class="td2_div3_2">
											项目编号：<%=task.getProject_id()%>
										</div>
										<div class="td2_div3_3">
											<a href="<%=isWatcher?"FlowManagerServlet?type=flowdetail&flowtype=1&id="+task.getId():"javascript:void(0)"%>" <%=isWatcher?"target='_bank'":"onclick='canNotSee();this.blur()'" %>>查看任务单</a>
										</div>
										<div class="td2_div3_2">
											预算表提交人：<%=budgetSubmiter %>
										</div>
									</div>
									<table class="td2_table0">
										<tr class="table0_tr1">
											<td class="table0_tr1_td1">
												项目采购预算表
											</td>
											<td class="table0_tr1_td2">
												<%
													for (File_path file_path : flieList1) {
												%>
												<div>
													<a href="javascript:void()"
														onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%></a>
												</div>
												<%
													}
												%>
											</td>
										</tr>
									</table>
									<%
										if (project_procurement.getProject_pid()==0&&reasonLen>0) {
									%>
									<table class="td2_table_hide">
										<tr>
											<td><span>显示预算审批</span><img src="images/hide_check.png"></td>
										</tr>
									</table>
									<table class="td2_table8">
										<%
											for (Flow reasonFlow : reasonList) {
													int reasonOpera = reasonFlow.getOperation();
													if (reasonOpera < 4 || reasonOpera > 11) {
										%>
										<tr>
											<td class="td2_table8_left">
												<%=reasonFlow.getReason().replaceAll("\r\n",
										"<br/>")%>
											</td>
											<td class="td2_table8_right">
											<%if(reasonOpera==0||reasonOpera==17){ %>
												<div class="td2_div5_bottom_noimg">
												<%}else if(reasonOpera==2||reasonOpera==5||reasonOpera==12||reasonOpera==14||reasonOpera==18) {%>
												<div class="td2_div5_bottom_agree">
												<%}else {%>
												<div class="td2_div5_bottom_disagree">
												<%}%>
													<div style="height: 15px;"></div>
													<div class="td2_div5_bottom_right1"><%=reasonFlow.getUsername()%></div>
													<div class="td2_div5_bottom_right2"><%=reasonFlow.getCreate_date()%></div>
												</div>
											</td>
										</tr>
										<%
											}
												}
										%>
									</table>
									<%
										}
									%>
									<%
										if ((operation>3&&operation<12)||((operation==14||operation==16)&&product_submiter)) {
									%>
									<div class="td2_div4">
											<%=operation<7||operation==14||operation==16||operation==11?"项目采购需求单":"项目采购进度表" %>
									</div>
									<div class="div_excel">
										<img src="images/exportExcel.png" onclick="<%=operation == 14||operation==16?"exportExcel()":"exportExcel2()"%>" title="导出">
										<%if (operation == 14||operation==16) {%>
											<img src="images/importExcel.png" onclick="$('#exportExcel_div .jFiler-input').click();" title="导入">
										<%} %>
									</div>
									<%if (operation == 14||operation == 16) {%>
									
									<input type="hidden" name="product_value">
									
									<table class="td2_table1" id="td2_table1">
										<tr class="table1_tr1">
											<td class="table1_tr1_td1">
												产品名称
											</td>
											<td class="table1_tr1_td2">
												品牌/制造商
											</td>
											<td class="table1_tr1_td3">
												规格/型号
											</td>
											<td class="table1_tr1_td7">
												物料编码
											</td>
											<td class="table1_tr1_td4">
												数量
											</td>
											<td class="table1_tr1_td5">
												单位
											</td>
											<td class="table1_tr1_td6">
												操作
											</td>
										</tr>
										<%
											if (procurementList!=null && procurementList.size()!=0){

												for (int i=0; i<procurementList.size(); i++) {
													Procurement procurement = procurementList.get(i);%>
													<tr class="table1_tr2" id="table1_tr<%=i+1%>">
														<td class="table1_tr2_td1">
															<input type="text" id="name<%=i+1%>" maxlength="50" value="<%=procurement.getName()%>">
														</td>
														<td class="table1_tr2_td2">
															<input type="text" id="agent<%=i+1%>" maxlength="50" value="<%=procurement.getAgent()%>">
														</td>
														<td class="table1_tr2_td3">
															<input type="text" id="model<%=i+1%>" maxlength="50" value="<%=procurement.getModel()%>">
														</td>
														<td class="table1_tr2_td7">
															<input type="text" id="materials_code<%=i+1%>" maxlength="50" value="<%=procurement.getMaterials_code()%>">
														</td>
														<td class="table1_tr2_td4">
															<input type="text" id="num<%=i+1%>" maxlength="9"
																   onkeyup="restr(this)" onafterpaste="restr(this)" value="<%=procurement.getNum()%>">
														</td>
														<td class="table1_tr2_td5">
															<input type="text" id="unit<%=i+1%>" maxlength="10" value="<%=procurement.getUnit()%>">
														</td>
														<td class="table1_tr2_td6">
															<img src="images/delete.png" title="删除" onclick="del(<%=i+1%>);">
														</td>
													</tr>
										<%		}
											}%>
										<tr class="table1_tr2" id="table1_tr0">
											<td class="table1_tr2_td1">
												<input type="text" id="name0" maxlength="50">
											</td>
											<td class="table1_tr2_td2">
												<input type="text" id="agent0" maxlength="50">
											</td>
											<td class="table1_tr2_td3">
												<input type="text" id="model0" maxlength="50">
											</td>
											<td class="table1_tr2_td7">
												<input type="text" id="materials_code0" maxlength="50">
											</td>
											<td class="table1_tr2_td4">
												<input type="text" id="num0" maxlength="9"
													onkeyup="restr(this)" onafterpaste="restr(this)">
											</td>
											<td class="table1_tr2_td5">
												<input type="text" id="unit0" maxlength="10">
											</td>
											<td class="table1_tr2_td6">
												<img src="images/delete.png" title="删除" onclick="del(0);"><img src="images/add_linkman.png" title="添加" onclick="add();">
											</td>
										</tr>
									</table>
									
									<table class="td2_table0">
										<tr class="table0_tr1">
											<td class="table0_tr1_td1">附件</td>
											<td class="table0_tr1_td2" style="padding:10px;" colspan="3">
												<%
													for (File_path file_path : flieList) {
												%>
												<div>
													<a href="javascript:void()"
													   onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%></a>
												</div>
												<%
													}
												%>
												<div id="section4" class="section-white5">
													<input type="file" name="file_budget" id="file_input4"
													multiple="multiple">
												</div>
											</td>
										</tr>
									</table>
									
									<%
										}else{
									%>
									<div class="td2_div7">
										<div class="td2_div71">
											提交人：<%=productSubmiter%>
										</div>
										<div class="td2_div72">
											采购：<%=project_procurement.getReceive_name()%>
										</div>
										<div class="td2_div73">
											验货：<%=project_procurement.getCheck_name()%>
										</div>
										<div class="td2_div74">
											入库：<%=project_procurement.getPutin_name()%>
										</div>
									</div>
									<table class="td2_table4" id="td2_table4">
										<tr class="table4_tr1">
											<td class="table4_tr1_td1">
												序号
											</td>
											<td class="table4_tr1_td2">
												产品名称
											</td>
											<td class="table4_tr1_td3">
												品牌/制造商
											</td>
											<td class="table4_tr1_td4">
												规格/型号
											</td>
											<td class="table4_tr1_td10">
												物料编码
											</td>
											<td class="table4_tr1_td5">
												数量
											</td>
											<td class="table4_tr1_td6">
												单位
											</td>
											<%if(operation>6){ %>
											<td class="table4_tr1_td8">
												预计到货
											</td>
											<td class="table4_tr1_td9">
												实际到货
											</td>
											<td class="table4_tr1_td7">
												合格率%
											</td>
											<%} %>
										</tr>
										<%
													for (int i=0;i<procurementList.size();i++) {Procurement procurement =procurementList.get(i);
										%>
											<tr class="table4_tr2" id="table4_tr0">
												<td class="table4_tr2_td1">
													<%=i+1%>
												</td>
												<td class="table4_tr2_td2 tooltip_div" id="name<%=i%>">
													<%=procurement.getName()%>
												</td>
												<td class="table4_tr2_td3 tooltip_div" id="agent<%=i%>">
													<%=procurement.getAgent()%>
												</td>
												<td class="table4_tr2_td4 tooltip_div" id="model<%=i%>">
													<%=procurement.getModel()%>
												</td>
												<td class="table4_tr2_td10 tooltip_div" id="materials_code<%=i%>">
													<%=procurement.getMaterials_code()==null?"":procurement.getMaterials_code()%>
												</td>
												<td class="table4_tr2_td5 tooltip_div" id="num<%=i%>">
													<%=procurement.getNum()%>
												</td>
												<td class="table4_tr2_td6 tooltip_div" id="unit<%=i%>">
													<%=procurement.getUnit()%>
												</td>
												<%if(operation>6){ %>
												<td class="table4_tr2_td8" <%=operation==7&&isBuyer?"style='padding:0px;width:70px'":"id='pre"+i+"'"%>>
												<%if(operation==7&&isBuyer){flag_pro=true; %>
													<input type="text" id="pre<%=i %>" name="pre<%=i %>" value="<%=procurement.getPredict_date()%>" placeholder="输入时间..." onClick="return Calendar('pre<%=i %>');" readonly="readonly"/>
													<%}else{ %>
													<%=procurement.getPredict_date()%>
													<%} %>
												</td>
												<td class="table4_tr2_td9"" <%=operation>6&&operation<10&&isChecker&&procurement.getPredict_date().length()>1?"style='padding:0px;width:70px'":"id='aog"+i+"'"%>>
												<%if(operation>6&&operation<10&&isChecker&&procurement.getPredict_date().length()>1){ flag_pro=true;%>
													<input type="text" id="aog<%=i %>" name="aog<%=i %>"  value="<%=procurement.getAog_date()%>" placeholder="输入时间..."  onClick="return Calendar('aog<%=i %>');" readonly="readonly"/>
													<%}else{ %>
													<%=procurement.getAog_date()%>
													<%} %>
												</td>
												<td class="table4_tr2_td7"" <%=operation>6&&operation<10&&isChecker&&procurement.getPredict_date().length()>1?"style='padding:0px;width:70px'":"id='pass"+i+"'"%>>
												<%if(operation>6&&operation<10&&isChecker&&procurement.getPredict_date().length()>1){ flag_pro=true;%>
													<input type="text" id="pass<%=i %>" name="pass<%=i %>"  value="<%=procurement.getPercent()%>"  placeholder="0-100"  oninput="value=checkDecimal(value);checkCover(2)" maxlength="6">
													<%}else{ %>
													<%=procurement.getPercent()%>
													<%} %>
												</td>
											</tr>
											<%} %>
										<%}%>
									</table>
									<table class="td2_table0">
										<tr class="table0_tr1">
											<td class="table0_tr1_td1">
												附件
											</td>
											<td class="table0_tr1_td2">
												<%
													for (File_path file_path : flieList) {
												%>
												<div>
													<a href="javascript:void()"
														onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%></a>
												</div>
												<%
													}
												%>
											</td>
										</tr>
									</table>
									<%}}%>
									<%
										if (operation > 3 && operation < 12) {
									%>
									<table class="td2_table3">
										<%
											for (Flow reasonFlow : reasonList) {
													int reasonOpera = reasonFlow.getOperation();
													if (reasonOpera >= 4 && reasonOpera < 12) {
										%>
										<tr>
											<td class="td2_table3_left">
												<%=reasonFlow.getReason().replaceAll("\r\n",
										"<br/>")%>
											</td>
											<td class="td2_table3_right">
												<div
													class="<%=reasonFlow.getOperation() == 2 ||reasonFlow.getOperation() == 4
										|| reasonFlow.getOperation() == 5 ? "td2_div5_bottom_agree"
										: "td2_div5_bottom_disagree"%> ">
													<div style="height: 15px;"></div>
													<div class="td2_div5_bottom_right1"><%=reasonFlow.getUsername()%></div>
													<div class="td2_div5_bottom_right2"><%=reasonFlow.getCreate_date()%></div>
												</div>
											</td>
										</tr>
										<%
											}
												}
										%>
									</table>
									<%
										}
									%>
								</div>
								<%
									if (flowManager.checkProjectPurchaseCanDo(task, mUser, operation)||canDel) {
								%>
								<textarea name="reason" class="div_testarea"
									placeholder="请输入意见或建议" required="required" maxlength="500"></textarea>
								<%
									}
								%>
								<div class="div_btn">
								<%if(canDel){ %>
								<img src="images/delete_travel.png" class="btn_agree" onclick="deleteProject();">
								<%} %>
									<%
									if(( ((operation < 4) || (operation ==12||operation==13||operation==15||operation==16||operation==19))&& budget_submiter)
											||((operation==4||operation==6)&&product_submiter)) {
									%>
                                    <%--修改--%>
									<img src="images/alter_flow.png" class="fistbutton" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=15&id=<%=project_procurement.getId()%>'">
									<%
										}
									%>
									<%
										if ((operation == 14||operation == 16)
												&&product_submiter) {
									%>
									<img src="images/submit_flow.png" class="btn_agree"
										onclick="addProcurement(true);">
									<%
										}
									%>
									<%--暂存按钮--%>
									<%
										if ((operation == 14||operation == 16)
												&&product_submiter) {
									%>
										<img src="images/save.png" class="btn_agree" id="save_procurement4"
										onclick="addProcurement(false);">
									<%
										}
									%>
									<%
										if (operation == 5
												&& isBuyer) {
									%>
                                    <%--确认采购--%>
                                        <img src="images/confirm.png" class="btn_agree"
										onclick="document.flowform.submit();">
									<%
										}
									%>
									<%
										if (operation==7&&isBuyer) {
									%>
									<%--完成采购--%>
									<img src="images/procurement_finished.png" class="fistbutton" id="procurement_finished" onclick="if($(this).css('cursor')=='pointer')updateProcurement(1);">
									<%
										}
									%>
									<%
										if (operation==8&&isChecker) {
									%>
									<%--完成验货--%>
									<img src="images/check_finished.png" class="fistbutton" id="check_finished" onclick="if($(this).css('cursor')=='pointer')updateProcurement(2);">
									<%
										}
									%>
									<%
										if (flag_pro) {
									%>
									<img src="images/save.png" class="btn_agree" id="save_procurement" onclick="if($(this).css('cursor')=='pointer')updateProcurement(0);">
									<%
										}
									%>
									<%
										if (operation == 10
												&& isPuter) {
									%>
                                    <%--确认入库--%>
									<img src="images/putin.png" class="btn_agree"
										onclick="document.flowform.submit();">
									<%
										}
									%>
									<%
										if (flowManager.checkProjectPurchaseCanDo(task, mUser, operation)) {
									%>
                                    <%--同意--%>
									<img src="images/agree_flow.png" class="btn_agree"
										onclick="verifyFlow(0);">
									<%
										if (operation == 1 || operation == 2 || operation == 12
													|| operation == 14 || operation == 4 || operation == 18) {
									%>
                                    <%--不同意--%>
									<img src="images/disagree_flow.png" class="btn_disagree"
										onclick="verifyFlow(1);">
									<%
										}
										}
									%>
								</div>
							</div>
						</form>
					</td>
				</tr>
			</table>

		</div>
	</body>
</html>
