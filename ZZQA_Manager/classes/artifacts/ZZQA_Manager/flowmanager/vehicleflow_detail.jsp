<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page import="com.zzqa.service.interfaces.vehicle.VehicleManager"%>
<%@page import="com.zzqa.pojo.vehicle.Vehicle"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%@page import="com.zzqa.util.FormTransform"%>
<%
	request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	PermissionsManager permissionsManager=(PermissionsManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("permissionsManager");
	VehicleManager vehicleManager=(VehicleManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("vehicleManager");
	FlowManager flowManager=(FlowManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("flowManager");
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
	if (session.getAttribute("vehicle_id") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	List<User> userList = userManager.getAllUserNoLeave();
	int vehicle_id = (Integer) session.getAttribute("vehicle_id");
	Vehicle vehicle=vehicleManager.getVehicleByID(vehicle_id);
	boolean v_flag=false;
	if(vehicle.getCar_info()==null||vehicle.getDriver()==0){
		v_flag=false;
	}
	int driver=vehicle.getDriver();
	String driverName="";
	boolean flag=false;
	if(driver!=0){
		flag=true;
		for(User user:userList){
			if(user.getId()==driver){
				driverName=user.getTruename();
				continue;
			}
		}
	}
	Flow flow=flowManager.getNewFlowByFID(15, vehicle_id);
	if(flow==null||vehicle==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	vehicle.setReason(new FormTransform().transRNToBR(vehicle.getReason()));
	int operation=flow.getOperation();
	Map drawMap=vehicleManager.getVehicleFlowForDraw(vehicle, flow);
	boolean canMSure=(operation==2)&&(uid==vehicle.getCreate_id());
	boolean candriver=(operation==10)&&(uid==vehicle.getDriver());
	boolean canApprove=(operation==1||operation==3)&&permissionsManager.checkPermission(mUser.getPosition_id(), 82);
	boolean canConfirm=(operation==4)&&permissionsManager.checkPermission(mUser.getPosition_id(),83);
//	System.out.print("canMSure="+canMSure);
	List<Flow> reasonList = flowManager.getReasonList(15, vehicle_id);
	String[] departmentArray = DataUtil.getdepartment();
	String[] cost_attributable=DataUtil.getCost_attributable();
	List<Vehicle> vehicles=new ArrayList<Vehicle>();
	if(canApprove){
		vehicles=vehicleManager.getRunningVehicle();
	}
	pageContext.setAttribute("mUser", mUser);
	pageContext.setAttribute("v_flag", v_flag);
	pageContext.setAttribute("userList", userList);
	pageContext.setAttribute("departmentArray", departmentArray);
	pageContext.setAttribute("drawMap", drawMap);
	pageContext.setAttribute("operation",operation);
	pageContext.setAttribute("vehicle", vehicle);
	pageContext.setAttribute("reasonList", reasonList);
	pageContext.setAttribute("flag", flag);
	pageContext.setAttribute("canApprove", canApprove);
	pageContext.setAttribute("candriver", candriver);
	pageContext.setAttribute("canConfirm", canConfirm);
	pageContext.setAttribute("cost_attributable", cost_attributable);
	pageContext.setAttribute("canMSure", canMSure);
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>用车申请流程</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/top.css">
<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
<link rel="stylesheet" type="text/css" href="css/vehicle.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
<link rel="stylesheet" type="text/css" href="css/jquery.searchableSelect.css">
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/showdate2.js"></script>
<script type="text/javascript" src="js/public.js"></script>
<script type="text/javascript" src="js/dialog.js"></script>
<script type="text/javascript" src="js/jquery.searchableSelect.js"></script>
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
		$(function(){
			$(".table_tr2_td2").html("<span style='white-space:pre;'>"+timeTransLongToStr(<%=vehicle.getStarttime()%>, 5, "/",false)+"时"+" 至 "+timeTransLongToStr(<%=vehicle.getEndtime()%>, 5, "/",false)+"时"+"</span>");
			$(".td2_table td:odd").css({"text-align":"left","padding":"0 5px"});
			$(".table_tr3_td2").css("line-height","18px");
			$(".td2_table2 td:even").css({"text-align":"left","padding":"0 5px"});
			if($(".table2_tr3_td2 select").length!=0){
				$(".table2_tr3_td2").css("text-align","center");
			}
			if(<%=candriver%>){
				var temp='';
				for(var i=0;i<24;i++){
					temp+='<option value="'+i+'">'+i+'时</option>';
				}
				$("#start_hour").html(temp);
				$("#end_hour").html(temp);
				var today=timeTransLongToStr(0, 4, "/",false);
				$("#start_driver_date").val(today);
				$("#end_driver_date").val(today);
				$("#start_hour").val(0);
				$("#end_hour").val(23);
			}else{
				$(".table2_tr5_td2").html("<span style='white-space:pre;'>"+timeTransLongToStr(<%=vehicle.getStart_driver_time()%>, 5, "/",false)+"时"+" 至 "+timeTransLongToStr(<%=vehicle.getEnd_driver_time()%>, 5, "/",false)+"时"+"</span>");
				$(".td2_table2 td:odd").css({"text-align":"left","padding":"0 5px"});
				$(".table2_tr5_td2").css("line-height","18px");
				$(".td2_table2 td:even").css({"text-align":"left","padding":"0 5px"});
				/* if($(".table2_tr5_td2 select").length!=0){
					$(".table2_tr5_td2").css("text-align","center");
				} */
			}
			if(<%=canApprove%>){
				if(vehicleArray.length>0){
					var temp='<tr class="table3_tr1"><td colspan="7" style="text-align:left;background:#DCF4FF">用车申请情况</td></tr><tr class="table3_tr1"><td>用车部门</td>'
						+'<td>申请人</td><td>目的地</td><td>使用事由</td><td>用车时间</td><td>车辆信息</td><td>状态</td></tr>';
					var stateArray=["","未审批","已审批","未审批","已用车",,,,,,"已审批"];
					for(var i=0;i<vehicleArray.length;i++){
						temp+='<tr class="table3_tr2">'
							+'<td class="tooltip_div">'+departmaneArray[vehicleArray[i][0]]+'</td>'
							+'<td class="tooltip_div">'+vehicleArray[i][1]+'</td>'
							+'<td class="tooltip_div">'+vehicleArray[i][2]+'</td>'
							+'<td class="tooltip_div">'+vehicleArray[i][3].replace(/\<br>/g, "")+'</td>'
							+'<td class="tooltip_div">'+(timeTransLongToStr(vehicleArray[i][4], 5, "/",false)+'时'+' 至 '+timeTransLongToStr(vehicleArray[i][5], 5, "/",false)+'时')+'</td>'
							+'<td class="tooltip_div">'+(vehicleArray[i][6]=="null"?"":vehicleArray[i][6])+'</td>'
							+'<td class="tooltip_div">'+stateArray[vehicleArray[i][7]]+'</td>'
							+'</tr>';
					}
					$(".td2_table3").append(temp);
					showToolTip($(".td2_table3"));
				}else{
					$(".td2_table3").remove();
				}
			}
			 $("#driver").searchableSelect();
			 $("#driver").next(".searchable-select").addClass('select-width').css("width","140px");
			 $('.searchable-select-dropdown').css({'height': '242px', 'overflow': 'hidden'});
			 $('.searchable-select-items').css('height', '200px');
		});
		<%if(canApprove){%>
		var vehicleArray=[
		       <%boolean first=false;for(Vehicle vehicle2:vehicles){
		    	   if(vehicle2.getId()!=vehicle.getId()){
		    		   if(first){
			    		   out.write(",");
			    	   }else{
			    		   first=true;
			    	   }
			    	   out.write("["+vehicle2.getApply_department()+",'"+vehicle2.getCreate_name()+"','"+vehicle2.getAddress()+"','"+new FormTransform().removeRN(vehicle2.getReason())+"',"+vehicle2.getStarttime()+","+vehicle2.getEndtime()+",'"+vehicle2.getCar_info()+"',"+vehicle2.getOperation()+"]");
		    	   }
		       }
		       %>
			];
		var departmaneArray=[
   		       <%int d_len=departmentArray.length;for(int i=0;i<d_len;i++){
   		    	   if(i>0){
   		    		   out.write(",");
   		    	   }
   		    	   out.write("['"+departmentArray[i]+"']");
   		       }
   		       %>
		   	];
		<%}%>
		function verifyFlow(isagree){
			var driver=$("#driver").val();
			var car_info=$("#car_info").val();
			if(isagree==2){
				if(<%=operation==3%> && <%=v_flag%>){
						initdiglog2("提示信息","请选择司机和填写车辆信息");
						return;
				}
				if(<%=operation!=3%>){
					if(driver==0){
						initdiglog2("提示信息","请选择司机");
						return;
					}
					if(car_info.trim().length==0){
						initdiglog2("提示信息", "请输入车辆信息");
						return;
					}
				}
			}else if(isagree==0){
				if(<%=v_flag%>){
					initdiglog2("提示信息","已选择司机和填写车辆信息，无法选择私车公用");
					return;
				}
				if(driver>0){
					initdiglog2("提示信息","私车公用不需要指定司机");
					return;
				}
				if(car_info.trim().length>0){
					initdiglog2("提示信息", "私车公用不需要填写车辆信息");
					return;
				}
			}
			if($(".div_testarea").val().trim().length==0){
				initdiglog2("提示信息","请输入意见或建议");
				return;
			}
			document.flowform.isagree.value=isagree;
			document.flowform.submit();
		}
		function confirm(opera){
			if(opera==2 || opera==10){
				if($("#remark").val().trim().length==0){
					initdiglog2("提示信息","请输入借用车辆信息");
					return;
				}
				if($("#mileage_used").val().trim().length==0){
					initdiglog2("提示信息","请输入行驶里程");
					return;
				}
				if($(".div_testarea").val().trim().length==0){
					initdiglog2("提示信息","请输入意见或建议");
					return;
				}
				if(opera==10){
					var start_driver_time=timeTransStrToLong2($("#start_driver_date").val()+" "+$("#start_hour").val()+":0:0");
					var end_driver_time=timeTransStrToLong2($("#end_driver_date").val()+" "+$("#end_hour").val()+":0:0");
					if(!(end_driver_time>start_driver_time)){
						initdiglog2("提示信息", "结束时间必须晚于出发时间");
						return;
					}
					$("#start_driver_time").val(start_driver_time);
					$("#end_driver_time").val(end_driver_time);
					
					if($("#start_mail").val().trim().length==0){
						initdiglog2("提示信息","请输入起始里程");
						return;
					}
					if($("#end_mail").val().trim().length==0){
						initdiglog2("提示信息","请输入结束里程");
						return;
					}
				}
			}
			document.flowform.type.value="vehicleflow";
			document.flowform.submit();
		}
		function deleteVehicle(){
			initdiglogtwo2("提示信息","你确定要撤销本次用车申请吗？");
	   		$( "#confirm2" ).click(function() {
	   			$( "#twobtndialog" ).dialog( "close" );
	   			if($(".div_testarea").val().trim().length>0){
	   				document.flowform.type.value="deleteVehicle";
	   				document.flowform.submit();
				}else{
					initdiglog2("提示信息","请输入撤销原因");
					return;
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
					<div class='<c:out value="${drawMap.title1_flow}"></c:out>'>
						<div class='<c:out value="${drawMap.color1}"></c:out>'>新建申请单</div>
						<div class='<c:out value="${drawMap.color2}"></c:out>'>用车审批</div>
						<div class='<c:out value="${drawMap.color3}"></c:out>'>车辆归还确认</div>
						<div class='<c:out value="${drawMap.color4}"></c:out>'><c:out value='${operation==6?"已撤销":"结束"}'></c:out></div>
					</div>
					<div class='<c:out value="${drawMap.title2_flow}"></c:out>'>
						<img src="images/<c:out value="${drawMap.img1}"></c:out>">
						<div class='<c:out value="${drawMap.bg_color1}"></c:out>'></div>
						<img src="images/<c:out value="${drawMap.img2}"></c:out>">
						<div class='<c:out value="${drawMap.bg_color2}"></c:out>'></div>
						<div class='<c:out value="${drawMap.bg_color3}"></c:out>'></div>
						<img src="images/<c:out value="${drawMap.img3}"></c:out>">
						<div class='<c:out value="${drawMap.bg_color4}"></c:out>'></div>
						<img src="images/<c:out value="${drawMap.img4}"></c:out>">
					</div>
					<div class='<c:out value="${drawMap.title3_flow}"></c:out>'>
						<div><c:out value="${drawMap.time1}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time2}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time3}" escapeXml="false"></c:out></div>
						<div><c:out value="${drawMap.time4}" escapeXml="false"></c:out></div>
					</div>
					<div class="td2_div2">用车申请表</div>
					<form
							action="NewFlowServlet" method="post" name="flowform">
							<input type="text"  name="display"  style="display:none"/><!-- 防止按回车直接上传 -->
							<input type="hidden"  name="type" value="vehicleflow"/>
							<input type="hidden"  name="operation" value="<%=operation%>"/>
							<input type="hidden"  name="isagree"/>
					<div class="td2_div3">
						<div>申请人：<c:out value="${vehicle.create_name}"></c:out></div>
						<div>审批人：<c:out value="${vehicle.approve_name}"></c:out></div>
						<div>执行人：<c:out value="${vehicle.executor_name}"></c:out>&nbsp;&nbsp;&nbsp;
						<input type="button" value="" style="display:none"></div>
					</div>
					<table class="td2_table">
						<tr class="table_tr1">
							<td class="table_tr1_td1">用车部门</td>
							<td class="table_tr1_td2">
								<c:out value="${departmentArray[vehicle.apply_department]}"></c:out>
							</td>
							<td class="table_tr1_td3">出发地</td>
							<td class="table_tr1_td4 tooltip_div">
								<c:out value="${vehicle.initial_address}"></c:out>
							</td>
							<td class="table_tr1_td3">目的地</td>
							<td class="table_tr1_td4 tooltip_div">
								<c:out value="${vehicle.address}"></c:out>
							</td>
						</tr>
						<tr class="table_tr4">
							<td class="table_tr4_td1">乘用人员</td>
							<td class="table_tr4_td2"  colspan="5">
								<c:out value="${vehicle.vehicle_person}"></c:out>
							</td>
						</tr>
						<tr class="table_tr2">
							<td class="table_tr2_td1">用车时间</td>
							<td class="table_tr2_td2" colspan="5">
							</td>
						</tr>
						<tr class="table_tr3">
							<td class="table_tr3_td1">使用事由</td>
							<td class="table_tr3_td2"  colspan="5">
								<c:out value="${vehicle.reason}" escapeXml="false"></c:out>
						</tr>
						<c:if test="${operation>1}">
							<tr class="table_tr1">
								<td class="table_tr1_td1">司机</td>
								<td class="table_tr1_td5">
									<c:out value="<%=driverName%>"></c:out>
								</td>
								<td class="table_tr1_td3">车辆信息</td>
								<td class="table_tr1_td6"  colspan="5">
									<c:out value="${vehicle.car_info}"></c:out>
								</td>
							</tr>
						</c:if>
						<c:if test="${operation==1 && canApprove}">
							<tr class="table_tr1">
								<td class="table_tr1_td1">司机</td>
								<td class="table_tr1_td5">
									<select name="driver" id="driver">
									<option value="0"></option>
										<c:forEach items="${userList}" var="userList" varStatus="list_status">
										<c:if test="${userList.id!=1}">
										<option value="<c:out value="${userList.id}"></c:out>"><c:out value="${userList.truename}"></c:out></option>
										</c:if>
										</c:forEach>
									</select>
								</td>
								<td class="table_tr1_td3">车辆信息</td>
								<td class="table_tr1_td6"  colspan="5">
									<input type="text" name="car_info" id="car_info" maxlength="100" placeholder="用公司车辆，请输入车辆信息">
								</td>
							</tr>
						</c:if>
					</table>
					<c:if test="${reasonList!= null && fn:length(reasonList) >0}">
					<table class="td2_table8">
					<c:forEach items="${reasonList}" var="reasonFlow">
					<c:if test="${reasonFlow.operation!=5}">
					<tr>
						<td class="td2_table8_left">
							<div>
								${reasonFlow.reason}
							</div>
						</td>
						<td class="td2_table8_right">
								<c:if test="${reasonFlow.operation!=2&&reasonFlow.operation!=3&&reasonFlow.operation!=5}">
									<div class="td2_div5_bottom_noimg">
								</c:if>
								<c:if test="${reasonFlow.operation==2|| reasonFlow.operation==10}">
									<div class="td2_div5_bottom_agree">
								</c:if>
								<c:if test="${reasonFlow.operation==3}">
									<div class="td2_div5_bottom_disagree">
								</c:if>
								<div style="height: 15px;"></div>
								<div class="td2_div5_bottom_right1"><c:out value="${reasonFlow.username}"></c:out></div>
								<div class="td2_div5_bottom_right2"><c:out value="${reasonFlow.create_date}"></c:out></div>
							</div>
						</td>
					</tr>
					</c:if>
					</c:forEach>
					</table>
					</c:if>
					<table class="td2_table2">
					<colgroup>
						<col class="table2_tr3_td1">  
						<col class="table2_tr3_td2">  
						<col class="table2_tr3_td3">  
						<col class="table2_tr3_td4">  
					</colgroup>
					<c:if test='${candriver||canMSure||(vehicle.remark!=null&&vehicle.remark!="")}'>
					<tr class="table2_tr1">
						<td colspan="6">车辆借用与归还信息</td>
					</tr>
					<c:if test='${flag && (candriver||(vehicle.remark!=null&&vehicle.remark!=""))}'>
						<tr class="table2_tr2">
							<td class="table2_tr2_td1">车辆情况</td>
							<td  colspan="5" class="table2_tr2_td2 tooltip_div">
								<c:if test="${candriver}">
								<input type="text" name="remark" id="remark" maxlength="100" placeholder="请填写借用车辆情况，例如停车位置、车辆有无异常情况">
								</c:if>
								<c:if test='${vehicle.remark!=null&&vehicle.remark!=""}'>
								<c:out value="${vehicle.remark}"></c:out>
								</c:if>
							</td>
						</tr>
					</c:if>
					<c:if test='${flag && (candriver||(vehicle.remark!=null&&vehicle.remark!=""))}'>
						<tr class="table2_tr6">
							<td class="table2_tr6_td1">起始里程</td>
							<td class="table2_tr6_td2">
							<c:if test="${candriver}">
								<input type="text" name="start_mail" id="start_mail" maxlength="100" placeholder="请输入起始里程">
							</c:if>
							<c:if test='${vehicle.start_mail!=null&&vehicle.start_mail!=""}'>
								<c:out value="${vehicle.start_mail}"></c:out>
							</c:if>
							</td>
							<td class="table2_tr6_td3">结束里程</td>
							<td class="table2_tr6_td4">
							<c:if test="${candriver}">
								<input type="text" name="end_mail" id="end_mail" maxlength="100" placeholder="请输入结束里程">
							</c:if>
							<c:if test='${vehicle.end_mail!=null&&vehicle.end_mail!=""}'>
								<c:out value="${vehicle.end_mail}"></c:out>
							</c:if>
							</td>
							<td class="table2_tr6_td5">行驶里程</td>
							<td class="table2_tr6_td6">
							<c:if test="${candriver}">
								<input type="text" name="mileage_used" id="mileage_used" maxlength="100" placeholder="请输入行驶里程数">
							</c:if>
							<c:if test='${vehicle.mileage_used!=null&&vehicle.mileage_used!=""}'>
								<c:out value="${vehicle.mileage_used}"></c:out>
							</c:if>
							</td>
						</tr>
						<tr class="table2_tr3">
							<td class="table2_tr3_td1">费用归属</td>
							<td class="table2_tr3_td2">
								<c:if test="${candriver}">
								<select id="cost_attributable" name="cost_attributable">
								<c:forEach items="${cost_attributable}" var="cost" varStatus="cost_status">
									<option value="<c:out value="${cost_status.index}"></c:out>"><c:out value="${cost}"></c:out></option>
								</c:forEach>
								</select>
								</c:if>
								<c:if test='${vehicle.mileage_used!=null&&vehicle.mileage_used!=""}'>
								<c:out value="${cost_attributable[vehicle.cost_attributable]}"></c:out>
								</c:if>
							</td>
							<td class="table2_tr5_td1">用车时间</td>
							<td class="table2_tr5_td2" colspan="3">
							<c:if test="${candriver}">
								<input type="hidden" name="start_driver_time" id="start_driver_time">
								<input type="hidden" name="end_driver_time" id="end_driver_time">
								<input type="text" id="start_driver_date" class="input-show-time" readonly="" onclick="return Calendar('start_driver_date');">
								<select id="start_hour">
								</select>
								<div>至</div>
								<input type="text" id="end_driver_date" class="input-show-time" readonly="" onclick="return Calendar('end_driver_date');">
								<select id="end_hour">
								</select>
							</c:if>
							</td>
						</tr>
					</c:if>
					<c:if test='${!flag && !candriver}'>
					<tr class="table2_tr2">
						<td class="table2_tr2_td1">车辆信息</td>
						<td  colspan="5" class="table2_tr2_td2 tooltip_div">
							<c:if test="${canMSure}">
							<input type="text" name="remark" id="remark" maxlength="100" placeholder="请填写借用车辆的信息，例如车牌号、品牌型号等">
							</c:if>
							<c:if test='${vehicle.remark!=null&&vehicle.remark!=""}'>
							<c:out value="${vehicle.remark}"></c:out>
							</c:if>
						</td>
					</tr>
					</c:if>
					</c:if>
					<c:if test='${!flag && !candriver && (canMSure||(vehicle.mileage_used!=null&&vehicle.mileage_used!=""))}'>
					<tr class="table2_tr3">
						<td class="table2_tr3_td1">费用归属</td>
						<td class="table2_tr3_td2">
							<c:if test="${canMSure}">
							<select id="cost_attributable" name="cost_attributable">
							<c:forEach items="${cost_attributable}" var="cost" varStatus="cost_status">
								<option value="<c:out value="${cost_status.index}"></c:out>"><c:out value="${cost}"></c:out></option>
							</c:forEach>
							</select>
							</c:if>
							<c:if test='${vehicle.mileage_used!=null&&vehicle.mileage_used!=""}'>
							<c:out value="${cost_attributable[vehicle.cost_attributable]}"></c:out>
							</c:if>
						</td>
						<td class="table2_tr3_td3">行驶里程</td>
						<td class="table2_tr3_td4 tooltip_div" colspan="3">
							<c:if test="${canMSure}">
							<input type="text" name="mileage_used" id="mileage_used" maxlength="50" placeholder="请填写行驶里程">
							</c:if>
							<c:if test='${vehicle.mileage_used!=null&&vehicle.mileage_used!=""}'>
							<c:out value="${vehicle.mileage_used}"></c:out>
							</c:if>
						</td>
					</tr>
					</c:if>
					</table>
					<table class="td2_table8">
					<c:forEach items="${reasonList}" var="reasonFlow2">
					<c:if test="${reasonFlow2.operation==5}">
					<tr>
						<td class="td2_table8_left">
							<div>${reasonFlow2.reason}</div>
						</td>
						<td class="td2_table8_right">
							<div class="td2_div5_bottom_confirm">
								<div style="height: 15px;"></div>
								<div class="td2_div5_bottom_right1"><c:out value="${reasonFlow2.username}"></c:out></div>
								<div class="td2_div5_bottom_right2"><c:out value="${reasonFlow2.create_date}"></c:out></div>
							</div>
						</td>
					</tr>
					</c:if>
					</c:forEach>
					</table>
					<c:if test="${canApprove}">
					<table class="td2_table3">
					<colgroup>
						<col class="table3_tr1_td1">
						<col class="table3_tr1_td2">
						<col class="table3_tr1_td3"> 
						<col class="table3_tr1_td4">
						<col class="table3_tr1_td5">
						<col class="table3_tr1_td6">
						<col class="table3_tr1_td7">
					</colgroup>
					</table>
					</c:if>
					<c:if test="${candriver||canApprove||(mUser.id==vehicle.create_id&&(operation<5 || operation==10))||(canConfirm&&operation==4)}">
					<textarea name="reason" class="div_testarea" placeholder="请输入意见或建议" required="required" maxlength="500"></textarea>
					</c:if>
					<div class="btn_group">
						<c:if test="${mUser.id==vehicle.create_id&&(operation<5 || operation==10) }">
							<div class="div_disagree" onclick="deleteVehicle()">撤销</div>
						</c:if>
						<c:if test="${mUser.id==vehicle.create_id&&(operation==1||operation==3)}">
							<div class="div_agree" onclick="window.location.href='<%=basePath %>flowmanager/update_vehicleflow.jsp'">修改</div>
						</c:if>
						<c:if test="${canApprove}">
							<div class="div_agree" onclick="verifyFlow(2)">同意用公司车</div>
							<div class="div_agree" onclick="verifyFlow(0)">同意私车公用</div>
							<c:if test="${operation==1}">
							<div class="div_disagree" onclick="verifyFlow(1)">不同意</div>
						</c:if>
						</c:if>
						<c:if test="${canMSure||canConfirm||candriver}">
							<div class="div_agree" onclick="confirm(<c:out value='${operation}'></c:out>);">确认</div>
						</c:if>
					</div>
					</form>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
