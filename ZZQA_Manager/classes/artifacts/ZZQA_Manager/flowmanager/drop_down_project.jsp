<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.project_procurement.Project_procurementManager"%>
<%@page import="com.zzqa.pojo.project_procurement.Project_procurement"%>
<% 
Project_procurementManager project_procurementManager=(Project_procurementManager)WebApplicationContextUtils
.getRequiredWebApplicationContext(getServletContext())
.getBean("project_procurementManager");
List<Project_procurement> list=project_procurementManager.getAllApplyedProjectList((Integer)session.getAttribute("uid"));
pageContext.setAttribute("project_list", list);
%>
<div id="bts-ex-9" class="selectpicker" data-live="true" data-clear="true">
   	<a href="#" class="clear"><span class="fa fa-times"></span><span class="sr-only">清除选中</span></a>
	<button data-id="prov" type="button" class="btn btn-lg btn-block btn-default dropdown-toggle">
		<span class="placeholder"
			style="font: 13px/ 17px 'SimSun';">选择项目采购单</span>
		<span class="caret"></span>
	</button>
	<div class="dropdown-menu">
		<div class="live-filtering" data-clear="true" data-autocomplete="true" data-keys="true">
			<label class="sr-only" for="input-bts-ex-9">在列表中搜索</label>
			<div class="search-box">
				<div class="input-group">
					<span class="input-group-addon" id="search-icon3">
					<span class="fa fa-search"></span>
					<a href="#0" class="fa fa-times hide filter-clear"><span class="sr-only">清空过滤</span></a>
					</span>
					<input type="text" placeholder="在列表中搜索" id="input-bts-ex-9" class="form-control live-search" aria-describedby="search-icon3" tabindex="1" style="font:13px/20px 'SimSun';"/>
				</div>
			</div>
			<div class="list-to-filter">
				<ul class="list-unstyled">
				<c:forEach items="${project_list}" var="pp">
				<li class="filter-item items" data-filter='<c:out value="${pp.name}"></c:out>' data-value="<c:out value="${pp.id}"></c:out>"><c:out value="${pp.name}"></c:out></li>
				</c:forEach>
				</ul>
				<div class="no-search-results">
					<div class="alert alert-warning" role="alert"><i class="fa fa-warning margin-right-sm"></i>找不到<strong>'<span></span>'</strong> </div>
				</div>
			</div>
		</div>
	</div>
	<input type="hidden" name="bts-ex-9" id="project_pid" value="">
</div>