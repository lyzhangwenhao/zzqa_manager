<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page
	import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page
	import="com.zzqa.service.interfaces.shipping.ShippingManager"%>
<%@page import="com.zzqa.pojo.shipping.Shipping"%>
<%@page import="com.zzqa.pojo.shipping_list.Shipping_list"%>
<%@page
	import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
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
	FlowManager flowManager= (FlowManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("flowManager");
	ShippingManager shippingManager= (ShippingManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("shippingManager");
	PermissionsManager permissionsManager=(PermissionsManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("permissionsManager");
	if (session.getAttribute("uid") == null||session.getAttribute("shipping_printType") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int shipping_printType = (Integer) session.getAttribute("shipping_printType");
	int uid = (Integer) session.getAttribute("uid");
	User mUser = userManager.getUserByID(uid);
	if (mUser == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int shipping_id = (Integer) session.getAttribute("shipping_id");
	Shipping shipping=shippingManager.getShippingDetailById(shipping_id);
	Flow flow=flowManager.getNewFlowByFID(18, shipping_id);
	boolean material_requisition=permissionsManager.checkPermission(mUser.getPosition_id(), 128);
	boolean isShippinger=permissionsManager.checkPermission(mUser.getPosition_id(), 129);
	if(shipping==null||flow==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int operation=flow.getOperation();
	Flow flow2=flowManager.getFlowByOperation(18, shipping_id, 2);
	if(flow2!=null){
		User user=userManager.getUserByID(flow2.getUid());
		pageContext.setAttribute("approve_uname", user==null?("uid"+flow2.getUid()):user.getTruename());
		pageContext.setAttribute("approve_time", flow2.getCreate_time());
	}else{
		pageContext.setAttribute("approve_time", 0);
	}
	Flow flow4=flowManager.getFlowByOperation(18, shipping_id, 4);
	if(flow4!=null){
		pageContext.setAttribute("material_time", flow4.getCreate_time());
	}else{
		pageContext.setAttribute("material_time", 0);
	}
	pageContext.setAttribute("shipping_printType", shipping_printType);
	pageContext.setAttribute("mUser", mUser);
	pageContext.setAttribute("shipping", shipping);
	pageContext.setAttribute("operation",operation);
	pageContext.setAttribute("material_requisition", material_requisition);
	pageContext.setAttribute("isShippinger", isShippinger);
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>打印单据</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
<link rel="stylesheet" type="text/css" href="css/top.css">
<link rel="stylesheet" type="text/css" href="css/preview_shipping.css">
<script src="js/jquery.min.js" type="text/javascript"></script>
<script  type="text/javascript" src="js/jquery-ui.min.js"></script>
<script  type="text/javascript" src="js/dialog.js"></script>
<script  type="text/javascript" src="js/public.js"></script>
<!--[if IE]>
	<script src="js/html5shiv.min.js" type="text/javascript"></script>
<![endif]-->
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
		var approve_uname="${approve_uname}";
		var approve_time=${approve_time};
		var material_uname="${shipping.material_man_name}";
		var material_time=${material_time};
		var checkedArray=new Array();
		$(function(){
			if(${shipping_printType==0}){
				$(".approve_uname").text(approve_uname);
				$(".approve_time").text(timeTransLongToStr(approve_time,4,"/",false));
				if(material_time&&material_time>0){
					$(".material_uname").text(material_uname);
					$(".material_time").text(timeTransLongToStr(material_time,4,"/",false));
				}
				$(".picking_tr_content").each(function(){
					var tr_height=$(this).height();
					$(this).find("td[index_td='remark'] input").css("height",tr_height+"px");
				});
				var temp='';
				var picking_td_selected=getCookie("picking_td_selected");
				var picking_td_selectedArray=picking_td_selected.split("");
				$(".picking_tr_title>td:gt(0)").each(function(i){
					var even=i%2==0;////两个一排
					if(even){
						temp+='<div class="dialog_sales_group">';
					}
					var td_name=$(this).attr("index_td");
					temp+='<div><input type="checkbox" name="td_checkbox'+td_name+'" id="td_checkbox'+i+'" class="chk_1" onchange="userCheckedChange('+i+')">'
						+'<label for="td_checkbox'+i+'"></label>'
						+'<div onclick="sameClick('+i+');">'+$(this).text().trim()+'</div></div>'
					checkedArray[i]=picking_td_selectedArray&&picking_td_selectedArray.length>i?picking_td_selectedArray[i]==1:true;
					if((i+1)==length||(!even)){
						temp+='</div>';
					}
				});
				$(".del_notify_div_img").after(temp);
				for(var i=0;i<checkedArray.length;i++){
					$(".dialog_sales input:eq("+i+")").prop("checked",checkedArray[i]);
				};
				closeDialog(1);
			}else {
				//发货单
				var prices=0;
				var nums=0;
				$(".shipping_tr_content").each(function(){
					var unit_price=parseFloat($(this).find("td[index_td='unit_price']").text().trim());
					var num=parseInt($(this).find("td[index_td='num']").text().trim());
					$(this).find("td[index_td='price']").text(unit_price*num);
					prices+=parseFloat($(this).find("td[index_td='price']").text().trim());
					nums+=num;
					var tr_height=$(this).height();
					$(this).find("td[index_td='remark'] input").css("height",tr_height+"px");
				});
				$("#shipping_tr_sum").find("td[index_td='price']").text(prices);
				$("#shipping_tr_sum").find("td[index_td='num']").text(nums);
				var temp='';
				var shipping_td_selected=getCookie("shipping_td_selected");
				var shipping_td_selectedArray=shipping_td_selected.split("");
				$(".shipping_tr_title>td:gt(0)").each(function(i){
					var even=i%2==0;////两个一排
					if(even){
						temp+='<div class="dialog_sales_group">';
					}
					var td_name=$(this).attr("index_td");
					temp+='<div><input type="checkbox" name="td_checkbox'+td_name+'" id="td_checkbox'+i+'" class="chk_1" onchange="userCheckedChange('+i+')">'
						+'<label for="td_checkbox'+i+'"></label>'
						+'<div onclick="sameClick('+i+');">'+$(this).text().trim()+'</div></div>'
					checkedArray[i]=shipping_td_selectedArray&&shipping_td_selectedArray.length>i?shipping_td_selectedArray[i]==1:true;
					if((i+1)==length||(!even)){
						temp+='</div>';
					}
				});
				$(".del_notify_div_img").after(temp);
				for(var i=0;i<checkedArray.length;i++){
					$(".dialog_sales input:eq("+i+")").prop("checked",checkedArray[i]);
				};
				closeDialog(1);
			}
		});
		function preview(){
			if(${shipping_printType==0}){
				//打印领料单
				$("#div_dashed").css("display","none");
				$(".picking_tr_content").find("td[index_td='remark']").each(function(){
					$(this).html($(this).find("input").val());
				});
				$(".parent_div").after('<div class="parent_div2"></div>');
				$(".parent_div .bottom_group_remark").css("display","block");
				$(".parent_div2").html($(".parent_div").html());
				$(".parent_div2 .bottom_group_remark").text("注：本联由制单人员留存");
				
				$(".parent_div").css("padding","5px");
				$(".div_btn").css("display","none");
				$("body").css("background","#fff");
				$(".picking_tr_title").find("td[index_td='remark']").text("备注");
				$(".contract_chose2").css("display","none");
				if($(".parent_div").height()>600){
					$(".parent_div").css({"page-break-before":"always"});
					$(".parent_div2").css({"page-break-before":"always"});
				}else{
					$(".parent_div").css({"height":"600px"});
					$(".parent_div2").css({"height":"600px"});
				}
				window.print();
				$(".parent_div").css({"height":"auto"});
				$(".parent_div .bottom_group_remark").css("display","none");
				$(".parent_div2").remove();
				$(".picking_tr_content").find("td[index_td='remark']").each(function(){
					var remark=$(this).text();
					$(this).html('<input type="text" value="'+remark+'" maxlength="200">');
					var tr_height=$(this).height();
					$(this).find("input").css("height",tr_height+"px");
					
				});
				$("#div_dashed").css("display","block");
				$(".parent_div").css("padding","25px");
				$("body").css("background","#f0f4f7");
				$(".div_btn").css("display","block");
				$(".picking_tr_title").find("td[index_td='remark']").text("备注（可编辑）");
				$(".contract_chose2").css("display","block");
			}else{
				//发货单
				$(".shipping_tr_content").find("td[index_td='remark']").each(function(){
					$(this).html($(this).find("input").val());
				});
				$(".td2_div1").css("margin","20px auto 0px auto");
				$(".dialog_sales").css("display","none");
				$(".contract_chose").css("display","none");
				$(".div_dashed").css("display","none");
				$(".parent_div").css("padding","5px");
				$(".div_btn").css("display","none");
				$(".div_btn").css("display","none");
				$("body").css("background","#fff");
				$(".shipping_tr_title").find("td[index_td='remark']").text("备注");
				window.print(); 
				$(".shipping_tr_content").find("td[index_td='remark']").each(function(){
					var remark=$(this).text();
					$(this).html('<input type="text" value="'+remark+'" maxlength="200">');
					var tr_height=$(this).height();
					$(this).find("input").css("height",tr_height+"px");
					
				});
				$(".td2_div1").css("margin","0px auto");
				$(".contract_chose").css("display","block");
				$(".parent_div").css("padding","25px");
				$("body").css("background","#f0f4f7");
				$(".div_dashed").css("display","block");
				$(".div_btn").css("display","block");
				$(".shipping_tr_title").find("td[index_td='remark']").text("备注（可编辑）");
			}
		}
		//领料完成
		function finishedMaterials(){
			document.flowform.submit();
		}
		//执行发货
		function doShipping(){
			document.flowform.submit();
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
		function closeDialog(btn_id){
			if(${shipping_printType==0}){
				if(btn_id==1){
					$(".chk_1").each(function(){
		    			var i=$(this).attr("id").replace("td_checkbox","").trim();
		    			checkedArray[parseInt(i)]=$(this).prop("checked");
		    		});
					var picking_td_selected="";
					var hideColumn=0;//显示的列数
					for(var i =0;i<checkedArray.length;i++){
						var td_name=$("#td_checkbox"+i).attr("name").replace("td_checkbox","");
						if(checkedArray[i]){
							picking_td_selected+="1";
							$(".picking_table td[index_td='"+td_name+"']").css("display","table-cell");
						}else{
							hideColumn++;
							picking_td_selected+="0";
							$(".picking_table td[index_td='"+td_name+"']").css("display","none");
						}
					}
					$(".picking_table td[index_td='index']").attr("colspan",(hideColumn+1));
					$(".shipping_tr_content").each(function(){
						var tr_height=$(this).height();
						$(this).find("td[index_td='remark'] input").css("height",tr_height+"px");
					});
					setCookie("picking_td_selected",picking_td_selected);
				}
			}else{
				if(btn_id==1){
					$(".chk_1").each(function(){
		    			var i=$(this).attr("id").replace("td_checkbox","").trim();
		    			checkedArray[parseInt(i)]=$(this).prop("checked");
		    		});
					var shipping_td_selected="";
					for(var i =0;i<checkedArray.length;i++){
						var td_name=$("#td_checkbox"+i).attr("name").replace("td_checkbox","");
						if(checkedArray[i]){
							shipping_td_selected+="1";
							$(".shipping_table td[index_td='"+td_name+"']").css("display","table-cell");
						}else{
							shipping_td_selected+="0";
							$(".shipping_table td[index_td='"+td_name+"']").css("display","none");
						}
					}
					
					$(".shipping_tr_content").each(function(){
						var tr_height=$(this).height();
						$(this).find("td[index_td='remark'] input").css("height",tr_height+"px");
					});
					setCookie("shipping_td_selected",shipping_td_selected);
				}
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
	<div class="parent_div">
		<c:if test="${shipping_printType==1}">
			<div class="td2_div1">浙江中自庆安新能源技术有限公司</div>
			<div class="td2_div1_center">发 货 单</div>
			<div class="contract_title">
				<div><span class="name1">客户合同号：</span><span class="name2">${shipping.customer_contract_no}</span></div>
				<div><span class="name1">客户名称：</span><span class="name2">${shipping.customer_name}</span></div>
			</div>
			<div class="contract_title">
				<div><span class="name1">申请日期：</span><span class="name2">${shipping.create_date}</span></div>
				<div><span class="name1">中自合同号：</span><span class="name2">${shipping.contract_no}</span></div>
			</div>
			<div class="contract_chose" onclick="showDialog();">查 选</div>
			<div class="contract_word">
				<span>发货明细：</span>
			</div>
			<table class="shipping_table">
				<tr class="shipping_tr_title shipping_tr">
					<td class="width:30px;">序号</td>
					<td index_td="materials_id">物料号</td>
					<td index_td="name">设备名称</td>
					<td index_td="model">型号</td>
					<td style="width:30px;" index_td="unit">单位</td>
					<td index_td="unit_price">单价</td>
					<td index_td="num">本次发货数量</td>
					<td index_td="price">本次发货金额</td>
					<td index_td="quality_no">质证号</td>
					<td index_td="remark">备注(可编辑)</td>
					<td index_td="logistics_demand">物流要求</td>
				</tr>
				<c:forEach items="${shipping.shipping_lists}" var="shipping_list" varStatus="status">
				<tr class="shipping_tr_content shipping_tr">
					<td index_td="index">${status.count}</td><td index_td="materials_id">${shipping_list.materials_id}</td>
					<td index_td="name">${shipping_list.name}</td><td index_td="model">${shipping_list.model}</td>
					<td index_td="unit">${shipping_list.unit}</td><td index_td="unit_price">${shipping_list.unit_price}</td>
					<td index_td="num">${shipping_list.num}</td><td index_td="price"></td><td index_td="quality_no">${shipping_list.quality_no}</td>
					<td index_td="remark" style="padding:0;"><input type="text" value="${shipping_list.remark}" maxlength="200"></td><td index_td="logistics_demand">${shipping_list.logistics_demand}</td>
				</tr>
				</c:forEach>
				<tr id="shipping_tr_sum">
					<td class="width:30px;" index_td="index">合计：</td>
					<td index_td="materials_id"></td>
					<td index_td="name"></td>
					<td index_td="model"></td>
					<td style="width:30px;" index_td="unit"></td>
					<td index_td="unit_price"></td>
					<td index_td="num"></td>
					<td index_td="price"></td>
					<td index_td="quality_no"></td>
					<td index_td="remark">
					</td><td index_td="logistics_demand"></td>
				</tr>
			</table>
			<div class="address_group"><span>发货地址：${shipping.address}</span><span>${shipping.linkman}</span><span>${shipping.linkman_phone}</span></div>
			<div class="div_dashed2"></div>
			<div class="bottom_white_group">
				<div>客户回执：</div>
				<div>公司盖章：</div>
				<div>签收人：</div>
				<div>签收日期：</div>
			</div>
		</c:if>
		<c:if test="${shipping_printType==0}">
			<div class="td2_div1">浙江中自庆安新能源技术有限公司</div>
			<div class="td2_div1_center">出 库 申 领 单</div>
	   		<div class="td2_div1_right">SC-04(B)</div>
	   		<div class="contract_chose2" onclick="showDialog();">查 选</div>
			<table class="picking_table">
				<tr><td colspan="2">项目名称：</td><td colspan="6">${shipping.project_name}</td></tr>
				<tr><td colspan="2">领料类型：</td><td colspan="2">${shipping.material_type}</td><td colspan="2">领料部门：</td><td colspan="2">${shipping.depart}</td></tr>
				<tr><td colspan="2">编号：</td><td colspan="2">${shipping.contract_no}</td><td colspan="2">出库时间：</td><td colspan="2">${shipping.putout_date}</td></tr>
				<tr><td colspan="8">物  料  清  单</td></tr>
				<tr class="picking_tr_title">
					<td index_td="index">序号</td>
					<td index_td="materials_id">物料号</td>
					<td index_td="name">名称</td>
					<td index_td="model">规格</td>
					<td index_td="unit">单位</td>
					<td index_td="num">数量</td>
					<td index_td="quality_no">质证号</td>
					<td index_td="remark">备注（可编辑）</td>
				</tr>
				<c:forEach items="${shipping.shipping_lists}" var="shipping_list" varStatus="status">
				<tr class="picking_tr_content">
					<td index_td="index">${status.count}</td>
					<td index_td="materials_id">${shipping_list.materials_id}</td>
					<td index_td="name">${shipping_list.name}</td>
					<td index_td="model">${shipping_list.model}</td>
					<td index_td="unit">${shipping_list.unit}</td>
					<td index_td="num">${shipping_list.num}</td>
					<td index_td="quality_no">${shipping_list.quality_no}</td>
					<td index_td="remark" style="padding:0;"><input type="text" value="${shipping_list.remark}" maxlength="200"></td>
				</tr>
				</c:forEach>
			</table>
			<div class="bottom_group_remark">注：本联由领料人员留存</div>
			<div class="bottom_group"><div class="bottom_div"><div>领料人/日期：</div><div><span class="material_uname"></span><span class="material_time"></span></div></div><div class="bottom_div"><div>批准人/日期：</div><div><span class="approve_uname"></span><span class="approve_time"></span></div></div><div class="bottom_div">仓管/日期：</div></div>
		</c:if>
		<div class="div_dashed" id="div_dashed"><div></div><div>分割线</div><div></div></div>
		<div class="div_btn">
			<div class="preview_btn" onclick="window.location.href='/ZZQA_Manager/flowmanager/backlog.jsp';">返回待办页</div>
			<div class="preview_btn" onclick="preview();">打 印</div>
			<c:if test="${operation==2&&material_requisition}">
			<div class="preview_btn" onclick="finishedMaterials();">完成领料</div>
			</c:if>
			<c:if test="${operation==4&&isShippinger}">
			<div class="preview_btn" onclick="doShipping();">执行发货</div>
			</c:if>
		</div>
	</div>
	<div class="dialog_sales">
		<div class="del_notify_div_img" onclick="closeDialog(0)"></div>
		<div class="sales_bottom"><div onclick="closeDialog(1)">确定</div></div>
	</div>
	<form action="ContractManagerServlet" method="post" name="flowform">
		<input type="hidden" name="type" value="shipping">
		<input type="hidden" name="reason" value="">
		<input type="hidden" name="isagree" value="">
		<input type="hidden" name="operation" value="${operation}">
	</form>
</body>
</html>
