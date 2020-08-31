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
	import="com.zzqa.service.interfaces.purchase_note.Purchase_noteManager"%>
<%@page import="com.zzqa.pojo.purchase_note.Purchase_note"%>
<%@page
	import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
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
	Position_userManager position_userManager = (Position_userManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("position_userManager");
	Product_infoManager product_infoManager= (Product_infoManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("product_infoManager");
	Sales_contractManager sales_contractManager= (Sales_contractManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("sales_contractManager");
	Purchase_noteManager purchase_noteManager=(Purchase_noteManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("purchase_noteManager");
	File_pathManager file_pathManager= (File_pathManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("file_pathManager");
	FlowManager flowManager= (FlowManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("flowManager");
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
	Map<String, String> drawMap= sales_contractManager.getSalesFlowForDraw(sales_contract,flow);
	List<File_path> file_paths=file_pathManager.getAllFileByCondition(11, sales_id, 1, 0);
	List<Product_info> product_infoList=sales_contractManager.getDetailProduct_infos(sales_id);
	int operation=flow.getOperation();
	int purchaseState=-1;//0：未采购；1：部分采购；2：已采购
	int purchase_allnum=0;
	for(Product_info product_info:product_infoList){
		//finishedNum+=purchase_noteManager.getFinishedCountByProductID(product_info.getId());
		//purchase_allnum+=purchase_noteManager.getCountByProductID(product_info.getId(), 0);//已采购数量;
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
	pageContext.setAttribute("file_paths", file_paths);
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
	List<Materials_info> mList=materials_infoManager.getMaterials_infos();
	request.setAttribute("mList", mList);
	String today=new SimpleDateFormat("yyyy/M/d").format(System.currentTimeMillis());
	pageContext.setAttribute("today",today);
	pageContext.setAttribute("applyFinished",applyFinished);
	//判断是否可撤销
	Flow flow5=flowManager.getFlowByOperation(11, sales_id, 5);
	Flow flow7=flowManager.getFlowByOperation(11, sales_id, 7);
	Flow flow9=flowManager.getFlowByOperation(11, sales_id, 9);
	Flow flow11=flowManager.getFlowByOperation(11, sales_id, 11);
	Flow flow13=flowManager.getFlowByOperation(11, sales_id, 13);
	boolean isDeling=false;//正在撤销或已撤销，不可修改
	if(flow13!=null){
		Flow flow12=flowManager.getFlowByOperation(11, sales_id, 12);
		if(flow12!=null&&flow12.getCreate_time()<flow13.getCreate_time()){
			isDeling=true;
		}
	}
	if(isDeling){
		//撤销中不可修改
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>修改销售合同</title>
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
<link rel="stylesheet" type="text/css" href="css/create_salesflow.css">
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
	<script type="text/javascript">
		$(function(){
			setContractState(<%=isDeling%>,<%=operation%>,<%=purchaseState%>,${applyFinished});
			initTD();
			$("#bts-ex-4 li[data-value='<%=sales_contract.getCompany_name2()%>']").click();
			//选中一个客户，拉去信息，填到需方
			$("#bts-ex-4 li.filter-item.items").click(function(){
				setSupplier($(this).attr("data-value"));
			});
			useFile(<%=sales_contract.getContract_file()==0%>);
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
		var first=true;//表格只计算一次
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
			var prices=0.0;
			//不含税单价总和
			var all_prices=0.0;
			$(".product_tab tr:gt(0)").each(function(){
				$(this).children("td:eq(0)").text(++k);
				var num=parseInt($(this).children("td:eq(4)").text().trim());
				var unit_price_taxes=parseFloat($(this).children("td:eq(5)").text().trim());
				var pvt=parseFloat($(this).children("td:eq(6)").text().trim());
				all_prices+=unit_price_taxes*num;
				all_pvt+=pvt*num;
				if(first){//表格原有数据初始化时计算一次
					var unit_price=unit_price_taxes/1.17;
					var price_taxes=unit_price_taxes*num;
					var price=unit_price_taxes/1.17*num;
					var predict_costing_taxes=parseFloat($(this).children("td:eq(6)").text().trim());
					//约掉1.17
					var unit_gross_profit=Math.round((unit_price_taxes-predict_costing_taxes)/unit_price_taxes*10000)/100+"%";
					$(this).children("td:eq(9)").text(Math.round(unit_price*100)/100);
					$(this).children("td:eq(10)").text(Math.round(price_taxes*100)/100);
					$(this).children("td:eq(11)").text(Math.round(price*100)/100);
					$(this).children("td:eq(12)").text(unit_gross_profit);
				}
			});
			if(!first){
				first=!first;
			}
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
					var product_id=nowTR.attr("id");
					if(typeof(product_id) == "undefined"){
						//新建的未绑定
						nowTR.remove();
						initTD();
						initDialogVal();
						return;
					}
					$.ajax({
						type:"post",//post方法
						url:"ContractManagerServlet",
						data:{"type":"delProductOnSales","product_id":product_id},
						timeout : 15000,
						success:function(returnData){
							if(returnData==0){
								nowTR.remove();
								initTD();
								initDialogVal();
							}else{
								initdiglog2("提示信息","该产品已被采购合同绑定，无法删除！");
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
				unit_price_taxes=parseFloat(unit_price_taxes);
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
				//单行毛利=（不含税单价-预估含税成本/1.17）/不含税单价
				var unit_gross_profit=Math.round((unit_price-predict_costing_taxes/1.17)/unit_price*1000)/10+"%";
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
			//初始化后没有选中任何一个，默认选中第一个
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
				initdiglog2("提示信息","请选择签订时间");
				return;
			}
			if($("input[name='saler']").val().trim().length==0){
				initdiglog2("提示信息","请输入销售人员！");
				return;
			}
			var product_infos="";
			$(".product_tab tr:gt(0)").each(function(){
				var product_row=$(this).children("td:eq(3)").attr("id")+"の"+$(this).children("td:eq(4)").text().trim()+"の"+$(this).children("td:eq(5)").text().trim()+"の"
					+$(this).children("td:eq(6)").text().trim()+"の"+$(this).children("td:eq(7)").text().trim()+"の"+$(this).children("td:eq(8)").text().trim();
				var product_id=$(this).attr("id");
				if(typeof(product_id) != "undefined"){
					product_row+="の"+product_id;
				}
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
			if(contract_file&&successUploadFileNum1==0&&file_num==0){
				initdiglog2("提示信息","请上传客户模板");
				return;
			}
			if($(".div_testarea").val().replace(/[ ]/g, "").length==0){
				initdiglog2("提示信息","请输入备注");
				return;
			}
			if(document.flowform.changeFile.value.length==0){//未删除文件
				if(<%=sales_contract.getContract_file()==0%>&&$("#checkbox11").prop("checked")){
					//将合同保存到记录中
					document.flowform.changeFile.value="-1";
				}else if(successUploadFileNum1>0){
					document.flowform.changeFile.value="0";
				}
			}else{
				document.flowform.changeFile.value=document.flowform.changeFile.value.replace("の","");
			}
			$("input[name='contract_file']").val(contract_file?0:1);
			document.flowform.submit();
		}
		var file_num=<%=sales_contract.getContract_file()==0?file_paths.size():0%>;//上传客户合同数
		//删除客户合同
	   	function delFile(id,name){
	   		initdiglogtwo2("提示信息","你确定要删除文件<br/>【"+name+"】吗？");
	   		$( "#confirm2" ).click(function() {
	   			$( "#twobtndialog" ).dialog( "close" );
	   			document.flowform.changeFile.value+="の"+id;
				$("#file_item"+id).remove();
				file_num--;
				if(successUploadFileNum1==0&&file_num==0&&$("#checkbox10").prop("checked")){
					initdiglog2("提示信息","删除成功，请上传客户合同，切勿中途退出！");
				}else{
					initdiglog2("提示信息","删除成功！");
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
				<form
						action="ContractManagerServlet?type=altersales&operation=<%=operation%>&file_time=<%=System.currentTimeMillis() %>"
						method="post" name="flowform">
				<input type="hidden" name="company_name">
				<input type="hidden" name="payment_method">
				<input type="hidden" name="payment_value">
				<input type="hidden" name="inspect_time">
				<input type="hidden" name="service_promise">
				<input type="hidden" name="changeSales"><%--changeSales 0： 修改过合同内容；1：未修改 --%>
				<input type="hidden" name="product_infos">
				<input type="hidden" name="contract_file"><%--contract_file 0： 不上传；1：上传 --%>
				<input type="hidden" name="changeFile"><%--contract_file 0： 修改过客户合同；1：没修改 --%>
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
							<input type="text" name="project_name" maxlength="100" value="${sales_contract.project_name}">
						</div>
						<div class="div2_project">
							<span>合同编号：</span>
							<input type="text" name="contract_no" maxlength="100" value="${sales_contract.contract_no}">
						</div>
						<div class="div2_time">
							<span>签订时间：</span>
							<input type="text" name="sign_time" id="sign_time" value="${sales_contract.sign_date}" onClick="return Calendar('sign_time');" readonly="readonly">
							<span>合同状态：</span>
							<div id="state"></div>
							<span>销售人员：</span>
							<input type="text" name="saler" id="saler" maxlength="5"  value="${sales_contract.saler}" >
						</div>
						<div class="div2_num">
							<span>已采购数量：</span>
							<span>${purchase_allnum}</span>
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
						<c:forEach items="${product_infoList}" var="product_info">
						<tr id="${product_info.id}" title='${product_info.purchase_num>0?"已采购数量":""}${product_info.purchase_num>0?product_info.purchase_num:""}'>
						<td></td>
						<td class="tooltip_div">${product_info.materials_id}</td>
						<td class="tooltip_div">${product_info.materials_remark}</td>
						<td class="tooltip_div" id="${product_info.m_id}">${product_info.model}</td>
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
						<div>
							<div><input type="checkbox" id="checkbox1" class="chk_1" onchange="saveChecked(1)" ${sales_contract.payment_method==1?"checked":""}/><label for="checkbox1"></label></div>
							<div>1.合同签订后<input type="text" class="payment_input" maxlength="5" oninput="checkIntPosition(this)" value="${sales_contract.payment_method==1?payment_value1:""}">个工作日内, 需方支付合同总额的<input type="text" class="payment_input" maxlength="8" oninput="checkFloatPositive(this,4)" value="${sales_contract.payment_method==1?payment_value2:""}">%预付款后合同生效；发货前支付合同总额的<input type="text" class="payment_input" maxlength="8" oninput="checkFloatPositive(this,4)" value="${sales_contract.payment_method==1?payment_value3:""}">%, 款到3个工作内发货；到货后支付合同总额的<input type="text" class="payment_input" maxlength="8" oninput="checkFloatPositive(this,4)" value="${sales_contract.payment_method==1?payment_value4:""}">%作为到货款；合同总额的<input type="text" class="payment_input" maxlength="8" oninput="checkFloatPositive(this,4)" value="${sales_contract.payment_method==1?payment_value5:""}">%,作为质保金在质保期满七天内付清；</div>
						</div>
						<div>
							<div><input type="checkbox" id="checkbox2" class="chk_1" onchange="saveChecked(2)" ${sales_contract.payment_method==2?"checked":""}/><label for="checkbox2"></label></div>
							<div>2.发货前支付全款，款到后供方发货并开具合同全额发票（17%增值税专用发票）；</div>
						</div>
						<div>
							<div><input type="checkbox" id="checkbox3" class="chk_1" onchange="saveChecked(3)" ${sales_contract.payment_method==3?"checked":""}/><label for="checkbox3"></label></div>
							<div>3.货到票到<input type="text" class="payment_input" maxlength="5" oninput="checkIntPosition(this)" value="${sales_contract.payment_method==3?payment_value1:""}">天内以电汇方式支付合同全款（17%增值税专用发票）。</div>
						</div>
					</div>
					<span class="span_title">运输方式和费用负担：</span>
					<div class="td2_div5">运输方式:<input type="text" maxlength="10" name="shipping_method" value="${sales_contract.shipping_method}">; 运费由<input type="text" maxlength="10" name="expense_burden" value="${sales_contract.expense_burden}">方负担。
					</div>
					<span class="span_title">交（提）货地点：</span>
					<div class="td2_div6"><input type="text" maxlength="100" name="delivery_points" value="需方的用户现场（以需方传真确认为准，中国大陆）">设备到达需方现场。
					</div>
					<span class="span_title">验收时间：</span>
					<div class="td2_div7">到货后<input type="text" maxlength="4" oninput="checkIntPosition(this)" id="inspect_time1" value="${inspect_time1}">个工作日内需方完成检验，如超过<input type="text" maxlength="5" oninput="checkIntPosition(this)" id="inspect_time2" value="${inspect_time2}">个工作日未检验视为验收通过。
					</div>
					<span class="span_title">供方对质量保修及服务承诺:</span>
					<div class="td2_div8">免费保修期为<input type="text" maxlength="2" oninput="checkIntPosition(this)"id="service_promise1" value="${service_promise1}">年（或为到货后<input type="text" maxlength="2" oninput="checkIntPosition(this)" id="service_promise2" value="${service_promise2}">个月内，以先到为准）。保修期内由于产品质量问题产生的服务费用由供方承担。需方需要现场服务，供方<input type="text" maxlength="3" oninput="checkIntPosition(this)" id="service_promise3" value="${service_promise3}">小时内响应；
					</div>
					<div class="td2_div9">
						<div>
							<div class="td2_div9_top">供 方</div>
							<div class="td2_div9_name"><span>单位名称（章）：</span><input type="text" maxlength="100" name="company_name1" value="${sales_contract.company_name1}"></div>
							<div class="td2_div9_address"><span>单位地址：</span><input type="text" maxlength="200" name="company_address1" value="${sales_contract.company_address1}"></div>
							<div class="td2_div9_postalcode"><span>邮政编码：</span><input type="text" maxlength="10" name="postal_code1" value="${sales_contract.postal_code1}"></div>
							<div class="td2_div9_person"><span>法定代表人：</span><input type="text" maxlength="100" name="law_person1"  value="${sales_contract.law_person1}"><span>委托代理人：</span><input type="text" maxlength="100" name="entrusted_agent1" value="${sales_contract.entrusted_agent1}"></div>
							<div class="td2_div9_phone"><span>电 话：</span><input type="text" maxlength="20" name="phone1" value="${sales_contract.phone1}"><span>传 真：</span><input type="text" maxlength="20" name="fax1" value="${sales_contract.fax1}"></div>
							<div class="td2_div9_bank"><span>开户行：</span><input type="text" maxlength="100" name="bank1" value="${sales_contract.bank1}"></div>
							<div class="td2_div9_accoun"><span>公司账号：</span><input type="text" maxlength="50" name="company_account1" value="${sales_contract.company_account1}"></div>
							<div class="td2_div9_tariffitem"><span>税 号：</span><input type="text" maxlength="100" name="tariff_item1" value="${sales_contract.tariff_item1}"></div>
						</div>
						<div>
							<div class="td2_div9_top">需 方</div>
							<div class="td2_div9_name"><span>单位名称（章）：</span><input type="text" maxlength="100" name="company_name2" style="border:0" readonly="readonly" value="${sales_contract.company_name2}"></div>
							<div class="td2_div9_address"><span>单位地址：</span><input type="text" maxlength="200" name="company_address2" value="${sales_contract.company_address2}"></div>
							<div class="td2_div9_postalcode"><span>邮政编码：</span><input type="text" maxlength="10" name="postal_code2" value="${sales_contract.postal_code2}"></div>
							<div class="td2_div9_person"><span>法定代表人：</span><input type="text" maxlength="100" name="law_person2" value="${sales_contract.law_person2}"><span>委托代理人：</span><input type="text" maxlength="100" name="entrusted_agent2" value="${sales_contract.entrusted_agent2}"></div>
							<div class="td2_div9_phone"><span>电 话：</span><input type="text" maxlength="20" name="phone2" value="${sales_contract.phone2}"><span>传 真：</span><input type="text" maxlength="20" name="fax2" value="${sales_contract.fax2}"></div>
							<div class="td2_div9_bank"><span>开户行：</span><input type="text" maxlength="100" name="bank2" value="${sales_contract.bank2}"></div>
							<div class="td2_div9_accoun"><span>公司账号：</span><input type="text" maxlength="50" name="company_account2" value="${sales_contract.company_account2}"></div>
							<div class="td2_div9_tariffitem"><span>税 号：</span><input type="text" maxlength="100" name="tariff_item2" value="${sales_contract.tariff_item2}"></div>
						</div>
					</div>
					<div class="div_dashed"></div>
					<c:if test="${sales_contract.contract_file==0}">
					<table class="td2_table0 ">
						<tr class="table0_tr1">
							<td class="table0_tr1_td1">
								客户合同
							</td>
							<td class="table0_tr1_td2">
							<c:forEach items="${file_paths}" var="file_path1">
								<div id="file_item${file_path1.id}">
								<a href="javascript:void()" onclick="fileDown(${file_path1.id})">${file_path1.file_name}</a>
								<a class="img_a" href="javascript:void(0);" onclick="delFile(${file_path1.id},'${file_path1.file_name}');this.blur();">[删除]</a>
								</div>
							</c:forEach>
								<div class="div_file_list">
								</div>
							</td>
						</tr>
					</table>
					</c:if>
					<div class="td2_div10"><span class="star">*</span><div>是否使用客户合同</div><input type="checkbox" id="checkbox10" class="chk_2" onchange="useFileChange(true)"/><label for="checkbox10"></label><div class="ifUseFile" onclick="useFile(true)" >是</div><input type="checkbox" id="checkbox11" class="chk_2"  onchange="useFileChange(false)"/><label for="checkbox11"></label><div class="ifUseFile" onclick="useFile(false)">否</div><div class="upload_file_div" onclick="$('#contract_file_div .jFiler-input').click();"><img title="上传客户合同" src="images/import_materials.png">上传客户模板</div></div>
					<c:if test="${sales_contract.contract_file==1}">
						<div class="div_file_list">
						</div>
					</c:if>
					<textarea name="reason" class="div_testarea" placeholder="请输入备注" required="required" maxlength="500"></textarea>
						<div class="buttom_btn_group"><img src="images/submit_materials.png" onclick="checkContract_no(<%=sales_id%>)"><img src="images/cancle_materials.png" onclick="window.location.href='<%=basePath %>flowmanager/salesflow_detail.jsp'"></div>
					</form>
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
		<div class=product_time><span>交货期：</span><input type="text" readonly="readonly" id="dialog_time" value="${today}" onclick="return Calendar('dialog_time');"  ></div>
		<div class="product_div"><span>备注：</span><textarea id="dialog_remark" maxlength="1000"></textarea></div>
		<div class="product_bottom"><img src="images/cancle_materials.png" onclick="closeDialog(0)"><img src="images/submit_materials.png" onclick="closeDialog(2)"><img src="images/del_materials.png" id="delproduct" onclick="closeDialog(1)"></div>
	</div>
</body>
</html>
