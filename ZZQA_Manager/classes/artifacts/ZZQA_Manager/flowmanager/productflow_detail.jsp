<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page
	import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page
	import="com.zzqa.service.interfaces.procurement.ProcurementManager"%>
<%@page
	import="com.zzqa.service.interfaces.product_procurement.Product_procurementManager"%>
<%@page
	import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.pojo.product_procurement.Product_procurement"%>
<%@page import="com.zzqa.service.interfaces.flow.FlowManager"%>
<%@page import="com.zzqa.service.interfaces.file_path.File_pathManager"%>
<%@page import="com.zzqa.pojo.permissions.Permissions"%>
<%@page import="com.zzqa.pojo.flow.Flow"%>
<%@page import="com.zzqa.pojo.procurement.Procurement"%>
<%@page import="com.zzqa.pojo.file_path.File_path"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	ProcurementManager procurementManager = (ProcurementManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("procurementManager");
	Product_procurementManager product_procurementManager = (Product_procurementManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("product_procurementManager");
	FlowManager flowManager = (FlowManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("flowManager");
	File_pathManager file_pathManager = (File_pathManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("file_pathManager");
	Position_userManager position_userManager = (Position_userManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("position_userManager");
	PermissionsManager permissionsManager = (PermissionsManager) WebApplicationContextUtils
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
	if (session.getAttribute("product_pid") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int product_pid = (Integer)session.getAttribute("product_pid");
	Product_procurement product_procurement = product_procurementManager
			.getProduct_procurementByID(product_pid);
	Flow flow = flowManager.getNewFlowByFID(2, product_pid);
	if(product_procurement==null||flow==null){
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int operation=flow.getOperation();
	List<File_path> flieList = file_pathManager.getAllFileByCondition(
			2, product_pid, 3, 0);
	List<Procurement> procurementList = procurementManager
			.getProcurementListLimit(1, product_pid);
	Map<String, String> map = product_procurementManager
			.getProductPFlowForDraw(product_procurement,flow);
	List<Flow> reasonList=flowManager.getReasonList(2,product_pid);
	boolean isCreater=mUser.getId()==product_procurement.getCreate_id();
	boolean isBuyer=permissionsManager.checkPermission(mUser.getPosition_id(), 21);
	boolean isChecker=permissionsManager.checkPermission(mUser.getPosition_id(), 22);
	boolean isPuter=permissionsManager.checkPermission(mUser.getPosition_id(), 23);
	boolean flag_pro=false;//有输入框时显示保存按钮
	pageContext.setAttribute("flieList", flieList);
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>生产采购流程</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css"
			href="css/productp_flow_detail.css">
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
		var pass_percent="";
		var procurementIDArray =[ 
			<%
			int m=procurementList.size();
			for(int i=0;i<m;i++){
				if(i!=0){
					out.write(",");
				}
				out.write("'"+procurementList.get(i).getId()+"'");
			}
			%>
			];
		function exportExcel() {
			excelExportOut(1,<%=product_procurement.getId()%>);
		}
	   	function verifyFlow(isagree){
			document.flowform.isagree.value=isagree;
			var reason=document.flowform.reason.value.replace(/[ ]/g, "");
			if(reason.length==0){
				initdiglog2("提示信息","请输入意见或建议！");
				return;
			}
			document.flowform.submit();
		}
		function submitPass(){
			for(var j=0;j<procurementIDArray.length;j++){
				var name="pass"+j;
				var pass_value=document.getElementById(name).value;
				if(!validate_pass(pass_value)){
    				initdiglog2("警告","第"+(j+1)+"行合格率输入有误！");
    				return;
  				}
  				if(j==0){
  					pass_percent=procurementIDArray[j]+"の"+pass_value;
  				}else{
  					pass_percent+="い"+procurementIDArray[j]+"の"+pass_value;
  				}
			}
			document.flowform.pass_percent.value=pass_percent;
			document.flowform.submit();
		}
		function validate_pass(sDouble){
	   		//检验是否为大于等于0且小于等于100
  			var re = /^\d+(?=\.{0,1}\d+$|$)/;
 		 	return re.test(sDouble)&&(!(sDouble>100));
		}
 		function validate(sDouble){
			//检验是否为正数
  			var re = /^\+?[1-9][0-9]*$/;
 		 	return re.test(sDouble)&&sDouble>0;
		}
		$(function(){
			if($("#procurement_finished").length>0){
				checkCover(1);
			}
			if($("#check_finished").length>0){
				checkCover(2);
			}
			if($("#save_procurement").length>0){
				checkCover(3);
			}
		});
		function checkCover(flag){
			if(flag==1){
				if(isFinish("pre")){
					$("#procurement_finished").attr("src","images/procurement_finished.png");
					$("#procurement_finished").css("cursor","pointer");
				}else{
					$("#procurement_finished").attr("src","images/procurement_finished_disabled.png");
					$("#procurement_finished").css("cursor","default");
				}
			}else if(flag==2){
				if(isFinish("aog")&&isFinish("pass")){
					$("#check_finished").attr("src","images/check_finished.png");
					$("#check_finished").css("cursor","pointer");
				}else{
					$("#check_finished").attr("src","images/check_finished_disabled.png");
					$("#check_finished").css("cursor","default");
				}
			}else if(flag==3){
				if(checkSave("pre")||checkSave("aog")){
					$("#save_procurement").attr("src","images/save.png");
					$("#save_procurement").css("cursor","pointer");
				}else{
					$("#save_procurement").attr("src","images/save_disabled.png");
					$("#save_procurement").css("cursor","default");
				}
			}
		}
		//检查是否填完
		function isFinish(id){
			for(var i=0;i<<%=procurementList.size()%>;i++){
				if($("#"+id+i).val().length==0){
					return false;
				}
			}
			return true;
		}
		//检查是否有值
		function checkSave(id){
			for(var i=0;i<<%=procurementList.size()%>;i++){
				if($("#"+id+i).val().length>0){
					return true;
				}
			}
			return false;
		}
		function updateProcurement(finished){
			var flag=finished>0?true:false;
			var pre_time="";
			//判断用户是否可编辑
			if(document.getElementById("pre0").nodeName=="INPUT"){
				for(var i=0;i<<%=procurementList.size()%>;i++){
					if(i>0){
						pre_time+="の";
					}
					if($("#pre"+i).val().length>0){
						pre_time+=$("#pre"+i).val();
					}else{
						if(finished==1){
							initdiglog2("提示信息","第"+(i+1)+"行预计时间未填写！");
							return;
						}
						pre_time+="@";
					}
				}
			}
			var aog_time="";
			var pass_percent="";
			if(<%=isChecker%>){
				for(var i=0;i<<%=procurementList.size()%>;i++){
					if(aog_time.length>0){
						aog_time+="の";
					}
					if(pass_percent.length>0){
						pass_percent+="の";
					}
					//判断用户是否可编辑
					if(document.getElementById("aog"+i).nodeName=="INPUT"){
						if($("#aog"+i).val().length>0){
							aog_time+=$("#aog"+i).val();
						}else{
							aog_time+="@";
						}
						if($("#pass"+i).val().length>0){
							if($("#aog"+i).val().length==0){
								initdiglog2("提示信息","第"+(i+1)+"行到货时间未填写！");
								return;
							}
							if(!validate_pass($("#pass"+i).val())){
								initdiglog2("提示信息","第"+(i+1)+"行合格率输入有误！");
								return;
							}
							pass_percent+=$("#pass"+i).val();
						}else{
							if(finished==2){
								initdiglog2("提示信息","第"+(i+1)+"行合格率未填写！");
								return;
							}
							pass_percent+="@";
						}
					}else{
						if(finished==2){
							initdiglog2("提示信息","第"+(i+1)+"行到货时间未填写！");
							return;
						}
						aog_time+="@";
						pass_percent+="@";
					}
				}
			}
			$.ajax({
				type:"post",//post方法
				url:"FlowManagerServlet",
				data:{"type":"productpflow","product_pid":<%=product_procurement.getId()%>,"operation":<%=operation%>,"finished":flag,"pre_time":pre_time,"aog_time":aog_time,"pass_percent":pass_percent},
				timeout : 10000, //超时时间设置，单位毫秒
				complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
					if(status=='timeout'){//超时,status还有success,error等值的情况
						initdiglog2("提示信息","请求超时，请重试!"); 
					}
				}, 
				//ajax成功的回调函数
				success:function(returnData){
					if(returnData==1){
						initdiglog2("提示信息","保存成功！");
					}else if(returnData==2){
						window.location.href="FlowManagerServlet?type=flowdetail&flowtype=2&id=<%=product_procurement.getId()%>";
					}else{
						initdiglog2("提示信息","保存失败！");						
					}
				}
			});
		}
		
		function setTime(time,obj){
			if(obj.id.substring(0,3)=="pre"){
				var nowdate="<%=DataUtil.getTadayStr()%>";
		    	//修改time的时间
		    	if(compareTime1(nowdate,time)){
		    		obj.value=time;
		    		checkCover(1);//input设为readonly没有监听事件了，只能加在这
		    		checkCover(3);
		    	}else{
		    		initdiglogtwo2("提示信息","预计到货时间早于当前时间，请确认输入无误？");
			   		$( "#confirm2" ).click(function() {
						$( "#twobtndialog" ).dialog( "close" );
						obj.value=time;
						checkCover(1);//input设为readonly没有监听事件了，只能加在这
			    		checkCover(3);
					});
		    	}
			}else{
				obj.value=time;
				checkCover(2);//input设为readonly没有监听事件了，只能加在这
				checkCover(3);
			}
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

						<form action="FlowManagerServlet?type=productpflow&uid=<%=mUser.getId()%>&product_pid=<%=product_pid%>&operation=<%=operation %>"
							method="post" name="flowform" enctype="multipart/form-data">
							<%if(operation==1||operation==3){ %><input type="hidden" name="isagree" value="0"><%} %>
							<div class="td2_div">
								<div class="td2_div1">
									<div class="td2_div1_1">
										<div class="<%=map.get("class11") %>">
											生产采购单
										</div>
										<div class="<%=map.get("class12") %>">
											采购单审核
										</div>
										<div class="<%=map.get("class13") %>">
											采购
										</div>
										<div class="<%=map.get("class15") %>">
											验货
										</div>
										<div class="<%=map.get("class16") %>">
											入库
										</div>
									</div>
									<div class="td2_div1_2">
										<div class="td2_div2_img">
											<img src="images/<%=map.get("img1") %>">
										</div>
										<div class="<%=map.get("class22") %>"></div>
										
										<div class="td2_div2_img">
											<img src="images/<%=map.get("img2") %>">
										</div>
										<div class="<%=map.get("class24") %>"></div>
										
										<div class="td2_div2_img">
											<img src="images/<%=map.get("img3") %>">
										</div>
										<div class="<%=map.get("class245") %>"></div>
										<div class="<%=map.get("class255") %>"></div>
										
										<div class="td2_div2_img">
											<img src="images/<%=map.get("img5") %>">
										</div>
										<div class="<%=map.get("class28") %>"></div>
										
										<div class="td2_div2_img">
											<img src="images/<%=map.get("img6") %>">
										</div>
									</div>
									<div class="td2_div1_3">
										<div class="td2_div31"><%=map.get("time1")%></div>
										<div class="td2_div32"><%=map.get("time2")%></div>
										<div class="td2_div33"><%=map.get("time3")%></div>
										<div class="td2_div35"><%=map.get("time5")%></div>
										<div class="td2_div36"><%=map.get("time6")%></div>
									</div>
								</div>
								<div class="td2_div2">
									<div class="td2_div3">
										<%=operation<4||operation>6?"生产采购单":"采购进度表"%>
									</div>
									<div class="div_excel">
										<img src="images/exportExcel.png" onclick="exportExcel()" title="导出">
									</div>
									<div class="td2_div7">
											<div class="td2_div71">
												提交人：<%=product_procurement.getCreate_name()%>
											</div>
											<div class="td2_div72">
												采购：<%=product_procurement.getReceive_name()%>
											</div>
											<div class="td2_div73">
												验货：<%=product_procurement.getCheck_name()%>
											</div>
											<div class="td2_div74">
												入库：<%=product_procurement.getPutin_name()%>
											</div>
									</div>
									<table class="td2_table1" id="td2_table1">
										<tr class="table1_tr1">
											<td class="table1_tr1_td1">
												序号
											</td>
											<td class="table1_tr1_td2">
												产品名称
											</td>
											<td class="table1_tr1_td3">
												品牌/制造商
											</td>
											<td class="table1_tr1_td4">
												规格/型号
											</td>
											<td class="table1_tr1_td10">
												物料编码
											</td>
											<td class="table1_tr1_td5">
												数量
											</td>
											<td class="table1_tr1_td6">
												单位
											</td>
											<%if(operation>3){ %>
											<td class="table1_tr1_td8">
												预计到货
											</td>
											<td class="table1_tr1_td9">
												实际到货
											</td>
											<td class="table1_tr1_td7">
												合格率%
											</td>
											<%} %>
										</tr>
										<%
												for (int i=0;i<procurementList.size();i++) {Procurement procurement = procurementList.get(i);
										%>
										<tr class="table1_tr2" id="table1_tr<%=i%>">
											<td class="table1_tr2_td1">
												<%=i+1%>
											</td>
											<td class="table1_tr2_td2 tooltip_div" id="name<%=i%>">
												<%=procurement.getName()%>
											</td>
											<td class="table1_tr2_td3 tooltip_div" id="agent<%=i%>">
												<%=procurement.getAgent()%>
											</td>
											<td class="table1_tr2_td4 tooltip_div" id="model<%=i%>">
												<%=procurement.getModel()%>
											</td>
											<td class="table1_tr2_td10 tooltip_div" id="materials_code<%=i%>">
												<%=procurement.getMaterials_code()%>
											</td>
											<td class="table1_tr2_td5 tooltip_div" id="num<%=i%>">
												<%=procurement.getNum()%>
											</td>
											<td class="table1_tr2_td6 tooltip_div" id="unit<%=i%>">
												<%=procurement.getUnit()%>
											</td>
											<%if(operation>3){ %>
											<td class="table1_tr2_td8" <%=operation==4&&isBuyer?"style='padding:0px;width:70px'":"id='pre"+i+"'"%>>
											<%if(operation==4&&isBuyer){flag_pro=true; %>
												<input type="text" id="pre<%=i %>" name="pre<%=i %>" value="<%=procurement.getPredict_date()%>" placeholder="输入时间..." onClick="return Calendar('pre<%=i %>');" readonly="readonly"/>
												<%}else{ %>
												<%=procurement.getPredict_date()%>
												<%} %>
											</td>
											<td class="table1_tr2_td9"" <%=operation>3&&operation<7&&isChecker&&procurement.getPredict_date().length()>1?"style='padding:0px;width:70px'":"id='aog"+i+"'"%>>
											<%if(operation>3&&operation<7&&isChecker&&procurement.getPredict_date().length()>1){flag_pro=true; %>
												<input type="text" id="aog<%=i %>" name="aog<%=i %>"  value="<%=procurement.getAog_date()%>" placeholder="输入时间..."  onClick="return Calendar('aog<%=i %>');" readonly="readonly"/>
												<%}else{ %>
												<%=procurement.getAog_date()%>
												<%} %>
											</td>
											<td class="table1_tr2_td7 tooltip_div"" <%=operation>3&&operation<7&&isChecker&&procurement.getPredict_date().length()>1?"style='padding:0px;width:70px'":"id='pass"+i+"'"%>>
											<%if(operation>3&&operation<7&&isChecker&&procurement.getPredict_date().length()>1){flag_pro=true; %>
												<input type="text" id="pass<%=i %>" name="pass<%=i %>"  value="<%=procurement.getPercent()%>"  placeholder="0-100"  oninput="value=checkDecimal(value);checkCover(2)" maxlength="6">
												<%}else{ %>
												<%=procurement.getPercent()%>
												<%} %>
											</td>
											<%} %>
										</tr>
										<%}%>
									</table>
									<table class="td2_table0">
										<tr class="table0_tr1">
											<td class="table0_tr1_td1">
												附件
											</td>
											<td class="table0_tr1_td2">
												<%
													for (File_path file_path : flieList) {
												%>
												<div>
													<a href="javascript:void()"
														onclick="fileDown(<%=file_path.getId()%>)"><%=file_path.getFile_name()%></a>
												</div>
												<%
													}
												%>
											</td>
										</tr>
									</table>
									<table class="td2_table3">
									<%int reasonLen=reasonList.size(); for(int i=0;i<reasonLen;i++){ Flow reasonFlow=reasonList.get(i);%>
										<tr>
											<td class="td2_table3_left">
												<%=reasonFlow.getReason().replaceAll("\r\n", "<br/>") %>
											</td>
											<td class="td2_table3_right">
												<div class="<%=reasonFlow.getOperation()==2?"td2_div5_bottom_agree":"td2_div5_bottom_disagree"%> ">
													<div style="height:15px;"></div>
													<div class="td2_div5_bottom_right1"><%=reasonFlow.getUsername() %></div>
													<div class="td2_div5_bottom_right2"><%=reasonFlow.getCreate_date() %></div>
												</div>
											</td>
										</tr>
										<%} %>
									</table>
								</div>
								<%
									if (flowManager.checkCanDo(2, mUser, operation)) {
								%>
								<textarea name="reason" class="div_testarea"
									placeholder="请输入意见或建议" required="required" maxlength="500"></textarea>
								<%
									}
								%>
								<div class="div_btn">
									<%if((operation==1||operation==3)&&isCreater){%>
									<a href="FlowManagerServlet?type=flowdetail&flowtype=14&id=<%=product_procurement.getId() %>" ><img src="images/alter_flow.png" class="fistbutton"></a>
									<%} %>
									<%
										if (operation == 2 && isBuyer) {
									%><img src="images/confirm.png" class="btn_agree"
										onclick="submit();">
									<%
										}
									%>
									<%
										if (operation==4&&isBuyer) {
									%>
									<img src="images/procurement_finished.png" class="fistbutton" id="procurement_finished" onclick="if($(this).css('cursor')=='pointer')updateProcurement(1);">
									<%
										}
									%>
									<%
										if ((operation>4&&operation<7)&& isChecker) {
									%>
									<img src="images/check_finished.png" class="fistbutton" id="check_finished" onclick="if($(this).css('cursor')=='pointer')updateProcurement(2);">
									<%
										}
									%>
									<%
										if ((operation==4&&isBuyer)||((operation==4||operation==5||operation==6)&&isChecker)) {
									%>
									<img src="images/save.png" class="btn_agree" id="save_procurement" onclick="if($(this).css('cursor')=='pointer'){updateProcurement(0);}">
									<%
										}
									%>
									<%
										if (operation==7&&isPuter) {
									%>
									
									<img src="images/putin.png" class="btn_agree"
										onclick="document.flowform.submit();">
									<%
										}
									%>
									<%
										if (flowManager.checkCanDo(2, mUser, operation)) {
									%>
									<img src="images/agree_flow.png" class="btn_agree"
										onclick="verifyFlow(0);">
									<%
										if (operation == 1) {
									%>
									<img src="images/disagree_flow.png" class="btn_disagree"
										onclick="verifyFlow(1);">
									<%
										}
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
