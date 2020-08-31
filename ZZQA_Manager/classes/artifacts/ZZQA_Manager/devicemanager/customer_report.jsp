<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.customer_data.Customer_dataManager"%>
<%@page import="com.zzqa.pojo.customer_data.Customer_data"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	Customer_dataManager customer_dataManager=(Customer_dataManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("customer_dataManager");
	PermissionsManager permissionsManager=(PermissionsManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("permissionsManager");
	if (session.getAttribute("uid") == null) {
		response.sendRedirect("login.jsp");
		return;
	}
	int uid = (Integer) session.getAttribute("uid");
	User mUser = userManager.getUserByID(uid);
	if (mUser == null) {
		response.sendRedirect("login.jsp");
		return;
	}
	String keywords="";
	int nowpage=1;
	int pagerow=10;
	if (session.getAttribute("keywords_customer") != null) {
		keywords = (String)session.getAttribute("keywords_customer");
	}else{
		session.setAttribute("keywords_customer", keywords);
	}
	if (session.getAttribute("nowpage_customer") != null) {
		nowpage = (Integer)session.getAttribute("nowpage_customer");
	}else{
		session.setAttribute("nowpage_customer", nowpage);
	}
	if (session.getAttribute("pagerow_customer") != null) {
		pagerow = (Integer)session.getAttribute("pagerow_customer");
	}else{
		session.setAttribute("pagerow_customer", pagerow);
	}
	List<Customer_data> customers=customer_dataManager.getCustomerByCondition(1,keywords,nowpage,pagerow);
	boolean permission64=permissionsManager.checkPermission(mUser.getPosition_id(), 64);
	int num=customer_dataManager.getNumByCondition(1,keywords);
	int allpage=(num%pagerow==0?0:1)+num/pagerow;
	pageContext.setAttribute("allpage", allpage);
	pageContext.setAttribute("pagerow", pagerow);
	pageContext.setAttribute("nowpage", nowpage);
	pageContext.setAttribute("keywords", keywords);
	pageContext.setAttribute("mUser", mUser);
	pageContext.setAttribute("customers", customers);
	pageContext.setAttribute("permission64", permission64);
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>客户资料库</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="rendere" content="webkit|ie-comp|ie-stand">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/statistical.css">
		<link rel="stylesheet" type="text/css" href="css/customer_report.css">
		<link rel="stylesheet" type="text/css" href="css/custom.css">
		<link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-filer.css">
		<link rel="stylesheet" type="text/css" href="css/default.css">
		<link rel="stylesheet" type="text/css"
			href="css/jquery.filer-dragdropbox-theme.css">
		<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/prettify.js"></script>
		<script type="text/javascript" src="js/jquery.filer.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		<!-- 现将隐藏的文件上传控件添加到body中，再渲染 -->
		<script type="text/javascript" src="js/custom1.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
		$(function(){
			<%if(!permission64){%>
			$(".dialog_customer input").attr("readonly",true);
			<%}%>
		});
		var nowpage=<%=nowpage%>;
		var nowFlow="customer_report";
		function showUserDialog(id){
			var top_val=$(window).scrollTop()+100+"px";
			$(".dialog_customer").css("top",top_val);
			nowID=id;
			if( id.length>0){
				//详情
				var tr=$("#tr"+id);
				var customer_id=tr.children("td:eq(0)").text().trim();
				var company_name=tr.children("td:eq(1)").text().trim();
				var company_address=tr.children("td:eq(2)").text().trim();
				var postal_code=tr.children("td:eq(3)").text().trim();
				var law_person=tr.children("td:eq(4)").text().trim();
				var entrusted_agent=tr.children("td:eq(5)").text().trim();
				var phone=tr.children("td:eq(6)").text().trim();
				var fax=tr.children("td:eq(7)").text().trim();
				var bank=tr.children("td:eq(8)").text().trim();
				var company_account=tr.children("td:eq(9)").text().trim();
				var tariff_item=tr.children("td:eq(10)").text().trim();
				if($(".customer_top").length==0){
					$(".dialog_customer").prepend('<div class="customer_top"><span>客户编码</span><span>'+customer_id+'</span></div>');
				}else{
					$(".customer_top span:eq(1)").text(customer_id);
				}
				<%if(permission64){ %>
				$(".customer_bottom").html('<img src="images/cancle_materials.png" onclick="closeDialog(0)"><img src="images/submit_materials.png" onclick="closeDialog(2)"><img src="images/del_materials.png" id="delcustomer" onclick="closeDialog(1)">');
				<%}else{%>
				$(".customer_bottom").html('<img src="images/cancle_materials.png" onclick="closeDialog(0)">');
				<%}%>
				$("#company_name").val(company_name);
				$("#company_address").val(company_address);
				$("#postal_code").val(postal_code);
				$("#law_person").val(law_person);
				$("#entrusted_agent").val(entrusted_agent);
				$("#phone").val(phone);
				$("#fax").val(fax);
				$("#bank").val(bank);
				$("#company_account").val(company_account);
				$("#tariff_item").val(tariff_item);
			}else{
				//添加
				$(".customer_top").remove();
				$("#delcustomer").remove();
			}
			if($(".dialog_customer_bg").length==0){
				$("body").append('<div class="dialog_customer_bg"></div>');
			}
			$(".dialog_customer_bg").css("display","block");
			$(".dialog_customer").css("display","block");
		}
		var nowID=0;//选中的id
		function closeDialog(btn_id){
			if(btn_id==1){
				//删除
				initdiglogtwo2("提示信息","你确定要删除该客户吗？");
		   		$( "#confirm2" ).click(function() {
					$( "#twobtndialog" ).dialog( "close" );
					delCustomer();
				});
			}else if(btn_id==2){
				if(nowID==0){
					addCustomer();
				}else{
					alterCustomer();
				}
			}else{//取消
				$(".dialog_customer_bg").css("display","none");
				$(".dialog_customer").css("display","none");
				initDialogVal();
			}
		}
		function initDialogVal(){
			$(".customer_id input").val("");
		}
		function delCustomer(){
			$.ajax({
				type:"post",//post方法
				url:"DeviceServlet",
				data:{"type":"checkCanDelCustomer","customer_id":nowID,"customer_type":1},
				timeout : 15000, 
				//ajax成功的回调函数
				success:function(returnData){
					if(returnData==0){
						document.operaform.type.value="delcustomer";
						document.operaform.keywords.value=$("#keywords_customer").val();
						document.operaform.customer_id.value=nowID;
						document.operaform.customer_type.value=1;
						document.operaform.submit();
					}else{
						//型号已存在
						initdiglog2("提示信息","单位已经被绑定，无法删除");
						return;
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
		function addCustomer(){
			var company_name=$("#company_name").val();
			if(company_name.trim().length==0){
				initdiglog2("提示信息","请输入单位名称");
				return;
			}
			var company_address=$("#company_address").val();
			if(company_address.trim().length==0){
				initdiglog2("提示信息","请输入单位地址");
				return;
			}
			var postal_code=$("#postal_code").val().trim();
			if(postal_code.length>0){
				if(!isPostalCode(postal_code)){
					initdiglog2("提示信息","邮政编码输入有误");
					return;
				}
			}
			var law_person=$("#law_person").val();
			var entrusted_agent=$("#entrusted_agent").val();
			var phone=$("#phone").val();
			if(phone.trim().length==0){
				initdiglog2("提示信息","请输入电话");
				return;
			}
			var fax=$("#fax").val().trim();
			var bank=$("#bank").val();
			if(bank.trim().length==0){
				initdiglog2("提示信息","请输入开户银行");
				return;
			}
			var company_account=$("#company_account").val();
			if(company_account.trim().length==0){
				initdiglog2("提示信息","请输入公司账号");
				return;
			}
			var tariff_item=$("#tariff_item").val();
			if(tariff_item.trim().length==0){
				initdiglog2("提示信息","请输入税号");
				return;
			}
			$.ajax({
				type:"post",//post方法
				url:"DeviceServlet",
				data:{"type":"checkcustomer","company_name":company_name,"customer_type":1},
				timeout : 15000, 
				//ajax成功的回调函数
				success:function(returnData){
					if(returnData==0){
						document.operaform.type.value="addcustomer";
						document.operaform.keywords.value=$("#keywords_customer").val();
						document.operaform.customer_type.value=1;
						document.operaform.company_name.value=company_name;
						document.operaform.company_address.value=company_address;
						document.operaform.postal_code.value=postal_code;
						document.operaform.law_person.value=law_person;
						document.operaform.entrusted_agent.value=entrusted_agent;
						document.operaform.phone.value=phone;
						document.operaform.fax.value=fax;
						document.operaform.bank.value=bank;
						document.operaform.company_account.value=company_account;
						document.operaform.tariff_item.value=tariff_item;
						document.operaform.submit();
					}else{
						//型号已存在
						initdiglog2("提示信息","单位名称已存在");
						return;
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
		function alterCustomer(){
			var customer_id=$(".customer_top span:eq(1)").text();
			var company_name=$("#company_name").val();
			if(company_name.trim().length==0){
				initdiglog2("提示信息","请输入单位名称");
				return;
			}
			var company_address=$("#company_address").val();
			if(company_address.trim().length==0){
				initdiglog2("提示信息","请输入单位地址");
				return;
			}
			var postal_code=$("#postal_code").val().trim();
			if(postal_code.length>0){
				if(!isPostalCode(postal_code)){
					initdiglog2("提示信息","邮政编码输入有误");
					return;
				}
			}
			var law_person=$("#law_person").val();
			var entrusted_agent=$("#entrusted_agent").val();
			var phone=$("#phone").val();
			if(phone.trim().length==0){
				initdiglog2("提示信息","请输入电话");
				return;
			}
			var fax=$("#fax").val().trim();
			var bank=$("#bank").val();
			if(bank.trim().length==0){
				initdiglog2("提示信息","请输入开户银行");
				return;
			}
			var company_account=$("#company_account").val();
			if(company_account.trim().length==0){
				initdiglog2("提示信息","请输入公司账号");
				return;
			}
			var tariff_item=$("#tariff_item").val();
			if(tariff_item.trim().length==0){
				initdiglog2("提示信息","请输入税号");
				return;
			}
			$.ajax({
				type:"post",//post方法
				url:"DeviceServlet",
				data:{"type":"checkcustomer","company_name":company_name,"customer_type":1},
				timeout : 15000, 
				//ajax成功的回调函数
				success:function(returnData){
					if(returnData==nowID||returnData==0){
						document.operaform.type.value="altercustomer";
						document.operaform.keywords.value=$("#keywords_customer").val();
						document.operaform.customer_id.value=customer_id;
						document.operaform.customer_type.value=1;
						document.operaform.company_name.value=company_name;
						document.operaform.company_address.value=company_address;
						document.operaform.postal_code.value=postal_code;
						document.operaform.law_person.value=law_person;
						document.operaform.entrusted_agent.value=entrusted_agent;
						document.operaform.phone.value=phone;
						document.operaform.fax.value=fax;
						document.operaform.bank.value=bank;
						document.operaform.company_account.value=company_account;
						document.operaform.tariff_item.value=tariff_item;
						document.operaform.submit();
					}else{
						//型号已存在
						initdiglog2("提示信息","单位名称已存在");
						return;
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
		function pageBegin(){
			document.filterform.nowpage.value=1;
			customerFilter();
		}
		function pageUP(){
			if(<%=nowpage > 1%>){
				document.filterform.nowpage.value=<%=nowpage%>-1;
				customerFilter();
			}else{
				initdiglog2("提示信息","已经是首页！");
			}
		}
		function pageDown(){
			if(<%=nowpage < allpage%>){
				document.filterform.nowpage.value=<%=nowpage%>+1;
				customerFilter();
			}else{
				initdiglog2("提示信息","已经是最后一页！");
			}
		}
		function pageLast(){
			document.filterform.nowpage.value=<%=allpage%>;
			customerFilter();
		}
		function customerFilter(){
			document.filterform.submit();
		}
		 $(function(){
			 $("#keywords_customer").keydown(function(e){
				if(e.keyCode==13){
					searchMaterial();
				}
			});
		 });
		function searchMaterial(){
			document.filterform.nowpage.value=1;
			customerFilter();
		}
		//导入成功，刷新页面
		function doNext(){
			window.location.reload();
		}
		</script>
	</head>

	<body onload="">
		<jsp:include page="/top.jsp" >
	<jsp:param name="name" value="<%=mUser.getName() %>" />
	<jsp:param name="level" value="<%=mUser.getLevel() %>" />
	<jsp:param name="index" value="2" />
	</jsp:include>
		<div class="td1_device">
			<form action="DeviceServlet?type=customerfilter" method="post"
				name="filterform">
				<input type="text" style="display:none">
				<input type="hidden" name="customer_type" value="1">
				<input type="hidden" name="nowpage">
				<div class="td1_div3">
					客户资料库
				</div>
				<div class="td1_div4">
					<img title="添加" src="images/add_materials.png" id="addCustomer" 
						onclick="showUserDialog('');" class="addCustomer" <%if(!permission64){ %>style="position:relative;z-index:-1"<%} %>>
					<%if(permission64){ %>
					<img title="导入表格" src="images/import_materials.png" onclick="$('#exportExcel_div .jFiler-input').click();" class="importCustomer">
					<%}%>
					<img title="导出表格" src="images/export_track.png" id="img_export" onclick="loadDownCustomer(1);" class="exportCustomer">
					<img title="搜索" src="images/user_search.gif" id="searchCustomer" 
						onclick="searchMaterial();" class="searchCustomer">
					<input type="text" name="keywords_customer" id="keywords_customer"  maxlength="30" placeholder="" value="<%=keywords%>" 
						onkeydown="if(event.keyCode==32) return false">
				</div>
				<table class="device_tab">
					<tr class="tab_tr1">
						<td class="tab_tr1_td1" style="width: 80px;">
							客户编码
						</td>
						<td class="tab_tr1_td2" >
							单位名称
						</td>
						<td class="tab_tr1_td3" >
							单位地址
						</td>
						<td class="tab_tr1_td4" >
							邮政编码
						</td>
						<td class="tab_tr1_td5" >
							法人代表
						</td>
						<td class="tab_tr1_td6" >
							委托代理人
						</td>
						<td class="tab_tr1_td7" >
							电话
						</td>
						<td class="tab_tr1_td8" >
							传真
						</td>
						<td class="tab_tr1_td9" >
							开户银行
						</td>
						<td class="tab_tr1_td10" >
							公司账号
						</td>
						<td class="tab_tr1_td11" >
							税号
						</td>
					<c:forEach items="${customers}" varStatus="status" var="customer">
					<tr id="tr<c:out value="${customer.customer_id}"></c:out>" class="tab_tr2 tr_pointer" onclick="showUserDialog('${customer.customer_id}');">
						<td class="tab_tr1_td1 tooltip_div">
							<c:out value="${customer.customer_id}"></c:out>
						</td>
						<td class="tab_tr1_td2 tooltip_div" >
							<c:out value="${customer.company_name}"></c:out>
						</td>
						<td class="tab_tr1_td3 tooltip_div" >
							<c:out value="${customer.company_address}"></c:out>
						</td>
						<td class="tab_tr1_td4 tooltip_div" >
							<c:out value="${customer.postal_code}"></c:out>
						</td>
						<td class="tab_tr1_td5 tooltip_div" >
							<c:out value="${customer.law_person}"></c:out>
						</td>
						<td class="tab_tr1_td6 tooltip_div" >
							<c:out value="${customer.entrusted_agent}"></c:out>
						</td>
						<td class="tab_tr1_td7 tooltip_div" >
							<c:out value="${customer.phone}"></c:out>
						</td>
						<td class="tab_tr1_td8 tooltip_div" >
							<c:out value="${customer.fax}"></c:out>
						</td>
						<td class="tab_tr1_td9 tooltip_div" >
							<c:out value="${customer.bank}"></c:out>
						</td>
						<td class="tab_tr1_td10 tooltip_div" >
							<c:out value="${customer.company_account}"></c:out>
						</td>
						<td class="tab_tr1_td11 tooltip_div" >
							<c:out value="${customer.tariff_item}"></c:out>
						</td>
					</tr>
					</c:forEach>
				</table>
				<div class="td2_div5">
					<c:if test="${nowpage <2}">
						<span class="span_nomal">首页</span>
						<span class="span_nomal">&lt;</span>
					</c:if>
					<c:if test="${nowpage> 1}">
						<span class="span_press" onclick="pageBegin();">首页</span>
						<span class="span_press" onclick="pageUP();">&lt;</span>
					</c:if>
					<span class="span_page"><c:out value="${allpage==0?0:nowpage}"></c:out>/<c:out value="${allpage}"></c:out></span>
					<c:if test="${allpage < 2 || nowpage == allpage}">
						<span class="span_nomal">&gt;</span>
						<span class="span_nomal">尾页</span>
					</c:if>
					<c:if test="${allpage >1&&nowpage != allpage}">
						<span class="span_press" onclick="pageDown();">&gt;</span>
						<span class="span_press" onclick="pageLast();">尾页</span>
					</c:if>
				</div>
			</form>
			<form action="DeviceServlet?" method="post"
				name="operaform">
				<input type="hidden" name="type">
				<input type="hidden" name="keywords">
				<input type="hidden" name="customer_id">
				<input type="hidden" name="customer_type" value="1">
				<input type="hidden" name="company_name">
				<input type="hidden" name="company_address">
				<input type="hidden" name="postal_code">
				<input type="hidden" name="law_person">
				<input type="hidden" name="entrusted_agent">
				<input type="hidden" name="phone">
				<input type="hidden" name="fax">
				<input type="hidden" name="bank">
				<input type="hidden" name="company_account">
				<input type="hidden" name="tariff_item">
			</form>
		</div>
		<div class="dialog_customer">
			<div class="customer_id"><div><span class="star">*</span>单位名称</div><input type="text" id="company_name" maxlength="100"></div>
			<div class="customer_id"><div><span class="star">*</span>单位地址</div><input type="text" id="company_address" maxlength="200"></div>
			<div class="customer_id"><div>邮政编码</div><input type="text" id="postal_code" maxlength="10"></div>
			<div class="customer_id"><div>法人代表</div><input type="text" id="law_person" maxlength="100"></div>
			<div class="customer_id"><div>委托代理人</div><input type="text" id="entrusted_agent" maxlength="100"></div>
			<div class="customer_id"><div><span class="star">*</span>电话</div><input type="text" id="phone" maxlength="20" oninput="this.value=checkTel(this.value)"></div>
			<div class="customer_id"><div>传真</div><input type="text" id="fax" maxlength="20" oninput="this.value=checkFax(this.value)"></div>
			<div class="customer_id"><div><span class="star">*</span>开户行</div><input type="text" id="bank" maxlength="100"></div>
			<div class="customer_id"><div><span class="star">*</span>公司账户</div><input type="text" id="company_account" maxlength="50"></div>
			<div class="customer_id"><div><span class="star">*</span>税号</div><input type="text" id="tariff_item" maxlength="100"></div>
			<div class="customer_bottom"><img src="images/cancle_materials.png" onclick="closeDialog(0)"><img src="images/submit_materials.png" onclick="closeDialog(2)"><img src="images/del_materials.png" id="delcustomer" onclick="closeDialog(1)"></div>
		</div>
	</body>
</html>
