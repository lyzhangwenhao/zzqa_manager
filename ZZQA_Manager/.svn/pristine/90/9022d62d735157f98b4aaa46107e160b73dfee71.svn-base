<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page
	import="com.zzqa.service.interfaces.procurement.ProcurementManager"%>
<%@page import="com.zzqa.pojo.procurement.Procurement"%>
<%@page
	import="com.zzqa.service.interfaces.manufacture.ManufactureManager"%>
<%@page import="com.zzqa.pojo.manufacture.Manufacture"%>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page import="com.zzqa.service.interfaces.file_path.File_pathManager"%>
<%@page import="com.zzqa.pojo.file_path.File_path"%>
<%@page import="com.zzqa.service.interfaces.task.TaskManager"%>
<%@page import="com.zzqa.pojo.task.Task"%>
<%@page
	import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page
	import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%@page
	import="com.zzqa.service.interfaces.device.DeviceManager"%>
<%@page import="com.zzqa.pojo.device.Device"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.zzqa.pojo.task.Task"%>
<%request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	ManufactureManager manufactureManager = (ManufactureManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("manufactureManager");
	FlowManager flowManager = (FlowManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("flowManager");
	File_pathManager file_pathManager = (File_pathManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("file_pathManager");
	TaskManager taskManager = (TaskManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("taskManager");
	Position_userManager position_userManager = (Position_userManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("position_userManager");
	DeviceManager deviceManager=(DeviceManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("deviceManager");
	PermissionsManager permissionsManager=(PermissionsManager) WebApplicationContextUtils
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
	if (session.getAttribute("m_id") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	} 
	int m_id = (Integer)session.getAttribute("m_id");
	Manufacture manufacture = manufactureManager
			.getManufactureByID(m_id);
	Flow flow = flowManager.getNewFlowByFID(5, m_id);
	if(manufacture==null||flow==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int task_id=manufacture.getTask_id();
	Task task=null;
	boolean isWatcher=false;
	if(task_id>0){
		task= taskManager.getTaskByID(task_id);
		if(task==null){
			request.getRequestDispatcher("/login.jsp").forward(request,
					response);
			return;
		}
		isWatcher="admin".equals(mUser.getName())||task.getCreate_id()==mUser.getId();
		if(!isWatcher){
			isWatcher=(task.getType()==0&&permissionsManager.checkPermission(mUser.getPosition_id(), 10))||(task.getType()==1||permissionsManager.checkPermission(mUser.getPosition_id(), 115));
		}
	}
	 
	int operation=flow.getOperation();
	Map<String, String> map = manufactureManager.getManufactureFlowForDraw(manufacture,flow);
	List<Device> deviceList=deviceManager.getDeviceList(m_id);
	String[] qualifyArray=DataUtil.getQualifyArray();
	int k=0;//判断测试报告是否全部上传
	for(Device device:deviceList){
		if(device.getFile_path()==null){
			k++;
			break;
		}
	}
	int j=0;//判断是否设置啦所有设备的状态
	for(Device device:deviceList){
		if(device.getQualify()==0){
			j++;
			break;
		}
	}
	int m=0;//合格的设备数量
	for(Device device:deviceList){
		if(device.getQualify()==1){
			m++;
		}
	}
	boolean isAlter=permissionsManager.checkPermission(mUser.getPosition_id(), 24);
	boolean isCreater=manufacture.getCreate_id()==mUser.getId();
	boolean isBuyer=permissionsManager.checkPermission(mUser.getPosition_id(), 21);
	boolean isChecker=permissionsManager.checkPermission(mUser.getPosition_id(), 22);
	boolean isPuter=permissionsManager.checkPermission(mUser.getPosition_id(), 23);

%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">
		<title>生产流程</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css"
			href="css/manufactureflow_detail.css">
		<link rel="stylesheet" type="text/css" href="css/custom.css">
		<link rel="stylesheet" type="text/css" href="css/jquery.filer.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-filer.css">
		<link rel="stylesheet" type="text/css" href="css/default.css">
		<link rel="stylesheet" type="text/css"
			href="css/jquery.filer-dragdropbox-theme.css">
		<link rel="stylesheet" type="text/css"
			href="css/font-awesome.min.css">
		<script src="js/showdate1.js" type="text/javascript"></script>
		<script src="js/prettify.js" type="text/javascript"></script>
		<script src="js/jquery.min.js" type="text/javascript"></script>
		<script src="js/jquery.filer.min.js" type="text/javascript"></script>
		<script src="js/custom.js" type="text/javascript"></script>
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
 		<script  type="text/javascript" src="js/jquery-ui.min.js"></script>
 		<script  type="text/javascript" src="js/dialog.js"></script>
 		<script  type="text/javascript" src="js/public.js"></script>
 		
		<!--[if IE]>
			<script src="http://libs.useso.com/js/html5shiv/3.7/html5shiv.min.js"></script>
		<![endif]-->
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
		var qnum=<%=m%>;//合格的设备数量 
		function choseflow(index){
			if(index==1){
				window.location.href="flowmanager/backlog.jsp";
			}else if(index==2){
				window.location.href="flowmanager/flowlist.jsp";
			}else if(index==3){
				window.location.href="flowmanager/newflow.jsp";
			}
		}
		function validate(sDouble){
			//检验是否为正数
  			var re = /^\d+(?=\.{0,1}\d+$|$)/;
 		 	return re.test(sDouble)
		}
	   	function del(n){
	   		var id="table_tr"+n;
	   		var obj = document.getElementById(id);
			if (obj != null) {
				obj.parentNode.removeChild(obj);
			}
	   	}
	   	function delBtn(name){
	   		var obj = document.getElementById("product_complete");
			if (obj != null) {
				obj.parentNode.removeChild(obj);
			}
			var obj1 = document.getElementById("div_testarea");
			if (obj1 != null) {
				obj1.parentNode.removeChild(obj1);
			}
	   	}
	   	function deleteDevice(index,id,qualify){
		   	initdiglogtwo2("提示信息","你确定要删除该设备吗？");
	   		$( "#confirm2" ).click(function() {
				$( "#twobtndialog" ).dialog( "close" );
				Lock_CheckForm();
				$.ajax({
					type:"post",//post方法
					url:"CheckServlet",
					data:{"type":"delDevice","ID":id,"uid":<%=uid%>},
					//ajax成功的回调函数
					success:function(returnData){
						if(returnData==0){
							//删除成功
							initdiglog2("提示信息","删除成功！");
							del(index);
							if(qualify==1){
								//删除合格的，修改合格台数
								qnum--;
								document.getElementById("qnum").innerHTML=qnum+"/"+<%=manufacture.getNum()%>+"台";
								if(qnum==0){
									delBtn();//没有合格的设备，不能设生产完毕
								}
							}
						}else{
							//删除失败
						}
					}
				});
			});
		}
	   	function finishProduct(){
	   		if(<%=j%>!=0){
   				initdiglog2("提示信息","请设置所有设备的状态！");
   				return;
   			}
   			if(<%=k%>!=0){
   				initdiglog2("提示信息","请上传所有设备的测试报告！");
   				return;
   			}
	   		//实际台数少于计划台数
	   		if(qnum < <%=manufacture.getNum()%>){
	   			initdiglogtwo2("提示信息","实际台数少于计划台数，还要继续吗？");
		   		$( "#confirm2" ).click(function() {
					$( "#twobtndialog" ).dialog( "close" );
					if(document.flowform.reason.value.replace(/[ ]/g,"").length<1){
		   					initdiglog2("提示信息","请输入备注！");
		   				}else{
		   					document.flowform.submit();
		   				}
				});
	   		}else{
	   			document.flowform.submit();
	   		}
	   	}
 		function validate(sDouble){
			//检验是否为正数
  			var re = /^\d+(?=\.{0,1}\d+$|$)/;
 		 	return re.test(sDouble)&&sDouble>0;
		}
	</script>
	</head>

	<body>
	<jsp:include page="/top.jsp" >
	<jsp:param name="name" value="<%=mUser.getName() %>" />
	<jsp:param name="level" value="<%=mUser.getLevel() %>" />
	<jsp:param name="index" value="1" />
	</jsp:include>
		<div class="div_center">
			<table class="table_center">
				<tr>
					<jsp:include page="/flowmanager/flowTab.jsp">
						<jsp:param name="index" value="0" />
					</jsp:include>
					<td class="table_center_td2">
						<form action="FlowManagerServlet?type=manufactureflow&uid=<%=mUser.getId()%>&m_id=<%=manufacture.getId()%>&operation=<%=flow.getOperation() %>"
							method="post" name="flowform">
							<div class="td2_div">
								<div class="td2_div1">
									<div class="td2_div1_1">
										<div class="<%=map.get("class11") %>">
											备料
										</div>
										<div class="td2_div1_1_div"></div>
										<div class="<%=map.get("class12") %>">
											出库
										</div>
										<div class="td2_div1_1_div"></div>
										<div class="<%=map.get("class13") %>">
											生产
										</div>
										<div class="td2_div1_1_div"></div>
										<div class="<%=map.get("class14") %>">
											入库
										</div>
									</div>
									<div class="td2_div1_2">
										<div class="td2_div2_img">
											<img src="images/<%=map.get("img1") %>">
										</div>
										<div class="<%=map.get("class215") %>"></div>
										<div class="<%=map.get("class225") %>"></div>
										<div class="td2_div2_img">
											<img src="images/<%=map.get("img2") %>">
										</div>
										<div class="<%=map.get("class24") %>"></div>
										
										<div class="td2_div2_img">
											<img src="images/<%=map.get("img3") %>">
										</div>
										<div class="<%=map.get("class26") %>"></div>
										
										<div class="td2_div2_img">
											<img src="images/<%=map.get("img4") %>">
										</div>
									</div>
									<div class="td2_div1_3">
										<div class="td2_div31"><%=map.get("time1")%></div>
										<div class="td2_div32"><%=map.get("time2")%></div>
										<div class="td2_div33"><%=map.get("time3")%></div>
										<div class="td2_div34"><%=map.get("time4")%></div>
									</div>
								</div>
								<%if(operation==1||operation==5){ %>
								<%if(task_id>0){ %>
								<div class="td2_div3">
										<div class="td2_div3_1">
											项目名称：<%=task.getProject_name()%>
										</div>
										<div class="td2_div3_2">
											项目编号：<%=task.getProject_id()%>
										</div>
										<div class="td2_div3_2">
											提 交 人：<%=manufacture.getCreate_name()%>
										</div>
										<div class="td2_div3_3">
											<a href="<%=isWatcher?"FlowManagerServlet?type=flowdetail&flowtype=1&id="+task.getId():"javascript:void(0)"%>" <%=isWatcher?"target='_bank'":"onclick='canNotSee();this.blur()'" %>>查看任务单</a>
										</div>
									</div>
								<%} %>
								<table class="td2_table0">
								<tr class="table0_tr1">
									<td class="table0_tr1_td1">
										设备台数
									</td>
									<td class="table0_tr1_td2">
										<%=manufacture.getNum()+"台" %>
									</td>
								</tr>
								<tr class="table0_tr1">
									<td class="table0_tr1_td1">
										计划完成时间
									</td>
									<td class="table0_tr1_td2">
										<%=manufacture.getPredict_date() %>
									</td>
								</tr>
								</table>
								<%} %>
								<%if(operation>1&&operation<5){ %>
								<div class="td2_div4">
									<%if(task_id>0){ %>
									<div class="td2_div5">
										生产单
									</div>
								<div class="td2_div3">
										<div class="td2_div3_1">
											项目名称：<%=task.getProject_name()%>
										</div>
										<div class="td2_div3_2">
											项目编号：<%=task.getProject_id()%>
										</div>
										<div class="td2_div3_2">
											提 交 人：<%=manufacture.getCreate_name()%>
										</div>
										<div class="td2_div3_3">
											<a
												href="FlowManagerServlet?type=flowdetail&flowtype=1&id=<%=task_id%>" target='_blank''>
												<%="查看任务单" %></a>
										</div>
									</div>
								<%} %>
									<div class="td2_div5">
										生产明细表
									</div>
									<div class="td2_div6">
										<div class="td2_div61">
											计划完成时间:<%=manufacture.getPredict_date()%>
										</div>
										<div class="td2_div62" id="qnum">
											<%=deviceList.size()+"/"+manufacture.getNum()%>台
										</div>
									</div>
									<table class="td2_table1">
										<tr class="table1_tr1">
											<td class="table1_tr1_td1">ID</td>
											<td class="table1_tr1_td2">批次号SN</td>
											<td class="table1_tr1_td3">状态</td>
											<td class="table1_tr1_td4">操作</td>
										</tr>
										<%int dlen=deviceList.size();for(int i=0;i<dlen;i++){Device device=deviceList.get(i);File_path file_path=device.getFile_path();%>
										<tr class="table1_tr2" id="table_tr<%=i%>">
											<td><%=device.getIdStr()%></td>
											<td><%=device.getSn()%></td>
											<td><%=qualifyArray[device.getQualify()]%></td>
											<td>
												<div <%=operation<3?"style='margin:0 auto;width:120px;'":"" %>>
												<a href="FlowManagerServlet?type=flowdetail&flowtype=10&id=<%=device.getId()%>"><img class="tr2_td4_img1" src="images/detail.png" title="详情"></a>
												<%if(operation<3&&isAlter){ %>
												<a href="FlowManagerServlet?type=flowdetail&flowtype=11&id=<%=device.getId()%>"><img class="tr2_td4_img2" src="images/alter.png" title="修改"></a>
												<img class="tr2_td4_img2" src="images/delete.png" onclick="deleteDevice(<%=i%>,<%=device.getId() %>,<%=device.getQualify() %>)" title="删除">
												<% }%>
												<%if(file_path!=null){%>
												<a href="javascript:void()" onclick="fileDown(<%=file_path.getId()%>)"><img class="tr2_td4_img2" src="images/accessory.png" title="查看附件"></a>
												<%} %>
												</div>
											</td>
										</tr>
										<%} %>
									</table>
									<%if(operation>2){ %>
									<div class="div_test"><%=manufacture.getReason()!=null&&manufacture.getReason().length()>0?("备注："+manufacture.getReason().replace("\r\n","<br/>")):""%></div>
									<%} %>
									<%if(deviceList.size()>0&&operation==2&&isCreater){ %>
										<textarea name="reason" class="div_testarea" id="div_testarea"
										placeholder="备注(如：台数不足时)" required="required" maxlength="500"
										onkeydown="limitLength(this.form.reason,500);"
										onkeyup="limitLength(this.form.reason,500);"></textarea>
										<%} %>
								</div>
								<%}%>
								<div class="div_btn">
									<%
										if (operation==1&&isAlter) {
									%>
									
									<img src="images/req_putout.png" class="btn_agree"
										onclick="submit();">
									<%
										}
									%>
									<%
										if (operation==5&&isPuter) {
									%>
									
									<img src="images/putout.png" class="btn_agree"
										onclick="submit();">
									<%
										}
									%>
									<%
										if (operation==2&&isAlter) {
									%>
									<a href="FlowManagerServlet?type=flowdetail&flowtype=12&id=<%=manufacture.getId() %>"><img src="images/add_device_img.png" class="btn_agree"></a>
									<%
										}
									%>
									<%
										if (deviceList.size()>0&&operation==2&&isCreater) {
									%>
									<img src="images/product_complete.png" class="btn_disagree" id="product_complete"
										onclick="finishProduct()">
									<%
										}
									%>
									<%
										if (operation==3&&isPuter) {
									%>
									<img src="images/putin.png" class="btn_agree"
										onclick="submit();">
									<%
										}
									%>
								</div>
							</div>
						</form>
					</td>
				</tr>
			</table>

		</div>
	</body>
</html>
