<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   <div id="bts-ex-8" class="selectpicker" data-live="true">
							<button data-id="prov" type="button" class="btn btn-lg btn-block btn-default dropdown-toggle">
								<span class="placeholder"
									style="font: 13px/ 17px 'SimSun';">选择销售合同</span>
								<span class="caret"></span>
							</button>
							<div class="dropdown-menu">
								<div class="live-filtering" data-clear="true" data-autocomplete="true" data-keys="true">
									<label class="sr-only" for="input-bts-ex-8">在列表中搜索</label>
									<div class="search-box">
										<div class="input-group">
											<span class="input-group-addon" id="search-icon3">
											<span class="fa fa-search"></span>
											<a href="#0" class="fa fa-times hide filter-clear"><span class="sr-only">清空过滤</span></a>
											</span>
											<input type="text" placeholder="在列表中搜索" id="input-bts-ex-8" class="form-control live-search" aria-describedby="search-icon3" tabindex="1" style="font:13px/20px 'SimSun';"/>
										</div>
									</div>
									<div class="list-to-filter">
										<ul class="list-unstyled">
										<c:forEach items="${salesList}" var="note_sales" varStatus="status_sales">
										<li class="filter-item items" data-filter='<c:out value="${note_sales.contract_no}"></c:out>' data-value="<c:out value="${note_sales.id}"></c:out>"><c:out value="${note_sales.contract_no}"></c:out></li>
										</c:forEach>
										</ul>
										<div class="no-search-results">
											<div class="alert alert-warning" role="alert"><i class="fa fa-warning margin-right-sm"></i>找不到<strong>'<span></span>'</strong> </div>
										</div>
									</div>
								</div>
							</div>
							<input type="hidden" name="bts-ex-8" id="sales_contractno" value="">
						</div>