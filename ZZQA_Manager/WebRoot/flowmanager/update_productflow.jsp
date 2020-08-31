<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.service.interfaces.file_path.File_pathManager"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page
	import="com.zzqa.service.interfaces.product_procurement.Product_procurementManager"%>
<%@page import="com.zzqa.pojo.product_procurement.Product_procurement"%>
<%@page
	import="com.zzqa.service.interfaces.procurement.ProcurementManager"%>
<%@page import="com.zzqa.pojo.procurement.Procurement"%>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.pojo.file_path.File_path"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%request.setCharacterEncoding("UTF-8");
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
	FlowManager flowManager = (FlowManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("flowManager");
	File_pathManager file_pathManager = (File_pathManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("file_pathManager");
	Position_userManager position_userManager=(Position_userManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("position_userManager");
	Product_procurementManager product_procurementManager = (Product_procurementManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("product_procurementManager");
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
	if (session.getAttribute("product_pid") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int product_pid =(Integer)session.getAttribute("product_pid");
	Product_procurement product_procurement = product_procurementManager
			.getProduct_procurementByID(product_pid);
	Flow flow = flowManager.getNewFlowByFID(2, product_pid);
	if(flow==null||product_procurement==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int operation=flow.getOperation();
	List<Procurement> procurementList = procurementManager
			.getProcurementListLimit(1, product_pid);
	List<File_path> flieList = file_pathManager.getAllFileByCondition(
			2, product_pid, 3, 0);
	pageContext.setAttribute("flieList", flieList);
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>修改生产采购流程</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css"
			href="css/update_productflow.css">
		<link rel="stylesheet" type="text/css" href="css/custom.css">
		<link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-filer.css">
		<link rel="stylesheet" type="text/css" href="css/default.css">
		<link rel="stylesheet" type="text/css"
			href="css/jquery.filer-dragdropbox-theme.css">
		<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/prettify.js"></script>
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/jquery.filer.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		<script type="text/javascript" src="js/refresh_scroll.js"></script>
		<!-- 现将隐藏的文件上传控件添加到body中，再渲染 -->
		<script type="text/javascript" src="js/custom.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
		function initauto() {
			$(".table1_tr2_td1 input").autocomplete({
				source : "./Autocomplete?typename=procure&type=1"
			});
			$(".table1_tr2_td2 input").autocomplete({
				source : "./Autocomplete?typename=procure&type=2"
			});
			$(".table1_tr2_td3 input").autocomplete({
				source : "./Autocomplete?typename=procure&type=3"
			});
			$(".table1_tr2_td5 input").autocomplete({
				source : "./Autocomplete?typename=procure&type=4"
			});
		}
		$(function() {
			initauto();
		});
		var procurement_num=<%=procurementList.size()%>;
	   	function addFlow(){
	   		var k=1;
	   		var product_value="";
	   		for(var i=1;i<procurement_num+1;i++){
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
							initdiglog2("提示信息","第 "+k+" 行【数量】输入有误！");
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
			if(name!=null&&name.length>0&&agent!=null&&agent.length>0&&model!=null&&model.length>0
					&&materials_code!=null&&materials_code.length>0&&num!=null&&unit!=null&&unit.length>0){
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
				initdiglog2("提示信息","第 "+k+"行信息不正确！");
				return;
			}
	   		document.flowform.product_value.value=product_value;
	   		document.flowform.product_name.value = document.getElementById("product_name1").value;
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
					+ '<td class="table1_tr2_td4"><input type="text" id="num'+ procurement_num+ '" value="'+ num+ '" maxlength="9"'+ 'onkeyup="restr(this)" onafterpaste="restr(this)"></td>'
					+ '<td class="table1_tr2_td5"><input type="text" id="unit'+procurement_num+'" value="'+unit+'" maxlength="10"></td>'
					+ '<td class="table1_tr2_td6"><img src="images/delete.png" title="删除" onclick="del('
					+ procurement_num
					+ ')"></td></tr>';
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
							&& model.length > 0 && materials_code != null
							&& materials_code.length > 0 && num != null && unit != null
							&& unit.length > 0) {
						if (!validate(num)) {
							initdiglog2("提示信息", "第 " + k + "行【数量】输入有误！");
							return;
						}
						if (excel_data == "") {
							excel_data = name + "の" + agent + "の" + model + "の"+ materials_code + "の"
									+ num + "の" + unit;
						} else {
							excel_data += "い" + name + "の" + agent + "の" + model+ "の" + materials_code
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
			if (name != null && name.length > 0 && agent != null
					&& agent.length > 0 && model != null && model.length > 0 && materials_code != null && materials_code.length > 0
					&& num != null && unit != null && unit.length > 0) {
				if (!validate(num)) {
					initdiglog2("提示信息", "第 " + k + "行【数量】输入有误！");
					return;
				}
				if (excel_data.length < 1) {
					excel_data = name + "の" + agent + "の" + model + "の" + materials_code+ "の" + num
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
			excelDown(excel_data,2);
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
			if (name0.length > 0 || agent0.length > 0 || model0.length > 0||num0.length>0|| unit0.length > 0) {
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
					temp += '<tr class="table1_tr2" id="table1_tr0">'
						+ '<td class="table1_tr2_td1"><input type="text" id="name0" value="'+name+'" maxlength="50"></td>'
						+ '<td class="table1_tr2_td2"><input type="text" id="agent0" value="'+agent+'" maxlength="50"></td>'
						+ '<td class="table1_tr2_td3"><input type="text" id="model0" value="'+model+'" maxlength="50"></td>'
						+ '<td class="table1_tr2_td7"><input type="text" id="materials_code0" value="'+materials_code+'" maxlength="50"></td>'
						+ '<td class="table1_tr2_td4"><input type="text" id="num0" value="'+ num+ '" maxlength="9"'+ 'onkeyup="restr(this)" onafterpaste="restr(this)"></td>'
						+ '<td class="table1_tr2_td5"><input type="text" id="unit0" value="'+unit+'" maxlength="9"></td>'
						+ '<td class="table1_tr2_td6"><img src="images/delete.png" title="删除" onclick="del(0)"><img src="images/add_linkman.png" title="添加" onclick="add();"></td></tr>';
				}else{
					temp += '<tr class="table1_tr2" id="table1_tr'+procurement_num+'">'
						+ '<td class="table1_tr2_td1"><input type="text" id="name'+procurement_num+'" value="'+name+'" maxlength="50"></td>'
						+ '<td class="table1_tr2_td2"><input type="text" id="agent'+procurement_num+'" value="'+agent+'" maxlength="50"></td>'
						+ '<td class="table1_tr2_td3"><input type="text" id="model'+procurement_num+'" value="'+model+'" maxlength="50"></td>'
						+ '<td class="table1_tr2_td7"><input type="text" id="materials_code'+procurement_num+'" value="'+materials_code+'" maxlength="50"></td>'
						+ '<td class="table1_tr2_td4"><input type="text" id="num'+ procurement_num+ '" value="'+ num+ '" maxlength="9"'+ 'onkeyup="restr(this)" onafterpaste="restr(this)"></td>'
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
	   	function validate(sDouble){
  			var re = /^\d+(?=\.{0,1}\d+$|$)/
 		 	return re.test(sDouble)&&sDouble>0
		}
		function restr(name){
	   		name.value=name.value.replace(/\D/g,"");
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
					<td class="table_center_td2">
						<form action="FlowManagerServlet?type=updateproductproflow&product_pid=<%=product_procurement.getId() %>&uid=<%=mUser.getId()%>&operation=<%=flow.getOperation() %>"
							method="post" name="flowform">
							<input type="hidden" name="product_value">
							<input type="hidden" name="product_name">
							<div class="td2_div">
								<div class="td2_div1">
									生产采购需求单
								</div>
								<div class="div_excel">
									<img src="images/exportExcel.png" onclick="exportExcel()" title="导出"><img src="images/importExcel.png" onclick="$('#exportExcel_div .jFiler-input').click();" title="导入">
								</div>
								<table class="td2_table2">
									<tr class="table2_tr1">
										<td class="table2_tr1_td1">生产单名称：</td>
										<td class="table2_tr1_td2" style="padding:10px;"colspan="3">
											<input type="text" name="product_name1" id="product_name1" value="<%=product_procurement.getProduct_name() %>" style="height:20px;width:300px">
										</td>
									</tr>
								</table>
								<table class="td2_table1" id="td2_table1">
									<tr class="table1_tr1">
										<td class="table1_tr1_td1">
											产品名称
										</td>
										<td class="table1_tr1_td2">
											品牌/代理商
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
									<% int plen=procurementList.size();for(int i=0;i<plen;i++){
										Procurement p=procurementList.get(i);
									%>
									<tr class="table1_tr2" id="table1_tr<%=i==plen-1?0:(i+1)%>">
										<td class="table1_tr2_td1">
											<input type="text" id="name<%=i==plen-1?0:(i+1)%>" maxlength="50" value="<%=p.getName() %>">
										</td>
										<td class="table1_tr2_td2">
											<input type="text" id="agent<%=i==plen-1?0:(i+1)%>" maxlength="50" value="<%=p.getAgent() %>">
										</td>
										<td class="table1_tr2_td3">
											<input type="text" id="model<%=i==plen-1?0:(i+1)%>" maxlength="50" value="<%=p.getModel() %>">
										</td>
										<td class="table1_tr2_td7">
											<input type="text" id="materials_code<%=i==plen-1?0:(i+1)%>" maxlength="50" value="<%=p.getMaterials_code()==null?"":p.getMaterials_code() %>">
										</td>
										<td class="table1_tr2_td4">
											<input type="text" id="num<%=i==plen-1?0:(i+1)%>" maxlength="9" value="<%=p.getNum() %>"
												onkeyup="restr(this)" onafterpaste="restr(this)">
										</td>
										<td class="table1_tr2_td5">
											<input type="text" id="unit<%=i==plen-1?0:(i+1)%>" maxlength="10" value="<%=p.getUnit() %>">
										</td>
										<td class="table1_tr2_td6">
											<%if(i==plen-1){ %>
											<img src="images/delete.png" onclick="del(0);" title="删除"><img src="images/add_linkman.png" onclick="add();" title="添加">
											<%}else { %>
											<img src="images/delete.png" onclick="del(<%=i+1 %>);" title="删除">
											<%} %>
										</td>
									</tr>
									<%} %>
								</table>
								<table class="td2_table0">
										<tr class="table0_tr1">
											<td class="table0_tr1_td1" style="display:table-cell; vertical-align:middle">
												附件
											</td>
											<td class="table0_tr1_td2" style="padding:10px;"colspan="3">
												<%
													for (File_path file_path : flieList) {
												%>
												<div id="file_div<%=file_path.getId()%>">
												<a class="img_a"
													href="javascript:void()" onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%></a>
												[<a class="img_a" href="javascript:void(0);" onclick="delFile(<%=file_path.getId()%>,'<%=file_path.getFile_name()%>',1)">删除</a>]
												</div>
												<%
													}
												%>
												<div id="section4" class="section-white5">
													<input type="file" name="file_budget" id="file_input3"
													multiple="multiple">
												</div>
											</td>
										</tr>
									</table>
								<div class="div_btn">
									<img src="images/submit_flow.png" onclick="addFlow();">
								</div>
							</div>
						</form>
					</td>
				</tr>
			</table>

		</div>
	</body>
</html>
