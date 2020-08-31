$(function(){
	var parentID=parent_id;
	var bossID=boss_id;
	var flag=false;
	var d_date = new Date(performance_month);//跳转时间
	var d_year=d_date.getFullYear();
	var d_month=d_date.getMonth()+1;
	var d_year2=d_year;
	var d_month2=d_month+1;
	var c_date = new Date();//当前时间
	var c_year=c_date.getFullYear();
	var c_month=c_date.getMonth()+1;
	var c_day=c_date.getDate();
	//直属上级领导为总经理时
	var d_month3;
	var d_year3;//考核表时间
	var d_month4;//计划表时间
	var d_year4;
	var pfm_month;
	var pfm_month2;
	if(d_year>2018){
		if(d_year==2019 && d_month<4){
			flag=false;
		}else{
			flag=true;
		}
	}
	//判断是否是历史时间
	if(d_year<c_year){
		if(c_year-d_year>1 || c_month>1 ||(c_month==1 && c_day>9) ){
			time_type = 1;
		}else{
			time_type = 2;
		}
	}else{
		time_type = 2;
	}
	//////////////////////////////
	if(parentID == bossID && (d_month==4 || d_month == 7 || d_month==10 || d_month==1)){
		if(d_year<c_year){//判断是否是历史时间
			if(c_year-d_year>1 || c_month>1 ||(c_month==1 && c_day>9) ){//如果当前时间比过去时间多一年则一定是历史时间或者当前月份>1.....
				if(d_month==10){//d_month==10时 计划表为下一年1月 年份+1
					d_month3=10;
					d_month4=1;
					d_year3=d_year;
					d_year4=d_year+1;
				}else{
					d_month3=d_month;
					d_month4=d_month+3;
					d_year3=d_year;
					d_year4=d_year;
				}
			}else{//此时当前年份比历史年份多1
				if(d_month==10){//d_month==10时 计划表为下一年1月 年份+1
					d_month3=10;
					d_month4=1;
					d_year3=d_year;
					d_year4=d_year+1;
				}else{
					d_month3=d_month;
					d_month4=d_month+3;
					d_year3=d_year;
					d_year4=d_year;
				}
			}
		}else if(d_year>c_year){//d_year时间为计划表时间
			d_month3=10;
			d_month4=1;
			d_year3=c_year;
			d_year4=d_year;
		}else{
			if(c_day<9){
				if(c_month<=d_month){
					if(d_month==1){
						d_month3=10;
						d_month4=1;
						d_year3=d_year-1;
						d_year4=d_year;
					}else if(d_month==4){
						d_month3=1;
						d_month4=4;
						d_year3=d_year;
						d_year4=d_year;
					}else if(d_month==7){
						d_month3=4;
						d_month4=7;
						d_year3=d_year;
						d_year4=d_year;
					}else if(d_month==10){
						d_month3=7;
						d_month4=10;
						d_year3=d_year;
						d_year4=d_year;
					}
				}else{
					if(d_month==1){
						d_month3=1;
						d_month4=4;
						d_year3=d_year;
						d_year4=d_year;
					}else if(d_month==4){
						d_month3=4;
						d_month4=7;
						d_year3=d_year;
						d_year4=d_year;
					}else if(d_month==7){
						d_month3=7;
						d_month4=10;
						d_year3=d_year;
						d_year4=d_year;
					}else if(d_month==10){
						d_month3=10;
						d_month4=1;
						d_year3=d_year;
						d_year4=d_year+1;
					}
				}
			}else{
				if(c_month<=d_month){
					if(1<=c_month && c_month<4){
						d_month3=1;
						d_month4=4;
						d_year3=d_year;
						d_year4=d_year;
					}else if(4<=c_month && c_month<7){
						d_month3=4;
						d_month4=7;
						d_year3=d_year;
						d_year4=d_year;
					}else if(7<=c_month && c_month<10){
						d_month3=7;
						d_month4=10;
						d_year3=d_year;
						d_year4=d_year;
					}else if(c_month>=10){
						d_month3=10;
						d_month4=1;
						d_year3=d_year;
						d_year4=d_year+1;
					}
				}else{
					if(d_month==1){
						d_month3=1;
						d_month4=4;
						d_year3=d_year;
						d_year4=d_year;
					}else if(d_month==4){
						d_month3=4;
						d_month4=7;
						d_year3=d_year;
						d_year4=d_year;
					}else if(d_month==7){
						d_month3=7;
						d_month4=10;
						d_year3=d_year;
						d_year4=d_year;
					}else if(d_month==10){
						d_month3=10;
						d_month4=1;
						d_year3=d_year;
						d_year4=d_year+1;
					}
				}
			}
		}
	
	}else if(parentID == bossID){
		if(1<d_month && d_month<4){
			d_month2=4;
			d_year2=d_year;
		}else if(4<d_month && d_month<7){
			d_month2=7;
			d_year2=d_year;
		}else if(7<d_month && d_month<10){
			d_month2=10;
			d_year2=d_year;
		}else if(10<d_month && d_month<=12){
			d_month2=1;
			d_year2=d_year+1;
		}
	}else{
		if(c_day<9 && c_month==1 && d_month==1 && d_year==c_year){
			time_type=2;
			d_month=12;
			d_month2=1;
			d_year-=1;
			d_year2=c_year;
		}else if(c_day>9 && c_month==12 && d_month==1 && d_year==c_year+1){
			time_type=2;
			d_month=12;
			d_month2=1;
			d_year=c_year;
			d_year2=c_year+1;
		}else{
			if(c_day<9){//每个月1~8号视作上个月
				c_month-=1;
				if(c_month==0){
					c_year-=1;
					c_month=12;
				}
			}
			if(d_year==c_year && d_month>=c_month){//当前月
				time_type = 2;             
				d_month = c_month;//跳转当前月或下一月，转化为当前月
			}else{//历史时间不会超过当前时间
				time_type = 1;
			}
			if(d_month == 0){
				d_year-=1;
				d_month=12;
			}else if(d_month == 12){
				d_year2+=1;
				d_month2=1;
			}else{
				d_month2=d_month+1;
			}
		}
	}
	/////////////////////////////
	if(parentID == bossID && (d_month==4 || d_month == 7 || d_month==10 || d_month==1)){
		$(".div_title").text(d_month3+"月考核表");
		$("#span_date").text(d_year3+"年"+d_month3+"月");
		pfm_month=timeTransStrToLong2(d_year3+"/"+d_month3+"/1");//考核时间戳
		pfm_month2=timeTransStrToLong2(d_year4+"/"+ d_month4 +"/1");//计划表时间戳
	}else{
		$(".div_title").text(d_month+"月考核表");
		$("#span_date").text(d_year+"年"+d_month+"月");
		pfm_month=timeTransStrToLong2(d_year+"/"+d_month+"/1");//月初时间戳
		pfm_month2=timeTransStrToLong2(d_year2+"/"+ d_month2 +"/1");//下月月初
	}
//	getPerformanceByMonth(pfm_month2,1,parentID,bossID);
	getPerformanceByMonth(pfm_month,pfm_month2,parentID,bossID);
});

function getPerformanceByMonth(t_month,f_month,parentID,bossID){
	if(parentID == bossID){
		$.ajax({
			type:"post",//post方法
			url:"OAServlet",
			data:{"type":"getPerformanceByMonth","performance_month":f_month,"performance_cid":performance_cid},
			dataType:'json',
			success:function(returnData){
				if(returnData){
					initTable(1,returnData);
					$.ajax({
						type:"post",//post方法
						url:"OAServlet",
						data:{"type":"getPerformanceByMonth","performance_month":t_month,"performance_cid":performance_cid},
						dataType:'json',
						success:function(lastReturnData){
							if(lastReturnData){
								initTable(0,lastReturnData);
							}
						}
					})
					
				}else{
					//无数据，新建
//					initdiglog2("提示信息","无数据，本月8号之后重新填写");
					$.ajax({
						type:"post",//post方法
						url:"OAServlet",
						data:{"type":"getLastMoncePerformance","lastmonth":t_month,"performance_month":f_month,"performance_cid":performance_cid},
						dataType:'json',
						success:function(lastReturnData){
							if(lastReturnData.length){
								initTable(1,lastReturnData[0]);
								initTable(0,lastReturnData[1]);
							}
						}
					})
				}
			},
			error:function(returnData){
				initdiglog2("提示信息","获取异常");
			}
		});
	}else{
		$.ajax({
			type:"post",//post方法
			url:"OAServlet",
			data:{"type":"getPerformanceByMonth","performance_month":t_month,"performance_cid":performance_cid},
			dataType:'json',
			success:function(returnData){
				if(returnData){
					initTable(0,returnData);
					$.ajax({
						type:"post",//post方法
						url:"OAServlet",
						data:{"type":"getPerformanceByMonth","performance_month":f_month,"performance_cid":performance_cid},
						dataType:'json',
						success:function(lastReturnData){
							if(lastReturnData){
								initTable(1,lastReturnData);
							}
						}
					})
				}else{
					//无数据，新建
//					initdiglog2("提示信息","无数据，本月8号之后重新填写");
				}
			},
			error:function(returnData){
				initdiglog2("提示信息","获取异常");
			}
		});
	}
}


/*function getPerformanceByMonth1(t_month,flag_month,parentID,bossID){
	$.ajax({
		type:"post",//post方法
		url:"OAServlet",
		data:{"type":"getPerformanceByMonth","performance_month":t_month,"performance_cid":performance_cid},
		dataType:'json',
		success:function(returnData){
			if(returnData){
				initTable(flag_month,returnData);
			}else{
				//无数据，新建
//				initdiglog2("提示信息","无数据，本月8号之后重新填写");
				if(parentID == bossID && flag_month==1){
					$.ajax({
						type:"post",//post方法
						url:"OAServlet",
						data:{"type":"getLastMoncePerformance","performance_month":t_month,"performance_cid":performance_cid},
						dataType:'json',
						success:function(lastReturnData){
							if(lastReturnData){
								initTable(0,lastReturnData);
							}
						}
					})
				}
			}
		},
		error:function(returnData){
			initdiglog2("提示信息","获取异常");
		}
	});
}*/

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
			if(performance_json2.operation==7){
				initdiglog2("提示信息","驳回"+str_result);
			}
			else{
				initdiglog2("提示信息","审批"+str_result);
			}			
			$( "#confirm1" ).click(function() {
				$( "#onebtndialog" ).dialog( "close" );
				window.location.href='FlowManagerServlet?type=flowdetail&flowtype=32&id='+performance_json.id;
			});
		},
		error:function(returnData){
			initdiglog2("提示信息","获取异常");
		}
	});
}