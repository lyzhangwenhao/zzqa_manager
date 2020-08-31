/****
 * 显示搜索对话框
 */
function showSearchDialog(){
	var items='';
	if(selectedType==0){
		if($(".dialog_search_useritem").length==0){
			$("#dialog_search_user input").val("");
			for(var num=userArray.length,i=num-1;i>=0;i--){
				items+='<div class="dialog_search_useritem" user_index="'+i+'" title="'+userArray[i][1]+'">'+userArray[i][1]+'</div>';
			}
			$("#dialog_search_user .dialog_search_row").html(items);
			$(".dialog_search_useritem").unbind("click").click(function(){
				$(".dialog_search_useritem").css("background",'');
				$(this).css("background","#87D3FF");
				$(".title_top_value ").text($(this).text());
				$(".title_top_value ").attr("title",$(this).text());
				selectedUser_index=parseInt($(this).attr("user_index"));
				closeSearchDialog();
				getWorkReport();
			});
		}
		$("#dialog_search_user").css("margin-top",(0-$("#dialog_search_user").height()/2)+"px");
		$("#dialog_search_user").css("display","block");
	}else{
		if($(".dialog_search_projectitem").length==0){
			$("#dialog_search_project input").val("");
			for(var num=projectArray.length,i=num-1;i>=0;i--){
				items+='<div class="dialog_search_projectitem" project_index="'+i+'" title="'+projectArray[i][1]+'">'+projectArray[i][1]+'</div>';
			}
			$("#dialog_search_project .dialog_search_row").html(items);
			$(".dialog_search_projectitem").unbind("click").click(function(){
				$(".dialog_search_projectitem").css("background",'');
				$(this).css("background","#87D3FF");
				$(".title_top_value ").text($(this).text());
				$(".title_top_value ").attr("title",$(this).text());
				selectedProject_index=$(this).attr("project_index");
				closeSearchDialog();
				getWorkReport();
			});
		}
		$("#dialog_search_project").css("margin-top",(0-$("#dialog_search_project").height()/2)+"px");
		$("#dialog_search_project").css("display","block");
	}
	if($(".dialog_work_bg").length==0){
		$("body").append('<div class="dialog_work_bg"></div>');
	}
	$(".dialog_work_bg").css("display","block");
}
/****
 * 关闭搜索对话框
 */
function closeSearchDialog(){
	if(selectedType==0){
		$("#dialog_search_user").css("display","none");
	}else{
		$("#dialog_search_project").css("display","none");
	}
	$(".dialog_work_bg").css("display","none");
}
/***
 * 选择项目
 * @param obj
 */
function selectTypeChange(){
	selectedType=$("input[name='selectedType']:checked").val();
	if(selectedType==0){
		$(".title_top_name").text("人员：");
		if(selectedUser_index>-1){
			$(".title_top_value").text(userArray[selectedUser_index][1]);
			$(".title_top_value ").attr("title",userArray[selectedUser_index][1]);
		}else{
			$(".title_top_value").text("");
			$(".title_top_value ").removeAttr("title");
		}
	}else{
		$(".title_top_name").text("项目：");
		if(selectedProject_index>-1){
			$(".title_top_value").text(projectArray[selectedProject_index][1]);
			$(".title_top_value ").attr("title",projectArray[selectedProject_index][1]);
		}else{
			$(".title_top_value").text("");
			$(".title_top_value ").removeAttr("title");
		}
	}
	getWorkReport();
}
function filterByKW(){
	if(selectedType==0){
		var kw=$("#dialog_search_user input").val();
		$("#dialog_search_user .dialog_search_useritem").each(function(){
			$(this).css("display",$(this).text().indexOf(kw)!=-1?"":"none");
		});
	}else{
		var kw=$("#dialog_search_project input").val();
		$("#dialog_search_project .dialog_search_projectitem").each(function(){
			$(this).css("display",$(this).text().indexOf(kw)!=-1?"":"none");
		});
	}
}
/****
 * 显示过滤对话框
 */
function showFilterDialog(){
	var items='';
	if(selectedType==0){
		if(!(selectedUser_index>-1)){
			initdiglogtwo2("提示信息","您还没未选择人员，是否立即跳转？");
			$( "#confirm2" ).click(function() {
				$( "#twobtndialog" ).dialog( "close" );
				showSearchDialog();
			});
			return;
		}
		for(var num=projectArray.length,i=num-1;i>=0;i--){
			items+='<div class="dialog_filter_projectitem" project_index="'+i+'">'
					+'<input type="checkbox" class="chk_1" id="checkbox_project'+i+(projectArray[i][2]?'" checked':'"')+'>'
					+'<label for="checkbox_project'+i+'" ></label><div title="'+projectArray[i][1]+'">'+projectArray[i][1]+'</div></div>';
		}
		$("#dialog_filter_project .dialog_search_row").html(items);
		$(".dialog_filter_projectitem").unbind("click").click(function(){
			var index=$(this).attr("project_index");
			$("#checkbox_project"+index).prop("checked",!$("#checkbox_project"+index).prop("checked"));
		});
		$("#dialog_filter_project").css("margin-top",(0-$("#dialog_filter_project").height()/2)+"px");
		$("#dialog_filter_project").css("display","block");
	}else{
		if(!(selectedProject_index>-1)){
			initdiglogtwo2("提示信息","您还没未选择项目，是否立即跳转？");
			$( "#confirm2" ).click(function() {
				$( "#twobtndialog" ).dialog( "close" );
				showSearchDialog();
			});
			return;
		}
		for(var num=userArray.length,i=num-1;i>=0;i--){
			items+='<div class="dialog_filter_useritem" user_index="'+i+'">'
					+'<input type="checkbox" class="chk_1" id="checkbox_user'+i+(userArray[i][2]?'" checked':'"')+'>'
					+'<label for="checkbox_user'+i+'" ></label><div title="'+userArray[i][1]+'">'+userArray[i][1]+'</div></div>';
		}
		$("#dialog_filter_user .dialog_search_row").html(items);
		$(".dialog_filter_useritem").unbind("click").click(function(){
			var index=$(this).attr("user_index");
			$("#checkbox_user"+index).prop("checked",!$("#checkbox_user"+index).prop("checked"));
		});
		$("#dialog_filter_user").css("margin-top",(0-$("#dialog_filter_user").height()/2)+"px");
		$("#dialog_filter_user").css("display","block");
	}
	if($(".dialog_work_bg").length==0){
		$("body").append('<div class="dialog_work_bg"></div>');
	}
	$(".dialog_work_bg").css("display","block");
}
/****
 * 关闭过滤对话框
 */
function closeFilterDialog(){
	if(selectedType==0){
		$("#dialog_filter_project").css("display","none");
	}else{
		$("#dialog_filter_user").css("display","none");
	}
	$(".dialog_work_bg").css("display","none");
}
/****
 * 全选
 */
function checkboxChange(){
	if(selectedType==0){
		var flag=$("#filterProjectAll").prop("checked");
		$(".dialog_filter_projectitem input").each(function(){
			$(this).prop("checked",flag);
		});
	}else{
		var flag=$("#filterUserAll").prop("checked");
		$(".dialog_filter_useritem input").each(function(){
			$(this).prop("checked",flag);
		});
	}
}
function filterSelectAll(){
	if(selectedType==0){
		var flag=$("#filterProjectAll").prop("checked")
		flag=!flag;
		$("#filterProjectAll").prop("checked",flag);
		$(".dialog_filter_projectitem input").each(function(){
			$(this).prop("checked",flag);
		});
	}else{
		var flag=$("#filterUserAll").prop("checked")
		flag=!flag;
		$("#filterUserAll").prop("checked",flag);
		$(".dialog_filter_useritem input").each(function(){
			$(this).prop("checked",flag);
		});
	}
}
function filterWatch(){
	if(selectedType==0){
		if($(".dialog_filter_projectitem input:checked").length>0){
			selectedPids="";
			for(var i=0;i<projectArray.length;i++){
				var flag=$("#checkbox_project"+i).prop("checked");
				projectArray[i][2]=flag;
				if(flag){
					selectedPids+="の"+projectArray[i][0];
				}
			}
			selectedPids=selectedPids.replace("の","");
			closeFilterDialog();
			getWorkReport();
		}else{
			initdiglog2("提示信息","请选择项目！");
		}
	}else{
		if($(".dialog_filter_useritem input:checked").length>0){
			selectedUids="";
			for(var i=0;i<userArray.length;i++){
				var flag=$("#checkbox_user"+i).prop("checked");
				userArray[i][2]=flag;
				if(flag){
					selectedUids+="の"+userArray[i][0];
				}
			}
			selectedUids=selectedUids.replace("の","");
			closeFilterDialog();
			getWorkReport();
		}else{
			initdiglog2("提示信息","请选择人员！");
		}
	}
}
function initTime(){
	var nowDate=new Date(endtime);
	var date1=nowDate.getFullYear()+"/"+(nowDate.getMonth()+1)+"/1";
	var date2=nowDate.getFullYear()+"/"+(nowDate.getMonth()+1)+"/"+nowDate.getDate();
	starttime=new Date(date1).getTime();
	endtime=new Date(date2).getTime();
	$("#time1").val(date1);
	$("#time2").val(date2);
	$("#time3").val(date1);
	$("#time4").val(date2);
	$("#time1").prop("readonly","readonly");
	$("#time2").prop("readonly","readonly");
}
function getWorkByMonths(startmonth,endmonth){
	if(pageType==1){
		if($(".dialog_work_bg").length==0){
			$("body").append('<div class="dialog_work_bg"></div>');
		}
		$(".dialog_work_bg").css("display","block");
		if(!uids){
			$(userArray).each(function(){
				uids+="の"+this[0];
			});
			if(uids){
				uids.replace("の","");
			}else{
				initdiglog2("提示信息","找不到用户");
				return;
			}
		}
		var date1=$("#time1").val();
		var date2=$("#time2").val();
		var startM=new Date(date1.substring(0,date1.lastIndexOf("/"))+"/1").getTime();
		var endM=new Date(date2.substring(0,date2.lastIndexOf("/"))+"/1").getTime();
		var startDay=date1.substring(date1.lastIndexOf("/")+1);
		var endDay=date2.substring(date2.lastIndexOf("/")+1);
		$.ajax({
			type:"post",//post方法
			url:"DeviceServlet",
			data:{"type":"getWorkdaysReport","startM":startM,"startDay":startDay,"endM":endM,"endDay":endDay},
			dataType:'json',
			success:function(returnData){
				$(".dialog_work_bg").css("display","none");
				reportJson=returnData;
				initTable();
			},
			error : function(XMLHttpRequest,status){ //请求完成后最终执行参数
				initdiglog2("提示信息","操作异常,请重试！");
				$(".dialog_work_bg").css("display","none");
			}
		});
	}else{
		if($(".dialog_work_bg").length==0){
			$("body").append('<div class="dialog_work_bg"></div>');
		}
		$(".dialog_work_bg").css("display","block");
		$.ajax({
			type:"post",//post方法
			url:"DeviceServlet",
			data:{"type":"getWorkByMonths","startmonth":startmonth,"endmonth":endmonth},
			dataType:'json',
			success:function(returnData){
				$(".dialog_work_bg").css("display","none");
				jsonDate=returnData;
				initTable();
			},
			error : function(){ //请求完成后最终执行参数
				initdiglog2("提示信息","操作异常,请重试！");
				$(".dialog_work_bg").css("display","none");
			}
		});	
	}
}
/****
 * 检查月份是否增加
 */
function checkTimeChange(){
	var time1=timeTransStrToLong2($("#time1").val());//选中的开始时间
	if(time1<starttime){
		var date_start=new Date(starttime);
		var date1=new Date(time1);
		if(date_start.getFullYear()!=date1.getFullYear()||date_start.getMonth()!=date1.getMonth()){
			return false;//不在同一月
		}
	}
	var time2=timeTransStrToLong2($("#time2").val());//选中的结束时间
	if(time2>endtime){
		var date_end=new Date(endtime);
		var date2=new Date(time2);
		if(date_end.getFullYear()!=date2.getFullYear()||date_end.getMonth()!=date2.getMonth()){
			return false;//不在同一月
		}
	}
	return true;
}
/****
 * 生成报表
 */
function getWorkReport(){
	if(!checkTimeChange()||starttime==0){
		var date1=$("#time1").val();
		var startmonth=new Date(date1.substring(0,date1.lastIndexOf("/"))+"/1").getTime();//开始月份为开始月份的1号
		var endmonth=new Date($("#time2").val()).getTime();
		getWorkByMonths(startmonth,endmonth);
		return;
	}
	initTable();
}
/****
 * 人报
 */
function insertDateByUser(){
	if(selectedUser_index==-1){
		return;
	}
	var u_id=userArray[selectedUser_index][0];
	var allDayNum=dateArray.length;
	dataArray=new Array();
	contentArray=new Array(allDayNum);
	remarkArray=new Array(allDayNum);
	var date1=new Date(starttime);
	var date2=new Date(endtime);
	var startmonth=new Date(date1.getFullYear()+"/"+(date1.getMonth()+1)+"/1").getTime();
	var endmonth=new Date(date2.getFullYear()+"/"+(date2.getMonth()+1)+"/1").getTime();
	for(var i=projectArray.length-1;i>=0;i--){
		if(projectArray[i][2]){
			var p_id=projectArray[i][0];
			var dataLength=dataArray.length;//加到数组最后
			dataArray[dataLength]=new Array(allDayNum+1);
			dataArray[dataLength][0]=i;//p_index
			if(jsonDate){
				$.each(jsonDate,function(){
					if(this.create_id==u_id&&(this.workmonth>=startmonth&&this.workmonth<=endmonth)){//本月在筛选时间内
						var offset=(this.workmonth-starttime)/86400000;
						$.each(this.list,function(){//工时日详情
							var index=offset+this.workday;
							if(index>0&&index<=allDayNum){//第一个日期对应下标1
								var job_content=this.job_content;
								var remark=this.remark;
								$.each(this.list,function(){//工时项目
									if(this.project_id==p_id){
										dataArray[dataLength][index]=this.hours;
										if(job_content&&!contentArray[index-1]){
											contentArray[index-1]=job_content;
										}
										if(remark&&!remarkArray[index-1]){
											remarkArray[index-1]=remark;
										}
										return false;//当日同一项目只有一条记录
									}
								});
							}
						});
					}
				});
			}
		}
	}
	var item='';
	for(var i=0,len=dataArray.length;i<len;i++){
		item+='<tr p_index="'+dataArray[i][0]+'"><td>'+projectArray[dataArray[i][0]][1]+'</td>';
		for(var j=1;j<=allDayNum;j++){
			if(dataArray[i][j]){
				item+='<td style="cursor:pointer">'+dataArray[i][j]+'</td>';
			}else{
				item+='<td></td>';
			}
		}
		item+='</tr>';
	}
	$("#workreport_tab").append(item);
	$("#workreport_tab tr:gt(1):even").css("background","#f0f0f0");
}
/****
 * 项目报
 */
function insertDateByProject(){
	if(selectedProject_index==-1){
		return;
	}
	var p_id=projectArray[selectedProject_index][0];
	var allDayNum=dateArray.length;
	dataArray=new Array();
	contentArray=new Array();
	remarkArray=new Array();
	var date1=new Date(starttime);
	var date2=new Date(endtime);
	var startmonth=new Date(date1.getFullYear()+"/"+(date1.getMonth()+1)+"/1").getTime();
	var endmonth=new Date(date2.getFullYear()+"/"+(date2.getMonth()+1)+"/1").getTime();
	for(var i=userArray.length-1;i>=0;i--){
		if(userArray[i][2]){
			var u_id=userArray[i][0];
			var dataLength=dataArray.length;//加到数组最后
			dataArray[dataLength]=new Array(allDayNum+1);
			dataArray[dataLength][0]=i;//p_index
			var contenLength=contentArray.length;
			var remarkLength=remarkArray.length;
			contentArray[contenLength]=new Array(allDayNum);
			remarkArray[remarkLength]=new Array(allDayNum);
			if(jsonDate){
				$.each(jsonDate,function(){
					if(this.create_id==u_id&&this.workmonth>=startmonth&&this.workmonth<=endmonth){//本月在筛选时间内
						var offset=(this.workmonth-starttime)/86400000;
						$.each(this.list,function(){//工时日详情
							var index=offset+this.workday;
							if(index>0&&index<=allDayNum){//第一个日期对应下标1
								var job_content=this.job_content;
								var remark=this.remark;
								$.each(this.list,function(){//工时项目
									if(this.project_id==p_id){
										dataArray[dataLength][index]=this.hours;
										if(job_content&&!contentArray[contenLength][index-1]){
											contentArray[contenLength][index-1]=job_content;
										}
										if(remark&&!remarkArray[remarkLength][index-1]){
											remarkArray[remarkLength][index-1]=remark;
										}
										return false;//当日同一项目只有一条记录
									}
								});
							}
						});
					}
				});
			}
		}
	}
	var item='';
	for(var i=0,len=dataArray.length;i<len;i++){
		item+='<tr u_index="'+dataArray[i][0]+'"><td>'+userArray[dataArray[i][0]][1]+'</td>';
		for(var j=1;j<=allDayNum;j++){
			if(dataArray[i][j]){
				item+='<td style="cursor:pointer">'+dataArray[i][j]+'</td>';
			}else{
				item+='<td></td>';
			}
		}
		item+='</tr>';
	}
	$("#workreport_tab").append(item);
	$("#workreport_tab tr:gt(1):even").css("background","#f0f0f0");
}
/****
 * 显示详情
 * @param uid
 * @returns
 */
function showWorkDayDialog(pname,hours,job_content,remark,nowDate){
	var item='<div class="dialog_workday_item"><div class="item_title1">项目：</div>'
		+'<div class="item_pname" title="'+pname+'">'+pname+'</div><div class="item_title2">工时：</div>'
		+'<div class="item_hours">'+parseFloat(hours)+'</div><div class="item_title3">时</div>'
		+'<div class="clearfloat_div"></div></div>';
	$(".dialog_workday_list").html(item);
	$(".dialog_workday_date div:eq(1)").text(nowDate);
	$(".dialog_workday_content div:eq(1)").html((job_content&&job_content.length>0)?transRNToBR(job_content):"");
	$(".dialog_workday_remark div:eq(1)").html(remark&&remark.length>0?transRNToBR(remark):"");
	if($(".dialog_work_bg").length==0){
		$("body").append('<div class="dialog_work_bg"></div>');
	}
	$(".dialog_workday").css("margin-top",(0-$(".dialog_workday").height()/2)+"px");
	$(".dialog_work_bg").css("display","block");
	$(".dialog_workday").css("display","block");
}
function closeWorkSetDialog(){
	$(".dialog_work_bg").css("display","none");
	$(".dialog_workday").css("display","none");
}
function setTime(time,obj){
	if(obj==document.getElementById("time3")){
		var time1=new Date(time).getTime();
		var time2=new Date($("#time4").val()).getTime();
		//修改time1的时间
    	if(time1<=time2){
    		obj.value=time;//time3
    		$("#time1").val(time);
    	}else{
    		initdiglog2("提示信息","开始时间必须早于结束时间！");
    	}
	}else{
		//修改time2的时间
		var time1=new Date($("#time3").val()).getTime();
		var time2=new Date(time).getTime();
    	if(time1<=time2){
    		obj.value=time;
    		$("#time2").val(time);
    	}else{
    		initdiglog2("提示信息","结束时间必须晚于开始时间！");
    	}
	}
}
//时间范围内的所有日期 [[时间戳1，日期1，判断新的一月(需要显示浮窗),周几
function initDateArray(t1,allDayNum){
	dateArray=new Array(allDayNum);
	var startMonth=$("#time1").val().substring(0,7);//格式2017/04或2017/4/
	var endMonth=$("#time2").val().substring(0,7);//2017/04
	var onceMonth=startMonth==endMonth;//是否为单月
	var off=new Date(t1).getDay();//0 for Sunday, 1 for Monday, 2 for Tuesday, and so on. 
	for(var i=0;i<allDayNum;i++){
		var date=new Date(t1);
		dateArray[i]=new Array(4);
		dateArray[i][0]=t1;//时间戳
		dateArray[i][1]=date.getDate();//日期
		dateArray[i][3]=weekArray[date.getDay()];//周几
		if(dateArray[i][1]==1||(i==0&&(dateArray[i][1]<20||onceMonth))){//开始为20号前（或不早于20号但不跨月），第一列显示浮窗
			dateArray[i][2]=true;//标记为新的一月,第一个显示月份
		}else{
			dateArray[i][2]=false;
		}
		t1+=86400000;//加一天
	}
}
//初始化表格
function initTable(){
	if(pageType==1){
		$("#workstatistics_tab tr:gt(0)").remove();
		if(reportJson){
			var temp='';
			var uid;
			$(projectArray).each(function(i){
				projectArray[i][3]=0;//初始化
			});
			$(userArray).each(function(i){
				userArray[i][3]=0;//初始化
				uid=this[0];
				temp+='<tr><td>'+this[1]+'</td>';
				$(projectArray).each(function(j){
					var hours=reportJson[uid+'_'+this[0]];
					temp+='<td>';
					if(hours){
						userArray[i][3]+=hours;
						projectArray[j][3]+=hours;
						temp+=hours;
					}
					temp+='</td>';
				});
				temp+='<td>'+userArray[i][3]+'</td></tr>';
			});
			temp+='<tr><td>合计</td>';
			var all_hours=0;
			$(projectArray).each(function(i){
				var hours=projectArray[i][3];
				all_hours+=hours;
				temp+='<td>'+hours+'</td>';
			});
			temp+='<td>'+all_hours+'</td></tr>';
			$("#workstatistics_tab").append(temp);
		}
		resize(1);
	}else{
		starttime=timeTransStrToLong2($("#time1").val());
		endtime=timeTransStrToLong2($("#time2").val());
		var allDayNum=Math.round((endtime-starttime)/86400000)+1;//总天数
		initDateArray(starttime,allDayNum);
		var temp='<tr><td>日期</td>';
		var temp0='<tr><td>'+(selectedType==1?'人员':'项目')+'</td>';
		for(var i=0;i<allDayNum;i++){//表头
			if(dateArray[i][2]){
				var d = new Date(dateArray[i][0]);    //根据时间戳生成的时间对象
				var month=d.getMonth() + 1;
				var year=d.getFullYear()
				var toolTip='<div class="container"><div>'+year+'年'+month+'月'+'</div><s><i></i></s></div>';
				temp+='<td>'+toolTip+dateArray[i][3]+'</td>';//新的一月
			}else{
				temp+='<td>'+dateArray[i][3]+'</td>';
			}
			temp0+='<td>'+dateArray[i][1]+'</td>';
		}
		temp+='</tr>'+temp0+'</tr>';
		$("#workreport_tab").html(temp);
		if(selectedType==0){
			insertDateByUser();
		}else if(selectedType==1){
			insertDateByProject();
		}
		resize(1);
		$("#workreport_tab tr:gt(1)").find("td:gt(0)").unbind("click").bind("click",function(){
			if($(this).css("cursor")=="pointer"){
				var column_index=this.cellIndex-1;
				var nowTime=timeTransStrToLong2($("#time1").val())+86400000*column_index;
				var nowDate=timeTransLongToStr(nowTime,4,"/",false);
				if(selectedType==0){
					var pname=$(this).parent().find("td:eq(0)").text();
					var hours=$(this).text();
					var job_content=contentArray[column_index];
					var remark=remarkArray[column_index];
					showWorkDayDialog(pname,hours,job_content,remark,nowDate);
				}else{
					var row_index=this.parentNode.rowIndex-2;
					var pname=projectArray[selectedProject_index][1];
					var hours=$(this).text();
					var job_content=contentArray[row_index][column_index];
					var remark=remarkArray[row_index][column_index];
					showWorkDayDialog(pname,hours,job_content,remark,nowDate);
				}
			}
		});
	}
}
function resize(arg) {
	if(pageType==1){
		var table=$("#workstatistics_tab");
		table.find("tr td:eq(0)").css({"max-width":"150px","min-width":"80px"});
		var table_width=table.css("width").replace("px","");
		var client_width=table.parent().css("width").replace("px","");
		if(parseInt(table_width)<=parseInt(client_width)){
			table.css("width","100%");
		}else{
			table.css("width","auto");
		}
		if(arg==1){
			var title_width=$("#workstatistics_tab td:eq(0)").outerWidth()+1;//80px
			var temp='<div></div><div></div>';
			temp+='<div>项目</div>';
			temp+='<div>人员</div>';
			$("#workstatistics_tab tr:gt(0)").each(function(i){
				var title_name=$(this).find("td:eq(0)").text();
				temp+='<div title="'+title_name+'">'+title_name+'</div>';
			});
			$("#workstatistics_tab_lefttitle").html(temp);
			$("#workstatistics_tab_lefttitle").find("div:gt(3):odd").css("background","#F0F0F0");
			$("#workstatistics_tab_lefttitle").find("div:gt(3):even").css("background","#fff");
			$("#workstatistics_tab_lefttitle").find("div:eq(0)").css("border-left",title_width+"px solid transparent");
			$("#workstatistics_tab_lefttitle").find("div:eq(1)").css("border-right",title_width+"px solid transparent");
			$("#workstatistics_tab_lefttitle").find("div:eq(2)").css("width",(title_width-11)+"px");
			$("#workstatistics_tab_lefttitle").find("div:eq(3)").css("width",(title_width-11)+"px");
			$("#workstatistics_tab_lefttitle").css("width",title_width+"px");
			$("#workstatistics_tab_lefttitle2").css("width",title_width+"px");
		}
	}else{
		var table=$("#workreport_tab");
		table.find("tr td:eq(0)").css({"max-width":"150px","min-width":"100px"});
		var table_width=table.css("width").replace("px","");
		var client_width=table.parent().css("width").replace("px","");
		if(parseInt(table_width)<=parseInt(client_width)){
			table.css("width","100%");
		}else{
			table.css("width","auto");
		}
		if(arg==1){
			var title_width=$("#workreport_tab td:eq(0)").outerWidth()+1;//80px
			var temp='<div></div><div></div>';
			temp+='<div>'+$("#workreport_tab tr:eq(0) td:eq(0)").text()+'</div>';
			temp+='<div>'+$("#workreport_tab tr:eq(1) td:eq(0)").text()+'</div>';
			$("#workreport_tab tr:gt(1)").each(function(i){
				var title_name=$(this).find("td:eq(0)").text();
				temp+='<div title="'+title_name+'">'+title_name+'</div>';
			});
			$("#workreport_tab_lefttitle").html(temp);
			$("#workreport_tab_lefttitle").find("div:gt(3):odd").css("background","#fff");
			$("#workreport_tab_lefttitle").find("div:gt(3):even").css("background","#F0F0F0");
			$("#workreport_tab_lefttitle").find("div:eq(0)").css("border-left",title_width+"px solid transparent");
			$("#workreport_tab_lefttitle").find("div:eq(1)").css("border-right",title_width+"px solid transparent");
			$("#workreport_tab_lefttitle").find("div:eq(2)").css("width",(title_width-11)+"px");
			$("#workreport_tab_lefttitle").find("div:eq(3)").css("width",(title_width-11)+"px");
			$("#workreport_tab_lefttitle").css("width",title_width+"px");
			$("#workreport_tab_lefttitle2").css("width",title_width+"px");
		}
	}
}