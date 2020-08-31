<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.materials_info.Materials_infoManager"%>
<%@page import="com.zzqa.pojo.materials_info.Materials_info"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	Materials_infoManager materials_infoManager = (Materials_infoManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("materials_infoManager");
	PermissionsManager permissionsManager=(PermissionsManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("permissionsManager");
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
	String keywords="";
	int nowpage=1;
	int pagerow=10;
	if (session.getAttribute("keywords_materials") != null) {
		keywords = (String)session.getAttribute("keywords_materials");
	}else{
		session.setAttribute("keywords_materials", keywords);
	}
	if (session.getAttribute("nowpage_materials") != null) {
		nowpage = (Integer)session.getAttribute("nowpage_materials");
	}else{
		session.setAttribute("nowpage_materials", nowpage);
	}
	if (session.getAttribute("pagerow_materials") != null) {
		pagerow = (Integer)session.getAttribute("pagerow_materials");
	}else{
		session.setAttribute("pagerow_materials", pagerow);
	}
	List<Materials_info> materials_infos=materials_infoManager.getMaterials_infosByCondition(keywords,nowpage,pagerow);
	int num=materials_infoManager.getNumByCondition(keywords);
	int allpage=(num%pagerow==0?0:1)+num/pagerow;
	boolean permission66=permissionsManager.checkPermission(mUser.getPosition_id(), 66);
	pageContext.setAttribute("allpage", allpage);
	pageContext.setAttribute("pagerow", pagerow);
	pageContext.setAttribute("nowpage", nowpage);
	pageContext.setAttribute("keywords", keywords);
	pageContext.setAttribute("mUser", mUser);
	pageContext.setAttribute("materials_infos", materials_infos);
	pageContext.setAttribute("permission66", permission66);
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>物料信息表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="rendere" content="webkit|ie-comp|ie-stand">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/statistical.css">
		<link rel="stylesheet" type="text/css" href="css/materials_report.css">
		<link rel="stylesheet" type="text/css" href="css/custom.css">
		<link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-filer.css">
		<link rel="stylesheet" type="text/css" href="css/default.css">
		<link rel="stylesheet" type="text/css"
			href="css/jquery.filer-dragdropbox-theme.css">
		<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/prettify.js"></script>
		<script type="text/javascript" src="js/jquery.filer.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		<!-- 现将隐藏的文件上传控件添加到body中，再渲染 -->
		<script type="text/javascript" src="js/custom1.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
		$(function(){
			<%if(!permission66){%>
			$(".dialog_materials input").attr("readonly",true);
			<%}%>
		});
		var nowpage=<%=nowpage%>;
		var nowFlow="material_report";
		function showUserDialog(id){
			nowID=id;
			if( id>0){
				//详情
				var tr=$("#tr"+id);
				var materials_id=tr.children("td:eq(0)").text().trim();
				var model=tr.children("td:eq(1)").text().trim();
				var remark=tr.children("td:eq(2)").text().trim();
				var unit=tr.children("td:eq(3)").text().trim();
				if($(".materials_top").length==0){
					$(".dialog_materials").prepend('<div class="materials_top"><span>序号</span><span>'+materials_id+'</span></div>');
				}else{
					$(".materials_top span:eq(1)").text(materials_id);
				}
				<%if(permission66){ %>
				$(".materials_bottom").html('<img src="images/cancle_materials.png" onclick="closeDialog(0)"><img src="images/submit_materials.png" onclick="closeDialog(2)"><img src="images/del_materials.png" id="delmaterials" onclick="closeDialog(1)">');
				<%}else{%>
				$(".materials_bottom").html('<img src="images/cancle_materials.png" onclick="closeDialog(0)">');
				<%}%>
				$(".materials_id input").val(materials_id);
				$(".materials_model input").val(model);
				$(".materials_remark input").val(remark);
				$(".materials_unit input").val(unit);
			}else{
				//添加
				$(".materials_top").remove();
				$("#delmaterials").remove();
			}
			if($(".dialog_materials_bg").length==0){
				$("body").append('<div class="dialog_materials_bg"></div>');
			}
			$(".dialog_materials_bg").css("display","block");
			$(".dialog_materials").css("display","block");
		}
		var nowID=0;//选中的id
		function closeDialog(btn_id){
			if(btn_id==1){
				//删除
				initdiglogtwo2("提示信息","你确定要删除该物料吗？");
		   		$( "#confirm2" ).click(function() {
					$( "#twobtndialog" ).dialog( "close" );
					delMaterials();
				});
			}else if(btn_id==2){
				if(nowID==0){
					addMaterials();
				}else{
					alterMaterials();
				}
			}else{//取消
				$(".dialog_materials_bg").css("display","none");
				$(".dialog_materials").css("display","none");
				initDialogVal();
			}
		}
		function initDialogVal(){
			$(".dialog_materials input").val("");
		}
		function delMaterials(){
			$.ajax({
				type:"post",//post方法
				url:"DeviceServlet",
				data:{"type":"checkDelMaterials","m_id":nowID},
				timeout : 15000, 
				//ajax成功的回调函数
				success:function(returnData){
					if(returnData==0){
						document.operaform.type.value="delmaterials";
						document.operaform.id.value=nowID;
						document.operaform.keywords.value=$("#keywords_materials").val();
						document.operaform.submit();
					}else{
						//已被绑定
						initdiglog2("提示信息","该物料已被绑定，无法删除");
						return;
					}
				},
				complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
					if(status!='success'){//超时,status还有success,error等值的情况
						if(status=='timeout'){
							initdiglog2("提示信息","请求超时！");
						}else{
							initdiglog2("提示信息","操作异常,请重试！");
						}
					}
				}
			});
		}
		function addMaterials(){
			var materials_id=$(".materials_id input").val();
			if(materials_id.trim().length==0){
				initdiglog2("提示信息","请输入物料编号");
				return;
			}
			var model=$(".materials_model input").val();
			if(model.trim().length==0){
				initdiglog2("提示信息","请输入型号");
				return;
			}
			var remark=$(".materials_remark input").val();
			var unit=$(".materials_unit input").val();
			$.ajax({
				type:"post",//post方法
				url:"DeviceServlet",
				data:{"type":"checkmaterials","model":model},
				timeout : 15000, 
				//ajax成功的回调函数
				success:function(returnData){
					if(returnData==0){
						document.operaform.type.value="addmaterial";
						document.operaform.materials_id.value=materials_id;
						document.operaform.model.value=model;
						document.operaform.remark.value=remark;
						document.operaform.unit.value=unit;
						document.operaform.keywords.value=$("#keywords_materials").val();
						document.operaform.submit();
					}else{
						//型号已存在
						initdiglog2("提示信息","型号已存在");
						return;
					}
				},
				complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
					if(status!='success'){//超时,status还有success,error等值的情况
						if(status=='timeout'){
							initdiglog2("提示信息","请求超时！");
						}else{
							initdiglog2("提示信息","操作异常,请重试！");
						}
					}
				}
			});
		}
		function alterMaterials(){
			var materials_id=$(".materials_id input").val();
			if(materials_id.trim().length==0){
				initdiglog2("提示信息","请输入物料编号");
				return;
			}
			var model=$(".materials_model input").val();
			if(model.trim().length==0){
				initdiglog2("提示信息","请输入型号");
				return;
			}
			var remark=$(".materials_remark input").val();
			var unit=$(".materials_unit input").val();
			$.ajax({
				type:"post",//post方法
				url:"DeviceServlet",
				data:{"type":"checkmaterials","model":model},
				timeout : 15000, 
				//ajax成功的回调函数
				success:function(returnData){
					if(returnData==nowID||returnData==0){
						document.operaform.type.value="altermaterial";
						document.operaform.materials_id.value=materials_id;
						document.operaform.model.value=model;
						document.operaform.remark.value=remark;
						document.operaform.unit.value=unit;
						document.operaform.id.value=nowID;
						document.operaform.keywords.value=$("#keywords_materials").val();
						document.operaform.submit();
					}else{
						//型号已存在
						initdiglog2("提示信息","型号重复");
						return;
					}
				},
				complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
					if(status!='success'){//超时,status还有success,error等值的情况
						if(status=='timeout'){
							initdiglog2("提示信息","请求超时！");
						}else{
							initdiglog2("提示信息","操作异常,请重试！");
						}
					}
				}
			});
		}
		function pageBegin(){
			document.filterform.nowpage.value=1;
			materialsFilter();
		}
		function pageUP(){
			if(<%=nowpage > 1%>){
				document.filterform.nowpage.value=<%=nowpage%>-1;
				materialsFilter();
			}else{
				initdiglog2("提示信息","已经是首页！");
			}
		}
		function pageDown(){
			if(<%=nowpage < allpage%>){
				document.filterform.nowpage.value=<%=nowpage%>+1;
				materialsFilter();
			}else{
				initdiglog2("提示信息","已经是最后一页！");
			}
		}
		function pageLast(){
			document.filterform.nowpage.value=<%=allpage%>;
			materialsFilter();
		}
		function materialsFilter(){
			document.filterform.submit();
		}
		 $(function(){
			 $("#keywords_materials").keydown(function(e){
				if(e.keyCode==13){
					searchMaterial();
				}
			});
		 });
		function searchMaterial(){
			document.filterform.nowpage.value=1;
			materialsFilter();
		}
		//导入成功，刷新页面
		function doNext(){
			window.location.reload();
		}
		</script>
	</head>

	<body onload="">
		<jsp:include page="/top.jsp" >
	<jsp:param name="name" value="<%=mUser.getName() %>" />
	<jsp:param name="level" value="<%=mUser.getLevel() %>" />
	<jsp:param name="index" value="2" />
	</jsp:include>
		<div class="td1_device">
			<form action="DeviceServlet?type=materialsfilter" method="post"
				name="filterform">
				<input type="text" style="display:none">
				<input type="hidden" name="nowpage">
				<div class="td1_div3">
					物料信息表
				</div>
				<div class="td1_div4">
					<img title="添加" src="images/add_materials.png" id="addMaterials" 
						onclick="showUserDialog(0);" class="addMaterials" <%if(!permission66){ %>style="position:relative;z-index:-1"<%} %>>
					<%if(permission66){ %>
					<img title="导入表格" src="images/import_materials.png" onclick="$('#exportExcel_div .jFiler-input').click();" class="importMaterials">
					<%}%>
					<img title="导出表格" src="images/export_track.png" id="img_export" onclick="loadDownMaterials();" class="exportMaterials">
					<img title="搜索" src="images/user_search.gif" id="searchMaterials" 
						onclick="searchMaterial();" class="searchMaterials">
					<input type="text" name="keywords_materials" id="keywords_materials"  maxlength="30" placeholder="" value="<%=keywords%>" 
						onkeydown="if(event.keyCode==32) return false">
				</div>
				<table class="device_tab">
					<tr class="tab_tr1">
						<td class="tab_tr1_td1" style="width:150px">
							物料编码
						</td>
						<td class="tab_tr1_td2" >
							型号
						</td>
						<td class="tab_tr1_td3" >
							产品描述
						</td>
						<td class="tab_tr1_td3" >
							单位
						</td>
					</tr>
					<c:forEach items="${materials_infos}" varStatus="status" var="materials_info">
					<tr id="tr<c:out value="${materials_info.id}"></c:out>" class="tab_tr2 tr_pointer" onclick="showUserDialog(<c:out value="${materials_info.id}"></c:out>);">
						<td class="tab_tr1_td1 tooltip_div">
							<c:out value="${materials_info.materials_id}"></c:out>
						</td>
						<td class="tab_tr1_td2 tooltip_div" >
							<c:out value="${materials_info.model}"></c:out>
						</td>
						<td class="tab_tr1_td3 tooltip_div" >
							<c:out value="${materials_info.remark}"></c:out>
						</td>
						<td class="tab_tr1_td3 tooltip_div" >
							<c:out value="${materials_info.unit}"></c:out>
						</td>
					</tr>
					</c:forEach>
				</table>
				<div class="td2_div5">
					<c:if test="${nowpage <2}">
						<span class="span_nomal">首页</span>
						<span class="span_nomal">&lt;</span>
					</c:if>
					<c:if test="${nowpage> 1}">
						<span class="span_press" onclick="pageBegin();">首页</span>
						<span class="span_press" onclick="pageUP();">&lt;</span>
					</c:if>
					<span class="span_page"><c:out value="${allpage==0?0:nowpage}"></c:out>/<c:out value="${allpage}"></c:out></span>
					<c:if test="${allpage < 2 || nowpage == allpage}">
						<span class="span_nomal">&gt;</span>
						<span class="span_nomal">尾页</span>
					</c:if>
					<c:if test="${allpage >1&&nowpage != allpage}">
						<span class="span_press" onclick="pageDown();">&gt;</span>
						<span class="span_press" onclick="pageLast();">尾页</span>
					</c:if>
				</div>
			</form>
			<form action="DeviceServlet?" method="post"
				name="operaform">
				<input type="hidden" name="type">
				<input type="hidden" name="keywords">
				<input type="hidden" name="id">
				<input type="hidden" name="materials_id">
				<input type="hidden" name="model">
				<input type="hidden" name="remark">
				<input type="hidden" name="unit">
			</form>
		</div>
		<div class="dialog_materials">
			<div class="materials_id"><div><span class="star">*</span>物料编号</div><input type="text" maxlength="100"></div>
			<div class="materials_model"><div><span class="star">*</span>型号</div><input type="text" maxlength="100"></div>
			<div class="materials_remark"><div><span class="star">*</span>产品描述</div><input type="text" maxlength="200"></div>
			<div class="materials_unit"><div>单位</div><input type="text" maxlength="10"></div>
			<div class="materials_bottom"><img src="images/cancle_materials.png" onclick="closeDialog(0)"><img src="images/submit_materials.png" onclick="closeDialog(2)"><img src="images/del_materials.png" id="delmaterials" onclick="closeDialog(1)"></div>
		</div>
	</body>
</html>
