var request_code=0;//当前请求,防止受上一次请求影响
var unShippingJson;//所有未出货的明细
var selected_salesID=0;
var selected_saler;
$(function(){
	$("#bts-ex-8 .dropdown-toggle .placeholder").text("选择中自合同");
	$("#bts-ex-10 .dropdown-toggle .placeholder").text("选择中自合同");
	$("#bts-ex-8 li.filter-item.items").click(function(){
		getNeedShippingBySale($(this).attr("data-value"));
	});
	$("#bts-ex-10 li.filter-item.items").click(function(){
		showAllNoShippingSale();
	});
	$("#customer_name1").bind('keydown',function(event){
	    if(event.keyCode == "13"){
	    	showAllNoShippingSale();
	    }
	});
	$("#saler").bind('keydown',function(event){
	    if(event.keyCode == "13"){
	    	showAllNoShippingSale();
	    }
	});
	$(".showall_search2>img").click(function(){
		showAllNoShippingSale();
	});
	$("#bts-ex-10 .clear").click(function(){
		showAllNoShippingSale();
	});
	$("body").append('<div class="dialog_shipping_bg"></div>');
	$(".shipping_model li.filter-item.items").bind("click",function(){
		var m_id=$(this).attr("data-value");
		var array=getMaterialsByID(m_id);
		$("#unit").val(array[4]);
	});
	$("#putout_time").val(timeTransLongToStr(0,4,"/",false));
	setPage(1);
});
function setPage(flag){
	if(flag==1){
		$("#shipping_showone").css("display","none");
		$("#shipping_showall").css("display","block");
		selected_salesID=0;//初始化
		if(!unShippingJson){
			getAllNoShippingSale();
		} 
	}else{
		$("#shipping_showone").css("display","block");
		$("#shipping_showall").css("display","none");
		if(selected_salesID!=0){
			$("#bts-ex-8 li.filter-item.items[data-value='"+selected_salesID+"']").click();
		}
	}
}
function getNeedShippingBySale(sales_id){
	var request_code_now=++request_code;
	$.ajax({
        type: "POST",
        url: "ContractManagerServlet",
        data:{
            type:"getNeedShippingBySale",
            "sales_id":sales_id
        } ,
        dataType: "json",
        error:function(){
        	if(request_code_now==request_code){
        		initdiglog2("提示信息","连接异常");
        	}
        },
        success: function(result){
        	if(request_code_now==request_code){
        		if(result){
        			setShipping(result);
        		}else{
        			initdiglog2("提示信息","数据异常，请刷新重试");
        		}
        	} 
        }
    });
}
/****
 * 未完成出货明细
 */
function getAllNoShippingSale(){
	var request_code_now=++request_code;
	$.ajax({
        type: "POST",
        url: "ContractManagerServlet",
        data:{
            type:"getAllNoShippingSale",
        } ,
        dataType: "json",
        error:function(){
        	if(request_code_now==request_code){
        		initdiglog2("提示信息","连接异常");
        	}
        },
        success: function(result){
        	if(request_code_now==request_code){
        		if(result){
        			unShippingJson=result;
        			showAllNoShippingSale();
        		}else{
        			initdiglog2("提示信息","数据异常，请刷新重试");
        		}
        	} 
        }
    });
}
/***
 * 显示未出货明细
 * @param shipping
 */
function showAllNoShippingSale(){
	var sid_search=$("#salesID2").val();
	var cname_search=$("#customer_name1").val();
	var saler_search=$("#saler").val();
	var temp='';
	var index=1;
	$.each(unShippingJson,function(){
		var sales_id=this.id;
		var customer_name=this.customer_name;
		var saler=this.saler?this.saler:"";
		var contract_no=this.contract_no;
		if((sid_search.length==0||sales_id==sid_search)
				&&(cname_search.length==0||customer_name.indexOf(cname_search)!=-1)
				&&(saler_search==0||saler.indexOf(saler_search)!=-1)){
			$.each(this.shipping_lists,function(){
				temp+='<tr class="shipping_tr_content" sales_id="'+sales_id+'">'
					+'<td >'+index+++'</td>'
					+'<td class="tooltip_div">'+contract_no+'</td>'
					+'<td class="tooltip_div">'+customer_name+'</td>'
					+'<td class="tooltip_div">'+saler+'</td>'
					+'<td class="tooltip_div">'+this.materials_id+'</td>'
					+'<td class="tooltip_div">'+this.name+'</td>'
					+'<td class="tooltip_div">'+this.model+'</td>'
					+'<td class="tooltip_div">'+this.unit+'</td>'
					+'<td class="tooltip_div">'+this.contract_num+'</td>'
					+'<td class="tooltip_div">'+this.unit_price+'</td>'
					+'<td class="tooltip_div">'+this.last_num+'</td>'
					+'</tr>';
			});
		}
	});
	$("#shipping_tab2").find("tr:gt(0)").remove();
	$("#shipping_tab2").append(temp);
	showToolTip($("#shipping_tab2"));
	$("#shipping_tab2").find("tr:gt(0)").click(function(){
		selected_salesID=$(this).attr("sales_id").trim();
		setPage(2);
	});
}
function setShipping(shipping){
	$("#customer_name").val(shipping.customer_name);
	selected_saler=shipping.saler;//销售人员
	var temp='';
	if(shipping.shipping_lists){
		$.each(shipping.shipping_lists,function(i){
			temp+='<tr class="shipping_tr_content" product_id="'+this.product_id+'" index_tr="'+i+'">'
				+'<td index_td="index" style="width:30px;">'+(i+1)+'</td>'
				+'<td index_td="saler" class="tooltip_div">'+selected_saler+'</td>'
				+'<td index_td="materials_id" class="tooltip_div" m_id="'+this.m_id+'">'+this.materials_id+'</td>'
				+'<td index_td="name" class="tooltip_div">'+this.name+'</td>'
				+'<td index_td="model" class="tooltip_div">'+this.model+'</td>'
				+'<td index_td="unit" class="tooltip_div">'+this.unit+'</td>'
				+'<td index_td="contract_num" class="tooltip_div">'+this.contract_num+'</td>'
				+'<td index_td="unit_price" class="tooltip_div">'+this.unit_price+'</td>'
				+'<td index_td="last_num" class="tooltip_div">'+this.last_num+'</td>'
				+'<td index_td="num" class="tooltip_div"></td>'
				+'<td index_td="price" class="tooltip_div"></td>'
				+'<td index_td="quality_no" class="tooltip_div"></td>'
				+'<td index_td="remark" class="tooltip_div"></td>'
				+'<td index_td="logistics_demand" class="tooltip_div"></td>'
				+'</tr>';
		});
	}
	$("#shipping_tab").find("tr:gt(0)").remove();
	$("#shipping_tab").append(temp);
	showToolTip($("#shipping_tab"));
	initTR();
}
function getMaterialsByModel(model){
	for(var i=0;i<materialsArray.length;i++){
		if(materialsArray[i][2]==model){
			return materialsArray[i];
		}
	}
	return new Array();
}
function getMaterialsByID(id){
	for(var i=0;i<materialsArray.length;i++){
		if(materialsArray[i][0]==id){
			return materialsArray[i];
		}
	}
	return new Array();
}
/****
 * @param index_tr
 */
function initTR(){
	$("#shipping_tab").find("tr:gt(0)").each(function(i){
		$(this).attr("index_tr",i);
		$(this).children("td:eq(0)").text(i+1);
		$(this).unbind("click").click(function(){
			showDialog(i);
		});
	});
}
function initDialogVal(){
	$("#bts-ex-5 button[data-id='prov']").attr("class","btn btn-lg btn-block btn-default dropdown-toggle").html('<span class="placeholder" style="font: 13px/ 17px &qout;SimSun&qout;;">选择型号</span><span class="caret"></span>');
	$("#bts-ex-5 li.selected").attr("class","filter-item items");
	$("#mid_input").val("");
	$(".dialog_shipping").css("display","none");
	$(".dialog_shipping_bg").css("display","none");
	$("#unit").val("");
	$("#quality_no").val("");
	$("#contract_num").val("");
	$("#unit_price").val("");
	$("#last_num").val("");
	$("#num").val("");
	$("#remark").val("");
	$("#logistics_demand").val("");
	nowTR=null;
}
function showDialog(index_tr){
	if(!parseInt($("#sales_contractno").val().trim())>0){
		initdiglog2("提示信息","请选择中自合同");
		return;
	}
	$("#tooltip_div").remove();
	if(index_tr>=0){
		//修改
		nowTR=$("tr[index_tr='"+index_tr+"']");
		if(nowTR.attr("product_id")==0){
			//配件
			var m_id=nowTR.find("td[index_td='materials_id']").attr("m_id");
			$(".accessories").css("display","block");
			$("#bts-ex-5 li[data-value='"+m_id+"']").click();
			$("#unit").val(nowTR.find("td[index_td='unit']").text());
			$("#contract_num").val(nowTR.find("td[index_td='contract_num']").text());
			$("#unit_price").val(nowTR.find("td[index_td='unit_price']").text());
			$("#last_num").val(nowTR.find("td[index_td='last_num']").text());
			$("#num").val(nowTR.find("td[index_td='num']").text());
			$("#quality_no").val(nowTR.find("td[index_td='quality_no']").text());
			$("#remark").val(nowTR.find("td[index_td='remark']").text());
			$("#logistics_demand").val(nowTR.find("td[index_td='logistics_demand']").text());
			$(".shipping_top").css("display","block");
			$(".shipping_top span:eq(1)").text(index_tr+1);
			$(".shipping_bottom").html('<img src="images/cancle_materials.png" onclick="closeDialog(0)"><img src="images/submit_materials.png" onclick="closeDialog(2)"><img src="images/del_materials.png" id="delproduct" onclick="closeDialog(1)">');
		}else{
			$(".accessories").css("display","none");
			$("#unit").val(nowTR.find("td[index_td='unit']").text());
			$("#num").val(nowTR.find("td[index_td='num']").text());
			$("#quality_no").val(nowTR.find("td[index_td='quality_no']").text());
			$("#remark").val(nowTR.find("td[index_td='remark']").text());
			$("#logistics_demand").val(nowTR.find("td[index_td='logistics_demand']").text());
			$(".shipping_top").css("display","block");
			$(".shipping_top span:eq(1)").text(index_tr+1);
			$(".shipping_bottom").html('<img src="images/cancle_materials.png" onclick="closeDialog(0)"><img src="images/submit_materials.png" onclick="closeDialog(2)">');
		}
		
	}else{
		//添加
		$(".shipping_top").css("display","none");
		$(".dialog_shipping_bg").css("display","block");
		$(".accessories").css("display","block");
		$(".shipping_bottom").html('<img src="images/cancle_materials.png" onclick="closeDialog(0)"><img src="images/submit_materials.png" onclick="closeDialog(2)">');
	}
	var dialog=$(".dialog_shipping");
	var top_val=$(window).scrollTop()+150+"px";
	dialog.css({"top":top_val,"display":"block"});
	$(".dialog_shipping_bg").css("display","block");
}
function closeDialog(index){
	if(index==0){
		//取消
	}else if(index==1){
		//删除
		if(nowTR&&nowTR.attr("product_id")==0){
			initdiglogtwo2("提示信息","你确定要删除该配件吗？");
	   		$( "#confirm2" ).click(function() {
				$( "#twobtndialog" ).dialog( "close" );
				nowTR.remove();
				initTR();
				initDialogVal();
			});
	   		return;
		}
		
	}else if(index==2){
		if(nowTR){
			//修改
			if(nowTR.attr("product_id")==0){
				//配件
				var m_id=$("#mid_input").val().trim();
				var unit=$("#unit").val().trim();
				var contract_num=$("#contract_num").val().trim();
				var unit_price=$("#unit_price").val().trim();
				var last_num=$("#last_num").val().trim();
				var num=$("#num").val().trim();
				var quality_no=$("#quality_no").val().trim();
				var remark=$("#remark").val().trim();
				var logistics_demand=$("#logistics_demand").val().trim();
				if(m_id.length<1){
					initdiglog2("提示信息","请选择型号");
					return;
				}
				if(unit.length<1){
					initdiglog2("提示信息","请输入单位");
					return;
				}
				if(contract_num.trim()==""||(contract_num!="0"&&!parseFloat(contract_num))){
					initdiglog2("提示信息","请输入合同数量");
					return;
				}
				if(unit_price.trim()==""||(unit_price!="0"&&!parseFloat(unit_price))){
					initdiglog2("提示信息","请输入单价");
					return;
				}
				if(last_num.trim()==""||(last_num!="0"&&!parseFloat(last_num))){
					initdiglog2("提示信息","请输入未发货数量");
					return;
				}
				if(!(num.length>0&&parseInt(num)>-1)){
					initdiglog2("提示信息","请输入本次发货数量");
					return;
				}
				var materials=getMaterialsByID(m_id);
				var price=num*unit_price;//本次发货金额
				nowTR.find("td[index_td='saler']").text("selected_saler");
				nowTR.find("td[index_td='materials_id']").attr("m_id",m_id);
				nowTR.find("td[index_td='materials_id']").text(materials[1]);
				nowTR.find("td[index_td='name']").text(materials[3]);
				nowTR.find("td[index_td='model']").text(materials[2]);
				nowTR.find("td[index_td='unit']").text(unit);
				nowTR.find("td[index_td='contract_num']").text(contract_num);
				nowTR.find("td[index_td='unit_price']").text(unit_price);
				nowTR.find("td[index_td='last_num']").text(last_num);
				nowTR.find("td[index_td='num']").text(num);
				nowTR.find("td[index_td='price']").text(price);
				nowTR.find("td[index_td='quality_no']").text(quality_no);
				nowTR.find("td[index_td='remark']").text(remark);
				nowTR.find("td[index_td='logistics_demand']").text(logistics_demand);
			}else{
				var unit=$("#unit").val().trim();
				var last_num=parseInt(nowTR.find("td[index_td='last_num']").text().trim());
				var num=$("#num").val().trim();
				var quality_no=$("#quality_no").val().trim();
				var remark=$("#remark").val().trim();
				var logistics_demand=$("#logistics_demand").val().trim();
				if(unit.length<1){
					initdiglog2("提示信息","请输入单位");
					return;
				}
				if(!(num.length>0&&parseInt(num)>-1)){
					initdiglog2("提示信息","请输入本次发货数量");
					return;
				}
				if(num>last_num){
					initdiglog2("提示信息","本次发货数量不能大于未发货数量");
					return;
				}
				var unit_price=parseFloat(nowTR.find("td[index_td='unit_price']").text().trim());
				var price=num*unit_price;//本次发货金额
				nowTR.find("td[index_td='saler']").text(selected_saler);
				nowTR.find("td[index_td='unit']").text(unit);
				nowTR.find("td[index_td='num']").text(num);
				nowTR.find("td[index_td='price']").text(price);
				nowTR.find("td[index_td='quality_no']").text(quality_no);
				nowTR.find("td[index_td='remark']").text(remark);
				nowTR.find("td[index_td='logistics_demand']").text(logistics_demand);
			}
		}else{
			//添加
			var m_id=$("#mid_input").val().trim();
			var unit=$("#unit").val().trim();
			var contract_num=$("#contract_num").val().trim();
			var unit_price=$("#unit_price").val().trim();
			var last_num=$("#last_num").val().trim();
			var num=$("#num").val().trim();
			var quality_no=$("#quality_no").val().trim();
			var remark=$("#remark").val().trim();
			var logistics_demand=$("#logistics_demand").val().trim();
			if(m_id.length<1){
				initdiglog2("提示信息","请选择型号");
				return;
			}
			if(unit.length<1){
				initdiglog2("提示信息","请输入单位");
				return;
			}
			if(contract_num.trim()==""||(contract_num!="0"&&!parseFloat(contract_num))){
				initdiglog2("提示信息","请输入合同数量");
				return;
			}
			if(unit_price.trim()==""||(unit_price!="0"&&!parseFloat(unit_price))){
				initdiglog2("提示信息","请输入单价");
				return;
			}
			if(last_num.trim()==""||(last_num!="0"&&!parseFloat(last_num))){
				initdiglog2("提示信息","请输入未发货数量");
				return;
			}
			if(!(num.length>0&&parseInt(num)>-1)){
				initdiglog2("提示信息","请输入本次发货数量");
				return;
			}
			var tr_num=$("#shipping_tab").find("tr:gt(0)").length;
			var materials=getMaterialsByID(m_id);
			var price=num*unit_price;//本次发货金额
			var temp='<tr class="shipping_tr_content" product_id="0" index_tr="'+tr_num+'">'
				+'<td index_td="index" style="width:30px;">'+(tr_num+1)+'</td>'
				+'<td index_td="saler" class="tooltip_div">'+selected_saler+'</td>'
				+'<td index_td="materials_id" class="tooltip_div" m_id="'+m_id+'">'+materials[1]+'</td>'
				+'<td index_td="name" class="tooltip_div">'+materials[3]+'</td>'
				+'<td index_td="model" class="tooltip_div">'+materials[2]+'</td>'
				+'<td index_td="unit" class="tooltip_div">'+unit+'</td>'
				+'<td index_td="contract_num" class="tooltip_div">'+contract_num+'</td>'
				+'<td index_td="unit_price" class="tooltip_div">'+unit_price+'</td>'
				+'<td index_td="last_num" class="tooltip_div">'+last_num+'</td>'
				+'<td index_td="num" class="tooltip_div">'+num+'</td>'
				+'<td index_td="price" class="tooltip_div">'+price+'</td>'
				+'<td index_td="quality_no" class="tooltip_div">'+quality_no+'</td>'
				+'<td index_td="remark" class="tooltip_div">'+remark+'</td>'
				+'<td index_td="logistics_demand" class="tooltip_div">'+logistics_demand+'</td>'
				+'</tr>';
			$("#shipping_tab").append(temp);
			showToolTip($("#shipping_tab").find("tr:last"));
		}
	}
	initTR();
	initDialogVal();
}
function addFlow(){
	var sales_id=parseInt($("#sales_contractno").val().trim());
	var customer_contract_no=$("#customer_contract_no").val().trim();
	var material_type=$("#material_type").val().trim();
	var department=$("#department").val().trim();
	var putout_time=$("#putout_time").val().trim();
	var address=$("#address").val().trim();
	var linkman=$("#linkman").val().trim();
	var linkman_phone=$("#linkman_phone").val().trim();
	if(!sales_id>0){
		initdiglog2("提示信息","请选择中自合同");
		return;
	}
	if(material_type.length<1){
		initdiglog2("提示信息","请输入领料类型");
		return;
	}
	if(!(department>0)){
		initdiglog2("提示信息","请选择部门");
		return;
	}
	if(putout_time.length<1){
		initdiglog2("提示信息","请输入出库时间");
		return;
	}
	if(address.length<1){
		initdiglog2("提示信息","请输入发货地址");
		return;
	}
	if(linkman.length<1){
		initdiglog2("提示信息","请输入联系人");
		return;
	}
	if(linkman_phone.length<1){
		initdiglog2("提示信息","请输入联系电话");
		return;
	}
	if(!testPhoneNumber(linkman_phone)){
		initdiglog2("提示信息","联系电话格式不正确");
		return;
	}
	putout_time=timeTransStrToLong2(putout_time);
	var shipping_jsonarray=eval('([])');
	var finished=true;
	var allZero=true;//是否全部不发货
	$("#shipping_tab").find("tr:gt(0)").each(function(){
		var product_id=$(this).attr("product_id").trim();
		var m_id=0;
		var name="";
		var unit="";
		var contract_num=0;
		var unit_price=0;
		var last_num=0;
		var num=$(this).find("td[index_td='num']").text().trim();
		num=num.length>0?parseInt(num):0;
		var remark=$(this).find("td[index_td='remark']").text().trim();
		var logistics_demand=$(this).find("td[index_td='logistics_demand']").text().trim();
		if(product_id=="0"){
			m_id=$(this).find("td[index_td='materials_id']").attr("m_id");
			name=$(this).find("td[index_td='name']").text().trim();
			contract_num=$(this).find("td[index_td='contract_num']").text().trim();
			unit_price=$(this).find("td[index_td='unit_price']").text().trim();
			last_num=$(this).find("td[index_td='last_num']").text().trim();
		}else{
			if(num>0){
				allZero=false;
			}
		}
		quality_no=$(this).find("td[index_td='quality_no']").text().trim();
		unit=$(this).find("td[index_td='unit']").text().trim();
		if(unit.length==0){
			finished=false;
			initdiglog2("提示信息","请输入单位");
			return false;
		}
		if(num>0){
			shipping_jsonarray.push({"product_id":product_id,"m_id":m_id,"name":name,"unit":unit,"quality_no":quality_no,"contract_num":contract_num,
				"unit_price":unit_price,"last_num":last_num,"num":num,"remark":remark
				,"logistics_demand":logistics_demand});
		}
	});
	if(!finished){
		return;
	}
	if(allZero){
		initdiglog2("提示信息","本次发货数量不能都为0！");
		return;
	}
	if(shipping_jsonarray.length<1){
		initdiglog2("提示信息","发货明细不能为空！");
		return;
	}
	$.ajax({
        type: "POST",
        url: "ContractManagerServlet",
        data:{
            type:"addshipping",
            "material_type":material_type,
            "department":department,
            "putout_time":putout_time,
            "sales_id":sales_id,
            "address":address,
            "linkman":linkman,
            "linkman_phone":linkman_phone,
            "customer_contract_no":customer_contract_no,
            "shipping_jsonarray":JSON.stringify(shipping_jsonarray)
        } ,
        error:function(){
        	initdiglog2("提示信息","连接异常");
        },
        success: function(result){
        	if(parseInt(result)>0){
        		window.location.href='FlowManagerServlet?type=flowdetail&flowtype=28&id='+result;
    		}else{
    			initdiglog2("提示信息","数据异常，请刷新重试");
    		}
        }
    });
}
/***
 * 导出未出货明细表
 */
function exportData(){
	var data="";
	$("#shipping_tab2 tr").each(function(i){
		if(i>0){
			data+="い";
		}
		$(this).find("td").each(function(k){
			if(k>0){
				data+="の";
			}
			data+=$(this).text().trim();
		});
	});
	var filename="未出货明细表";
	$.ajax({
		type:"post",//post方法
		url:"HandelTempFileServlet",
		data:{"type":"exporttrack_out","data":data},
		//ajax成功的回调函数
		success:function(returnData){
			if(returnData&&returnData.length>1){
				window.location.href="FileDownServlet?type=loadtrackexcel&filePath="+returnData+"&filename="+filename;
			}else{
				//失败
				initdiglog2("提示信息", "导出失败！");
			}
		},
		complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
			if(status!='success'){//超时,status还有success,error等值的情况
				initdiglog2("提示信息","导出失败！");
			}
		}
	});
}