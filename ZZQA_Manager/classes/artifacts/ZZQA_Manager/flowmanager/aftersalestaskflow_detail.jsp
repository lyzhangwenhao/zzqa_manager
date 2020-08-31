<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page import="com.zzqa.service.interfaces.file_path.File_pathManager"%>
<%@page import="com.zzqa.pojo.file_path.File_path"%>
<%@page import="com.zzqa.service.interfaces.aftersales_task.Aftersales_taskManager"%>
<%@page import="com.zzqa.pojo.aftersales_task.Aftersales_task"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%
	request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	PermissionsManager permissionsManager=(PermissionsManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("permissionsManager");
	Aftersales_taskManager aftersales_taskManager=(Aftersales_taskManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("aftersales_taskManager");
	FlowManager flowManager=(FlowManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("flowManager");
	File_pathManager file_pathManager=(File_pathManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("file_pathManager");
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
	if (session.getAttribute("aftersales_tid") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int aftersales_tid = (Integer) session.getAttribute("aftersales_tid");
	Aftersales_task aftersales_task=aftersales_taskManager.getAlterSales_TaskByID(aftersales_tid);
	if(aftersales_task==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	Flow flow=flowManager.getNewFlowByFID(13, aftersales_tid);
	int operation=flow.getOperation();
	Map<String, String> drawMap = aftersales_taskManager.getTaskFlowForDraw(aftersales_task, flow);
	List<Flow> reasonList=flowManager.getReasonList(13, aftersales_tid);
	List<HashMap<String,Object>> mapList=new ArrayList<HashMap<String,Object>>();
	String reason_alter=null;
	for(Flow reasonFlow:reasonList){
		int opera=reasonFlow.getOperation();
		String reason=reasonFlow.getReason();
		HashMap file_map=new HashMap();
		file_map.put("operation", opera);
		file_map.put("reason", reason);
		file_map.put("username", reasonFlow.getUsername());
		file_map.put("flow_date", reasonFlow.getCreate_date());
		file_map.put("reason",reasonFlow.getReason());
		if(opera==4||opera==6||opera==5||opera==10){
			List<File_path> files=file_pathManager.getAllFileByCondition(13, reasonFlow.getId(), 0, 1);
			file_map.put("files", files);
		}
		mapList.add(file_map);
		if(operation==4){
			if(opera==4){
				reason_alter=reason;
			}
		}else if(operation==6||operation==8){
			if(opera==6){
				reason_alter=reason;
			}
		}
	}
	List<File_path> fileList4=new ArrayList<File_path>();
	Flow newflow=flowManager.getFlowByOperation(13, aftersales_tid, 4);
	if(newflow!=null){
		fileList4=file_pathManager.getAllFileByCondition(13, newflow.getId(), 1, 1);
	}
	List<File_path> fileList6=new ArrayList<File_path>();
	newflow=flowManager.getFlowByOperation(13, aftersales_tid, 6);
	if(newflow!=null){
		fileList6=file_pathManager.getAllFileByCondition(13, newflow.getId(), 1, 1);
	}
	newflow=flowManager.getFlowByOperation(13, aftersales_tid, 5);
	List<File_path> fileList5=new ArrayList<File_path>();
	if(newflow!=null){
		fileList5=file_pathManager.getAllFileByCondition(13, newflow.getId(), 1, 1);
	}
	List<File_path> file_paths=file_pathManager.getAllFileByCondition(13, aftersales_tid, 1, 0);
	String[] pCategoryArray=DataUtil.getPCategoryArray();
	String[] productTypeArray=DataUtil.getProductTypeArray();
	String[] pCaseArray=DataUtil.getPCaseArray();
	boolean canApply=aftersales_taskManager.checkCanApply(aftersales_task, mUser, operation);
	boolean canAlter=mUser.getId()==aftersales_task.getCreate_id()&&(operation==1||operation==3);
	boolean canDel=mUser.getId()==aftersales_task.getCreate_id()&&(operation<5||operation==10);
	boolean canConfirm=mUser.getId()==aftersales_task.getCreate_id()&&(operation==4||operation==10);
	boolean canCancel=mUser.getId()==aftersales_task.getCreate_id()&&(operation==5);//撤回
	int assistantPID=DataUtil.getAfterSaleAssistantArray()[aftersales_task.getProject_category()];
	boolean canAddFile=permissionsManager.checkPermission(mUser.getPosition_id(), assistantPID)&&(operation==2||operation==4||operation==5||operation==6||operation==8);
	pageContext.setAttribute("pCategoryArray", pCategoryArray);
	pageContext.setAttribute("productTypeArray", productTypeArray);
	pageContext.setAttribute("pCaseArray", pCaseArray);
	pageContext.setAttribute("aftersales_task", aftersales_task);
	pageContext.setAttribute("mUser", mUser);
	pageContext.setAttribute("drawMap", drawMap);
	pageContext.setAttribute("operation", operation);
	pageContext.setAttribute("mapList", mapList);
	pageContext.setAttribute("fileList4", fileList4);
	pageContext.setAttribute("fileList5", fileList5);
	pageContext.setAttribute("fileList6", fileList6);
	pageContext.setAttribute("file_paths", file_paths);
	pageContext.setAttribute("canApply", canApply);
	pageContext.setAttribute("canAlter", canAlter);
	pageContext.setAttribute("canConfirm", canConfirm);//字段附件
	pageContext.setAttribute("canAddFile", canAddFile);//助理添加修改附件
	pageContext.setAttribute("canDel", canDel);
	pageContext.setAttribute("canCancel", canCancel);
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>售后任务单</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/top.css">
<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
<link rel="stylesheet" type="text/css" href="css/aftersalestaskflow.css">
<link rel="stylesheet" type="text/css" href="css/custom.css">
<link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
<link rel="stylesheet" type="text/css" href="css/default.css">
<link rel="stylesheet" type="text/css"
	href="css/jquery.filer-dragdropbox-theme.css">
<script src="js/showdate1.js" type="text/javascript"></script>
<script src="js/prettify.js" type="text/javascript"></script>
<script  type="text/javascript" src="js/jquery.min.js"></script>
<script src="js/jquery.filer.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
<script  type="text/javascript" src="js/jquery-ui.min.js"></script>
<script  type="text/javascript" src="js/dialog.js"></script>
<script  type="text/javascript" src="js/public.js"></script>
<script type="text/javascript" src="js/aftersales_task.js"></script>
<!-- 选将input加载到body再由custom.js渲染 -->
<script src="js/custom.js" type="text/javascript"></script>
<!--[if IE]>
	<script src="js/html5shiv.min.js" type="text/javascript"></script>
<![endif]-->
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
	var operation=<%=operation%>;
	var reason1="<%=reason_alter%>";//助理备注
	var reason2='';//诊断部分
	var file_num=0;
	$(function(){
		if(operation==2||operation==4){
			file_num=<%=fileList4.size()%>;
		}else if(operation==5||operation==6||operation==8){
			file_num=<%=fileList6.size()%>;
		}
		if(<%=canAddFile%>){
			if(operation==4||operation==6||operation==8){
				$("#alter_file1").css("display","none");
				$("#alter_file1 .div_file_list").attr("class","div_file_list2");
				$("#addfile").css("display","none");//保存按钮
				$("#canclefile").css("display","none");
			}
			if(operation==2||operation==5){
				$("#canclefile").css("display","none");
			}
		}
	});
	function returnPre(){
		initdiglogtwo2("提示信息","返回上一步，附件需要重新上传！");
   		$( "#confirm2" ).click(function() {
   			$( "#twobtndialog" ).dialog( "close" );
   			document.flowform.type.value="canaelAfterSalesTask";
			document.flowform.submit();
   		});
	}
	//flag 1:显示修改相关；2：添加
	function showFile_alter(flag){
		if(flag==1){
			reason2=$(".div_testarea").val();
			$(".div_testarea").val(reason1);
			$("#alter_file_btn").css("display","none");
			$("#addfile").css("display","inline-block");
			$("#alter_file1").css("display","block");
			$("#alter_file2").css("display","none");
			$("#alter_file1 .div_file_list2").attr("class","div_file_list");
			$("#alter_file2 .div_file_list").attr("class","div_file_list2");
			$("#confirm").css("display","none");
			$("#hangup").css("display","none");
			$("#canclefile").css("display","inline-block");
		}else{
			reason1=$(".div_testarea").val();
			$(".div_testarea").val(reason2);
			$("#alter_file_btn").css("display","inline-block");
			$("#addfile").css("display","none");
			$("#alter_file1").css("display","none");
			$("#alter_file2").css("display","inline-block");
			$("#alter_file1 .div_file_list").attr("class","div_file_list2");
			$("#alter_file2 .div_file_list2").attr("class","div_file_list");
			$("#confirm").css("display","inline-block");
			$("#hangup").css("display","inline-block");
			$("#canclefile").css("display","none");
		}
	}
	//撤销
	function deleteAfterSalesTask(op){
		initdiglogtwo2("提示信息","你确定要撤销该售后任务单吗？");
   		$( "#confirm2" ).click(function() {
   			$( "#twobtndialog" ).dialog( "close" );
   			if($(".div_testarea").val().replace(/[ ]/g, "").length>0){
   				document.flowform.type.value="deleteAfterSalesTask";
   				document.flowform.submit();
			}else{
				initdiglog2("提示信息","请输入撤销原因");
				return;
			}
   		});
	}
	function verifyFlow(flag){
		document.flowform.addfile.value="2";
		document.flowform.isagree.value=flag;
		if($(".div_testarea").val().replace(/[ ]/g, "").length==0){
			initdiglog2("提示信息","请输入意见或建议");
			return;
		}
		document.flowform.submit();
	}
	function addFile(){
		document.flowform.addfile.value="0";
		if($(".alter_file").css("display")=="none"){
			$(".alter_file").css("display","block");
			$("#alter_file_btn").remove();
		}
		if(successUploadFileNum1==0&&file_num==0){
			initdiglog2("提示信息","请上传附件");
			return;
		}
		if($(".div_testarea").val().replace(/[ ]/g, "").length==0){
			initdiglog2("提示信息","请输入意见或建议");
			return;
		}
		document.flowform.submit();
	}
	function confirmFlow(flag){
		document.flowform.addfile.value=flag;
		if($(".div_testarea").val().replace(/[ ]/g, "").length==0){
			initdiglog2("提示信息","请输入意见或建议");
			return;
		}
		document.flowform.submit();
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
				<td class="table_center_td2_notfull">
				<div class='<c:out value="${drawMap.title1_flow}"></c:out>'>
						<div class='<c:out value="${drawMap.color1}"></c:out>'><br/>新建</div>
						<div class='<c:out value="${drawMap.color2}"></c:out>'>现场服务<br/>负责人审批</div>
						<div class='<c:out value="${drawMap.color3}"></c:out>'>现场服务<br/>助理确认</div>
						<div class='<c:out value="${drawMap.color4}"></c:out>'>任务完成<br/>情况确认</div>
						<div class='<c:out value="${drawMap.color5}"></c:out>'><br/>上传任务记录</div>
						<div class='<c:out value="${drawMap.color6}"></c:out>'>任务完成情况<br/>审批</div>
						<div class='<c:out value="${drawMap.color7}"></c:out>'><br/><c:out value='${operation==9?"已撤销":"结束"}'></c:out></div>
					</div>
					<div class='<c:out value="${drawMap.title2_flow}"></c:out>'>
						<img src="images/<c:out value="${drawMap.img1}"></c:out>">
						<div class='<c:out value="${drawMap.bg_color1}"></c:out>'></div>
						<img src="images/<c:out value="${drawMap.img2}"></c:out>">
						<div class='<c:out value="${drawMap.bg_color2}"></c:out>'></div>
						<img src="images/<c:out value="${drawMap.img3}"></c:out>">
						<div class='<c:out value="${drawMap.bg_color3}"></c:out>'></div>
						<img src="images/<c:out value="${drawMap.img4}"></c:out>">
						<div class='<c:out value="${drawMap.bg_color4}"></c:out>'></div>
						<img src="images/<c:out value="${drawMap.img5}"></c:out>">
						<div class='<c:out value="${drawMap.bg_color5}"></c:out>'></div>
						<img src="images/<c:out value="${drawMap.img6}"></c:out>">
						<div class='<c:out value="${drawMap.bg_color6}"></c:out>'></div>
						<img src="images/<c:out value="${drawMap.img7}"></c:out>">
					</div>
					<div class='<c:out value="${drawMap.title3_flow}"></c:out>'>
						<div><c:out value="${drawMap.time1}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time2}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time3}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time4}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time5}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time6}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time7}" escapeXml="false"></c:out></div>
					</div>
				<form
						action="NewFlowServlet"
						method="post" name="flowform">
						<input type="hidden" name="type" value="aftersales_task">
						<input type="hidden" name="file_time" value="<%=System.currentTimeMillis() %>">
						<input type="hidden" name="operation" value="<%=operation %>">
						<input type="hidden" name="delFileIDs" value=""><%--被删除文件的id  格式：の1の2の3の4の5の --%>
						<input type="hidden" name="addfile" value="1"><%--0：鉴别修改文件 1：确认 2：审批--%>
						<input type="hidden" name="isagree" value="1">
				<div class="td2_div0">
					<div class="td2_div1">售后任务单</div>
					<div class="div_dashed"></div>
					<div class="td2_div2">
						<div class="div_ptype">
							<div>
								<span>项目类型：</span>
								<div>
									<c:out value='${pCategoryArray[aftersales_task.project_category]}'></c:out>
								</div>
							</div>
							<div>
								<span>产品类型：</span>
								<div>
									<c:out value='${productTypeArray[aftersales_task.product_type]}'></c:out>
								</div>
							</div>
						</div>
						<div class="div_name">
							<span>项目名称：</span>
							<div>
							<c:out value='${aftersales_task.project_name}'></c:out>
							</div>
						</div>
						<div class="div_ptype">
							<div>
								<span>任务单编号：</span>
								<div>
									<c:out value='${aftersales_task.project_id}'></c:out>
								</div>
							</div>
							<div>
								<span>项目情况：</span>
								<div>
									<c:out value='${pCaseArray[aftersales_task.project_case]}'></c:out>
								</div>
							</div>
						</div>
					</div>
					<div class="div_dashed"></div>
					<div class="file_num">附件：（<c:out value='${fn:length(file_paths)}'></c:out>个）</div>
					<div class="div_file_list2">
					<c:forEach items="${file_paths}" var="file_path">
					<div class="div_file_item">
						<a href="javascript:void()" onclick="fileDown(<c:out value='${file_path.id}'></c:out>)"><c:out value='${file_path.file_name}'></c:out></a>
					</div>
					</c:forEach>
					</div>
				</div>
				<c:if test="${mapList!= null && fn:length(mapList) >0}">
					<table class="td2_table8">
					<c:forEach items="${mapList}" var="fileMap">
					<tr>
						<td class="td2_table8_left">
							<div>
								<c:out value="${fileMap.reason}" escapeXml="false"></c:out>
							</div>
							<c:if test="${fileMap.files!= null && fn:length(fileMap.files) >0}">
							<c:forEach items="${fileMap.files}" var="file">
							<div>
							<a href="javascript:void(0)" onclick="fileDown(<c:out value='${file.id}'></c:out>)"><c:out value="${file.file_name}"></c:out>&nbsp;&nbsp;<c:out value="${file.create_date}"></c:out></a>
							</div>
							</c:forEach>
							</c:if>
							</div>
						</td>
						<td class="td2_table8_right">
							<c:if test="${fileMap.operation==0}">
									<div class="td2_div5_bottom_noimg">
								</c:if>
								<c:if test="${fileMap.operation==2||fileMap.operation==7}">
									<div class="td2_div5_bottom_agree">
								</c:if>
								<c:if test="${fileMap.operation==3||fileMap.operation==8}">
									<div class="td2_div5_bottom_disagree">
								</c:if>
								<c:if test="${fileMap.operation==4||fileMap.operation==5||fileMap.operation==6}">
									<div class="td2_div5_bottom_confirm">
								</c:if>
								<div style="height: 15px;"></div>
								<div class="td2_div5_bottom_right1"><c:out value="${fileMap.username}"></c:out></div>
								<div class="td2_div5_bottom_right2"><c:out value="${fileMap.flow_date}"></c:out></div>
							</div>
						</td>
					</tr>
					</c:forEach>
					</table>
					</c:if>
				<c:if test="${canDel||canApply||canAddFile||canConfirm || (!canConfirm && operation==10)}">
				<textarea name="reason" class="div_testarea" placeholder="请输入意见或建议" required="required" maxlength="500"></textarea>
				</c:if>
				<c:if test="${canAddFile}">
				<div class="alter_file" id="alter_file1">
				<div class="assistant_files_parent" id="parent1">
					<div class="assistant_files">助理附件：</div>
						<div class="div_file_list">
							<c:if test="${operation==2||operation==4}">
								 <c:forEach items="${fileList4}" var="file4">
								<div id="file_item<c:out value='${file4.id}'></c:out>" class="div_file_item">
									<a href="javascript:void()" onclick="fileDown(<c:out value='${file4.id}'></c:out>)"><c:out value="${file4.file_name}"></c:out></a>
									 <a class="img_a" href="javascript:void(0);" onclick="delFile(<c:out value='${file4.id}'></c:out>,'<c:out value='${file4.file_name}'></c:out>');this.blur();">[删除]</a>
								</div>
								</c:forEach>
							</c:if> 
							<c:if test="${operation==6||operation==8}">
								<c:forEach items="${fileList6}" var="file6">
								<div id="file_item<c:out value='${file6.id}'></c:out>" class="div_file_item">
									<a href="javascript:void()" onclick="fileDown(<c:out value='${file6.id}'></c:out>)"><c:out value='${file6.file_name}'></c:out></a>
									 <a class="img_a" href="javascript:void(0);" onclick="delFile(<c:out value='${file6.id}'></c:out>,'<c:out value='${file6.file_name}'></c:out>');this.blur();">[删除]</a>
								</div>
								</c:forEach>
							</c:if>
						</div>
					</div>
					<div class="div_addfile_div"><div class="div_addfile"  onclick="$('#contract_file_div .jFiler-input').click()">添加附件</div></div>
				</div>
				</c:if>
				<c:if test="${canConfirm || (!canConfirm && operation==10)}">
				<div class="alter_file" id="alter_file2">
					<div class="assistant_files_parent" id="parent2">
						<div class="assistant_files">完成确认附件：</div>
						<div class="div_file_list">
							<c:if test="${operation==5}">
								<c:forEach items="${fileList5}" var="file5">
								<div id="file_item<c:out value='${file5.id}'></c:out>" class="div_file_item">
									<a href="javascript:void()" onclick="fileDown(<c:out value='${file5.id}'></c:out>)"><c:out value='${file5.file_name}'></c:out></a>
									 <a class="img_a" href="javascript:void(0);" onclick="delFile2(<c:out value='${file5.id}'></c:out>,'<c:out value='${file5.file_name}'></c:out>');this.blur();">[删除]</a>
								</div>
								</c:forEach>
							</c:if>
						</div>
					</div>
					<div class="div_addfile_div"><div class="div_addfile"  onclick="$('#contract_file_div2 .jFiler-input').click()">添加附件</div></div>
				</div>
				</c:if>
				</form>
				<div class="btn_group ">
					<c:if test="${canDel}">
						<div class="div_disagree" onclick="deleteAfterSalesTask(<c:out value='${operation}'></c:out>);">撤销</div>
					</c:if>
					<c:if test="${canCancel}">
						<div class="div_disagree" onclick="returnPre()" >撤回</div>
					</c:if>
					<c:if test="${canAlter}">
						<div class="div_agree" onclick="window.location.href='<%=basePath%>flowmanager/update_aftersalestaskflow.jsp'">修改</div>
					</c:if>
					<c:if test="${(canAddFile&&(operation==4||operation==6||operation==8))}">
						<div class="div_agree"  id="alter_file_btn" onclick="showFile_alter(1);">修改附件</div>
					</c:if>
					<c:if test="${canAddFile}">
						<div class="div_agree"  id="addfile" onclick="addFile()" >助理确认</div>
						<div class="div_agree"  id="canclefile" onclick="showFile_alter(2)" >取消</div>
					</c:if>
					<c:if test="${canConfirm}">
						<div class="div_agree"  id="confirm" onclick="confirmFlow(1)">完成确认</div>
						<c:if test="${operation==4}">
						<div class="div_disagree"  id="hangup" onclick="confirmFlow(3)">挂起</div>
						</c:if>
					</c:if>
					<c:if test="${!canConfirm && operation==10}">
						<div class="div_agree"  id="confirm" onclick="confirmFlow(2)">完成确认</div>
					</c:if>
					<c:if test="${canApply}">
						<div class="div_agree"  onclick="verifyFlow(0);">同意</div>
						<c:if test="${operation==1||operation==6}">
							<div class="div_disagree" onclick="verifyFlow(1);">不同意</div>
						</c:if>
					</c:if>
				</div>
			</td>
		</tr>
		</table>
		
	</div>
</body>
</html>
