$(function(){
	begin_month--;
	if(begin_month==0){
		begin_month=12;
		begin_year--;
	}
	end_month--;	
	if(end_month==0){
		end_month=12;
		end_year--;
	}
	$("#btn_begin_year").html(begin_year+"年");
	$("#btn_begin_month").html(begin_month+"月");
	$("#btn_end_year").html(end_year+"年");
	$("#btn_end_month").html(end_month+"月");
	onSearch();
});

/**获取数据**/
function getPerformanceReport(){
	$.ajax({
		type:"post",//post方法
		url:"OAServlet",
		data:{"type":"getPerformanceReport","department_index":department_index,"create_id":create_id,"begin_month":begin_time,"end_month":end_time},
		dataType:'json',
		success:function(returnData){
			if(returnData){//返回数组，一个绩效对应一条记录，且根据用户做了排序
				var dataArr = [];
				var t_create_id = 0;
				var len = returnData.length;
				for(var i=0; i<len; i++){
					if(t_create_id != returnData[i].create_id && isValidUser(returnData[i].create_id)){//用户变更判定是否为有效用户
						t_create_id = returnData[i].create_id;
						if(department_index==0){
							for(var j=0; j<arr_users_unsubmit.length;j++){
								if(t_create_id == arr_users_unsubmit[j][0]){
									arr_users_unsubmit.splice(j,1);
									break;
								}
							}
						}
					}
					if(t_create_id == returnData[i].create_id){
						dataArr.push(returnData[i]);
					}
				}
				if(dataArr.length == 0){
					initdiglog2("提示信息","无数据");
				}
				else{
					setData(dataArr);
				}				
			}else{
				initdiglog2("提示信息","无数据");
			}
		},
		error:function(returnData){
			initdiglog2("提示信息","获取异常");
		}
	});
}
/**判断是否为有效用户**/
function isValidUser(t_create_id){
	var isValid = false;
	for(var i=0; i<usersArray.length; i++){
		if(t_create_id == usersArray[i][0]){
			isValid = true;
			break;
		}
	}
	return isValid;
}

/**查询数据**/
function onSearch(){
	staff_name = $("#ipt_staff_name").val();
	if(staff_name != ""){
		department_index = 0;
		$("#sel_department").val(department_index);
	}
	begin_time=timeTransStrToLong2(begin_year+"/"+begin_month+"/1");//月初时间戳
	end_time=timeTransStrToLong2(end_year+"/"+ end_month +"/1");//下月月初
	arr_month = [];	
	var t_year=begin_year;
	var t_month=begin_month;
	var t_time = begin_time;
	arr_month.push(t_time);
	while(t_time<end_time){
		t_month++;
		if(t_month == 13){
			t_month = 1;
			t_year++;
		}
		t_time = timeTransStrToLong2(t_year+"/"+t_month+"/1");
		arr_month.push(t_time);
	}
	initTable();
	arr_users_unsubmit = usersArray.concat();
	getPerformanceReport();
}
/**初始化表格**/
function initTable(){
	$("#tab_table").html("");	
	$("#tab_table_tableFix").html("");
	$("#tab_table_tableHead").html("");
	$("#tab_table_tableColumn").html("");
//	$("#tab_table_tableLayout").html("");
	var str_tr = '<tr><th style="min-width:8em;">人员</th><th style="min-width:12em">岗位名称</th>';
	var len = arr_month.length;
	var t_time;
	var t_date;
	var t_month;
	for(var i=0; i<len; i++){
		t_time = arr_month[i];
		t_date= new Date(t_time);
		t_month = t_date.getMonth()+1;
		str_tr += '<th style="min-width:8em;" colspan="2";>'+t_month+'月</th>';
	}
	if(arr_month.length > 1){
		str_tr += '<th style="min-width:8em;">平均值</th>';
	}
	str_tr += '</tr>';
	$("#tab_table").append(str_tr);
}
/**填充数据**/
function setData(returnData){
	var i=0;
	var len=returnData.length;
	var len_month = arr_month.length;
	var index_month = 0;
	var obj;
	var str_data = "";
	var t_create_id = 0;
	var index_staff = 0;//人员序号
	var tr_class = "tab_tr2";
	var t_sum_right=0;//右侧平均值（和）
	var t_sum_bottom=0;//下方平均值（和）
	var t_month_valid=0;//有效次数
	var t_sum=0;//总值
	var t_valid=0;//下方有效平均值数目
	var t_department_index=0;//所属部门
	for(i=0; i<len; i++){
		obj = returnData[i];
		if(t_create_id != obj.create_id){
			t_department_index = 0;
			if(t_create_id!=0){//切换用户时，补上后面的月份空缺
				while(index_month<=(len_month-1)){
					str_data += '<td>'+'缺'+'</td>';
					str_data += '<td>'+'缺'+'</td>';
					index_month++;
				}
				if(len_month>1){
					if(t_month_valid == 0){
						str_data += '<td>'+'缺'+'</td>';
					}
					else{
						str_data += '<td>'+(t_sum_right/t_month_valid/0.9).toFixed(0)+'%'+'</td>';
					}
				}								
				str_data += '</tr>';
				$("#tab_table").append(str_data);
				str_data = "";
				index_staff++;
			}			
			if(index_staff%2 == 0){
				tr_class = "tab_tr2";
			}
			else{
				tr_class = "tab_tr3";
			}
			t_create_id = obj.create_id;
			index_month = 0;
			t_sum_right = 0;
			t_month_valid = 0;
			t_department_index = obj.department_index;
			str_data += '<tr class='+tr_class+' staff_name='+obj.create_name+' department_index="'+obj.department_index+'"><td>'+obj.create_name+'</td><td>'+obj.position_name+'</td>';
		}
		while(arr_month[index_month]<obj.performance_month){//补上之前月份的空缺
			str_data += '<td>'+'缺'+'</td>';
			str_data += '<td>'+'缺'+'</td>';
			index_month++;
		}
		if(arr_month[index_month]==obj.performance_month){
			if(t_department_index != obj.department_index){
				t_department_index = obj.department_index;
				str_data = changeValueBTQuots(str_data,"department_index",t_department_index);
			}
			str_data += '<td onclick="onTdClick('+obj.id+')">'+arr_quotiety[obj.quotiety]+'</td>';
			str_data += '<td onclick="onTdClick('+obj.id+')">'+(obj.score/0.9).toFixed(0)+'%'+'</td>';
			t_month_valid++;
			t_sum_right += Number(obj.score);
			index_month++;
		}
	}
	if(len>0){//补上后面的月份空缺
		while(index_month<=(len_month-1)){
			str_data += '<td>'+'缺'+'</td>';
			str_data += '<td>'+'缺'+'</td>';
			index_month++;
		}
		if(len_month>1){
			if(t_month_valid == 0){
				str_data += '<td>'+'缺'+'</td>';
			}
			else{
				str_data += '<td>'+(t_sum_right/t_month_valid/0.9).toFixed(0)+'%'+'</td>';
			}
		}
		str_data += '</tr>';
		$("#tab_table").append(str_data);
		str_data = "";
		index_staff++;
	}
	/**补充未提交考核的人员**/
	if(department_index==0){
		len = arr_users_unsubmit.length;
		var t_index_staff = index_staff;		
		for(i=0; i<len; i++){
			if(t_index_staff%2 == 0){
				tr_class = "tab_tr2";
			}
			else{
				tr_class = "tab_tr3";
			}
			str_data = '<tr class='+tr_class+' staff_name='+arr_users_unsubmit[i][1]+' department_index="'+0+'"><td>'+arr_users_unsubmit[i][1]+'</td><td>'+""+'</td>';
			index_month=0;
			while(index_month<=(len_month-1)){
				str_data += '<td>'+'缺'+'</td>';
				str_data += '<td>'+'缺'+'</td>';
				index_month++;
			}
			if(len_month>1){//平均值
				str_data += '<td>'+'缺'+'</td>';
			}								
			str_data += '</tr>';
			$("#tab_table").append(str_data);
			t_index_staff++;
		}
	}
	/**两人及两人以上计算部门平均值**/
	var t_score = "";
	if(index_staff>1){
		str_data = '<tr class="tab_tr4"><td>'+"平均值"+'</td><td></td>';
		for(var i=0; i<len_month; i++){
			t_sum_bottom = 0;
			t_month_valid = 0;
			$("#tab_table tr:gt(0)").each(function(){
				t_score = $(this).children('td:eq('+(2*i+3)+')').text();
				if(t_score != "缺"){
					t_sum_bottom += Number(t_score.slice(0,-1));
					t_month_valid++;
				}
			});
			if(t_month_valid==0){
				str_data += '<td></td>';
				str_data += '<td>'+'缺'+'</td>';
			}
			else{
				str_data += '<td></td>';
				str_data += '<td>'+(t_sum_bottom/t_month_valid).toFixed(0)+'%'+'</td>';
				t_sum += (t_sum_bottom/t_month_valid);
				t_valid++;
			}
		}
		if(len_month>1){
			if(t_valid == 0){
				str_data += '<td>'+'缺'+'</td>';
			}
			else{
				str_data += '<td>'+(t_sum/t_valid).toFixed(0)+'%'+'</td>';
			}
		}
		str_data += '</tr>';
		$("#tab_table").append(str_data);
	}	
	/**固定表格**/
	var tableHeight = $("#tab_table").height();
	tableHeight+=20;
	var windowHeight = $(window).height();
	var flag_vScroll = false;
	if(tableHeight>(windowHeight-300) && (windowHeight-300)>300){
		flag_vScroll = true;
		tableHeight = windowHeight-300;
	}
	if(len_month>7 || flag_vScroll){
		fixTable("tab_table",2,1020,tableHeight);
	}
	/**员工过滤**/
	onStaffChange();
}
/**
 * 字符串状态，修改属性的值
 * str=需要修改的字符串
 * tag=属性标签（在str中不重复）
 * value=替换后的值
 */
function changeValueBTQuots(str,tag,value){	
	var itag = 	str.indexOf(tag);
	var l_quot = itag + (tag.length+1);//(tag.length+1)表示补上等号
	var r_quot = str.indexOf('"',(l_quot+1));
	var str_old = str.slice(itag,r_quot+1);
	var str_new = tag + '="' +value+ '"';
	str = str.replace(str_old,str_new);
	return str;	
}
/**部门改变**/
function onDepartmentChange(){
	department_index = $("#sel_department").val();
	$("#sel_department").attr("title",departmentArray[department_index]);
}
/**日期选择**/
function choseReport(year,month,obj,flag){
	obj.blur();
	if(flag == 1){
		begin_year = year;
		begin_month = month;
		$("#btn_begin_year").html(begin_year+"年");
		$("#btn_begin_month").html(begin_month+"月");
	}
	else{
		end_year = year;
		end_month = month;
		$("#btn_end_year").html(end_year+"年");
		$("#btn_end_month").html(end_month+"月");
	}
}
/**员工改变**/
function onStaffChange(){
	staff_name = $("#ipt_staff_name").val(); 
	if(staff_name == ""){
		$("#tab_table tr:gt(0)").show();
		$("#tab_table_tableColumn tr:gt(0)").show();
	}
	else{
		$("#tab_table tr:gt(0)").hide();
		$('#tab_table tr[staff_name*='+staff_name+']').show();
		$("#tab_table_tableColumn tr:gt(0)").hide();
		$('#tab_table_tableColumn tr[staff_name*='+staff_name+']').show();
	}
}
/**跳转到对应的考核表**/
function onTdClick(id){
	window.location.href='FlowManagerServlet?type=flowdetail&flowtype=32&id='+id;
}
/**导出表格**/
function onExportTrack(){
	var len_tr = $("#tab_table tr:visible").length;
	if(len_tr==1){
		initdiglog2("提示信息", "没有数据！");
		return;
	}
	var temp='';
	var index_th=0;
	var index_td;
	var rowCount=0;//行号
	var t_department_index=0;//所属部门
	$("#tab_table tr").each(function(){
		var rowTemp='';
		var display = $(this).css("display");
		if(display=="none"){
			return true;//相当于continue
		}
		rowCount++;
		$(this).find("th").each(function(){
			if(index_th==1){
				rowTemp+='の'+ "所属部门";
			}
			rowTemp+='の'+$(this).text().trim();			
			if(index_th>1){
				rowTemp+='の';
			}
			index_th++;
    	});
		if(rowCount==2 || (rowCount>1 && rowCount<len_tr)){
			t_department_index=$(this).attr("department_index");
		}
		index_td=0;
		$(this).find("td").each(function(){
			if(index_td==1){
				if(len_tr>2 && rowCount==len_tr){
					rowTemp+='の';
				}
				else{
					if(t_department_index == 0){
						rowTemp+='の';
					}
					else{
						rowTemp+='の'+departmentArray[t_department_index];
					}
				}
			}
			rowTemp+='の'+$(this).text().trim();
			index_td++;
    	});
		temp+="い"+rowTemp.replace('の','');
	});
	temp=temp.replace("い","");
	//导出excel
	var filename="考核统计表（"+begin_year+"年"+begin_month+"月-"+end_year+"年"+end_month+"月）";
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
/**
 * 固定表格
 * TableID=原table的id，FixColumnNumber=需要锁定的列数，width=显示的宽度，height=显示的高度
 * **/
function fixTable(TableID, FixColumnNumber, width, height) {
	var str_layout="";
    if ($("#" + TableID + "_tableLayout").length != 0) {
    	$("#" + TableID + "_tableLayout").before($("#" + TableID));
        $("#" + TableID + "_tableLayout").empty();
    }
    else {
    	str_layout = '<div id="'+TableID+'_tableLayout" style="overflow:hidden;height:'+height+'px;width:'+width+'px;margin:0px auto"></div>';
        $("#" + TableID).after(str_layout);
    }
    $('<div id="' + TableID + '_tableFix"></div>'
        + '<div id="' + TableID + '_tableHead"></div>'
        + '<div id="' + TableID + '_tableColumn"></div>'
        + '<div id="' + TableID + '_tableData"></div>').appendTo("#" + TableID + "_tableLayout");
    var oldtable = $("#" + TableID);
    var tableFixClone = oldtable.clone(true);
    tableFixClone.attr("id", TableID + "_tableFixClone");
    $("#" + TableID + "_tableFix").append(tableFixClone);
    var tableHeadClone = oldtable.clone(true);
    tableHeadClone.attr("id", TableID + "_tableHeadClone");
    $("#" + TableID + "_tableHead").append(tableHeadClone);
    var tableColumnClone = oldtable.clone(true);
    tableColumnClone.attr("id", TableID + "_tableColumnClone");
    $("#" + TableID + "_tableColumn").append(tableColumnClone);
    $("#" + TableID + "_tableData").append(oldtable);
    $("#" + TableID + "_tableLayout table").each(function () {
        $(this).css("margin", "0");
    });
    var HeadHeight = $("#" + TableID + "_tableHead tr:eq(0)").height();
    HeadHeight += 2;
    $("#" + TableID + "_tableHead").css("height", HeadHeight);
    $("#" + TableID + "_tableFix").css("height", HeadHeight);
    var ColumnsWidth = 0;
    var ColumnsNumber = 0;
    $("#" + TableID + "_tableColumn tr:last td:lt(" + FixColumnNumber + ")").each(function () {
        ColumnsWidth += $(this).outerWidth(true);
        ColumnsNumber++;
    });
    ColumnsWidth += 2;
    $("#" + TableID + "_tableColumn").css("width", ColumnsWidth);
    $("#" + TableID + "_tableFix").css("width", ColumnsWidth);
    $("#" + TableID + "_tableData").scroll(function () {
        $("#" + TableID + "_tableHead").scrollLeft($("#" + TableID + "_tableData").scrollLeft());
        $("#" + TableID + "_tableColumn").scrollTop($("#" + TableID + "_tableData").scrollTop());
    });
    $("#" + TableID + "_tableFix").css({ "overflow": "hidden", "position": "relative", "z-index": "50"});
    $("#" + TableID + "_tableHead").css({ "overflow": "hidden", "width": width - 17, "position": "relative", "z-index": "45"});
    $("#" + TableID + "_tableColumn").css({ "overflow": "hidden", "height": height - 17, "position": "relative", "z-index": "40"});
    $("#" + TableID + "_tableData").css({ "overflow": "auto", "width": width, "height": height, "position": "relative","z-index": "35"});
    if ($("#" + TableID + "_tableHead").width() > $("#" + TableID + "_tableFix table").width()) {
        $("#" + TableID + "_tableHead").css("width", $("#" + TableID + "_tableFix table").width());
        $("#" + TableID + "_tableData").css("width", $("#" + TableID + "_tableFix table").width() + 17);
    }
    if ($("#" + TableID + "_tableColumn").height() > $("#" + TableID + "_tableColumn table").height()) {
        $("#" + TableID + "_tableColumn").css("height", $("#" + TableID + "_tableColumn table").height());
        $("#" + TableID + "_tableData").css("height", $("#" + TableID + "_tableColumn table").height() + 17);
    }
    $("#" + TableID + "_tableFix").offset($("#" + TableID + "_tableLayout").offset());
    $("#" + TableID + "_tableHead").offset($("#" + TableID + "_tableLayout").offset());
    $("#" + TableID + "_tableColumn").offset($("#" + TableID + "_tableLayout").offset());
    $("#" + TableID + "_tableData").offset($("#" + TableID + "_tableLayout").offset());
}
