<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.zzqa.pojo.customer_data.Customer_data"%>
<%@page
	import="com.zzqa.service.interfaces.customer_data.Customer_dataManager"%>
	<%@page
	import="com.zzqa.service.interfaces.sales_contract.Sales_contractManager"%>
<%@page import="com.zzqa.pojo.sales_contract.Sales_contract"%>
<% 
Customer_dataManager customer_dataManager = (Customer_dataManager) WebApplicationContextUtils
	.getRequiredWebApplicationContext(getServletContext())
	.getBean("customer_dataManager");
Sales_contractManager sales_contractManager=(Sales_contractManager)WebApplicationContextUtils
	.getRequiredWebApplicationContext(getServletContext())
	.getBean("sales_contractManager");
String a=request.getParameter("customer_type");
int type="1".equals(request.getParameter("customer_type"))?1:2;
List<String> namelist=customer_dataManager.getCompany_names(type);
pageContext.setAttribute("namelist", namelist);
%>
   <div id="bts-ex-4" class="selectpicker" data-live="true">
							<button data-id="prov" type="button" class="btn btn-lg btn-block btn-default dropdown-toggle">
								<span class="placeholder"
									style="font: 13px/ 17px 'SimSun';"><%=type==1?"选择客户名称":"选择供应商名称" %></span>
								<span class="caret"></span>
							</button>
							<div class="dropdown-menu">
								<div class="live-filtering" data-clear="true" data-autocomplete="true" data-keys="true">
									<label class="sr-only" for="input-bts-ex-4">在列表中搜索</label>
									<div class="search-box">
										<div class="input-group">
											<span class="input-group-addon" id="search-icon3">
											<span class="fa fa-search"></span>
											<a href="#0" class="fa fa-times hide filter-clear"><span class="sr-only">清空过滤</span></a>
											</span>
											<input type="text" placeholder="在列表中搜索" id="input-bts-ex-4" class="form-control live-search" aria-describedby="search-icon3" tabindex="1" style="font:13px/20px 'SimSun';"/>
										</div>
									</div>
									<div class="list-to-filter">
										<ul class="list-unstyled">
										<c:forEach items="${namelist}" var="company_name">
										<li class="filter-item items" data-filter='<c:out value="${company_name}"></c:out>' data-value="<c:out value="${company_name}"></c:out>"><c:out value="${company_name}"></c:out></li>
										</c:forEach>
										</ul>
										<div class="no-search-results">
											<div class="alert alert-warning" role="alert"><i class="fa fa-warning margin-right-sm"></i>找不到<strong>'<span></span>'</strong> </div>
										</div>
									</div>
								</div>
							</div>
							<input type="hidden" name="bts-ex-4" id="cname_input" value="">
						</div>