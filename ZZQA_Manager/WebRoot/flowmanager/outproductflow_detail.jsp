<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.service.interfaces.procurement.ProcurementManager"%>
<%@page import="com.zzqa.service.interfaces.outsource_product.Outsource_productManager"%>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.service.interfaces.file_path.File_pathManager"%>
<%@page import="com.zzqa.service.interfaces.product_procurement.Product_procurementManager"%>
<%@page import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page import="com.zzqa.pojo.file_path.File_path"%>
<%@page import="com.zzqa.pojo.product_procurement.Product_procurement"%>
<%@page import="com.zzqa.pojo.outsource_product.Outsource_product"%>
<%@page import="com.zzqa.pojo.procurement.Procurement"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	Outsource_productManager outsource_productManager = (Outsource_productManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("outsource_productManager");
	FlowManager flowManager = (FlowManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("flowManager");
	File_pathManager file_pathManager = (File_pathManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("file_pathManager");
	Product_procurementManager product_procurementManager = (Product_procurementManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("product_procurementManager");
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

	String out_pid_str = request.getParameter("out_pid");
	if (session.getAttribute("out_pid") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int out_pid = (Integer)session.getAttribute("out_pid");
	Outsource_product outsource_product = outsource_productManager
			.getOutsource_productByID(out_pid);
	Flow flow = flowManager.getNewFlowByFID(4, out_pid);
	if(outsource_product==null||flow==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int operation = flow.getOperation();
	Product_procurement product_procurement = product_procurementManager
			.getProduct_procurementByID(outsource_product
					.getProduct_pid());
	if(product_procurement==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	List<Procurement> procurementList = procurementManager
			.getProcurementListLimit(3, out_pid);
	Map<String, String> map = outsource_productManager
			.getOutPFlowForDraw(outsource_product,flow);
	List<File_path> flieList1 = file_pathManager.getAllFileByCondition(
			4, out_pid, 1, 0);
	List<File_path> flieList2 = file_pathManager.getAllFileByCondition(
			4, out_pid, 2, 0);
	List<File_path> flieList3 = file_pathManager.getAllFileByCondition(
			4, out_pid, 3, 0);
	List<Flow> reasonList = flowManager.getReasonList(4, out_pid);
	boolean isCreater=outsource_product.getCreate_id()==mUser.getId();
	boolean isWatcher="admin".equals(mUser.getName())||product_procurement.getCreate_id()==mUser.getId()||permissionsManager.checkPermission(mUser.getPosition_id(), 19);
	boolean isBuyer=permissionsManager.checkPermission(mUser.getPosition_id(), 21);
	boolean isChecker=permissionsManager.checkPermission(mUser.getPosition_id(), 22);
	boolean isPuter=permissionsManager.checkPermission(mUser.getPosition_id(), 23);
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<title>外协生产流程</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css"
			href="css/outproduct_flow_detail.css">
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
		var procurement_num=1;
		function submitPass(){
			var k=1;
	   		var product_value="";
	   		for(var i=1;i<procurement_num+1;i++){
	   			if(document.getElementById("table1_tr"+i)){
	   			    var name=document.getElementById("name"+i).value;
			   		var agent=document.getElementById("agent"+i).value;
			   		var model=document.getElementById("model"+i).value;
			   		var num=document.getElementById("num"+i).value;
			   		var unit=document.getElementById("unit"+i).value;
			   		var pass=document.getElementById("pass"+i).value;
					if(name!=null&&name.length>0&&agent!=null&&agent.length>0&&model!=null&&model.length>0&&
					unit!=null&&unit.length>0){
						if(!validate(num)){
							initdiglog2("提示信息","第 "+k+" 行，【数量】输入有误！");
							return;
						}else if(!validate_pass(pass)){
							initdiglog2("提示信息","第 "+k+" 行，【合格率】输入有误！");
							return;
						}
						if(k==1){
							product_value=name+"の"+agent+"の"+model+"の"+num+"の"+unit+"の"+pass;
						}else{
							product_value+="い"+name+"の"+agent+"の"+model+"の"+num+"の"+unit+"の"+pass;
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
	   		var num=document.getElementById("num0").value;
	   		var unit=document.getElementById("unit0").value;
	   		var pass=document.getElementById("pass0").value;
			if(name!=null&&name.length>0&&agent!=null&&agent.length>0&&model!=null&&model.length>0&&
			unit!=null&&unit.length>0){
				if(!validate(num)){
					initdiglog2("提示信息","第 "+k+" 行，【数量】输入有误！");
					return;
				}else if(!validate_pass(pass)){
					initdiglog2("提示信息","第 "+k+" 行，【合格率】输入有误！");
					return;
				}
				if(product_value.length<1){
					product_value=name+"の"+agent+"の"+model+"の"+num+"の"+unit+"の"+pass;
				}else{
					product_value+="い"+name+"の"+agent+"の"+model+"の"+num+"の"+unit+"の"+pass;
				}
			}else{
				initdiglog2("提示信息","第 "+k+" 行信息不正确！");
				return;
			}
	   		document.flowform.product_value.value=product_value;
	   		document.flowform.submit();
		}
		function validate_pass(sDouble){
			//检验是否为正数
  			var re = /^\d+(?=\.{0,1}\d+$|$)/;
 		 	return re.test(sDouble)&&(!(sDouble>100));
		}
 		function validate(sDouble){
			//检验是否为正数
  			var re = /^\+?[1-9][0-9]*$/;
 		 	return re.test(sDouble)&&sDouble>0;
		}
 		function addTitle(){
 			resetRefresh();//重置刷新
 			procurement_num++;
	   		var temp='<tr class="table1_tr1"><td class="table1_tr1_td1">产品名称</td><td class="table1_tr1_td2">品牌/制造商</td>'+
		    		'<td class="table1_tr1_td3">规格/型号</td><td class="table1_tr1_td4">数量</td>'+
					'<td class="table1_tr1_td5">单位</td><td class="table1_tr1_td6">合格率%</td>'+
					'<td class="table1_tr1_td7">操作</td></tr>';
	   		for(var i=1;i<procurement_num;i++){
	   			if(document.getElementById("table1_tr"+i)){
	   				var name=document.getElementById("name"+i).value;
			   		var agent=document.getElementById("agent"+i).value;
			   		var model=document.getElementById("model"+i).value;
			   		var num=document.getElementById("num"+i).value;
			   		var unit=document.getElementById("unit"+i).value;
			   		var pass=document.getElementById("pass"+i).value;
		   			temp+='<tr class="table1_tr2" id="table1_tr'+i+'">'+
		   				'<td class="table1_tr2_td1"><input type="text" id="name'+i+'" value="'+name+'" maxlength="50"></td>'+
						'<td class="table1_tr2_td2"><input type="text" id="agent'+i+'" value="'+agent+'" maxlength="50"></td>'+
					    '<td class="table1_tr2_td3"><input type="text" id="model'+i+'" value="'+model+'" maxlength="50"></td>'+
						'<td class="table1_tr2_td4"><input type="text" id="num'+i+'" value="'+num+'" maxlength="9"'+
							'onkeyup="restr(this)" onafterpaste="restr(this)"></td>'+
						'<td class="table1_tr2_td5"><input type="text" id="unit'+i+'" value="'+unit+'" maxlength="10"></td>'+
						'<td class="table1_tr2_td6"><input type="text" id="pass'+i+'" value="'+pass+'" maxlength="6"'+
						' oninput="value=checkDecimal(value)"></td>'+
						'<td class="table1_tr2_td7"><img src="images/delete.png" title="删除" onclick="del('+i+')"></td></tr>';
				}
 			}
 			return temp;
 		}
 		function addNew(){
 			var name=document.getElementById("name0").value;
	   		var agent=document.getElementById("agent0").value;
	   		var model=document.getElementById("model0").value;
	   		var num=document.getElementById("num0").value;
	   		var unit=document.getElementById("unit0").value;
	   		var pass=document.getElementById("pass0").value;
	   		var temp ='<tr class="table1_tr2" id="table1_tr'+procurement_num+'">'+
				'<td class="table1_tr2_td1"><input type="text" id="name'+procurement_num+'" value="'+name+'" maxlength="50"></td>'+
				'<td class="table1_tr2_td2"><input type="text" id="agent'+procurement_num+'" value="'+agent+'" maxlength="50"></td>'+
			    '<td class="table1_tr2_td3"><input type="text" id="model'+procurement_num+'" value="'+model+'" maxlength="50"></td>'+
				'<td class="table1_tr2_td4"><input type="text" id="num'+procurement_num+'" value="'+num+'" maxlength="9"'+
					' onkeyup="restr(this)" onafterpaste="restr(this)"></td>'+
				'<td class="table1_tr2_td5"><input type="text" id="unit'+procurement_num+'" value="'+unit+'" maxlength="10"></td>'+
				'<td class="table1_tr2_td6"><input type="text" id="pass'+procurement_num+'" value="'+pass+'" maxlength="6"'+
					' oninput="value=checkDecimal(value)"></td>'+
				'<td class="table1_tr2_td7"><img src="images/delete.png" title="删除" onclick="del('+procurement_num+')"></td></tr>';
 			return temp; 
 		}
 		function addLast() {
 			var temp='<tr class="table1_tr2" id="table1_tr0"><td class="table1_tr2_td1"><input type="text" id="name0" maxlength="50"></td>'+
				'<td class="table1_tr2_td2"><input type="text" id="agent0" maxlength="50"></td>'+
				'<td class="table1_tr2_td3"><input type="text" id="model0" maxlength="50"></td>'+
				'<td class="table1_tr2_td4"><input type="text" id="num0" onkeyup="restr(this)" onafterpaste="restr(this)" maxlength="9"></td>'+
				'<td class="table1_tr2_td5"><input type="text" id="unit0" maxlength="10"></td>'+
				'<td class="table1_tr2_td6"><input type="text" id="pass0" oninput="value=checkDecimal(value)" maxlength="6"></td>'+
				'<td class="table1_tr2_td7"><img src="images/delete.png" title="删除" onclick="del(0)"><img src="images/add_linkman.png" title="添加" onclick="add();"></td>';
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
 		<%if(operation>3){%>
 		function exportExcel() {
 			var excel_data = "";
 			<%if(operation==4){%>
 			var k=0;
 			for (var i = 1; i < procurement_num + 1; i++) {
 				if (document.getElementById("table1_tr" + i)) {
 					k++;
 					var name = $("#name"+i).val();
 		 			var agent = $("#agent"+i).val();
 		 			var model = $("#model"+i).val();
 		 			var num = $("#num"+i).val();
 		 			var unit = $("#unit"+i).val();
 		 			var pass = $("#pass"+i).val();
 					if (name != null && name.length > 0 && agent != null
 							&& agent.length > 0 && model != null
 							&& model.length > 0 && num != null && unit != null
 							&& unit.length > 0) {
 						if (!validate(num)) {
 							initdiglog2("提示信息", "第 " + k + "行【数量】输入有误！");
 							return;
 						}
 						if (!validate_pass(pass)) {
 							initdiglog2("提示信息", "第 " + k + "行【合格率】输入有误！");
 							return;
 						}
 						if (excel_data == "") {
 							excel_data = name + "の" + agent + "の" + model + "の"
 									+ num + "の" + unit+"の" + pass;
 						} else {
 							excel_data += "い" + name + "の" + agent + "の" + model
 									+ "の" + num + "の" + unit+"の" + pass;
 						}
 					} else {
 						initdiglog2("提示信息", "第 " + k + "行信息不完整！");
 						return;
 					}
 				}
 			}
 			k++;
 			var name = $("#name0").val();
 			var agent = $("#agent0").val();
 			var model = $("#model0").val();
 			var num = $("#num0").val();
 			var unit = $("#unit0").val();
 			var pass = $("#pass0").val();
 			if (name != null && name.length > 0 && agent != null
 					&& agent.length > 0 && model != null && model.length > 0
 					&& num != null && unit != null && unit.length > 0) {
 				if (!validate(num)) {
 					initdiglog2("提示信息", "第 " + k + "行【数量】输入有误！");
 					return;
 				}
 				if (!validate_pass(pass)) {
 					initdiglog2("提示信息", "第 " + k + "行【合格率】输入有误！");
 					return;
 				}
 				if (excel_data.length < 1) {
 					excel_data = name + "の" + agent + "の" + model + "の" + num
 							+ "の" + unit+"の" + pass;
 				} else {
 					excel_data += "い" + name + "の" + agent + "の" + model + "の"
 							+ num + "の" + unit+"の" + pass;
 				}
 			} else {
 				initdiglog2("提示信息", "第 " + k + "行信息不完整！");
 				return;
 			}
 			if (excel_data == "") {
 				initdiglog2("提示信息", "没有数据！");
 				return;
 			}
 			<%}else{%>
 				for(var i=0;i<<%=procurementList.size()%>;i++){
 					var name =$("#name"+i).text().replace(/[\r\n\t]/g,"");
 					var agent = $("#agent"+i).text().replace(/[\r\n\t]/g,"");
 					var model = $("#model"+i).text().replace(/[\r\n\t]/g,"");
 					var num = $("#num"+i).text().replace(/[\r\n\t]/g,"");
 					var unit = $("#unit"+i).text().replace(/[\r\n\t]/g,"");
 					var pass = $("#pass"+i).text().replace(/[\r\n\t]/g,"");
 					if (i==0) {
 	 					excel_data = name + "の" + agent + "の" + model + "の" + num
 	 							+ "の" + unit+"の" + pass;
 	 				} else {
 	 					excel_data += "い" + name + "の" + agent + "の" + model + "の"
 	 							+ num + "の" + unit+"の" + pass;
 	 				}
 				}
 			<%}%>
 			excelDown(excel_data,4);
 		}
 		<%}%>
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
 			var num0 = document.getElementById("num0").value;
 			var unit0 = document.getElementById("unit0").value;
 			var pass0 = document.getElementById("pass0").value;
 			if (name0.length > 0 || agent0.length > 0 || model0.length > 0||num0.length>0|| unit0.length > 0) {
 				temp += '<tr class="table1_tr2" id="table1_tr'+procurement_num+'">'+
					'<td class="table1_tr2_td1"><input type="text" id="name'+procurement_num+'" value="'+name0+'" maxlength="50"></td>'+
					'<td class="table1_tr2_td2"><input type="text" id="agent'+procurement_num+'" value="'+agent0+'" maxlength="50"></td>'+
				    '<td class="table1_tr2_td3"><input type="text" id="model'+procurement_num+'" value="'+model0+'" maxlength="50"></td>'+
					'<td class="table1_tr2_td4"><input type="text" id="num'+procurement_num+'" value="'+num0+'" maxlength="9"'+
						' onkeyup="restr(this)" onafterpaste="restr(this)"></td>'+
					'<td class="table1_tr2_td5"><input type="text" id="unit'+procurement_num+'" value="'+unit0+'" maxlength="10"></td>'+
					'<td class="table1_tr2_td6"><input type="text" id="pass'+procurement_num+'" value="'+pass0+'" maxlength="6"'+
						' oninput="value=checkDecimal(value)"></td>'+
					'<td class="table1_tr2_td7"><img src="images/delete.png" title="删除" onclick="del('+procurement_num+')"></td></tr>';
 				procurement_num++;
 			}
	   		for(var i=0;i<myobj.length;i++){
 				var name=myobj[i].name;
 				var agent=myobj[i].agent;
 				var model=myobj[i].model;
 				var num=myobj[i].num;
 				var unit=myobj[i].unit;
 				var pass =checkDecimal(myobj[i].percent);
 				if(i==myobj.length-1){
 					temp+='<tr class="table1_tr2" id="table1_tr0">'
 						+'<td class="table1_tr2_td1"><input type="text" id="name0"  value="'+name+'" maxlength="50"></td>'+
	 					'<td class="table1_tr2_td2"><input type="text" id="agent0" value="'+agent+'" maxlength="50"></td>'+
	 					'<td class="table1_tr2_td3"><input type="text" id="model0" value="'+model+'" maxlength="50"></td>'+
	 					'<td class="table1_tr2_td4"><input type="text" id="num0" value="'+ num+ '" onkeyup="restr(this)" onafterpaste="restr(this)" maxlength="9"></td>'+
	 					'<td class="table1_tr2_td5"><input type="text" id="unit0" value="'+unit+'" maxlength="10"></td>'+
	 					'<td class="table1_tr2_td6"><input type="text" id="pass0" value="'+pass+'" oninput="value=checkDecimal(value)" maxlength="6"></td>'+
	 					'<td class="table1_tr2_td7"><img src="images/delete.png" title="删除" onclick="del(0)"><img src="images/add_linkman.png" title="添加" onclick="add();"></td>';
 				}else{
 					temp += '<tr class="table1_tr2" id="table1_tr'+procurement_num+'">'
		 				+ '<td class="table1_tr2_td1"><input type="text" id="name'+procurement_num+'" value="'+name+'" maxlength="50"></td>'
		 				+ '<td class="table1_tr2_td2"><input type="text" id="agent'+procurement_num+'" value="'+agent+'" maxlength="50"></td>'
		 				+ '<td class="table1_tr2_td3"><input type="text" id="model'+procurement_num+'" value="'+model+'" maxlength="50"></td>'
		 				+ '<td class="table1_tr2_td4"><input type="text" id="num'+ procurement_num+ '" value="'+ num+ '" maxlength="9"'+ 'onkeyup="restr(this)" onafterpaste="restr(this)"></td>'
		 				+ '<td class="table1_tr2_td5"><input type="text" id="unit'+procurement_num+'" value="'+unit+'" maxlength="10"></td>'
		 				+'<td class="table1_tr2_td6"><input type="text" id="pass'+procurement_num+'" value="'+pass+'" maxlength="6"'+
							' oninput="value=checkDecimal(value)"></td>'
						+'<td class="table1_tr2_td7"><img src="images/delete.png" title="删除" onclick="del('+procurement_num+')"></td></tr>';
 				}
 				procurement_num++;
	   		}
 			var docTable = document.getElementById("td2_table1");
 			docTable.innerHTML = temp;
 			initauto();
 			initdiglog2("提示信息","导入成功！");
 		}
	   	function restr(name){
	   		name.value=name.value.replace(/\D/g,"");
	   	}
	   	function del(n){
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
							document.getElementById("num0").value = document.getElementById("num"+i).value;
							document.getElementById("unit0").value = document.getElementById("unit"+i).value;
							document.getElementById("pass0").value = document.getElementById("pass"+i).value;
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
		$(function(){
			initauto();
		});
		function setTime(time,obj){
			if(obj==document.getElementById("time1")){
				var nowdate="<%=DataUtil.getTadayStr()%>";
		    	//修改time的时间
		    	if(compareTime1(nowdate,time)){
		    		obj.value=time;
		    	}else{
		    		initdiglogtwo2("提示信息","预计到货时间早于当前时间，请确认输入无误？");
			   		$( "#confirm2" ).click(function() {
						$( "#twobtndialog" ).dialog( "close" );
						obj.value=time;
					});
		    	}
			}else{
				obj.value=time;
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
					<td class="table_center_td2">
						<form
							action="FlowManagerServlet?type=outproductflow&uid=<%=mUser.getId()%>&out_pid=<%=outsource_product.getId()%>&operation=<%=operation%>"
							method="post" name="flowform" enctype="multipart/form-data">
							<div class="td2_div">
								<div class="td2_div1">
									<div class="td2_div1_1">
										<div class="<%=map.get("class11")%>">
											外协生产单
										</div>
										<div class="<%=map.get("class12")%>">
											出库
										</div>
										<div class="<%=map.get("class13")%>">
											取回
										</div>
										<div class="<%=map.get("class14")%>">
											验货
										</div>
										<div class="<%=map.get("class15")%>">
											入库
										</div>
									</div>
									<div class="td2_div1_2">
										<div class="td2_div2_img">
											<img src="images/<%=map.get("img1")%>">
										</div>
										<div class="<%=map.get("class22")%>"></div>

										<div class="td2_div2_img">
											<img src="images/<%=map.get("img2")%>">
										</div>
										<div class="<%=map.get("class235")%>"></div>
										<div class="<%=map.get("class245")%>"></div>

										<div class="td2_div2_img">
											<img src="images/<%=map.get("img3")%>">
										</div>
										<div class="<%=map.get("class26")%>"></div>

										<div class="td2_div2_img">
											<img src="images/<%=map.get("img4")%>">
										</div>
										<div class="<%=map.get("class28")%>"></div>

										<div class="td2_div2_img">
											<img src="images/<%=map.get("img5")%>">
										</div>
									</div>
									<div class="td2_div1_3">
										<div class="td2_div31"><%=map.get("time1")%></div>
										<div class="td2_div32"><%=map.get("time2")%></div>
										<div class="td2_div33"><%=map.get("time3")%></div>
										<div class="td2_div34"><%=map.get("time4")%></div>
										<div class="td2_div35"><%=map.get("time5")%></div>
									</div>
								</div>
								<div class="td2_div2">
									<div class="td2_div3">
										外协生产单
									</div>
									<table class="td2_table0">
										<tr class="table0_tr1">
											<td class="table0_tr1_td1">
												关联生产采购
											</td>
											<td class="table0_tr1_td2">
												<a href="<%=isWatcher?"FlowManagerServlet?type=flowdetail&flowtype=2&id="+outsource_product.getProduct_pid():"javascript:void(0)"%>"
													<%=isWatcher?"target='_bank'":"onclick='canNotSee();this.blur();'" %>> <%=product_procurement.getName()%> </a>
											</td>
										</tr>
										<%
											if (flieList1.size() > 0) {
										%>
										<tr class="table0_tr2">
											<td class="table0_tr2_td1">
												附件
											</td>
											<td class="table0_tr2_td2">
												<%
													for (File_path file_path : flieList1) {
												%>
												<div>
													<a href="javascript:void()" onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%></a>
												</div>
												<%
													}
												%>
											</td>
										</tr>
										<%
											}
										%>
									</table>
									<%
										if (operation > 2
												|| (operation == 2 && isBuyer)) {
									%>
									<table class="td2_table2">
										<%
											if (operation > 1) {
										%>
										<tr class="table2_tr1">
											<td class="table2_tr1_td1">
												预计到货时间
											</td>
											<td class="table2_tr1_td2">
												<%
													if (operation == 2) {
												%>
												<div class="section-white3">
													<input type="text" id="time1" name="predict_time"
														onClick="return Calendar('time1');" readonly="readonly"
														value="<%=DataUtil.getTadayStr()%>">
													<span id="predict_error"></span>
												</div>
												<div id="section4" class="section-white1">
													<input type="file" name="file_predict" id="file_input2"
														multiple="multiple">
												</div>
												<%
													} else {
												%>
												<div class="div_time_left"><%=outsource_product.getPredict_date()%></div>
												<div class="div_img_right">
													<%
														for (File_path file_path : flieList2) {
													%>
													<div>
														<a href="javascript:void()" onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%></a>
													</div>
													<%
														}
													%>
												</div>
												<%
													}
												%>



											</td>
										</tr>
										<%
											}
										%>
										<%
											if (operation > 3
														|| (operation == 3 && isChecker)) {
										%>
										<tr class="table2_tr2">
											<td class="table2_tr2_td1">
												实际到货时间
											</td>
											<td class="table2_tr2_td2">
												<%
													if (operation == 3) {
												%>
												<div class="section-white3">
													<input type="text" id="time2" name="aog_time"
														onClick="return Calendar('time2');" readonly="readonly"
														value="<%=DataUtil.getTadayStr()%>">
													<span id="aog_error"></span>
												</div>
												<div id="section4" class="section-white1">
													<input type="file" name="file_aog" id="file_input3"
														multiple="multiple">
												</div>
												<%
													} else {
												%>
												<div class="div_time_left"><%=outsource_product.getAog_date()%></div>
												<div class="div_img_right">
													<%
														for (File_path file_path : flieList3) {
													%>
													<div>
														<a href="javascript:void()" onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%></a>
													</div>
													<%
														}
													%>
												</div>
												<%
													}
												%>

											</td>
										</tr>
										<%
											}
										%>
									</table>
									<%
										}
									%>
									<%
										if (operation > 4||(operation==4&&isChecker)) {
									%>
									<div class="td2_div3">
										产品合格率
									</div>
									<div class="div_excel">
									<img src="images/exportExcel.png" onclick="exportExcel()" title="导出"><%if(operation == 4){ %><img src="images/importExcel.png" onclick="$('#exportExcel_div .jFiler-input').click();" title="导入"><%} %>
								</div>
									<%
										if (operation == 4) {
									%>
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
										<td class="table1_tr1_td4">
											数量
										</td>
										<td class="table1_tr1_td5">
											单位
										</td>
										<td class="table1_tr1_td6">
											合格率%
										</td>
										<td class="table1_tr1_td7">
											操作
										</td>
									</tr>
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
										<td class="table1_tr2_td4">
											<input type="text" id="num0" 
												onkeyup="restr(this)" onafterpaste="restr(this)" maxlength="9">
										</td>
										<td class="table1_tr2_td5">
											<input type="text" id="unit0" maxlength="10">
										</td>
										<td class="table1_tr2_td6">
											<input type="text" id="pass0" oninput="value=checkDecimal(value)" maxlength="6">
										</td>
										<td class="table1_tr2_td7">
											<img src="images/delete.png" title="删除" onclick="del(0);"><img src="images/add_linkman.png" title="添加" onclick="add();">
										</td>
									</tr>
								</table>
									<%}else if(operation>4){ %>
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
											<td class="table4_tr1_td5">
												数量
											</td>
											<td class="table4_tr1_td6">
												单位
											</td>
											<td class="table4_tr1_td7">
												合格率%
											</td>
										</tr>
										<%
											int pLen = procurementList.size();
												for (int i=0;i<pLen;i++) {
											Procurement procurement=procurementList.get(i);
										%>
										
									
										<tr class="table4_tr2" id="table1_tr<%=i%>">
											<td class="table4_tr2_td1">
												<span><%=i+1%></span>
											</td>
											<td class="table4_tr2_td2" id="name<%=i%>">
												<span><%=procurement.getName()%>
											</td>
											<td class="table4_tr2_td3" id="agent<%=i%>">
												<%=procurement.getAgent()%>
											</td>
											<td class="table4_tr2_td4" id="model<%=i%>">
												<%=procurement.getModel()%>
											</td>
											<td class="table4_tr2_td5" id="num<%=i%>">
												<%=procurement.getNum()%>
											</td>
											<td class="table4_tr2_td6" id="unit<%=i%>">
												<%=procurement.getUnit()%>
											</td>
											<td class="table4_tr2_td7" id="pass<%=i%>">
												<%=procurement.getPass_percent()%>
											</td>
										</tr>
										<%
											}
										%>

									</table>
									<%
										}}
									%>
								</div>
								<div class="div_btn">
									<%
										if (operation == 1&& isPuter) {
									%><img src="images/putout.png" class="btn_agree"
										onclick="document.flowform.submit();">
									<%
										}
									%>
									<%
										if (operation == 2 && isBuyer) {
									%>

									<img src="images/submit_flow.png" class="btn_agree"
										onclick="submit();">
									<%
										}
									%>
									<%
										if (operation == 3 && isChecker) {
									%>

									<img src="images/submit_flow.png" class="btn_agree"
										onclick="submit();">
									<%
										}
									%>
									<%
										if (operation == 4&&isChecker) {
									%>

									<img src="images/submit_flow.png" class="btn_agree"
										onclick="submitPass();">
									<%
										}
									%>
									<%
										if (operation == 5
												&& isPuter) {
									%>

									<img src="images/putin.png" class="btn_agree"
										onclick="document.flowform.submit();">
									<%
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
