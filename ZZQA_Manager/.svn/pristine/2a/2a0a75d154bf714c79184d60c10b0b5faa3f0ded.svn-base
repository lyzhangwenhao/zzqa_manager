/***
 * 设置合同状态 {"待批复","已批复","被拒","部分采购","已采购","撤销中","已撤销"};
 * @param isDeling 是否撤销中或已撤销
 * @param opera 流程
 * @param purchaseState 0：未采购；1：部分采购；(2：已采购)
 */
function setContractState(isDeling,opera,purchaseState,applyFinished){
	if(applyFinished){
		if(purchaseState==1){
			$("#state").text("部分采购");
		}else if(purchaseState==2){
			$("#state").text("已采购");
		}else{
			$("#state").text("已批复");
		}
	}else if(opera==13){
		$("#state").text("已撤销");
	}else{
		if(isDeling){
			$("#state").text("撤销中");
		}else if(opera==5||opera==7||opera==9||opera==11){
			$("#state").text("被拒");
		}else{
			$("#state").text("待批复");
		}
	}
}
$(function(){
	$("body").append('<div id="contract_file_div" style="display:none"><input type="file" name="file_input_contract" id="file_input_contract" multiple="multiple"></div>');
});
function delfile(filename,jq_me){
	$('[title="'+filename+'"].jFiler-item-title').parent().find("a").click();
	jq_me.parent().remove();
}
//file_type=1
function uploadFileSuccess(filename){
	$(".div_file_list").append('<div class="div_file_item"><a href="javascript:void()" onclick="fileDown(0,&quot;'+filename+'&quot;,1);">'+filename+'</a><a href="javascript:void(0)" onclick="delfile(&quot;'+filename+'&quot;'+',$(this))" >[删除]</a></div>');
}
//保留方法
function updateFileNum(){
	
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
//检查是否重复
function checkContract_no(foreign_id){
	if($("input[name='contract_no']").val().trim().length==0){
		initdiglog2("提示信息","请输入合同编号");
		return;
	}
	$.ajax({
		type:"post",//post方法
		url:"ContractManagerServlet",
		data:{"type":"checkContract_no","contract_no":$("input[name='contract_no']").val(),"foreign_id":foreign_id,contract_type:1},
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