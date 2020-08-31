<%@page import="net.sf.json.JSONArray"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page
	import="com.zzqa.service.interfaces.materials_info.Materials_infoManager"%>
<%@page import="com.zzqa.pojo.materials_info.Materials_info"%>
<%@page
	import="com.zzqa.service.interfaces.sales_contract.Sales_contractManager"%>
<%@page import="com.zzqa.pojo.sales_contract.Sales_contract"%>
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
	Materials_infoManager materials_infoManager= (Materials_infoManager) WebApplicationContextUtils
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
	List<Materials_info> mList=materials_infoManager.getMaterials_infos();
	request.setAttribute("mList", mList);
	List<Sales_contract> salesList=sales_contractManager.getNeedPurchaseProducts();
	request.setAttribute("salesList", salesList);
	pageContext.setAttribute("today",new SimpleDateFormat("yyyy/M/d").format(System.currentTimeMillis()));
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>新建采购合同</title>
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
		var nextFlow=0;//0：提交备货信息；1：筛选采购信息；2：提交采购信息
		function setPurchaseType(flag){
			document.flowform.purchase_type.value=flag;
			setContractState(false,0,0);
			$(".border_div").css("display","none");
			$(".div_btn").css("display","block");
			if(flag==1){
				nextFlow=1;
				initTR(1);
				$("#hide_div1").attr("class","div_show");
				$("#bts-ex-4 li.filter-item.items").click(function(){
					setSupplier($(this).attr("data-value"));
				});
				useFile(false,true);//默认不是预付款
			}else{
				nextFlow=0;
				$("#hide_div2").attr("class","div_show");
				$("#hide_div3").attr("class","div_show");
				$("#hide_div5").attr("class","div_show");
				useFile(false,true);//默认不是预付款
				$("#bts-ex-6 li.filter-item.items").click(function(){
					setSupplier($(this).attr("data-value"));
				});
			}
		}
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
       	      <%int slen=salesList.size();for(int i=0;i<slen;i++){
       	    	  Sales_contract sales_contract=salesList.get(i);
       	    	  if(i>0){
       	    		  out.write(",");
       	    	  }
       	    	  out.write("["+sales_contract.getId()+",'"+sales_contract.getContract_no()+"','"+sales_contract.getProject_name()+"','"+sales_contract.getCompany_name2()+"']");
       	      }%>     
       	      ];
		function selectPurchase(){
			if(nextFlow==1){
				//直接采购 筛选销售单的产品
				var cname_input=$("#cname_input").val();
				if(cname_input.length==0){
					initdiglog2("提示信息了","请选择供应商");
					return;
				}
				document.flowform.supplier.value=cname_input;
				var stop=false;
				var data="";
				var allZero=true;
				$("#apply_tab tr:gt(0)").each(function(){
					if(stop){
						return;
					}
					if(data.length>0){
						data+="い";
					 }
					var num=$(this).find("td:eq(9)").text().trim();
					if(num.length==0){
						initdiglog2("提示信息","请输入采购数量,若本次不采购请输入0");
						stop=true;
						return;
					}
					var last_num=parseInt($(this).find("td:eq(8)").text().trim());
					num=parseInt(num);
					if(num>last_num){
						stop=true;
						initdiglog2("提示信息", "第"+$(this) .find("td:eq(0)").text().trim()+"行采购数量超过上限");
						return;
					}
					if(num>0){
						data+=$(this).attr("sales_id")+"の"+$(this).attr("product_id")+"の"+num;
					}
					if(allZero){
						allZero=num==0;
					}
				});
				if(stop){
					return;
				}
				if(allZero){
					initdiglog2("提示信息","采购数量不能全为0");
					return;
				}
				$(".div_show").attr("class","hide_div");
				$("#hide_div2").attr("class","div_show");
				$("#hide_div4").attr("class","div_show");
				$("#hide_div5").attr("class","div_show");
				$("#div2_name_select").html("").text(cname_input).css("top","0px");
				var selected_salesIDs="";//选中的合同
				$("#apply_tab tr:gt(0)").each(function(){
					var num=$(this).children("td:eq(9)").text().trim();
					if(num>0){
						var sales_id=$(this).attr("sales_id");
						var product_id=$(this).attr("product_id");
						var contract_no=$(this).children("td:eq(1)").text().trim();
						var customer=$(this).children("td:eq(2)").text().trim();
						var project_name=$(this).children("td:eq(3)").text().trim();
						var model=$(this).children("td:eq(4)").text().trim();
						var predict_costing_taxes=$(this).children("td:eq(5)").text().trim();
						var mArray=getMaterialsByModel(model);
						//用于辅料筛选销售合同
						selected_salesIDs+="の"+sales_id;
						var temp='<tr sales_id="'+sales_id+'" product_id="'+product_id+'">'
							+'<td class="tooltip_div" style="width:30px;"></td>'
							+'<td class="tooltip_div">'+contract_no+'</td>'
							+'<td class="tooltip_div">'+customer+'</td>'
							+'<td class="tooltip_div">'+project_name+'</td>'
							+'<td class="tooltip_div">'+mArray[1]+'</td>'
							+'<td class="tooltip_div">'+model+'</td>'
							+'<td class="tooltip_div">'+mArray[2]+'</td>'
							+'<td class="tooltip_div">'+num+'</td>'
							+'<td class="tooltip_div">'+predict_costing_taxes+'</td>'
							+'<td class="tooltip_div"></td>'
							+'<td class="tooltip_div" style="width:60px;"></td>'
							+'<td class="tooltip_div"></td>'
							+'<td class="tooltip_div"></td>'
							+'<td class="tooltip_div"></td>'
							+'<td class="tooltip_div"></td></tr>';
						$("#apply_tab2").append(temp);
						showToolTip($("#apply_tab2").find("tr:last"));
					}
				});
				selected_salesIDs+="の";
				$("#bts-ex-8 li.filter-item").each(function(){
					if(selected_salesIDs.indexOf("の"+$(this).attr("data-value")+"の")==-1){
						//该合同已不存在
						$(this).remove();
					}
				});
				initTR(2);
				nextFlow=2;
			}else{
				checkContract_no(0);//上传前验证合同编号
			}
		}
		function addFlow(){
			if(nextFlow==0){
				//备货需要筛选供应商
				var cname_input=$("#cname_input6").val();
				if(cname_input.length==0){
					initdiglog2("提示信息了","请选择供应商");
					return;
				}
				document.flowform.supplier.value=cname_input;
			}
			if($("input[name='sign_time']").val().replace(/\s/g,"").length==0){
				initdiglog2("提示信息了","请输入采购签订时间");
				return;
			}
			if(nextFlow==0){
				var data="";
				$("#purchase_tab tr:gt(0)").each(function(){
					if(data.length>0){
						data+="い";
					}
					data+=$(this).children("td:eq(2)").attr("id")+"の"+$(this).children("td:eq(4)").text().trim()+"の"
						+$(this).children("td:eq(5)").text().trim()+"の"+$(this).children("td:eq(6)").text().trim()+"の"
						+$(this).children("td:eq(7)").text().trim()+"の"+$(this).children("td:eq(8)").text().trim();
				});
				document.flowform.data.value=data;
				if(data.length==0){
					initdiglog2("提示信息了","请输入采购信息");
					return;
				}
			}else{
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
					if($(this).attr("product_id")=="0"){
						//辅料
						//product_idのsales_idのm_idの数量の预计含税成本の含税单价の交货期の备注
						data+="0の"+$(this).attr("sales_id")+"の"+$(this).children("td:eq(5)").attr("id")+"の"
						+$(this).children("td:eq(7)").text().trim()+"の"+$(this).children("td:eq(8)").text().trim()+"の"+$(this).children("td:eq(9)").text().trim()
						+"の"+$(this).children("td:eq(10)").text().trim()+"の"+$(this).children("td:eq(11)").text().trim();
					}else{
						//product_idのsales_idのm_idの数量の预计含税成本の含税单价の交货期の备注"
						data+=$(this).attr("product_id")+"の"+$(this).attr("sales_id")+"の"+$(this).children("td:eq(5)").attr("id")+"の"
						+$(this).children("td:eq(7)").text().trim()+"の"+$(this).children("td:eq(8)").text().trim()+"の"+$(this).children("td:eq(9)").text().trim()
						+"の"+$(this).children("td:eq(10)").text().trim()+"の"+$(this).children("td:eq(11)").text().trim();
					}
				});
				if(stop){
					return;
				}
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
					<form action="ContractManagerServlet?type=addpurchase"
							method="post" name="flowform">
							<input type="text" name="nodata" style="display:none">
							<input type="hidden" name="supplier">
							<input type="hidden" name="data">
							<input type="hidden" name="moxa">
						<div class="td2_div1">采购合同</div>
						<div class="border_div">
							<input type="hidden" name="purchase_type">
							<div onclick="setPurchaseType(1)">正常采购</div><div onclick="setPurchaseType(2)">备货采购</div>
						</div>
						<div class="hide_div" id="hide_div1">
							<span class="span_title">采购申请单：</span>
							<div class="tab_title_name">
								<span>供应商名称：</span>
								<div class="customer_div">
								<jsp:include page="/flowmanager/drop_down_customer.jsp" >
									<jsp:param name="customer_type" value="2"/>
									</jsp:include>
								</div>
							</div>
							<table class="product_tab" id="apply_tab">
								<tr class="product_tr1">
									<td style="width:30px;">序号</td>
									<td>销售合同号</td>
									<td>客户名称</td>
									<td>项目名称</td>
									<td>型号</td>
									<td>预估成本</td>
									<td>合同数量</td>
									<td>含税销售单价</td>
									<td>未采购数量</td>
									<td style="width:60px">本次采购数量</td>
								</tr>
								<c:forEach items="${salesList}" var="sales">
									<c:forEach items="${sales.product_infos}" var="product_info">
										<tr product_id="<c:out value='${product_info.id}'></c:out>" sales_id="<c:out value='${sales.id}'></c:out>">
											<td style="width:30px;"></td>
											<td class="tooltip_div"><c:out value="${sales.contract_no}"></c:out></td>
											<td class="tooltip_div"><c:out value="${sales.company_name2}"></c:out></td>
											<td class="tooltip_div"><c:out value="${sales.project_name}"></c:out></td>
											<td class="tooltip_div"><c:out value="${product_info.model}"></c:out></td>
											<td class="tooltip_div"><c:out value="${product_info.predict_costing_taxes_str}"></c:out></td>
											<td class="tooltip_div"><c:out value="${product_info.num}"></c:out></td>
											<td class="tooltip_div"><c:out value="${product_info.unit_price_taxes}"></c:out></td>
											<td class="tooltip_div"><c:out value="${product_info.last_num}"></c:out></td>
											<td class="tooltip_div" style="width:60px">0</td>
										</tr>
									</c:forEach>
								</c:forEach>
							</table>
						</div>
						<div class="hide_div" id="hide_div2">
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
									<input type="text" name="contract_no" maxlength="100">
								</div>
								<div class="div2_time">
									<span>签订时间：</span>
									<input type="text" name="sign_time" id="sign_time" value="<c:out value='${today}'></c:out>" onClick="return Calendar('sign_time');" readonly="readonly">
									<span>合同状态：</span>
									<div>待批复</div>
								</div>
							</div>
						</div>
						<div class="hide_div" id="hide_div3">
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
									<td style="width:65px;">交货期</td>
									<td>备注</td>
									<td>不含税单价</td>
									<td>含税金额</td>
									<td>不含税金额</td>
								</tr>
							</table>
						</div>
						<div class="hide_div" id="hide_div4">
							<div class="td2_div3">
								<span>采购单：</span>
								<img src="images/add_product.png" onclick="showApplyDialog2();">
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
									<td style="width:65px;">交货期</td>
									<td>备注</td>
									<td>不含税单价</td>
									<td>含税金额</td>
									<td>不含税金额</td>
								</tr>
							</table>
						</div>
						<div class="hide_div" id="hide_div5">
							<span class="span_title">付款方式：</span>
							<div class="td2_div4">
								<div>是否预付款:</div>
								<input type="checkbox" id="checkbox10" class="chk_2" onchange="useFileChange(true)"/><label for="checkbox10"></label><div class="ifUseFile" onclick="useFile(true)">是</div>
								<input type="checkbox" id="checkbox11" class="chk_2"  onchange="useFileChange(false)"/><label for="checkbox11"></label><div class="ifUseFile" onclick="useFile(false)">否</div>
							</div>
							<div class="td2_div4_address"><input type="text" maxlength="100" name="payment_value" value="货到票到后一个月以后付款，在发货的同时提供全额的17%增值税发票。"></div>
							<span class="span_title">到货时间/地点：</span>
							<div class="td2_div5"><input type="text" maxlength="100" name="aog_time_address" value="按甲方通知发货时间为准，杭州经济技术开发区（下沙）6号大街260号中自科技园"></div>
							<div class="td2_div5_linkman">联系人：<input type="text" maxlength="100" name="linkman" value=""></div>
							<span class="span_title">验收标准：</span>
							<div class="td2_div6">质保期为：<input type="text" maxlength="2" name="checkout_time" value="" oninput="checkIntPosition(this)">年</div>
							<div class="td2_div9">
								<div>
									<div class="td2_div9_top">甲&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;方</div>
									<div class="td2_div9_name"><span>单位名称（章）：</span><input type="text" maxlength="100" name="company_name1" value="浙江中自庆安新能源技术有限公司"></div>
									<div class="td2_div9_address"><span>单位地址：</span><input type="text" maxlength="200" name="company_address1" value="杭州经济技术开发区6号大街260号1幢"></div>
									<div class="td2_div9_postalcode"><span>邮政编码：</span><input type="text" maxlength="10" name="postal_code1" value="310018"></div>
									<div class="td2_div9_person"><span>法定代表人：</span><input type="text" maxlength="100" name="law_person1"><span>委托代理人：</span><input type="text" maxlength="100" name="entrusted_agent1"></div>
									<div class="td2_div9_phone"><span>电 话：</span><input type="text" maxlength="20" name="phone1"value="0571-28995840"><span>传 真：</span><input type="text" maxlength="20" name="fax1" value="0571-28995841"></div>
									<div class="td2_div9_bank"><span>开户行：</span><input type="text" maxlength="100" name="bank1" value="中国银行杭州出口加工区支行"></div>
									<div class="td2_div9_accoun"><span>公司账号：</span><input type="text" maxlength="50" name="company_account1" value="354558327795"></div>
									<div class="td2_div9_tariffitem"><span>税 号：</span><input type="text" maxlength="100" name="tariff_item1" value="91330101557941713M"></div>
								</div>
								<div>
									<div class="td2_div9_top">乙&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;方</div>
									<div class="td2_div9_name"><span>单位名称（章）：</span><input type="text" maxlength="100" name="company_name2" style="border:0" readonly="readonly"></div>
									<div class="td2_div9_address"><span>单位地址：</span><input type="text" maxlength="200" name="company_address2"></div>
									<div class="td2_div9_postalcode"><span>邮政编码：</span><input type="text" maxlength="10" name="postal_code2"></div>
									<div class="td2_div9_person"><span>法定代表人：</span><input type="text" maxlength="100" name="law_person2"><span>委托代理人：</span><input type="text" maxlength="100" name="entrusted_agent2"></div>
									<div class="td2_div9_phone"><span>电 话：</span><input type="text" maxlength="20" name="phone2"><span>传 真：</span><input type="text" maxlength="20" name="fax2"></div>
									<div class="td2_div9_bank"><span>开户行：</span><input type="text" maxlength="100" name="bank2"></div>
									<div class="td2_div9_accoun"><span>公司账号：</span><input type="text" maxlength="50" name="company_account2"></div>
									<div class="td2_div9_tariffitem"><span>税 号：</span><input type="text" maxlength="100" name="tariff_item2"></div>
								</div>
							</div>
						</div>
						<div class="div_btn " style="display:none">
						<img src="images/submit_materials.png" class="btn_agree" onclick="selectPurchase()">
						<a href="<%=basePath%>flowmanager/create_purchaseflow.jsp"><img src="images/cancle_materials.png" class="btn_agree"></a>
						</div>
					</form>
				</td>
			</tr>
		</table>
	</div>
	<div class="dialog_product" id="dialog_apply">
		<div class="product_top"><span>序号：</span><span></span></div>
		<div class="product_div"><span>销售合同：</span><div></div></div>
		<div class="product_div"><span>客户名称：</span><div></div></div>
		<div class="product_div"><span>项目名称：</span><div></div></div>
		<div class="product_div"><span>型号：</span><div></div></div>
		<div class="product_div"><span>预估成本：</span><div></div></div>
		<div class="product_div"><span>合同数量：</span><div></div></div>
		<div class="product_div"><span>含税销售单价：</span><div></div></div>
		<div class="product_div"><span>未采购数量：</span><div></div></div>
		<div class="product_div"><span>本次采购数量：</span><input type="text" name="purchase_num" maxlength="9" oninput="checkIntPosition(this)"></div>
		<div class="product_bottom"><img src="images/cancle_materials.png" onclick="closeApplyDialog(0)"><img src="images/submit_materials.png" onclick="closeApplyDialog(2)"></div>
	</div>
	<div class="dialog_product" id="dialog_apply2">
	<div class="dislog_cover"></div>
		<div class="product_top"><span>序号：</span><span></span></div>
		<div class="product_div product_model" ><span>销售合同：</span>
				<div>
					<jsp:include page="/flowmanager/drop_down_contract.jsp" />
				</div>
			</div>
			<div class="product_div product_model" ><span>型号：</span>
				<div>
					<jsp:include page="/flowmanager/drop_down_model.jsp" />
				</div>
			</div>
		<div class="product_div"><span>数量：</span><input type="text" maxlength="8" oninput="checkIntPosition(this)"></div>
		<div class="product_div"><span>预计含税成本：</span><input type="text" maxlength="8" oninput="checkFloatPositive(this,2)"></div>
		<div class="product_div"><span>含税单价：</span><input type="text" maxlength="8" oninput="checkFloatPositive(this,2)"></div>
		<div class=product_div><span>交货期：</span><input type="text" readonly="readonly" style="width:100px;" value="<c:out value='${today}'></c:out>" id="dialog_time" onclick="return Calendar('dialog_time');"  ></div>
		<div class="product_div"><span>备注：</span><textarea maxlength="200"></textarea></div>
		<div class="product_bottom"><img src="images/cancle_materials.png" onclick="closeApplyDialog2(0)"><img src="images/submit_materials.png" onclick="closeApplyDialog(2)"></div>
	</div>
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
		<div class="product_bottom"><img src="images/cancle_materials.png" onclick="closePurchaseDialog(0)"><img src="images/submit_materials.png" onclick="closePurchaseDialog(2,true)"><img src="images/del_materials.png"  onclick="closePurchaseDialog(1)"></div>
	</div>
</body>
</html>
