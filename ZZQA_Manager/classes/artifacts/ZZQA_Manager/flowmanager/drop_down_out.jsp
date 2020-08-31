<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.zzqa.pojo.product_procurement.Product_procurement"%>
<%@page
	import="com.zzqa.service.interfaces.product_procurement.Product_procurementManager"%>
<% 
Product_procurementManager product_procurementManager = (Product_procurementManager) WebApplicationContextUtils
		.getRequiredWebApplicationContext(getServletContext())
		.getBean("product_procurementManager");
List<Product_procurement> product_procurementList = product_procurementManager.getFinishedProduct_procurement();

%>
<div id="bts-ex-4" class="selectpicker" data-live="true" data-clear="true">
	<a href="#" class="clear"><span class="fa fa-times"></span><span class="sr-only">清除选中</span></a>
	<button data-id="prov" type="button" class="btn btn-lg btn-block btn-default dropdown-toggle">
		<span class="placeholder"
			style="font: 13px/ 17px 'SimSun';">选择生产采购单</span>
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
				<%for(Product_procurement product_procurement:product_procurementList){ %>
				<li class="filter-item items" data-filter="<%=product_procurement.getName() %>" data-value="<%=product_procurement.getId()%>"><%=product_procurement.getName() %></li>
					<%} %>
				</ul>
				<div class="no-search-results">
					<div class="alert alert-warning" role="alert"><i class="fa fa-warning margin-right-sm"></i>找不到<strong>'<span></span>'</strong> </div>
				</div>
			</div>
		</div>
	</div>
	<input type="hidden" name="bts-ex-4" id="task_id_input" value="">
</div>