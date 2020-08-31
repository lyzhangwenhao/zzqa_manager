/****
 * 提取供应商下信息
 * @param supplier
 */
function setSupplier(company_name){
	if(checkMOXA(company_name)){
		$(".td2_div4").css("display","none");
	}else{
		$(".td2_div4").css("display","block");
		useFile(false,true);
	}
	$.ajax({
		type:"post",//post方法
		url:"ContractManagerServlet",
		data:{"type":"getCustomerByCName","company_name":company_name,"customer_type":2},
		timeout : 15000, 
		dataType:'json',
		success:function(returnData){
			if(returnData!=null){
				$(".td2_div9>div:eq(1) .td2_div9_name input").val(returnData.company_name);
				$(".td2_div9>div:eq(1) .td2_div9_address input").val(returnData.company_address);
				$(".td2_div9>div:eq(1) .td2_div9_postalcode input").val(returnData.postal_code);
				$(".td2_div9>div:eq(1) .td2_div9_person input:eq(0)").val(returnData.law_person);
				$(".td2_div9>div:eq(1) .td2_div9_person input:eq(1)").val(returnData.entrusted_agent);
				$(".td2_div9>div:eq(1) .td2_div9_phone input:eq(0)").val(returnData.phone);
				$(".td2_div9>div:eq(1) .td2_div9_phone input:eq(1)").val(returnData.fax);
				$(".td2_div9>div:eq(1) .td2_div9_bank input:eq(0)").val(returnData.bank);
				$(".td2_div9>div:eq(1) .td2_div9_accoun input:eq(0)").val(returnData.company_account);
				$(".td2_div9>div:eq(1) .td2_div9_tariffitem input:eq(0)").val(returnData.tariff_item);
			}else{
				initdiglog2("提示信息","提取供应商信息失败，请请刷新页面重试！");
				$("#cname_input6").val("");
				$("#bts-ex-6 li.selected").attr("class","filter-item items");
				$("#bts-ex-6 span.text").text("选择供应商");
				$("#cname_input").val("");
				$("#bts-ex-4 li.selected").attr("class","filter-item items");
				$("#bts-ex-4 span.text").text("选择供应商");
			}					
		},
		complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
			if(status!='success'){//超时,status还有success,error等值的情况
				if(status=='timeout'){
					initdiglog2("提示信息","请求超时！");
				}else{
					initdiglog2("提示信息","操作异常,请重试！");
				}
				$("#cname_input6").val("");
				$("#bts-ex-6 li.selected").attr("class","filter-item items");
				$("#bts-ex-6 span.text").text("选择供应商");
				$("#cname_input").val("");
				$("#bts-ex-4 li.selected").attr("class","filter-item items");
				$("#bts-ex-4 span.text").text("选择供应商");
			}
		}
	});
}
//检查是否重复
function checkContract_no(foreign_id){
	if($("input[name='contract_no']").val().trim().length==0){
		initdiglog2("提示信息","请输入合同编号");
		return;
	}
	$.ajax({
		type:"post",//post方法
		url:"ContractManagerServlet",
		data:{"type":"checkContract_no","contract_no":$("input[name='contract_no']").val(),"foreign_id":foreign_id,contract_type:2},
		timeout : 15000, 
		dataType:'json',
		success:function(returnData){
			if(returnData==1){
				addFlow();
			}else{
				initdiglogtwo2("提示信息","你的合同编号有重复,是否还要继续？");
		   		$( "#confirm2" ).click(function() {
		   			$( "#twobtndialog" ).dialog( "close" );
		   			addFlow();
		   		});
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
function initTR(flag){
	var index=0;
	if(flag==1){
		$("#apply_tab tr:gt(0)").each(function(){
			if(index++%2==0){
				$(this).attr("class","product_tr2");
			}else{
				$(this).attr("class","product_tr3");
			}
			$(this).children("td:eq(0)").text(index);
			$(this).unbind("click").click(function(){
				showApplyDialog($(this));
			});
		});
	}else if(flag==2){
		$("#apply_tab2 tr:gt(0)").each(function(){
			if(index++%2==0){
				$(this).attr("class","product_tr2");
			}else{
				$(this).attr("class","product_tr3");
			}
			$(this).children("td:eq(0)").text(index);
			$(this).unbind("click").click(function(){
				showApplyDialog2($(this));
			});
			if($(this).children("td:eq(9)").text().trim().length>0){
				var num=parseInt($(this).children("td:eq(7)").text().trim());
				var unit_price_taxes=parseFloat($(this).children("td:eq(9)").text().trim());
				var unit_price=unit_price_taxes/1.17;
				var price_taxes=unit_price_taxes*num;
				var price=price_taxes/1.17; 
				$(this).children("td:eq(12)").text(Math.round(unit_price*100)/100);
				$(this).children("td:eq(13)").text(Math.round(price_taxes*100)/100);
				$(this).children("td:eq(14)").text(Math.round(price*100)/100);
			}
		});
	}else if(flag==3){
		$("#apply_tab2 tr:gt(0)").each(function(){
			if(index++%2==0){
				$(this).attr("class","product_tr2");
			}else{
				$(this).attr("class","product_tr3");
			}
			$(this).children("td:eq(0)").text(index);
			$(this).unbind("click").click(function(){
				var noteid=$(this).attr("id");
				var note_id=noteid?parseInt(noteid):0;//等于0 可修改
				showApplyDialog3($(this),note_id==0);
			});
			var num=parseInt($(this).children("td:eq(7)").text().trim());
			var unit_price_taxes=parseFloat($(this).children("td:eq(9)").text().trim());
			var unit_price=unit_price_taxes/1.17;
			var price_taxes=unit_price_taxes*num;
			var price=price_taxes/1.17; 
			$(this).children("td:eq(12)").text(Math.round(unit_price*100)/100);
			$(this).children("td:eq(13)").text(Math.round(price_taxes*100)/100);
			$(this).children("td:eq(14)").text(Math.round(price*100)/100);
		});
	}else if(flag==4){
		$("#purchase_tab tr:gt(0)").each(function(){
			if(index++%2==0){
				$(this).attr("class","product_tr2");
			}else{
				$(this).attr("class","product_tr3");
			}
			$(this).children("td:eq(0)").text(index);
			$(this).unbind("click").click(function(){
				showPurchaseDialog($(this));
			});
			var num=parseInt($(this).children("td:eq(4)").text().trim());
			var unit_price_taxes=parseFloat($(this).children("td:eq(6)").text().trim());
			var unit_price=unit_price_taxes/1.17;
			var price_taxes=unit_price_taxes*num;
			var price=price_taxes/1.17; 
			$(this).children("td:eq(9)").text(Math.round(unit_price*100)/100);
			$(this).children("td:eq(10)").text(Math.round(price_taxes*100)/100);
			$(this).children("td:eq(11)").text(Math.round(price*100)/100);
		});
	}else if(flag==5){
		$("#purchase_tab tr:gt(0)").each(function(){
			if(index++%2==0){
				$(this).attr("class","product_tr2");
			}else{
				$(this).attr("class","product_tr3");
			}
			$(this).children("td:eq(0)").text(index);
			$(this).unbind("click").click(function(){
				showPurchaseDialog2($(this));
			});
			var num=parseInt($(this).children("td:eq(4)").text().trim());
			var unit_price_taxes=parseFloat($(this).children("td:eq(6)").text().trim());
			var unit_price=unit_price_taxes/1.17;
			var price_taxes=unit_price_taxes*num;
			var price=price_taxes/1.17; 
			$(this).children("td:eq(9)").text(Math.round(unit_price*100)/100);
			$(this).children("td:eq(10)").text(Math.round(price_taxes*100)/100);
			$(this).children("td:eq(11)").text(Math.round(price*100)/100);
		});
	}else{
		$("#apply_tab2 tr:gt(0)").each(function(){
			if(index++%2==0){
				$(this).attr("class","product_tr2");
			}else{
				$(this).attr("class","product_tr3");
			}
			$(this).children("td:eq(0)").text(index);
			$(this).unbind("click").click(function(){
				showApplyDialog4($(this));
			});
			if($(this).children("td:eq(9)").text().trim().length>0){
				var num=parseInt($(this).children("td:eq(7)").text().trim());
				var unit_price_taxes=parseFloat($(this).children("td:eq(9)").text().trim());
				var unit_price=unit_price_taxes/1.17;
				var price_taxes=unit_price_taxes*num;
				var price=price_taxes/1.17; 
				$(this).children("td:eq(12)").text(Math.round(unit_price*100)/100);
				$(this).children("td:eq(13)").text(Math.round(price_taxes*100)/100);
				$(this).children("td:eq(14)").text(Math.round(price*100)/100);
			}
		});
	}
}
function initDialogVal(flag){
	if(flag==1){
		$("#dialog_apply input").val("");
	}else if(flag==2){
		//清空下拉选择框
		$("#bts-ex-8 li.selected").attr("class","filter-item items");
		$("#sales_contractno").val("");
		$("#bts-ex-8 span.text").text("选择销售合同");
		$("#bts-ex-5 li.selected").attr("class","filter-item items");
		$("#mid_input").val("");
		$("#bts-ex-5 span.text").text("选择型号");
		$("#dialog_apply2").find(".product_div:eq(2) input").val("");
		$("#dialog_apply2").find(".product_div:eq(3) input").val("");
		$("#dialog_apply2").find(".product_div:eq(4) input").val("");
		$("#dialog_apply2").find(".product_div:eq(5) input").val(today);
		$("#dialog_apply2").find(".product_div:eq(6) textarea").val("");
	}else if(flag==3){
		if(checkAog){
			$("#aog_time").val("");
			$("#aog_num").val("");
		}
	}else if(flag==4){
		$("#dialog_purchase").find(".product_div:eq(1) input").val("")
		$("#dialog_purchase").find(".product_div:eq(2) input").val("")
		$("#dialog_purchase").find(".product_div:eq(3) input").val("")
		$("#dialog_purchase").find(".product_div:eq(4) input").val(today)
		$("#dialog_purchase").find(".product_div:eq(5) textarea").val("")
		//清空下拉选择框
		$("#bts-ex-5 li.selected").attr("class","filter-item items");
		$("#mid_input").val("");
		$("#bts-ex-5 span.text").text("选择型号");
	}else if(flag==5){
		
	}else{
		//清空下拉选择框
		$("#bts-ex-8 li.selected").attr("class","filter-item items");
		$("#sales_contractno").val("");
		$("#bts-ex-8 span.text").text("选择销售合同");
		$("#bts-ex-5 li.selected").attr("class","filter-item items");
		$("#mid_input").val("");
		$("#bts-ex-5 span.text").text("选择型号");
		$("#dialog_apply4").find(".product_div:eq(2) input").val("");
		$("#dialog_apply4").find(".product_div:eq(3) input").val("");
		$("#dialog_apply4").find(".product_div:eq(4) input").val("");
		$("#dialog_apply4").find(".product_div:eq(5) input").val(today);
		$("#dialog_apply4").find(".product_div:eq(6) textarea").val("");
	}
	$(".dialog_product_bg").css("display","none");
	$(".dialog_product").css("display","none");
}
//由div触发checkbox
/****
 * direct    true：直接选中；其他：取反
 */
function useFile(usefile,direct){
	if(direct){
		$("#checkbox10").prop("checked",usefile);
		$("#checkbox11").prop("checked",!usefile);
	}else{
		var flag=$("#checkbox10").prop("checked");
		$("#checkbox10").prop("checked",!flag);
		$("#checkbox11").prop("checked",flag);
	}
}
//由label触发checkbox
function useFileChange(usefile){
	if(usefile){//点击是
		var flag=$("#checkbox10").prop("checked");
		$("#checkbox10").prop("checked",flag);
		$("#checkbox11").prop("checked",!flag);
	}else{//点击否
		var flag=$("#checkbox11").prop("checked");
		$("#checkbox10").prop("checked",!flag);
		$("#checkbox11").prop("checked",flag);
	}
}
function getMaterialsByID(id){
	for(var i=0;i<materialsArray.length;i++){
		if(materialsArray[i][0]==id){
			return materialsArray[i];
		}
	}
	return new Array();
}
function getMaterialsByModel(model){
	for(var i=0;i<materialsArray.length;i++){
		if(materialsArray[i][2]==model){
			return materialsArray[i];
		}
	}
	return new Array();
}
function getContractArrayByContractIndex(contractno_index){
	return salesArray[parseInt(contractno_index)];
}
function getContractArrayBySalesID(salesID){
	for(var i=0;i<salesArray.length;i++){
		if(salesArray[i][0]==salesID){
			return salesArray[i];
		}
	}
	return new Array();
}
/***
 * 设置合同状态 [待批复，已批复，被拒,撤销中,已入库]
 * @param opera 流程
 */
function setContractState(isDeling,opera,applyFinished){
	if(opera==10){
		$(".div2_time").children("div:last-child").text("已入库");
	}else if(isDeling){
		if(opera==11){
			$(".div2_time").children("div:last-child").text("已撤销");
		}else{
			$(".div2_time").children("div:last-child").text("撤销中");
		}
	}else{
		if(applyFinished){
			$(".div2_time").children("div:last-child").text("已批复");
		}else if(opera==3||opera==5||opera==7||opera==9){
			$(".div2_time").children("div:last-child").text("被拒");
		}else{
			$(".div2_time").children("div:last-child").text("待批复");
		}
	}
}
//通过供应商来判断  MOXA的定义就是MOXA厂家： 摩莎科技（上海）有限公司
function checkMOXA(supplier_name){
	return "摩莎科技（上海）有限公司"==supplier_name;
}
/****
 * 检查采购单中的销售合同是否关联主料，主料被全部删除，对应的辅料也要被删除
 */
function checkSalesContract(){
	var selected_salesID="の";
	$("#apply_tab2 tr:gt(0)").each(function(){
		if($(this).attr("product_id")!=0){
			selected_salesID+=$(this).attr("sales_id")+"の";
		}
	});
	$("#bts-ex-8 li.filter-item").each(function(){
		var sales_id=$(this).attr("data-value");
		if(selected_salesID.indexOf("の"+sales_id+"の")==-1){
			//该合同已不存在
			$(this).remove();
			$("tr[sales_id='"+sales_id+"']").remove();
		}
	});
}
function showApplyDialog(jq_tr){
	$("#tooltip_div").remove();
	var tab=$("#dialog_apply");
	var top_val=$(window).scrollTop()+150+"px";
	tab.css("top",top_val);
	nowTR=jq_tr;
	//详情
	var index=jq_tr.children("td:eq(0)").text().trim();//序号
	if(tab.find(".product_top").length==0){
		tab.prepend('<div class="product_top"><span>序号：</span><span>'+index+'</span></div>');
	}else{
		tab.find(".product_top span:eq(1)").text(index);
	}
	tab.find(".product_div:eq(0) div").text(jq_tr.children("td:eq(1)").text().trim());
	tab.find(".product_div:eq(1) div").text(jq_tr.children("td:eq(2)").text().trim());
	tab.find(".product_div:eq(2) div").text(jq_tr.children("td:eq(3)").text().trim());
	tab.find(".product_div:eq(3) div").text(jq_tr.children("td:eq(4)").text().trim());
	tab.find(".product_div:eq(4) div").text(jq_tr.children("td:eq(5)").text().trim());
	tab.find(".product_div:eq(5) div").text(jq_tr.children("td:eq(6)").text().trim());
	tab.find(".product_div:eq(6) div").text(jq_tr.children("td:eq(7)").text().trim());
	tab.find(".product_div:eq(7) div").text(jq_tr.children("td:eq(8)").text().trim());
	tab.find(".product_bottom").html('<img src="images/cancle_materials.png" onclick="closeApplyDialog(0)"><img src="images/submit_materials.png" onclick="closeApplyDialog(2)">');
	tab.find(".product_div:eq(8) input").val(jq_tr.children("td:eq(9)").text().trim());
	if($(".dialog_product_bg").length==0){
		$("body").append('<div class="dialog_product_bg"></div>');
	}
	$(".dialog_product_bg").css("display","block");
	tab.css("display","block");
}
function closeApplyDialog(btn_id){
	if(btn_id==2){
		//修改
		var num=$("#dialog_apply").find(".product_div:eq(8) input").val();
		if(parseInt(num)>=0){
			nowTR.children("td:eq(9)").text(num);
		}else{
			initdiglog2("提示信息","请输入本次采购数量，若不采购请输入0");
			return;
		}
	}
	initDialogVal(1);
}
/*****
 * 正常采购单
 * @param jq_tr
 */
function showApplyDialog2(jq_tr){
	$("#tooltip_div").remove();
	var tab=$("#dialog_apply2");
	var top_val=$(window).scrollTop()+150+"px";
	tab.css("top",top_val);
	nowTR=jq_tr;
	if(jq_tr==null){
		//添加
		tab.find(".product_top").remove();
		$(".dislog_cover").css("display","none");
		tab.find(".product_div:lt(4)").each(function(){
			$(this).find("span:eq(0)").css("color","#70CFF9");
		});
	}else{
		//详情
		var index=jq_tr.children("td:eq(0)").text().trim();//序号
		if(tab.find(".product_top").length==0){
			tab.prepend('<div class="product_top"><span>序号：</span><span>'+index+'</span></div>');
		}else{
			tab.find(".product_top span:eq(1)").text(index);
		}
		var sales_id=jq_tr.attr("sales_id");
		var contract_no=jq_tr.find("td:eq(1)").text().trim();
		var materials_model=jq_tr.find("td:eq(5)").text().trim();
		var num=jq_tr.find("td:eq(7)").text().trim();
		var predict_costing_taxes=jq_tr.find("td:eq(8)").text().trim();
		var unit_price_taxes=jq_tr.find("td:eq(9)").text().trim();
		var sign_date=jq_tr.find("td:eq(10)").text().trim();
		var remark=jq_tr.find("td:eq(11)").text().trim();
		var modelArray=getMaterialsByModel(materials_model);
		$("#bts-ex-5 li[data-value='"+modelArray[0]+"']").click();
		$("#bts-ex-8 li[data-value='"+sales_id+"']").click();
		tab.find(".product_div:eq(2) input").val(num);
		tab.find(".product_div:eq(3) input").val(predict_costing_taxes);
		tab.find(".product_div:eq(4) input").val(unit_price_taxes);
		tab.find(".product_div:eq(5) input").val(sign_date.length>0?sign_date:today);
		tab.find(".product_div:eq(6) textarea").val(remark);
		var product_id=nowTR.attr("product_id")?parseInt(nowTR.attr("product_id")):0;
		if(product_id==0){//物料
			$(".dislog_cover").css("display","none");
			tab.find(".product_div:lt(4)").each(function(){
				$(this).find("span:eq(0)").css("color","#70CFF9");
			});
			tab.find(".product_bottom").html('<img src="images/cancle_materials.png" onclick="closeApplyDialog2(0)"><img src="images/submit_materials.png" onclick="closeApplyDialog2(2)"><img src="images/del_materials.png" id="delnote" onclick="closeApplyDialog2(1)">');
		}else{
			$(".dislog_cover").css("display","block");
			$(".dislog_cover").unbind("click").click(function(){
				initdiglog2("提示信息","系统自动获取，不可修改");
			});
			tab.find(".product_div:lt(4)").each(function(){
				$(this).find("span:eq(0)").css("color","#f00");
			});
			tab.find(".product_bottom").html('<img src="images/cancle_materials.png" onclick="closeApplyDialog2(0)"><img src="images/submit_materials.png" onclick="closeApplyDialog2(2)">');
		}
	}
	if($(".dialog_product_bg").length==0){
		$("body").append('<div class="dialog_product_bg"></div>');
	}
	$(".dialog_product_bg").css("display","block");
	tab.css("display","block");
}
function closeApplyDialog2(btn_id){
	if(btn_id==1){
		//删除
		initdiglogtwo2("提示信息","你确定要删除该辅料信息吗？");
   		$( "#confirm2" ).click(function() {
			$( "#twobtndialog" ).dialog( "close" );
			nowTR.remove();
			initTR(2);
			initDialogVal(2);
		});
   		return;
	}else if(btn_id==2){
		var salesID=$("#sales_contractno").val();
		var contractArray=getContractArrayBySalesID(salesID);
		var mArray=getMaterialsByID($("#mid_input").val());
		var num=$("#dialog_apply2").find(".product_div:eq(2) input").val();
		var predict_costing_taxes=$("#dialog_apply2").find(".product_div:eq(3) input").val();
		var unit_price_taxes=$("#dialog_apply2").find(".product_div:eq(4) input").val();
		var delivery_date=$("#dialog_apply2").find(".product_div:eq(5) input").val();
		var remark=$("#dialog_apply2").find(".product_div:eq(6) textarea").val();
		if(contractArray.length==0){
			initdiglog2("提示信息","请选择销售合同");
			return;
		}
		if(mArray.length==0){
			initdiglog2("提示信息","请选择型号");
			return;
		}
		if(num.length==0||(num=parseInt(num))==0){
			initdiglog2("提示信息","请输入数量");
			return;
		}
		if(predict_costing_taxes.length==0||(predict_costing_taxes=parseFloat(predict_costing_taxes))==0){
			initdiglog2("提示信息","请输入预计含税成本");
			return;
		}
		if(unit_price_taxes.length==0||(unit_price_taxes=parseFloat(unit_price_taxes))==0){
			initdiglog2("提示信息","请输入含税单价");
			return;
		}
		if(delivery_date.length==0){
			initdiglog2("提示信息","请选择交货期");
			return;
		}
		if(remark.replace(/\s/g,"").length==0){
			initdiglog2("提示信息","请输入备注");
			return;
		}
		if(nowTR==null){
			//增加
			var temp='<tr  sales_id="'+contractArray[0]+'" product_id="0" >'
				+'<td style="width:30px;"></td>'
				+'<td class="tooltip_div">'+contractArray[1]+'</td>'
				+'<td class="tooltip_div">'+contractArray[3]+'</td>'
				+'<td class="tooltip_div">'+contractArray[2]+'</td>'
				+'<td class="tooltip_div">'+mArray[1]+'</td>'
				+'<td id="'+mArray[0]+'" class="tooltip_div">'+mArray[2]+'</td>'
				+'<td class="tooltip_div">'+mArray[3]+'</td>'
				+'<td class="tooltip_div" style="width:60px">'+num+'</td>'
				+'<td class="tooltip_div">'+predict_costing_taxes+'</td>'
				+'<td class="tooltip_div">'+unit_price_taxes+'</td>'
				+'<td>'+delivery_date+'</td>'
				+'<td class="tooltip_div">'+remark+'</td>'
				+'<td class="tooltip_div"></td>'
				+'<td class="tooltip_div"></td>'
				+'	<td class="tooltip_div"></td></tr>';
			$("#apply_tab2").append(temp);
			showToolTip($("#apply_tab2").find("tr:last"));
		}else{
			//修改
			if(nowTR.attr("product_id")==0){
				nowTR.find("td:eq(1)").text(contractArray[1]);
				nowTR.find("td:eq(2)").text(contractArray[3]);
				nowTR.find("td:eq(3)").text(contractArray[2]);
				nowTR.find("td:eq(4)").text(mArray[1]);
				nowTR.find("td:eq(5)").text(mArray[2]);
				nowTR.find("td:eq(5)").attr("id",mArray[0]);
				nowTR.find("td:eq(6)").text(mArray[3]);
				nowTR.find("td:eq(8)").text(predict_costing_taxes);
			}
			nowTR.find("td:eq(9)").text(unit_price_taxes);
			nowTR.find("td:eq(10)").text(delivery_date);
			nowTR.find("td:eq(11)").text(remark);
		}
		initTR(2);
	}
	initDialogVal(2);
}
/*****
 * 正常采购单 详情
 * @param jq_tr
 */
function showApplyDialog3(jq_tr){
	$("#tooltip_div").remove();
	var tab=$("#dialog_apply3");
	var top_val=$(window).scrollTop()+150+"px";
	tab.css("top",top_val);
	nowTR=jq_tr;
	var index=jq_tr.children("td:eq(0)").text().trim();//序号
	if(tab.find(".product_top").length==0){
		tab.prepend('<div class="product_top"><span>序号：</span><span>'+index+'</span></div>');
	}else{
		tab.find(".product_top span:eq(1)").text(index);
	}
	var contract_no=jq_tr.find("td:eq(1)").text().trim();
	var materials_model=jq_tr.find("td:eq(5)").text().trim();
	var num=jq_tr.find("td:eq(7)").text().trim();
	var predict_costing_taxes=jq_tr.find("td:eq(8)").text().trim();
	var unit_price_taxes=jq_tr.find("td:eq(9)").text().trim();
	var sign_date=jq_tr.find("td:eq(10)").text().trim();
	var remark=jq_tr.find("td:eq(11)").text().trim();
	tab.find(".product_div:eq(0) div").text(contract_no);
	tab.find(".product_div:eq(1) div").text(materials_model);
	tab.find(".product_div:eq(2) div").text(num);
	tab.find(".product_div:eq(3) div").text(predict_costing_taxes);
	tab.find(".product_div:eq(4) div").text(unit_price_taxes);
	tab.find(".product_div:eq(5) div").text(sign_date);
	tab.find(".product_div:eq(6) textarea").val(remark);
	if(showBuyInfo){
		//显示到货
		if(checkAog){
			$("#aog_time").val(jq_tr.find("td.aog_date").text().trim());
			$("#aog_num").val(jq_tr.find("td.aog_num").text().trim());
		}else{
			$("#aog_time").text(jq_tr.find("td.aog_date").text().trim());
			$("#aog_num").text(jq_tr.find("td.aog_num").text().trim());
		}
	}
	if($(".dialog_product_bg").length==0){
		$("body").append('<div class="dialog_product_bg"></div>');
	}
	$(".dialog_product_bg").css("display","block");
	tab.css("display","block");
}
function closeApplyDialog3(btn_id){
	if(btn_id==2){
		if(checkAog){
			var num=$("#aog_num").val();
			if(num==0){
				initdiglog2("提示信息","实际入库数量不能为空");
				return;
			}
			nowTR.find("td.aog_date").text($("#aog_time").val());
			nowTR.find("td.aog_num").text($("#aog_num").val());
			checkCover();
		}
	}
	initDialogVal(3);
}
/*****
 * 修改合同
 * @param jq_tr
 */
function showApplyDialog4(jq_tr){
	$("#tooltip_div").remove();
	var tab=$("#dialog_apply4");
	var top_val=$(window).scrollTop()+150+"px";
	tab.css("top",top_val);
	nowTR=jq_tr;
	if(jq_tr==null){
		//添加
		tab.find(".product_top").remove();
		$(".dislog_cover").css("display","none");
		tab.find(".product_div:lt(4)").each(function(){
			$(this).find("span:eq(0)").css("color","#70CFF9");
		});
		tab.find(".product_bottom").html('<img src="images/cancle_materials.png" onclick="closeApplyDialog4(0)"><img src="images/submit_materials.png" onclick="closeApplyDialog4(2)">');
	}else{
		//详情
		var index=jq_tr.children("td:eq(0)").text().trim();//序号
		if(tab.find(".product_top").length==0){
			tab.prepend('<div class="product_top"><span>序号：</span><span>'+index+'</span></div>');
		}else{
			tab.find(".product_top span:eq(1)").text(index);
		}
		var sales_id=jq_tr.attr("sales_id");
		var materials_model=jq_tr.find("td:eq(5)").text().trim();
		var num=jq_tr.find("td:eq(7)").text().trim();
		var predict_costing_taxes=jq_tr.find("td:eq(8)").text().trim();
		var unit_price_taxes=jq_tr.find("td:eq(9)").text().trim();
		var sign_date=jq_tr.find("td:eq(10)").text().trim();
		var remark=jq_tr.find("td:eq(11)").text().trim();
		var modelArray=getMaterialsByModel(materials_model);
		$("#bts-ex-5 li[data-value='"+modelArray[0]+"']").click();
		$("#bts-ex-8 li[data-value='"+sales_id+"']").click();
		tab.find(".product_div:eq(2) input").val(predict_costing_taxes);
		tab.find(".product_div:eq(3) input").val(num);
		tab.find(".product_div:eq(4) input").val(unit_price_taxes);
		tab.find(".product_div:eq(5) input").val(sign_date.length>0?sign_date:today);
		tab.find(".product_div:eq(6) textarea").val(remark);
		var product_id=nowTR.attr("product_id")?parseInt(nowTR.attr("product_id")):0;
		if(product_id==0){//物料
			$(".dislog_cover").css("display","none");
			tab.find(".product_div:lt(3)").each(function(){
				$(this).find("span:eq(0)").css("color","#70CFF9");
			});
			tab.find(".product_bottom").html('<img src="images/cancle_materials.png" onclick="closeApplyDialog4(0)"><img src="images/submit_materials.png" onclick="closeApplyDialog4(2)"><img src="images/del_materials.png" id="delnote" onclick="closeApplyDialog4(1)">');
		}else{
			$(".dislog_cover").css({"display":"block","height":"125px"});
			$(".dislog_cover").unbind("click").click(function(){
				initdiglog2("提示信息","系统自动获取，不可修改");
			});
			tab.find(".product_div:lt(3)").each(function(){
				$(this).find("span:eq(0)").css("color","#f00");
			});
			tab.find(".product_bottom").html('<img src="images/cancle_materials.png" onclick="closeApplyDialog4(0)"><img src="images/submit_materials.png" onclick="closeApplyDialog4(2)"><img src="images/del_materials.png" id="delnote" onclick="closeApplyDialog4(1)">');
		}
	}
	if($(".dialog_product_bg").length==0){
		$("body").append('<div class="dialog_product_bg"></div>');
	}
	$(".dialog_product_bg").css("display","block");
	tab.css("display","block");
}
/****
 * 修改采购合同
 */
function closeApplyDialog4(btn_id){
	if(btn_id==1){
		//删除
		if(nowTR.attr("product_id")==0){
			initdiglogtwo2("提示信息","你确定要删除该辅料信息吗？");
	   		$( "#confirm2" ).click(function() {
				$( "#twobtndialog" ).dialog( "close" );
				nowTR.remove();
				initTR(6);
				initDialogVal(6);
			});
		}else{
			initdiglogtwo2("提示信息","你确定要删除该产品信息吗，若同一销售合同绑定的产品信息都被删除，绑定该销售合同的辅料也将被同步删除，是否继续？");
	   		$( "#confirm2" ).click(function() {
				$( "#twobtndialog" ).dialog( "close" );
				nowTR.remove();
				checkSalesContract();
				initTR(6);
				initDialogVal(6);
			});
		}
   		return;
	}else if(btn_id==2){
		var salesID=$("#sales_contractno").val();
		var contractArray=getContractArrayBySalesID(salesID);
		var mArray=getMaterialsByID($("#mid_input").val());
		var predict_costing_taxes=$("#dialog_apply4").find(".product_div:eq(2) input").val();
		var num=$("#dialog_apply4").find(".product_div:eq(3) input").val();
		var unit_price_taxes=$("#dialog_apply4").find(".product_div:eq(4) input").val();
		var delivery_date=$("#dialog_apply4").find(".product_div:eq(5) input").val();
		var remark=$("#dialog_apply4").find(".product_div:eq(6) textarea").val();
		if(contractArray.length==0){
			initdiglog2("提示信息","请选择销售合同");
			return;
		}
		if(mArray.length==0){
			initdiglog2("提示信息","请选择型号");
			return;
		}
		if(num.length==0||(num=parseInt(num))==0){
			initdiglog2("提示信息","请输入数量");
			return;
		}
		if(predict_costing_taxes.length==0||(predict_costing_taxes=parseFloat(predict_costing_taxes))==0){
			initdiglog2("提示信息","请输入预计含税成本");
			return;
		}
		if(unit_price_taxes.length==0||(unit_price_taxes=parseFloat(unit_price_taxes))==0){
			initdiglog2("提示信息","请输入含税单价");
			return;
		}
		if(delivery_date.length==0){
			initdiglog2("提示信息","请选择交货期");
			return;
		}
		if(remark.replace(/\s/g,"").length==0){
			initdiglog2("提示信息","请输入备注");
			return;
		}
		if(nowTR==null){
			//增加
			var temp='<tr  sales_id="'+contractArray[0]+'" product_id="0" note_id="0">'
				+'<td style="width:30px;"></td>'
				+'<td class="tooltip_div">'+contractArray[1]+'</td>'
				+'<td class="tooltip_div">'+contractArray[3]+'</td>'
				+'<td class="tooltip_div">'+contractArray[2]+'</td>'
				+'<td class="tooltip_div">'+mArray[1]+'</td>'
				+'<td id="'+mArray[0]+'" class="tooltip_div">'+mArray[2]+'</td>'
				+'<td class="tooltip_div">'+mArray[3]+'</td>'
				+'<td class="tooltip_div" style="width:60px">'+num+'</td>'
				+'<td class="tooltip_div">'+predict_costing_taxes+'</td>'
				+'<td class="tooltip_div">'+unit_price_taxes+'</td>'
				+'<td>'+delivery_date+'</td>'
				+'<td class="tooltip_div">'+remark+'</td>'
				+'<td class="tooltip_div"></td>'
				+'<td class="tooltip_div"></td>'
				+'	<td class="tooltip_div"></td></tr>';
			$("#apply_tab2").append(temp);
			showToolTip($("#apply_tab2").find("tr:last"));
		}else{
			//修改
			if(nowTR.attr("product_id")==0){
				nowTR.find("td:eq(1)").text(contractArray[1]);
				nowTR.find("td:eq(2)").text(contractArray[3]);
				nowTR.find("td:eq(3)").text(contractArray[2]);
				nowTR.find("td:eq(4)").text(mArray[1]);
				nowTR.find("td:eq(5)").text(mArray[2]);
				nowTR.find("td:eq(5)").attr("id",mArray[0]);
				nowTR.find("td:eq(6)").text(mArray[3]);
				nowTR.find("td:eq(8)").text(predict_costing_taxes);
			}
			nowTR.find("td:eq(7)").text(num);
			nowTR.find("td:eq(9)").text(unit_price_taxes);
			nowTR.find("td:eq(10)").text(delivery_date);
			nowTR.find("td:eq(11)").text(remark);
		}
		initTR(6);
	}
	initDialogVal(6);
}
function showPurchaseDialog(jq_tr){
	$("#tooltip_div").remove();
	var top_val=$(window).scrollTop()+150+"px";
	var tab=$("#dialog_purchase ");
	tab.css("top",top_val);
	if(jq_tr!=null){
		nowTR=jq_tr;
		//详情
		var index=jq_tr.children("td:eq(0)").text().trim();
		var materials_model=jq_tr.children("td:eq(2)").text().trim();
		var num=jq_tr.children("td:eq(4)").text().trim();
		var predict_costing_taxes=jq_tr.children("td:eq(5)").text().trim();
		var unit_price_taxes=jq_tr.children("td:eq(6)").text().trim();
		var time=jq_tr.children("td:eq(7)").text().trim();
		var remark=jq_tr.children("td:eq(8)").text().trim();
		if(tab.find(".product_top").length==0){
			tab.prepend('<div class="product_top"><span>序号：</span><span>'+index+'</span></div>');
		}else{
			tab.find(".product_top span:eq(1)").text(index);
		}
		tab.find(".product_bottom").html('<img src="images/cancle_materials.png" onclick="closePurchaseDialog(0)"><img src="images/submit_materials.png" onclick="closePurchaseDialog(2)"><img src="images/del_materials.png" onclick="closePurchaseDialog(1)">');
		//初始化下拉选择框
		var modelArray=getMaterialsByModel(materials_model);
		$("#bts-ex-5 li[data-value='"+modelArray[0]+"']").click();
		tab.find(".product_div:eq(1) input").val(num);
		tab.find(".product_div:eq(2) input").val(predict_costing_taxes);
		tab.find(".product_div:eq(3) input").val(unit_price_taxes);
		tab.find(".product_div:eq(4) input").val(time);
		tab.find(".product_div:eq(5) textarea").val(remark);
	}else{
		//添加
		nowTR=null;
		var today=timeTransLongToStr(0,4,"/",false);
		tab.find(".product_div:eq(4) input").val(today);
		tab.find(".product_top").remove();
		tab.find(".product_bottom").html('<img src="images/cancle_materials.png" onclick="closePurchaseDialog(0)"><img src="images/submit_materials.png" onclick="closePurchaseDialog(2)">');
	}
	if($(".dialog_product_bg").length==0){
		$("body").append('<div class="dialog_product_bg"></div>');
	}
	$(".dialog_product_bg").css("display","block");
	tab.css("display","block");
}
function closePurchaseDialog(btn_id){
	if(btn_id==1){
		//删除
		initdiglogtwo2("提示信息","你确定要删除该备货信息吗？");
   		$( "#confirm2" ).click(function() {
			$( "#twobtndialog" ).dialog( "close" );
			nowTR.remove();
			initTR(4);
			initDialogVal(4);
		});
   		return;
	}else if(btn_id==2){
		var mArray=getMaterialsByID($("#mid_input").val());
		var num=$("#dialog_purchase .product_div:eq(1) input").val();
		var predict_costing_taxes=$("#dialog_purchase .product_div:eq(2) input").val();
		var unit_price_taxes=$("#dialog_purchase .product_div:eq(3) input").val();
		var delivery_time=$("#dialog_purchase .product_div:eq(4) input").val();
		var remark=$("#dialog_purchase .product_div:eq(5) textarea").val();
		if(mArray.length==0){
			initdiglog2("提示信息","请选择型号");
			return;
		}
		if(num.length==0||(num=parseInt(num))==0){
			initdiglog2("提示信息","请输入数量");
			return;
		}
		if(predict_costing_taxes.length==0||(predict_costing_taxes=parseFloat(predict_costing_taxes))==0){
			initdiglog2("提示信息","请输入预计含税成本");
			return;
		}
		if(unit_price_taxes.length==0||(unit_price_taxes=parseFloat(unit_price_taxes))==0){
			initdiglog2("提示信息","请输入含税单价");
			return;
		}
		if(delivery_time.length==0){
			initdiglog2("提示信息","请选择交货期");
			return;
		}
		if(remark.replace(/\s/g,"").length==0){
			initdiglog2("提示信息","请输入备注");
			return;
		}
		var unit_price=unit_price_taxes/1.17;
		var price_taxes=unit_price_taxes*num;
		var price=price_taxes/1.17;
		if(nowTR==null){//添加
			var temp='<tr><td></td>'
					+'<td class="tooltip_div">'+mArray[1]+'</td>'
					+'<td class="tooltip_div" id="'+$("#mid_input").val()+'">'+mArray[2]+'</td>'
					+'<td class="tooltip_div">'+mArray[3]+'</td>'
					+'<td class="tooltip_div">'+num+'</td>'
					+'<td class="tooltip_div">'+predict_costing_taxes+'</td>'
					+'<td class="tooltip_div">'+unit_price_taxes+'</td>'
					+'<td class="tooltip_div">'+delivery_time+'</td>'
					+'<td class="tooltip_div">'+remark+'</td>'
					+'<td class="tooltip_div">'+Math.round(unit_price*100)/100+'</td>'
					+'<td class="tooltip_div">'+Math.round(price_taxes*100)/100+'</td>'
					+'<td class="tooltip_div">'+Math.round(price*100)/100+'</td></tr>';
			$("#purchase_tab").append(temp);
			showToolTip($("#purchase_tab tr:last"));
		}else{//修改
			nowTR.children("td:eq(1)").text(mArray[1]);
			nowTR.children("td:eq(2)").text(mArray[2]);
			nowTR.children("td:eq(3)").text(mArray[3]);
			nowTR.children("td:eq(4)").text(num);
			nowTR.children("td:eq(5)").text(predict_costing_taxes);
			nowTR.children("td:eq(6)").text(unit_price_taxes);
			nowTR.children("td:eq(7)").text(delivery_time);
			nowTR.children("td:eq(8)").text(remark);
			nowTR.children("td:eq(9)").text(Math.round(unit_price*100)/100);
			nowTR.children("td:eq(10)").text(Math.round(price_taxes*100)/100);
			nowTR.children("td:eq(11)").text(Math.round(price*100)/100);
		}
		//初始化序号
		initTR(4);
	}
	initDialogVal(4);
}
function showPurchaseDialog2(jq_tr){
	$("#tooltip_div").remove();
	var top_val=$(window).scrollTop()+150+"px";
	var tab=$("#dialog_purchase2");
	tab.css("top",top_val);
	nowTR=jq_tr;
	//详情
	var index=jq_tr.children("td:eq(0)").text().trim();
	var materials_model=jq_tr.children("td:eq(2)").text().trim();
	var num=jq_tr.children("td:eq(4)").text().trim();
	var predict_costing_taxes=jq_tr.children("td:eq(5)").text().trim();
	var unit_price_taxes=jq_tr.children("td:eq(6)").text().trim();
	var time=jq_tr.children("td:eq(7)").text().trim();
	var remark=jq_tr.children("td:eq(8)").text().trim();
	if(tab.find(".product_top").length==0){
		tab.prepend('<div class="product_top"><span>序号：</span><span>'+index+'</span></div>');
	}else{
		tab.find(".product_top span:eq(1)").text(index);
	}
	if(showBuyInfo){
		//显示到货
		if(checkAog){
			$("#aog_time").val(jq_tr.find("td.aog_date").text().trim());
			$("#aog_num").val(jq_tr.find("td.aog_num").text().trim());
		}else{
			$("#aog_time").text(jq_tr.find("td.aog_date").text().trim());
			$("#aog_num").text(jq_tr.find("td.aog_num").text().trim());
		}
	}
	//初始化下拉选择框
	tab.find(".product_div:eq(0) div").text(materials_model);
	tab.find(".product_div:eq(1) div").text(num);
	tab.find(".product_div:eq(2) div").text(predict_costing_taxes);
	tab.find(".product_div:eq(3) div").text(unit_price_taxes);
	tab.find(".product_div:eq(4) div").text(time);
	tab.find(".product_div:eq(5) textarea").val(remark).attr("readonly",true);
	if($(".dialog_product_bg").length==0){
		$("body").append('<div class="dialog_product_bg"></div>');
	}
	$(".dialog_product_bg").css("display","block");
	tab.css("display","block");
}
function closePurchaseDialog2(btn_id){
	if(btn_id==2){
		if(checkAog){
			var num=$("#aog_num").val();
			if(num==0){
				initdiglog2("提示信息","实际入库数量不能为空");
				return;
			}
			nowTR.find("td.aog_date").text($("#aog_time").val());
			nowTR.find("td.aog_num").text($("#aog_num").val());
			checkCover();
		}
	}
	//初始化序号
	initDialogVal(5);
}
/****
 * 同步高度
 */
function syncDIVHeight(){
	var hl = $(".td2_div9>div:eq(0)").outerHeight(); //获取左侧left层的高度  
	var hr = $(".td2_div9>div:eq(1)").outerHeight(); //获取右侧right层的高度   
   	var mh = Math.max(hl,hr); //比较hl与hr的高度，并将最大值赋给变量mh 
   	$(".td2_div9>div:eq(0)").height(mh); //将left层高度设为最大高度mh   
   	$(".td2_div9>div:eq(1)").height(mh); //将right层高度设为最大高度 
}