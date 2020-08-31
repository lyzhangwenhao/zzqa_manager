$(function(){
	getDeliverByID();
});
function getDeliverByID(){
	$.ajax({
		type:"post",//post方法
		url:"OAServlet",
		data:{"type":"getDepartPuchaseByID","departPuchase_id":departPuchase_id},
		dataType:'json',
		success:function(returnData){
			if(returnData){
				departPurcahse_json=returnData;
				items_json=departPurcahse_json.items;
				flows=departPurcahse_json.flows;
				departPurcahse_json.items=null;
				departPurcahse_json.flows=null;
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
	var operation=departPurcahse_json.operation;
	var create_date=timeTransLongToStr(departPurcahse_json.create_time,100,"-",true).replace(" ","<br/>");
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
		$("#flow_title1>div:eq(1)").attr("class","color_error");
		$("#flow_title2>div:eq(0)").attr("class","background_color_error");
		$("#flow_title2>img:eq(0)").attr("src","images/pass.png");
		$("#flow_title2>img:eq(1)").attr("src","images/error.png");
		$("#flow_title1").show();
		$("#flow_title2").show();
		$("#flow_title3").show();
	}else if(operation==3){
		$("#flow_title3>div:eq(0)").html(create_date);
		$("#flow_title3>div:eq(1)").html(getFlowTime(3));
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
	}else if(operation==5){		
		$("#flow_title3>div:eq(0)").html(create_date);
		$("#flow_title3>div:eq(1)").html(getFlowTime(3));
		$("#flow_title3>div:eq(2)").html(getFlowTime(10));
		$("#flow_title1>div:eq(0)").attr("class","color_did");
		$("#flow_title1>div:eq(1)").attr("class","color_did");
		$("#flow_title1>div:eq(2)").attr("class","color_did");
		$("#flow_title2>div:eq(0)").attr("class","background_color_did");
		$("#flow_title2>div:eq(1)").attr("class","background_color_did");
		$("#flow_title2>div:eq(2)").attr("class","background_color_did");
		$("#flow_title2>img:eq(0)").attr("src","images/pass.png");
		$("#flow_title2>img:eq(1)").attr("src","images/pass.png");
		$("#flow_title2>img:eq(2)").attr("src","images/pass.png");
		$("#flow_title2>img:eq(3)").attr("src","images/go.png");
		$("#flow_title1").show();
		$("#flow_title2").show();
		$("#flow_title3").show();
		
	}else if(operation==10){		
		$("#flow_title3>div:eq(0)").html(create_date);
		$("#flow_title3>div:eq(1)").html(getFlowTime(3));
		$("#flow_title3>div:eq(2)").html(getFlowTime(10));
		$("#flow_title1>div:eq(0)").attr("class","color_did");
		$("#flow_title1>div:eq(1)").attr("class","color_did");
		$("#flow_title1>div:eq(2)").attr("class","color_did");
		$("#flow_title2>div:eq(0)").attr("class","background_color_did");
		$("#flow_title2>div:eq(1)").attr("class","background_color_did");
		$("#flow_title2>div:eq(2)").attr("class","background_color_did");
		$("#flow_title2>img:eq(0)").attr("src","images/pass.png");
		$("#flow_title2>img:eq(1)").attr("src","images/pass.png");
		$("#flow_title2>img:eq(2)").attr("src","images/pass.png");
		$("#flow_title2>img:eq(3)").attr("src","images/go.png");
		$("#flow_title1").show();
		$("#flow_title2").show();
		$("#flow_title3").show();
		
	}else if(operation==4){
		$("#flow_title3>div:eq(0)").html(create_date);
		$("#flow_title3>div:eq(1)").html(getFlowTime(3));
		$("#flow_title3>div:eq(2)").html(getFlowTime(4));
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
	}else if(operation==7){
		$("#flow_title3>div:eq(0)").html(create_date);
		$("#flow_title3>div:eq(1)").html(getFlowTime(3));
		var t=getFlowTime(5);
		$("#flow_title3>div:eq(2)").html(t);
		$("#flow_title3>div:eq(3)").html(getFlowTime(9 ));
		$("#flow_title3>div:eq(4)").html(getFlowTime(7));
		$("#flow_title3>div:eq(5)").html(getFlowTime(7));
		$("#flow_title1>div").attr("class","color_did");
		$("#flow_title2>div").attr("class","background_color_did");
		$("#flow_title2>img").attr("src","images/pass.png");
		$("#flow_title1").show();
		$("#flow_title2").show();
		$("#flow_title3").show();
	}else if(operation==8){
		$("#flow_title3>div:eq(0)").html(create_date);
		$("#flow_title3>div:eq(1)").html(getFlowTime(3));
		$("#flow_title3>div:eq(2)").html(getFlowTime(10));
		$("#flow_title3>div:eq(3)").html(getFlowTime(8));
		$("#flow_title1>div:eq(0)").attr("class","color_did");
		$("#flow_title1>div:eq(1)").attr("class","color_did");
		$("#flow_title1>div:eq(2)").attr("class","color_did");
		$("#flow_title1>div:eq(3)").attr("class","color_error");
		$("#flow_title2>div:eq(0)").attr("class","background_color_did");
		$("#flow_title2>div:eq(1)").attr("class","background_color_did");
		$("#flow_title2>div:eq(2)").attr("class","background_color_error");
		$("#flow_title2>img:eq(0)").attr("src","images/pass.png");
		$("#flow_title2>img:eq(1)").attr("src","images/pass.png");
		$("#flow_title2>img:eq(2)").attr("src","images/pass.png");
		$("#flow_title2>img:eq(3)").attr("src","images/error.png");
		$("#flow_title1").show();
		$("#flow_title2").show();
		$("#flow_title3").show();
	}else if(operation==9){
		$("#flow_title3>div:eq(0)").html(create_date);
		$("#flow_title3>div:eq(1)").html(getFlowTime(3));
		$("#flow_title3>div:eq(2)").html(getFlowTime(10));
		$("#flow_title3>div:eq(3)").html(getFlowTime(9));
		$("#flow_title1>div:eq(0)").attr("class","color_did");
		$("#flow_title1>div:eq(1)").attr("class","color_did");
		$("#flow_title1>div:eq(2)").attr("class","color_did");
		$("#flow_title1>div:eq(3)").attr("class","color_did");
		$("#flow_title2>div:eq(0)").attr("class","background_color_did");
		$("#flow_title2>div:eq(1)").attr("class","background_color_did");
		$("#flow_title2>div:eq(2)").attr("class","background_color_did");
		$("#flow_title2>div:eq(3)").attr("class","background_color_did");
		$("#flow_title2>img:eq(0)").attr("src","images/pass.png");
		$("#flow_title2>img:eq(1)").attr("src","images/pass.png");
		$("#flow_title2>img:eq(2)").attr("src","images/pass.png");
		$("#flow_title2>img:eq(3)").attr("src","images/pass.png");
		$("#flow_title2>img:eq(4)").attr("src","images/go.png");
		$("#flow_title1").show();
		$("#flow_title2").show();
		$("#flow_title3").show();
	}
}
function initTab(){
	var operation =departPurcahse_json.operation;
	$("#purchaseName").text(departPurcahse_json.purchaseName);
	$("#purchaseTime").text(departPurcahse_json.purchaseTime);
	$("#purchaseNum").text(departPurcahse_json.purchaseNum);
	var i=0;
	var temp='';
	$.each(items_json,function(i){
		temp+='<tr class="materials_tab_content" item_id="'+this.id+'" index_tr="'+(i+1)+'">'
		+'<td index_td="index" style="width:30px;">'+(i+1)+'</td>'
		+'<td index_td="material_id">'+this.material_id+'</td>'
		+'<td index_td="material_name" >'+this.material_name+'</td>'
		+'<td index_td="model">'+this.model+'</td>'
		+'<td index_td="processMaterial">'+this.processMaterial+'</td>'
		+'<td index_td="num">'+this.num+'</td>'
		+'<td index_td="remark">'+this.remark+'</td>'
		+'<td index_td="involveProject">'+(this.involveProject)+'</td>';
		if((operation==5 || operation==8) && departPurcahse_json.buyer){
			temp+='<td index_td="predict_date" style="margin:0px;" >'+'<input type="text" style="margin:0px;height:100%;width:100%;border:0;background:transparent;" id='+'"'+"pre"+i+'"'+' placeholder="输入时间..." value="'+(this.predict_date)+'" onClick="return Calendar('+"pre"+i+');" readonly="readonly"/>'+'</td>'
			+'<td index_td="aog_date">'+(this.aog_date)+'</td>';
		}else if(operation==9 && departPurcahse_json.checker){
			temp+='<td index_td="predict_date">'+(this.predict_date)+'</td>'
			+'<td index_td="aog_date" style="margin:0px;">'+'<input type="text" style="margin:0px;height:100%;width:100%;border:0;background:transparent;" id='+'"'+"aog"+i+'"'+' value="'+(this.aog_date)+'" placeholder="输入时间..." onClick="return Calendar(this);" readonly="readonly"/>'+'</td>';
		}else if(operation>=5 && operation!=8){
			temp+='<td index_td="predict_date">'+(this.predict_date)+'</td>'
			+'<td index_td="aog_date">'+(this.aog_date)+'</td>';
		}
		temp+='</tr>';
		i++;
	});
	$(".materials_tab_title").after(temp);
	var temp='';
	$.each(flows,function(){
		if(this.reason&&this.reason.length>0){
			var create_date=timeTransLongToStr(this.create_time,4,".",true);
			temp+='<tr><td class="td2_table3_left">'+transRNToBR(this.reason)+'</td><td class="td2_table3_right">';
			if(this.operation==3||this.operation==10){
				temp+='<div class="td2_div5_bottom_agree">';
			}else if(this.operation==2||this.operation==4 ||this.operation==8){
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
	var operation =departPurcahse_json.operation;
	var temp='';
	var needReason=false;
	if((operation!=6&&operation!=7)&&departPurcahse_json.create_id==uid){
		temp+='<div class="agree_div" onclick="jumpToAlter()">修 改</div><div class="disagree_div" onclick="deleteFlow()">撤 销</div>';
		needReason=true;
	}
	if((operation==1||operation==2)&&departPurcahse_json.leader){
		temp+='<div class="agree_div" onclick="verifyFlow(true)">同 意</div>';
		if(operation==1){
			temp+='<div class="disagree_div" onclick="verifyFlow(false)">不同意</div>';
		}
		needReason=true;
	}else if((operation==3||operation==4)&&departPurcahse_json.keeper){
		temp+='<div class="agree_div" onclick="verifyFlow(true)">同 意</div>';
		if(operation==3){
			temp+='<div class="disagree_div" onclick="verifyFlow(false)">不同意</div>';
		}
		needReason=true;
	}else if(operation==10&&departPurcahse_json.buyer){
			temp+='<div class="agree_div" onclick="verifyFlow(true)">确认采购</div>';
	}else if((operation==5||operation==8)&&departPurcahse_json.buyer){
		if(operation==5){
			temp+='<div class="agree_div" onclick="verifyFlow(true)">完成</div>';
			temp+='<div class="agree_div" onclick="saveTime()">保存</div>';
		}else{
			temp+='<div class="agree_div" onclick="verifyFlow(true)">同 意</div>';
		}
		needReason=true;
	}else if(operation==9&&departPurcahse_json.checker){
		temp+='<div class="agree_div" onclick="verifyFlow(true)">完成</div>';
		temp+='<div class="agree_div" onclick="saveTime()">保存</div>';
		needReason=true;
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
	window.location.href='FlowManagerServlet?type=flowdetail&flowtype=37&id='+departPurcahse_json.id;
}
function verifyFlow(flag){
	flow_json={};
	var length = items_json.length;
	var operation =departPurcahse_json.operation;
	if((operation==1||operation==2)&&flag){
		flow_json.operation=3;
	}else if((operation==3||operation==4)&&flag){
		flow_json.operation=10;
	}else if(operation==10&&flag){
		flow_json.operation=5;
	}else if((operation==5||operation==8)&&flag){
		for(var j=0;j<length;j++){
			if(items_json[j].predict_date==null || items_json[j].predict_date==""){
				initdiglog2("提示信息","第"+(j+1)+"行预计到货时间未填写！");
				return;
			}
		}
		flow_json.operation=9;
	}else if(operation==1&&!flag){
		flow_json.operation=2;
	}else if(operation==3&&!flag){
		flow_json.operation=4;
	}else if(operation==5&&!flag){
		flow_json.operation=8;
	}else if(operation==9&&flag){
		for(var j=0;j<length;j++){
			if(items_json[j].aog_date==null || items_json[j].aog_date==""){
				initdiglog2("提示信息","第"+(j+1)+"行实际到货时间未填写！");
				return;
			}
		}
		flow_json.operation=7;
	}else{
		initdiglog2("提示信息","数据异常，请刷新页面");
		return;
	}
	var reason=$(".div_testarea").val().trim();
	if(reason.length==0 && operation!=10){
		initdiglog2("提示信息","请输入意见或者建议");
		return;
	}
	flow_json.reason=reason;
	submitFlow();
}
function submitFlow(){
	$.ajax({
		type:"post",//post方法
		url:"OAServlet",
		data:{"type":"saveDepartePurchaseFlow","departPurcahse_json":JSON.stringify(departPurcahse_json),
			"items_json":JSON.stringify(items_json),"flow_json":JSON.stringify(flow_json)},
		dataType:'json',
		success:function(returnData){
			if(returnData>0){
				location.href='FlowManagerServlet?type=flowdetail&flowtype=36&id='+returnData;
			}else{
				initdiglog2("提示信息","提交异常，请刷新页面后重试");
			}
		},
		error:function(returnData){
			initdiglog2("提示信息","获取异常");
		}
	});
}
//保存时间
function saveTime(){
	var operation =departPurcahse_json.operation;
	$.ajax({
		type:"post",//post方法
		url:"OAServlet",
		data:{"type":"saveDepartePurchaseTime","items_json":JSON.stringify(items_json),"departPuchase_id":departPuchase_id,"operation":operation},
		dataType:'json',
		success:function(returnData){
			if(returnData>0){
				location.href='FlowManagerServlet?type=flowdetail&flowtype=36&id='+returnData;
			}else{
				initdiglog2("提示信息","提交异常，请刷新页面后重试");
			}
		},
		error:function(returnData){
			initdiglog2("提示信息","获取异常");
		}
	});
}
