<%@page import="com.zzqa.pojo.sales_contract.Sales_contract"%>
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
<%@page
	import="com.zzqa.service.interfaces.shipping.ShippingManager"%>
<%@page import="com.zzqa.pojo.shipping.Shipping"%>
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
	ShippingManager shippingManager=(ShippingManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("shippingManager");
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
	List<Map> salesList=shippingManager.getAllNoShippingSale();
	session.setAttribute("salesList", salesList);
	String[] departmentArray=DataUtil.getdepartment();
	request.setAttribute("departmentArray", departmentArray);
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>新建出货流程</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/top.css">
<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
<link rel="stylesheet" type="text/css" href="css/custom.css">
<link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
<link rel="stylesheet" type="text/css" href="css/default.css">
<link rel="stylesheet" type="text/css"
	href="css/jquery.filer-dragdropbox-theme.css">
<link rel="stylesheet" type="text/css"
	href="css/font-awesome.min.css">
<link rel="stylesheet" href="css/bootstrap/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="css/createshipping.css">
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
<script type="text/javascript" src="js/createshipping.js"></script>
<!--[if IE]>
	<script src="js/html5shiv.min.js" type="text/javascript"></script>
<![endif]-->
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
	var nowTR;//当前修改的tr
	var materialsArray=[
  	      <%int mlen=mList.size();for(int i=0;i<mlen;i++){
  	    	  Materials_info materials_info=mList.get(i);
  	    	  if(i>0){
  	    		  out.write(",");
  	    	  }
  	    	  out.write("["+materials_info.getId()+",'"+materials_info.getMaterials_id()+"','"+materials_info.getModel()+"','"+materials_info.getRemark()+"','"+(materials_info.getUnit()!=null?materials_info.getUnit():"")+"']");
  	      }%>     
  	      ];
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
				<div class="shipping_top_btns">
				<div class="btn-group" role="group" aria-label="...">
				  	<button type="button" class="btn btn-default" onclick="setPage(1)">未出货明细</button>
					<button type="button" class="btn btn-default" onclick="setPage(2)">添加出货流程</button>
				</div>
				</div>
				<div id="shipping_showone" class="shipping_showone">
					<div class="td2_div1">出货单</div>
					<span class="span_title">基本信息：</span>
					<div class="td2_div2">
						<div class="div2_name">
							<span>中自合同号：</span>
							<div>
								<jsp:include page="/flowmanager/drop_down_contract.jsp" />
							</div>
						</div>
						<div class="div2_project div2_customer">
							<span>客户名称：</span>
							<input type="text" id="customer_name" maxlength="100" readonly="readonly">
						</div>
						<div class="div2_project">
							<span>客户合同号：</span>
							<input type="text" id="customer_contract_no" maxlength="100" placeholder="选填">
						</div>
						<div class="div2_project">
							<span>领料类型：</span>
							<input type="text" id="material_type" maxlength="100">
						</div>
						<div class="div2_project">
							<span>领料部门：</span>
							<select id="department">
							<c:forEach items="${departmentArray}" var="depart" varStatus="status">
							<c:if test="${status.index!=3}">
							<option value="${status.index}">
								${depart}
							</option>
							</c:if>
							</c:forEach>
							</select>
						</div>
						<div class="div2_project">
							<span>出库时间：</span>
							<input type="text" id="putout_time" maxlength="100" onclick="return Calendar('putout_time');" readonly="readonly">
						</div>
						<div class="div2_project">
							<span>发货地址：</span>
							<input type="text" id="address" maxlength="100">
						</div>
						<div class="div2_project">
							<span>联系人：</span>
							<input type="text" id="linkman" maxlength="100">
						</div>
						<div class="div2_project">
							<span>联系电话：</span>
							<input type="text" id="linkman_phone" placeholder="格式如：0571-81818118" maxlength="100">
						</div>
					</div>
					<div class="td2_div3">
						<span>发货明细：</span>
						<img src="images/add_product.png" onclick="showDialog();">
					</div>
					<table class="shipping_tab" id="shipping_tab">
						<tr class="shipping_tr_title">
							<td style="width:30px;">序号</td>
							<td>销售人员</td>
							<td style="width:60px;">物料号</td>
							<td style="width:60px;">设备名称</td>
							<td>型号</td>
							<td>单位</td>
							<td>合同数量</td>
							<td>单价</td>
							<td style="width: 70px;">未发货数量</td>
							<td>本次发货数量</td>
							<td>本次发货金额</td>
							<td>质证号</td>
							<td style="width: 60px;">备注</td>
							<td>物流要求</td>
						</tr>
					</table>
					<div class="bottom_btn_group"><img src="images/cancle_materials.png" onclick="window.location.href='<%=basePath %>flowmanager/newflow.jsp'"><img src="images/submit_materials.png" onclick="addFlow()"></div>
					</div><div id="shipping_showall" class="shipping_showall">
						<div class="td2_div1">未出货明细</div>
						<div class="showall_search">
							<div class="showall_search1">
								<span>中自合同号：</span>
								<div>
									<jsp:include page="/flowmanager/drop_down_contract3.jsp" />
								</div>
							</div>
							<div class="showall_search2">
								<span>客户名称：</span>
								<input type="text" maxlength="15" id="customer_name1" placeholder="搜索客户名称">
								<img src="images/search_emp.png">
							</div>
							<div class="showall_search2">
								<span>销售人员：</span>
								<input type="text" maxlength="15" id="saler" placeholder="销售人员">
								<img src="images/search_emp.png">
							</div>
						</div>
						<div class="showall_title">
							<span>未出货明细表：</span>
							<img src="images/export_track.png" title="导出明细表" onclick="exportData();">
						</div>
						<table class="shipping_tab" id="shipping_tab2">
							<tr class="shipping_tr_title">
								<td style="width:30px;">序号</td>
								<td>中自合同</td>
								<td>客户名称</td>
								<td>销售人员</td>
								<td style="width:60px;">物料号</td>
								<td style="width:60px;">设备名称</td>
								<td>型号</td>
								<td>单位</td>
								<td>合同数量</td>
								<td>单价</td>
								<td style="width: 70px;">未发货数量</td>
							</tr>
						</table>
					</div>
				</td>
			</tr>
		</table>
		
	</div>
	<form action="ContractManagerServlet" method="post" name="flowform">
		<input type="hidden" name="type" value="updateshipping">
		<input type="hidden" name="operation" value="${operation}">
	</form>
	<div class="dialog_shipping">
		<div class="shipping_top"><span>序号：</span><span></span></div>
		<div class="shipping_model accessories"><span><span class="star">*</span>型号：</span>
			<div>
				<jsp:include page="/flowmanager/drop_down_model.jsp" />
			</div>
		</div>
		<div class="shipping_div"><span><span class="star">*</span>单位：</span><input type="text" maxlength="8" id="unit" ></div>
		<div class="shipping_div accessories"><span><span class="star">*</span>合同数量：</span><input type="text" maxlength="8" id="contract_num" oninput="checkIntPosition(this)"></div>
		<div class="shipping_div accessories"><span><span class="star">*</span>单价：</span><input type="text" maxlength="8" id="unit_price" oninput="checkFloatPositive(this,2)"></div>
		<div class="shipping_div accessories"><span><span class="star">*</span>未发货数量：</span><input type="text" maxlength="8" id="last_num" oninput="checkIntPosition(this)"></div>
		<div class="shipping_div"><span><span class="star">*</span>本次发货数量：</span><input type="text" maxlength="8" id="num" oninput="checkIntPosition(this)"></div>
		<div class="shipping_div"><span>质证号：</span><input type="text" maxlength="100" id="quality_no" ></div>
		<div class="shipping_div"><span>备注：</span><input type="text" maxlength="100" id="remark" ></div>
		<div class="shipping_div"><span>物流要求：</span><input type="text" maxlength="100" id="logistics_demand" ></div>
		<div class="shipping_bottom"></div>
	</div>
</body>
</html>
