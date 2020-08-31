var bgArray=["#FFF1D6","#D6FFE8","#D6FFE8","#FF9292","#D1EEFF"];//审批状态的背景色的
var selectedIndex=-1;
var MonthDNum = new Array(0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
var monthArray;//monthArray[i][0]=0;//显示的日期monthArray[i][1]=false;//是否为可选日期monthArray[i][2]=false;//是否为可选日期中的周末
var oneWeekIndex;//当前月份一号为星期几 0-6 周日-周六
var stopTop=false;//是否阻止监听冒泡
var jsonDate;//数据
var workmonth;
var todayArray=timeTransLongToStr(0,4,"/",false).split("/");
function deleteProject(index){
	initPMDialog();
	var p_id=projectArray[index][0];
	initdiglogtwo2("提示信息","你确定要删除项目<br/>【"+projectArray[index][1]+"】吗？");
	$( "#confirm2" ).click(function() {
		$( "#twobtndialog" ).dialog( "close" );
		$.ajax({
			type:"post",//post方法
			url:"NewFlowServlet",
			data:{"type":"delProject","p_id":p_id},
			timeout : 15000, 
			dataType:'text',
			success:function(returnData){
				if(returnData==1){
					initdiglog2("提示信息","删除成功！");
					projectArray[index][2]=false;
					$(".dialog_pm_item[project_index='"+index+"']").remove();
					initPMDialog();	
				}else{
					initdiglog2("提示信息","抱歉，该项目已被绑定，无法删除！");
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
	});
}
function updateProject(index){
	initPMDialog();
	$(".dialog_pm_btns>div:eq(1)").css({"cursor":"pointer","background":"#4CB6AC"});
	pm_state=1;
	var item=$(".dialog_pm_item[project_index='"+index+"']");
	item.find("div:eq(0)").remove();
	item.find("img:nth-last-of-type(2)").css("visibility","hidden");
	item.prepend('<input type="text" maxlength="200" value="'+projectArray[index][1]+'">');
}
function addProject(){
	if($(".dialog_pm_additem").length==0){
		initPMDialog();
		$(".dialog_pm_btns>div:eq(1)").css({"cursor":"pointer","background":"#4CB6AC"});
		pm_state=0;
		var temp='<div class="dialog_pm_additem"><input type="text" maxlength="200">'
				+'<img src="images/delete_tree.png" title="取消添加" onclick="canclePMDialog();"><div><div class="clearfloat_div"></div></div>';
		$(".dialog_pm_list").after(temp);
	}
}
var pm_state=-1;//项目管理的当前处理进度（-1：等待；0：添加；1：修改；[2：删除 不用记录，无需ui更新]）
function initPMDialog(){
	if(pm_state==0){
		$(".dialog_pm_additem").remove();
	}else if(pm_state==1){
		var item=$(".dialog_pm_item input").parent();
		item.find("input").remove();
		item.find("img:nth-last-of-type(2)").css("visibility","visible");
		var index=item.attr("project_index");
		item.prepend('<div class="dialog_pm_item_div1"  title="'+projectArray[index][1]+'">'+projectArray[index][1]+'</div>');
	}
	pm_state=-1;
	$(".dialog_pm_btns>div:eq(1)").css({"cursor":"default","background":"#dddddd"});
}
function saveProject(){
	if(pm_state==0){
		//添加
		var pname=$(".dialog_pm_additem input").val().trim();
		if(pname.length==0){
			initdiglog2("提示信息", "请输入项目名称！");
			return;
		}
		$.ajax({
			type:"post",//post方法
			url:"NewFlowServlet",
			data:{"type":"addProject","pname":pname},
			timeout : 15000, 
			dataType:'text',
			success:function(returnData){
				if(returnData>0){
					var array=new Array();
					array[0]=returnData;
					array[1]=pname;
					array[2]=true;
					projectArray.push(array);
					initdiglog2("提示信息","添加成功！");
					initPMDialog();
					var index=projectArray.length-1;
					var temp='<div class="dialog_pm_item" project_index="'+index+'"><div class="dialog_pm_item_div1" title="'+projectArray[index][1]+'">'
						+projectArray[index][1]+'</div><img src="images/alter_tree.png" title="修改" onclick="updateProject('+index+');">'
						+'<img src="images/delete_tree.png" title="删除" onclick="deleteProject('+index+');"><div class="clearfloat_div"></div></div>';
					$(".dialog_pm_list").prepend(temp);
				}else{
					initdiglog2("提示信息","该项目名称已存在！");
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
	}else if(pm_state==1){
		//修改
		var input=$(".dialog_pm_item input");
		var pname=input.val().trim();
		var index=input.parent().attr("project_index");
		var p_id=projectArray[index][0];
		if(pname.length==0){
			initdiglog2("提示信息", "请输入项目名称！");
			return;
		}
		$.ajax({
			type:"post",//post方法
			url:"NewFlowServlet",
			data:{"type":"alterProject","pname":pname,"p_id":p_id},
			timeout : 15000, 
			dataType:'text',
			success:function(returnData){
				if(returnData>0){
					projectArray[index][1]=pname;
					initdiglog2("提示信息","修改成功！");
					initPMDialog();
				}else{
					initdiglog2("提示信息","该项目名称已存在！");
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
}
function canclePMDialog(){
	if(pm_state>-1){
		initPMDialog();//返回上一步
	}else{
		closePMDialog();//当没有编辑时，关闭对话框
	}
}
/****
 * 显示项目管理对话框
 */
function showPMDialog(){
	var items='';
	for(var i=projectArray.length-1;i>=0;i--){
		if(!projectArray[i][2]){
			continue;
		}
		items+='<div class="dialog_pm_item" project_index="'+i+'"><div class="dialog_pm_item_div1" title="'+projectArray[i][1]+'">'
				+projectArray[i][1]+'</div><img src="images/alter_tree.png" title="修改" onclick="updateProject('+i+');">'
				+'<img src="images/delete_tree.png" title="删除" onclick="deleteProject('+i+');"><div class="clearfloat_div"></div></div>';
	}
	$(".dialog_pm_list").html(items);
	if($(".dialog_work_bg").length==0){
		$("body").append('<div class="dialog_work_bg"></div>');
		$(".dialog_work_bg").click(function(){
			event.stopPropagation();//防止冒泡
		});
	}
	$(".dialog_pm").css("margin-top",(0-$(".dialog_pm").height()/2)+"px");
	$(".dialog_work_bg").css("display","block");
	$(".dialog_pm").css("display","block");
	$(".dialog_pm_btns>div:eq(1)").css({"cursor":"default","background":"#dddddd"});//禁用按钮二
}
/****
 * 关闭项目管理对话框
 */
function closePMDialog(){
	$(".dialog_work_bg").css("display","none");
	$(".dialog_pm").css("display","none");
	pm_state=-1;
}
function initSelect(date){
	var beginYear=2017;
	var nowMonth=date.getMonth() + 1;
	var nowYear=date.getFullYear();
	var temp='';
	for(var i=beginYear;i<nowYear+2;i++){
		temp+='<option value="'+i+'" '+(i==nowYear?'selected':'')+'>'+i+'</option>';
	}
	$("#work_year").html(temp);
	temp='';
	for(var i=1;i<13;i++){
		temp+='<option value="'+i+'" '+(i==nowMonth?'selected':'')+'>'+i+'</option>';
	}
	$("#work_month").html(temp);
	initTime();
}
function initMonthArray(){
	monthArray=new Array();
	for(var i=0;i<42;i++){
		monthArray[i]=new Array();
		monthArray[i][0]=0;//显示的日期
		monthArray[i][1]=false;//是否为可选日期
		monthArray[i][2]=false;//是否为可选日期中的周末
	}
}
function initTime(){
	initMonthArray();
	var year=$("#work_year").val();
	var month=$("#work_month").val();
	var DayNum = (IsLeapYear(year) && month == 2) ? MonthDNum[month] + 1 : MonthDNum[month];
	var lastDayNum=31;//上个月为去年12月
	if(month!=1){//上月为1-11月
		lastDayNum=(IsLeapYear(year) && month == 3) ? MonthDNum[month-1] + 1 : MonthDNum[month-1];
	}
	var date = new Date(year+"/"+month+"/1");
	oneWeekIndex=date.getDay();//当前月份一号为星期几 0-6 周日-周六
	for(var i=0;i<oneWeekIndex;i++){
		//0 1 2 3 4 5 6
		monthArray[oneWeekIndex-i-1][0]=lastDayNum-i;//填充上个月
	}
	for(var i=1;i<=DayNum;i++){
		monthArray[i+oneWeekIndex-1][0]=i;//本月
		monthArray[i+oneWeekIndex-1][1]=true;//本月才可操作
		if((oneWeekIndex+i)%7==0||(oneWeekIndex+i)%7==1){
			monthArray[i+oneWeekIndex-1][2]=true;//可选日期的周末
		}
	}
	if((DayNum+oneWeekIndex)<36){
		//只显示5行
		$("#date36").parent().css("display","none");
		if((DayNum+oneWeekIndex)<29){
			//只显示4行
			$("#date30").parent().css("display","none");
		}
	}else{
		$("#date36").parent().css("display","block");
	}
	date = new Date(year+"/"+month+"/"+DayNum);
	var endWeekIndex=date.getDay();//当前月份最后一天为星期几 0-6 周日-周六
	for(var i=endWeekIndex;i<6;i++){
		monthArray[DayNum+oneWeekIndex+(5-i)][0]=6-i;//填充下个月
	}
	showDate();
	getWorkByMonth(year,month);
}
function showDate(){
	selectedIndex=-1;
	for(var i=0;i<monthArray.length;i++){
		$("#date"+(i+1)+" div:eq(0)").text(monthArray[i][0]);
		if(monthArray[i][0]!=0){
			if(monthArray[i][1]){
				if(monthArray[i][2]){
					$("#date"+(i+1)+" div:eq(0)").css("color","#FE018F");
				}else{
					$("#date"+(i+1)+" div:eq(0)").css("color","#000");
				}
			}else{
				$("#date"+(i+1)+" div:eq(0)").css("color","#b3b3b3");
			}
			$("#date"+(i+1)).css("background","#fff");
			$("#date"+(i+1)).css("cursor","default");
		}
	}
}
/*是否润年*/
function IsLeapYear(y) {
	if (0 == y % 4 && ((y % 100 != 0) || (y % 400 == 0))) {
		return true;
	} else {
		return false;
	}
}
function getWorkByMonth(year,month){
	workmonth=timeTransStrToLong2(year+"/"+month+"/1");
	$.ajax({
		type:"post",//post方法
		url:"NewFlowServlet",
		data:{"type":"getWorkByMonth","workmonth":workmonth,"create_id":create_id},
		timeout : 15000, 
		dataType:'json',
		success:function(returnData){
			jsonDate=returnData;
			if(jsonDate!=null){
				if(createNow){
					//在新建界面切换到的是已提交的工时表，自动跳转到详情页面
					window.location.href="NewFlowServlet?type=jumpToWorkByMonth&workmonth="+timeTransStrToLong2(year+"/"+month);
				}else{
					//canAlter=uid==create_id&&jsonDate.operation<3;//未提交前都可以改
					canAlter=uid==create_id
					//canApprove=isparent&&jsonDate.operation<3;
					canApprove=isparent;
					insertData();
				}
			}else{
				//新建
				canAlter=uid==create_id;
				canApprove=false;
			}
			//当天特别注明
			var days=(new Date().getTime()-new Date($("#work_year").val()+"/"+$("#work_month").val()+"/1").getTime())/86400000;
			var tidayId="#date"+(Math.ceil(days)+oneWeekIndex);
			if($(tidayId).length>0){
				$(tidayId).css("background",bgArray[4]);
			}
			if(canAlter){
				for(var i=0;i<monthArray.length;i++){
					if(monthArray[i][1]){
						$("#date"+(i+1)).css("cursor","pointer");
					}
				}
			}
			if(canApprove){
				$(".div_group2").css("display","block");
			}else{
				$(".div_group2").css("display","none");
			}
		},
		complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
			if(status!='success'){//超时,status还有success,error等值的情况
				if(status=='timeout'){
					initdiglog2("提示信息","请求超时！");
				}else{
					initdiglog2("提示信息","获取信息失败，请刷新重试！");
				}
			}
		}
	});
}
/****
 * 领导点开后设为已读
 * @param workday_id
 */
function updateWorkStatus(workday_id,status){
	$.ajax({
		type:"post",//post方法
		url:"NewFlowServlet",
		data:{"type":"updateWorkStatus","workday_id":workday_id,"status":status}
	});
}
function recoverBgColor(){
	if(selectedIndex>-1&&$(".dialog_work_bg").css("display")=="none"){
		var day=parseInt($("#date"+selectedIndex+" >div").text());
		if(day==todayArray[2]&&$("#work_year").val()==todayArray[0]&&$("#work_month").val()==todayArray[1]){
			$("#date"+selectedIndex).css("background",bgArray[4]);
		}else if(jsonDate==null){
			$("#date"+selectedIndex).css("background","#fff");
		}else{
			var hasThisDay=false;//标记当天是否已提交（用于颜色区分）
			$.each(jsonDate.list,function() {
				if(this.workday==day){
					//2为老版本的不同意状态，统一作为已读处理
					if(this.status==0&&canApprove){
						this.status=1;
						updateWorkStatus(this.id,1);
					}else if(this.status==3&&canAlter){
						//改为已读
						this.status=1;
						updateWorkStatus(this.id,1);
					}
					$("#date"+selectedIndex).css("background",bgArray[this.status]);
					hasThisDay=true;
					return false;
				}
			});
			if(!hasThisDay){
				$("#date"+selectedIndex).css("background","#fff");
			}
		}
	}
}
function insertData(){
	$.each(jsonDate.list,function() {
		var id="date"+(this.workday+oneWeekIndex);
		$("#"+id).css("background",bgArray[this.status]);
		if($("#"+id).css("cursor")!="pointer"){
			$("#"+id).css("cursor","pointer");//有内容的都可查看
		}
	});
}
function getProjectByID(p_id){
	for(var i=0;i<projectArray.length;i++){
		if(projectArray[i][0]==p_id){
			return projectArray[i][1];
		}
	}
	return "项目"+p_id;
}
/*****
 * 添加工时详情对话框的项目行
 * @param p_id
 * @param hours
 */
function addworkdayProject(p_id,hours){
	p_id=p_id?p_id:0;
	hours=hours?hours:"";
	var item='<div class="dialog_workday_item" project_id="'+p_id+'"><div class="item_title1">项目：</div>'
		+'<select>'+options+'</select><div class="item_title2">工时：</div>'
		+'<input type="number" min="0" max="24" step="0.5" value="'+hours+'" maxLength="4">'
		+'<div class="item_title3">时</div>'
		+'<div class="workday_item_del" onclick="delworkdayProject(this)" title="删除本行"></div>'
		+'<div class="clearfloat_div"></div></div>';
	$(".dialog_workday_list").append(item);
	if(p_id>0){
		if($(".dialog_workday_item:last option[value='"+p_id+"']").length==0){//项目已被删除，修改时不显示
			$(".dialog_workday_item:last").remove();
			return;
		}else{
			$(".dialog_workday_list select:last").val(p_id);
		}
	}
	resetAddBtnAtLast();
}
/****
 * 删除本行
 * @param obj
 */
function delworkdayProject(obj){
	if($(obj).parent().siblings().length>0){
		//还有其他行
		$(obj).parent().remove();
		resetAddBtnAtLast();
	}else{
		initdiglog2("提示信息","至少需要保留一行，若您需要删除当天的工时统计，请将工时数全部设为0");
	}
}
/*****
 * 将删除按钮移到最后一栏
 */
function resetAddBtnAtLast(){
	$(".workday_item_add").remove();
	var delBtn=$(".dialog_workday_item:last").find("div.workday_item_del");
	delBtn.after('<div class="workday_item_add" onclick="addworkdayProject()" title="添加下一行"></div>');
}
var options;
/***
 * 工时日详情
 */
var workday;
function showWorkSetDialog(day){
	workday=day;
	$(".dialog_workday_list").html("");//清空之前的记录
	if(canAlter){
		options='';
		for(var i=projectArray.length-1;i>=0;i--){
			if(projectArray[i][2]){
				options+='<option value="'+projectArray[i][0]+'">'+projectArray[i][1]+"</option>";
			}
		}
	}
	$(".dialog_workday_date").text("日期："+$("#work_year").val()+"/"+$("#work_month").val()+"/"+day);
	var job_content='';
	var remark='';
	if(jsonDate!=null){
		$.each(jsonDate.list,function() {
			if(this.workday==day){
				job_content=this.job_content;
				remark=this.remark;
				if(canAlter){
					$.each(this.list,function(){
						addworkdayProject(this.project_id,parseFloat(this.hours));
					});
				}else{
					$.each(this.list,function(){
						var pname=getProjectByID(this.project_id);
						var item='<div class="dialog_workday_item"><div class="item_title1">项目：</div>'
							+'<div class="item_pname" title="'+pname+'">'+pname+'</div><div class="item_title2">工时：</div>'
							+'<div class="item_hours">'+parseFloat(this.hours)+'</div><div class="item_title3">时</div>'
							+'<div class="clearfloat_div"></div></div>';
						$(".dialog_workday_list").append(item);
					});
				}
				return false;
			}
		});
	}
	job_content=job_content!=null&&job_content.length>0?job_content:"";
	$(".dialog_workday_content").css("display","block");
	if(canAlter){
		$(".dialog_workday_content div:eq(1)").remove();
		$(".dialog_workday_content textarea").val(job_content);
	}else{
		$(".dialog_workday_content textarea").remove();
		$(".dialog_workday_content div:eq(1)").html(transRNToBR(job_content));
	}
	remark=remark!=null&&remark.length>0?remark:"";
	$(".dialog_workday_remark").css("display","block");
	if(canApprove){
		$(".dialog_workday_remark div:eq(1)").remove();
		$(".dialog_workday_remark textarea").val(remark);
	}else{
		if(createNow){
			//提交页面不显示空备注
			$(".dialog_workday_remark").css("display","none");
		}else{
			$(".dialog_workday_remark textarea").remove();
			$(".dialog_workday_remark div:eq(1)").html(transRNToBR(remark));
		}
	}
	if(canAlter||canApprove){
		$(".dialog_workday_btns").css("display","block");
	}else{
		$(".dialog_workday_btns").css("display","none");
	}
	if(canAlter&&$(".dialog_workday_list div").length==0){
		addworkdayProject(this.project_id,"");
	}
	if($(".dialog_work_bg").length==0){
		$("body").append('<div class="dialog_work_bg"></div>');
		$(".dialog_work_bg").click(function(){
			event.stopPropagation();//防止冒泡
		});
	}
	$(".dialog_workday").css("margin-top",(0-$(".dialog_workday").height()/2)+"px");
	$(".dialog_work_bg").css("display","block");
	$(".dialog_workday").css("display","block");
}
function closeWorkSetDialog(){
	$(".dialog_work_bg").css("display","none");
	$(".dialog_workday").css("display","none");
}
function saveWorkDayProject(){
	var wdproject="";
	var job_content="";
	var remark="";
	var status=0;
	if(canAlter){
		var allHours=0;
		var selectedPIDS="の";//格式 の1の1の1の
		for(var i=0,item=$(".dialog_workday_item"),len=item.length;i<len;i++){
			var p_id=$(item[i]).find("select").val();
			if(!p_id>0){
				initdiglog2("提示信息","第"+(i+1)+"行未选择项目！");
				return;
			}
			if(selectedPIDS.indexOf(p_id)!=-1){
				initdiglog2("提示信息","第"+(i+1)+"行项目选择重复！");
				return;
			}
			selectedPIDS+=p_id+"の";
			var hours=$(item[i]).find("input").val();
			if(hours.length==0||(hours=parseFloat(hours))<0){
				initdiglog2("提示信息","第"+(i+1)+"行未输入工时！");
				return;
			}
			allHours+=hours;
			if(hours%0.5!=0||hours<0||hours>24){
				initdiglog2("提示信息","第"+(i+1)+"行工时输入有误，请输入0.5的整数倍，工时范围0~24");
				return;
			}
			wdproject+="い"+p_id+"の"+hours;
		}
		if(allHours>24){
			initdiglog2("提示信息","工时总和已超过24小时！");
			return;
		}
		wdproject=wdproject.replace("い","");
		job_content=$(".dialog_workday_content textarea").val().trim();
		status=0;//改回未读状态
	}
	if(canApprove){
		remark=$(".dialog_workday_remark textarea").val().trim();
		status=2;//改为有未读评论状态
	}
	var operation=jsonDate?jsonDate.operation:0;
	$.ajax({
		type:"post",//post方法
		url:"NewFlowServlet",
		data:{"type":"addWorkDayProjectByMonth","operation":operation,"create_id":create_id,"workmonth":workmonth,"workday":workday,"status":status,"wdproject":wdproject,"job_content":job_content,"remark":remark},
		timeout : 15000, 
		dataType:'json',
		success:function(returnData){
			closeWorkSetDialog();
			initdiglog2("提示信息","保存成功！");
			jsonDate=returnData;
			if(jsonDate!=null){
				//canAlter=uid==create_id&&jsonDate.operation<3;
				canAlter=uid==create_id;
				//canApprove=isparent&&jsonDate.operation<3;
				canApprove=isparent;
			}else{
				canAlter=uid==create_id;
				canApprove=false;
			}
		},
		complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
			if(status!='success'){//超时,status还有success,error等值的情况
				if(status=='timeout'){
					initdiglog2("提示信息","请求超时！");
				}else{
					initdiglog2("提示信息","工时统计表状态已过期，请刷新重试！");
				}
			}
		}
	});
}
function saveAllWorkDayProject(){
	if(!jsonDate||!jsonDate.list||jsonDate.list.length==0){
		initdiglog2("提示信息","请输入工时统计安排");
		return;
	}
	var canFinish=false;
	for(var i=0;i<monthArray.length;i++){
		if(monthArray[i][1]&&!monthArray[i][2]){
			//工作日
			var day=monthArray[i][0];
			canFinish=false;
			$.each(jsonDate.list,function(){
				if(this.workday==day){
					canFinish=true;
					return false;
				}
			});
			if(!canFinish){
				initdiglogtwo2("提示信息","检测到您本月有部分日期未添加工时，是否忽略？");
				$( "#confirm2" ).click(function() {
					$( "#twobtndialog" ).dialog( "close" );
					window.location.href="NewFlowServlet?type=saveAllWorkDayProject&id="+jsonDate.id;
				});
				return false;
			}
		}
	}
	if(canFinish){
		window.location.href="NewFlowServlet?type=saveAllWorkDayProject&id="+jsonDate.id;
	}
}