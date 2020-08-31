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
	Purchase_noteManager purchase_noteManager=(Purchase_noteManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("purchase_noteManager");
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
	if (session.getAttribute("purchase_id") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int purchase_id = (Integer) session.getAttribute("purchase_id");
	Purchase_contract purchase_contract=purchase_contractManager.getPurchase_contractByID(purchase_id);
	Flow flow=flowManager.getNewFlowByFID(12, purchase_id);
	if(flow==null||purchase_contract==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int operation=flow.getOperation();
	int applyNum=purchase_contractManager.getPurchaseApplyNum(purchase_contract);
	//产品已购数量不包含当前的(流程未结束的)采购合同所采购的数量,若为审批完成后又修改了且此时还没审批结束，contract_num中记录已采购数量
	boolean applyFinished=operation==10||operation==12||operation==13
		||operation==4&&applyNum==2||operation==6&&applyNum==3||operation==8&&applyNum>3;
	List<Purchase_note> noteList=purchase_noteManager.getPurchase_notesByPID(purchase_id, applyFinished);
	pageContext.setAttribute("mUser", mUser);
	pageContext.setAttribute("purchase_contract", purchase_contract);
	pageContext.setAttribute("operation",operation);
	pageContext.setAttribute("noteList", noteList);
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>产品采购合同书</title>
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
<script  type="text/javascript" src="js/purchase.js"></script>
<!--[if IE]>
	<script src="js/html5shiv.min.js" type="text/javascript"></script>
<![endif]-->
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
		var type=<%=purchase_contract.getType()%>;
		$(function(){
			var purchase_td_selected=getCookie("purchase_td_selected");
			initTD();
			syncDIVHeight();
			var purchase_td_selectedArray=purchase_td_selected.split("");
			var k=0;
			var temp='';
			var bigIndex=$(".product_tr1>td").length-1;
			$(".product_tr1>td").each(function(){
				var even=k%2==0;//偶数
				if(even){
					temp+='<div class="dialog_sales_group">';
				}
				temp+='<div><input type="checkbox" id="td_checkbox'+k+'" class="chk_1" onchange="userCheckedChange('+k+')">'
					+'<label for="td_checkbox'+k+'"></label>'
					+'<div onclick="sameClick('+k+');">'+$(this).text().trim()+'</div></div>'
				checkedArray[k]=purchase_td_selectedArray&&purchase_td_selectedArray.length>k?purchase_td_selectedArray[k]==1:true;
				if(++k==length||(!even)){
					temp+='</div>';
				}
			});
			closeDialog(1);
			$(".del_notify_div_img").after(temp);
		});
		/***
		  *初始化表格序号 1,2,3。。。，第二行开始， 最大值为tr数减1
		  *计算整单毛利
		  *整单毛利=（不含税金额总和-预估含税成本总和/1.17）/不含税金额总和
		  **/
		function initTD(){
			var contract_price=0.0;//合同总价
			$(".product_tr2").each(function(){
				if(type==1){
					var unit_price_taxes=parseFloat($(this).children("td:eq(8)").text().trim());
					var num=parseInt($(this).children("td:eq(7)").text().trim());
					var price_taxes=unit_price_taxes*num;
					var price=unit_price_taxes/1.17*num;
					var predict_costing_taxes=parseFloat($(this).children("td:eq(9)").text().trim());
					var unit_price=unit_price_taxes/1.17;
					var unit_gross_profit=Math.round((unit_price-predict_costing_taxes/1.17)/unit_price*1000)/10+"%";
					//单行毛利=（不含税单价-预估含税成本/1.17）/不含税单价
					$(this).children("td:eq(12)").text(Math.round(unit_price*100)/100);
					$(this).children("td:eq(13)").text(Math.round(price_taxes*100)/100);
					$(this).children("td:eq(14)").text(Math.round(price*100)/100);
					$(this).children("td:eq(15)").text(unit_gross_profit);
					contract_price+=price_taxes;
				}else{
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
				}
			});
			contract_price=Math.round(contract_price*100)/100;
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
				var purchase_td_selected="";
				for(var i =0;i<checkedArray.length;i++){
					if(checkedArray[i]){
						purchase_td_selected+="1";
						$(".product_tr2").each(function(){
							$(this).children("td:eq("+i+")").css("display","table-cell");
						});
						$(".product_tr1 td:eq("+i+")").css("display","table-cell");
					}else{
						purchase_td_selected+="0";
						$(".product_tr2").each(function(){
							$(this).children("td:eq("+i+")").css("display","none");
						});
						$(".product_tr1 td:eq("+i+")").css("display","none");
					}
				}
				setCookie("purchase_td_selected",purchase_td_selected);
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
		<div class="td2_div1"><c:out value="${purchase_contract.company_name1}"></c:out><br/>产品采购合同书</div>
		<div class="contract_title">
		<div><span class="name1">甲方：</span><span class="name2"><c:out value="${purchase_contract.company_name1}"></c:out></span></div>
		<div><span class="address1">合同编号：</span><span class="address2"><c:out value="${purchase_contract.contract_no}"></c:out></span></div>
		</div>
		<div class="contract_title">
		<div><span class="name1">乙方：</span><span class="name2"><c:out value="${purchase_contract.company_name2}"></c:out></span></div>
		<div><span class="address1">签订地点：</span><span class="address2">杭州</span></div>
		</div>
		<div class="contract_word">
		&nbsp;&nbsp;根据《中华人民共和国合同法》及其他有关法律法规，遵循平等、自愿、公平和诚实信用的原则，甲、乙双方在协商一致的基础上，订立本合同以共同遵守。
		</div>
		<div class="contract_chose">
		<div onclick="showDialog();">查 选</div>
		</div>
		<div class="contract_word">
			<div class="float_left_title1">
			一、产品信息：
		</div>
		<div class="float_right_title1">
		签订时间：<%=new SimpleDateFormat("yyyy年MM月dd日").format(purchase_contract.getSign_time()) %>
		</div>
		</div>
		<table class="product_tab">
			<tr class="product_tr1">
				<td style="width:30px;">序号</td>
				<c:if test="${purchase_contract.type==1}">
				<td>销售合同</td>
				<td>客户名称</td>
				<td>项目名称</td>
				</c:if>
				<td style="min-width:60px;">物料编码</td>
				<td style="min-width:60px;">产品描述</td>
				<td style="min-width:60px;">型号</td>
				<td style="width:40px;">数量</td>
				<td>含税单价</td>
				<td>预计含税成本</td>
				<td style="min-width: 70px;">交货期</td>
				<td style="min-width:60px;">备注</td>
				<td>不含税单价</td>
				<td>含税金额</td>
				<td>不含税金额</td>
			</tr>
			<c:forEach items="${noteList}" var="note" varStatus="status">
			<tr class="product_tr2">
			<td><c:out value="${status.count}"></c:out></td>
			<c:if test="${purchase_contract.type==1}">
				<td class="tooltip_div"><c:out value="${note.contract_no}"></c:out></td>
				<td class="tooltip_div"><c:out value="${note.customer}"></c:out></td>
				<td class="tooltip_div"><c:out value="${note.project_name}"></c:out></td>
			</c:if>
			<td class="tooltip_div"><c:out value="${note.materials_id}"></c:out></td>
			<td class="tooltip_div"><c:out value="${note.materials_remark}"></c:out></td>
			<td class="tooltip_div"><c:out value="${note.model}"></c:out></td>
			<td class="tooltip_div"><c:out value="${note.num}"></c:out></td>
			<td class="tooltip_div"><c:out value="${note.unit_price_taxes_str}"></c:out></td>
			<td class="tooltip_div"><c:out value="${note.predict_costing_taxes_str}"></c:out></td>
			<td class="tooltip_div"><c:out value="${note.delivery_date}"></c:out></td>
			<td class="tooltip_div"><c:out value="${note.remark}"></c:out></td>
			<td class="tooltip_div"></td>
			<td class="tooltip_div"></td>
			<td class="tooltip_div"></td>
			</tr>
			</c:forEach>
			<tr class="product_tr3" >
				<td colspan="<c:out value='${purchase_contract.type==1?15:12}'></c:out>" style="text-align:left">合同总价：￥</td>
			</tr>
			<tr class="product_tr3" >
				<td colspan="<c:out value='${purchase_contract.type==1?15:12}'></c:out>"  style="text-align:left">大写：含税大写人民币元整（￥）。</td>
			</tr>
		</table>
		<div class="contract_word">
			<div>二、付款方式：${purchase_contract.payment_value}</div>
			<div>三、本合同额包含设备费、包装费、运费、保险费及税费。</div>
			<div>四、交（提）货：</div>
			<div class="contract_word_son"><div>1.</div><div>货物在运输途中的损毁、灭失等一切损失由乙方负责。</div></div>
			<div class="contract_word_son"><div>2.</div><div>包装应符合规定要求，包装费由乙方承担，包装物不回收。</div></div>
			<div class="contract_word_son"><div>3.</div><div>甲方未能按时提货时，乙方没有征得甲方书面认可，不得将货物另行处理。</div></div>
			<div class="contract_word_son"><div>4.</div><div>到货时间/地点：<c:out value="${purchase_contract.aog_time_address}"></c:out>，联系人：<c:out value="${purchase_contract.linkman}"></c:out>。</div></div>
			<div class="contract_word_son"><div>5.</div><div>验收标准以国家相关标准、行业标准或乙方企业标准为依据，当标准条款存在抵触时，以上一级标准为准。</div></div>
			<div>五、验收标准：根甲方的检验标准和图纸要求进行验收，质保期为<c:out value='${purchase_contract.checkout_time}'></c:out>年。</div>
			<div>六、违约责任：</div>
			<div class="contract_word_son"><div>1.</div><div>如乙方不能按甲方要求按期供货导致甲方损失，甲方有权更换其他供货厂家且不承担违约责任。</div></div>
			<div class="contract_word_son"><div>2.</div><div>由于乙方原因导致所交的货物达不到甲方要求的，甲方有权要求乙方作换货或退货处理，由此产生的运输、修理、生产等损失由乙方承担。</div></div>
			<div class="contract_word_son"><div>3.</div><div>乙方不能按时交货或标的物因质量、服务原因不能按时投用的，每延误 1 天乙方向甲方支付合同额的 1% 作为赔偿。</div></div>
			<div>七、其他约定：</div>
			<div class="contract_word_son"><div>1.</div><div>本合同附件是本合同的组成部分，与本合同具有同等法律效力。</div></div>
			<div class="contract_word_son"><div>2.</div><div>因不可抗力（双方无法预见、无法避免并无法克服的客观情况）导致本合同无法履行，双方互不承担责任，任何一方都有权解除合同。</div></div>
			<div class="contract_word_son"><div>3.</div><div>本合同未尽事宜，双方可签订补充协议，本合同与补充协议不一致的地方，以补充协议为准。</div></div>
			<div class="contract_word_son"><div>4.</div><div>本合同项下发生的争议，由双方当事人协商解决，也可以由当地工商行政管理部门调解。协商或调解不成的，由甲方所在地人民法院管辖。</div></div>
			<div class="contract_word_son"><div>5.</div><div>本合同自甲、乙双方签字盖章之日起生效。</div></div>
			<div class="contract_word_son"><div>6.</div><div>本合同一式二份，双方各执一份，传真件有效。</div></div>
		</div>
		
		<div class="td2_div9">
			<div>
				<div class="td2_div9_top">甲&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;方</div>
				<div class="td2_div9_name"><span>单位名称（章）：</span><div><c:out value='${purchase_contract.company_name1}'></c:out></div></div>
				<div class="td2_div9_address"><span>单位地址：</span><div><c:out value='${purchase_contract.company_address1}'></c:out></div></div>
				<div class="td2_div9_postalcode"><span>邮政编码：</span><div><c:out value='${purchase_contract.postal_code1}'></c:out></div></div>
				<div class="td2_div9_person"><span>法定代表人：</span><div><c:out value='${purchase_contract.law_person1}'></c:out></div><span>委托代理人：</span><div><c:out value='${purchase_contract.entrusted_agent1}'></c:out></div></div>
				<div class="td2_div9_phone"><span>电 话：</span><div><c:out value='${purchase_contract.phone1}'></c:out></div><span>传 真：</span><div><c:out value='${purchase_contract.fax1}'></c:out></div></div>
				<div class="td2_div9_bank"><span>开户行：</span><div><c:out value='${purchase_contract.bank1}'></c:out></div></div>
				<div class="td2_div9_accoun"><span>公司账号：</span><div><c:out value='${purchase_contract.company_account1}'></c:out></div></div>
				<div class="td2_div9_tariffitem"><span>税 号：</span><div><c:out value='${purchase_contract.tariff_item1}'></c:out></div></div>
			</div>
			<div>
				<div class="td2_div9_top">乙&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;方</div>
				<div class="td2_div9_name"><span>单位名称（章）：</span><div><c:out value='${purchase_contract.company_name2}'></c:out></div></div>
				<div class="td2_div9_address"><span>单位地址：</span><div><c:out value='${purchase_contract.company_address2}'></c:out></div></div>
				<div class="td2_div9_postalcode"><span>邮政编码：</span><div><c:out value='${purchase_contract.postal_code2}'></c:out></div></div>
				<div class="td2_div9_person"><span>法定代表人：</span><div><c:out value='${purchase_contract.law_person2}'></c:out></div><span>委托代理人：</span><div><c:out value='${purchase_contract.entrusted_agent2}'></c:out></div></div>
				<div class="td2_div9_phone"><span>电 话：</span><div><c:out value='${purchase_contract.phone2}'></c:out></div><span>传 真：</span><div><c:out value='${purchase_contract.fax2}'></c:out></div></div>
				<div class="td2_div9_bank"><span>开户行：</span><div><c:out value='${purchase_contract.bank2}'></c:out></div></div>
				<div class="td2_div9_accoun"><span>公司账号：</span><div><c:out value='${purchase_contract.company_account2}'></c:out></div></div>
				<div class="td2_div9_tariffitem"><span>税 号：</span><div><c:out value='${purchase_contract.tariff_item2}'></c:out></div></div>
			</div>
		</div>
		<!--endprint1-->
			<c:if test="${operation==10}">
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
