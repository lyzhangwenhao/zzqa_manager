<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page
	import="com.zzqa.service.interfaces.materials_info.Materials_infoManager"%>
<%@page import="com.zzqa.pojo.materials_info.Materials_info"%>
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
	pageContext.setAttribute("today",new SimpleDateFormat("yyyy/M/d").format(System.currentTimeMillis()));
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>新建销售合同</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/top.css">
<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
<link rel="stylesheet" type="text/css" href="css/create_salesflow.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
<link rel="stylesheet" type="text/css" href="css/custom.css">
<link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
<link rel="stylesheet" type="text/css" href="css/default.css">
<link rel="stylesheet" type="text/css"
	href="css/jquery.filer-dragdropbox-theme.css">
<link rel="stylesheet" type="text/css"
	href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/bootstrap/bootstrap.min.css">
<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/prettify.js" type="text/javascript"></script>
<script src="js/jquery.filer.min.js" type="text/javascript"></script>

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
<script type="text/javascript" src="js/contract.js"></script>
<!-- 现将隐藏的文件上传控件添加到body中，再渲染 -->
<script src="js/custom.js" type="text/javascript"></script>
<!--[if IE]>
	<script src="js/html5shiv.min.js" type="text/javascript"></script>
<![endif]-->
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
		var today="<%=DataUtil.getTadayStr() %>"; 
		$(function(){
			//选中一个客户，拉去信息，填到需方
			$("#bts-ex-4 li.filter-item.items").click(function(){
				setSupplier($(this).attr("data-value"));
			});
			useFile(true);
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
		function getMaterialsByID(id){
			for(var i=0;i<materialsArray.length;i++){
				if(materialsArray[i][0]==id){
					return materialsArray[i];
				}
			}
			return new Array();
		}
		function getMaterialsByModel(model){
			for(var i=0;i<materialsArray.length;i++){
				if(materialsArray[i][2]==model){
					return materialsArray[i];
				}
			}
			return new Array();
		} 
		/**初始化表格样式**/
		function initTR(){
			var index=0;
			$(".product_tab tr:gt(0)").each(function(){
				if(index++%2==0){
					$(this).attr("class","product_tr2");
				}else{
					$(this).attr("class","product_tr3");
				}
			});
			$(".product_tr2").unbind("click").click(function(){
				showDialog($(this));
			});
			$(".product_tr3").unbind("click").click(function(){
				showDialog($(this));
			});
		}
		/***
		  *初始化表格序号 1,2,3。。。，第二行开始， 最大值为tr数减1
		  *计算整单毛利
		  *整单毛利=（不含税金额总和-预估含税成本总和/1.17）/不含税金额总和
		  **/
		function initTD(){
			initTR();
			var k=0;
			//-预估含税成本总和
			var all_pvt=0.0;
			//不含税金额总和
			var all_prices=0.0;
			$(".product_tab tr:gt(0)").each(function(){
				$(this).children("td:eq(0)").text(++k);
				var pvt=parseFloat($(this).children("td:eq(6)").text().trim());
				var num=parseInt($(this).children("td:eq(4)").text().trim());
				all_prices+=parseFloat($(this).children("td:eq(5)").text().trim())*num;
				all_pvt+=pvt*num;
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
				if($("#delproduct").length==0){
					$(".product_bottom").append('<img src="images/del_materials.png" id="delproduct" onclick="closeDialog(1)">');
				}
				//初始化下拉选择框
				var modelArray=getMaterialsByModel(materials_model);
				$("#bts-ex-5 li[data-value='"+modelArray[0]+"']").click();
				$("#dialog_num").val(num);
				$("#dialog_upt").val(unit_price_taxes);
				$("#dialog_pct").val(predict_costing_taxes);
				$("#dialog_time").val(time);
				$("#dialog_remark").val(remark);
			}else{
				//添加
				nowTR=null;
				$(".product_top").remove();
				$("#delproduct").remove();
			}
			if($(".dialog_product_bg").length==0){
				$("body").append('<div class="dialog_product_bg"></div>');
			}
			$(".dialog_product_bg").css("display","block");
			$(".dialog_product").css("display","block");
		}
		function closeDialog(btn_id){
			if(btn_id==1){
				//删除
				initdiglogtwo2("提示信息","你确定要删除该产品吗？");
		   		$( "#confirm2" ).click(function() {
					$( "#twobtndialog" ).dialog( "close" );
					nowTR.remove();
					initTD();
					initDialogVal();
				});
		   		return;
			}else if(btn_id==2){
				var mArray=getMaterialsByID($("#mid_input").val());
				if(mArray.length==0){
					initdiglog2("提示信息","请选择型号");
					return;
				}
				var num=$("#dialog_num").val();
				if(num.length==0||(num=parseInt(num))==0){
					initdiglog2("提示信息","请输入数量");
					return;
				}
				var unit_price_taxes=$("#dialog_upt").val();
				if(unit_price_taxes.length==0||(unit_price_taxes=parseFloat(unit_price_taxes))==0){
					initdiglog2("提示信息","请输入含税销售单价");
					return;
				}
				var predict_costing_taxes=$("#dialog_pct").val();
				if(predict_costing_taxes.length==0||(predict_costing_taxes=parseFloat(predict_costing_taxes))==0){
					initdiglog2("提示信息","请输入预计含税成本");
					return;
				}
				var delivery_time=$("#dialog_time").val();
				if(delivery_time.length==0){
					initdiglog2("提示信息","请选择交货期");
					return;
				}
				var remark=$("#dialog_remark").val();
				if(remark.length==0){
					initdiglog2("提示信息","请输入备注");
					return;
				}
				var unit_price=unit_price_taxes/1.17;
				var price_taxes=unit_price_taxes*num;
				var price=unit_price_taxes/1.17*num;
				//单行毛利=（不含税单价-预估含税成本/1.17）/不含税单价 约掉1.17
				var unit_gross_profit=Math.round((unit_price_taxes-predict_costing_taxes)/unit_price_taxes*10000)/100+"%";
				if(nowTR==null){//添加
					var temp='<tr><td></td>'
							+'<td class="tooltip_div">'+mArray[1]+'</td>'
							+'<td class="tooltip_div">'+mArray[3]+'</td>'
							+'<td class="tooltip_div" id="'+$("#mid_input").val()+'">'+mArray[2]+'</td>'
							+'<td class="tooltip_div">'+num+'</td>'
							+'<td class="tooltip_div">'+unit_price_taxes+'</td>'
							+'<td class="tooltip_div">'+predict_costing_taxes+'</td>'
							+'<td class="tooltip_div">'+delivery_time+'</td>'
							+'<td class="tooltip_div">'+remark+'</td>'
							+'<td class="tooltip_div">'+Math.round(unit_price*100)/100+'</td>'
							+'<td class="tooltip_div">'+Math.round(price_taxes*100)/100+'</td>'
							+'<td class="tooltip_div">'+Math.round(price*100)/100+'</td>'
							+'<td class="tooltip_div">'+unit_gross_profit+'</td></tr>';
					$(".product_tab").append(temp);
					showToolTip($(".product_tab").find("tr:last"));
				}else{//修改
					nowTR.children("td:eq(1)").text(mArray[1]);
					nowTR.children("td:eq(2)").text(mArray[3]);
					nowTR.children("td:eq(3)").text(mArray[2]);
					nowTR.children("td:eq(4)").text(num);
					nowTR.children("td:eq(5)").text(unit_price_taxes);
					nowTR.children("td:eq(6)").text(predict_costing_taxes);
					nowTR.children("td:eq(7)").text(delivery_time);
					nowTR.children("td:eq(8)").text(remark);
					nowTR.children("td:eq(9)").text(Math.round(unit_price*100)/100);
					nowTR.children("td:eq(10)").text(Math.round(price_taxes*100)/100);
					nowTR.children("td:eq(11)").text(Math.round(price*100)/100);
					nowTR.children("td:eq(12)").text(unit_gross_profit);
				}
				//初始化序号，计算整单毛利
				initTD();
			}
			initDialogVal();
		}
		function initDialogVal(){
			$(".dialog_product_bg").css("display","none");
			$(".dialog_product").css("display","none");
			$("#dialog_num").val("");
			$("#dialog_upt").val("");
			$("#dialog_pct").val("");
			$("#dialog_num").val("");
			$("#dialog_remark").val("");
			//清空下拉选择框
			$("#bts-ex-5 li.selected").attr("class","filter-item items");
			$("#mid_input").val("");
			$("#bts-ex-5 span.text").text("选择型号");
		}
		//取消其他checkbox的选择中状态
		function saveChecked(index){
			$(".td2_div4 .chk_1").each(function(){
				if($(this).prop("checked")&&$(this).attr("id").indexOf(index)==-1){
					$(this).prop("checked",false);
				}
			});
		}
		//由div触发checkbox
		function useFile(usefile){
			if(usefile){
				var flag=$(".td2_div10 input:eq(0)").prop("checked");
				$(".td2_div10 input:eq(0)").prop("checked",!flag);
				$(".td2_div10 input:eq(1)").prop("checked",flag);
			}else{
				var flag=$(".td2_div10 input:eq(1)").prop("checked");
				$(".td2_div10 input:eq(0)").prop("checked",flag);
				$(".td2_div10 input:eq(1)").prop("checked",!flag);
			}
			if($(".td2_div10 input:eq(0)").prop("checked")){
				$(".upload_file_div").css("display","block");
			}else{
				$(".upload_file_div").css("display","none");
			}
		}
		//由label触发checkbox
		function useFileChange(usefile){
			if(usefile){
				var flag=$(".td2_div10 input:eq(0)").prop("checked");
				$(".td2_div10 input:eq(1)").prop("checked",!flag);
			}else{
				var flag=$(".td2_div10 input:eq(1)").prop("checked");
				$(".td2_div10 input:eq(0)").prop("checked",!flag);
			}
			if($(".td2_div10 input:eq(0)").prop("checked")){
				$(".upload_file_div").css("display","block");
			}else{
				$(".upload_file_div").css("display","none");
			}
		}
		function setSupplier(company_name){
			$.ajax({
				type:"post",//post方法
				url:"ContractManagerServlet",
				data:{"type":"getCustomerByCName","company_name":company_name,"customer_type":1},
				timeout : 15000, 
				dataType:'json',
				success:function(returnData){
					if(returnData!=null){
						$(".td2_div9>div:eq(1) .td2_div9_name input").val(returnData.company_name);
						$(".td2_div9>div:eq(1) .td2_div9_address input").val(returnData.company_address);
						$(".td2_div9>div:eq(1) .td2_div9_postalcode input").val(returnData.postal_code);
						$(".td2_div9>div:eq(1) .td2_div9_person input:eq(0)").val(returnData.law_person);
						$(".td2_div9>div:eq(1) .td2_div9_person input:eq(1)").val(returnData.entrusted_agent);
						$(".td2_div9>div:eq(1) .td2_div9_phone input:eq(0)").val(returnData.phone);
						$(".td2_div9>div:eq(1) .td2_div9_phone input:eq(1)").val(returnData.fax);
						$(".td2_div9>div:eq(1) .td2_div9_bank input:eq(0)").val(returnData.bank);
						$(".td2_div9>div:eq(1) .td2_div9_accoun input:eq(0)").val(returnData.company_account);
						$(".td2_div9>div:eq(1) .td2_div9_tariffitem input:eq(0)").val(returnData.tariff_item);
					}else{
						initdiglog2("提示信息","提取客户信息失败！");
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
		function addFlow(){
			var cname=$("#cname_input").val();
			if(!cname.length>0){
				initdiglog2("提示信息","请选择客户");
				return;
			}
			document.flowform.company_name=cname;
			$("input[name='project_name']").val($("input[name='project_name']").val().trim());
			if($("input[name='sign_time']").val().length==0){
				initdiglog2("提示信息","请选择签订时间！");
				return;
			}
			if($("input[name='saler']").val().trim().length==0){
				initdiglog2("提示信息","请输入销售人员！");
				return;
			}
			var product_infos="";
			$(".product_tab tr:gt(0)").each(function(){
				//m_idの数量の含税单价の预计含税成本の交货期の备注
				var product_row=$(this).children("td:eq(3)").attr("id")+"の"+$(this).children("td:eq(4)").text().trim()+"の"+$(this).children("td:eq(5)").text().trim()+"の"
					+$(this).children("td:eq(6)").text().trim()+"の"+$(this).children("td:eq(7)").text().trim()+"の"+$(this).children("td:eq(8)").text().trim();
				if(product_infos.length>0){
					product_infos+="い";
				}
				product_infos+=product_row;
			});
			if(product_infos.length==0){
				initdiglog2("提示信息","请添加产品信息");
				return;
			}
			$("input[name='product_infos']").val(product_infos);
			var flag1=$("#checkbox1").prop("checked");
			var flag2=$("#checkbox2").prop("checked");
			var flag3=$("#checkbox3").prop("checked");
			if(!(flag1||flag2||flag3)){
				initdiglog2("提示信息","请选择付款方式");
				return;
			}
			var stop=false;
			if(flag1){
				var payment_value="";
				$(".td2_div4>div:eq(0) input[type='text']").each(function(){
					if(stop){
						return;				
					}
					if($(this).val().length==0){
						stop=true;
						initdiglog2("提示信息","请将付款方式填写完整");
						return;
					}
					payment_value+="の"+$(this).val();
				});
				$("input[name='payment_value']").val(payment_value.replace("の",""));
				$("input[name='payment_method']").val(1);
			}
			if(flag2){
				var payment_value="";
				$(".td2_div4>div:eq(1) input[type='text']").each(function(){
					if(stop){
						return;				
					}
					if($(this).val().length==0){
						stop=true;
						initdiglog2("提示信息","请将付款方式填写完整");
						return;
					}
					payment_value+="の"+$(this).val();
				});
				$("input[name='payment_value']").val(payment_value.replace("の",""));
				$("input[name='payment_method']").val(2);
			}
			if(flag3){
				var payment_value="";
				$(".td2_div4>div:eq(2) input[type='text']").each(function(){
					if(stop){
						return;				
					}
					if($(this).val().length==0){
						stop=true;
						initdiglog2("提示信息","请将付款方式填写完整");
						return;
					}
					payment_value+="の"+$(this).val();
				});
				$("input[name='payment_value']").val(payment_value.replace("の",""));
				$("input[name='payment_method']").val(3);
			}
			if(stop){
				return;				
			}
			if($("input[name='shipping_method']").val().replace(/\s/g,"").length==0){
				initdiglog2("提示信息","请输入运输方式");
				return;
			}
			if($("input[name='expense_burden']").val().replace(/\s/g,"").length==0){
				initdiglog2("提示信息","请输入费用负担方");
				return;
			}
			if($("input[name='delivery_points']").val().replace(/\s/g,"").length==0){
				initdiglog2("提示信息","请输入交货地点");
				return;
			}
			var inspect_time1=$("#inspect_time1").val();
			var inspect_time2=$("#inspect_time2").val();
			if(inspect_time1.replace(/\s/g,"").length==0||inspect_time2.replace(/\s/g,"").length==0){
				initdiglog2("提示信息","验收时间不完整");
				return;
			}
			$("input[name='inspect_time']").val(inspect_time1+"の"+inspect_time2);
			var service_promise1=$("#service_promise1").val();
			var service_promise2=$("#service_promise2").val();
			var service_promise3=$("#service_promise3").val();
			if(service_promise1.length==0||service_promise2.length==0||service_promise3.length==0){
				initdiglog2("提示信息","保修及服务不完整");
				return;
			}
			$("input[name='service_promise']").val(service_promise1+"の"+service_promise2+"の"+service_promise3);
			if($("input[name='company_name1']").val().replace(/\s/g,"").length==0||$("input[name='company_address1']").val().replace(/\s/g,"").length==0||
					$("input[name='phone1']").val().replace(/\s/g,"").length==0||$("input[name='bank1']").val().replace(/\s/g,"").length==0||
					$("input[name='company_account1']").val().replace(/\s/g,"").length==0||$("input[name='tariff_item1']").val().replace(/\s/g,"").length==0){
				initdiglog2("提示信息","供方信息不完整");
				return;
			}
			if($("input[name='company_name2']").val().replace(/\s/g,"").length==0||$("input[name='company_address2']").val().replace(/\s/g,"").length==0||
					$("input[name='phone2']").val().replace(/\s/g,"").length==0||$("input[name='bank2']").val().replace(/\s/g,"").length==0||
					$("input[name='company_account2']").val().replace(/\s/g,"").length==0||$("input[name='tariff_item2']").val().replace(/\s/g,"").length==0){
				initdiglog2("提示信息","需方信息不完整");
				return;
			}
			var contract_file=$("#checkbox10").prop("checked");
			if(contract_file&&successUploadFileNum1==0){
				initdiglog2("提示信息","请上传客户模板");
				return;
			}
			$("input[name='contract_file']").val(contract_file?0:1);
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
				<form
						action="ContractManagerServlet?type=addsales&file_time=<%=System.currentTimeMillis() %>"
						method="post" name="flowform">
				<input type="hidden" name="company_name">
				<input type="hidden" name="payment_method">
				<input type="hidden" name="payment_value">
				<input type="hidden" name="inspect_time">
				<input type="hidden" name="service_promise">
				<input type="hidden" name="product_infos">
				<input type="hidden" name="contract_file"><%--contract_file 0： 不上传；1：上传 --%>
					<div class="td2_div1">销售合同</div>
					<span class="span_title">基本信息：</span>
					<div class="td2_div2">
						<div class="div2_name">
							<span>客户名称：</span>
							<div>
								<jsp:include page="/flowmanager/drop_down_customer.jsp" >
								<jsp:param name="customer_type" value="1"/>
								</jsp:include>
							</div>
						</div>
						<div class="div2_project">
							<span>项目名称：</span>
							<input type="text" name="project_name" maxlength="100">
						</div>
						<div class="div2_project">
							<span>合同编号：</span>
							<input type="text" name="contract_no" maxlength="100">
						</div>
						<div class="div2_time">
							<span>签订时间：</span>
							<input type="text" name="sign_time" id="sign_time" value="<c:out value='${today}'></c:out>" onClick="return Calendar('sign_time');" readonly="readonly">
							<span>合同状态：</span>
							<div>待批复</div>
							<span>销售人员：</span>
							<input type="text" name="saler" id="saler" maxlength="5">
						</div>
						<div class="div2_num">
							<span>已采购数量：</span>
							<span id="all_num">0</span>
							<span>整单毛利：</span>
							<span id="gross_profit"></span>
						</div>
					</div>
					<div class="td2_div3">
						<span>产品信息：</span>
						<img src="images/add_product.png" onclick="showDialog();">
					</div>
					<table class="product_tab">
						<tr class="product_tr1">
							<td style="width:30px;">序号</td>
							<td style="width:60px;">物料编码</td>
							<td style="width:60px;">产品描述</td>
							<td>型号</td>
							<td>数量</td>
							<td>含税销<br/>售单价</td>
							<td>预计含<br/>税成本</td>
							<td style="width: 70px;">交货期</td>
							<td>备注</td>
							<td style="width: 60px;">不含税销<br/>售单价</td>
							<td>含税<br/>金额</td>
							<td>不含税<br/>金额</td>
							<td>单行<br/>毛利</td>
						</tr>
					</table>
					<span class="span_title">付款方式：</span>
					<div class="td2_div4">
						<div>
							<div><input type="checkbox" id="checkbox1" class="chk_1" onchange="saveChecked(1)" /><label for="checkbox1"></label></div>
							<div>1.合同签订后<input type="text" class="payment_input" maxlength="5" oninput="checkIntPosition(this)">个工作日内, 需方支付合同总额的<input type="text" class="payment_input" maxlength="8" oninput="checkFloatPositive(this,4)">%预付款后合同生效；发货前支付合同总额的<input type="text" class="payment_input" maxlength="8" oninput="this.value=checkFloatPositive(this.value,4)">%, 款到3个工作内发货；到货后支付合同总额的<input type="text" class="payment_input" maxlength="8" oninput="this.value=checkFloatPositive(this.value,4)">%作为到货款；合同总额的<input type="text" class="payment_input" maxlength="8" oninput="this.value=checkFloatPositive(this.value,4)">%,作为质保金在质保期满七天内付清；</div>
						</div>
						<div>
							<div><input type="checkbox" id="checkbox2" class="chk_1" onchange="saveChecked(2)" /><label for="checkbox2"></label></div>
							<div>2.发货前支付全款，款到后供方发货并开具合同全额发票（17%增值税专用发票）；</div>
						</div>
						<div>
							<div><input type="checkbox" id="checkbox3" class="chk_1" onchange="saveChecked(3)" /><label for="checkbox3"></label></div>
							<div>3.货到票到<input type="text" class="payment_input" maxlength="5" oninput="checkIntPosition(this)">天内以电汇方式支付合同全款（17%增值税专用发票）。</div>
						</div>
					</div>
					<span class="span_title">运输方式和费用负担：</span>
					<div class="td2_div5">运输方式:<input type="text" maxlength="10" name="shipping_method" value="汽车">; 运费由<input type="text" maxlength="10" name="expense_burden" value="供">方负担。
					</div>
					<span class="span_title">交（提）货地点：</span>
					<div class="td2_div6"><input type="text" maxlength="100" name="delivery_points" value="需方的用户现场（以需方传真确认为准，中国大陆）">设备到达需方现场。
					</div>
					<span class="span_title">验收时间：</span>
					<div class="td2_div7">到货后<input type="text" maxlength="4" oninput="checkIntPosition(this)" id="inspect_time1" value="5">个工作日内需方完成检验，如超过<input type="text" maxlength="5" oninput="checkIntPosition(this)" id="inspect_time2" value="5">个工作日未检验视为验收通过。
					</div>
					<span class="span_title">供方对质量保修及服务承诺:</span>
					<div class="td2_div8">免费保修期为<input type="text" maxlength="2" oninput="checkIntPosition(this)"id="service_promise1">年（或为到货后<input type="text" maxlength="2" oninput="checkIntPosition(this)" id="service_promise2" value="18">个月内，以先到为准）。保修期内由于产品质量问题产生的服务费用由供方承担。需方需要现场服务，供方<input type="text" maxlength="3" oninput="checkIntPosition(this)" id="service_promise3" value="48">小时内响应；
					</div>
					<div class="td2_div9">
						<div>
							<div class="td2_div9_top">供 方</div>
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
							<div class="td2_div9_top">需 方</div>
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
					</form>
					<div class="div_dashed"></div>
					<div class="td2_div10"><span class="star">*</span><div>是否使用客户合同</div><input type="checkbox" id="checkbox10" class="chk_2" onchange="useFileChange(true)"/><label for="checkbox10"></label><div class="ifUseFile" onclick="useFile(true)">是</div><input type="checkbox" id="checkbox11" class="chk_2"  onchange="useFileChange(false)"/><label for="checkbox11"></label><div class="ifUseFile" onclick="useFile(false)">否</div><div class="upload_file_div" onclick="$('#contract_file_div .jFiler-input').click();"><img title="上传客户合同" src="images/import_materials.png">上传客户模板</div></div>
					<div class="div_file_list">
					</div>
					<div class="buttom_btn_group"><img src="images/submit_materials.png" onclick="checkContract_no(0)"><img src="images/cancle_materials.png" onclick="window.location.href='<%=basePath %>flowmanager/newflow.jsp'"></div>
				</td>
			</tr>
		</table>
		
	</div>
	<div class="dialog_product">
		<div class="product_model"><span>型号：</span>
			<div>
				<jsp:include page="/flowmanager/drop_down_model.jsp" />
			</div>
		</div>
		<div class="product_div"><span>数量：</span><input type="text" maxlength="8" id="dialog_num" oninput="checkIntPosition(this)"></div>
		<div class="product_div"><span>含税销售单价：</span><input type="text" maxlength="8" id="dialog_upt" oninput="checkFloatPositive(this,2)"></div>
		<div class="product_div"><span>预计含税成本：</span><input type="text" maxlength="8" id="dialog_pct" oninput="checkFloatPositive(this,2)"></div>
		<div class=product_time><span>交货期：</span><input type="text" readonly="readonly" id="dialog_time" value="<c:out value='${today}'></c:out>" onclick="return Calendar('dialog_time');"  ></div>
		<div class="product_div"><span>备注：</span><textarea id="dialog_remark" maxlength="1000"></textarea></div>
		<div class="product_bottom"><img src="images/cancle_materials.png" onclick="closeDialog(0)"><img src="images/submit_materials.png" onclick="closeDialog(2)"><img src="images/del_materials.png" id="delproduct" onclick="closeDialog(1)"></div>
	</div>
</body>
</html>
