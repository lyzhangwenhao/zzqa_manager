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
				deliver_json.items=null;
				deliver_json.flows=null;
				initFlows();
				initTab();
				initBtns();
			}else{
				initdiglog2("提示信息","获取异常");
			}
		},
		error:function(returnData){
			initdiglog2("提示信息","获取异常");
		}
	});
}
function getFlowTime(opera){
	var time=0;
	var len=flows.length;
	for (var i = 0; i < len; i++) {
		if(flows[len-i-1].operation==opera){
			time= flows[len-i-1].create_time;
			break;
		}
	}
	return flow_date=timeTransLongToStr(time,100,"-",true).replace(" ","<br/>");
}
/***
 * 初始化流程图
 */
function initFlows(){
	var operation=deliver_json.operation;
	var create_date=timeTransLongToStr(deliver_json.create_time,100,"-",true).replace(" ","<br/>");
	if(operation==1){
		$("#flow_title3>div:eq(0)").html(create_date);
		$("#flow_title1>div:eq(0)").attr("class","color_did");
		$("#flow_title2>div:eq(0)").attr("class","background_color_did");
		$("#flow_title2>img:eq(0)").attr("src","images/pass.png");
		$("#flow_title2>img:eq(1)").attr("src","images/go.png");
		$("#flow_title1").show();
		$("#flow_title2").show();
		$("#flow_title3").show();
	}else if(operation==2){
		$("#flow_title3>div:eq(0)").html(create_date);
		$("#flow_title3>div:eq(1)").html(getFlowTime(2));
		$("#flow_title1>div:eq(0)").attr("class","color_did");
		$("#flow_title1>div:eq(1)").attr("class","color_did");
		$("#flow_title2>div:eq(0)").attr("class","background_color_did");
		$("#flow_title2>div:eq(1)").attr("class","background_color_did");
		$("#flow_title2>img:eq(0)").attr("src","images/pass.png");
		$("#flow_title2>img:eq(1)").attr("src","images/pass.png");
		$("#flow_title2>img:eq(2)").attr("src","images/go.png");
		$("#flow_title1").show();
		$("#flow_title2").show();
		$("#flow_title3").show();
	}else if(operation==3){
		$("#flow_title3>div:eq(0)").html(create_date);
		$("#flow_title3>div:eq(1)").html(getFlowTime(3));
		$("#flow_title1>div:eq(0)").attr("class","color_did");
		$("#flow_title1>div:eq(1)").attr("class","color_error");
		$("#flow_title2>div:eq(0)").attr("class","background_color_error");
		$("#flow_title2>img:eq(0)").attr("src","images/pass.png");
		$("#flow_title2>img:eq(1)").attr("src","images/error.png");
		$("#flow_title1").show();
		$("#flow_title2").show();
		$("#flow_title3").show();
	}else if(operation==4){
		$("#flow_title3>div:eq(0)").html(create_date);
		$("#flow_title3>div:eq(1)").html(getFlowTime(2));
		var t=getFlowTime(4);
		$("#flow_title3>div:eq(2)").html(t);
		$("#flow_title3>div:eq(3)").html(t);
		$("#flow_title1>div").attr("class","color_did");
		$("#flow_title2>div").attr("class","background_color_did");
		$("#flow_title2>img").attr("src","images/pass.png");
		$("#flow_title1").show();
		$("#flow_title2").show();
		$("#flow_title3").show();
	}else if(operation==5){
		$("#flow_title3>div:eq(0)").html(create_date);
		$("#flow_title3>div:eq(1)").html(getFlowTime(2));
		$("#flow_title3>div:eq(2)").html(getFlowTime(5));
		$("#flow_title1>div:eq(0)").attr("class","color_did");
		$("#flow_title1>div:eq(1)").attr("class","color_did");
		$("#flow_title1>div:eq(2)").attr("class","color_error");
		$("#flow_title2>div:eq(0)").attr("class","background_color_did");
		$("#flow_title2>div:eq(1)").attr("class","background_color_error");
		$("#flow_title2>img:eq(0)").attr("src","images/pass.png");
		$("#flow_title2>img:eq(1)").attr("src","images/pass.png");
		$("#flow_title2>img:eq(2)").attr("src","images/error.png");
		$("#flow_title1").show();
		$("#flow_title2").show();
		$("#flow_title3").show();
	}else if(operation==6){
		$("#flow_title3>div:eq(0)").html(create_date);
		$("#flow_title3>div:eq(3)").html(getFlowTime(6));
		$("#flow_title2>img:eq(0)").attr("src","images/pass.png");
		$("#flow_title2>img:eq(3)").attr("src","images/error.png");
		$("#flow_title1>div:eq(3)").text("已撤销");
		$("#flow_title1").attr("class","title1_flowdel").show();
		$("#flow_title2").attr("class","title2_flowdel").show();
		$("#flow_title3").attr("class","title3_flowdel").show();
	}
}
function initTab(){
	$("#project_name").text(deliver_json.project_name);
	$("#project_id").text(deliver_json.project_id);
	$("#material_type").text(materialsArray[deliver_json.material_type]);
	$("#department_index").text(departmentArray[deliver_json.department_index]);
	var temp='';
	$.each(items_json,function(i){
		temp+='<tr class="materials_tab_content" item_id="'+this.id+'" index_tr="'+(i+1)+'">'
		+'<td index_td="index" style="width:30px;">'+(i+1)+'</td>'
		+'<td index_td="material_id">'+this.material_id+'</td>'
		+'<td index_td="material_name" >'+this.material_name+'</td>'
		+'<td index_td="model">'+this.model+'</td>'
		+'<td index_td="unit">'+this.unit+'</td>'
		+'<td index_td="num">'+this.num+'</td>'
		+'<td index_td="quality">'+(this.quality?this.quality:"")+'</td>'
		+'<td index_td="remark">'+this.remark+'</td>'
		+'</tr>';
	});
	$(".materials_tab_title").after(temp);
	var temp='';
	$.each(flows,function(){
		if(this.reason&&this.reason.length>0){
			var create_date=timeTransLongToStr(this.create_time,4,".",true);
			temp+='<tr><td class="td2_table3_left">'+transRNToBR(this.reason)+'</td><td class="td2_table3_right">';
			if(this.operation==2||this.operation==4){
				temp+='<div class="td2_div5_bottom_agree">';
			}else if(this.operation==3||this.operation==5){
				temp+='<div class="td2_div5_bottom_disagree">';
			}else {
				temp+='<div class="td2_div5_bottom_noimg">';
			}
			temp+='<div style="height: 15px;"></div><div class="td2_div5_bottom_right1">'+this.username+'</div><div class="td2_div5_bottom_right2">'
				+create_date+'</div></div></td></tr>';
		}
	});
	if(temp.length>0){
		temp='<div class="reason_table_parent"><table class="td2_table3">'+temp+'</table></div>';
		$(".reason_parent").before('<div class="hide-btn" onclick="showApprove()"><span>显示审批</span><img src="images/show_check.png"></div>');
		$(".reason_parent").before(temp);
	}
}
function initBtns(){
	var operation =deliver_json.operation;
	var temp='';
	var needReason=false;
	if((operation!=4&&operation!=6)&&deliver_json.create_id==uid){
		temp+='<div class="agree_div" onclick="jumpToAlter()">修 改</div><div class="disagree_div" onclick="deleteFlow()">撤 销</div>';
		needReason=true;
	}
	if((operation==1||operation==3)&&deliver_json.leader){
		temp+='<div class="agree_div" onclick="verifyFlow(true)">同 意</div>';
		if(operation==1){
			temp+='<div class="disagree_div" onclick="verifyFlow(false)">不同意</div>';
		}
		needReason=true;
	}else if((operation==2||operation==5)&&deliver_json.keeper){
		temp+='<div class="agree_div" onclick="verifyFlow(true)">同 意</div>';
		if(operation==2){
			temp+='<div class="disagree_div" onclick="verifyFlow(false)">不同意</div>';
		}
		needReason=true;
	}
	if(operation==4){
		temp+='<div class="agree_div" onclick="preview()">打 印</div>';
	}
	if(needReason){
		$(".reason_parent").show();
	}
	$(".btns_group").html(temp);
}
function showApprove(){
	if(now_show){
		$(".hide-btn span").text("显示审批");
		$(".hide-btn img").attr("src","images/show_check.png");
	}else{
		$(".hide-btn span").text("隐藏审批");
		$(".hide-btn img").attr("src","images/hide_check.png");
	}
	now_show=!now_show;
	$(".reason_table_parent").toggle();
}
function deleteFlow(){
	initdiglogtwo2("提示信息","您确定要撤销吗？");
	$( "#confirm2" ).click(function() {
		$( "#twobtndialog" ).dialog( "close" );
		flow_json={};
		flow_json.operation=6;
		var reason=$(".div_testarea").val().trim();
		if(reason.length==0){
			initdiglog2("提示信息","请输入撤销理由");
		}else{
			flow_json.reason=reason;
			submitFlow();
		}
	});
}
function jumpToAlter(){
	window.location.href='FlowManagerServlet?type=flowdetail&flowtype=34&id='+deliver_json.id;
}
function verifyFlow(flag){
	flow_json={};
	var operation =deliver_json.operation;
	if((operation==1||operation==3)&&flag){
		flow_json.operation=2;
	}else if((operation==2||operation==5)&&flag){
		flow_json.operation=4;
	}else if(operation==1&&!flag){
		flow_json.operation=3;
	}else if(operation==2&&!flag){
		flow_json.operation=5;
	}else{
		initdiglog2("提示信息","数据异常，请刷新页面");
		return;
	}
	var reason=$(".div_testarea").val().trim();
	if(reason.length==0){
		initdiglog2("提示信息","请输入理由");
		return;
	}
	flow_json.reason=reason;
	submitFlow();
}
function submitFlow(){
	$.ajax({
		type:"post",//post方法
		url:"OAServlet",
		data:{"type":"saveDeliverFlow","deliver_json":JSON.stringify(deliver_json),
			"items_json":JSON.stringify(items_json),"flow_json":JSON.stringify(flow_json)},
		dataType:'json',
		success:function(returnData){
			if(returnData>0){
				location.href='FlowManagerServlet?type=flowdetail&flowtype=33&id='+returnData;
			}else{
				initdiglog2("提示信息","提交异常，请刷新页面后重试");
			}
		},
		error:function(returnData){
			initdiglog2("提示信息","获取异常");
		}
	});
}
function preview(){
	window.location.href='FlowManagerServlet?type=flowdetail&flowtype=35&id='+deliver_json.id;
}