function verifyFlow(isagree){
	document.flowform.isagree.value=isagree;
	var reason=document.flowform.reason.value.replace(/\s/g,"");
	if(reason.length==0){
		initdiglog2("提示信息","请输入意见或建议！");
		return;
	}
	document.flowform.submit();
}
function alterFlow(){
	initdiglogtwo2("提示信息","您确定要重新修改任务单吗？");
	$( "#confirm2" ).click(function() {
		$( "#twobtndialog" ).dialog( "close" );
		var reason=document.flowform.reason.value.replace(/\s/g,"");
		if(reason.length==0){
			initdiglog2("提示信息","请输入意见或建议！");
			return;
		}
		document.flowform.type.value="task_updateflow";
		document.flowform.submit();
	});
}
function alertRemarks(){
	$.ajax({
		type:"post",//post方法
		url:"CheckServlet",
		data:{"type":"alertRemarks","remarks":document.flowform.remarks.value},
		timeout : 10000, //超时时间设置，单位毫秒
		complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
			if(status=='timeout'){//超时,status还有success,error等值的情况
				initdiglog2("提示信息","请求超时，请重试!"); 
			}
		}, 
		//ajax成功的回调函数
		success:function(returnData){
			initdiglog2("提示信息","保存成功！");
			remark=document.flowform.remarks.value.replace(/[\r\n]/g, "<br/>").replace(/[\n\r]/g, "<br/>").replace(/[\r]/g, "<br/>").replace(/[\n]/g, "<br/>");
		}
	});
}
function cancleTask(f){
	if(f==0){
		//撤销
		initdiglogtwo2("提示信息","您确定要撤销该任务单吗？");
   		$( "#confirm2" ).click(function() {
			$( "#twobtndialog" ).dialog( "close" );
			var reason=document.flowform.reason.value.replace(/\s/g,"");
			if(reason.length==0){
				initdiglog2("提示信息","请输入意见或建议！");
				return;
			}
			document.flowform.type.value="cancleStartupTask";
			document.flowform.submit();
   		});
	}else{
		//恢复
		initdiglogtwo2("提示信息","您确定要恢复该任务单吗？");
   		$( "#confirm2" ).click(function() {
			$( "#twobtndialog" ).dialog( "close" );
			document.flowform.type.value="recoverStartupTask";
			document.flowform.submit();
   		});
	}
}
var fids_del='';
function addfile(){
	if(successUploadFileNum8==0&&$(".files_ul>li").length==0){
		initdiglog2("提示信息","请上传合同！");
		return;
	}
	$("#fids_del").val(fids_del);
	document.flowform.isagree.value=3;
	document.flowform.submit();
}
function delFile(fid,fname){
	initdiglogtwo2("提示信息","您确定要删除合同【"+fname+"】吗？");
	$( "#confirm2" ).click(function() {
		$( "#twobtndialog" ).dialog( "close" );
		if(fids_del.length>0){
			fids_del+='の'+fid;
		}else{
			fids_del=fid;
		}
		$("#file_li_"+fid).remove();
	});
}
function preview(){ 
	bdhtml=window.document.body.innerHTML;//获取当前页的html代码 
	sprnstr="<!--startprint1-->";//设置打印开始区域 
	
	sprnstr0="<!--startprint0-->";
	//$("#remarks").text();
	eprnstr0="<!--endprint0-->";
	
	eprnstr="<!--endprint1-->";//设置打印结束区域 
	prnhtml=bdhtml.substring(bdhtml.indexOf(sprnstr)+18,bdhtml.indexOf(sprnstr0));
	prnhtml+=remark.replace(/\r\n/g,"<br/>").replace(/\n\r/g,"<br/>").replace(/\r/g,"<br/>").replace(/\n/g,"<br/>");
	prnhtml+=bdhtml.substring(bdhtml.indexOf(eprnstr0)+16,bdhtml.indexOf(eprnstr));
	window.document.body.innerHTML=prnhtml; 
	document.title =$("#project_name").text().trim()+$("#project_case").text().trim()
		+"项目启动任务单"+$("#project_id").text().trim();
	window.print(); 
	window.document.body.innerHTML=bdhtml;
	if($(".table2_tr9_td2 textarea").length>0){
		var reg=new RegExp("<br/>","g");
		document.flowform.remarks.value=remark.replace(reg,"\r\n");
	}
	document.title ="任务单流程";
	initdiglogtwo2("提示信息","是否将所有文件打包下载吗？");
	$( "#confirm2" ).click(function() {
		$("#twobtndialog").dialog( "close" );
		window.location.href="FileZipDownServlet?type=17";
	});
}