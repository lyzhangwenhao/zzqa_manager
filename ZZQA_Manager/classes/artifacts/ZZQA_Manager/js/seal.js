$(function(){
	$("body").append('<div id="contract_file_div" style="display:none"><input type="file" name="file_input_contract" id="file_input_contract" multiple="multiple"></div>');
});
function delfile(filename,jq_me){
	$('[title="'+filename+'"].jFiler-item-title').parent().find("a").click();
	jq_me.parent().remove();
}
function uploadFileSuccess(filename){
	$("#div_file_list").append('<div class="div_file_item"><span>'+filename+'</span><a href="javascript:void(0)" onclick="delfile(&quot;'+filename+'&quot;'+',$(this))" >删除</a></div>');
}
//保留
function updateFileNum(){
	
}
function delFile(id,name){
	initdiglogtwo2("提示信息","你确定要删除文件<br/>【"+name+"】吗？");
	$( "#confirm2" ).click(function() {
		$( "#twobtndialog" ).dialog( "close" );
		document.flowform.delFileIDs.value+="の"+id;
		$("#file_item"+id).remove();
		initdiglog2("提示信息","删除成功！");
	});
}