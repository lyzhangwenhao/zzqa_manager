<%@page import="com.zzqa.service.interfaces.purchase_note.Purchase_noteManager"%>
<%@page import="com.zzqa.pojo.purchase_note.Purchase_note"%>
<%@page import="com.zzqa.pojo.operation.Operation"%>
<%@page import="com.zzqa.pojo.product_info.Product_info"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page
	import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page
	import="com.zzqa.service.interfaces.product_info.Product_infoManager"%>
<%@page import="com.zzqa.pojo.product_info.Product_info"%>
<%@page
	import="com.zzqa.service.interfaces.file_path.File_pathManager"%>
<%@page import="com.zzqa.pojo.file_path.File_path"%>
<%@page
	import="com.zzqa.service.interfaces.purchase_contract.Purchase_contractManager"%>
<%@page import="com.zzqa.pojo.purchase_contract.Purchase_contract"%>
<%@page
	import="com.zzqa.service.interfaces.purchase_note.Purchase_noteManager"%>
<%@page import="com.zzqa.pojo.purchase_note.Purchase_note"%>
<%@page
	import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%@page
	import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
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
	Position_userManager position_userManager = (Position_userManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("position_userManager");
	Product_infoManager product_infoManager= (Product_infoManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("product_infoManager");
	Purchase_contractManager purchase_contractManager= (Purchase_contractManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("purchase_contractManager");
	Purchase_noteManager purchase_noteManager= (Purchase_noteManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("purchase_noteManager");
	File_pathManager file_pathManager= (File_pathManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("file_pathManager");
	FlowManager flowManager= (FlowManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("flowManager");
	PermissionsManager permissionsManager=(PermissionsManager)WebApplicationContextUtils
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
	if (session.getAttribute("purchase_id") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int purchase_id = (Integer) session.getAttribute("purchase_id");
	Purchase_contract purchase_contract=purchase_contractManager.getPurchase_contractByID(purchase_id);
	if(purchase_contract==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	Flow flow=flowManager.getNewFlowByFID(12, purchase_id);
	List<Flow> reasonList=flowManager.getReasonList(12, purchase_id);
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy/M/d HH:mm:ss");
	Map<String, String> drawMap= purchase_contractManager.getPurchaseFlowForDraw(purchase_contract,flow);
	int operation=flow.getOperation();
	boolean canApply=purchase_contractManager.checkCanApply(purchase_contract, mUser, operation);
	boolean canBuy=purchase_contractManager.checkCanBuy(purchase_contract, mUser, operation);
	//判断是否可撤销
	Flow flow11=flowManager.getFlowByOperation(12, purchase_id, 11);
	boolean isDeling=false;//正在撤销或已撤销，不可修改
	if(flow11!=null){
		isDeling=true;
	}
	int applyNum=purchase_contractManager.getPurchaseApplyNum(purchase_contract);
	//产品已购数量不包含当前的(流程未结束的)采购合同所采购的数量,若为审批完成后又修改了且此时还没审批结束，contract_num中记录已采购数量
	boolean applyFinished=operation==10||operation==12||operation==13
		||operation==4&&applyNum==2||operation==6&&applyNum==3||operation==8&&applyNum>3;
	List<Purchase_note> noteList=purchase_noteManager.getPurchase_notesByPID(purchase_id,applyFinished);
	pageContext.setAttribute("mUser", mUser);
	pageContext.setAttribute("canApply", canApply);
	pageContext.setAttribute("showBuyInfo", operation==10||operation==12||operation==13);
	pageContext.setAttribute("canBuy", canBuy);
	pageContext.setAttribute("checkAog", (operation==12)&&permissionsManager.checkPermission(mUser.getPosition_id(), 119));
	pageContext.setAttribute("store", (operation==13)&&permissionsManager.checkPermission(mUser.getPosition_id(), 120));
	pageContext.setAttribute("drawMap", drawMap);
	pageContext.setAttribute("purchase_contract", purchase_contract);
	pageContext.setAttribute("operation",operation);
	pageContext.setAttribute("applyFinished",applyFinished);
	pageContext.setAttribute("reasonList", reasonList);
	pageContext.setAttribute("isDeling", isDeling);
	request.setAttribute("noteList", noteList);
	pageContext.setAttribute("flow_titlename1", purchase_contract.getType()==1?"正常采购":"备货采购");
	pageContext.setAttribute("today",new SimpleDateFormat("yyyy/M/d").format(System.currentTimeMillis()));
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>采购合同</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/top.css">
<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
<link rel="stylesheet" type="text/css" href="css/purchaseflow.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
<link rel="stylesheet" href="css/bootstrap/bootstrap.min.css">
<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/modernizr.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/vendor/tabcomplete.min.js"></script>
<script src="js/vendor/livefilter.min.js"></script>
<script src="js/vendor/src/bootstrap-select.js"></script>
<script src="js/vendor/src/filterlist.js"></script>
<script src="js/plugins.js"></script>

<script  type="text/javascript" src="js/jquery-ui.min.js"></script>
<script  type="text/javascript" src="js/dialog.js"></script>
<script  type="text/javascript" src="js/public.js"></script>
<script type="text/javascript" src="js/showdate2.js"></script>
<script type="text/javascript" src="js/purchase.js"></script>
<!--[if IE]>
	<script src="js/html5shiv.min.js" type="text/javascript"></script>
<![endif]-->
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
	var flag=0;
	var showBuyInfo=${showBuyInfo};
	var checkAog=${checkAog};
	$(function(){
		var operation=${operation};
		var isDeling=${isDeling};
		setContractState(isDeling,operation,${applyFinished});
		syncDIVHeight();
		if(${purchase_contract.type}==1){
			initTR(3);
		}else{
			initTR(5);
		}
		checkCover();
	});
	function verifyFlow(isagree){
		if($(".div_testarea").val().replace(/[ ]/g, "").length==0){
			initdiglog2("提示信息","请输入意见或建议");
			return;
		}
		document.flowform.isagree.value=isagree;
		document.flowform.submit();
	}
	/* 检查验货信息填写 */
	function checkCover(){
		if(checkSave()){
			$("#saveInfo").attr("src","images/save.png").bind("click",saveInfo);
			$("#saveInfo").css("cursor","pointer");
			if(isFinish()){
				$("#check_finished").attr("src","images/check_finished.png").bind("click",check_finished);
				$("#check_finished").css("cursor","pointer");
			}else{
				$("#check_finished").attr("src","images/check_finished_disabled.png").unbind("click");
				$("#check_finished").css("cursor","default");
			}
		}else{
			$("#saveInfo").attr("src","images/save_disabled.png").unbind("click");
			$("#saveInfo").css("cursor","default");
			$("#check_finished").attr("src","images/check_finished_disabled.png").unbind("click");
			$("#check_finished").css("cursor","default");
		}
	}
	//检查是否填完
	function isFinish(){
		var finished=true;
		$(".product_tab").find("tr:gt(0)").each(function(){
			var num=$(this).find("td.aog_num").text().trim();
			var aog_date=$(this).find("td.aog_date").text().trim();
			if(aog_date.length<1||num.length<1){
				finished=false;
				return false;
			}
		});
		return finished;
	}
	//检查是否有值，有值时显示保存按钮
	function checkSave(){
		var save=false;
		$(".product_tab").find("tr:gt(0)").each(function(){
			var num=$(this).find("td.aog_num").text().trim();
			var aog_date=$(this).find("td.aog_date").text().trim();
			if(aog_date.length>0||num.length>0){
				save=true;
				return false;
			}
		});
		return save;
	}
	function saveInfo(){
		var aogInfos="";
		$(".product_tab").find("tr:gt(0)").each(function(){
			var num=$(this).find("td.aog_num").text().trim();
			var aog_date=$(this).find("td.aog_date").text().trim();
			aog_date=aog_date.length>0?timeTransStrToLong2(aog_date):0;
			num=num.length>0?num:0;
			aogInfos+="い"+$(this).attr("id")+"の"+aog_date+"の"+num;
		});
		aogInfos=aogInfos.replace("い","");
		$.ajax({
			type:"post",//post方法
			url:"ContractManagerServlet",
			data:{"type":"purchase","isagree":1,"aogInfos":aogInfos,"operation":${operation}},
			timeout : 15000, 
			dataType:'json',
			success:function(returnData){
				initdiglog2("提示信息","保存成功！");					
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
	function check_finished(){
		var aogInfos="";
		var errorCode=0;//0 可以 1：实际入库时间空2：入库数量空3：数量不对
		$(".product_tab").find("tr:gt(0)").each(function(){
			var num=$(this).find("td.aog_num").text().trim();
			var aog_date=$(this).find("td.aog_date").text().trim();
			if(aog_date.length==0){
				errorCode=1;
				return false;
			}
			if(num.length==0){
				errorCode=2;
				return false;
			}
			if(num!=$(this).find("td.num").text().trim()){
				errorCode=3;
			}
			aog_date=aog_date.length>0?timeTransStrToLong2(aog_date):0;
			num=num.length>0?num:0;
			aogInfos+="い"+$(this).attr("id")+"の"+timeTransStrToLong2(aog_date)+"の"+num;
		});
		if(errorCode==1){
			initdiglog2("提示信息","请输入实际入库时间");
			return;
		}else if(errorCode==2){
			initdiglog2("提示信息","请输入实际入库数量");
			return;
		}else if(errorCode==3){
			initdiglogtwo2("提示信息","系统检测到有产品的实际入库数量与采购数量不符合，确定已检查无误？");
	   		$( "#confirm2" ).click(function() {
	   			$( "#twobtndialog" ).dialog( "close" );
	   			aogInfos=aogInfos.replace("い","");
	   			document.flowform.aogInfos.value=aogInfos;
	   			document.flowform.isagree.value=0;
	   			document.flowform.submit();
	   		});
			return;
		}else{
			aogInfos=aogInfos.replace("い","");
			document.flowform.aogInfos.value=aogInfos;
			document.flowform.isagree.value=0;
			document.flowform.submit();
		}
	}
	function deletePurchase(op){
		initdiglogtwo2("提示信息",(op==10?"该采购合同已完成，撤销需要重新审批。":"")+"你确定要撤销该采购合同吗？");
   		$( "#confirm2" ).click(function() {
   			$( "#twobtndialog" ).dialog( "close" );
   			if(op!=10||$(".div_testarea").val().replace(/[ ]/g, "").length>0){
   				document.flowform.type.value="deletePurchase";
   				document.flowform.submit();
			}else{
				initdiglog2("提示信息","请输入撤销原因");
				return;
			}
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
				<td class="table_center_td2_notfull">
				<div class='<c:out value="${drawMap.title1_flow}"></c:out>'>
						<div class='<c:out value="${drawMap.color1}"></c:out>'><c:out value="${flow_titlename1}"></c:out></div>
						<div class='<c:out value="${drawMap.color2}"></c:out>'>商务审核</div>
						<div class='<c:out value="${drawMap.color3}"></c:out>'>部门经理审核</div>
						<div class='<c:out value="${drawMap.color4}"></c:out>'>运营总监审核</div>
						<div class='<c:out value="${drawMap.color5}"></c:out>'>总经理审核</div>
						<div class='<c:out value="${drawMap.color6}"></c:out>'>采购</div>
						<div class='<c:out value="${drawMap.color7}"></c:out>'>验货</div>
						<div class='<c:out value="${drawMap.color8}"></c:out>'><c:out value='${operation==14?"已撤销":"已入库"}'></c:out></div>
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
						<div class='<c:out value="${drawMap.bg_color7}"></c:out>'></div>
						<img src="images/<c:out value="${drawMap.img8}"></c:out>">
					</div>
					<div class='<c:out value="${drawMap.title3_flow}"></c:out>'>
						<div><c:out value="${drawMap.time1}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time2}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time3}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time4}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time5}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time6}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time7}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time8}" escapeXml="false"></c:out></div>
					</div>
				<form action="ContractManagerServlet"
						method="post" name="flowform">
							<input type="hidden" name="isagree">
							<input type="hidden" name="operation" value="${operation}">
							<input type="hidden" name="type" value="purchase">
							<input type="hidden" name="aogInfos">
					<span class="span_title">基本信息：</span>
							<div class="td2_div2">
						<div class="div2_name">
							<span>供应商名称：</span>
							<div id="div2_name_select" style="top:0">
							${purchase_contract.company_name2}
							</div>
						</div>
						<div class="div2_name">
							<span>合同编号：</span>
							<div style="top:0">${purchase_contract.contract_no}</div>
						</div>
						<div class="div2_time">
							<span>签订时间：</span>
							<div><c:out value="${purchase_contract.sign_date}"></c:out></div>
							<span>合同状态：</span>
							<div></div>
						</div>
					</div>
					<c:if test="${purchase_contract.type==1}">
							<div class="td2_div3">
								<span>采购单：</span>
							</div>
							<table class="product_tab" id="apply_tab2">
								<tr class="product_tr1">
									<td style="width:30px;">序号</td>
									<td>销售合同</td>
									<td>客户名称</td>
									<td>项目名称</td>
									<td>物料编码</td>
									<td>型号</td>
									<td>产品描述</td>
									<td>数量</td>
									<td>预计含税成本</td>
									<td>含税单价</td>
									<td style="width: 70px;">交货期</td>
									<td>备注</td>
									<td>不含税单价</td>
									<td>含税金额</td>
									<td>不含税金额</td>
									<c:if test="${showBuyInfo}">
									<td style="width:70px">实际入库时间</td>
									<td>实际入库数量</td>
									</c:if>
								</tr>
								<c:forEach items="${noteList}" var="apply_note">
								<tr  id="${apply_note.id}" title='${apply_note.hasbuy_num>0?"已采购数量":""}${apply_note.hasbuy_num>0?apply_note.hasbuy_num:""}'>
									<td style="width:30px;"></td>
									<td id='<c:out value="${apply_note.sales_id}"></c:out>' class="tooltip_div"><c:out value="${apply_note.contract_no}"></c:out></td>
									<td class="tooltip_div"><c:out value="${apply_note.customer}"></c:out></td>
									<td class="tooltip_div"><c:out value="${apply_note.project_name}"></c:out></td>
									<td class="tooltip_div"><c:out value="${apply_note.materials_id}"></c:out></td>
									<td id='<c:out value="${apply_note.m_id}"></c:out>' class="tooltip_div"><c:out value="${apply_note.model}"></c:out></td>
									<td class="tooltip_div"><c:out value="${apply_note.materials_remark}"></c:out></td>
									<td class="tooltip_div num" style="width:60px"><c:out value="${apply_note.num}"></c:out></td>
									<td class="tooltip_div"><c:out value="${apply_note.predict_costing_taxes_str}"></c:out></td>
									<td class="tooltip_div"><c:out value="${apply_note.unit_price_taxes_str}"></c:out></td>
									<td><c:out value="${apply_note.delivery_date}"></c:out></td>
									<td class="tooltip_div"><c:out value="${apply_note.remark}"></c:out></td>
									<td class="tooltip_div"></td>
									<td class="tooltip_div"></td>
									<td class="tooltip_div"></td>
									<c:if test="${showBuyInfo}">
									<td class="tooltip_div aog_date">
									${apply_note.aog_date}
									</td>
									<td class="tooltip_div aog_num">
									${apply_note.aog_num>0?apply_note.aog_num:""}
									</td>
									</c:if>
								</tr>
								</c:forEach>
							</table>
							</c:if>
							<c:if test="${purchase_contract.type==2}">
							<div class="td2_div3">
								<span>备货采购：</span>
							</div>
							<table class="product_tab" id="purchase_tab">
								<tr class="product_tr1">
									<td style="width:30px;">序号</td>
									<td>物料编码</td>
									<td>型号</td>
									<td>产品描述</td>
									<td>数量</td>
									<td>预估成本</td>
									<td>含税单价</td>
									<td style="width: 70px;">交货期</td>
									<td>备注</td>
									<td>不含税单价</td>
									<td>含税金额</td>
									<td>不含税金额</td>
									<c:if test="${showBuyInfo}">
									<td style="width:70px">实际入库时间</td>
									<td>实际入库数量</td>
									</c:if>
								</tr>
								<c:forEach items="${noteList}" var="stockup_note">
								<tr id="${stockup_note.id}" title='${stockup_note.hasbuy_num>0?"已采购数量":""}${stockup_note.hasbuy_num>0?stockup_note.hasbuy_num:""}'>
									<td style="width:30px;"></td>
									<td class="tooltip_div"><c:out value="${stockup_note.materials_id}"></c:out></td>
									<td id='<c:out value="${stockup_note.m_id}"></c:out>' class="tooltip_div"><c:out value="${stockup_note.model}"></c:out></td>
									<td class="tooltip_div"><c:out value="${stockup_note.materials_remark}"></c:out></td>
									<td class="tooltip_div num" style="width:60px"><c:out value="${stockup_note.num}"></c:out></td>
									<td class="tooltip_div"><c:out value="${stockup_note.predict_costing_taxes_str}"></c:out></td>
									<td class="tooltip_div"><c:out value="${stockup_note.unit_price_taxes_str}"></c:out></td>
									<td><c:out value="${stockup_note.delivery_date}"></c:out></td>
									<td class="tooltip_div"><c:out value="${stockup_note.remark}"></c:out></td>
									<td class="tooltip_div"></td>
									<td class="tooltip_div"></td>
									<td class="tooltip_div"></td>
									<c:if test="${showBuyInfo}">
									<td class="tooltip_div aog_date">
									${stockup_note.aog_date}
									</td>
									<td class="tooltip_div aog_num">
									${stockup_note.aog_num>0?stockup_note.aog_num:""}
									</td>
									</c:if>
								</tr>
								</c:forEach>
							</table>
							</c:if>
							<span class="span_title">付款方式：</span>
							<c:if test="${purchase_contract.moxa>0}">
							<div class="td2_div4" style="text-align:left;"><c:out value='${purchase_contract.moxa==1?"预付":"不预付"}'></c:out></div>
							</c:if>
							<div class="td2_div4_address"><c:out value="${purchase_contract.payment_value}"></c:out></div>
							<span class="span_title">到货时间/地点：</span>
							<div class="td2_div5"><c:out value="${purchase_contract.aog_time_address}"></c:out></div>
							<div class="td2_div5_linkman">联系人：<c:out value="${purchase_contract.linkman}"></c:out></div>
						<span class="span_title">验收标准：</span>
						<div class="td2_div6">质保期为：<c:out value="${purchase_contract.checkout_time}"></c:out>年</div>
						<div class="td2_div9">
							<div>
								<div class="td2_div9_top">甲&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;方</div>
								<div class="td2_div9_name"><span>单位名称（章）：</span><div><c:out value="${purchase_contract.company_name1}"></c:out></div></div>
								<div class="td2_div9_address"><span>单位地址：</span><div><c:out value="${purchase_contract.company_address1}"></c:out></div></div>
								<div class="td2_div9_postalcode"><span>邮政编码：</span><div><c:out value="${purchase_contract.postal_code1}"></c:out></div></div>
								<div class="td2_div9_person"><span>法定代表人：</span><div><c:out value="${purchase_contract.law_person1}"></c:out></div><span>委托代理人：</span><div><c:out value="${purchase_contract.entrusted_agent1}"></c:out></div></div>
								<div class="td2_div9_phone"><span>电 话：</span><div><c:out value="${purchase_contract.phone1}"></c:out></div><span>传 真：</span><div><c:out value="${purchase_contract.fax1}"></c:out></div></div>
								<div class="td2_div9_bank"><span>开户行：</span><div><c:out value="${purchase_contract.bank1}"></c:out></div></div>
								<div class="td2_div9_accoun"><span>公司账号：</span><div><c:out value="${purchase_contract.company_account1}"></c:out></div></div>
								<div class="td2_div9_tariffitem"><span>税 号：</span><div><c:out value="${purchase_contract.tariff_item1}"></c:out></div></div>
							</div>
							<div>
								<div class="td2_div9_top">乙&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;方</div>
								<div class="td2_div9_name"><span>单位名称（章）：</span><div><c:out value="${purchase_contract.company_name2}"></c:out></div></div>
								<div class="td2_div9_address"><span>单位地址：</span><div><c:out value="${purchase_contract.company_address2}"></c:out></div></div>
								<div class="td2_div9_postalcode"><span>邮政编码：</span><div><c:out value="${purchase_contract.postal_code2}"></c:out></div></div>
								<div class="td2_div9_person"><span>法定代表人：</span><div><c:out value="${purchase_contract.law_person2}"></c:out></div><span>委托代理人：</span><div><c:out value="${purchase_contract.entrusted_agent2}"></c:out></div></div>
								<div class="td2_div9_phone"><span>电 话：</span><div><c:out value="${purchase_contract.phone2}"></c:out></div><span>传 真：</span><div><c:out value="${purchase_contract.fax2}"></c:out></div></div>
								<div class="td2_div9_bank"><span>开户行：</span><div><c:out value="${purchase_contract.bank2}"></c:out></div></div>
								<div class="td2_div9_accoun"><span>公司账号：</span><div><c:out value="${purchase_contract.company_account2}"></c:out></div></div>
								<div class="td2_div9_tariffitem"><span>税 号：</span><div><c:out value="${purchase_contract.tariff_item2}"></c:out></div></div>
							</div>
						</div>
							<c:if test="${reasonList!= null && fn:length(reasonList) >0}">
							<div class="approve_div">
								<div>领导审批</div>
								<table class="td2_table3">
								<c:forEach items="${reasonList}" var="reasonFlow">
									<tr>
									<td class="td2_table3_left">
										<c:out value="${reasonFlow.reason}" escapeXml="false"></c:out>
									</td>
									<td class="td2_table3_right">
									<c:choose>
									   <c:when test="${reasonFlow.operation==2||reasonFlow.operation==4||reasonFlow.operation==6||reasonFlow.operation==8}">
									   <div class="td2_div5_bottom_agree">
									   </c:when>
									   <c:when test="${reasonFlow.operation==3||reasonFlow.operation==5||reasonFlow.operation==7||reasonFlow.operation==9}">
									   <div class="td2_div5_bottom_disagree">
									   </c:when>
									   <c:otherwise>
									   <div class="td2_div5_bottom_noimg">
									   </c:otherwise>
									</c:choose>
											<div style="height: 15px;"></div>
											<div class="td2_div5_bottom_right1"><c:out value="${reasonFlow.username}"></c:out></div>
											<div class="td2_div5_bottom_right2"><c:out value="${reasonFlow.create_date}"></c:out></div>
										</div>
									</td>
								</tr>
								</c:forEach>
							</table>
							</div>
							</c:if>
							<c:if test="${canApply||(mUser.id==purchase_contract.create_id&&!isDeling)}">
							<textarea name="reason" class="div_testarea" placeholder="请输入意见或建议" required="required" maxlength="500"></textarea>
							</c:if>
							<div class="div_btn">
								<c:if test="${mUser.id==purchase_contract.create_id&&!isDeling}">
									<a href="javascript:void(0)" class="btn_agree" onclick="deletePurchase(<c:out value='${operation}'></c:out>);"><img src="images/delete_travel.png"></a>
									<a href="flowmanager/update_purchaseflow.jsp" class="btn_agree"><img src="images/alter_flow.png"></a>
								</c:if>
								<a href="flowmanager/preview_purchase_contract.jsp" class="btn_agree" target="_blank"><img src="images/contract_preview.png"></a>
								<c:if test="${canApply}">
									<img src="images/agree_flow.png" class="btn_agree" onclick="verifyFlow(0);">
									<c:if test="${operation==1||operation==2||operation==4||operation==6||operation==8}">
										<img src="images/disagree_flow.png" class="btn_disagree" onclick="verifyFlow(1);">
									</c:if>
								</c:if>
								<c:if test="${checkAog}">
									<img src="images/check_finished_disabled.png" class="btn_disagree" id="check_finished" >
									<img src="images/save_disabled.png" class="btn_disagree" id="saveInfo">
								</c:if>
								<c:if test="${canBuy}">
									<img src="images/confirm.png" class="btn_disagree" onclick="document.flowform.submit();">
								</c:if>
								<c:if test="${store}">
									<img src="images/putin.png" class="btn_disagree" onclick="document.flowform.submit();">
								</c:if>
							</div>
					</form>
					
				</td>
			</tr>
		</table>
	</div>
	<c:if test="${purchase_contract.type==1}">
	<div class="dialog_product" id="dialog_apply3">
		<div class="product_top"><span>序号：</span><span></span></div>
		<div class="product_div product_model" ><span>销售合同：</span>
				<div></div>
			</div>
			<div class="product_div product_model" ><span>型号：</span>
				<div></div>
			</div>
		<div class="product_div"><span>数量：</span><div></div></div>
		<div class="product_div"><span>预计含税成本：</span><div></div></div>
		<div class="product_div"><span>含税单价：</span><div></div></div>
		<div class=product_div><span>交货期：</span><div></div></div>
		<div class="product_div"><span>备注：</span><textarea id="dialog_remark" readonly="readonly"></textarea></div>
		<c:if test="${showBuyInfo}">
		<div class="product_div"><span>实际入库时间：</span><c:if test="${checkAog}"><input type="text" readonly="readonly" style="width:100px;" id="aog_time" onclick="return Calendar('aog_time');"  ></c:if><c:if test="${!checkAog}"><div id="aog_time"></div></c:if></div>
		<div class="product_div"><span>实际入库数量：</span><c:if test="${checkAog}"><input type="text" maxlength="8" id="aog_num" oninput="checkIntPosition(this,true)"></c:if><c:if test="${!checkAog}"><div id="aog_num"></div></c:if></div>
		</c:if>
		<div class="product_bottom">
		<img src="images/cancle_materials.png" onclick="closeApplyDialog3(0)">
		<c:if test="${checkAog}">
			<img src="images/submit_materials.png" onclick="closeApplyDialog3(2)">
		</c:if>
		</div>
	</div>
	</c:if>
	<c:if test="${purchase_contract.type==2}">
		<div class="dialog_product" id="dialog_purchase2">
			<div class="product_div product_model" ><span>型号：</span>
				<div></div>
			</div>
			<div class="product_div"><span>数量：</span><div></div></div>
			<div class="product_div"><span>预计含税成本：</span><div></div></div>
			<div class="product_div"><span>含税单价：</span><div></div></div>
			<div class=product_div><span>交货期：</span><div></div></div>
			<div class="product_div"><span>备注：</span><textarea id="dialog_remark"></textarea></div>
			<c:if test="${showBuyInfo}">
			<div class="product_div"><span>实际入库时间：</span><c:if test="${checkAog}"><input type="text" readonly="readonly" style="width:100px;" id="aog_time" onclick="return Calendar('aog_time');"  ></c:if><c:if test="${!checkAog}"><div id="aog_time"></div></c:if></div>
			<div class="product_div"><span>实际入库数量：</span><c:if test="${checkAog}"><input type="text" maxlength="8" id="aog_num" oninput="checkIntPosition(this,true)"></c:if><c:if test="${!checkAog}"><div id="aog_num"></div></c:if></div>
			</c:if>
			<div class="product_bottom">
			<img src="images/cancle_materials.png" onclick="closePurchaseDialog2(0)">
			<c:if test="${checkAog}">
			<img src="images/submit_materials.png" onclick="closePurchaseDialog2(2)">
			</c:if>
			</div>
		</div>
	</c:if>
</body>
</html>
