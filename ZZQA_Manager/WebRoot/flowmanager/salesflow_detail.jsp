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
	import="com.zzqa.service.interfaces.sales_contract.Sales_contractManager"%>
<%@page import="com.zzqa.pojo.sales_contract.Sales_contract"%>
<%@page
	import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page
	import="com.zzqa.service.interfaces.purchase_note.Purchase_noteManager"%>
<%@page import="com.zzqa.pojo.purchase_note.Purchase_note"%>
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
	Sales_contractManager sales_contractManager= (Sales_contractManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("sales_contractManager");
	File_pathManager file_pathManager= (File_pathManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("file_pathManager");
	FlowManager flowManager= (FlowManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("flowManager");
	Purchase_noteManager purchase_noteManager=(Purchase_noteManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("purchase_noteManager");
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
	if (session.getAttribute("sales_id") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int sales_id = (Integer) session.getAttribute("sales_id");
	Sales_contract sales_contract=sales_contractManager.getSales_contractByID(sales_id);
	Flow flow=flowManager.getNewFlowByFID(11, sales_id);
	if(flow==null||sales_contract==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	List<Flow> reasonList=flowManager.getReasonList(11, sales_id);
	List<HashMap<String,Object>> mapList=new ArrayList<HashMap<String,Object>>();
	Iterator<Flow> iterator=reasonList.iterator();
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy/M/d HH:mm:ss");
	boolean showTop=false;//判断修改的备注是否显示在合同审批中
	while(iterator.hasNext()){
		Flow flow2=(Flow)iterator.next();
		if(flow2.getOperation()==-1||flow2.getOperation()==0||flow2.getOperation()==2||flow2.getOperation()==3){
			if(flow2.getOperation()==0){
				if(showTop){
					HashMap<String,Object> map=new HashMap<String,Object>();
					map.put("operation", flow2.getOperation());
					map.put("reason", flow2.getReason());
					map.put("username", flow2.getUsername());
					map.put("flow_date", flow2.getCreate_date());
					mapList.add(map);
					iterator.remove();
				}
			}else{
				HashMap<String,Object> map=new HashMap<String,Object>();
				map.put("operation", flow2.getOperation());
				map.put("reason", flow2.getReason());
				map.put("username", flow2.getUsername());
				map.put("flow_date", flow2.getCreate_date());
				List<File_path> files=file_pathManager.getAllFileByCondition(11, flow2.getId(), 1, 1);
				if(files!=null){
					for(File_path file:files){
						file.setCreate_date(sdf.format(file.getCreate_time()));
					}
					map.put("files", files);
				}
				mapList.add(map);
				iterator.remove();
			}
		}
		if(flow2.getOperation()==-1||flow2.getOperation()==3){
			showTop=true;
		}else if(flow2.getOperation()>3){
			showTop=false;
		}
	}
	Map<String, String> drawMap= sales_contractManager.getSalesFlowForDraw(sales_contract,flow);
	List<File_path> file_paths=file_pathManager.getAllFileByCondition(11, sales_id, 1, 0);
	int operation=flow.getOperation();
	List<Product_info> product_infoList=sales_contractManager.getDetailProduct_infos(sales_id);
	int purchaseState=-1;//0：未采购；1：部分采购；2：已采购
	int purchase_allnum=0;//已采购数量
	for(Product_info product_info:product_infoList){
		purchase_allnum+=product_info.getPurchase_num();
		if(product_info.getPurchase_num()>0){
			purchaseState=2;
			if(product_info.getPurchase_num()>=product_info.getNum()){
				if(purchaseState==-1||purchaseState==2){
					purchaseState=2;
				}else{
					purchaseState=1;
				}
			}else{
				purchaseState=1;
			}
		}else{
			if(purchaseState>0){
				purchaseState=1;
			}else{
				purchaseState=0;
			}
		}
	}
	int applyNum=sales_contractManager.getApplyNum(sales_contract);
	boolean applyFinished=operation==12||(operation==6&&applyNum==1)||(operation==8&&applyNum==2)||(operation==10&&applyNum==3);
	if(!applyFinished){
		purchaseState=0;
	}
	boolean canApply=sales_contractManager.checkCanApply(sales_contract, mUser, operation);
	pageContext.setAttribute("purchase_allnum", purchase_allnum);
	pageContext.setAttribute("mUser", mUser);
	pageContext.setAttribute("canApply", canApply);
	pageContext.setAttribute("drawMap", drawMap);
	pageContext.setAttribute("sales_contract", sales_contract);
	pageContext.setAttribute("operation",operation);
	pageContext.setAttribute("mapList", mapList);
	pageContext.setAttribute("file_paths", file_paths);
	pageContext.setAttribute("reasonList", reasonList);
	pageContext.setAttribute("product_infoList", product_infoList);
	String[] payment_valueArray=sales_contract.getPayment_value().split("の");
	for(int i=0;i<payment_valueArray.length;i++){
		pageContext.setAttribute("payment_value"+(i+1), payment_valueArray[i]);
	}
	String[] inspect_timeArray=sales_contract.getInspect_time().split("の");
	for(int i=0;i<inspect_timeArray.length;i++){
		pageContext.setAttribute("inspect_time"+(i+1), inspect_timeArray[i]);
	}
	String[] service_promiseArray=sales_contract.getService_promise().split("の");
	for(int i=0;i<service_promiseArray.length;i++){
		pageContext.setAttribute("service_promise"+(i+1), service_promiseArray[i]);
	}
	//判断是否可撤销
	Flow flow13=flowManager.getFlowByOperation(11, sales_id, 13);
	boolean isDeling=false;//正在撤销或已撤销，不可修改
	if(flow13!=null){
		isDeling=true;
	}
	pageContext.setAttribute("applyFinished", applyFinished);
	pageContext.setAttribute("isDeling", isDeling);
	pageContext.setAttribute("sealManager", sales_contractManager.checkSealManager(sales_contract,mUser,operation));
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>销售合同</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
<link rel="stylesheet" type="text/css" href="css/custom.css">
<link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
<link rel="stylesheet" type="text/css" href="css/default.css">
<link rel="stylesheet" type="text/css"
	href="css/jquery.filer-dragdropbox-theme.css">
<link rel="stylesheet" type="text/css"
	href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/bootstrap/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/top.css">
<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
<link rel="stylesheet" type="text/css" href="css/salesflow_detail.css">
<script src="js/jquery.min.js" type="text/javascript"></script>

<script  type="text/javascript" src="js/jquery-ui.min.js"></script>
<script  type="text/javascript" src="js/dialog.js"></script>
<script  type="text/javascript" src="js/public.js"></script>
<script  type="text/javascript" src="js/contract.js"></script>
<!--[if IE]>
	<script src="js/html5shiv.min.js" type="text/javascript"></script>
<![endif]-->
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
		var flag=0;//隐藏客户合同历史存档
		$(function(){
			$(".td2_table_hide").click(function(){
				hideApprove(flag);
			});
			syncDIVHeight();
			setContractState(<%=isDeling%>,<%=operation%>,<%=purchaseState%>,${applyFinished});
			initTD();
		});
		/***
		  *初始化表格序号 1,2,3。。。，第二行开始， 最大值为tr数减1
		  *计算整单毛利
		  *整单毛利=（不含税金额总和-预估含税成本总和/1.17）/不含税金额总和
		  **/
		function initTD(){
			$(".product_tr2").unbind("click").click(function(){
				showDialog($(this));
			});
			$(".product_tr3").unbind("click").click(function(){
				showDialog($(this));
			});
			//-预估含税成本总和
			var all_pvt=0.0;
			//不含税单价总和
			var all_prices=0.0;
			$(".product_tab tr:gt(0)").each(function(){
				var unit_price_taxes=parseFloat($(this).children("td:eq(5)").text().trim());
				var pvt=parseFloat($(this).children("td:eq(6)").text().trim());
				var num=parseInt($(this).children("td:eq(4)").text().trim());
				all_prices+=unit_price_taxes*num;
				all_pvt+=pvt*num;
				
				var unit_price=unit_price_taxes/1.17;
				var price_taxes=unit_price_taxes*num;
				var price=unit_price_taxes/1.17*num;
				var predict_costing_taxes=parseFloat($(this).children("td:eq(6)").text().trim());
				var unit_gross_profit=Math.round((unit_price_taxes-predict_costing_taxes)/unit_price_taxes*10000)/100+"%";
				//单行毛利=（不含税单价-预估含税成本/1.17）/不含税单价
				$(this).children("td:eq(9)").text(Math.round(unit_price*100)/100);
				$(this).children("td:eq(10)").text(Math.round(price_taxes*100)/100);
				$(this).children("td:eq(11)").text(Math.round(price*100)/100);
				$(this).children("td:eq(12)").text(unit_gross_profit);
			});
			if($(".product_tab tr:gt(0)").length>0){
				//整单毛利=（不含税金额总和-预估含税成本总和/1.17）/不含税金额总和 约掉1.17
				var gross_profit=Math.round((all_prices-all_pvt)/all_prices*10000)/100+"%";
				$("#gross_profit").text(gross_profit);
			}else{
				$("#gross_profit").text("");
			}
		}
		var nowTR;
		function showDialog(jq_tr){
			$("#tooltip_div").remove();
			var top_val=$(window).scrollTop()+150+"px";
			$(".dialog_product ").css("top",top_val);
			if(arguments.length>0){
				nowTR=jq_tr;
				//详情
				var index=jq_tr.children("td:eq(0)").text().trim();
				var materials_model=jq_tr.children("td:eq(3)").text().trim();
				var num=jq_tr.children("td:eq(4)").text().trim();
				var unit_price_taxes=jq_tr.children("td:eq(5)").text().trim();
				var predict_costing_taxes=jq_tr.children("td:eq(6)").text().trim();
				var time=jq_tr.children("td:eq(7)").text().trim();
				var remark=jq_tr.children("td:eq(8)").text().trim();
				if($(".product_top").length==0){
					$(".dialog_product").prepend('<div class="product_top"><span>序号：</span><span>'+index+'</span></div>');
				}else{
					$(".product_top span:eq(1)").text(index);
				}
				//初始化下拉选择框
				$("#index_num").text(materials_model);
				$("#dialog_num").text(num);
				$("#dialog_upt").text(unit_price_taxes);
				$("#dialog_pct").text(predict_costing_taxes);
				$("#dialog_time").text(time);
				$("#dialog_remark").val(remark);
			}
			if($(".dialog_product_bg").length==0){
				$("body").append('<div class="dialog_product_bg"></div>');
			}
			$(".dialog_product_bg").css("display","block");
			$(".dialog_product").css("display","block");
		}
		function closeDialog(btn_id){
			nowTR=null;
			$(".dialog_product_bg").css("display","none");
			$(".dialog_product").css("display","none");
		}
		function verifyFlow(isagree){
			if($(".div_testarea").val().replace(/[ ]/g, "").length==0){
				initdiglog2("提示信息","请输入意见或建议");
				return;
			}
			document.flowform.isagree.value=isagree;
			document.flowform.submit();
		}
		function sealAgree(){
			if($(".div_testarea").val().replace(/[ ]/g, "").length==0){
				initdiglog2("提示信息","请输入意见或建议");
				return;
			}
			document.flowform.submit();
		}
		function hideApprove(){
			if(flag==0){
				$(".td2_table_hide span").text("隐藏客户合同审批");
				$(".td2_table_hide img").attr("src","images/hide_check.png");
				flag=1;
			}else{
				$(".td2_table_hide span").text("显示客户合同审批");
				$(".td2_table_hide img").attr("src","images/show_check.png");
				flag=0;
			}
			$(".td2_table8").toggle();
		}
		function deleteSales(op){
			initdiglogtwo2("提示信息",(op==12?"该销售合同已完成，撤销需要重新审批。":"")+"你确定要撤销该销售合同吗？");
	   		$( "#confirm2" ).click(function() {
	   			$( "#twobtndialog" ).dialog( "close" );
	   			if(op!=12||$(".div_testarea").val().replace(/[ ]/g, "").length>0){
	   				document.flowform.type.value="deleteSales";
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
					<div class='${drawMap.title1_flow}'>
						<div class='${drawMap.color1}'>提交状态单</div>
						<div class='${drawMap.color2}'>客户合同审核</div>
						<div class='${drawMap.color3}'>商务审核</div>
						<div class='${drawMap.color4}'>部门经理审核</div>
						<div class='${drawMap.color5}'>运营总监审核</div>
						<div class='${drawMap.color6}'>总经理审核</div>
						<div class='${drawMap.color7}'>商务盖章</div>
						<div class='${drawMap.color8}'>${operation==13?"已撤销":"完成"}</div>
					</div>
					<div class='${drawMap.title2_flow}'>
						<img src="images/${drawMap.img1}">
						<div class='${drawMap.bg_color1}'></div>
						<img src="images/${drawMap.img2}">
						<div class='${drawMap.bg_color2}'></div>
						<img src="images/${drawMap.img3}">
						<div class='${drawMap.bg_color3}'></div>
						<img src="images/${drawMap.img4}">
						<div class='${drawMap.bg_color4}'></div>
						<img src="images/${drawMap.img5}">
						<div class='${drawMap.bg_color5}'></div>
						<img src="images/${drawMap.img6}">
						<div class='${drawMap.bg_color6}'></div>
						<img src="images/${drawMap.img7}">
						<div class='${drawMap.bg_color7}'></div>
						<img src="images/${drawMap.img8}">
					</div>
					<div class='${drawMap.title3_flow}'>
						<div><c:out value="${drawMap.time1}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time2}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time3}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time4}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time5}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time6}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time7}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time8}" escapeXml="false"></c:out></div>
					</div>
				<form
						action="ContractManagerServlet?file_time=<%=System.currentTimeMillis() %>&operation=<%=operation %>"
						method="post" name="flowform">
				<input type="hidden" name="type" value="sales">
				<input type="text" name="hiddenInput" style="display:none">
				<input type="hidden" name="isagree">
				<input type="hidden" name="contract_file"><%--contract_file 0： 不上传；1：上传 --%>
				<!--startprint1-->
					<div class="td2_div1">销售合同</div>
					<span class="span_title">基本信息：</span>
					<div class="td2_div2">
						<div class="div2_name">
							<span>客户名称：</span>
							<div id="curstomer">
								${sales_contract.company_name2}
							</div>
						</div>
						<div class="div2_project">
							<span>项目名称：</span>
							<div id="project_name">
								${sales_contract.project_name}
							</div>
						</div>
						<div class="div2_project">
							<span>合同编号：</span>
							<div id="contract_no">
								${sales_contract.contract_no}
							</div>
						</div>
						<div class="div2_time">
							<span>签订时间：</span>
							<div id="sign_date">
							${sales_contract.sign_date}
							</div>
							<span>合同状态：</span>
							<div id="state">
							</div>
							<span>销售人员：</span>
							<div id="saler">${sales_contract.saler}</div>
						</div>
						<div class="div2_num">
							<span>已采购数量：</span>
							<div>${purchase_allnum}</div>
							<span>整单毛利：</span>
							<div id="gross_profit">
							</div>
						</div>
					</div>
					<div class="td2_div3">
						<span>产品信息：</span>
					</div>
					<table class="product_tab">
						<tr class="product_tr1">
							<td style="width:30px;">序号</td>
							<td style="width:60px;">物料编码</td>
							<td style="width:60px;">产品描述</td>
							<td style="width:60px;">型号</td>
							<td style="width:40px;">数量</td>
							<td>含税销售单价</td>
							<td>预计含税成本</td>
							<td style="width: 70px;">交货期</td>
							<td style="width:60px;">备注</td>
							<td style="width:60px;">不含税销售单价</td>
							<td>含税金额</td>
							<td>不含税金额</td>
							<td>单行毛利</td>
						</tr>
						<c:forEach items="${product_infoList}" var="product_info" varStatus="status">
						<tr class="${status.count%2==0?"product_tr3":"product_tr2"}" title='${product_info.purchase_num>0?"已采购数量":""}${product_info.purchase_num>0?product_info.purchase_num:""}'>
						<td>${status.count}</td>
						<td class="tooltip_div">${product_info.materials_id}</td>
						<td class="tooltip_div">${product_info.materials_remark}</td>
						<td class="tooltip_div">${product_info.model}</td>
						<td class="tooltip_div">${product_info.num}</td>
						<td class="tooltip_div">${product_info.unit_price_taxes_str}</td>
						<td class="tooltip_div">${product_info.predict_costing_taxes_str}</td>
						<td class="tooltip_div">${product_info.delivery_date}</td>
						<td class="tooltip_div">${product_info.remark}</td>
						<td class="tooltip_div"></td>
						<td class="tooltip_div"></td>
						<td class="tooltip_div"></td>
						<td class="tooltip_div"></td>
						</tr>
						</c:forEach>
					</table>
					<span class="span_title">付款方式：</span>
					<div class="td2_div4">
						<c:if test="${sales_contract.payment_method==1}">
							<div id="payment_method">合同签订后${payment_value1}个工作日内, 需方支付合同总额的${payment_value2}%预付款后合同生效；发货前支付合同总额的${payment_value3}%, 款到3个工作内发货；到货后支付合同总额的${payment_value4}%作为到货款；合同总额的${payment_value5}%,作为质保金在质保期满七天内付清；</div>
						</c:if>
						<c:if test="${sales_contract.payment_method==2}">
							<div id="payment_method">发货前支付全款，款到后供方发货并开具合同全额发票（17%增值税专用发票）；</div>
						</c:if>
						<c:if test="${sales_contract.payment_method==3}">
							<div id="payment_method">货到票到${payment_value1}天内以电汇方式支付合同全款（17%增值税专用发票）</div>
						</c:if>
					</div>
					<span class="span_title">运输方式和费用负担：</span>
					<div class="td2_div5">运输方式:${sales_contract.shipping_method}运费由${sales_contract.expense_burden}方负担。
					</div>
					<span class="span_title">交（提）货地点：</span>
					<div class="td2_div6">${sales_contract.delivery_points}设备到达需方现场。
					</div>
					<span class="span_title">验收时间：</span>
					<div class="td2_div7">到货后${inspect_time1}个工作日内需方完成检验，如超过${inspect_time2}个工作日未检验视为验收通过。
					</div>
					<span class="span_title">供方对质量保修及服务承诺:</span>
					<div class="td2_div8">免费保修期为${service_promise1}年（或为到货后${service_promise2}个月内，以先到为准）。保修期内由于产品质量问题产生的服务费用由供方承担。需方需要现场服务，供方${service_promise3}小时内响应；
					</div>
					<div class="td2_div9">
						<div>
							<div class="td2_div9_top">供 方</div>
							<div class="td2_div9_name"><span>单位名称（章）：</span><div>${sales_contract.company_name1}</div></div>
							<div class="td2_div9_address"><span>单位地址：</span><div>${sales_contract.company_address1}</div></div>
							<div class="td2_div9_postalcode"><span>邮政编码：</span><div>${sales_contract.postal_code1}</div></div>
							<div class="td2_div9_person"><span>法定代表人：</span><div>${sales_contract.law_person1}</div><span>委托代理人：</span><div>${sales_contract.entrusted_agent1}</div></div>
							<div class="td2_div9_phone"><span>电 话：</span><div>${sales_contract.phone1}</div><span>传 真：</span><div>${sales_contract.fax1}</div></div>
							<div class="td2_div9_bank"><span>开户行：</span><div>${sales_contract.bank1}</div></div>
							<div class="td2_div9_accoun"><span>公司账号：</span><div>${sales_contract.company_account1}</div></div>
							<div class="td2_div9_tariffitem"><span>税 号：</span><div>${sales_contract.tariff_item1}</div></div>
						</div>
						<div>
							<div class="td2_div9_top">需 方</div>
							<div class="td2_div9_name"><span>单位名称（章）：</span><div>${sales_contract.company_name2}</div></div>
							<div class="td2_div9_address"><span>单位地址：</span><div>${sales_contract.company_address2}</div></div>
							<div class="td2_div9_postalcode"><span>邮政编码：</span><div>${sales_contract.postal_code2}</div></div>
							<div class="td2_div9_person"><span>法定代表人：</span><div>${sales_contract.law_person2}</div><span>委托代理人：</span><div>${sales_contract.entrusted_agent2}</div></div>
							<div class="td2_div9_phone"><span>电 话：</span><div>${sales_contract.phone2}</div><span>传 真：</span><div>${sales_contract.fax2}</div></div>
							<div class="td2_div9_bank"><span>开户行：</span><div>${sales_contract.bank2}</div></div>
							<div class="td2_div9_accoun"><span>公司账号：</span><div>${sales_contract.company_account2}</div></div>
							<div class="td2_div9_tariffitem"><span>税 号：</span><div>${sales_contract.tariff_item2}</div></div>
						</div>
					</div>
					<div class="div_dashed"></div>
					<!--endprint1-->
					<c:if test="${sales_contract.contract_file==0}">
					<table class="td2_table0">
						<tr class="table0_tr1">
							<td class="table0_tr1_td1">
								客户合同
							</td>
							<td class="table0_tr1_td2">
							<c:forEach items="${file_paths}" var="file_path1">
								<a href="javascript:void()" onclick="fileDown(${file_path1.id})">${file_path1.file_name}</a>
							</c:forEach>
							</td>
						</tr>
					</table>
					</c:if>
					<c:if test="${mapList!= null && fn:length(mapList) >0}">
					<table class="td2_table_hide ${sales_contract.contract_file==0?"":"border-top"}">
						<tr>
							<td><span>显示客户合同审批</span><img src="images/show_check.png"></td>
						</tr>
					</table>
					<table class="td2_table8">
					<c:forEach items="${mapList}" var="fileMap">
					<tr>
						<td class="td2_table8_left">
							<div>
								<c:if test="${fileMap.operation==-1||fileMap.operation==0}">
									<div class="div_noimg">
									<c:out value="${fileMap.reason}" escapeXml="false"></c:out>
									</div>
								</c:if>
								<c:if test="${fileMap.operation==2}">
									<div class="div_agree">
									<c:out value="${fileMap.reason}" escapeXml="false"></c:out>
									</div>
								</c:if>
								<c:if test="${fileMap.operation==3}">
									<div class="div_disagree">
									<c:out value="${fileMap.reason}" escapeXml="false"></c:out>
									</div>
								</c:if>
								<c:if test="${fileMap.files!= null && fn:length(fileMap.files) >0}">
								<div class="table8_file"><div>客户合同：</div>
								<div>
								<c:forEach items="${fileMap.files}" var="file">
								<a href="javascript:void(0)" onclick="fileDown(${file.id})">${file.file_name}&nbsp;&nbsp;${file.create_date}</a>
								</c:forEach>
								</div>
								</div>
								</c:if>
							</div>
						</td>
						<td class="td2_table8_right">
							<c:if test="${fileMap.operation==-1||fileMap.operation==0}">
									<div class="td2_div5_bottom_noimg">
								</c:if>
								<c:if test="${fileMap.operation==2}">
									<div class="td2_div5_bottom_agree">
								</c:if>
								<c:if test="${fileMap.operation==3}">
									<div class="td2_div5_bottom_disagree">
								</c:if>
								<div style="height: 15px;"></div>
								<div class="td2_div5_bottom_right1">${fileMap.username}</div>
								<div class="td2_div5_bottom_right2">${fileMap.flow_date}</div>
							</div>
						</td>
					</tr>
					</c:forEach>
					</table>
					</c:if>
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
								<c:if test="${reasonFlow.operation==0||reasonFlow.operation==13}">
									<div class="td2_div5_bottom_noimg">
								</c:if>
								<c:if test="${reasonFlow.operation==4||reasonFlow.operation==6||reasonFlow.operation==8||reasonFlow.operation==10}">
									<div class="td2_div5_bottom_agree">
								</c:if>
								<c:if test="${reasonFlow.operation==5||reasonFlow.operation==7||reasonFlow.operation==9||reasonFlow.operation==11}">
									<div class="td2_div5_bottom_disagree">
								</c:if>
										<div style="height: 15px;"></div>
										<div class="td2_div5_bottom_right1">${reasonFlow.username}</div>
										<div class="td2_div5_bottom_right2">${reasonFlow.create_date}</div>
									</div>
								</td>
							</tr>
							</c:forEach>
						</table>
						</div>
						</c:if>
					<c:if test="${sealManager||canApply||(mUser.id==sales_contract.create_id&&!isDeling)}">
					<textarea name="reason" class="div_testarea" placeholder="请输入意见或建议" required="required" maxlength="500"></textarea>
					</c:if>
					<div class="div_btn">
						<c:if test="${mUser.id==sales_contract.create_id&&!isDeling}">
						<a href="javascript:void(0)" class="btn_agree" onclick="deleteSales(${operation});"><img src="images/delete_travel.png"></a>
						</c:if>
						<c:if test="${operation>3||sales_contract.contract_file==1}">
						<a href="flowmanager/preview_sales_contract.jsp" class="btn_agree" target="_blank"><img src="images/contract_preview.png"></a>
						</c:if>
						<c:if test="${mUser.id==sales_contract.create_id&&!isDeling}">
						<a href="flowmanager/update_salesflow.jsp" class="btn_agree"><img src="images/alter_flow.png"></a>
						</c:if>
						<c:if test="${canApply}">
						<img src="images/agree_flow.png" class="btn_agree" onclick="verifyFlow(0);">
							<c:if test="${operation==1||operation==2||operation==4||operation==6||operation==8}">
							<img src="images/disagree_flow.png" class="btn_disagree" onclick="verifyFlow(1);">
							</c:if>
						</c:if>
						<c:if test="${sealManager&&!isDeling}">
						<img src="images/seal_confirm.png" class="btn_disagree" onclick="sealAgree();">
						</c:if>
					</div>
					</form>
				</td>
			</tr>
		</table>
		
	</div>
	<div class="dialog_product">
		<div class="product_model"><span>型号：</span>
			<div id="index_num"></div>
		</div>
		<div class="product_model"><span>数量：</span><div id="dialog_num"></div></div>
		<div class="product_model"><span>含税销售单价：</span><div id="dialog_upt"></div></div>
		<div class="product_model"><span>预计含税成本：</span><div id="dialog_pct"></div></div>
		<div class=product_model><span>交货期：</span><div id="dialog_time"></div></div>
		<div class="product_div"><span>备注：</span><textarea id="dialog_remark" readonly="readonly" ></textarea></div>
		<div class="product_bottom"><img src="images/cancle_materials.png" onclick="closeDialog(0)"></div>
	</div>
</body>
</html>
