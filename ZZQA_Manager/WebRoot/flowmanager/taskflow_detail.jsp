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
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%@page
	import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%@ page import="com.zzqa.util.DateTrans" %>
<%
	request.setCharacterEncoding("UTF-8");
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
	if (session.getAttribute("task_id") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int task_id = (Integer)session.getAttribute("task_id");
	String[] flowTypeArray = DataUtil.getFlowTypeArray();
	Flow flow = flowManager.getNewFlowByFID(1, task_id);
	Task task = taskManager.getTaskByID(task_id);
	if(flow==null||task==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int operation = flow.getOperation();
	String[] pCaseArray = DataUtil.getPCaseArray();
	String[] stageArray = DataUtil.getStageArray();
	String[] pTypeArray = DataUtil.getPTypeArray();
	List<Linkman> linkmanList1 = linkmanManager.getLinkmanListLimit(1,
			task_id, 1, 0);
	List<Linkman> linkmanList2 = linkmanManager.getLinkmanListLimit(1,
			task_id, 2, 0);
	List<Linkman> linkmanList3 = linkmanManager.getLinkmanListLimit(1,
			task_id, 3, 0);
	List<File_path> fpathList1 = file_pathManager
			.getAllFileByCondition(1, task_id, 1, 0);
	List<File_path> fpathList2 = file_pathManager
			.getAllFileByCondition(1, task_id, 2, 0);
	List<File_path> fpathList3 = file_pathManager
			.getAllFileByCondition(1, task_id, 3,0);
	List<File_path> fpathList4 = file_pathManager
			.getAllFileByCondition(1, task_id, 4,0);
	List<File_path> fpathList5 = file_pathManager
			.getAllFileByCondition(1, task_id, 5,0);
	List<File_path> fpathList6 = file_pathManager
			.getAllFileByCondition(1, task_id, 6,0);
	Map<String, String> map= taskManager.getTaskFlowForDraw(task,flow);

	boolean hasPermission = permissionsManager.checkPermission(mUser.getPosition_id(), 50);

	List<Flow> reasonList = flowManager.getReasonList(1,task_id);
	boolean doTaskFile=false;//项目配置单处理权限
	int position_id=mUser.getPosition_id();
	int p_case = task.getProject_case();
	int project_type = task.getProject_type();
	int product_type = task.getProduct_type();
	int project_category=task.getProject_category();
	if(task.getProject_category()==5){//新产品试装项目
		doTaskFile=((task.getProject_category()==5 && (operation==13 || operation==18)) && (task.getCreate_id()==mUser.getId() || "admin".equals(mUser.getName())));
	}else{
		if(task.getProject_case()==0){
			//普项
			if(task.getProject_type() == 2){
				doTaskFile=(operation==24||operation==18)&&permissionsManager.checkPermission(position_id, 157);
			}else{
				if(task.getProject_category()==6 || task.getProject_category()==7 || task.getProject_category()==8){
					//煤炭冶金项目 到了工程审核时候 配置单由工程审核权限的人上传
					doTaskFile=((operation==13 || operation==18) && permissionsManager.checkPermission(position_id, 171));
				}else{
					doTaskFile=(operation==13||operation==18)&&permissionsManager.checkPermission(position_id, 50);
				}
			}
		}else{
			//急项
			if(task.getProject_type() == 2){//售后
				doTaskFile=(operation==21||operation==18)&&permissionsManager.checkPermission(position_id, 157);
			}else{//非售后项目
				if(task.getProject_category()==6 || task.getProject_category()==7 || task.getProject_category()==8){
					//煤炭冶金项目 到了工程审核时候 配置单由工程审核权限的人上传
					doTaskFile=((operation==21 || operation==18) && permissionsManager.checkPermission(position_id, 171));
				}else{
					doTaskFile=(operation==21||operation==18)&&permissionsManager.checkPermission(position_id, 50);
				}
			}
		}
	}
	int size=fpathList1.size();
	
	//结束后增加附件
	boolean addTaskFile=(
			(operation==5||operation==8||operation==23)&&
					(permissionsManager.checkPermission(position_id, 50) || ((task.getProject_category()==6 || task.getProject_category()==7 || task.getProject_category()==8)&&permissionsManager.checkPermission(position_id, 171))))
			||  ((task.getProject_category()==5 && (operation==13 || operation==23)) && (task.getCreate_id()==mUser.getId()));
	//2018-11-21 新增int getProject_type
	boolean canApprove=flowManager.checkTaskCanDo(task.getCreate_id(),task.getProject_type(),task.getProject_category(),task.getProject_case(),task.getProduct_type(),mUser, operation);
	pageContext.setAttribute("operation", operation);
	pageContext.setAttribute("task", task);
	pageContext.setAttribute("mUser", mUser);
	pageContext.setAttribute("canApprove", canApprove);
	pageContext.setAttribute("hasPermission", hasPermission);
	boolean watchFile=((operation == 5 || operation == 8|| operation == 23)&&("admin".equals(mUser.getName())||permissionsManager.checkPermission(mUser.getPosition_id(),13))) || ((operation==17||operation==20)&&permissionsManager.checkPermission(position_id, 163));
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		
		<title>任务单流程</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css" href="css/taskflow_detail.css">
		<link rel="stylesheet" type="text/css" href="css/custom.css">
		<link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-filer.css">
		<link rel="stylesheet" type="text/css" href="css/default.css">
		<link rel="stylesheet" type="text/css"
			href="css/jquery.filer-dragdropbox-theme.css">
		<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
		<script src="js/prettify.js" type="text/javascript"></script>
		<script src="js/jquery.min.js" type="text/javascript"></script>
		<script src="js/jquery.filer.min.js" type="text/javascript"></script>
		<script src="js/custom.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		
		<style>
			body {
				font-size: 62.5%;
			}
			/* .td2_div141_pass_new{
				margin-left:45px;
			}
			.td2_div131_pass_new{
				margin-left:43px;
			} */
		</style>
	<script type="text/javascript">
		var remark="<%=task.getRemarks() != null ? task.getRemarks().replaceAll("\r\n", "<br/>").replaceAll("\n\r", "<br/>").replaceAll("\r", "<br/>").replaceAll("\n", "<br/>") : ""%>";
		var file_num=<%=fpathList3.size()%>;
		var file_num4=<%=fpathList4.size()%>;
		var file_num5=<%=fpathList5.size()%>;
		var addTaskFile=<%=addTaskFile%>;
		var projectName = "<%=task.getProject_name()%>";
		var fileData = new Array();
		var file_length1 = <%=size%>;
		var file_length2 = <%=fpathList2.size()%>;
		var file_length3 = <%=fpathList3.size()%>;
		var file_length4 = <%=fpathList4.size()%>;
		var file_length5 = <%=fpathList5.size()%>;
		var file_length6 = <%=fpathList6.size()%>;
		var protocolData1  = new Array();
		var protocolData2  = new Array();
		var protocolData3  = new Array();
		var protocolData4  = new Array();
		var protocolData5  = new Array();
		var protocolData6  = new Array();
		$(function(){
			if(<%=watchFile%>){
				getAllFileGroupByState();
			}
			if(file_length1>0){
				<%
					if(task.getProtocol() == 0){
						int i=0;
						for (File_path file_path : fpathList1) {
							%>
								protocolData1[<%=i%>]=<%=file_path.getId()%>;
							<%
							i++;
						}
					}
				%>
			}
			if(file_length2>0){
				<%
					if(task.getProtocol() == 0){
						int i=0;
						for (File_path file_path : fpathList2) {
							%>
							protocolData2[<%=i%>]=<%=file_path.getId()%>;
							<%
							i++;
						}
					}
				%>
			}
			if(file_length3>0){
				<%
					if(task.getProtocol() == 0){
						int i=0;
						for (File_path file_path : fpathList3) {
							%>
								protocolData3[<%=i%>]=<%=file_path.getId()%>;
							<%
							i++;
						}
					}
				%>
			}
			if(file_length4>0){
				<%
					if(task.getProtocol() == 0){
						int i=0;
						for (File_path file_path : fpathList4) {
							%>
							protocolData4[<%=i%>]=<%=file_path.getId()%>;
							<%
							i++;
						}
					}
				%>
			}
			if(file_length5>0){
				<%
					if(task.getProtocol() == 0){
						int i=0;
						for (File_path file_path : fpathList5) {
							%>
							protocolData5[<%=i%>]=<%=file_path.getId()%>;
							<%
							i++;
						}
					}
				%>
			}
			if(file_length6>0){
				<%
					if(task.getProtocol() == 0){
						int i=0;
						for (File_path file_path : fpathList6) {
							%>
								protocolData6[<%=i%>]=<%=file_path.getId()%>;
							<%
							i++;
						}
					}
				%>
			}

		});
		function getAllFileGroupByState(){
			$.ajax({
				type:"post",//post方法
				url:"FlowManagerServlet",
				data:{"type":"getAllFileGroupByState"},
				dataType:'json',
				error : function(){ //请求完成后最终执行参数
					initdiglog2("提示信息","加载失败!"); 
				}, 
				//ajax成功的回调函数
				success:function(returnData){
					if(returnData&&returnData.length>0){
						var nowstate=returnData[0].state;
						var time=returnData[0].create_time;
						var temp='<div class="state_div"><span>'+timeTransLongToStr(time,100,"-",true)+'</span>';
						var count=0;
						$.each(returnData,function(){
							if(this.state!=nowstate){
								nowstate=this.state;
								count=0;
								fileData=[];
								temp+='</div><div class="state_div"><span>'+timeTransLongToStr(this.create_time,100,"-",true)+'</span>';
							}
							fileData[count] = this.id;
							count++;
							temp+='<div><a class="img_a" href="javascript:void()" onclick="fileDown('+this.id+')">'+this.file_name+'</a></div>';
						});
						temp+='<div>';
						// $(".table2_tr15_td2").prepend(temp);
					}
				}
			});
		}
		function saveTaskFile(){
			if(successUploadFileNum3>0){
				initdiglogtwo2("提示信息", "请确认文件上传无误并及时告知相关人员！");
				$( "#confirm2" ).click(function() {
					$( "#twobtndialog" ).dialog( "close" );
					$.ajax({
						type:"post",//post方法
						url:"FlowManagerServlet",
						data:{"type":"alertTaskProjectFile"},
						error : function(XMLHttpRequest,status){ //请求完成后最终执行参数
							initdiglog2("提示信息","请求错误，请刷新重试!"); 
						}, 
						//ajax成功的回调函数
						success:function(returnData){
							location.reload();
						}
					});
		   		});
			}else{
				initdiglog2("提示信息","请上传项目材料配置单！");
	 			return;
			}
		}
		function saveTaskFile4(){
			if(successUploadFileNum4>0){
				initdiglogtwo2("提示信息", "请确认文件上传无误并及时告知相关人员！");
				$( "#confirm2" ).click(function() {
					$( "#twobtndialog" ).dialog( "close" );
					$.ajax({
						type:"post",//post方法
						url:"FlowManagerServlet",
						data:{"type":"alertTaskProjectFile4"},
						error : function(XMLHttpRequest,status){ //请求完成后最终执行参数
							initdiglog2("提示信息","请求错误，请刷新重试!");
						},
						//ajax成功的回调函数
						success:function(returnData){
							location.reload();
						}
					});
				});
			}else{
				initdiglog2("提示信息","请上传项目材料配置单！");
				return;
			}
		}
		function saveTaskFile5(){
			if(successUploadFileNum5>0){
				initdiglogtwo2("提示信息", "请确认文件上传无误并及时告知相关人员！");
				$( "#confirm2" ).click(function() {
					$( "#twobtndialog" ).dialog( "close" );
					$.ajax({
						type:"post",//post方法
						url:"FlowManagerServlet",
						data:{"type":"alertTaskProjectFile5"},
						error : function(XMLHttpRequest,status){ //请求完成后最终执行参数
							initdiglog2("提示信息","请求错误，请刷新重试!");
						},
						//ajax成功的回调函数
						success:function(returnData){
							location.reload();
						}
					});
				});
			}else{
				initdiglog2("提示信息","请上传项目材料配置单！");
				return;
			}
		}
		function saveTaskFile6(){
			if(successUploadFileNum6>0){
				initdiglogtwo2("提示信息", "请确认文件上传无误并及时告知相关人员！");
				$( "#confirm2" ).click(function() {
					$( "#twobtndialog" ).dialog( "close" );
					$.ajax({
						type:"post",//post方法
						url:"FlowManagerServlet",
						data:{"type":"alertTaskProjectFile6"},
						error : function(XMLHttpRequest,status){ //请求完成后最终执行参数
							initdiglog2("提示信息","请求错误，请刷新重试!");
						},
						//ajax成功的回调函数
						success:function(returnData){
							location.reload();
						}
					});
				});
			}else{
				initdiglog2("提示信息","请备注文件！");
				return;
			}
		}
		function downTaskFile(type){
			var truename;
			if(type==1){
				if(protocolData1.length>0){
					truename="供货清单（"+projectName+"）";
					fileDownList(protocolData1,truename);
				}
			}else if (type==2){
				if(protocolData2.length>0){
					truename="技术附件（"+projectName+"）";
					fileDownList(protocolData2,truename);
				}
			}else if (type==3){
				if(protocolData3.length>0){
					truename="项目材料配置单（"+projectName+"）";
					fileDownList(protocolData3,truename);
				}
			}else if (type==4){
				if(protocolData4.length>0){
					truename="项目材料配置单（"+projectName+"）";
					fileDownList(protocolData4,truename);
				}
			}else if (type==5){
				if(protocolData5.length>0){
					truename="出场图纸（"+projectName+"）";
					fileDownList(protocolData5,truename);
				}
			}
			else if (type==6){
				if(protocolData6.length>0){
					truename="备注文件（"+projectName+"）";
					fileDownList(protocolData6,truename);
				}
			}
		}
		function verifyFlow(isagree){
			document.flowform.isagree.value=isagree;
			<%--if (isagree==2){--%>
			<%--	<%--%>
			<%--		operation = 1000;	//表示是工程设计师修改后提交的--%>
			<%--	%>--%>
			<%--}--%>
			var reason=document.flowform.reason.value.replace(/\s/g,"");
			if(reason.length==0){
				initdiglog2("提示信息","请输入意见或建议！");
				return;
			}
			<%if (doTaskFile) {%>
				if(isagree==0&&(successUploadFileNum4==0&&successUploadFileNum3==0)&&(file_num==0&&file_num4==0)) {
		 			initdiglog2("提示信息","请上传项目材料配置单！！");
		 			return;
				}
			if(isagree==0&&successUploadFileNum5==0&&successUploadFileNum3==0&&file_num==0&&file_num5==0) {
				initdiglog2("提示信息","请上传出厂图纸！！");
				return;
			}
			<%}%>
			document.flowform.submit();
		}
		function alertRemarks(){
			$.ajax({
				type:"post",//post方法
				url:"CheckServlet",
				data:{"type":"alertRemarks","remarks":document.flowform.remarks.value},
				timeout : 10000, //超时时间设置，单位毫秒
				complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
					if(status=='timeout'){//超时,status还有success,error等值的情况
						initdiglog2("提示信息","请求超时，请重试!"); 
					}
				}, 
				//ajax成功的回调函数
				success:function(returnData){
					//$( "#onebtndialog" ).dialog( "open" );
					initdiglog2("提示信息","保存成功！");
					remark=document.flowform.remarks.value.replace(/[\r\n]/g, "<br/>").replace(/[\n\r]/g, "<br/>").replace(/[\r]/g, "<br/>").replace(/[\n]/g, "<br/>");
				}
			});
		}
		function cancleTask(f){
			if(f==0){
				//撤销
				initdiglogtwo2("提示信息","您确定要撤销该任务单吗？");
		   		$( "#confirm2" ).click(function() {
					$( "#twobtndialog" ).dialog( "close" );
					var reason=document.flowform.reason.value.replace(/\s/g,"");
					if(reason.length==0){
						initdiglog2("提示信息","请输入意见或建议！");
						return;
					}
					document.flowform2.reason.value=reason;
					document.flowform2.type.value="cancleTask";
					document.flowform2.submit();
		   		});
			}else{
				//恢复
				initdiglogtwo2("提示信息","您确定要恢复该任务单吗？");
		   		$( "#confirm2" ).click(function() {
					$( "#twobtndialog" ).dialog( "close" );
					document.flowform2.type.value="recoverTask";
					document.flowform2.submit();
		   		});
			}
		}
	   	function delFile(id,name){
	   		initdiglogtwo2("提示信息","您确定要删除附件<br/>【"+""+name+"】吗？");
	   		$( "#confirm2" ).click(function() {
				$( "#twobtndialog" ).dialog( "close" );
				$.ajax({
					type:"post",//post方法
					url:"DeleteFileServlet",
					data:{"id":id,"type":"delTaskFile2"},
					timeout : 10000, //超时时间设置，单位毫秒
					//ajax成功的回调函数
					complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
						if(status=='timeout'){//超时,status还有success,error等值的情况
							initdiglog2("提示信息","请求超时，请重试!"); 
						}
					}, 
					success:function(returnData){
						if(returnData==1){
							initdiglog2("提示信息","删除成功！");
							var na="#file_div"+id;
							$(na).remove();
							file_num--;
						}
					}
				});
			});
	   	}
		   function preview(){
			   $("#section4").hide();
			   $(".state_add").hide();
			   bdhtml=window.document.body.innerHTML;//获取当前页的html代码 
				sprnstr="<!--startprint1-->";//设置打印开始区域 
				
				sprnstr0="<!--startprint0-->";
				//$("#remarks").text();
				eprnstr0="<!--endprint0-->";
				
				eprnstr="<!--endprint1-->";//设置打印结束区域 
				prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+18,bdhtml.indexOf(sprnstr0));
				prnhtml+=remark.replace(/\r\n/g,"<br/>").replace(/\n\r/g,"<br/>").replace(/\r/g,"<br/>").replace(/\n/g,"<br/>");
				prnhtml+=bdhtml.substring(bdhtml.indexOf(eprnstr0)+16,bdhtml.indexOf(eprnstr));
				window.document.body.innerHTML=prnhtml; 
				document.title =$("#project_name").text().trim()+$("#project_case").text().trim()
					+"项目任务单"+$("#project_id").text().trim();
				window.print(); 
				window.document.body.innerHTML=bdhtml;
				$("#section4").show();
				$(".state_add").show();
				if($(".table2_tr9_td2 textarea").length>0){
					var reg=new RegExp("<br/>","g");
					document.flowform.remarks.value=remark.replace(reg,"\r\n");
				}
				document.title ="任务单流程";
				initdiglogtwo2("提示信息","是否将所有文件打包下载吗？");
		   		$( "#confirm2" ).click(function() {
					$("#twobtndialog").dialog( "close" );
					window.location.href="FileZipDownServlet?type=1";
				});
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
							action="FlowManagerServlet" method="post" name="flowform2">
							<input type="hidden" name="reason">
							<input type="hidden" name="type">
							<input type="hidden" name="task_id" value=<%=task_id %>>
							</form>
						<form
							action="FlowManagerServlet?type=verifytaskflow&operation=<%=operation%>&file_time=<%=System.currentTimeMillis() %>"
							method="post" name="flowform" enctype="multipart/form-data">
							<input type="hidden" name="isagree" value="">
							<div class="td2_div">
								<div class="td2_div1">
								<%if(operation==12){ %>
									<div class="td2_div1_1_delete">
										<div>提交项目单</div>
										<div>已撤销</div>
									</div>
									<div class="td2_div1_2_delete">
										<div>
											<img src="images/pass.png">
										</div>
										<div></div>
										<div>
											<img src="images/error.png">
										</div>
									</div>
									<div class="td2_div1_3_delete">
										<div><%=map.get("time1")%></div>
										<div><%=map.get("time2")%></div>
									</div>
								<%}else if(operation==5||operation==8){ %>
									<div class="td2_div1_1">
										<div class="<%=map.get("class11")%>"><%=map.get("name1")%></div>
										<div class="<%=map.get("class12")%>"><%=map.get("name2")%></div>
										<div class="<%=map.get("class13")%>"><%=map.get("name3")%></div>
										<div class="<%=map.get("class14")%>"><%=map.get("name4")%></div>
										<div class="<%=map.get("class15")%>"><%=map.get("name5")%></div>
									</div>
									<div class="td2_div1_2">
										<div class="td2_div21">
											<img src="images/<%=map.get("img1")%>">
										</div>
										<div class="<%=map.get("class22")%>"></div>
										<div class="td2_div23">
											<img src="images/<%=map.get("img2")%>">
										</div>
										<div class="<%=map.get("class24")%>"></div>
										<div class="td2_div25">
											<img src="images/<%=map.get("img3")%>">
										</div>
										<div class="<%=map.get("class26")%>"></div>
										<div class="td2_div27">
											<img src="images/<%=map.get("img4")%>">
										</div>
										<div class="<%=map.get("class28")%>"></div>
										<div class="td2_div29">
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
								<%}else{ %>
									<%if(product_type==10){ %>
										<div class="td4_div1_1_new">
											<div class="<%=map.get("class11")%>"><%=map.get("name1")%></div>
											<div class="<%=map.get("class12")%>"><%=map.get("name2")%></div>
											<div class="<%=map.get("class13")%>"><%=map.get("name3")%></div>
											<div class="<%=map.get("class14")%>"><%=map.get("name4")%></div>
										</div>
										<div class="td4_div1_2_new">
											<div class="td4_div40_new">
												<img src="images/<%=map.get("img1")%>">
											</div>
											<div class="<%=map.get("class22")%>"></div>
											<div class="td4_div41_new">
												<img src="images/<%=map.get("img2")%>">
											</div>
											<div class="<%=map.get("class24")%>"></div>
											<div class="td4_div42_new">
												<img src="images/<%=map.get("img3")%>">
											</div>
											<div class="<%=map.get("class26")%>"></div>
											<div class="td4_div43_new">
												<img src="images/<%=map.get("img4")%>">
											</div>
										</div>
										<div class="td4_div1_3_new">
											<div class="td4_div31_new"><%=map.get("time1")%></div>
											<div class="td4_div32_new"><%=map.get("time2")%></div>
											<div class="td4_div33_new"><%=map.get("time3")%></div>
											<div class="td4_div34_new"><%=map.get("time4")%></div>
										</div>
									<%}else{ %>
										<%if(project_type==2 && project_category !=5){ %>
											<div class="td2_div1_1_new">
												<div class="<%=map.get("class11")%>"><%=map.get("name1")%></div>
												<div class="<%=map.get("class12")%>"><%=map.get("name2")%></div>
												<div class="<%=map.get("class13")%>"><%=task.getProject_case()==1?"<div style='display:inline-block;width:7.13px;'></div>":""%><%=map.get("name3")%><%=task.getProject_case()==1?"<div style='display:inline-block;width:7.13px;'></div>":""%></div>
												<div class="<%=map.get("class14")%>"><%=map.get("name4")%></div>
												<div class="<%=map.get("class38")%>"><%=map.get("name8")%></div>
												<div class="<%=map.get("class17")%>"><%=map.get("name7")%></div>
												<div class="<%=map.get("class15")%>"><%=task.getProject_case()==0?"<div style='display:inline-block;width:7.13px;'></div>":""%><%=map.get("name5")%><%=task.getProject_case()==0?"<div style='display:inline-block;width:7.13px;'></div>":""%></div>
												<div class="<%=map.get("class16")%>"><%=map.get("name6")%></div>
											</div>
											<div class="td2_div1_2_new">
												<div class="td2_div21_new">
													<img src="images/<%=map.get("img1")%>">
												</div>
												<div class="<%=map.get("class22")%>"></div>
												<div class="td2_div23_new">
													<img src="images/<%=map.get("img2")%>">
												</div>
												<div class="<%=map.get("class24")%>"></div>
												<div class="td2_div25_new">
													<img src="images/<%=map.get("img3")%>">
												</div>
												<div class="<%=map.get("class26")%>"></div>
												<div class="td2_div213_new">
													<img src="images/<%=map.get("img4")%>">
												</div>
												<div class="<%=map.get("class30")%>"></div>
												<div class="td2_div39_new">
													<img src="images/<%=map.get("img8")%>">
												</div>
												<div class="<%=map.get("class39")%>"></div>
												<div class="td2_div27_new">
													<img src="images/<%=map.get("img7")%>">
												</div>
												<div class="<%=map.get("class28")%>"></div>
												<div class="td2_div29_new">
													<img src="images/<%=map.get("img5")%>">
												</div>
												<div class="<%=map.get("class210")%>"></div>
												<div class="td2_div211_new">
													<img src="images/<%=map.get("img6")%>">
												</div>
											</div>
											<div class="td2_div1_3_new">
												<div class="td2_div31_new"><%=map.get("time1")%></div>
												<div class="td2_div32_new"><%=map.get("time2")%></div>
												<div class="td2_div33_new"><%=map.get("time3")%></div>
												<div class="td2_div34_new"><%=map.get("time4")%></div>
												<div class="td2_div39_new_2"><%=map.get("time8")%></div>
												<div class="td2_div37_new"><%=map.get("time7")%></div>
												<div class="td2_div35_new"><%=map.get("time5")%></div>
												<div class="td2_div36_new"><%=map.get("time6")%></div>
											</div>
										<%}else{ %>
											<%if (project_category==5){%>
												<div class="td2_div1_1_new">
													<div class="<%=map.get("class11")%>"><%=map.get("name1")%></div>
													<div class="<%=map.get("class12")%>"><%=map.get("name2")%></div>
													<div style="margin-left: 20px;" class="<%=map.get("class13")%>" <%=task.getProject_category()==5?"style='margin-left:43px;'":""%>><%=task.getProject_case()==1?"<div style='display:inline-block;width:7.13px;'></div>":""%><%=map.get("name3")%><%=task.getProject_case()==1?"<div style='display:inline-block;width:7.13px;'></div>":""%></div>
													<div style="margin-left: 20px;" class="<%=map.get("class14")%>" <%=task.getProject_category()==5?"style='margin-left:45px;'":""%>><%=map.get("name4")%></div>
													<div class="<%=map.get("class15")%>"><%=task.getProject_case()==0?"<div style='display:inline-block;width:7.13px;'></div>":""%><%=map.get("name5")%><%=task.getProject_case()==0?"<div style='display:inline-block;width:7.13px;'></div>":""%></div>
													<div style="float: left; margin-left: 60px;" class="<%=map.get("class16")%>"><%=map.get("name6")%></div>
												</div>
												<div class="td2_div1_2_new">
													<div class="td2_div21_new">
														<img src="images/<%=map.get("img1")%>">
													</div>
													<div class="<%=map.get("class22")%>"></div>
													<div class="td2_div23_new">
														<img src="images/<%=map.get("img2")%>">
													</div>
													<div class="<%=map.get("class24")%>"></div>
													<div class="td2_div25_new">
														<img src="images/<%=map.get("img3")%>">
													</div>

													<div class="<%=map.get("class26")%>"></div>
													<div class="td2_div27_new">
														<img src="images/<%=map.get("img4")%>">
													</div>

													<div class="<%=map.get("class28")%>"></div>
													<div class="td2_div29_new">
														<img src="images/<%=map.get("img5")%>">
													</div>
													<div class="<%=map.get("class210")%>"></div>
													<div class="td2_div211_new">
														<img src="images/<%=map.get("img6")%>">
													</div>
												</div>
												<div class="td2_div1_3_new">
													<div class="td2_div41_new"><%=map.get("time1")%></div>
													<div class="td2_div42_new"><%=map.get("time2")%></div>
													<div class="td2_div43_new"><%=map.get("time3")%></div>

													<div class="td2_div44_new"><%=map.get("time4")%></div>

													<div class="td2_div45_new"><%=map.get("time5")%></div>
													<div style="float: left; margin-left: 60px;" class="td2_div46_new"><%=map.get("time6")%></div>
												</div>
											<%}else{%>
												<div class="td2_div1_1_new">
													<div class="<%=map.get("class11")%>"><%=map.get("name1")%></div>
													<div class="<%=map.get("class12")%>"><%=map.get("name2")%></div>
													<div class="<%=map.get("class13")%>" <%=task.getProject_category()==5?"style='margin-left:43px;'":""%>><%=task.getProject_case()==1?"<div style='display:inline-block;width:7.13px;'></div>":""%><%=map.get("name3")%><%=task.getProject_case()==1?"<div style='display:inline-block;width:7.13px;'></div>":""%></div>
													<%if(p_case==0 && project_category !=5){ %>
													<div class="<%=map.get("class38")%>"><%=map.get("name8")%></div>
													<%}%>
													<div class="<%=map.get("class14")%>" <%=task.getProject_category()==5?"style='margin-left:45px;'":""%>><%=map.get("name4")%></div>
													<%if(p_case!=0 && project_category !=5){ %>
													<div class="<%=map.get("class38")%>"><%=map.get("name8")%></div>
													<%}%>
													<div class="<%=map.get("class15")%>"><%=task.getProject_case()==0?"<div style='display:inline-block;width:7.13px;'></div>":""%><%=map.get("name5")%><%=task.getProject_case()==0?"<div style='display:inline-block;width:7.13px;'></div>":""%></div>
													<div class="<%=map.get("class16")%>"><%=map.get("name6")%></div>
												</div>
												<div class="td2_div1_2_new">
													<div class="td2_div21_new">
														<img src="images/<%=map.get("img1")%>">
													</div>
													<div class="<%=map.get("class22")%>"></div>
													<div class="td2_div23_new">
														<img src="images/<%=map.get("img2")%>">
													</div>
													<div class="<%=map.get("class24")%>"></div>
													<div class="td2_div25_new">
														<img src="images/<%=map.get("img3")%>">
													</div>
													<%if(p_case==0 && project_category !=5){ %>
													<div class="<%=map.get("class39")%>"></div>
													<div class="td2_div39_new">
														<img src="images/<%=map.get("img8")%>">
													</div>
													<%}%>
													<div class="<%=map.get("class26")%>"></div>
													<div class="td2_div27_new">
														<img src="images/<%=map.get("img4")%>">
													</div>
													<%if(p_case!=0 && project_category !=5){ %>
													<div class="<%=map.get("class39")%>"></div>
													<div class="td2_div39_new">
														<img src="images/<%=map.get("img8")%>">
													</div>
													<%}%>
													<div class="<%=map.get("class28")%>"></div>
													<div class="td2_div29_new">
														<img src="images/<%=map.get("img5")%>">
													</div>
													<div class="<%=map.get("class210")%>"></div>
													<div class="td2_div211_new">
														<img src="images/<%=map.get("img6")%>">
													</div>
												</div>
												<div class="td2_div1_3_new">
													<div class="td2_div41_new"><%=map.get("time1")%></div>
													<div class="td2_div42_new"><%=map.get("time2")%></div>
													<%if ("1970-01-01<br/>08:00:00".equals(map.get("time3"))){ %>
														<div class="td2_div43_new"><%=map.get("time8")%></div>
													<%}else {%>
														<div class="td2_div43_new"><%=map.get("time3")%></div>
													<%}%>
													<%--为了显示没有审批时的默认时间--%>
<%--													<%System.out.println(map.get("time3"));%>--%>

													<%if(p_case==0 && project_category !=5){ %>
														<div class="td2_div49_new"><%=map.get("time8")%></div>
													<%}%>
													<div class="td2_div44_new"><%=map.get("time4")%></div>
													<%if(p_case!=0 && project_category !=5){ %>
														<div class="td2_div49_new"><%=map.get("time8")%></div>
													<%}%>
													<div class="td2_div45_new"><%=map.get("time5")%></div>
													<div class="td2_div46_new"><%=map.get("time6")%></div>
												</div>
											<%}%>

										<%} %>
									<%} %>
								<%} %>
								</div>
								<div class="td2_div2" id="printContent">
								<!--startprint1-->
									<div class="td2_div3">
										项目任务单
									</div>
									<table class="td2_table1">
										<tr class="table1_tr1">
											<td class="table1_tr1_td1">
												项目类型：
											</td>
											<td class="table1_tr1_td2">
												<div ><%=DataUtil.getPCategoryArray()[task.getProject_category()]%></div>
											</td>
											<td class="table1_tr1_td1">
												<input type="button" value="查看采购流程" onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=42&id=<%=task.getId()%>'">
											</td>
										</tr>
										<tr class="table1_tr1">
											<td class="table1_tr1_td1">
												产品类型：
											</td>
											<td class="table1_tr1_td2">
<%--												<div ><%=DataUtil.getProductTypeArray()[task.getProduct_type()]%></div>--%>
												<%if(task.getProject_category()==0 && "1".equals(task.getIs_new_data())){ %>
													<div><%=task.getFan_product_type()%></div>
												<%} else { %>
													<div><%=DataUtil.getProductTypeArray()[task.getProduct_type()]%></div>
												<%} %>
											</td>
										</tr>
										<tr class="table1_tr1">
											<td class="table1_tr1_td1">
												项目序号：
											</td>
											<td class="table1_tr1_td2">
												<div id="project_name"><%=task.getProject_name()%></div>
											</td>
										</tr>
										<tr class="table1_tr2">
											<td class="table1_tr2_td1">
												项目编号：
											</td>
											<td class="table1_tr2_td2">
												<span id="project_id"><%=task.getProject_id()%></span>
											</td>
										</tr>
										<%if ("1".equals(task.getIs_new_data())) { %>
											<tr class="table1_tr2">
												<td class="table1_tr2_td1">
													风机数量：
												</td>
												<td class="table1_tr2_td2">
													<span id="fan_num"><%=task.getFan_num()%></span>
												</td>
											</tr>
											<tr class="table1_tr2">
												<td class="table1_tr2_td1">
													项目名称及主机厂家：
												</td>
												<td class="table1_tr2_td2">
													<span id="factory"><%=task.getFactory()%></span>
												</td>
											</tr>
											<tr class="table1_tr2">
												<td class="table1_tr2_td1">
													项目交期：
												</td>
												<td class="table1_tr2_td2">
													<span id="submit_date"><%=task.getSubmit_date()%>周</span>
												</td>
											</tr>
											<tr class="table1_tr2">
												<td class="table1_tr2_td1">
													合同类型：
												</td>
												<td class="table1_tr2_td2">
													<span id="contract_type"><%=task.getContract_type()%></span>
												</td>
											</tr>
											<tr class="table1_tr2">
												<td class="table1_tr2_td1">
													设备类型：
												</td>
												<td class="table1_tr2_td2">
													<span id="equipment_type"><%=task.getEquipment_type()%></span>
												</td>
											</tr>
										<%} else {%>
											<tr class="table1_tr2">
												<td class="table1_tr2_td1">
													项目质保期：
												</td>
												<td class="table1_tr2_td2">
													<span id="project_life"><%=task.getProject_life() == null?"/" : task.getProject_life()%></span>
												</td>
											</tr>
											<tr class="table1_tr2">
												<td class="table1_tr2_td1">
													项目诊断      </br>
													报告周期：
												</td>
												<td class="table1_tr2_td2">
													<span id="project_report_peried"> <%=task.getProject_report_peried() == null?"/" : task.getProject_report_peried()%></span>
												</td>
											</tr>
											<tr class="table1_tr3">
												<td class="table1_tr3_td1">
													项目情况：
												</td>
												<td class="table1_tr3_td2">
													<span id="project_case"><%=pCaseArray[task.getProject_case()]%></span>
												</td>
											</tr>
											<tr class="table1_tr4">
												<td class="table1_tr4_td1">
													销售阶段：
												</td>
												<td class="table1_tr4_td2">
													<span><%=stageArray[task.getStage()]%></span>
												</td>
											</tr>
											<tr class="table1_tr5">
												<td class="table1_tr5_td1">
													工程类型：
												</td>
												<td class="table1_tr5_td2">
													<span><%=pTypeArray[task.getProject_type()]%></span>
												</td>
											</tr>
										<%} %>




									</table>
									<table class="td2_table2">
										<tr class="table2_tr1">
											<td class="table2_tr1_td1">
												用户名称
											</td>
											<td class="table2_tr1_td2">
												<span><%=task.getCustomer()%></span>
											</td>
										</tr>
										<tr class="table2_tr2">
											<td class="table2_tr2_td1">
												用户联系人
											</td>
											<td class="table2_tr2_td2">
												<%
													for (Linkman linkman : linkmanList1) {
												%>
												<span><%="姓名：" + linkman.getLinkman()%></span>&nbsp&nbsp
												<span><%="电话：" + linkman.getPhone()%></span>
												<br />
												<%
													}
												%>
											</td>
										</tr>
										<%if (!"1".equals(task.getIs_new_data())) { %>
											<tr class="table2_tr3">
												<td class="table2_tr3_td1">
													发票接收人
												</td>
												<td class="table2_tr3_td2">
													<%
														for (Linkman linkman : linkmanList2) {
													%>
													<span><%="姓名：" + linkman.getLinkman()%></span>&nbsp&nbsp
													<span><%="电话：" + linkman.getPhone()%></span>
													<br />
													<%
														}
													%>
												</td>
											</tr>
										<% } %>


										<tr class="table2_tr4">
											<td class="table2_tr4_td1">
												设备联系人
											</td>
											<td class="table2_tr4_td2">
												<%
													for (Linkman linkman : linkmanList3) {
												%>
												<span><%="姓名：" + linkman.getLinkman()%></span>&nbsp&nbsp
												<span><%="电话：" + linkman.getPhone()%></span>
												<br />
												<%
													}
												%>

											</td>
										</tr>
										<tr class="table2_tr5">
											<td class="table2_tr5_td1">
												要求发货时间
											</td>
											<td class="table2_tr5_td2">
												<span><%=task.getDelivery_timestr()%></span>
											</td>
										</tr>
										<tr class="table2_tr1">
											<td class="table2_tr1_td1">
												发货地址
											</td>
											<td class="table2_tr1_td2">
												<span><%=task.getAddress()%></span>
											</td>
										</tr>
										<%if ("1".equals(task.getIs_new_data())) {%>
											<tr class="table2_tr1">
												<td class="table2_tr1_td1">
													收货人
												</td>
												<td class="table2_tr1_td2">
													<span><%=task.getConsignee()%></span>
												</td>
											</tr>
										<% } %>

										<tr class="table2_tr6">
											<td class="table2_tr6_td1">
												项目说明及
												<br />
												特殊要求
											</td>
											<td class="table2_tr6_td2">
												<%
													if (task.getInspection() == 0) {
												%>
												<div>
													1.要求施工前现场开箱验货
												</div>
												<%
													}
												%>
												<%
													if (task.getVerify() == 0) {
												%>
												<span><%=2 - task.getInspection() - task.getVerify()%>.发货前需和销售经理确认
												</span>
												<%
													}
												%>
												<div>
													<%=task.getDescription().replaceAll("\n", "<br/>")%>
												</div>
											</td>
										</tr>
										<tr class="table2_tr7">
											<td class="table2_tr7_td1">
												供货清单
											</td>
											<td class="table2_tr7_td2">
												<%
													for (File_path file_path : fpathList1) {
												%>
												<div>
												<a class="img_a" href="javascript:void()"
													onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%></a>
												</div>
												<%
													}
												%>
												<div class="state_add">
													<div class="submit_div" onclick="downTaskFile(1)">下载</div>
												</div>

											</td>
										</tr>
										<tr class="table2_tr8">
											<td class="table2_tr8_td1">
												移交项目中心
												<br />
												技术附件
											</td>
											<td class="table2_tr8_td2">
												<%
													if (task.getProtocol() == 0) {
														for (File_path file_path : fpathList2) {
												%>
												<div>
													<a class="img_a" href="javascript:void()"
														onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%></a>
												</div>
												<%
														}
													}
												%>

												<%=task.getOther().length() > 0?"<span>其他："+ task.getOther().replaceAll("\n", "<br/>")+"</span>":"" %>
												<div class="state_add">
													<div class="submit_div" onclick="downTaskFile(2)">下载</div>
												</div>

											</td>
										</tr>
										<tr class="table2_tr9">
											<td class="table2_tr9_td1">
												备注
												<br />
												<br />
												<div style="font: 11px/15px 'SimSun';">
													( 注：修改简单信息请用备注，无需重新审核 )
												</div>
											</td>
											<td class="table2_tr9_td2">
											<!--startprint0-->
												<%
													if (task.getCreate_id() == mUser.getId()) {
												%>
													<textarea id="remarks" name="remarks" placeholder="此处输入备注"
														required="required" maxlength="2000"><%=task.getRemarks() != null ? task.getRemarks():""%></textarea>
													<input style="clear:right" type="button" onclick="alertRemarks();" value="保存"></br>
												<h7>&nbsp;</h7>
													<%
														if(fpathList6!=null && fpathList6.size()!=0){
															for (File_path file_path : fpathList6) {
													%>
													<div class="state_div">
														<span>
															<%=DateTrans.transitionDate(file_path.getCreate_time())%>
														</span>
													</div>
													<div>
														<a class="img_a" href="javascript:void()"
														   onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%>
														</a>
													</div>
													<%
															}
														}
													%>

													<div id="section4" class="div_file_right_div">
														<input type="file" name="file_list" id="file_input6"
															   multiple="multiple">
													</div>
													<div class="state_add">
														<div class="save_div" style="display:none">添加附件</div>
														<div class="submit_div" onclick="saveTaskFile6()">保存</div>
														<div class="submit_div" onclick="downTaskFile(6)">下载</div>
													</div>
												<%
													} else {
												%>
													<%=task.getRemarks() != null ? task.getRemarks().replaceAll("\n", "<br/>") : ""%>
													<%
														if(fpathList6!=null && fpathList6.size()!=0){
															for (File_path file_path : fpathList6) {
													%>
														<div class="state_div">
															<span>
																<%=DateTrans.transitionDate(file_path.getCreate_time())%>
															</span>
														</div>
														<div>
															<a class="img_a" href="javascript:void()"
															   onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%>
															</a>
														</div>
													<%
															}
													%>
														<div class="state_add">
															<div class="submit_div" onclick="downTaskFile(6)">下载</div>
														</div>
													<%
														}
													%>


												<%
													}
												%>
												<!--endprint0-->
											</td>
										</tr>
										<%if ( fpathList4.size() != 0 || fpathList5.size() != 0) { %>
											<tr>
												<td class="table2_tr7_td1">
													<span class="star"></span>项目材料配置单</br>
													<div style="font: 11px/15px 'SimSun';">
														1、材料配置单</br>
														2、特殊选型说明文档</br>
														3、配置单更改凭据
													</div>
												</td>
												<td class="table2_tr7_td2">
													<%
														for (File_path file_path : fpathList4) {
													%>
													<div class="state_div">
														<span>
															<%=DateTrans.transitionDate(file_path.getCreate_time())%>
														</span>
													</div>
													<div>
														<a class="img_a" href="javascript:void()"
														   onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%></a>
													</div>
													<%
														}
													%>
													<%if(addTaskFile){ %>
														<div id="section4" class="div_file_right_div">
															<input type="file" name="file_list" id="file_input4"
																   multiple="multiple">
														</div>
														<div class="state_add">
															<div class="save_div" style="display:none">添加附件</div>
															<div class="submit_div" onclick="saveTaskFile4()">保存</div>
															<div class="submit_div" onclick="downTaskFile(4)">下载</div>
														</div>
													<%} else if (fpathList4.size()!=0){%>
														<div class="state_add">
															<div class="submit_div" onclick="downTaskFile(4)">下载</div>
														</div>
													<%}%>
<%--													<div class="state_add">--%>
<%--														<div class="submit_div" onclick="downTaskFile(4)">下载</div>--%>
<%--													</div>--%>

												</td>
											</tr>
											<tr>
												<td class="table2_tr7_td1">
													<span class="star"></span>出厂图纸</br>
													<div style="font: 11px/15px 'SimSun';">
														1、结构件图纸</br>
														2、接线图纸（电气图纸）</br>
														3、数据流量容量计算表
													</div>
												</td>
												<td class="table2_tr7_td2">
													<%
														for (File_path file_path : fpathList5) {
													%>
													<div class="state_div">
														<span>
															<%=DateTrans.transitionDate(file_path.getCreate_time())%>
														</span>
													</div>
													<div>
														<a class="img_a" href="javascript:void()"
														   onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%></a>
													</div>
													<%
														}
													%>
													<%if(addTaskFile){ %>
														<div id="section4" class="div_file_right_div">
															<input type="file" name="file_list" id="file_input5"
																   multiple="multiple">
														</div>
														<div class="state_add">
															<div class="save_div" style="display:none">添加附件</div>
															<div class="submit_div" onclick="saveTaskFile5()">保存</div>
															<div class="submit_div" onclick="downTaskFile(5)">下载</div>
														</div>
													<%} else if (fpathList5.size()!=0){%>
														<div class="state_add">
															<div class="submit_div" onclick="downTaskFile(5)">下载</div>
														</div>
													<%}%>
<%--													<div class="state_add">--%>
<%--														<div class="submit_div" onclick="downTaskFile(5)">下载</div>--%>
<%--													</div>--%>

												</td>
											</tr>
										<% } %>

<%--										<%if(watchFile&&fpathList3.size()!=0){ %>--%>
										<%if(fpathList3.size()!=0){ %>
											<tr class="table2_tr15">
												<td class="table2_tr15_td1">
													项目材料配置单
													<br />
													<div style="font: 11px/15px 'SimSun';">
														( 注：以最新上传为准 )
													</div>
												</td>
												<td class="table2_tr15_td2">
													<%
														for (File_path file_path : fpathList3) {
													%>
													<div class="state_div">
														<span>
															<%=DateTrans.transitionDate(file_path.getCreate_time())%>
														</span>
													</div>
													<div>
														<a class="img_a" href="javascript:void()"
														   onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%></a>
													</div>
													<%
														}
													%>
													<%if(addTaskFile){ %>
														<div id="section4" class="div_file_right_div">
															<input type="file" name="file_list" id="file_input3"
																multiple="multiple">
														</div>
														<div class="state_add">
															<div class="save_div" style="display:none">添加附件</div>
															<div class="submit_div" onclick="saveTaskFile()">保存</div>
															<div class="submit_div" onclick="downTaskFile(3)">下载</div>
														</div>
													<%} else if (fpathList3.size()!=0){%>
														<div class="state_add">
															<div class="submit_div" onclick="downTaskFile(3)">下载</div>
														</div>
													<%}%>
												</td>
											</tr>
										<%} %>
									</table>


									<%
										int reasonLen = reasonList.size();
										for (int i = 0; i < reasonLen; i++) {
											Flow reasonFlow = reasonList.get(i);int reasonOperation=reasonFlow.getOperation();
									%>
										<table class="td2_table3">
											<tr>
												<td class="td2_table3_left">
													<%=reasonFlow.getReason().replaceAll("\n\r","<br/>").replaceAll("\r\n","<br/>").replaceAll("\n","<br/>").replaceAll("\r","<br/>")%>
												</td>
												<td class="td2_table3_right">
												<%if(reasonOperation ==0||reasonOperation ==12){ %>
													<div class="td2_div5_bottom_noimg">
												<%}else if(reasonOperation<9||reasonOperation==13||reasonOperation==17||reasonOperation==19||reasonOperation==21||reasonOperation==24||reasonOperation==26){ %>
												<div class="td2_div5_bottom_agree">
												<%}else{ %>
												<div class="td2_div5_bottom_disagree">
												<% }%>
														<div style="height: 15px;"></div>
														<div class="td2_div5_bottom_right1"><%=reasonFlow.getUsername()%></div>
														<div class="td2_div5_bottom_right2"><%=reasonFlow.getCreate_date()%></div>
													</div>
												</td>
											</tr>
										</table>
									<%
										}
									%>

									<!--endprint1-->
								</div>
								
								<c:if test="${canApprove||(mUser.id==task.create_id&&operation!=12)||operation==27||operation==20||operation==22}">
									<textarea name="reason" class="div_testarea"
									placeholder="请输入意见或建议" required="required" maxlength="500"
									onkeydown="if(event.keyCode==32) return false"></textarea>
								</c:if>

								<%
									if (doTaskFile && !(hasPermission && project_category!=5 && product_type != 10 && (operation == 18 || operation == 13 || operation == 27|| operation == 20|| operation == 22))) {
								%>
									<table class="td2_table5">
										<tr>
											<td class="table5_td1">
												<span class="star">*</span>项目材料配置单
											</td>
											<td class="table5_td2">
												<%
													for (File_path file_path : fpathList3) {
												%>
													<div id="file_div<%=file_path.getId()%>">
														<a class="img_a" href="javascript:void()"
														   onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%></a>
														[
														<a class="img_a" href="javascript:void(0);"
														   onclick="delFile(<%=file_path.getId()%>,'<%=file_path.getFile_name()%>')">删除</a>]
													</div>
												<%
													}
												%>
												<div id="section5" class="section-white5">
													<input type="file" name="file_list" id="file_input3"
														   multiple="multiple">
												</div>
											</td>
										</tr>
									</table>
								<%
									}
								%>


								<%
//									if (hasPermission && (doTaskFile || operation == 27|| operation == 20|| operation == 22)) {
									if (hasPermission && project_category!=5 && product_type != 10 && (operation == 18 || operation == 13 || operation == 27|| operation == 20|| operation == 22)) {
								%>

									<table class="td2_table5">
										<tr>
											<td class="table5_td1">
												<span class="star">*</span>项目材料配置单</br>
												<div style="font: 11px/15px 'SimSun';">
													1、材料配置单</br>
													2、特殊选型说明文档</br>
													3、配置单更改凭据
												</div>
											</td>
											<td class="table5_td2">
												<%
													for (File_path file_path : fpathList4) {
												%>
													<div id="file_div<%=file_path.getId()%>">
														<a class="img_a" href="javascript:void()"
															onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%></a>
														[
														<a class="img_a" href="javascript:void(0);"
															onclick="delFile(<%=file_path.getId()%>,'<%=file_path.getFile_name()%>')">删除</a>]
													</div>
												<%
													}
												%>
												<div id="section4" class="section-white5">
													<input type="file" name="file_list" id="file_input4"
														   multiple="multiple">
												</div>
											</td>
										</tr>
										<tr>
											<td class="table5_td1">
												<span class="star">*</span>出厂图纸</br>
												<div style="font: 11px/15px 'SimSun';">
													1、结构件图纸</br>
													2、接线图纸（电气图纸）</br>
													3、数据流量容量计算表
												</div>
											</td>
											<td class="table5_td2">
												<%
													for (File_path file_path : fpathList5) {
												%>
													<div id="file_div<%=file_path.getId()%>">
														<a class="img_a" href="javascript:void()"
														   onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%></a>
														[
														<a class="img_a" href="javascript:void(0);"
														   onclick="delFile(<%=file_path.getId()%>,'<%=file_path.getFile_name()%>')">删除</a>]
													</div>
												<%
													}
												%>
												<div id="section5" class="section-white5">
													<input type="file" name="file_list" id="file_input5"
														   multiple="multiple">
												</div>
											</td>
										</tr>
									</table>
								<%
									}
								%>
								<div class="div_btn">
									<c:if test="${task.create_id == mUser.id&& operation != 5 && operation != 8&& operation != 12&& operation != 23}">
<%--										修改按钮--%>
										<img src="images/alter_flow.png" class="fistbutton"
										onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=13&id=<%=task.getId()%>'">
									</c:if>
									<c:if test="${task.project_category!=5 &&!(task.create_id == mUser.id&& operation != 5 && operation != 8&& operation != 12&& operation != 23)&&hasPermission && operation != 5 && operation != 8&& operation != 12&& operation != 23 && (operation == 27|| operation == 20|| operation == 22)}">
										<%--工程设计修改按钮--%>
										<img src="images/alter_flow.png" class="fistbutton" onclick="verifyFlow(2)">
									</c:if>
									<c:if test="${mUser.id==task.create_id&&operation!=12}">
<%--										撤销按钮--%>
										<img src="images/delete_travel.png" class="btn_agree" onclick="cancleTask(0)">
									</c:if>
									<c:if test="${canApprove}">
<%--										同意按钮--%>
										<img src="images/agree_flow.png" class="btn_agree" onclick="verifyFlow(0);">
										<c:if test="${operation ==1||operation ==2||operation==13||operation==17||operation==19||operation==21||operation==24||operation==26}">
<%--											不同意按钮--%>
											<img src="images/disagree_flow.png" class="btn_disagree" onclick="verifyFlow(1);">
										</c:if>
									</c:if>
									<c:if test="${task.isedited == 1}">
										<%--对比按钮--%>
										<a href="FlowManagerServlet?type=flowdetail&flowtype=16&id=<%=task_id%>"
										target="_blank"><img src="images/contrast.png" class="btn_disagree"> </a>
									</c:if>
									<c:if test="${operation==5 || operation== 8|| operation== 23}">
<%--										打印按钮--%>
										<img src="images/print.jpg" class="btn_agree" onclick="preview();">
									</c:if>
									<c:if test="${operation==12&&task.create_id==mUser.id}">
<%--										恢复按钮--%>
										<img src="images/recover.png" class="btn_agree" onclick="cancleTask(1);">
									</c:if>
								</div>
							</div>
						</form>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>