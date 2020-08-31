<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="com.zzqa.pojo.leave.Leave"%>
<%@page import="com.zzqa.service.interfaces.leave.LeaveManager"%>
<%
	LeaveManager leaveManager = (LeaveManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("leaveManager");
	int uid = (Integer) session.getAttribute("uid");
	List<Leave> leaveList = leaveManager.getLeaveListAfterApproval(uid);
%>
<div id="section_leave" class="table_div_left" >
	<div id="bts-ex-2" class="selectpicker" data-live="true">
		<button data-id="prov" type="button"
			class="btn btn-lg btn-block btn-default dropdown-toggle">
			<span class="placeholder" style="font: 13px/ 17px 'SimSun';">选择请假单</span>
			<span class="caret"></span>
		</button>
		<div class="dropdown-menu">
			<div class="live-filtering" data-clear="true"
				data-autocomplete="true" data-keys="true">
				<label class="sr-only" for="input-bts-ex-2">在列表中搜索</label>
				<div class="search-box">
					<div class="input-group">
						<span class="input-group-addon" id="search-icon3"> <span
							class="fa fa-search"></span> <a href="#0"
							class="fa fa-times hide filter-clear"><span class="sr-only">清空过滤</span></a>
						</span> <input type="text" placeholder="在列表中搜索" id="input-bts-ex-2"
							class="form-control live-search" aria-describedby="search-icon3"
							tabindex="1" style="font:13px/20px 'SimSun';" />
					</div>
				</div>
				<div class="list-to-filter">
					<ul class="list-unstyled">
						<%
							for (Leave leave :leaveList) {
								String name = leave.getName();
						%>
						<li class="filter-item items" data-filter="<%=name%>"
							data-value="<%=leave.getId()%>"><%=name%></li>
						<%
							}
						%>
					</ul>
					<div class="no-search-results">
						<div class="alert alert-warning" role="alert">
							<i class="fa fa-warning margin-right-sm"></i>找不到<strong>'<span></span>'
							</strong>
						</div>
					</div>
				</div>
			</div>
		</div>
		<input type="hidden" name="bts-ex-2" id="leave_id" value="">
	</div>
</div>
