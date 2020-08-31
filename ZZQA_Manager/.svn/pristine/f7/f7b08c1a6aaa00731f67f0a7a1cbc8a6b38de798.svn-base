$(function(){
	getDeliverByID();
});
function getDeliverByID(){
	$.ajax({
		type:"post",//post方法
		url:"OAServlet",
		data:{"type":"getDeliverByID","deliver_id":deliver_id},
		dataType:'json',
		success:function(returnData){
			if(returnData){
				deliver_json=returnData;
				items_json=deliver_json.items;
				flows=deliver_json.flows;
				initTab();
			}else{
				initdiglog2("提示信息","获取异常");
			}
		},
		error:function(returnData){
			initdiglog2("提示信息","获取异常");
		}
	});
}
function getFlow(opera){
	var time=0;
	var len=flows.length;
	for (var i = 0; i < len; i++) {
		if(flows[len-i-1].operation==opera){
			return flows[len-i-1];
		}
	}
	return flows[0];
}
function initTab(){
	$("#project_name").text(deliver_json.project_name);
	$("#project_id").text(deliver_json.project_id);
	$("#material_type").text(materialsArray[deliver_json.material_type]);
	$("#department_index").text(departmentArray[deliver_json.department_index]);
	var approve_flow=getFlow(4);
	var deliver_date=timeTransLongToStr(approve_flow.create_time,4,"/",false);
	$("#create_time").text(deliver_date);
	var temp='';
	var max_len=9;
	var last_num=1;
	$.each(items_json,function(i){
		last_num=i+1;
		temp+='<tr class="picking_tr_content">'
			+'<td index_td="index" style="width:30px;">'+last_num+'</td>'
			+'<td index_td="material_id">'+this.material_id+'</td>'
			+'<td index_td="material_name" >'+this.material_name+'</td>'
			+'<td index_td="model">'+this.model+'</td>'
			+'<td index_td="unit">'+this.unit+'</td>'
			+'<td index_td="num">'+this.num+'</td>'
			+'<td index_td="quality">'+(this.quality?this.quality:"")+'</td>'
			+'<td index_td="remark">'+this.remark+'</td>'
			+'</tr>';
	});
	for(var i=last_num+1;i<=max_len;i++){
		temp+='<tr class="picking_tr_content">'
			+'<td index_td="index" style="width:30px;">'+i+'</td>'
			+'<td index_td="material_id"></td>'
			+'<td index_td="material_name" ></td>'
			+'<td index_td="model"></td>'
			+'<td index_td="unit"></td>'
			+'<td index_td="num"></td>'
			+'<td index_td="quality"></td>'
			+'<td index_td="remark"></td>'
			+'</tr>';
	}
	$(".picking_tr_title").after(temp);
	approve_flow=getFlow(1);
	$("#material_uname").text(approve_flow.username);
	$("#material_time").text(timeTransLongToStr(deliver_json.create_time,4,"/",false));
	approve_flow=getFlow(2);
	$("#approve_uname").text(approve_flow.username);
	$("#approve_time").text(timeTransLongToStr(approve_flow.create_time,4,"/",false));
	approve_flow=getFlow(4);
	$("#keeper_uname").text(approve_flow.username);
	$("#keeper_time").text(deliver_date);
}
function preview(){
	$("#div_dashed").css("display","none");
	$(".parent_div").css("padding","5px");
	$(".div_btn").css("display","none");
	$("body").css("background","#fff");
	window.print();
	$("#div_dashed").css("display","block");
	$(".parent_div").css("padding","25px");
	$("body").css("background","#f0f4f7");
	$(".div_btn").css("display","block");
}