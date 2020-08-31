<%@page import="com.zzqa.util.DataUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	Position_userManager position_userManager=(Position_userManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext()).getBean(
					"position_userManager");
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
	Position_user position_user = position_userManager.getPositionByID(mUser.getPosition_id());
	int parentID=0;
	int bossId=position_userManager.getBossParentID();
	parentID=position_user.getParent();
	List<User> leaders=userManager.getParentListByChildUid(uid);
	String[] departmentArray=DataUtil.getdepartment();
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>新建绩效考核</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
		<link rel="stylesheet" type="text/css" href="css/create_performanceflow.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script src="js/showdate.js"></script>
		<script src="js/jquery.min.js"></script>
		<script src="js/jquery-ui.min.js"></script>
		<script src="js/dialog.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		<script src="js/create_performanceflow.js"></script>
		<script type="text/javascript">
		var performance_cid=<%=uid%>;
		var parent_id=<%=parentID%>;
		var boss_id=<%=bossId%>;
		var type=1;
		var username="<%=mUser.getTruename()%>";//本人
		var position_name="<%=mUser.getPosition_name()%>";//职位
		var leader_name="<%=leaders.size()>0?leaders.get(0).getTruename():""%>";//领导
		var leader_id="<%=leaders.size()>0?leaders.get(0).getId():0%>";//领导id
		var departmentArray=[<%int len=departmentArray.length;for(int i=0;i<len;i++){
			if(i>0){
				out.write(",'"+departmentArray[i]+"'");
			}
			else if(i==3){
				continue;
			}
			else{
				out.write("'"+departmentArray[i]+"'");
			}			
		}%>];//部门列表
		//operation=1.保存计划；2：提交计划；3：计划表已批阅；4.保存考核；5：提交考核；6：考核完成，结束；7：计划驳回；8：考核驳回；
		var tab_id="#tab_table";//当前操作表的#id
		var tab_index=0;//0=考核表 1=计划表
		var pfm_id;//考核表id
		var pfm_id2;//计划表id		
		var pfm_month;//考核表时间戳
		var pfm_month2;//计划表时间戳
		var pfm_operation;//考核表状态
		var pfm_operation2;
		var pfm_operation_old=0;//考核表状态（用于保存时，是否有交叉操作判断）
		var pfm_operation_old2=0;
		var items_json=[];//当月考核详细
		var performance_json={};//当月考核表信息	
		var flow_json={};//流程对象（存operation等）
		var flows=[];//流程列表
		var len_flowshow=0;//显示的流程长度
		var items_json2=[];//下月
		var performance_json2={};
		var flow_json2={};//流程对象（存operation等）
		var flows2=[];//流程列表
		var len_flowshow2=0;//显示的流程长度
		var arr_score=["","A+","A","A-","B+","B","B-","C+","C","C-","D+","D","D-"];
		var sum_wt_plan=0;//计划权重
		var sum_wt_carry=0;//实施权重
		var sum_wt_plan2=0;//计划权重
		var sum_wt_carry2=0;//实施权重
		var table_type = 0;//0=新建状态 1=修改状态 2=驳回后修改状态 3=提交状态未审核状态 4=提交已审核状态 
		
		/**初始化员工信息**/
		$(function(){
			//初始化操作
			var department_html='';
			$(departmentArray).each(function(i){
				department_html+='<option value="'+i+'">'+this+'</option>';
			});
			$("#sel_department").html(department_html);
			$("#sel_department").attr("title",departmentArray[0]);
			$("#div_username").text(username);
			$("#ipt_position").text(position_name);
			$("#ipt_leader").text(leader_name);
			var score_html='';			
			$(arr_score).each(function(i){
				score_html += '<option value="'+i+'">'+this+'</option>';
			});
			$("#sel_a_self").html(score_html);
			$("#sel_a_leader").html(score_html);
			$("#tr_addRow").unbind("click").click(function(){
				showDialog();
			});
			$("#tr_addRow2").unbind("click").click(function(){
				showDialog();
			});
			
			$("#div_table2").hide();
			$("#div_flows_contol").click(function(){
				controlFlows(1);
			});
			$("#div_flows_contol2").click(function(){
				controlFlows(2);
			});
			$("#btn_submit").hide();
		});
		/**所属部门改变**/
		function onDepartmentChange(){
			var department_index = $("#sel_department").val();
			$("#sel_department").attr("title",departmentArray[department_index]);
		}
		/**显示或隐藏流程**/
		function controlFlows(index){
			var t_id = "";
			var t_id2 = "";
			if(index == 1){
				t_id = "#div_flows";
				t_id2 = "#div_flows_contol";
			}
			else if(index == 2){
				t_id = "#div_flows2";
				t_id2 = "#div_flows_contol2";
			}
			var display = $(t_id).css("display");
			if(display == "none"){
				$(t_id).show();
				$(t_id2+" span").text("隐藏审核流程");
				$(t_id2+" img").attr("src","images/show_check.png");
			}
			else{
				$(t_id).hide();
				$(t_id2+" span").text("显示审核流程");
				$(t_id2+" img").attr("src","images/hide_check.png");
			}
		}
		/**切换表格**/
		function onTabTypeChange(){
			var d;
			var year;
			var month;
			tab_index = (tab_index==0) ? 1 : 0;
			if(tab_index == 1){
				type=2;
				tab_id = "#tab_table2";
				$("#div_table2").show();
				$("#div_table").hide();
				d = new Date(pfm_month2);
				year=d.getFullYear();
				month=d.getMonth()+1;
				$(".div_title").text(month+"月计划表");
				$("#span_rdate").text(year+"年"+month+"月");
				$("#btn_table").text("上一页");
				$("#btn_submit").show();
			}
			else{
				type=1;
				tab_id = "#tab_table";
				$("#div_table2").hide();
				$("#div_table").show();
				d = new Date(pfm_month);
				year=d.getFullYear();
				month=d.getMonth()+1;
				$(".div_title").text(month+"月考核表");
				$("#span_rdate").text(year+"年"+month+"月");
				$("#btn_table").text("下一页");
				$("#btn_submit").hide();
			}
			initTR();
		}
		/**初始化表格**/
		function initTable(flag_month,data){
			var len = 0;
			var i=0;
			var str_flows="";
			var t_flow={};
			/**判断operation**/
			var operation=data.operation;
			if(flag_month==1){//计划
				len_flowshow2=0;
				if(operation!=0){//空
					flows2 = data.flows;
					len = flows2.length;
					str_flows = "";
					for(i=0; i<len; i++){
						t_flow = flows2[i];
						if(!(t_flow.operation==6 || t_flow.operation==7 || t_flow.operation == 3)){
							continue;
						}
						str_flows += '<div class="div_flow">';
						str_flows += '<div class="flow_left">'+ flows2[i].reason +'</div>';
						if(t_flow.operation == 7){//驳回
							str_flows += '<div class="flow_right_disagree">';
						}
						else if(t_flow.operation == 6 || t_flow.operation ==3){
							str_flows += '<div class="flow_right_agree">';
						}
						str_flows += '<div class="flow_right1">'+t_flow.username+'</div>';
						str_flows += '<div class="flow_right2">'+timeTransLongToStr(t_flow.create_time,4,".",true)+'</div>';
						str_flows += '</div></div>';
						len_flowshow2++;
					}
					$("#div_flows2").append(str_flows);	
					if(len_flowshow2>0){
						$("#div_flows_contol2").show();
						$("#div_flows2").show();
					}	
					setTableInfo("#tab_table2",data);
					items_json2=data.items;
					performance_json2=data;
					performance_json2.items=null;
				}
			}
			else{//考核
				len_flowshow=0;
				if(operation!=0){
					if(operation == 6){
						table_type = 4;//审核结束
						window.location.href='FlowManagerServlet?type=flowdetail&flowtype=32&id='+data.id;
						$("#btn_save").hide();
						$("#btn_submit").hide();
					}
					table_type=1;//非新建时，默认为修改状态
					flows = data.flows;
					len = flows.length;				
					str_flows = "";
					for(i=0; i<len; i++){
						t_flow = flows[i];
						if(!(t_flow.operation==6 || t_flow.operation==8 || t_flow.operation==7 || t_flow.operation==3)){
							continue;
						}
						if(t_flow.reason==undefined || t_flow.reason.length == 0){
							continue;
						}
						str_flows += '<div class="div_flow">';
						str_flows += '<div class="flow_left">'+ flows[i].reason +'</div>';
						if(t_flow.operation == 7){//驳回
							str_flows += '<div class="flow_right_disagree">';
						}
						else if(t_flow.operation==6 || t_flow.operation ==3 || t_flow.operation ==8){
							str_flows += '<div class="flow_right_agree">';
						}
						str_flows += '<div class="flow_right1">'+t_flow.username+'</div>';
						str_flows += '<div class="flow_right2">'+timeTransLongToStr(t_flow.create_time,4,".",true)+'</div>';
						str_flows += '</div></div>';
						len_flowshow++;
						if(t_flow.operation==6 || t_flow.operation==8){//已经审核过或被驳回
							table_type = 2;
						}
					}
					$("#div_flows").append(str_flows);
					if(len_flowshow>0){
						$("#div_flows_contol").show();
						$("#div_flows").show();
					}
					setTableInfo("#tab_table",data);
					items_json=data.items;
					performance_json=data;
					performance_json.items=null;
				}				
			}
		}		
		/**设置表格信息**/
		function setTableInfo(tab_id,data){
			if(tab_id=="#tab_table"){
				$("#sel_department").val(data.department_index);
				pfm_id = data.id;
				pfm_month = data.performance_month;
				pfm_operation = data.operation;
				pfm_operation_old = pfm_operation;
				sum_wt_plan = 0;
				sum_wt_carry = 0;
			}
			else{
				pfm_id2 = data.id;
				pfm_month2 = data.performance_month;
				pfm_operation2 = data.operation;
				pfm_operation_old2 = pfm_operation2;
				sum_wt_plan2 = 0;
				sum_wt_carry2 = 0;
			}
			var items = data.items;
			var str_table = "";
			var t_sum_wt_plan = 0;
			var t_sum_wt_carry = 0;
			for(var i=0; i<items.length; i++){
				var work = items[i];
				var target = work.target;
				var schedule = work.plain;
				var wt_plan = work.weight;
				var assessor = work.assessor;
				var wt_carry = work.weight_self;
				var c_wt_carry = wt_carry;
				if(tab_id=="#tab_table2" && wt_carry==0){
					c_wt_carry = "";
				}
				var situation = work.situation;
				var a_self = work.score_self;
				var wt_leader = work.weight_leader;
				var a_leader = work.score_leader;
				t_sum_wt_plan += Number(wt_plan);
				t_sum_wt_carry += Number(wt_carry);
				str_table += '<tr><td class="tooltip_div tln_left">'+toDomStr(target)+'</td>'
						+'<td class="tooltip_div tln_left">'+toDomStr(schedule)+'</td>'
						+'<td class="tooltip_div">'+wt_plan+'</td>'
						+'<td class="tooltip_div">'+assessor+'</td>'
						+'<td class="tooltip_div">'+c_wt_carry+'</td>'
						+'<td class="tooltip_div tln_left">'+toDomStr(situation)+'</td>'
						+'<td class="tooltip_div" a_self_index="'+a_self+'">'+arr_score[a_self]+'</td>'
						+'<td class="tooltip_div" style="display:none">'+wt_leader+'</td>'
						+'<td class="tooltip_div" style="display:none" a_leader_index="'+a_leader+'">'+arr_score[a_leader]+'</td></tr>';
			}
			$(tab_id+" tr:eq(-2)").before(str_table);
			showToolTip($(tab_id).find("tr:gt(0)"));
			
			$(tab_id+" .tab_tr4").children("td:eq(2)").text(t_sum_wt_plan);
			$(tab_id+" .tab_tr4").children("td:eq(4)").text(t_sum_wt_carry);
			setWeightColor(tab_id+" .tab_tr4","td:eq(2)",t_sum_wt_plan);
			setWeightColor(tab_id+" .tab_tr4","td:eq(4)",t_sum_wt_carry);
			if(tab_id=="#tab_table"){				
				sum_wt_plan = t_sum_wt_plan;
				sum_wt_carry = t_sum_wt_carry;				
			}
			else{
				sum_wt_plan2 = t_sum_wt_plan;
				sum_wt_carry2 = t_sum_wt_carry;
			}
			initTR();
		}
		
		/**设置权重颜色**/
		function setWeightColor(id,childId,value){
			if(value == 100){
				$(id).children(childId).css("background-color","#799dd9");
			}
			else{
				$(id).children(childId).css("background-color","#ff0000");
			}
		}
		
		/**初始化表格行样式**/
		function initTR(){
			var index=0;
			var len = $(tab_id+" tr:gt(0)").length;
			$(tab_id+" tr:gt(0)").each(function(){				
				if(index == len-1){
					;
				}
				else if(index%2==0){
					$(this).attr("class","tab_tr2");
				}else{
					$(this).attr("class","tab_tr3");
				}
				index++;
			});
			$(".tab_tr2").unbind("click").click(function(){
				showDialog($(this));
			});
			$(".tab_tr3").unbind("click").click(function(){
				showDialog($(this));
			});
			$("#tr_addRow").unbind("click").click(function(){
				showDialog();
			});
			$("#tr_addRow2").unbind("click").click(function(){
				showDialog();
			});
			if(table_type == 2){
				$("#tab_table .tab_tr2").unbind("click");
				$("#tab_table .tab_tr3").unbind("click");
				$("#tr_addRow").unbind("click");
			}
		}
		/**显示工作对话框**/
		var nowTR;//当前行
		function showDialog(jq_tr){
			var top_val=(($(window).height()-550)/2+$(window).scrollTop())+"px";
			$(".dlg_work ").css("top",top_val);
			$("#ipt_assessor").val(leader_name);
			if(tab_id=="#tab_table"){
				$(".dlg_work .work_div:eq(4)").show();
				$(".dlg_work .work_div:eq(5)").show();
				$(".dlg_work .work_div:eq(6)").show();
			}
			else{
				$(".dlg_work .work_div:eq(4)").hide();
				$(".dlg_work .work_div:eq(5)").hide();
				$(".dlg_work .work_div:eq(6)").hide();
			}
			if(arguments.length>0){//修改
				$("#btn_work_del").show();
				nowTR=jq_tr;
				var target=onlyGetText(jq_tr,0);
				var schedule=onlyGetText(jq_tr,1);
				var wt_plan=jq_tr.children("td:eq(2)").text().trim();
				var assessor=jq_tr.children("td:eq(3)").text().trim();
				var wt_carry=jq_tr.children("td:eq(4)").text().trim();
				var situation=onlyGetText(jq_tr,5);
				var a_self=jq_tr.children("td:eq(6)").attr("a_self_index");
				var wt_leader=jq_tr.children("td:eq(7)").text().trim();
				var a_leader=jq_tr.children("td:eq(8)").attr("a_leader_index");				
				$("#ipt_target").val(target);
				$("#ta_schedule").val(schedule);
				$("#ipt_wt_plan").val(wt_plan);
				$("#ipt_assessor").val(assessor);
				$("#ipt_wt_carry").val(wt_carry);
				$("#ta_situation").val(situation);	
				$("#sel_a_self").val(a_self);
				$("#ipt_wt_leader").val(wt_leader);
				$("#sel_a_leader").val(a_leader);
			}else{//添加				
				$("#btn_work_del").hide();
				nowTR=null;
			}
			$(".dlg_work").css("display","block");
		}
		/**关闭工作对话框**/
		function closeDialog(btn_id){
			var t_sum_wt_plan = 0;
			var t_sum_wt_carry = 0;
			if(tab_id=="#tab_table"){
				t_sum_wt_plan = sum_wt_plan;
				t_sum_wt_carry = sum_wt_carry;
			}
			else{
				t_sum_wt_plan = sum_wt_plan2;
				t_sum_wt_carry = sum_wt_carry2;
			}
			if(btn_id==2){//删除				
				initdiglogtwo2("提示信息","你确定要删除该任务吗？");
		   		$( "#confirm2" ).click(function() {
					$( "#twobtndialog" ).dialog( "close" );					
					t_sum_wt_plan -= Number(nowTR.children("td:eq(2)").text().trim());
					t_sum_wt_carry -= Number(nowTR.children("td:eq(4)").text().trim());
					nowTR.remove();
					initTR();
					if(tab_id=="#tab_table"){
						sum_wt_plan = t_sum_wt_plan;
						sum_wt_carry = t_sum_wt_carry;
					}
					else{
						sum_wt_plan2 = t_sum_wt_plan;
						sum_wt_carry2 = t_sum_wt_carry;
					}
					$(tab_id+" .tab_tr4").children("td:eq(2)").text(t_sum_wt_plan);
					$(tab_id+" .tab_tr4").children("td:eq(4)").text(t_sum_wt_carry);
					setWeightColor(tab_id+" .tab_tr4","td:eq(2)",t_sum_wt_plan);
					setWeightColor(tab_id+" .tab_tr4","td:eq(4)",t_sum_wt_carry);
					initDialogVal();
				});
			}else if(btn_id==1){//保存
				var target = $("#ipt_target").val();
				var c_target = toDomStr(target);
				var schedule = $("#ta_schedule").val();
				var c_schedule = toDomStr(schedule);
				var wt_plan = $("#ipt_wt_plan").val();
				var assessor = $("#ipt_assessor").val();
				var wt_carry = $("#ipt_wt_carry").val();
				var situation = $("#ta_situation").val();
				var c_situation = toDomStr(situation);
				var a_self = $("#sel_a_self").val();
				var wt_leader = $("#ipt_wt_leader").val();
				var a_leader = $("#sel_a_leader").val();
				if(validValues() == false){
					return;
				}
				if(nowTR == null){//添加
					var temp='<tr><td class="tooltip_div tln_left">'+c_target+'</td>'
							+'<td class="tooltip_div  tln_left">'+c_schedule+'</td>'
							+'<td class="tooltip_div">'+wt_plan+'</td>'
							+'<td class="tooltip_div">'+assessor+'</td>'
							+'<td class="tooltip_div">'+wt_carry+'</td>'
							+'<td class="tooltip_div  tln_left">'+c_situation+'</td>'
							+'<td class="tooltip_div" a_self_index="'+a_self+'">'+arr_score[a_self]+'</td>'
							+'<td class="tooltip_div" style="display:none">'+wt_leader+'</td>'
							+'<td class="tooltip_div" style="display:none" a_leader_index="'+a_leader+'">'+arr_score[a_leader]+'</td></tr>';
					$(tab_id+" tr:eq(-2)").before(temp);
					showToolTip($(tab_id).find("tr:eq(-3)"));
					t_sum_wt_plan += Number(wt_plan);
					t_sum_wt_carry += Number(wt_carry);
				}
				else{//修改
					t_sum_wt_plan -= Number(nowTR.children("td:eq(2)").text());
					t_sum_wt_carry -= Number(nowTR.children("td:eq(4)").text());
					nowTR.children("td:eq(0)").html(c_target);
					nowTR.children("td:eq(1)").html(c_schedule);
					nowTR.children("td:eq(2)").text(wt_plan);
					nowTR.children("td:eq(3)").text(assessor);
					nowTR.children("td:eq(4)").text(wt_carry);
					nowTR.children("td:eq(5)").html(c_situation);
					nowTR.children("td:eq(6)").attr("a_self_index",a_self);
					nowTR.children("td:eq(6)").text(arr_score[a_self]);
					nowTR.children("td:eq(7)").text(wt_leader);
					nowTR.children("td:eq(8)").attr("a_leader_index",a_leader);
					nowTR.children("td:eq(8)").text(arr_score[a_leader]);
					t_sum_wt_plan += Number(nowTR.children("td:eq(2)").text());
					t_sum_wt_carry += Number(nowTR.children("td:eq(4)").text());
				}
				initTR();
				if(tab_id=="#tab_table"){
					sum_wt_plan = t_sum_wt_plan;
					sum_wt_carry = t_sum_wt_carry;
				}
				else{
					sum_wt_plan2 = t_sum_wt_plan;
					sum_wt_carry2 = t_sum_wt_carry;
				}
				$(tab_id+" .tab_tr4").children("td:eq(2)").text(t_sum_wt_plan);
				$(tab_id+" .tab_tr4").children("td:eq(4)").text(t_sum_wt_carry);
				setWeightColor(tab_id+" .tab_tr4","td:eq(2)",t_sum_wt_plan);
				setWeightColor(tab_id+" .tab_tr4","td:eq(4)",t_sum_wt_carry);
				initDialogVal();
			}else{//取消
				initDialogVal();
			}			
		}
		/**验证值**/
		function validValues(){
			var target = $("#ipt_target").val();
			var schedule = $("#ta_schedule").val();
			var wt_plan = $("#ipt_wt_plan").val();
			var assessor = $("#ipt_assessor").val();
			var wt_carry = $("#ipt_wt_carry").val();
			var situation = $("#ta_situation").val();
			var a_self = $("#sel_a_self").val();
			if(target.length == 0){
				initdiglog2("提示信息","工作内容不能为空");
				return false;
			}
			if(schedule.length == 0){
				initdiglog2("提示信息","预计达到的工作目标不能为空");
				return false;
			}
			if(wt_plan.length == 0){
				initdiglog2("提示信息","权重%（计划）不能为空");
				return false;
			}
			if(assessor.length == 0){
				initdiglog2("提示信息","考核人不能为空");
				return false;
			}
			if(tab_id=="#tab_table"){
				if(wt_carry.length == 0){
					initdiglog2("提示信息","权重%（实施）不能为空");
					return false;
				}
				if(wt_plan>100 || wt_carry>100){
					initdiglog2("提示信息","权重必须为0~100");
					return false;
				}				
				if(wt_carry>0 && situation.length == 0){
					initdiglog2("提示信息","完成情况分析不能为空");
					return false;
				}
				if(wt_carry>0 && a_self==0){
					initdiglog2("提示信息","自评不能为空");
					return false;
				}
			}
			else{
				if(wt_plan>100){
					initdiglog2("提示信息","权重必须为0~100");
					return false;
				}				
			}
			return true;
		}
		/**初始化工作对话框的值**/
		function initDialogVal(){
			$(".dlg_work").css("display","none");
			$("#ipt_target").val("");
			$("#ta_schedule").val("");
			$("#ipt_wt_plan").val("");
			$("#ipt_assessor").val("");
			$("#ipt_wt_carry").val("");
			$("#ta_situation").val("");			
			$("#sel_a_self").val(0);
			$("#ipt_wt_leader").val("");
			$("#sel_a_leader").val(0);
		}
		
		/**
		*保存考核表
		*typy：1=暂存，2=提交
		**/
		function onSubmit(type){
			if($("#sel_department").val() == 0){
				initdiglog2("提示信息","请选择部门");
				return;
			}
			if(type == 2){
				/**var len = $("#tab_table tr:gt(0)").length;
				if(len <= 2){
					initdiglog2("提示信息","考核表内容不能为空");
					return;
				}
				len = $("#tab_table2 tr:gt(0)").length;
				if(len <= 2){
					initdiglog2("提示信息","计划表内容不能为空");
					return;
				}**/
				if(sum_wt_carry != 100){
					initdiglog2("提示信息","考核表的实施权重之和必须为100%");
					return;
				}
				if(sum_wt_plan2 != 100){
					initdiglog2("提示信息","计划表的计划权重之和必须为100%");
					return;
				}
			}
			performance_json.id=pfm_id;
			performance_json.performance_month = pfm_month;
			performance_json.department_index = $("#sel_department").val();
			performance_json.operation = (type+3);
			performance_json.operation_old = pfm_operation_old;
			if(table_type==0){
				performance_json.item1 = 1;
				performance_json.item2 = 1;
				performance_json.item3 = 1;
				performance_json.item4 = 1;
				performance_json.quotiety = 0;
				performance_json.score = 0;
				performance_json.feedback = "";
			}			
			items_json = makeItemJson("#tab_table");
			flow_json.operation = (type+3);
			flow_json.operation_old = pfm_operation_old;
			
			performance_json2.id=pfm_id2;
			performance_json2.performance_month = pfm_month2;
			performance_json2.department_index = $("#sel_department").val();
			performance_json2.operation = type;
			performance_json2.operation_old = pfm_operation_old2;
			if(table_type==0 || table_type==1){
				performance_json2.item1 = 1;
				performance_json2.item2 = 1;
				performance_json2.item3 = 1;
				performance_json2.item4 = 1;
				performance_json2.quotiety = 0;
				performance_json2.score = 0;
				performance_json2.feedback = "";
			}			
			items_json2 = makeItemJson("#tab_table2");
			flow_json2.operation = type;
			flow_json2.operation_old = pfm_operation_old2;
			savePerformanceFlow(JSON.stringify(items_json),JSON.stringify(performance_json),JSON.stringify(flow_json),JSON.stringify(items_json2),JSON.stringify(performance_json2),JSON.stringify(flow_json2));
		}
		
		/**构造items**/
		function makeItemJson(t_tab_id){
			var items_json=[];
			var work;
			var len = $(t_tab_id+" tr:gt(0)").length;
			$(t_tab_id+" tr:gt(0)").each(function(i){
				if(i>=(len-2)){
					return false;
				}
				work = {};
				
				work.target = onlyGetText($(this),0);//工作内容
				work.plain = onlyGetText($(this),1);//预计达到的工作目标
				work.weight = $(this).children("td:eq(2)").text().trim();//权重（计划）
				work.assessor = $(this).children("td:eq(3)").text().trim();//考核人
				work.weight_self = $(this).children("td:eq(4)").text().trim();//权重（实施）
				work.situation = onlyGetText($(this),5);//完成情况分析
				work.score_self = $(this).children("td:eq(6)").attr("a_self_index");//自评
				work.weight_leader = $(this).children("td:eq(7)").text().trim();//权重（考评）
				work.score_leader = $(this).children("td:eq(8)").attr("a_leader_index");//终评
				items_json.push(work);
			});
			return items_json;
		}
		
		/**有浮窗的单元格获取文本**/
		function onlyGetText(jq_tr,index){
			var jq_td = jq_tr.children("td:eq("+index+")").clone();
			jq_td.find("div").remove();
			var t_str = toNormalStr(jq_td.html().trim());
			return t_str;
		}
		
		/**普通字符串转dom字符串**/
		function toDomStr(str){
			var t_str = str.toString();
//			t_str = t_str.replace(/\r\n/g, '<br/>'); 
			t_str = t_str.replace(/\n/g, '<br/>');
//			t_str = t_str.replace(/\s/g, ' '); //空格处理
			return t_str;
		}
		
		/**dom字符串转普通字符串**/
		function toNormalStr(str){
			var t_str = str.toString();
			var reg=new RegExp("<br/>","g");
			t_str = t_str.replace(reg,"\n");
			reg=new RegExp("<br>","g");
			t_str = t_str.replace(reg,"\n");
			return t_str;
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
						<jsp:param name="index" value="3" />
					</jsp:include>
					<td class="table_center_td2_notfull">
						<div class="div_title">考核表</div>
						<form action="" method="post" name="flowform" enctype="multipart/form-data">
							<input type="text"  name="hide"  style="display:none"/><!-- 防止按回车直接上传 -->
							<div class="div_user">
								<div style="width:20%">
									<span>员工：</span>
									<span id="div_username">name</span>
								</div>
								<div style="width:30%">
									<span>所属部门：</span>
									<select id="sel_department" name="sel_department" onchange="onDepartmentChange()"></select>
								</div>
								<div style="width:25%">
									<span>岗位名称：</span>
									<span id="ipt_position"></span>
								
								</div>
								<div style="width:20%;border-right: none;">
									<span>审核人：</span>
									<span id="ipt_leader"></span>
								</div>
							</div>
							<div class="div_row2">
								<div class="div_tleft"><div class="div_point"></div>绩效评价</div>
								<img class="img_button" title="导出表格" src="images/export_track.png" onclick="onExportTrack(type);">	
								<span id="span_rdate" class="span_rdate"></span>
							</div>
							<!-- 考核表 -->
							<div id="div_table">								
								<table id="tab_table" class="tab_table">
									<tr>
										<th style="width: 15%">工作内容</th>
										<th style="width: 22%">预计达到的工作目标</th>
										<th style="width: 7.5%">权重%<br>（计划）</th>
										<th style="width: 7.5%">考核人</th>
										<th style="width: 7.5%">权重%<br>（实施）</th>
										<th style="width: 25%">完成情况分析</th>
										<th style="width: 7.5%">自评</th>
										<th style="width: 7.5%;display:none">权重%<br>（考评）</th>
										<th style="width: 7.5%;display:none">终评</th>
									</tr>
									<tr id="tr_addRow" class="tab_tr2">
										<td>
											<img src="images/add_work.png" title="添加" style="vertical-align:middle;">
											添加工作内容
										</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td style="display:none;"></td>
										<td style="display:none;"></td>
									</tr>
									<tr class="tab_tr4">
										<td></td>
										<td></td>
										<td>0</td>
										<td></td>
										<td>0</td>
										<td></td>
										<td></td>
										<td style="display:none;"></td>
										<td style="display:none;"></td>
									</tr>
								</table>
								<div id="div_flows_contol" class="flows_control">
									<span>隐藏审核流程</span>
									<img src="images/show_check.png" class="btn_flows_control">
								</div>
								<div id="div_flows" class="div_flows">
								</div>
							</div>
							<!-- 以下为计划表 -->
							<div id="div_table2">
								<table id="tab_table2" class="tab_table">
									<tr>
										<th style="width: 15%">工作内容</th>
										<th style="width: 22%">预计达到的工作目标</th>
										<th style="width: 7.5%">权重%<br>（计划）</th>
										<th style="width: 7.5%">考核人</th>
										<th style="width: 7.5%">权重%<br>（实施）</th>
										<th style="width: 25%">完成情况分析</th>
										<th style="width: 7.5%">自评</th>
										<th style="width: 7.5%;display:none">权重%<br>（考评）</th>
										<th style="width: 7.5%;display:none">终评</th>
									</tr>
									<tr id="tr_addRow2" class="tab_tr2">
										<td>
											<img src="images/add_work.png" title="添加" style="vertical-align:middle;">
											添加工作内容
										</td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td style="display:none;"></td>
										<td style="display:none;"></td>
									</tr>
									<tr class="tab_tr4">
										<td></td>
										<td></td>
										<td>0</td>
										<td></td>
										<td>0</td>
										<td></td>
										<td></td>
										<td style="display:none;"></td>
										<td style="display:none;"></td>
									</tr>
								</table>
								<div id="div_flows_contol2" class="flows_control">
									<span>隐藏审核流程</span>
									<img src="images/show_check.png" class="btn_flows_control">
								</div>
								<div id="div_flows2" class="div_flows">
								</div>
							</div>
							<!-- 控制bar -->	
							<div class="control_bottom">
								<div id="btn_table" class="div_button" style="background-color:#799dd9" onclick="onTabTypeChange()">下一页</div>
								<div id="btn_save" class="div_button" style="background-color:#799dd9" onclick="onSubmit(1)">暂 存</div>
								<div id="btn_submit" class="div_button" style="background-color:#41c651" onclick="onSubmit(2)">提 交</div>							
							</div>
						</form>
					</td>
				</tr>
			</table>
		</div>
		<div class="dlg_work">
			<div class="work_div"><span>工作内容：</span><input id="ipt_target" type="text" maxlength="50"></div>
			<div class="work_div"><span>预计达到的工作目标：</span><textarea id="ta_schedule" maxlength="500"></textarea></div>
			<div class="work_div"><span>权重%（计划）：</span><input id="ipt_wt_plan" type="text" maxlength="4" oninput="checkFloatPositive(this,2)"></div>
			<div class="work_div"><span>考核人：</span><input id="ipt_assessor" type="text" maxlength="50"></div>
			<div class="work_div"><span>权重%（实施）：</span><input id="ipt_wt_carry" type="text" maxlength="4" oninput="checkFloatPositive(this,2)"></div>
			<div class="work_div"><span>完成情况分析：</span><textarea id="ta_situation" maxlength="500"></textarea></div>
			<div class="work_div"><span>自评：</span><select id="sel_a_self" name="sel_a_self"></select></div>
			<div class="work_div" style="display:none"><span>权重%（考评）：</span><input id="ipt_wt_leader" type="text" maxlength="4"></div>
			<div class="work_div" style="display:none"><span>终评：</span><select id="sel_a_leader" name="sel_a_leader"></select></div>
			<div class="work_bottom">
				<img src="images/cancle_materials.png" onclick="closeDialog(0)">
				<img src="images/submit_materials.png" onclick="closeDialog(1)">
				<img id="btn_work_del" src="images/del_materials.png" onclick="closeDialog(2)">
			</div>
		</div>
	</body>
</html>
