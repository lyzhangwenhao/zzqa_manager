$(function(){
	var parentID=parent_id;
	var bossID=boss_id;
	var d = new Date();
	var year=d.getFullYear();
	var month=d.getMonth()+1;
	var day=d.getDate();
	var month2 = month+1;
	var year2 =year;
	var month3;
	var year3=year;
	if(parentID == bossID){
		if(day<9){//部门总监月份加减三
			if(1<month && month<=4){
				month=1;
				month3=4;
			}else if(4<month && month<=7){
				month=4;
				month3=7;
			}else if(7<month && month<=10){
				month=7;
				month3=10;
			}else if(10<month || month==1){
				if(month==1){
					year--;
				}else{
					year3++;
				}
				month=10;
				month3=1;
			}
		}else{
			if(1<=month && month<4){
//				year-=1;
				month=1;
				month3=4;
			}else if(4<=month && month<7){
				month=4;
				month3=7;
			}else if(7<=month && month<10){
				month=7;
				month3=10;
			}else if(10<=month && month<=12){
				month=10;
				month3=1;
				year3+=1;
			}
		}
	}else{
		if(day<9){//每个月1~8号视作上个月
			month-=1;
			month2-=1;
		}
		if(month == 0){
			year-=1;
			month=12;
		}else if(month == 12){
			year2+=1;
			month2=1;
		}
	}
	$(".div_title").text(month+"月考核表");
	$("#span_rdate").text(year+"年"+month+"月");
	pfm_month=timeTransStrToLong2(year+"/"+month+"/1");//月初时间戳
	if(parentID == bossID){
		pfm_month2=timeTransStrToLong2(year3+"/"+ month3 +"/1");//下月月初
	}else{
		pfm_month2=timeTransStrToLong2(year2+"/"+ month2 +"/1");//下月月初
	}
	getPerformanceByMonth(pfm_month,0,1);
	getPerformanceByMonth(pfm_month2,1,1);
});

/**
 * 获取考核或计划表
 * @param performance_month 时间戳
 * @param flag_month 0=考核 1=计划
 * @param flag_reset 0=不刷新页面 1=刷新页面内容
 * 备注：第一次（新建考核或计划）暂存时，不刷新页面，但需要获取id等信息
 */
function getPerformanceByMonth(performance_month,flag_month,flag_reset){
	$.ajax({
		type:"post",//post方法
		url:"OAServlet",
		data:{"type":"getPerformanceByMonth","performance_month":performance_month,"performance_cid":performance_cid},
		dataType:'json',
		success:function(returnData){
			if(returnData){
				if(flag_reset==0){
					tempStorage(flag_month,returnData);
				}
				else{
					initTable(flag_month,returnData);
				}				
			}else{
				$("#div_flows_contol").hide();
				$("#div_flows_contol2").hide();
//				initdiglog2("提示信息","获取失败");
			}
		},
		error:function(returnData){
			initdiglog2("提示信息","获取异常");
		}
	});
}

/**
 * 暂存处理
 * 不刷新页面，但需要更新id、flows等信息
 * @param flag_month
 * @param data
 */
function tempStorage(flag_month,data){
	/**判断operation**/
	var operation=data.operation;
	if(flag_month==1){//计划
		if(operation!=0){//空
			pfm_id2 = data.id;
			pfm_month2 = data.performance_month;
			pfm_operation2 = data.operation;
			pfm_operation_old2 = pfm_operation2;
			flows2 = data.flows;
			items_json2=data.items;
			performance_json2=data;
			performance_json2.items=null;
		}
	}
	else{//考核
		if(operation!=0){
			pfm_id = data.id;
			pfm_month = data.performance_month;
			pfm_operation = data.operation;
			pfm_operation_old = pfm_operation;
			flows = data.flows;
			items_json=data.items;
			performance_json=data;
			performance_json.items=null;
		}				
	}
}

/***
 * 提交
 */
function savePerformanceFlow(t_items_json,t_performance_json,t_flow_json,t_items_json2,t_performance_json2,t_flow_json2){
	//整合成json字符串
	/**var items_json="[]";//当月
	var performance_json="{}";
	var items_json2="[]";//下月
	var performance_json2="{}";**/
	$.ajax({
		type:"post",//post方法
		url:"OAServlet",
		data:{"type":"savePerformanceFlow","items_json":t_items_json,"performance_json":t_performance_json,"flow_json":t_flow_json,
			"items_json2":t_items_json2,"performance_json2":t_performance_json2,"flow_json2":t_flow_json2},
		dataType:'json',
		success:function(returnData){
			//提交后处理
			var str_result="";
			if(returnData==0){
				str_result = "失败";
			}
			else{
				str_result = "成功";
			}
			if(performance_json2.operation==1){
				initdiglog2("提示信息","暂存"+str_result);
			}
			else{
				initdiglog2("提示信息","提交"+str_result);
			}
			$( "#confirm1" ).click(function() {
				$( "#onebtndialog" ).dialog( "close" );
				if(returnData == 0){//保存失败直接刷新页面
					window.location.reload();
				}
				else{
					if(performance_json2.operation==1){//暂存处理,不刷新页面
						getPerformanceByMonth(pfm_month,0,0);
						getPerformanceByMonth(pfm_month2,1,0);
					}
					else{//提交处理，刷新页面
						window.location.reload();
					}					
				}
			});			
		},
		error:function(returnData){
			initdiglog2("提示信息","获取异常");
		}
	});
}

/**导出表格**/
function onExportTrack(type){
	var d = new Date();
	var type=type;
	var year=d.getFullYear();
	var month=d.getMonth()+1;
	var temp='';
	var index_th=0;
	var index_td;
	var rowCount=0;//行号
	var t_department_index=0;//所属部门
	if(type==1){
		len_tr = $("#tab_table tr:visible").length;
		if(len_tr==1){
			initdiglog2("提示信息", "没有数据！");
			return;
		}
		$("#tab_table tr").each(function(){
			var rowTemp='';
			var display = $(this).css("display");
			if(display=="none"){
				return true;//相当于continue
			}
			rowCount++;
			$(this).find("th").each(function(){
				display = $(this).css("display");
				if(display=="none"){
					return false;//相当于break
				}
				rowTemp+='の'+$(this).text().trim();			
				index_th++;
	    	});
			if(rowCount==2 || (rowCount>1 && rowCount<len_tr)){
				t_department_index=$(this).attr("department_index");
			}
			index_td=0;
			$(this).find("td").each(function(){
				if(index_td >= index_th){
					return false;//相当于break
				}
				rowTemp+='の'+$(this).text().trim();
				index_td++;
	    	});
			temp+="い"+rowTemp.replace('の','');
		});
	}else{
		len_tr = $("#tab_table2 tr:visible").length;
		if(len_tr==1){
			initdiglog2("提示信息", "没有数据！");
			return;
		}
		$("#tab_table2 tr").each(function(){
			var rowTemp='';
			var display = $(this).css("display");
			if(display=="none"){
				return true;//相当于continue
			}
			rowCount++;
			$(this).find("th").each(function(){
				display = $(this).css("display");
				if(display=="none"){
					return false;//相当于break
				}
				rowTemp+='の'+$(this).text().trim();			
				index_th++;
	    	});
			if(rowCount==2 || (rowCount>1 && rowCount<len_tr)){
				t_department_index=$(this).attr("department_index");
			}
			index_td=0;
			$(this).find("td").each(function(){
				if(index_td >= index_th){
					return false;//相当于break
				}
				rowTemp+='の'+$(this).text().trim();
				index_td++;
	    	});
			temp+="い"+rowTemp.replace('の','');
		});
	}
	temp=temp.replace("い","");
	//导出excel
	var filename=null;
	if(type==1){
		filename=username+"的考核表";
	}else{
		filename=username+"的计划表";
	}
	$.ajax({
		type:"post",//post方法
		url:"HandelTempFileServlet",
		data:{"type":"exporttrack_out","data":temp},
		//ajax成功的回调函数
		success:function(returnData){
			if(returnData.length>1){
				window.location.href="FileDownServlet?type=loadtrackexcel&filePath="+returnData+"&filename="+filename;
			}else{
				//失败
				initdiglog2("提示信息", "导出失败！");
			}
		},
		error : function(){
			initdiglog2("提示信息","导出失败！");
		}
	});
}