$(function(){
	$("body").append('<div id="communicate_file_div" style="display:none"><input type="file" name="file_input_communicate" id="file_input_communicate" multiple="multiple"></div>');
});
function delfile(filename){
	$('[title="'+filename+'"].jFiler-item-title').parent().find("a").click();
	$(':contains("'+filename+'").filename-itme-div').remove();
}
function updateFileNum(num){
	if(num>0){
		$(".communicate_file_num").html("附件：（"+num+"个）");
	}else{
		$(".communicate_file_num").html("附件");
	}
}