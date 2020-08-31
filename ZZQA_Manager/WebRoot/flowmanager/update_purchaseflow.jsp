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
	import="com.zzqa.service.interfaces.materials_info.Materials_infoManager"%>
<%@page import="com.zzqa.pojo.materials_info.Materials_info"%>
<%@page
	import="com.zzqa.service.interfaces.purchase_note.Purchase_noteManager"%>
<%@page import="com.zzqa.pojo.purchase_note.Purchase_note"%>
<%@page
	import="com.zzqa.service.interfaces.sales_contract.Sales_contractManager"%>
<%@page import="com.zzqa.pojo.sales_contract.Sales_contract"%>
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
	Materials_infoManager materials_infoManager=(Materials_infoManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("materials_infoManager");
	Sales_contractManager sales_contractManager=(Sales_contractManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("sales_contractManager");
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
	List<Materials_info> mList=materials_infoManager.getMaterials_infos();
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
	//产品已购数量不包含当前的(流程未结束的)采购合同所采购的数量
	List<Purchase_note> noteList=purchase_noteManager.getPurchase_notesByPID(purchase_id,applyFinished);
	pageContext.setAttribute("mUser", mUser);
	pageContext.setAttribute("canApply", canApply);
	pageContext.setAttribute("drawMap", drawMap);
	pageContext.setAttribute("purchase_contract", purchase_contract);
	pageContext.setAttribute("operation",operation);
	pageContext.setAttribute("reasonList", reasonList);
	pageContext.setAttribute("isDeling", isDeling);
	pageContext.setAttribute("applyFinished", applyFinished);
	request.setAttribute("noteList", noteList);
	pageContext.setAttribute("flow_titlename1", purchase_contract.getType()==1?"正常采购":"备货采购");
	List<Purchase_note> contractNos=new ArrayList<Purchase_note>();
	Set<Integer> set=new HashSet<Integer>();
	for(Purchase_note purchase_note:noteList){
		int sales_id=purchase_note.getSales_id();
		if(purchase_note.getProduct_id()>0&&!set.contains(sales_id)){
			contractNos.add(purchase_note);
			set.add(sales_id);
		}
	}
	request.setAttribute("contractNos", contractNos);
	pageContext.setAttribute("today",new SimpleDateFormat("yyyy/M/d").format(System.currentTimeMillis()));
	request.setAttribute("mList", mList);
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>修改采购合同</title>
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
	var nowTR;
	var today=timeTransLongToStr(0, 4, "/",false);
	$(function(){
		if(<%=purchase_contract.getType()==1%>){
			initTR(6);
		}else{
			initTR(4);
		}
		var moxa=<%=purchase_contract.getMoxa()%>;
		if(moxa==0){
			$(".td2_div4").css("display","none");
		}else if(moxa==1){
			useFile(true,true);
		}else{
			useFile(false,true);
		}
		$("#bts-ex-6 li[data-filter='"+"<%=purchase_contract.getCompany_name2()%>"+"']").click();
		$("#bts-ex-6 li.filter-item.items").click(function(){
			setSupplier($(this).attr("data-value"));
		});
		setContractState(${isDeling},${operation},${applyFinished});
	});
	var materialsArray=[
      <%int mlen=mList.size();for(int i=0;i<mlen;i++){
    	  Materials_info materials_info=mList.get(i);
    	  if(i>0){
    		  out.write(",");
    	  }
    	  out.write("["+materials_info.getId()+",'"+materials_info.getMaterials_id()+"','"+materials_info.getModel()+"','"+materials_info.getRemark()+"']");
      }%>     
      ];
	var salesArray=[
    	      <%int slen=noteList.size();for(int i=0;i<slen;i++){
    	    	  Purchase_note purchase_note=noteList.get(i);
    	    	  if(i>0){
    	    		  out.write(",");
    	    	  }
    	    	  out.write("["+purchase_note.getSales_id()+",'"+purchase_note.getContract_no()+"','"+purchase_note.getProject_name()+"','"+purchase_note.getCustomer()+"']");
    	      }%>     
    	      ];
		function addFlow(){
			var cname_input=$("#cname_input6").val();
			if(cname_input.length==0){
				initdiglog2("提示信息了","请选择供应商");
				return;
			}
			if($("input[name='sign_time']").val().replace(/\s/g,"").length==0){
				initdiglog2("提示信息了","请输入采购签订时间");
				return;
			}
			document.flowform.supplier.value=cname_input;
			if(<%=purchase_contract.getType()==1%>){
				//直接采购
				var data="";
				var Index=0;
				var stop=false;
				$("#apply_tab2 tr:gt(0)").each(function(){
					if(stop){
						return;
					}
					if(data.length>0){
						data+="い";
					}
					Index++;
					if($(this).children("td:eq(10)").text().trim().length==0){
						if(!stop){
							stop=true;
						}
						initdiglog2("提示信息了","第"+Index+"行采购单信息不完整");
						return;
					}
					//note_idのproduct_idのsales_idのm_idの数量の预计含税成本の含税单价の交货期の备注
					data+=$(this).attr("note_id")+"の"+$(this).attr("product_id")+"の"+$(this).attr("sales_id")+"の"+$(this).children("td:eq(5)").attr("id")+"の"
					+$(this).children("td:eq(7)").text().trim()+"の"+$(this).children("td:eq(8)").text().trim()+"の"+$(this).children("td:eq(9)").text().trim()
					+"の"+$(this).children("td:eq(10)").text().trim()+"の"+$(this).children("td:eq(11)").text().trim();
				});
				if(stop){
					return;
				}
				document.flowform.data.value=data;
				if(data.length==0){
					initdiglog2("提示信息了","请输入采购信息");
					return;
				}
			}else{
				var data="";
				$("#purchase_tab tr:gt(0)").each(function(){
					if(data.length>0){
						data+="い";
					}
					//note_idのm_idの数量の预计含税成本の含税单价の交货期の备注
					var note_id=$(this).attr("note_id")?$(this).attr("note_id"):0;
					data+=note_id+"の"+$(this).children("td:eq(2)").attr("id")+"の"+$(this).children("td:eq(4)").text().trim()+"の"
						+$(this).children("td:eq(5)").text().trim()+"の"+$(this).children("td:eq(6)").text().trim()+"の"
						+$(this).children("td:eq(7)").text().trim()+"の"+$(this).children("td:eq(8)").text().trim();
				});
				document.flowform.data.value=data;
				if(data.length==0){
					initdiglog2("提示信息了","请输入采购信息");
					return;
				}			
			}	
			if(!checkMOXA(document.flowform.supplier.value)){
				if(!$("#checkbox10").prop("checked")&&!$("#checkbox11").prop("checked")){
					initdiglog2("提示信息了","请选择是否预付款");
					return;
				}
				document.flowform.moxa.value=$("#checkbox10").prop("checked")?1:2;
			}else{
				document.flowform.moxa.value=0;
			}
			if($("input[name='payment_value']").val().replace(/\s/g,"").length==0){
				initdiglog2("提示信息了","请输入付款方式");
				return;
			}
			if($("input[name='aog_time_address']").val().replace(/\s/g,"").length==0){
				initdiglog2("提示信息了","请输入到货时间/地点：");
				return;
			}
			if($("input[name='linkman']").val().replace(/\s/g,"").length==0){
				initdiglog2("提示信息了","请输入联系人");
				return;
			}
			if($("input[name='checkout_time']").val().replace(/\s/g,"").length==0){
				initdiglog2("提示信息了","请输入质保期");
				return;
			}
			if($("input[name='company_name1']").val().replace(/\s/g,"").length==0||$("input[name='company_address1']").val().replace(/\s/g,"").length==0||
					$("input[name='phone1']").val().replace(/\s/g,"").length==0||$("input[name='bank1']").val().replace(/\s/g,"").length==0||
					$("input[name='company_account1']").val().replace(/\s/g,"").length==0||$("input[name='tariff_item1']").val().replace(/\s/g,"").length==0){
				initdiglog2("提示信息","甲方信息不完整");
				return;
			}
			if($("input[name='company_name2']").val().replace(/\s/g,"").length==0||$("input[name='company_address2']").val().replace(/\s/g,"").length==0||
					$("input[name='phone2']").val().replace(/\s/g,"").length==0||$("input[name='bank2']").val().replace(/\s/g,"").length==0||
					$("input[name='company_account2']").val().replace(/\s/g,"").length==0||$("input[name='tariff_item2']").val().replace(/\s/g,"").length==0){
				initdiglog2("提示信息","乙方信息不完整");
				return;
			}
			var reason=$(".div_testarea").val().trim();
			if(reason.length==0){
				initdiglog2("提示信息","请输入备注");
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
					<jsp:param name="index" value="3" />
				</jsp:include>
				<td class="table_center_td2_notfull">
					<form action="ContractManagerServlet?type=alterPurchase&operation=<%=operation %>"
							method="post" name="flowform">
							<input type="text" name="nodata" style="display:none">
							<input type="hidden" name="supplier" value="<c:out value='${purchase_contract.supplier}'></c:out>">
							<input type="hidden" name="data">
							<input type="hidden" name="moxa">
						<div class="td2_div1">采购合同</div>
						<span class="span_title">基本信息：</span>
							<div class="td2_div2">
								<div class="div2_name">
									<span>供应商名称：</span>
									<div id="div2_name_select">
										<jsp:include page="/flowmanager/drop_down_customer1.jsp" >
											<jsp:param name="customer_type" value="2"/>
											</jsp:include>
									</div>
								</div>
								<div class="div2_name">
									<span>合同编号：</span>
									<input type="text" name="contract_no" maxlength="100" value="<c:out value='${purchase_contract.contract_no}'></c:out>">
								</div>
								<div class="div2_time">
									<span>签订时间：</span>
									<input type="text" name="sign_time" id="sign_time" value="<c:out value='${purchase_contract.sign_date}'></c:out>" onClick="return Calendar('sign_time');" readonly="readonly">
									<span>合同状态：</span>
									<div class="div2_time">待批复</div>
								</div>
							</div>
							<c:if test="${purchase_contract.type==1}">
								<div class="td2_div3">
									<span>采购单：</span>
									<img src="images/add_product.png" onclick="showApplyDialog4();">
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
										<td style="width:70px;">交货期</td>
										<td>备注</td>
										<td>不含税单价</td>
										<td>含税金额</td>
										<td>不含税金额</td>
									</tr>
									<c:forEach items="${noteList}" var="apply_note">
									<tr  note_id='${apply_note.id}'  sales_id='${apply_note.sales_id}' product_id='${apply_note.product_id}'  title="<c:if test='${apply_note.hasbuy_num>0}'>已采购数量为${apply_note.hasbuy_num}</c:if>">
										<td style="width:30px;"></td>
										<td class="tooltip_div">${apply_note.contract_no}</td>
										<td class="tooltip_div">${apply_note.customer}</td>
										<td class="tooltip_div">${apply_note.project_name}</td>
										<td class="tooltip_div">${apply_note.materials_id}</td>
										<td id='${apply_note.m_id}' class="tooltip_div">${apply_note.model}</td>
										<td class="tooltip_div">${apply_note.materials_remark}</td>
										<td class="tooltip_div" style="width:60px">${apply_note.num}</td>
										<td class="tooltip_div">${apply_note.predict_costing_taxes_str}</td>
										<td class="tooltip_div">${apply_note.unit_price_taxes_str}</td>
										<td>${apply_note.delivery_date}</td>
										<td class="tooltip_div">${apply_note.remark}</td>
										<td class="tooltip_div"></td>
										<td class="tooltip_div"></td>
										<td class="tooltip_div"></td>
									</tr>
								</c:forEach>
								</table>
							</c:if>
							<c:if test="${purchase_contract.type==2}">
								<div class="td2_div3">
									<span>备货采购：</span>
									<img src="images/add_product.png" onclick="showPurchaseDialog();">
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
										<td style="width:70px;">交货期</td>
										<td>备注</td>
										<td>不含税单价</td>
										<td>含税金额</td>
										<td>不含税金额</td>
									</tr>
									<c:forEach items="${noteList}" var="stockup_note">
									<tr note_id='${stockup_note.id}'>
										<td style="width:30px;"></td>
										<td class="tooltip_div">${stockup_note.materials_id}</td>
										<td id='${stockup_note.m_id}' class="tooltip_div">${stockup_note.model}</td>
										<td class="tooltip_div">${stockup_note.materials_remark}</td>
										<td class="tooltip_div" style="width:60px">${stockup_note.num}</td>
										<td class="tooltip_div">${stockup_note.predict_costing_taxes}</td>
										<td class="tooltip_div">${stockup_note.unit_price_taxes}</td>
										<td>${stockup_note.delivery_date}</td>
										<td class="tooltip_div">${stockup_note.remark}</td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</c:forEach>
								</table>
							</c:if>
							<span class="span_title">付款方式：</span>
							<div class="td2_div4">
								<div>是否预付款:</div>
								<input type="checkbox" id="checkbox10" class="chk_2" onchange="useFileChange(true)"/><label for="checkbox10"></label><div class="ifUseFile" onclick="useFile(true)">是</div>
								<input type="checkbox" id="checkbox11" class="chk_2"  onchange="useFileChange(false)"/><label for="checkbox11"></label><div class="ifUseFile" onclick="useFile(false)">否</div>
							</div>
							<div class="td2_div4_address"><input type="text" maxlength="100" name="payment_value" value="<c:out value='${purchase_contract.payment_value}'></c:out>"></div>
							<span class="span_title">到货时间/地点：</span>
							<div class="td2_div5"><input type="text" maxlength="100" name="aog_time_address" value="<c:out value='${purchase_contract.aog_time_address}'></c:out>"></div>
							<div class="td2_div5_linkman">联系人：<input type="text" maxlength="100" name="linkman" value="<c:out value='${purchase_contract.linkman}'></c:out>"></div>
							<span class="span_title">验收标准：</span>
							<div class="td2_div6">质保期为：<input type="text" maxlength="2" name="checkout_time" value="<c:out value='${purchase_contract.checkout_time}'></c:out>" oninput="checkIntPosition(this)">年</div>
							<div class="td2_div9">
								<div>
									<div class="td2_div9_top">甲&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;方</div>
									<div class="td2_div9_name"><span>单位名称（章）：</span><input type="text" maxlength="100" name="company_name1" value="<c:out value='${purchase_contract.company_name1}'></c:out>"></div>
									<div class="td2_div9_address"><span>单位地址：</span><input type="text" maxlength="200" name="company_address1" value="<c:out value='${purchase_contract.company_address1}'></c:out>"></div>
									<div class="td2_div9_postalcode"><span>邮政编码：</span><input type="text" maxlength="10" name="postal_code1" value="<c:out value='${purchase_contract.postal_code1}'></c:out>"></div>
									<div class="td2_div9_person"><span>法定代表人：</span><input type="text" maxlength="100" name="law_person1" value="<c:out value='${purchase_contract.law_person1}'></c:out>"><span>委托代理人：</span><input type="text" maxlength="100" name="entrusted_agent1" value="<c:out value='${purchase_contract.entrusted_agent1}'></c:out>"></div>
									<div class="td2_div9_phone"><span>电 话：</span><input type="text" maxlength="20" name="phone1" value="<c:out value='${purchase_contract.phone1}'></c:out>"><span>传 真：</span><input type="text" maxlength="20" name="fax1" value="<c:out value='${purchase_contract.fax1}'></c:out>"></div>
									<div class="td2_div9_bank"><span>开户行：</span><input type="text" maxlength="100" name="bank1" value="<c:out value='${purchase_contract.bank1}'></c:out>"></div>
									<div class="td2_div9_accoun"><span>公司账号：</span><input type="text" maxlength="50" name="company_account1" value="<c:out value='${purchase_contract.company_account1}'></c:out>"></div>
									<div class="td2_div9_tariffitem"><span>税 号：</span><input type="text" maxlength="100" name="tariff_item1" value="<c:out value='${purchase_contract.tariff_item1}'></c:out>"></div>
								</div>
								<div>
									<div class="td2_div9_top">乙&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;方</div>
									<div class="td2_div9_name"><span>单位名称（章）：</span><input type="text" maxlength="100" name="company_name2" style="border:0" readonly="readonly" value="<c:out value='${purchase_contract.company_name2}'></c:out>"></div>
									<div class="td2_div9_address"><span>单位地址：</span><input type="text" maxlength="200" name="company_address2" value="<c:out value='${purchase_contract.company_address2}'></c:out>"></div>
									<div class="td2_div9_postalcode"><span>邮政编码：</span><input type="text" maxlength="10" name="postal_code2" value="<c:out value='${purchase_contract.postal_code2}'></c:out>"></div>
									<div class="td2_div9_person"><span>法定代表人：</span><input type="text" maxlength="100" name="law_person2" value="<c:out value='${purchase_contract.law_person2}'></c:out>"><span>委托代理人：</span><input type="text" maxlength="100" name="entrusted_agent2" value="<c:out value='${purchase_contract.entrusted_agent2}'></c:out>"></div>
									<div class="td2_div9_phone"><span>电 话：</span><input type="text" maxlength="20" name="phone2" value="<c:out value='${purchase_contract.phone2}'></c:out>"><span>传 真：</span><input type="text" maxlength="20" name="fax2" value="<c:out value='${purchase_contract.fax2}'></c:out>"></div>
									<div class="td2_div9_bank"><span>开户行：</span><input type="text" maxlength="100" name="bank2" value="<c:out value='${purchase_contract.bank2}'></c:out>"></div>
									<div class="td2_div9_accoun"><span>公司账号：</span><input type="text" maxlength="50" name="company_account2" value="<c:out value='${purchase_contract.company_account2}'></c:out>"></div>
									<div class="td2_div9_tariffitem"><span>税 号：</span><input type="text" maxlength="100" name="tariff_item2" value="<c:out value='${purchase_contract.tariff_item2}'></c:out>"></div>
								</div>
							</div>
						<textarea name="reason" class="div_testarea" placeholder="请输入备注" required="required" maxlength="500"></textarea>
						<div class="buttom_btn_group">
								<img src="images/submit_materials.png" class="btn_agree" onclick="checkContract_no(<%=purchase_id%>)">
								<img src="images/cancle_materials.png" onclick="window.location.href='<%=basePath %>flowmanager/purchaseflow_detail.jsp'">
							</div>
					</form>
				</td>
			</tr>
		</table>
	</div>
	<c:if test="${purchase_contract.type==1}">
	<div class="dialog_product" id="dialog_apply4">
	<div class="dislog_cover"></div>
		<div class="product_top"><span>序号：</span><span></span></div>
		<div class="product_div product_model" ><span>销售合同：</span>
				<div>
					<jsp:include page="/flowmanager/drop_down_contract1.jsp" />
				</div>
			</div>
			<div class="product_div product_model" ><span>型号：</span>
				<div>
					<jsp:include page="/flowmanager/drop_down_model.jsp" />
				</div>
			</div>
		<div class="product_div"><span>预计含税成本：</span><input type="text" maxlength="8" oninput="checkFloatPositive(this,2)"></div>
		<div class="product_div"><span>数量：</span><input type="text" maxlength="8" oninput="checkIntPosition(this)"></div>
		<div class="product_div"><span>含税单价：</span><input type="text" maxlength="8" oninput="checkFloatPositive(this,2)"></div>
		<div class=product_div><span>交货期：</span><input type="text" readonly="readonly" style="width:100px;" value="<c:out value='${today}'></c:out>" id="dialog_time" onclick="return Calendar('dialog_time');"  ></div>
		<div class="product_div"><span>备注：</span><textarea maxlength="200"></textarea></div>
		<div class="product_bottom"></div>
	</div>
	</c:if>
	<c:if test="${purchase_contract.type==2}">
	<div class="dialog_product" id="dialog_purchase">
		<div class="product_div product_model" ><span>型号：</span>
			<div>
				<jsp:include page="/flowmanager/drop_down_model.jsp" />
			</div>
		</div>
		<div class="product_div"><span>数量：</span><input type="text" maxlength="8" oninput="checkIntPosition(this)"></div>
		<div class="product_div"><span>预计含税成本：</span><input type="text" maxlength="8"  oninput="checkFloatPositive(this,2)"></div>
		<div class="product_div"><span>含税单价：</span><input type="text" maxlength="8" oninput="checkFloatPositive(this,2)"></div>
		<div class=product_div><span>交货期：</span><input type="text" readonly="readonly" style="width:100px;" value="<c:out value='${today}'></c:out>" id="dialog_time2" onclick="return Calendar('dialog_time2');"  ></div>
		<div class="product_div"><span>备注：</span><textarea maxlength="200"></textarea></div>
		<div class="product_bottom"></div>
	</div>
	</c:if>
</body>
</html>
