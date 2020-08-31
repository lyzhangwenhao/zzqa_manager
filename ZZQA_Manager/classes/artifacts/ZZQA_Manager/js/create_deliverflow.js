$(function(){
	if(deliver_id>0){
		//修改
		getDeliverByID(deliver_id);
	}else{
		//新建
		initTable();
	}
});
function initTable(){
	var temp='';
	$.each(materialsArray,function(i){
		if(i>0){
			temp+='<option value="'+i+'">'+this+'</option>';
		}
	});
	$("#material_type").html(temp);
	temp='';
	$.each(departmentArray,function(i){
		if(i!=0&&i!=3){
			temp+='<option value="'+i+'">'+this+'</option>';
		}
	});
	$("#department_index").html(temp);
	$(".materials_tab_add").click(function(){
		showDialog(0);
	});
	$(".cancel_div").click(function(){
		history.back(-1);
	});
	if(deliver_id>0){
		$(".reason_parent").show();
		$("#project_name").val(deliver_json.project_name);
		$("#project_id").val(deliver_json.project_id);
		$("#department_index").val(deliver_json.department_index);
		$("#material_type").val(deliver_json.material_type);
		if(deliver_json.operation!=4&&deliver_json.operation!=6){
			$(".submit_div").click(function(){
				saveDeliver();
			});
		}else{
			$(".materials_tab_add").css("display","none");
		}
		temp='';
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
		initTR();
	}else{
		$(".submit_div").click(function(){
			saveDeliver();
		});
	}
}
function saveDeliver(){
	flow_json={};
	items_json=[];
	if(deliver_id==0){
		deliver_json={};
	}
	var project_name=$("#project_name").val().trim();
	var project_id=$("#project_id").val().trim();
	var material_type=$("#material_type").val();
	var department_index=$("#department_index").val();
	if(project_name.length==0){
		initdiglog2("提示信息","请输入项目名称");
		return;
	}
	if(project_id.length==0){
		initdiglog2("提示信息","请输入项目编号");
		return;
	}
	if($(".materials_tab_content").length==0){
		initdiglog2("提示信息","请添加物料清单");
		return;
	}
	$(".materials_tab_content").each(function(i){
		var tr_jq=$(this);
		var item={};
		item.id=tr_jq.attr("item_id");
		item.material_id=tr_jq.find("td[index_td='material_id']").text().trim();
		item.material_name=tr_jq.find("td[index_td='material_name']").text().trim();
		item.model=tr_jq.find("td[index_td='model']").text().trim();
		item.unit=tr_jq.find("td[index_td='unit']").text().trim();
		item.num=tr_jq.find("td[index_td='num']").text().trim();
		item.quality=tr_jq.find("td[index_td='quality']").text().trim();
		item.remark=tr_jq.find("td[index_td='remark']").text().trim();
		items_json.push(item);
	});
	deliver_json.project_name=project_name;
	deliver_json.project_id=project_id;
	deliver_json.material_type=material_type;
	deliver_json.department_index=department_index;
	if(deliver_id>0){
		var reason=$(".div_testarea").val().trim();
		flow_json.reason=reason;
		if(reason.length==0){
			initdiglog2("提示信息","请输入修改理由");
			return;
		}
	}
	flow_json.operation=1;
	$.ajax({
		type:"post",//post方法
		url:"OAServlet",
		data:{"type":"saveDeliverFlow","deliver_json":JSON.stringify(deliver_json),
			"items_json":JSON.stringify(items_json),"flow_json":JSON.stringify(flow_json),"del_ids":del_ids},
		dataType:'json',
		success:function(returnData){
			if(returnData>0){
				//
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
function getDeliverByID(d_id){
	$.ajax({
		type:"post",//post方法
		url:"OAServlet",
		data:{"type":"getDeliverByID","deliver_id":d_id},
		dataType:'json',
		success:function(returnData){
			deliver_json=returnData;
			items_json=deliver_json.items;
			items_json.flows=null;
			deliver_json.items=null;
			initTable();
		},
		error:function(returnData){
			initdiglog2("提示信息","获取异常");
		}
	});
}
function showDialog(index_tr){
	if(index_tr>0){
		//修改dialog_div
		nowTR=$("tr[index_tr='"+index_tr+"']");
		$("#material_id").val(nowTR.find("td[index_td='material_id']").text().trim());
		$("#material_name").val(nowTR.find("td[index_td='material_name']").text().trim());
		$("#model").val(nowTR.find("td[index_td='model']").text().trim());
		$("#unit").val(nowTR.find("td[index_td='unit']").text().trim());
		$("#num").val(nowTR.find("td[index_td='num']").text().trim());
		$("#quality").val(nowTR.find("td[index_td='quality']").text().trim());
		$("#remark").val(nowTR.find("td[index_td='remark']").text().trim());
		$(".dialog_top").css("display","block");
		$(".dialog_top>span:eq(1)").text(index_tr);
		$(".bottom_btn_group").html('<div class="dialog_cancelbtn"  onclick="closeDialog(0)">取消</div><div class="dialog_addbtn" onclick="closeDialog(2)">确认</div><div class="dialog_delbtn" id="delproduct" onclick="closeDialog(1)">删除</div>');
	}else{
		//添加
		$(".dialog_top").css("display","none");
		$(".bottom_btn_group").html('<div class="dialog_cancelbtn" onclick="closeDialog(0)">取消</div><div class="dialog_addbtn" onclick="closeDialog(2)">确认</div>');
	}
	var dialog=$(".dialog_div");
	var top_val=$(window).scrollTop()+dialog.height()/2+"px";
	dialog.css({"top":top_val,"display":"block"});
	$(".dialog_bg").css("display","block");
}
function closeDialog(index){
	if(index==0){
		//取消
	}else if(index==1){
		//删除
		initdiglogtwo2("提示信息","您确定要删除吗？");
   		$( "#confirm2" ).click(function() {
			$( "#twobtndialog" ).dialog( "close" );
			var item_id=nowTR.attr('item_id');
			if(item_id!=0){
				if(del_ids.length>0){
					del_ids+='の'+item_id;
				}else{
					del_ids=item_id;
				}
			}
			nowTR.remove();
			initTR();
			initDialogVal();
		});
   		return;
		
	}else if(index==2){
		if(nowTR){
			//修改
			var material_id=$("#material_id").val().trim();
			var material_name=$("#material_name").val().trim();
			var model=$("#model").val().trim();
			var unit=$("#unit").val().trim();
			var num=$("#num").val().trim();
			var quality=$("#quality").val().trim();
			var remark=$("#remark").val().trim();
			if(material_id.length<1){
				initdiglog2("提示信息","请输入物料编码");
				return;
			}
			if(material_name.length<1){
				initdiglog2("提示信息","请输入名称");
				return;
			}
			if(model.length<1){
				initdiglog2("提示信息","请输入规格");
				return;
			}
			if(unit.length<1){
				initdiglog2("提示信息","请输入单位");
				return;
			}
			if(num.trim()==""||(num!="0"&&!parseFloat(num))){
				initdiglog2("提示信息","请输入数量");
				return;
			}
			nowTR.find("td[index_td='material_id']").text(material_id);
			nowTR.find("td[index_td='material_name']").text(material_name);
			nowTR.find("td[index_td='model']").text(model);
			nowTR.find("td[index_td='unit']").text(unit);
			nowTR.find("td[index_td='num']").text(num);
			nowTR.find("td[index_td='quality']").text(quality);
			nowTR.find("td[index_td='remark']").text(remark);
		}else{
			//添加
			var material_id=$("#material_id").val().trim();
			var material_name=$("#material_name").val().trim();
			var model=$("#model").val().trim();
			var unit=$("#unit").val().trim();
			var num=$("#num").val().trim();
			var quality=$("#quality").val().trim();
			var remark=$("#remark").val().trim();
			if(material_id.length<1){
				initdiglog2("提示信息","请输入物料编码");
				return;
			}
			if(material_name.length<1){
				initdiglog2("提示信息","请输入名称");
				return;
			}
			if(model.length<1){
				initdiglog2("提示信息","请输入规格");
				return;
			}
			if(unit.length<1){
				initdiglog2("提示信息","请输入单位");
				return;
			}
			if(num.trim()==""||(num!="0"&&!parseFloat(num))){
				initdiglog2("提示信息","请输入数量");
				return;
			}
			var tr_num=$(".materials_tab_content").length+1;
			var temp='<tr class="materials_tab_content" item_id="0" index_tr="'+tr_num+'">'
				+'<td index_td="index" style="width:30px;">'+tr_num+'</td>'
				+'<td index_td="material_id">'+material_id+'</td>'
				+'<td index_td="material_name" >'+material_name+'</td>'
				+'<td index_td="model">'+model+'</td>'
				+'<td index_td="unit">'+unit+'</td>'
				+'<td index_td="num">'+num+'</td>'
				+'<td index_td="quality">'+quality+'</td>'
				+'<td index_td="remark">'+remark+'</td>'
				+'</tr>';
			$(".materials_tab_add").before(temp);
		}
	}
	initTR();
	initDialogVal();
}
function initTR(){
	$(".materials_tab_content").each(function(i){
		$(this).find("td[index_td='index']").text(i+1);
		$(this).attr("index_tr",i+1).css("cursor","pointer").unbind("click").click(function(){
			showDialog(i+1);
		});
	});
}
function initDialogVal(){
	$("#material_id").val("");
	$("#material_name").val("");
	$("#model").val("");
	$("#unit").val("");
	$("#num").val("");
	$("#quality").val("");
	$("#remark").val("");
	nowTR=null;
	$(".dialog_div").css({"display":"none"});
	$(".dialog_bg").css("display","none");
}