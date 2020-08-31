$(function(){
	$("body").append('<div id="contract_file_div" style="display:none"><input type="file" name="file_input_contract" id="file_input_contract" multiple="multiple"></div>');
	$("body").append('<div id="contract_file_div2" style="display:none"><input type="file" name="file_input_contract2" id="file_input_contract2" multiple="multiple"></div>');
});
function delfile(filename,jq_me){
	$('[title="'+filename+'"].jFiler-item-title').parent().find("a").click();
	jq_me.parent().remove();
}
function updateFileNum(){
	if($("#file_num").length>0){
		var n=file_num+successUploadFileNum1;
		if(n<1){
			$("#file_num").text("附件");
		}else{
			$("#file_num").text("附件（"+n+"个）");
		}
	}
}
function updateFileNum2(){

}
function uploadFileSuccess(filename){
	$(".div_file_list").append('<div class="div_file_item"><span>'+filename+'</span><a href="javascript:void(0)" onclick="delfile(&quot;'+filename+'&quot;'+',$(this))" >删除</a></div>');
}
function uploadFileSuccess2(filename){
	$(".div_file_list").append('<div class="div_file_item"><span>'+filename+'</span><a href="javascript:void(0)" onclick="delfile(&quot;'+filename+'&quot;'+',$(this))" >删除</a></div>');
}
function delFile(id,name){
	initdiglogtwo2("提示信息","你确定要删除文件<br/>【"+name+"】吗？");
	$( "#confirm2" ).click(function() {
		$( "#twobtndialog" ).dialog( "close" );
		document.flowform.delFileIDs.value+="の"+id;
		$("#file_item"+id).remove();
		file_num--;
		if(successUploadFileNum1==0&&file_num==0&&$("#checkbox10").prop("checked")){
			initdiglog2("提示信息","删除成功，请上传附件，切勿中途退出！");
		}else{
			initdiglog2("提示信息","删除成功！");
		}
		updateFileNum();
	});
}
function delFile2(id,name){
	initdiglogtwo2("提示信息","你确定要删除文件<br/>【"+name+"】吗？");
	$( "#confirm2" ).click(function() {
		$( "#twobtndialog" ).dialog( "close" );
		document.flowform.delFileIDs.value+="の"+id;
		$("#file_item"+id).remove();
	});
}