<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page
	import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page
	import="com.zzqa.service.interfaces.shipping.ShippingManager"%>
<%@page
	import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.pojo.shipping.Shipping"%>
<%@page import="com.zzqa.pojo.shipping_list.Shipping_list"%>
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
	if (session.getAttribute("shipping_id") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int shipping_id = (Integer) session.getAttribute("shipping_id");
	Shipping shipping=shippingManager.getShippingDetailById(shipping_id);
	Flow flow=flowManager.getNewFlowByFID(18, shipping_id);
	if(flow==null||shipping==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int operation=flow.getOperation();
	boolean canApprove=flowManager.checkCanDo(18, mUser, operation);
	boolean material_requisition=permissionsManager.checkPermission(mUser.getPosition_id(), 128);
	if(operation==2&&material_requisition){
		session.setAttribute("shipping_printType", 0);
		response.sendRedirect("/ZZQA_Manager/flowmanager/preview_shipping.jsp");
		return;
	}
	boolean isShippinger=permissionsManager.checkPermission(mUser.getPosition_id(), 129);
	Flow flow_del=flowManager.getFlowByOperation(18, shipping_id, 7);
	List<Flow> reasonList=flowManager.getReasonList(18, shipping_id);
	Map<String, String> drawMap= shippingManager.getShippingFlowForDraw(shipping,flow);
	pageContext.setAttribute("shipping", shipping);
	pageContext.setAttribute("mUser", mUser);
	pageContext.setAttribute("operation", operation);
	pageContext.setAttribute("drawMap", drawMap);
	pageContext.setAttribute("reasonList", reasonList);
	pageContext.setAttribute("canApprove", canApprove);
	pageContext.setAttribute("material_requisition", material_requisition);
	pageContext.setAttribute("isShippinger", isShippinger);
	pageContext.setAttribute("deling", flow_del!=null);
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>出货流程详情</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/top.css">
<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
<link rel="stylesheet" type="text/css" href="css/shipping.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
<script src="js/jquery.min.js" type="text/javascript"></script>
<script  type="text/javascript" src="js/jquery-ui.min.js"></script>
<script  type="text/javascript" src="js/dialog.js"></script>
<script  type="text/javascript" src="js/public.js"></script>
<script type="text/javascript" src="js/showdate2.js"></script>
<script type="text/javascript" src="js/shipping.js"></script>
<!--[if IE]>
	<script src="js/html5shiv.min.js" type="text/javascript"></script>
<![endif]-->
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
		var now_show=false;//隐藏状态
		var operation=${operation};
		var deling=${deling};
		var material_requisition=${material_requisition};
		var isShippinger=${isShippinger};
		$(function(){
			/* if(operation==2&&material_requisition){
				//直接打印出库申领单
				//document.getElementById("print_materials").click();
				window.location.href='FlowManagerServlet?type=flowdetail&flowtype=29&id=${shipping.id}';
				return;
			}else if(operation>2&&isShippinger){
				//直接打印发货单
				//window.location.href='flowmanager/preview_shipping.jsp';
			} */
			if(${operation==5&&isShippinger}){
				if($("#ship_time").val().length==0){
					$("#ship_time").val(timeTransLongToStr(0,4,"/",false));
				}
			}
		});
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
						<div class='${drawMap.color1}'>新建发货申请</div>
						<div class='${drawMap.color2}'>发货审批下达</div>
						<div class='${drawMap.color3}'>仓库执行领料</div>
						<div class='${drawMap.color4}'>发货执行</div>
						<div class='${drawMap.color5}'>${operation==7?"已撤销":"信息反馈"}</div>
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
					</div>
					<div class='${drawMap.title3_flow}'>
						<div><c:out value="${drawMap.time1}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time2}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time3}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time4}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time5}" escapeXml="false"></c:out></div>
					</div>
					<div class="td2_div1">出货单</div>
					<span class="span_title">基本信息：</span>
					<div class="td2_div2">
						<div class="div2_name">
							<span>客户名称：</span>
							<div id="customer_name">
								${shipping.customer_name}
							</div>
						</div>
						<div class="div2_name">
							<span>客户合同号：</span>
							<div id="customer_contract_no">
								${shipping.customer_contract_no}
							</div>
						</div>
						<div class="div2_name">
							<span>中自合同号：</span>
							<div id="contract_no">
								${shipping.contract_no}
							</div>
						</div>
						<%-- <div class="div2_name">
							<span>项目名称：</span>
							<div id="project_name">
								${shipping.project_name}
							</div>
						</div> --%>
						<div class="div2_name">
							<span>领料类型：</span>
							<div id="material_type">
								${shipping.material_type}
							</div>
						</div>
						<div class="div2_name">
							<span>领料部门：</span>
							<div id="department">
								${shipping.depart}
							</div>
						</div>
						<div class="div2_time">
							<span>出库时间：</span>
							<div id="putout_date">
							${shipping.putout_date}
							</div>
							<span>合同状态：</span>
							<div id="state">
							</div>
							<span>申请人：</span>
							<div id="create_name">${shipping.create_name}</div>
						</div>
					</div>
					<div class="td2_div3">
						<span>发货明细：</span>
					</div>
					<table class="shipping_tab">
						<tr class="shipping_tr_title">
							<td style="width:30px;">序号</td>
							<td style="width:60px;">物料号</td>
							<td style="width:60px;">设备名称</td>
							<td>型号</td>
							<td>单位</td>
							<td>合同数量</td>
							<td style="width:60px;">单价</td>
							<td style="width: 70px;">未发货数量</td>
							<td>本次发货数量</td>
							<td>本次发货金额</td>
							<td>质证号</td>
							<td style="max-width: 60px;">备注</td>
							<td>物流要求</td>
						</tr>
						<c:forEach items="${shipping.shipping_lists}" var="shipping_list" varStatus="status">
						<tr class="shipping_tr_content" product_id="${shipping_list.product_id}" index_tr="${status.index}">
							<td index_td="index" class="tooltip_div">${status.count}</td>
							<td index_td="materials_id" class="tooltip_div">${shipping_list.materials_id}</td>
							<td index_td="name" class="tooltip_div">${shipping_list.name}</td>
							<td index_td="model" class="tooltip_div">${shipping_list.model}</td>
							<td index_td="unit" class="tooltip_div">${shipping_list.unit}</td>
							<td index_td="contract_num" class="tooltip_div" >${shipping_list.contract_num}</td>
							<td index_td="unit_price" class="tooltip_div">${shipping_list.unit_price}</td>
							<td index_td="last_num" class="tooltip_div" style="width: 70px;">${shipping_list.last_num}</td>
							<td index_td="num" class="tooltip_div">${shipping_list.num}</td>
							<td index_td="price" class="tooltip_div"></td>
							<td index_td="quality_no" class="tooltip_div">${shipping_list.quality_no}</td>
							<td index_td="remark" class="tooltip_div">${shipping_list.remark}</td>
							<td index_td="logistics_demand" class="tooltip_div">${shipping_list.logistics_demand}</td>
						</tr>
						</c:forEach>
					</table>
					<div class="address_group"><span>发货地址：${shipping.address}</span><span>${shipping.linkman}</span><span>${shipping.linkman_phone}</span></div>
					<c:if test="${fn:length(reasonList)>0}">
					<div class="hide-btn" onclick="showApprove()"><span>显示审批</span><img src="images/show_check.png"></div>
					<table class="td2_table3">
					<c:forEach items="${reasonList}" var="reasonFlow">
						<tr>
							<td class="td2_table3_left">
								${reasonFlow.reason}
							</td>
							<td class="td2_table3_right">
							<c:if test="${reasonFlow.operation==2}">
							<div class="td2_div5_bottom_agree">
							</c:if>
							<c:if test="${reasonFlow.operation==3}">
							<div class="td2_div5_bottom_disagree">
							</c:if>
							<c:if test="${reasonFlow.operation!=2&&reasonFlow.operation!=3}">
							<div class="td2_div5_bottom_noimg">
							</c:if>
									<div style="height: 15px;"></div>
									<div class="td2_div5_bottom_right1">${reasonFlow.username}</div>
									<div class="td2_div5_bottom_right2">${reasonFlow.create_date}</div>
								</div>
							</td>
						</tr>
					</c:forEach>
					</table>
					</c:if>
					<c:if test="${operation==5&&isShippinger}">
					<div class="shipping_real_group">
					<div>信息反馈</div>
					<div class="shipping_real_left"><span>实际发货时间</span><input id="ship_time" onclick="return Calendar('ship_time');" value="${shipping.ship_time>0?shipping.ship_date:""}" readonly="readonly"></div>
					<div class="shipping_real_right"><span>件数</span><input id="logistics_num" maxlength="20" value="${shipping.logistics_num!=null?shipping.logistics_num:""}"></div>
					<div class="shipping_real_left"><span>物流公司</span><input id="logistics_company" value="${shipping.logistics_company}" maxlength="100"></div>
					<div class="shipping_real_right"><span>物流单号</span><input id="orderId" value="${shipping.orderId}" maxlength="100"></div>
					</div>
					</c:if>
					<c:if test="${operation!=5&&shipping.ship_time>0}">
					<table class="shipping_real_table">
						<tr><td>实际发货时间</td><td>件数</td><td>物流公司</td><td>物流单号</td></tr>
						<tr><td>${shipping.ship_date}</td><td>${shipping.logistics_num}</td>
						<td>${shipping.logistics_company}</td><td>${shipping.orderId}</td></tr>
					</table>
					</c:if>
					<c:if test="${canApprove||(mUser.id==shipping.create_id&&operation!=7&&!deling)}">
						<textarea id="reason" class="div_testarea" 
						placeholder="请输入意见或建议" required="required" maxlength="500"></textarea>
					</c:if>
					<div class="div_btn">
						<c:if test="${shipping.create_id == mUser.id&& operation != 6&& operation != 7&&!deling}">
						<div onclick="window.location.href='FlowManagerServlet?type=flowdetail&flowtype=31&id=${shipping.id}'"
						 class="preview_btn" >修 改</div>
						</c:if>
						<c:if test="${mUser.id==shipping.create_id&&operation!=7&&!deling}">
							<div class="disagree_btn" onclick="cancleTask();">撤 销</div>
						</c:if>
						<c:if test="${canApprove}">
							<div class="preview_btn" onclick="verifyFlow(0);">同 意</div>
							<c:if test="${operation ==1}">
								<div class="disagree_btn" onclick="verifyFlow(1);">不同意</div>
							</c:if>
						</c:if>
						<c:if test="${operation!=1&&operation!=3}">
						<a href="FlowManagerServlet?type=flowdetail&flowtype=29&id=${shipping.id}" id="print_materials" target="_blank"><div class="preview_btn">打印领料单</div></a>
						</c:if>
						<c:if test="${shipping.material_man_id>0}">
						<a href="FlowManagerServlet?type=flowdetail&flowtype=30&id=${shipping.id}" target="_blank"><div class="preview_btn">打印出货单</div></a>
						</c:if>
						<c:if test="${operation==2&&material_requisition}">
						<div class="preview_btn" onclick="finishedMaterials();">完成领料</div>
						</c:if>
						<c:if test="${operation==4&&isShippinger}">
						<div class="preview_btn" onclick="doShipping();">执行发货</div>
						</c:if>
						<c:if test="${operation==5&&isShippinger}">
						<div class="preview_btn" onclick="finishedShipping();">发货反馈</div>
						</c:if>
					</div>
				</td>
			</tr>
		</table>
		
	</div>
	<form action="ContractManagerServlet" method="post" name="flowform">
		<input type="hidden" name="type" value="shipping">
		<input type="hidden" name="reason" value="">
		<input type="hidden" name="isagree" value="">
		<input type="hidden" name="ship_time" value="">
		<input type="hidden" name="logistics_num" value="">
		<input type="hidden" name="logistics_company" value="">
		<input type="hidden" name="orderId" value="">
		<input type="hidden" name="operation" value="${operation}">
	</form>
	<div class="dialog_shipping">
		<div class="shipping_top"><span>序号：</span><span id="order"></span></div>
		<div class="shipping_model"><span>物料号：</span>
			<div id="materials_id"></div>
		</div>
		<div class="shipping_model"><span>设备名称：</span>
			<div id="name"></div>
		</div>
		<div class="shipping_model"><span>型号：</span>
			<div id="model"></div>
		</div>
		<div class="shipping_model"><span>单位：</span><div id="unit"></div></div>
		<div class="shipping_model"><span>合同数量：</span><div id="contract_num"></div></div>
		<div class="shipping_model"><span>单价：</span><div id="unit_price"></div></div>
		<div class="shipping_model"><span>未发货数量：</span><div id="last_num"></div></div>
		<div class="shipping_model"><span>本次发货数量：</span><div id="num"></div></div>
		<div class="shipping_model"><span>本次发货金额：</span><div id="price"></div></div>
		<div class="shipping_model"><span>质证号：</span><div id="quality_no"></div></div>
		<div class="shipping_div"><span>备注：</span><textarea id="remark" readonly="readonly" ></textarea></div>
		<div class="shipping_div"><span>物流要求</span><textarea id="logistics_demand"></textarea></div>
		<div class="shipping_bottom"><img src="images/cancle_materials.png" onclick="closeDialog()"></div>
	</div>
</body>
</html>
