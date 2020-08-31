<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page import="com.zzqa.service.interfaces.task.TaskManager"%>
<%@page import="com.zzqa.pojo.task.Task"%>
<%@page import="com.zzqa.service.interfaces.linkman.LinkmanManager"%>
<%@page import="com.zzqa.pojo.linkman.Linkman"%>
<%@page import="com.zzqa.service.interfaces.file_path.File_pathManager"%>
<%@page import="com.zzqa.pojo.file_path.File_path"%>
<%@page
	import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%@page import="com.zzqa.util.FormTransform"%>
<%request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	FlowManager flowManager = (FlowManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("flowManager");
	TaskManager taskManager = (TaskManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("taskManager");
	LinkmanManager linkmanManager = (LinkmanManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("linkmanManager");
	File_pathManager file_pathManager = (File_pathManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("file_pathManager");
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
	if (session.getAttribute("task_id") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int tid = (Integer)session.getAttribute("task_id");
	String[] flowTypeArray = DataUtil.getFlowTypeArray();
	Task task = taskManager.getTaskByID(tid);
	Flow flow = flowManager.getNewFlowByFID(17, tid);
	if(flow==null||task==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int operation=flow.getOperation();
	List<Linkman> linkmanList1 = linkmanManager.getLinkmanListLimit(17,tid, 1, 0);
	List<Linkman> linkmanList2 = linkmanManager.getLinkmanListLimit(17,tid, 2, 0);
	List<Linkman> linkmanList3 = linkmanManager.getLinkmanListLimit(17,tid, 3, 0);
	List<File_path> fpathList1 = file_pathManager
			.getAllFileByCondition(17, tid, 1, 0);
	List<File_path> fpathList2 = file_pathManager
			.getAllFileByCondition(17, tid, 2, 0);
	List<File_path> fpathList3 = file_pathManager
			.getAllFileByCondition(17, tid, 3, 0);
	List<File_path> fpathList4 = file_pathManager
			.getAllFileByCondition(17, tid, 4, 0);
	List<File_path> fpathList5 = file_pathManager
			.getAllFileByCondition(17, tid, 5, 0);
	List<File_path> fpathList6 = file_pathManager
			.getAllFileByCondition(17, tid, 6, 0);
	List<File_path> fpathList7 = file_pathManager
			.getAllFileByCondition(17, tid, 7, 0);
	List<Flow> reasonList=flowManager.getReasonList(17,tid);
	String[] pCategoryArray=DataUtil.getPCategoryArray2();
	String[] productTypeArray=DataUtil.getProductTypeArray2();
	String[] pCaseArray = DataUtil.getPCaseArray();
	String[] stageArray = DataUtil.getStageArray2();
	String[] pTypeArray = DataUtil.getPTypeArray();
	pageContext.setAttribute("mUser", mUser);
	pageContext.setAttribute("operation", operation);
	pageContext.setAttribute("task", task);
	pageContext.setAttribute("pCategoryArray", pCategoryArray);
	pageContext.setAttribute("productTypeArray", productTypeArray);
	pageContext.setAttribute("pCaseArray", pCaseArray);
	pageContext.setAttribute("stageArray", stageArray);
	pageContext.setAttribute("pTypeArray", pTypeArray);
	pageContext.setAttribute("linkmanList1", linkmanList1);
	pageContext.setAttribute("linkmanList2", linkmanList2);
	pageContext.setAttribute("linkmanList3", linkmanList3);
	pageContext.setAttribute("fpathList1", fpathList1);
	pageContext.setAttribute("fpathList2", fpathList2);
	pageContext.setAttribute("fpathList3", fpathList3);
	pageContext.setAttribute("fpathList4", fpathList4);
	pageContext.setAttribute("fpathList5", fpathList5);
	pageContext.setAttribute("fpathList6", fpathList6);
	pageContext.setAttribute("fpathList7", fpathList7);
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>修改项目启动任务单流程</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css" href="css/update_taskflow.css">
		<link rel="stylesheet" type="text/css" href="css/custom.css">
		<link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
		<link rel="stylesheet" type="text/css" href="css/default.css">
		<link rel="stylesheet" type="text/css"
			href="css/jquery.filer-dragdropbox-theme.css">
		<script src="js/showdate1.js" type="text/javascript"></script>
		<script src="js/prettify.js" type="text/javascript"></script>
		<script  type="text/javascript" src="js/jquery.min.js"></script>
		<script src="js/jquery.filer.min.js" type="text/javascript"></script>
		<script src="js/custom.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
 		<script  type="text/javascript" src="js/jquery-ui.min.js"></script>
 		<script  type="text/javascript" src="js/dialog.js"></script>
 		<script  type="text/javascript" src="js/public.js"></script>
		<!--[if IE]>
			<script src="http://libs.useso.com/js/html5shiv/3.7/html5shiv.min.js"></script>
		<![endif]-->
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
		var file_num1=<%=fpathList1.size()%>;
		var file_num2=<%=fpathList2.size()%>;
		var file_num3=<%=fpathList3.size()%>;
		var file_num4=<%=fpathList4.size()%>;
		var file_num5=<%=fpathList5.size()%>;
		var file_num6=<%=fpathList6.size()%>;
		var linkman_user_num=<%=linkmanList1.size()%>;
		var linkman_bill_num=<%=linkmanList2.size()%>;
		var linkman_device_num=<%=linkmanList3.size()%>;
		var delFids="";
	   	//删除图片
	   	function delFile(id,name,type){
	   		initdiglogtwo2("提示信息","你确定要删除文件<br/>【"+name+"】吗？");
	   		$( "#confirm2" ).click(function() {
				$( "#twobtndialog" ).dialog( "close" );
				delFids+="の"+id;
				var na="#file_div"+id;
				$(na).remove();
				initdiglog2("提示信息","删除成功！");
				if(type==1){
					file_num1--;
				}else if(type==2){
					file_num2--;
				}else if(type==3){
					file_num3--;
				}else if(type==4){
					file_num4--;
				}else if(type==5){
					file_num5--;
				}else if(type==6){
					file_num6--;
				}
			});
	   	}
	   	
	   	function testPhoneNumber(phone){
 			if(phone.length>0){
   				var reg_phone=/^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
   				var reg_mobile=/^1\d{10}$/;
   				if(reg_phone.test(phone)||reg_mobile.test(phone)){
     				return true;
   				}
     			return false;
 			}else{
    			return false;
 			}
		}
	   	function alertFlow(){
	   		var k=0;
	   		if(document.flowform.project_name.value.length<1){
	   			k++;
	   			document.getElementById("pname_error").innerText="请输入项目名称";
	   		}else{
	   			document.getElementById("pname_error").innerText="";
	   		}
	   		if(document.flowform.project_id.value.length<1){
	   			k++;
	   			document.getElementById("pid_error").innerText="请输入项目编号";
	   		}else{
	   			document.getElementById("pid_error").innerText="";
	   		}
	   		if(document.flowform.customer.value.length<1){
	   			k++;
	   			document.getElementById("customer_error").innerText="请输入用户名称";
	   		}else{
	   			document.getElementById("customer_error").innerText="";
	   		}
	   		var linkman_user="";
	   		var linkman= document.getElementById("linkman_user0").value;
	   		var phone= document.getElementById("phone_user0").value;
			if(linkman!=null&&linkman.length>0&&testPhoneNumber(phone)){
				document.getElementById("linkman_user0").value=linkman;
				document.getElementById("phone_user0").value=phone;
				document.getElementById("linkman_user_span0").innerText="";
				if(linkman_user.length==0){
					linkman_user=linkman+"の"+phone;
				}else{
					linkman_user+="い"+linkman+"の"+phone;
				}
			}else{
				k++;
				if(linkman.length<1&&phone.length<1){
					document.getElementById("linkman_user_span0").innerText="请输入姓名和电话";
				}else if(linkman.length<1){
					document.getElementById("linkman_user_span0").innerText="请输入姓名";
				}else if(phone.length<1){
					document.getElementById("linkman_user_span0").innerText="请输入电话";
				}else if(!testPhoneNumber(phone)){
					document.getElementById("linkman_user_span0").innerText="电话格式不正确";
				}else{
					document.getElementById("linkman_user_span0").innerText="信息输入有误";
				}
			}
	   		for(var i=1;i<linkman_user_num+1;i++){
	   			if(document.getElementById("linkman_user_div"+i)){
	   			    var linkman= document.getElementById("linkman_user"+i).value;
	   			    var phone= document.getElementById("phone_user"+i).value;
					if(linkman!=null&&linkman.length>0&&testPhoneNumber(phone)){
						document.getElementById("linkman_user"+i).value=linkman;
						document.getElementById("phone_user"+i).value=phone;
						document.getElementById("linkman_user_span"+i).innerText="";
						if(linkman_user.length==0){
							linkman_user=linkman+"の"+phone;
						}else{
							linkman_user+="い"+linkman+"の"+phone;
						}
					}else{
						k++;
						if(linkman.length<1&&phone.length<1){
							document.getElementById("linkman_user_span"+i).innerText="请输入姓名和电话";
						}else if(linkman.length<1){
							document.getElementById("linkman_user_span"+i).innerText="请输入姓名";
						}else if(phone.length<1){
							document.getElementById("linkman_user_span"+i).innerText="请输入电话";
						}else if(!testPhoneNumber(phone)){
							document.getElementById("linkman_user_span"+i).innerText="电话格式不正确";
						}else{
							document.getElementById("linkman_user_span"+i).innerText="信息输入有误";
						}
					}
				}
	   		}
	   		document.flowform.linkman_user.value=linkman_user;
	   		var linkman_bill="";
	   		var linkman= document.getElementById("linkman_bill0").value;
  			var phone= document.getElementById("phone_bill0").value;
			if(linkman!=null&&linkman.length>0&&testPhoneNumber(phone)){
				document.getElementById("linkman_bill0").value=linkman;
				document.getElementById("phone_bill0").value=phone;
				document.getElementById("linkman_bill_span0").innerText="";
				if(linkman_bill.length==0){
					linkman_bill=linkman+"の"+phone;
				}else{
					linkman_bill+="い"+linkman+"の"+phone;
				}
			}else{
				k++;
				if(linkman.length<1&&phone.length<1){
					document.getElementById("linkman_bill_span0").innerText="请输入姓名和电话";
				}else if(linkman.length<1){
					document.getElementById("linkman_bill_span0").innerText="请输入姓名";
				}else if(phone.length<1){
					document.getElementById("linkman_bill_span0").innerText="请输入电话";
				}else if(!testPhoneNumber(phone)){
					document.getElementById("linkman_bill_span0").innerText="电话格式不正确";
				}else{
					document.getElementById("linkman_bill_span0").innerText="信息输入有误";
				}
			}
	   		for(var i=1;i<linkman_bill_num+1;i++){
	   			if(document.getElementById("linkman_bill_div"+i)){
	   			    var linkman= document.getElementById("linkman_bill"+i).value;
	   			    var phone= document.getElementById("phone_bill"+i).value;
					if(linkman!=null&&linkman.length>0&&testPhoneNumber(phone)){
						document.getElementById("linkman_bill"+i).value=linkman;
						document.getElementById("phone_bill"+i).value=phone;
						document.getElementById("linkman_bill_span"+i).innerText="";
						if(linkman_bill.length==0){
							linkman_bill=linkman+"の"+phone;
						}else{
							linkman_bill+="い"+linkman+"の"+phone;
						}
					}else{
						k++;
						if(linkman.length<1&&phone.length<1){
							document.getElementById("linkman_bill_span"+i).innerText="请输入姓名和电话";
						}else if(linkman.length<1){
							document.getElementById("linkman_bill_span"+i).innerText="请输入姓名";
						}else if(phone.length<1){
							document.getElementById("linkman_bill_span"+i).innerText="请输入电话";
						}else if(!testPhoneNumber(phone)){
							document.getElementById("linkman_bill_span"+i).innerText="电话格式不正确";
						}else{
							document.getElementById("linkman_bill_span"+i).innerText="信息输入有误";
						}
					}
				}
	   		}
	   		document.flowform.linkman_bill.value=linkman_bill;
	   		var linkman_device="";
	   		var linkman= document.getElementById("linkman_device0").value;
  			var phone= document.getElementById("phone_device0").value;
			if(linkman!=null&&linkman.length>0&&testPhoneNumber(phone)){
				document.getElementById("linkman_device0").value=linkman;
				document.getElementById("phone_device0").value=phone;
				document.getElementById("linkman_device_span0").innerText="";
				if(linkman_device.length==0){
					linkman_device=linkman+"の"+phone;
				}else{
					linkman_device+="い"+linkman+"の"+phone;
				}
			}else{
				k++;
				if(linkman.length<1&&phone.length<1){
					document.getElementById("linkman_device_span0").innerText="请输入姓名和电话";
				}else if(linkman.length<1){
					document.getElementById("linkman_device_span0").innerText="请输入姓名";
				}else if(phone.length<1){
					document.getElementById("linkman_device_span0").innerText="请输入电话";
				}else if(!testPhoneNumber(phone)){
					document.getElementById("linkman_device_span0").innerText="电话格式不正确";
				}else{
					document.getElementById("linkman_device_span0").innerText="信息输入有误";
				}
			}
	   		for(var i=1;i<linkman_device_num+1;i++){
	   			if(document.getElementById("linkman_device_div"+i)){
	   			    var linkman= document.getElementById("linkman_device"+i).value;
	   			    var phone= document.getElementById("phone_device"+i).value;
					if(linkman!=null&&linkman.length>0&&testPhoneNumber(phone)){
						document.getElementById("linkman_device"+i).value=linkman;
						document.getElementById("phone_device"+i).value=phone;
						document.getElementById("linkman_device_span"+i).innerText="";
						if(linkman_device.length==0){
							linkman_device=linkman+"の"+phone;
						}else{
							linkman_device+="い"+linkman+"の"+phone;
						}
					}else{
						k++;
						if(linkman.length<1&&phone.length<1){
							document.getElementById("linkman_device_span"+i).innerText="请输入姓名和电话";
						}else if(linkman.length<1){
							document.getElementById("linkman_device_span"+i).innerText="请输入姓名";
						}else if(phone.length<1){
							document.getElementById("linkman_device_span"+i).innerText="请输入电话";
						}else if(!testPhoneNumber(phone)){
							document.getElementById("linkman_device_span"+i).innerText="电话格式不正确";
						}else{
							document.getElementById("linkman_device_span"+i).innerText="信息输入有误";
						}
					}
				}
	   		}
	   		document.flowform.linkman_device.value=linkman_device;
	   		if(strToDate(document.flowform.delivery_time.value)){ 
  			 	k++;
	   			document.getElementById("time_error").innerText="请检查时间格式";
	   		}else{
	   			document.getElementById("time_error").innerText="";
	   		}
  			if(strToDate(document.flowform.contract_time.value)){ 
  			 	k++;
	   			document.getElementById("time1_error").innerText="请检查时间格式";
	   		}else{
	   			document.getElementById("time1_error").innerText="";
	   		}
  			if(successUploadFileNum1==0&&file_num1==0) {
    			k++;
        		document.getElementById("file_input1_error").innerText="请选择文件";
    		}else {
        		document.getElementById("file_input1_error").innerText="";
    		}
  			if(document.flowform.description.value.replace(/\s+/g,"").length<1){
	   			initdiglog2("提示信息","合同执行风险一栏不能为空!"); 
	   			k++;
	   			return;
	   		}
	   		if(file_num2==0&&successUploadFileNum2==0&&document.flowform.other.value.replace(/\s+/g,"").length<1){
	   			initdiglog2("提示信息","您还未上传附件1：合同及技术协议扫描件，若无附件请备注!"); 
	   			k++;
	   			return;
	   		}
	   		if(file_num3==0&&successUploadFileNum3==0&&document.flowform.other2.value.replace(/\s+/g,"").length<1){
	   			initdiglog2("提示信息","您还未上传附件2：项目商务、技术评审邮件记录（虚拟打印PDF版），若无附件请备注!"); 
	   			k++;
	   			return;
	   		}
	   		if(file_num4==0&&successUploadFileNum4==0&&document.flowform.other3.value.replace(/\s+/g,"").length<1){
	   			initdiglog2("提示信息","您还未上传附件附件3：外部采购设备询价邮件记录，若无附件请备注!"); 
	   			k++;
	   			return;
	   		}
	   		if(file_num5==0&&successUploadFileNum5==0&&document.flowform.other4.value.replace(/\s+/g,"").length<1){
	   			initdiglog2("提示信息","您还未上传附件4：外包服务供应商信息及报价表（供应商评审表），若无附件请备注!"); 
	   			k++;
	   			return;
	   		}
	   		if(file_num6==0&&successUploadFileNum6==0&&document.flowform.other5.value.replace(/\s+/g,"").length<1){
	   			initdiglog2("提示信息","您还未上传附件5：投标报价表，若无附件请备注!"); 
	   			k++;
	   			return;
	   		}
  			if($(".div_testarea").length>0){
  				if($(".div_testarea").val().replace(/\s/g,"").length<1){
  					initdiglog2("提示信息","请说明本次修改内容!"); 
  	  				k++;
  	  				return;
  				}
  			}
  			document.flowform.delFids.value=delFids.replace("の","");
	   		if(k==0){
	   			document.flowform.submit();
	   		}
	   	}
	   	function addLinkman(n){
		   	if(n==1){
		   		var temp="";
		   		linkman_user_num++;
		   		for(var i=1;i<linkman_user_num;i++){
	   				if(document.getElementById("linkman_user_div"+i)){
	   					var linkman=document.getElementById("linkman_user"+i).value;
		   				var phone=document.getElementById("phone_user"+i).value;
	   					temp+='<div class="div_padding" id="linkman_user_div'+i+'">'+
							'姓名：<input type="text" value="'+linkman+'"id="linkman_user'+i+'" maxlength="10" onkeydown="if(event.keyCode==32) return false">'+
							' 电话：<input type="phone" value="'+phone+'"id="phone_user'+i+'"  maxlength="20" onkeydown="if(event.keyCode==32) return false">'+
							' <img src="images/delete.png" title="删除" onclick="delLinkman(1,'+i+');">'+
							' <span id="linkman_user_span'+i+'"></span></div>';
	   				}
	   			}
		   		var linkman=document.flowform.linkman_user0.value;
		   		var phone=document.flowform.phone_user0.value;
		   		var linkman_div = document.getElementById("linkman_user_div");
		   		temp+='<div class="div_padding" id="linkman_user_div'+linkman_user_num+'">'+
						'姓名：<input type="text" value="'+linkman+'"id="linkman_user'+linkman_user_num+'" maxlength="10" onkeydown="if(event.keyCode==32) return false">'+
						' 电话：<input type="phone" value="'+phone+'"id="phone_user'+linkman_user_num+'"  maxlength="20" onkeydown="if(event.keyCode==32) return false">'+
						' <img src="images/delete.png" title="删除" onclick="delLinkman(1,'+linkman_user_num+');">'+
						' <span id="linkman_user_span'+linkman_user_num+'"></span></div>';
		   		linkman_div.innerHTML = temp;
		   		document.flowform.linkman_user0.value="";
		   		document.flowform.phone_user0.value="";
		   	}else if(n==2){
		   		linkman_bill_num++;
		   		var temp="";
		   		for(var i=1;i<linkman_bill_num;i++){
	   				if(document.getElementById("linkman_bill_div"+i)){
	   					var linkman=document.getElementById("linkman_bill"+i).value;
		   				var phone=document.getElementById("phone_bill"+i).value;
	   					temp+='<div class="div_padding" id="linkman_bill_div'+i+'">'+
							'姓名：<input type="text" value="'+linkman+'"id="linkman_bill'+i+'" maxlength="10" onkeydown="if(event.keyCode==32) return false">'+
							' 电话：<input type="phone" value="'+phone+'"id="phone_bill'+i+'"  maxlength="20" onkeydown="if(event.keyCode==32) return false">'+
							' <img src="images/delete.png" title="删除" onclick="delLinkman(1,'+i+');">'+
							' <span id="linkman_bill_span'+i+'"></span></div>';
	   				}
	   			}
		   		var linkman=document.flowform.linkman_bill0.value;
		   		var phone=document.flowform.phone_bill0.value;
		   		var linkman_div = document.getElementById("linkman_bill_div");
		   		temp+='<div class="div_padding" id="linkman_bill_div'+linkman_bill_num+'">'+
						'姓名：<input type="text" value="'+linkman+'"id="linkman_bill'+linkman_bill_num+'" maxlength="10" onkeydown="if(event.keyCode==32) return false">'+
						' 电话：<input type="phone" value="'+phone+'"id="phone_bill'+linkman_bill_num+'"  maxlength="20" onkeydown="if(event.keyCode==32) return false">'+
						' <img src="images/delete.png" title="删除" onclick="delLinkman(2,'+linkman_bill_num+');">'+
						' <span id="linkman_bill_span'+linkman_bill_num+'"></span></div>';
		   		linkman_div.innerHTML = temp;
		   		document.flowform.linkman_bill0.value="";
		   		document.flowform.phone_bill0.value="";
		   	}else if(n==3){
		   		var temp="";
		   		linkman_device_num++;
		   		for(var i=1;i<linkman_device_num;i++){
	   				if(document.getElementById("linkman_device_div"+i)){
	   					var linkman=document.getElementById("linkman_device"+i).value;
		   				var phone=document.getElementById("phone_device"+i).value;
	   					temp+='<div class="div_padding" id="linkman_device_div'+i+'">'+
							'姓名：<input type="text" value="'+linkman+'"id="linkman_device'+i+'" maxlength="10" onkeydown="if(event.keyCode==32) return false">'+
							' 电话：<input type="phone" value="'+phone+'"id="phone_device'+i+'"  maxlength="20" onkeydown="if(event.keyCode==32) return false">'+
							' <img src="images/delete.png" title="删除" onclick="delLinkman(1,'+i+');">'+
							' <span id="linkman_device_span'+i+'"></span></div>';
	   				}
	   			}
		   		var linkman=document.flowform.linkman_device0.value;
		   		var phone=document.flowform.phone_device0.value;
		   		var linkman_div = document.getElementById("linkman_device_div");
		   		temp+='<div class="div_padding" id="linkman_device_div'+linkman_device_num+'">'+
						'姓名：<input type="text" value="'+linkman+'"id="linkman_device'+linkman_device_num+'" maxlength="10" onkeydown="if(event.keyCode==32) return false">'+
						' 电话：<input type="phone" value="'+phone+'"id="phone_device'+linkman_device_num+'"  maxlength="20" onkeydown="if(event.keyCode==32) return false">'+
						' <img src="images/delete.png" title="删除" onclick="delLinkman(3,'+linkman_device_num+');">'+
						' <span id="linkman_device_span'+linkman_device_num+'"></span></div>';
		   		linkman_div.innerHTML = temp;
		   		document.flowform.linkman_device0.value="";
		   		document.flowform.phone_device0.value="";
		   	}
	   	}
	   	function strToDate(str) {
	   		//判断日期格式符合YYYY-MM-DD标准
 			var tempStrs = str.split("-");
 			if(tempStrs.length==3&&validate(tempStrs[0])&&tempStrs[0].length==4&&validate(tempStrs[1])&&tempStrs[1]<13&&validate(tempStrs[2])&&tempStrs[2]<32){
				return false;
 			}
 			return true;
 		}
 		function validate(sDouble){
			//检验是否为正数
  			var re = /^\d+(?=\.{0,1}\d+$|$)/;
 		 	return re.test(sDouble)&&sDouble>0;
		}
	   	function delLinkman(n,name){
	   		var id="";
	   		var t_num = 1;
	   		var t_name = "";
	   		var t_phone = "";
	   		var t_div = "";
	   		if(n==1){
	   			id="linkman_user_div"+name;
	   			t_div = "linkman_user_div";
	   			t_num = linkman_user_num;
	   			t_name = "linkman_user";
	   			t_phone = "phone_user";	   			
	   		}else if(n==2){
	   			id="linkman_bill_div"+name;
	   			t_div = "linkman_bill_div";
	   			t_num = linkman_bill_num;
	   			t_name = "linkman_bill";
	   			t_phone = "phone_bill";
	   		}else if(n==3){
	   			id="linkman_device_div"+name;
	   			t_div = "linkman_device_div";
	   			t_num = linkman_device_num;
	   			t_name = "linkman_device";
	   			t_phone = "phone_device";
	   		}
	   		var obj = document.getElementById(id);
			if (obj != null) {
				if(name == 0){
					for(var i=t_num;i>0;i--){
						if(document.getElementById(t_div+i)){
							document.getElementById(t_name+0).value = document.getElementById(t_name+i).value;
							document.getElementById(t_phone+0).value = document.getElementById(t_phone+i).value;
							var lastId = t_div+i;
							var lastObj = document.getElementById(lastId);
							lastObj.parentNode.removeChild(lastObj);
							break;
						}
					}
					if(i == 0){
						initdiglog2("提示信息","至少保留一行！");
						return;
					}
				}
				else{
					obj.parentNode.removeChild(obj);
				}
			}
	   	}
		function setTime(time,obj){
			var nowdate="<%=DataUtil.getTadayStr()%>";
			if(compareTime1(nowdate,time)){
				obj.value=time;
			}else{
				initdiglogtwo2("提示信息","日期早于当前时间，请确认输入无误？");
		   		$( "#confirm2" ).click(function() {
					$( "#twobtndialog" ).dialog( "close" );
					obj.value=time;
				});
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
						<form action="NewFlowServlet?type=alertstartuptaskflow&file_time=<%=System.currentTimeMillis()%>" method="post"
							name="flowform">
							<input type="hidden" name="delFids">
							<input type="hidden" name="linkman_user">
							<input type="hidden" name="linkman_bill">
							<input type="hidden" name="linkman_device">
							<div class="td2_div">
								<div class="td2_div1">
									项目启动任务单
								</div>
								<table class="td2_table1">
									<tr class="table1_tr1">
										<td class="table1_tr1_td1">
											<span class="star">*</span>项目类型
										</td>
										<td class="table1_tr1_td2">
											<select name="pCategory">
												<c:forEach items="${pCategoryArray}" var="pCategory" varStatus="status">
												<option value="${status.index}" <c:if test="${status.index==task.project_category}">selected</c:if>  > ${pCategory}</option>
												</c:forEach>
											</select>
										</td>
									</tr>
									<tr class="table1_tr1">
										<td class="table1_tr1_td1">
											<span class="star">*</span>产品类型
										</td>
										<td class="table1_tr1_td2">
											<select name="productType">
												<c:forEach items="${productTypeArray}" var="productType" varStatus="status">
												<option value="${status.index}" <c:if test="${status.index==task.product_type}">selected</c:if>  > ${productType}</option>
												</c:forEach>
											</select>
										</td>
									</tr>
									<tr class="table1_tr1">
										<td class="table1_tr1_td1">
											<span class='star'>*</span>项目名称
										</td>
										<td class="table1_tr1_td2">
											<input type="text" name="project_name" maxlength="50" required="required" value="${task.project_name}">
											<span id="pname_error"></span>
										</td>
									</tr>
									<tr class="table1_tr2">
										<td class="table1_tr2_td1">
											<span class='star'>*</span>项目编号
										</td>
										<td class="table1_tr2_td2">
											<input type="text" name="project_id" maxlength="100" value="${task.project_id}" onkeyup="value=value.replace(/[^\d]/g,'')">
											<span id="pid_error"></span>
										</td>
									</tr>
									<tr class="table1_tr3">
										<td class="table1_tr3_td1">
											<span class='star'>*</span>项目情况
										</td>
										<td class="table1_tr3_td2">
											<c:forEach items="${pCaseArray}" var="pCase" varStatus="status">
												<label><input name="project_case" type="radio" value="${status.index}" ${task.project_case==status.index?"checked":""} />${pCase}</label>
											</c:forEach>
										</td>
									</tr>
									<tr class="table1_tr4">
										<td class="table1_tr4_td1">
											<span class='star'>*</span>销售阶段
										</td>
										<td class="table1_tr4_td2">
											<c:forEach items="${stageArray}" var="stage" varStatus="status" begin="1">
												<label><input name="stage" type="radio" value="${status.index}" ${task.stage==status.index?"checked":""} />${stage}</label>
											</c:forEach>
										</td>
									</tr>
									<tr class="table1_tr5">
										<td class="table1_tr5_td1">
											<span class='star'>*</span>工程类型
										</td>
										<td class="table1_tr5_td2">
											<c:forEach items="${pTypeArray}" var="pType" varStatus="status">
												<label><input name="project_type" type="radio" value="${status.index}" ${task.project_type==status.index?"checked":""} />${pType}</label>
											</c:forEach>
										</td>
									</tr>
								</table>
								<table class="td2_table2">
									<tr class="table2_tr1">
										<td class="table2_tr1_td1">
											用户名称
										</td>
										<td class="table2_tr1_td2">
											<input type="text" name="customer" maxlength="100" value="${task.customer}">
											<span id="customer_error"></span>
										</td>
									</tr>
									<tr class="table2_tr2">
										<td class="table2_tr2_td1">
											<span class='star'>*</span>用户联系人
										</td>
										<td class="table2_tr2_td2">
											<div id="linkman_user_div">
											<%int len1=linkmanList1.size();for(int i=1;i<len1;i++){ %>
												<div class="div_padding" id="linkman_user_div<%=i%>">
													姓名：<input type="text" value="<%=linkmanList1.get(i).getLinkman() %>" id="linkman_user<%=i %>" maxlength="10" onkeydown="if(event.keyCode==32) return false">
													电话：<input type="phone" value="<%=linkmanList1.get(i).getPhone() %>" id="phone_user<%=i %>"  maxlength="20" onkeydown="if(event.keyCode==32) return false">
							 						<img src="images/delete.png" title="删除" onclick="delLinkman(1,<%=i %>);">
													<span id="linkman_user_span<%=i %>"></span>
												</div>
											<%} %>
											</div>
											<div id="linkman_user_div0" class="div_padding">
												姓名：<input type="text" id="linkman_user0" maxlength="10" value="<%=linkmanList1.size()>0?linkmanList1.get(0).getLinkman():""%>" onkeydown="if(event.keyCode==32) return false">
												电话：<input type="phone" id="phone_user0" maxlength="20" value="<%=linkmanList1.size()>0?linkmanList1.get(0).getPhone():""%>" onkeydown="if(event.keyCode==32) return false">
												<img src="images/delete.png" title="删除" onclick="delLinkman(1,0);">
												<img src="images/add_linkman.png" style="margin-left: 10px" title="添加" onclick="addLinkman(1);">
												<span id="linkman_user_span0" style="margin-left: 10px"></span>
											</div>
										</td>
									</tr>
									<tr class="table2_tr3">
										<td class="table2_tr3_td1">
											<span class='star'>*</span>发票接收人
										</td>
										<td class="table2_tr3_td2">
											<div id="linkman_bill_div">
												<%int len2=linkmanList2.size();for(int i=1;i<len2;i++){ %>
												<div class="div_padding" id="linkman_bill_div<%=i%>">
													姓名：<input type="text" value="<%=linkmanList2.get(i).getLinkman() %>" id="linkman_bill<%=i %>" maxlength="10" onkeydown="if(event.keyCode==32) return false">
													电话：<input type="phone" value="<%=linkmanList2.get(i).getPhone() %>" id="phone_bill<%=i %>"  maxlength="20" onkeydown="if(event.keyCode==32) return false">
							 						<img src="images/delete.png" title="删除" onclick="delLinkman(2,<%=i %>);">
													<span id="linkman_bill_span<%=i %>"></span>
												</div>
												<%} %>
											</div>
											<div id="linkman_bill_div0" class="div_padding">
												姓名：<input type="text" id="linkman_bill0" maxlength="10" value="<%=linkmanList2.size()>0?linkmanList2.get(0).getLinkman():"" %>" onkeydown="if(event.keyCode==32) return false">
												电话：<input type="phone" id="phone_bill0" maxlength="20" value="<%=linkmanList2.size()>0?linkmanList2.get(0).getPhone():"" %>" onkeydown="if(event.keyCode==32) return false">
												<img src="images/delete.png" title="删除" onclick="delLinkman(2,0);">
												<img src="images/add_linkman.png" style="margin-left: 10px" title="添加" onclick="addLinkman(2);">
												<span id="linkman_bill_span0" style="margin-left: 10px"></span>
											</div>
										</td>
									</tr>
									<tr class="table2_tr4">
										<td class="table2_tr4_td1">
											<span class='star'>*</span>设备接收人
										</td>
										<td class="table2_tr4_td2" id="linkman_device_td">
											<div id="linkman_device_div">
												<%int len3=linkmanList3.size();for(int i=1;i<len3;i++){ %>
												<div class="div_padding" id="linkman_device_div<%=i%>">
													姓名：<input type="text" value="<%=linkmanList3.get(i).getLinkman() %>" id="linkman_device<%=i %>" maxlength="10" onkeydown="if(event.keyCode==32) return false">
													电话：<input type="phone" value="<%=linkmanList3.get(i).getPhone() %>" id="phone_device<%=i %>"  maxlength="20" onkeydown="if(event.keyCode==32) return false">
							 						<img src="images/delete.png" title="删除" onclick="delLinkman(3,<%=i %>);">
													<span id="linkman_device_span<%=i %>"></span>
												</div>
												<%} %>
											</div>
											<div id="linkman_device_div0" class="div_padding">
												姓名：<input type="text" id="linkman_device0" maxlength="10" value="<%=linkmanList3.size()>0?linkmanList3.get(0).getLinkman():"" %>" onkeydown="if(event.keyCode==32) return false">
												电话：<input type="phone" id="phone_device0" maxlength="20" value="<%=linkmanList3.size()>0?linkmanList3.get(0).getPhone():"" %>" onkeydown="if(event.keyCode==32) return false">
												<img src="images/delete.png" title="删除" onclick="delLinkman(3,0);">
												<img src="images/add_linkman.png" style="margin-left: 10px" title="添加" onclick="addLinkman(3);">
												<span id="linkman_device_span0" style="margin-left: 10px"></span>
											</div>
										</td>
									</tr>
									<tr class="table2_tr5">
										<td class="table2_tr5_td1">
											<span class='star'>*</span>要求发货时间
										</td>
										<td class="table2_tr5_td2">
											<input type="text" id="time" name="delivery_time" value="${task.delivery_timestr}" 
											onClick="return Calendar('time');" readonly="readonly"/>
											<span id="time_error"></span>
										</td>
									</tr>
									<tr class="table2_tr5">
										<td class="table2_tr5_td1">
											<span class='star'>*</span>合同生效时间
										</td>
										<td class="table2_tr5_td2">
											<input type="text" id="time1" name="contract_time" value="${task.contract_timestr}" 
											onClick="return Calendar('time1');" readonly="readonly"/>
											<span id="time1_error"></span>
										</td>
									</tr>
									<tr class="table2_tr6">
										<td class="table2_tr6_td1">
											<span class='star'>*</span>项目说明及特殊要求（含合同执行风险）
										</td>
										<td class="table2_tr6_td2">
											<span>1.是否要求施工前现场开箱验货&nbsp</span>
											<label><input name="inspection" type="radio" value="0" <%=task.getInspection()==0?"checked":""%>/>是</label>
											<label><input name="inspection" type="radio" value="1" <%=task.getInspection()==1?"checked":""%>/>否</label><br/>
											<span>2.发货前是否要求需和销售经理确认&nbsp</span>
											<label><input name="verify" type="radio" value="0" <%=task.getVerify()==0?"checked":""%>/>是</label>
											<label><input name="verify" type="radio" value="1" <%=task.getVerify()==1?"checked":""%>/>否</label><br/>
											<textarea name="description" placeholder="此处输入项目说明、特殊要求和合同执行风险" 
											onkeydown="limitLength(this,1800);" onkeyup="limitLength(this,1800);" 
											maxlength="1800"><%=task.getDescription().length()>0?task.getDescription():"" %></textarea>
										</td>
									</tr>
									<tr class="table2_tr7">
										<td class="table2_tr7_td1">
											<span class='star'>*</span>项目成本核算表
										</td>
										<td class="table2_tr7_td2">
										<div class="tr7_div1">
											<c:forEach items="${fpathList1}" var="file_path">
												<div id="file_div${file_path.id}"><a class="img_a"
												href="javascript:void()" onclick="fileDown(${file_path.id})">${file_path.file_name}</a>
											[<a class="img_a" href="javascript:void(0);" onclick="delFile(${file_path.id},'${file_path.file_name}',1)">删除</a>]
											</div>
											</c:forEach>
										</div>
										<div class="tr7_div2">
											<div class="section-white">
												<input type="file" name="file_list" id="file_input1"
												multiple="multiple">
											</div>
											<div class="section-white2">
												<span id="file_input1_error"></span>
											</div>
											</div>
										</td>
									</tr>
									<tr class="table2_tr8">
										<td class="table2_tr8_td1">
											<span class='star'>*</span>项目技术附件
										</td>
										<td class="table2_tr8_td2">
											 <div style="display:block">
												<div class="file_title_remark">附件1：合同及技术协议扫描件</div>
												<c:forEach items="${fpathList2}" var="file_path">
												<div id="file_div${file_path.id}"><a class="img_a"
												href="javascript:void()" onclick="fileDown(${file_path.id})">${file_path.file_name}</a>
												[<a class="img_a" href="javascript:void(0);" onclick="delFile(${file_path.id},'${file_path.file_name}',2)">删除</a>]
												</div>
												</c:forEach>
												<div class="section-white">
													<input type="file" name="file_technical2" id="file_input2" multiple="multiple">												
												</div>
												<textarea name="other" placeholder="附件1：合同及技术协议扫描件" onkeydown="limitLength(this,500);" 
												onkeyup="limitLength(this,500);" style="height:30px;" maxlength="500">${task.other}</textarea>
											</div>
											<div style="display:block">
												<div class="file_title_remark">附件2：项目商务、技术评审邮件记录（虚拟打印PDF版</div>
												<c:forEach items="${fpathList3}" var="file_path2">
												<div id="file_div${file_path2.id}"><a class="img_a"
												href="javascript:void()" onclick="fileDown(${file_path2.id})">${file_path2.file_name}</a>
												[<a class="img_a" href="javascript:void(0);" onclick="delFile(${file_path2.id},'${file_path2.file_name}',3)">删除</a>]
												</div>
												</c:forEach>
												<div class="section-white">
													<input type="file" name="file_technical3" id="file_input3" multiple="multiple">												
												</div>
												<textarea name="other2" placeholder="附件2：项目商务、技术评审邮件记录（虚拟打印PDF版）" onkeydown="limitLength(this,500);" 
												onkeyup="limitLength(this,500);" style="height:30px;" maxlength="500">${task.other2}</textarea>
											</div>
										 	<div style="display:block">
												<div class="file_title_remark">附件3（如有）：外部采购设备询价邮件记录</div>
												<c:forEach items="${fpathList4}" var="file_path">
												<div id="file_div${file_path.id}"><a class="img_a"
												href="javascript:void()" onclick="fileDown(${file_path.id})">${file_path.file_name}</a>
												[<a class="img_a" href="javascript:void(0);" onclick="delFile(${file_path.id},'${file_path.file_name}',4)">删除</a>]
												</div>
												</c:forEach>
												<div class="section-white">
													<input type="file" name="file_technical4" id="file_input4" multiple="multiple">												
												</div>
												<textarea name="other3" placeholder="附件3（如有）：外部采购设备询价邮件记录" onkeydown="limitLength(this,500);" 
												onkeyup="limitLength(this,500);" style="height:30px;" maxlength="500">${task.other3}</textarea>
											</div>
											<div style="display:block">
												<div class="file_title_remark">附件4：外包服务供应商信息及报价表（供应商评审表）</div>
												<c:forEach items="${fpathList5}" var="file_path">
												<div id="file_div${file_path.id}"><a class="img_a"
												href="javascript:void()" onclick="fileDown(${file_path.id})">${file_path.file_name}</a>
												[<a class="img_a" href="javascript:void(0);" onclick="delFile(${file_path.id},'${file_path.file_name}',5)">删除</a>]
												</div>
												</c:forEach>
												<div class="section-white">
													<input type="file" name="file_technical5" id="file_input5" multiple="multiple">												
												</div>
												<textarea name="other4" placeholder="附件4：外包服务供应商信息及报价表（供应商评审表）" onkeydown="limitLength(this,500);" 
												onkeyup="limitLength(this,500);" style="height:30px;" maxlength="500">${task.other4}</textarea>
											</div>
											<div style="display:block">
												<div class="file_title_remark">附件5：投标报价表</div>
												<c:forEach items="${fpathList6}" var="file_path">
												<div id="file_div${file_path.id}"><a class="img_a"
												href="javascript:void()" onclick="fileDown(${file_path.id})">${file_path.file_name}</a>
												[<a class="img_a" href="javascript:void(0);" onclick="delFile(${file_path.id},'${file_path.file_name}',6)">删除</a>]
												</div>
												</c:forEach>
												<div class="section-white">
													<input type="file" name="file_technical6" id="file_input6" multiple="multiple">												
												</div>
												<textarea name="other5" placeholder="附件5：投标报价表" onkeydown="limitLength(this,500);" 
												onkeyup="limitLength(this,500);" style="height:30px;" maxlength="500">${task.other5}</textarea>
											</div>
											<div style="display:block">
												<div class="file_title_remark">附件6：其他与项目执行相关文档</div>
												<c:forEach items="${fpathList7}" var="file_path">
												<div id="file_div${file_path.id}"><a class="img_a"
												href="javascript:void()" onclick="fileDown(${file_path.id})">${file_path.file_name}</a>
												[<a class="img_a" href="javascript:void(0);" onclick="delFile(${file_path.id},'${file_path.file_name}',7)">删除</a>]
												</div>
												</c:forEach>
												<div class="section-white">
													<input type="file" name="file_technical7" id="file_input7" multiple="multiple">												
												</div>
												<textarea name="other6" placeholder="附件6：其他与项目执行相关文档" onkeydown="limitLength(this,500);" 
												onkeyup="limitLength(this,500);" style="height:30px;" maxlength="500">${task.other6}</textarea>
											</div>
										</td>
									</tr>
									<tr class="table2_tr9">
											<td class="table2_tr9_td1">
												备注
											</td>
											<td class="table2_tr9_td2">
											<textarea name="remarks" onkeydown="limitLength(this,2000);"
									onkeyup="limitLength(this,2000);"
										placeholder="此处输入备注" required="required" maxlength="2000">${task.remarks}</textarea>
										</td>
										</tr>
									
								</table>
								<textarea name="reason" id="reason"  class="div_testarea" placeholder="请输入修改内容" required="required" maxlength="500"></textarea>
								<c:if test="${operation != 7 && operation != 8&&mUser.id==task.create_id}">
								<div class="div_btn"><img src="images/submit_flow.png" onclick="alertFlow();"></div>
								</c:if>
							</div>
						</form>
					</td>
				</tr>
			</table>

		</div>
	</body>
</html>
