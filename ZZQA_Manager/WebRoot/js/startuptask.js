function strToDate(str) {
		//判断日期格式符合YYYY-MM-DD标准
		var tempStrs = str.split("-");
		if(tempStrs.length==3&&validate(tempStrs[0])&&tempStrs[0].length==4&&validate(tempStrs[1])&&tempStrs[1]<13&&validate(tempStrs[2])&&tempStrs[2]<32){
		return false;
		}
		return true;
	}
	function validate(sDouble){
	//检验是否为正数
		var re = /^\d+(?=\.{0,1}\d+$|$)/;
	 	return re.test(sDouble)&&sDouble>0;
}
function setTime(time,obj){
	//修改time的时间
	if(compareTime1(nowdate,time)){
		obj.value=time;
	}else{
		initdiglogtwo2("提示信息","日期早于当前时间，确认输入无误？");
   		$( "#confirm2" ).click(function() {
			$( "#twobtndialog" ).dialog( "close" );
			obj.value=time;
		});
	}
}
function addFlow(){
	var k=0;
	if(document.flowform.project_name.value.length<1){
		k++;
		document.getElementById("pname_error").innerText="请输入项目名称";
	}else{
		document.getElementById("pname_error").innerText="";
	}
	if(document.flowform.project_id.value.length<1){
		k++;
		document.getElementById("pid_error").innerText="请输入项目编号";
	}else{
		document.getElementById("pid_error").innerText="";
	}
	if(document.flowform.customer.value.length<1){
		k++;
		document.getElementById("customer_error").innerText="请输入用户名称";
	}else{
		document.getElementById("customer_error").innerText="";
	}
	var linkman_user="";
	for(var i=1;i<linkman_user_num+1;i++){
		if(document.getElementById("linkman_user_div"+i)){
		    var linkman= document.getElementById("linkman_user"+i).value;
		    var phone= document.getElementById("phone_user"+i).value;
			if(linkman.length>0&&testPhoneNumber(phone)){
				document.getElementById("linkman_user"+i).value=linkman;
				document.getElementById("phone_user"+i).value=phone;
				document.getElementById("linkman_user_span"+i).innerText="";
				if(linkman_user.length==0){
					linkman_user=linkman+"の"+phone;
				}else{
					linkman_user+="い"+linkman+"の"+phone;
				}
			}else{
				k++;
				if(linkman.length<1&&phone.length<1){
					document.getElementById("linkman_user_span"+i).innerText="请输入姓名和电话";
				}else if(linkman.length<1){
					document.getElementById("linkman_user_span"+i).innerText="请输入姓名";
				}else if(phone.length<1){
					document.getElementById("linkman_user_span"+i).innerText="请输入电话";
				}else if(!testPhoneNumber(phone)){
					document.getElementById("linkman_user_span"+i).innerText="电话格式不正确";
				}else{
					document.getElementById("linkman_user_span"+i).innerText="信息输入有误";
				}
			}
		}
	}
	var linkman= document.getElementById("linkman_user0").value;
	var phone= document.getElementById("phone_user0").value;
	if(linkman.length>0&&testPhoneNumber(phone)){
		document.getElementById("linkman_user0").value=linkman;
		document.getElementById("phone_user0").value=phone;
		document.getElementById("linkman_user_span0").innerText="";
		if(linkman_user.length==0){
			linkman_user=linkman+"の"+phone;
		}else{
			linkman_user+="い"+linkman+"の"+phone;
		}
	}else{
		k++;
		if(linkman.length<1&&phone.length<1){
			document.getElementById("linkman_user_span0").innerText="请输入姓名和电话";
		}else if(linkman.length<1){
			document.getElementById("linkman_user_span0").innerText="请输入姓名";
		}else if(phone.length<1){
			document.getElementById("linkman_user_span0").innerText="请输入电话";
		}else if(!testPhoneNumber(phone)){
			document.getElementById("linkman_user_span0").innerText="电话格式不正确";
		}else{
			document.getElementById("linkman_user_span0").innerText="信息输入有误";
		}
	}
	
	
	document.flowform.linkman_user.value=linkman_user;
	var linkman_bill="";
	for(var i=1;i<linkman_bill_num+1;i++){
		if(document.getElementById("linkman_bill_div"+i)){
		    var linkman= document.getElementById("linkman_bill"+i).value;
		    var phone= document.getElementById("phone_bill"+i).value;
			if(linkman!=null&&linkman.length>0&&testPhoneNumber(phone)){
				document.getElementById("linkman_bill"+i).value=linkman;
				document.getElementById("phone_bill"+i).value=phone;
				document.getElementById("linkman_bill_span"+i).innerText="";
				if(linkman_bill.length==0){
					linkman_bill=linkman+"の"+phone;
				}else{
					linkman_bill+="い"+linkman+"の"+phone;
				}
			}else{
				k++;
				if(linkman.length<1&&phone.length<1){
					document.getElementById("linkman_bill_span"+i).innerText="请输入姓名和电话";
				}else if(linkman.length<1){
					document.getElementById("linkman_bill_span"+i).innerText="请输入姓名";
				}else if(phone.length<1){
					document.getElementById("linkman_bill_span"+i).innerText="请输入电话";
				}else if(!testPhoneNumber(phone)){
					document.getElementById("linkman_bill_span"+i).innerText="电话格式不正确";
				}else{
					document.getElementById("linkman_bill_span"+i).innerText="信息输入有误";
				}
			}
		}
	}
	var linkman= document.getElementById("linkman_bill0").value;
	var phone= document.getElementById("phone_bill0").value;
	if(linkman!=null&&linkman.length>0&&testPhoneNumber(phone)){
		document.getElementById("linkman_bill0").value=linkman;
		document.getElementById("phone_bill0").value=phone;
		document.getElementById("linkman_bill_span0").innerText="";
		if(linkman_bill.length==0){
			linkman_bill=linkman+"の"+phone;
		}else{
			linkman_bill+="い"+linkman+"の"+phone;
		}
	}else{
		k++;
		if(linkman.length<1&&phone.length<1){
			document.getElementById("linkman_bill_span0").innerText="请输入姓名和电话";
		}else if(linkman.length<1){
			document.getElementById("linkman_bill_span0").innerText="请输入姓名";
		}else if(phone.length<1){
			document.getElementById("linkman_bill_span0").innerText="请输入电话";
		}else if(!testPhoneNumber(phone)){
			document.getElementById("linkman_bill_span0").innerText="电话格式不正确";
		}else{
			document.getElementById("linkman_bill_span0").innerText="信息输入有误";
		}
	}
	document.flowform.linkman_bill.value=linkman_bill;
	var linkman_device="";
	for(var i=1;i<linkman_device_num+1;i++){
		if(document.getElementById("linkman_device_div"+i)){
		    var linkman= document.getElementById("linkman_device"+i).value;
		    var phone= document.getElementById("phone_device"+i).value;
			if(linkman!=null&&linkman.length>0&&testPhoneNumber(phone)){
				document.getElementById("linkman_device"+i).value=linkman;
				document.getElementById("phone_device"+i).value=phone;
				document.getElementById("linkman_device_span"+i).innerText="";
				if(linkman_device.length==0){
					linkman_device=linkman+"の"+phone;
				}else{
					linkman_device+="い"+linkman+"の"+phone;
				}
			}else{
				k++;
				if(linkman.length<1&&phone.length<1){
					document.getElementById("linkman_device_span"+i).innerText="请输入姓名和电话";
				}else if(linkman.length<1){
					document.getElementById("linkman_device_span"+i).innerText="请输入姓名";
				}else if(phone.length<1){
					document.getElementById("linkman_device_span"+i).innerText="请输入电话";
				}else if(!testPhoneNumber(phone)){
					document.getElementById("linkman_device_span"+i).innerText="电话格式不正确";
				}else{
					document.getElementById("linkman_device_span"+i).innerText="信息输入有误";
				}
			}
		}
	}
	var linkman= document.getElementById("linkman_device0").value;
	var phone= document.getElementById("phone_device0").value;
	if(linkman!=null&&linkman.length>0&&testPhoneNumber(phone)){
		document.getElementById("linkman_device0").value=linkman;
		document.getElementById("phone_device0").value=phone;
		document.getElementById("linkman_device_span0").innerText="";
		if(linkman_device.length==0){
			linkman_device=linkman+"の"+phone;
		}else{
			linkman_device+="い"+linkman+"の"+phone;
		}
	}else{
		k++;
		if(linkman.length<1&&phone.length<1){
			document.getElementById("linkman_device_span0").innerText="请输入姓名和电话";
		}else if(linkman.length<1){
			document.getElementById("linkman_device_span0").innerText="请输入姓名";
		}else if(phone.length<1){
			document.getElementById("linkman_device_span0").innerText="请输入电话";
		}else if(!testPhoneNumber(phone)){
			document.getElementById("linkman_device_span0").innerText="电话格式不正确";
		}else{
			document.getElementById("linkman_device_span0").innerText="信息输入有误";
		}
	}
	document.flowform.linkman_device.value=linkman_device;
	if(strToDate(document.flowform.delivery_time.value)){ 
	 	k++;
		document.getElementById("time_error").innerText="请检查时间格式";
	}else{
		document.getElementById("time_error").innerText="";
	}
	if(strToDate(document.flowform.contract_time.value)){ 
	 	k++;
		document.getElementById("time_error2").innerText="请检查时间格式";
	}else{
		document.getElementById("time_error2").innerText="";
	}
	if(successUploadFileNum1==0) {
		k++;
		document.getElementById("file_input1_error").innerText="请选择文件";
	}else {
		document.getElementById("file_input1_error").innerText="";
	}
	if(document.flowform.description.value.replace(/\s+/g,"").length<1){
			initdiglog2("提示信息","合同执行风险一栏不能为空!"); 
			k++;
			return;
		}
	if(successUploadFileNum2==0&&document.flowform.other.value.replace(/\s+/g,"").length<1){
		initdiglog2("提示信息","您还未上传附件1：合同及技术协议扫描件，若无附件请备注!"); 
		k++;
		return;
	}
	if(successUploadFileNum3==0&&document.flowform.other2.value.replace(/\s+/g,"").length<1){
		initdiglog2("提示信息","您还未上传附件2：项目商务、技术评审邮件记录（虚拟打印PDF版），若无附件请备注!"); 
		k++;
		return;
	}
	if(successUploadFileNum4==0&&document.flowform.other3.value.replace(/\s+/g,"").length<1){
		initdiglog2("提示信息","您还未上传附件3：外部采购设备询价邮件记录，若无附件请备注!"); 
		k++;
		return;
	}
	if(successUploadFileNum5==0&&document.flowform.other4.value.replace(/\s+/g,"").length<1){
		initdiglog2("提示信息","您还未上传附件4：外包服务供应商信息及报价表（供应商评审表），若无附件请备注!"); 
		k++;
		return;
	}
	if(successUploadFileNum6==0&&document.flowform.other5.value.replace(/\s+/g,"").length<1){
		initdiglog2("提示信息","您还未上传附件5：投标报价表，若无附件请备注!"); 
		k++;
		return;
	}
	if(k==0){
		document.flowform.submit();
	}
}
function addLinkman(n){
   	if(n==1){
   		var temp="";
   		linkman_user_num++;
   		for(var i=1;i<linkman_user_num;i++){
				if(document.getElementById("linkman_user_div"+i)){
					var linkman=document.getElementById("linkman_user"+i).value;
   				var phone=document.getElementById("phone_user"+i).value;
					temp+='<div class="div_padding" id="linkman_user_div'+i+'">'+
					'姓名：<input type="text" value="'+linkman+'"id="linkman_user'+i+'" maxlength="10" onkeydown="if(event.keyCode==32) return false">'+
					' 电话：<input type="phone" value="'+phone+'"id="phone_user'+i+'"  maxlength="20" onkeydown="if(event.keyCode==32) return false">'+
					' <img src="images/delete.png" title="删除" onclick="delLinkman(1,'+i+');">'+
					' <span id="linkman_user_span'+i+'"></span></div>';
				}
			}
   		var linkman=document.flowform.linkman_user0.value;
   		var phone=document.flowform.phone_user0.value;
   		var linkman_div = document.getElementById("linkman_user_div");
   		temp+='<div class="div_padding" id="linkman_user_div'+linkman_user_num+'">'+
				'姓名：<input type="text" value="'+linkman+'"id="linkman_user'+linkman_user_num+'" maxlength="10" onkeydown="if(event.keyCode==32) return false">'+
				' 电话：<input type="phone" value="'+phone+'"id="phone_user'+linkman_user_num+'"  maxlength="20" onkeydown="if(event.keyCode==32) return false">'+
				' <img src="images/delete.png" title="删除" onclick="delLinkman(1,'+linkman_user_num+');">'+
				' <span id="linkman_user_span'+linkman_user_num+'"></span></div>';
   		linkman_div.innerHTML = temp;
   		document.flowform.linkman_user0.value="";
   		document.flowform.phone_user0.value="";
   	}else if(n==2){
   		linkman_bill_num++;
   		var temp="";
   		for(var i=1;i<linkman_bill_num;i++){
				if(document.getElementById("linkman_bill_div"+i)){
					var linkman=document.getElementById("linkman_bill"+i).value;
   				var phone=document.getElementById("phone_bill"+i).value;
					temp+='<div class="div_padding" id="linkman_bill_div'+i+'">'+
					'姓名：<input type="text" value="'+linkman+'"id="linkman_bill'+i+'" maxlength="10" onkeydown="if(event.keyCode==32) return false">'+
					' 电话：<input type="phone" value="'+phone+'"id="phone_bill'+i+'"  maxlength="20" onkeydown="if(event.keyCode==32) return false">'+
					' <img src="images/delete.png" title="删除" onclick="delLinkman(2,'+i+');">'+
					' <span id="linkman_bill_span'+i+'"></span></div>';
				}
			}
   		var linkman=document.flowform.linkman_bill0.value;
   		var phone=document.flowform.phone_bill0.value;
   		var linkman_div = document.getElementById("linkman_bill_div");
   		temp+='<div class="div_padding" id="linkman_bill_div'+linkman_bill_num+'">'+
				'姓名：<input type="text" value="'+linkman+'"id="linkman_bill'+linkman_bill_num+'" maxlength="10" onkeydown="if(event.keyCode==32) return false">'+
				' 电话：<input type="phone" value="'+phone+'"id="phone_bill'+linkman_bill_num+'"  maxlength="20" onkeydown="if(event.keyCode==32) return false">'+
				' <img src="images/delete.png" title="删除" onclick="delLinkman(2,'+linkman_bill_num+');">'+
				' <span id="linkman_bill_span'+linkman_bill_num+'"></span></div>';
   		linkman_div.innerHTML = temp;
   		document.flowform.linkman_bill0.value="";
   		document.flowform.phone_bill0.value="";
   	}else if(n==3){
   		var temp="";
   		linkman_device_num++;
   		for(var i=1;i<linkman_device_num;i++){
				if(document.getElementById("linkman_device_div"+i)){
					var linkman=document.getElementById("linkman_device"+i).value;
   				var phone=document.getElementById("phone_device"+i).value;
					temp+='<div class="div_padding" id="linkman_device_div'+i+'">'+
					'姓名：<input type="text" value="'+linkman+'"id="linkman_device'+i+'" maxlength="10" onkeydown="if(event.keyCode==32) return false">'+
					' 电话：<input type="phone" value="'+phone+'"id="phone_device'+i+'"  maxlength="20" onkeydown="if(event.keyCode==32) return false">'+
					' <img src="images/delete.png" title="删除" onclick="delLinkman(3,'+i+');">'+
					' <span id="linkman_device_span'+i+'"></span></div>';
				}
			}
   		var linkman=document.flowform.linkman_device0.value;
   		var phone=document.flowform.phone_device0.value;
   		var linkman_div = document.getElementById("linkman_device_div");
   		temp+='<div class="div_padding" id="linkman_device_div'+linkman_device_num+'">'+
				'姓名：<input type="text" value="'+linkman+'"id="linkman_device'+linkman_device_num+'" maxlength="10" onkeydown="if(event.keyCode==32) return false">'+
				' 电话：<input type="phone" value="'+phone+'"id="phone_device'+linkman_device_num+'"  maxlength="20" onkeydown="if(event.keyCode==32) return false">'+
				' <img src="images/delete.png" title="删除" onclick="delLinkman(3,'+linkman_device_num+');">'+
				' <span id="linkman_device_span'+linkman_device_num+'"></span></div>';
   		linkman_div.innerHTML = temp;
   		document.flowform.linkman_device0.value="";
   		document.flowform.phone_device0.value="";
   	}
}
function delLinkman(n,name){
	var id="";
	var t_num = 1;
	var t_name = "";
	var t_phone = "";
	var t_div = "";
	if(n==1){
		id="linkman_user_div"+name;
		t_div = "linkman_user_div";
		t_num = linkman_user_num;
		t_name = "linkman_user";
		t_phone = "phone_user";	   			
	}else if(n==2){
		id="linkman_bill_div"+name;
		t_div = "linkman_bill_div";
		t_num = linkman_bill_num;
		t_name = "linkman_bill";
		t_phone = "phone_bill";
	}else if(n==3){
		id="linkman_device_div"+name;
		t_div = "linkman_device_div";
		t_num = linkman_device_num;
		t_name = "linkman_device";
		t_phone = "phone_device";
	}
	var obj = document.getElementById(id);
	if (obj != null) {
		if(name == 0){
			for(var i=t_num;i>0;i--){
				if(document.getElementById(t_div+i)){
					document.getElementById(t_name+0).value = document.getElementById(t_name+i).value;
					document.getElementById(t_phone+0).value = document.getElementById(t_phone+i).value;
					var lastId = t_div+i;
					var lastObj = document.getElementById(lastId);
					lastObj.parentNode.removeChild(lastObj);
					break;
				}
			}
			if(i == 0){
				initdiglog2("提示信息","至少保留一行！");
				return;
			}
		}
		else{
			obj.parentNode.removeChild(obj);
		}
	}
}