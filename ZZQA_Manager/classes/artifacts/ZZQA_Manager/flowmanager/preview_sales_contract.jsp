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
<%@page import="com.zzqa.pojo.operation.Operation"%>
<%@page import="com.zzqa.pojo.product_info.Product_info"%>
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
	List<Product_info> product_infoList=product_infoManager.getProduct_infos(sales_id);
	int operation=flow.getOperation();
	pageContext.setAttribute("mUser", mUser);
	pageContext.setAttribute("sales_contract", sales_contract);
	pageContext.setAttribute("operation",operation);
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
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>产品购销合同书</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
<link rel="stylesheet" type="text/css" href="css/top.css">
<link rel="stylesheet" type="text/css" href="css/preview_sales_contract.css">
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
		$(function(){
			var k=0;
			var temp='';
			var bigIndex=$(".product_tr1>td").length-1;
			initTD();
			syncDIVHeight();
			var sales_td_selected=getCookie("sales_td_selected");
			var sales_td_selectedArray=sales_td_selected.split("");
			$(".product_tr1>td").each(function(){
				var even=k%2==0;//偶数
				if(even){
					temp+='<div class="dialog_sales_group">';
				}
				temp+='<div><input type="checkbox" id="td_checkbox'+k+'" class="chk_1" onchange="userCheckedChange('+k+')">'
					+'<label for="td_checkbox'+k+'"></label>'
					+'<div onclick="sameClick('+k+');">'+$(this).text().trim()+'</div></div>'
				checkedArray[k]=sales_td_selectedArray&&sales_td_selectedArray.length>k?sales_td_selectedArray[k]==1:true;
				if(++k==length||(!even)){
					temp+='</div>';
				}
			});
			$(".del_notify_div_img").after(temp);
			for(var i=0;i<checkedArray.length;i++){
				$(".dialog_sales input:eq("+i+")").prop("checked",checkedArray[i]);
			};
			closeDialog(1);
		});
		/***
		  *初始化表格序号 1,2,3。。。，第二行开始， 最大值为tr数减1
		  *计算整单毛利
		  *整单毛利=（不含税金额总和-预估含税成本总和/1.17）/不含税金额总和
		  **/
		function initTD(){
			var contract_price=0;//合同总价
			$(".product_tr2").each(function(){
				var unit_price_taxes=parseFloat($(this).children("td:eq(5)").text().trim());
				var num=parseInt($(this).children("td:eq(4)").text().trim());
				var price_taxes=unit_price_taxes*num;
				var price=unit_price_taxes/1.17*num;
				var predict_costing_taxes=parseFloat($(this).children("td:eq(6)").text().trim());
				var unit_price=unit_price_taxes/1.17;
				var unit_gross_profit=Math.round((unit_price-predict_costing_taxes/1.17)/unit_price*1000)/10+"%";
				//单行毛利=（不含税单价-预估含税成本/1.17）/不含税单价
				$(this).children("td:eq(9)").text(Math.round(unit_price*100)/100);
				$(this).children("td:eq(10)").text(Math.round(price_taxes*100)/100);
				$(this).children("td:eq(11)").text(Math.round(price*100)/100);
				$(this).children("td:eq(12)").text(unit_gross_profit);
				contract_price+=price_taxes;
			});
			$(".product_tr3:eq(0) td").text("合同总价：￥"+contract_price);
			$(".product_tr3:eq(1) td").text("大写："+DX(contract_price));
		}
		function preview(){
			$(".dialog_sales").css("display","none");
			$(".contract_chose").css("display","none");
			$(".div_dashed").css("display","none");
			$(".parent_div").css("padding","5px");
			$(".div_btn").css("display","none");
			$("body").css("background","#fff");
			window.print(); 
			$(".contract_chose").css("display","block");
			$(".parent_div").css("padding","25px");
			$("body").css("background","#f0f4f7");
			$(".div_dashed").css("display","block");
			$(".div_btn").css("display","block");
		}
		function showDialog(){
			var top_val=$(window).scrollTop()+150+"px";
			$(".dialog_sales").css("top",top_val);
			if($(".dialog_sales_bg").length==0){
				$("body").append('<div class="dialog_sales_bg"></div>');
			}
			for(var i=0;i<checkedArray.length;i++){
				$(".dialog_sales input:eq("+i+")").prop("checked",checkedArray[i]);
			};
			$(".dialog_sales_bg").css("display","block");
			$(".dialog_sales").css("display","block");
		}
		var checkedArray=new Array();
		function closeDialog(btn_id){
			if(btn_id==1){
				$(".chk_1").each(function(){
	    			var i=$(this).attr("id").replace("td_checkbox","");
	    			checkedArray[parseInt(i)]=$(this).prop("checked");
	    		});
				var sales_td_selected="";
				for(var i =0;i<checkedArray.length;i++){
					if(checkedArray[i]){
						sales_td_selected+="1";
						$(".product_tr2").each(function(){
							$(this).children("td:eq("+i+")").css("display","table-cell");
						});
						$(".product_tr1 td:eq("+i+")").css("display","table-cell");
					}else{
						sales_td_selected+="0";
						$(".product_tr2").each(function(){
							$(this).children("td:eq("+i+")").css("display","none");
						});
						$(".product_tr1 td:eq("+i+")").css("display","none");
					}
				}
				setCookie("sales_td_selected",sales_td_selected);
			}
			$(".dialog_sales_bg").css("display","none");
			$(".dialog_sales").css("display","none");
		}
		function sameClick(id){
	    	if($("#td_checkbox"+id).prop("checked")){
	    		var canClick=false;
	    		$(".chk_1").each(function(){
	    			var i=$(this).attr("id").replace("td_checkbox","");
	    			if($(this).prop("checked")&&id!=i){
	    				canClick=true;
	    			}
	    		})
		    	if(canClick){
		    		//必须保留一个
		    		$("#td_checkbox"+id).prop("checked",false);
		    	}else{
		    		initdiglog2("提示信息", "请至少选择一列")
		    	}
	    	}else{
	    		$("#td_checkbox"+id).prop("checked",true);
	    	}
	    }
	    function userCheckedChange(id){
	    	if(!($("#td_checkbox"+id).prop("checked"))){
	    		var canClick=false;
	    		$(".chk_1").each(function(){
	    			var i=$(this).attr("id").replace("td_checkbox","");
	    			if($(this).prop("checked")&&id!=i){
	    				canClick=true;
	    			}
	    		})
		    	if(!canClick){
		    		$("#td_checkbox"+id).prop("checked",true);
		    		initdiglog2("提示信息", "请至少选择一列");
		    	}
	    	}
	    }
	</script>
</head>

<body>
	<!--startprint1-->
	<div class="parent_div">
		<div class="td2_div1">产品购销合同书</div>
		<div class="contract_title">
		<div><span class="name1">供方：</span><span class="name2"><c:out value="${sales_contract.company_name1}"></c:out></span></div>
		<div><span class="address1">合同编号：</span><span class="address2"><c:out value="${sales_contract.contract_no}"></c:out></span></div>
		</div>
		<div class="contract_title">
		<div><span class="name1">需方：</span><span class="name2"><c:out value="${sales_contract.company_name2}"></c:out></span></div>
		<div><span class="address1">签订地点：</span><span class="address2">杭州</span></div>
		</div>
		<div class="contract_word">
		&nbsp;&nbsp;供、需双方本着平等互利、等价有偿、诚实信用的原则，在协商一致的基础上，需方向供方订购下列货物，经双方协商签订合同如下：
		</div>
		<div class="contract_chose">
		<div onclick="showDialog();">查 选</div>
		</div>
		<div class="contract_word">
			<div class="float_left_title1">
			一、产品信息：
		</div>
		<div class="float_right_title1">
		签订时间：<%=new SimpleDateFormat("yyyy年MM月dd日").format(sales_contract.getSign_time()) %>
		</div>
		</div>
		<table class="product_tab">
			<tr class="product_tr1">
				<td>序号</td>
				<td>物料编码</td>
				<td>产品描述</td>
				<td>型号</td>
				<td>数量</td>
				<td>含税销售单价</td>
				<td>预计含税成本</td>
				<td style="width:60px">交货期</td>
				<td>备注</td>
				<td>不含税销售单价</td>
				<td>含税金额</td>
				<td>不含税金额</td>
				<td>单行毛利</td>
			</tr>
			<c:forEach items="${product_infoList}" var="product_info" varStatus="status">
			<tr class="product_tr2">
			<td><c:out value="${status.count}"></c:out></td>
			<td class="tooltip_div"><c:out value="${product_info.materials_id}"></c:out></td>
			<td class="tooltip_div"><c:out value="${product_info.materials_remark}"></c:out></td>
			<td class="tooltip_div"><c:out value="${product_info.model}"></c:out></td>
			<td class="tooltip_div"><c:out value="${product_info.num}"></c:out></td>
			<td class="tooltip_div"><c:out value="${product_info.unit_price_taxes_str}"></c:out></td>
			<td class="tooltip_div"><c:out value="${product_info.predict_costing_taxes_str}"></c:out></td>
			<td class="tooltip_div"><c:out value="${product_info.delivery_date}"></c:out></td>
			<td class="tooltip_div"><c:out value="${product_info.remark}"></c:out></td>
			<td class="tooltip_div"></td>
			<td class="tooltip_div"></td>
			<td class="tooltip_div"></td>
			<td class="tooltip_div"></td>
			</tr>
			</c:forEach>
			<tr class="product_tr3" >
				<td colspan="13" ></td>
			</tr>
			<tr class="product_tr3" >
				<td colspan="13"></td>
			</tr>
		</table>
		<div class="contract_word">
			<c:if test="${sales_contract.payment_method==1}">
				<div>二、付款方式：合同签订后<c:out value='${payment_value1}'></c:out>个工作日内， 需方支付合同总额的<c:out value='${payment_value2}'></c:out>%预付款后合同生效；发货前支付合同总额的<c:out value='${payment_value3}'></c:out>%， 款到3个工作内发货；到货后支付合同总额的<c:out value='${payment_value4}'></c:out>%作为到货款；合同总额的<c:out value='${payment_value5}'></c:out>%，作为质保金在质保期满七天内付清。</div>
			</c:if>
			<c:if test="${sales_contract.payment_method==2}">
				<div>二、付款方式：发货前支付全款，款到后供方发货并开具合同全额发票（17%增值税专用发票）。</div>
			</c:if>
			<c:if test="${sales_contract.payment_method==3}">
				<div>二、付款方式：货到票到<c:out value='${payment_value1}'></c:out>天内以电汇方式支付合同全款（17%增值税专用发票）。</div>
			</c:if>
			<div>三、运输方式和费用负担：运输方式：<c:out value='${sales_contract.shipping_method}'></c:out>；运费由<c:out value='${sales_contract.expense_burden}'></c:out>方负担。</div>
			<div>四、包装标准、包装物的供应与回收：包装符合规定要求，保障运输途中的安全，运输途中的一切损失由供方负责，包装费用由供方负担，包装物不回收。</div>
			<div>五、交（提）货地点：<c:out value='${sales_contract.delivery_points}'></c:out>设备到达需方现场，由需方自行负责卸货并妥善保管。</div>
			<div>六、验收标准与时间：产品检收标准以中自庆安企业标准和国家相关标准为准。到货后<c:out value='${inspect_time1}'></c:out>个工作日内需方完成检验，如超过<c:out value='${inspect_time2}'></c:out>个工作日未检验视为验收通过。</div>
			<div>七、系统设备详细清单见附件清单。随机备品配件、专用工具额量和供应办法：无。</div>
			<div>八、供方对质量保修及服务承诺：（1）免费保修期为<c:out value='${service_promise1}'></c:out>年（或为到货后<c:out value='${service_promise2}'></c:out>个月内，以先到为准）。保修期内由于产品质量问题产生的服务费用由供方承担。需方需要现场服务，供方<c:out value='${service_promise3}'></c:out>小时内响应。</div>
			<div>九、合同纠纷解决：如本合同发生争议双方协商解决， 协商不成可依照《合同法》规定处理。若须提交诉讼的，由供方所在地人民法院管辖。</div>
			<div>十、本合同一式肆份，双方各持贰份。</div>
			<div>十一、该项目最终用户/装置名称：<c:out value='${sales_contract.company_name2}'></c:out><c:if test="${fn:length(sales_contract.project_name)>0}">,</c:if><c:out value='${sales_contract.project_name}' escapeXml="false"></c:out>。</div>
			<div>十二、其他约定事项：未尽事宜，双方协商解决。 </div>
		</div>
		
		<div class="td2_div9">
			<div>
				<div class="td2_div9_top">供 方</div>
				<div class="td2_div9_name"><span>单位名称（章）：</span><div><c:out value='${sales_contract.company_name1}'></c:out></div></div>
				<div class="td2_div9_address"><span>单位地址：</span><div><c:out value='${sales_contract.company_address1}'></c:out></div></div>
				<div class="td2_div9_postalcode"><span>邮政编码：</span><div><c:out value='${sales_contract.postal_code1}'></c:out></div></div>
				<div class="td2_div9_person"><span>法定代表人：</span><div><c:out value='${sales_contract.law_person1}'></c:out></div><span>委托代理人：</span><div><c:out value='${sales_contract.entrusted_agent1}'></c:out></div></div>
				<div class="td2_div9_phone"><span>电 话：</span><div><c:out value='${sales_contract.phone1}'></c:out></div><span>传 真：</span><div><c:out value='${sales_contract.fax1}'></c:out></div></div>
				<div class="td2_div9_bank"><span>开户行：</span><div><c:out value='${sales_contract.bank1}'></c:out></div></div>
				<div class="td2_div9_accoun"><span>公司账号：</span><div><c:out value='${sales_contract.company_account1}'></c:out></div></div>
				<div class="td2_div9_tariffitem"><span>税 号：</span><div><c:out value='${sales_contract.tariff_item1}'></c:out></div></div>
			</div>
			<div>
				<div class="td2_div9_top">需 方</div>
				<div class="td2_div9_name"><span>单位名称（章）：</span><div><c:out value='${sales_contract.company_name2}'></c:out></div></div>
				<div class="td2_div9_address"><span>单位地址：</span><div><c:out value='${sales_contract.company_address2}'></c:out></div></div>
				<div class="td2_div9_postalcode"><span>邮政编码：</span><div><c:out value='${sales_contract.postal_code2}'></c:out></div></div>
				<div class="td2_div9_person"><span>法定代表人：</span><div><c:out value='${sales_contract.law_person2}'></c:out></div><span>委托代理人：</span><div><c:out value='${sales_contract.entrusted_agent2}'></c:out></div></div>
				<div class="td2_div9_phone"><span>电 话：</span><div><c:out value='${sales_contract.phone2}'></c:out></div><span>传 真：</span><div><c:out value='${sales_contract.fax2}'></c:out></div></div>
				<div class="td2_div9_bank"><span>开户行：</span><div><c:out value='${sales_contract.bank2}'></c:out></div></div>
				<div class="td2_div9_accoun"><span>公司账号：</span><div><c:out value='${sales_contract.company_account2}'></c:out></div></div>
				<div class="td2_div9_tariffitem"><span>税 号：</span><div><c:out value='${sales_contract.tariff_item2}'></c:out></div></div>
			</div>
		</div>
		<!--endprint1-->
			<c:if test="${operation==12}">
		<div class="div_dashed"><div></div><div>分割线</div><div></div></div>
		<div class="div_btn">
			<img src="images/print.jpg" class="btn_agree" onclick="preview();">
		</div>
		</c:if>
	</div>
	<div class="dialog_sales">
		<div class="del_notify_div_img" onclick="closeDialog(0)"></div>
		<div class="sales_bottom"><div onclick="closeDialog(1)">确定</div></div>
	</div>
</body>
</html>
