$(function(){
	var prices=0;
	var nums=0;
	var last_nums=0;
	var contract_nums=0;
	$(".shipping_tr_content").each(function(){
		var unit_price=parseFloat($(this).find("td[index_td='unit_price']").text().trim());
		var num=parseInt($(this).find("td[index_td='num']").text().trim());
		$(this).find("td[index_td='price']").text(unit_price*num);
		prices+=parseFloat($(this).find("td[index_td='price']").text().trim());
		nums+=num;
		last_nums+=parseInt($(this).find("td[index_td='last_num']").text().trim());
		contract_nums+=parseInt($(this).find("td[index_td='contract_num']").text().trim());
		$(this).click(function(){
			showDialog($(this).attr("index_tr"));
		});
	});
	var temp='<tr id="shipping_tr_sum">'
		+'<td colspan="4"></td>'
		+'<td>合计：</td>'
		+'<td index_td="contract_num" class="tooltip_div">'+contract_nums+'</td>'
		+'<td></td>'
		+'<td index_td="last_num" class="tooltip_div">'+last_nums+'</td>'
		+'<td index_td="num" class="tooltip_div">'+nums+'</td>'
		+'<td index_td="price" class="tooltip_div">'+prices+'</td>'
		+'<td colspan="2"></td>'
		+'</tr>';
	$(".shipping_tab").append(temp);
	showToolTip($("#shipping_tr_sum"));
	$("body").append('<div class="dialog_shipping_bg"></div>');
	setState();
});
function showDialog(index){
	var nowTR=$("tr[index_tr='"+index+"']");
	$("#order").text(nowTR.find("td[index_td='index']").text().trim());
	$("#materials_id").text(nowTR.find("td[index_td='materials_id']").text().trim());
	$("#name").text(nowTR.find("td[index_td='name']").text().trim());
	$("#model").text(nowTR.find("td[index_td='model']").text().trim());
	$("#unit").text(nowTR.find("td[index_td='unit']").text().trim());
	$("#contract_num").text(nowTR.find("td[index_td='contract_num']").text().trim());
	$("#unit_price").text(nowTR.find("td[index_td='unit_price']").text().trim());
	$("#last_num").text(nowTR.find("td[index_td='last_num']").text().trim());
	$("#num").text(nowTR.find("td[index_td='num']").text().trim());
	$("#price").text(nowTR.find("td[index_td='price']").text().trim());
	$("#quality_no").text(nowTR.find("td[index_td='quality_no']").text().trim());
	$("#remark").text(nowTR.find("td[index_td='remark']").text().trim());
	$("#logistics_demand").val(nowTR.find("td[index_td='logistics_demand']").text().trim());
	var top_val=$(window).scrollTop()+150+"px";
	$(".dialog_shipping_bg").css("display","block");
	$(".dialog_shipping").css({"top":top_val,"display":"block"});
}
function closeDialog(){
	$(".dialog_shipping_bg").css("display","none");
	$(".dialog_shipping").css("display","none");
}
function verifyFlow(flag){
	var reason=$("#reason").val().trim();
	if(!reason.length>0){
		initdiglog2("提示信息","请输入意见或建议");
		return;
	}
	document.flowform.type.value="shipping";
	document.flowform.isagree.value=flag;
	document.flowform.reason.value=reason;
	document.flowform.submit();
}
function cancleTask(){
	var reason=$("#reason").val().trim();
	if(!reason.length>0){
		initdiglog2("提示信息","请输入意见或建议");
		return;
	}
	document.flowform.type.value="delShipping";
	document.flowform.reason.value=reason;
	document.flowform.submit();
}
//领料完成
function finishedMaterials(){
	document.flowform.submit();
}
//执行发货
function doShipping(){
	document.flowform.submit();
}
//信息反馈
function finishedShipping(){
	var ship_time=$("#ship_time").val().trim();
	var logistics_num=$("#logistics_num").val().trim();
	var logistics_company=$("#logistics_company").val().trim();
	var orderId=$("#orderId").val().trim();
	if(ship_time.length<1){
		initdiglog2("提示信息","请输入实际发货时间");
		return;
	}
	if(logistics_num.length<1||(parseInt(logistics_num)==0)){
		initdiglog2("提示信息","请输入件数");
		return;
	}
	if(logistics_company.length<1){
		initdiglog2("提示信息","请输入物流公司");
		return;
	}
	if(orderId.length<1){
		initdiglog2("提示信息","请输入物流单号");
		return;
	}
	document.flowform.ship_time.value=timeTransStrToLong2(ship_time);
	document.flowform.logistics_num.value=logistics_num;
	document.flowform.logistics_company.value=logistics_company;
	document.flowform.orderId.value=orderId;
	document.flowform.submit();
}
function setState(){
	if(deling){
		//撤销
		if(operation==1){
			$("#state").text("撤销中");
		}else{
			$("#state").text("已撤销");
		}
	}else{
		if(operation==1){
			$("#state").text("审批中");
		}else if(operation==2){
			$("#state").text("已批复");
		}else if(operation==3){
			$("#state").text("被拒");
		}else if(operation==4){
			$("#state").text("领料完成");
		}else if(operation==5){
			$("#state").text("已发货");
		}else{
			$("#state").text("执行完毕");
		}
	}
}
/***
 * 显示审批
 */
function showApprove(){
	if(now_show){
		$(".hide-btn span").text("显示审批");
		$(".hide-btn img").attr("src","images/show_check.png");
	}else{
		$(".hide-btn span").text("隐藏审批");
		$(".hide-btn img").attr("src","images/hide_check.png");
	}
	now_show=!now_show;
	$(".td2_table3").toggle();
}