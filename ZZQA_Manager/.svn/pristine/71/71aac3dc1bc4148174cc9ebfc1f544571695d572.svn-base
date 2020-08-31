var loading=false;//在下载文件
/*****
 * 判断不能一行显示的用浮窗显示完整信息
 */
var format = '{0}\r\n{1}';
$(function(){
	showToolTip();
	showLinkToolTip();
	//用于导入Excel时，初始化上传控件，并隐藏
	$("body").append('<div id="exportExcel_div" style="display:none"><input type="file" name="file_excel" id="file_excel" multiple="multiple"></div>');
});
function testPhoneNumber(phone){
	if(phone.length>0){
		var reg_phone=/^(([0\+]\d{2,3}-)?(0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
		var reg_mobile=/^1\d{10}$/;
		if(reg_phone.test(phone)||reg_mobile.test(phone)){
			return true;
		}
		return false;
	}else{
		return false;
	}
}
//邮编
function isPostalCode(val){
	 var pattern =/^[0-9]{6}$/;
	 if(val!=""){
	     if(pattern.exec(val))         {
	    	 return true;;
	     }
	 }
	 return false;
}
//去掉左边的空白  
function trimLeft(s){  
	if(s == null) {  
		return "";  
	}  
	var whitespace = new String(" \t\n\r");  
	var str = new String(s);  
	if (whitespace.indexOf(str.charAt(0)) != -1) {  
		var j=0, i = str.length;  
	while (j < i && whitespace.indexOf(str.charAt(j)) != -1){  
		j++;  
	}  
	str = str.substring(j, i);  
	}  
	return str;  
}
function checkFax(val){
	if(val!=null&&val.length>0){
		val=trimLeft(val.replace(/\#/g,""));//移除多余的#和前面空格
		val = val.replace(/^\-/g,""); //验证第一个字符是数字而不是-
		val=val.replace(" ","#");
		val = val.replace(/[^\d-#]/g,""); //清除"数字"和"-#"以外的字符
		val = val.replace(/\#{2,}/g,"#"); //只保留第一个- 清除多余的
		val = val.replace(/\-{2,}/g,"-"); //只保留第一个.#清除多余的
		val=val.replace("#"," ");//恢复第一个空格
		return val;
	}else{
		return "";
	}
}
function checkTel(val){
	if(val!=null&&val.length>0){
		val = val.replace(/[^\d-]/g,""); //清除"数字"和"-#"以外的字符
		val = val.replace(/\-{2,}/g,"-"); //只保留第一个.#清除多余的
		return val;
	}else{
		return "";
	}
}
function limitLength(field,maxLength){
		if(field.value.length>maxLength){
			initdiglog2("提示信息","输入内容过多！");
		}
		field.value = field.value.substring(0, maxLength); 
	}
function getPositionForInput(ctrl){
	var CaretPos = 0;
	if (document.selection) { // IE Support 
		ctrl.focus();
		var Sel = document.selection.createRange();
		Sel.moveStart('character', -ctrl.value.length);
		CaretPos = Sel.text.length;
	}else if(ctrl.selectionStart || ctrl.selectionStart == '0'){// Firefox support 
		CaretPos = ctrl.selectionStart;
	} 
	return (CaretPos); 
}
//设置光标位置函数 
function setCursorPosition(ctrl2, pos){ 
	if(ctrl2.setSelectionRange){ 
		ctrl2.focus(); 
		ctrl2.setSelectionRange(pos,pos); 
	}else if (ctrl2.createTextRange) { 
		var range = ctrl2.createTextRange(); 
		range.collapse(true); 
		range.moveEnd('character', pos); 
		range.moveStart('character', pos); 
		range.select(); 
	} 
}
/****
 * 
 * @param val
 * @param saveZore 是否保留一位数0
 * @returns
 */
function checkIntPosition(obj,saveZore) {
	var index=getPositionForInput(obj);
	var var_temp=obj.value;
	var val=obj.value;
	val=val.replace(/[^\d]/g, ""); // 清除"数字"以外的字符
	if(parseInt(val)>=0){
		if(saveZore){
			val=parseInt(val);
		}else{
			if(val.length>1){
				val=val.replace(/\b(0+)/gi,"");//输入超过1位时，自动去掉第一位的0
			}
		}
	}else{
		val=""
	}
	obj.value=val;
	if(var_temp==val){
		setCursorPosition(obj,index);
	}else if(var_temp.length-String(val).length==1){
		setCursorPosition(obj,--index);
	}
}
function checkNum(obj){
	var index=getPositionForInput(obj);
	var var_temp=obj.value;
	var val=obj.value;
	val=val.replace(/[^\d]/g, ""); // 清除"数字"以外的字符
	val=String(val);
	obj.value=val;
	if(var_temp==val){
		setCursorPosition(obj,index);
	}else if(var_temp.length-val.length==1){
		setCursorPosition(obj,--index);
	}
}

/*****
 * 正浮点数 
 * reserved 保留小数位数
 */
function checkFloatPositive(obj,reserved) {
	var index=getPositionForInput(obj);
	var var_temp=obj.value;
	var val=obj.value;
	val = val.replace(/\s/g, "");
	reserved=parseInt(reserved); 
	if (val != null && val.length > 0&&reserved>0&&reserved<7) {
		val = val.replace(/[^\d.]/g, ""); // 清除"数字"和"."以外的字符
		val = val.replace(/^\./g, ""); // 验证第一个字符是数字而不是小数点
		val = val.replace(".", "#");// 为保留第一个小数点，将第一个小数点转换成“-”
		val = val.replace(/\./g, "");// 移除多余的小数点
		val = val.replace("#", ".");// 恢复第一个小数点
		var pointIndex=val.indexOf(".");
		//1.789->0.79
		if(pointIndex!=-1&&(pointIndex+3)<val.length){
			var multiple=Math.pow(10,reserved);
			val=Math.round(val*multiple)/multiple;
		}
	} else {
		val= "";
	}
	obj.value=val;
	if(var_temp==val){
		setCursorPosition(obj,index);
	}else if(var_temp.length-String(val).length==1){
		setCursorPosition(obj,--index);
	}
}
function checkDecimal(val){
	if(val!=null&&val.length>0){
		val = val.replace(/[^\d.]/g,""); //清除"数字"和"."以外的字符
		val = val.replace(/^\./g,""); //验证第一个字符是数字而不是小数点
		val=val.replace(".","-");//为保留第一个小数点，将第一个小数点转换成“-”
		val=val.replace(/\./g,"");//移除多余的小数点
		val=val.replace("-",".");//恢复第一个小数点
		val = val.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
		var temp=val;
		if(val.indexOf(".") > 0){
			//带小数点的情况
			if(temp.substring(val.indexOf("."),val.length-1).length<3){
				return temp;
			}
			var endWithPoint=val.charAt(val.length-1)==".";
			var endZeroLen=val.length-val.indexOf(".")-1;
			// 10. 10.0 10.00 10.01 10.10
			val = val * 100; // 这里变成了12345.6
			val=val*1000;//处理14.5->14.499.999
			val = Math.round(val)
			val=val/1000;
			val = Math.round(val); // 四舍五入，去掉小数点后面的位数
			if(endWithPoint){
				val=val/100+".";//数字+字符
			}else{
				val+="";
				if(val.length==1){
					//0.03 3
					val="0.0"+val;
				}else{
					if(val!=0){
						val=val.substring(0,val.length-2)+"."+val.substring(val.length-2,val.length-2+endZeroLen);
					}else{
						//0.0
						val=temp;
					}
				}
				
			}
		}
		if(val.indexOf(".")==0){
			val="0"+val;
		}
	}else{
		val="";
	}
	return val;
}
//从链接跳转的查看权限
function canNotSee(){
	initdiglog2("提示信息","抱歉，您没有访问权限！");
}
/***
 * 下载文件
 * fileID 查看已下载文件
 * file_name,file_type 查看临时文件
 */
function fileDown(fileID,file_name,file_type){
	event.stopPropagation();
	if(loading){
		return;
	}
	loading=!loading;
	if(file_name){
		//查看临时文件
		window.location.href="FileDownServlet?type=loadTempFile&file_name="+file_name+"&file_type="+file_type;
		loading=!loading;
		return;
	}
	$.ajax({
		type:"post",//post方法
		url:"FilePermissionServlet",
		data:{"id":fileID},
		timeout : 10000, //超时时间设置，单位毫秒
		//ajax成功的回调函数
		complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
			if(status=='timeout'){//超时,status还有success,error等值的情况
				initdiglog2("提示信息","请求超时，请重试!"); 
			}
			loading=!loading;
		}, 
		success:function(returnData){
			if(returnData==0){
				//没权限
				initdiglog2("提示信息","抱歉，您没有访问权限!"); 
			}else if(returnData==1){
				window.location.href="FileDownServlet?type=loadfile&id="+fileID;
			}else if(returnData==2){
				initdiglog2("提示信息","抱歉，找不到文件!"); 
			}else if(returnData==3){
				initdiglog2("提示信息","用户登入超时!"); 
			}
		}
	});
}

/***
 * 下载文件
 * fileID 查看已下载文件
 * file_name,file_type 查看临时文件
 */
function fileDownList(fileID,file_name){
	event.stopPropagation();
	if(loading){
		return;
	}
	loading=!loading;
	$.ajax({
		type:"post",//post方法
		url:"FilePermissionServlet",
		data:{"id":fileID[0]},
		timeout : 10000, //超时时间设置，单位毫秒
		//ajax成功的回调函数
		complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
			if(status=='timeout'){//超时,status还有success,error等值的情况
				initdiglog2("提示信息","请求超时，请重试!"); 
			}
			loading=!loading;
		}, 
		success:function(returnData){
			if(returnData==0){
				//没权限
				initdiglog2("提示信息","抱歉，您没有访问权限!"); 
			}else if(returnData==1){
				window.location.href="FileDownServlet?type=loadfileList&id="+fileID+"&file_name="+file_name;
			}else if(returnData==2){
				initdiglog2("提示信息","抱歉，找不到文件!"); 
			}else if(returnData==3){
				initdiglog2("提示信息","用户登入超时!"); 
			}
		}
	});
}

//下载前端的数据
function excelDown(excel_data,flowType){
	if(loading){
		return;
	}
	loading=!loading;
	$.ajax({
		type:"post",//post方法
		url:"HandelTempFileServlet",
		data:{"type":"export_excel","excel_data":excel_data},
		timeout : 15000,
		//ajax成功的回调函数
		success:function(returnData){
			if(returnData.length>1){
				window.location.href="FileDownServlet?type=loadexcel&flowType="+flowType+"&filePath="+returnData;
			}else{
				//失败
				initdiglog2("提示信息", "导出失败！");
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
			loading=!loading;
		}
	});
}
//数据源为数据库 （在生产采购单详情页导出 flowType1：采购单）
function excelExportOut(flowType,flowID){
	if(loading){
		return;
	}
	loading=!loading;
	$.ajax({
		type:"post",//post方法
		url:"HandelTempFileServlet",
		data:{"type":"exportexcel_out","flowType":flowType,"flowID":flowID},
		timeout : 15000,
		//ajax成功的回调函数
		success:function(returnData){
			if(returnData.length>1){
				window.location.href="FileDownServlet?type=loadexcel&flowType="+(flowType+1)+"&filePath="+returnData;
			}else{
				//失败
				initdiglog2("提示信息", "导出失败！");
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
			loading=!loading;
		}
	});
}
//导出出差、请假月报表
function loadDownReport(flowType,num,year,month){
	if(loading){
		return;
	}
	loading=!loading;
	if(num<1){
		initdiglog2("提示信息", "找不到数据！");
		loading=!loading;
		return;
	}
	$.ajax({
		type:"post",//post方法
		url:"HandelTempFileServlet",
		data:{"type":"exportreport","flowType":flowType,"year":year,"month":month},
		timeout : 15000,
		//ajax成功的回调函数
		success:function(returnData){
			if(returnData.length>1){
				window.location.href="FileDownServlet?type=loadreport&flowType="+flowType+"&filePath="+returnData
				+"&year="+year+"&month="+month;
			}else{
				//失败
				initdiglog2("提示信息", "导出失败！");
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
			loading=!loading;
		}
	});
}
/****
 * 导出所有物料信息到excel
 */
function loadDownMaterials(){
	if(loading){
		return;
	}
	loading=!loading;
	$.ajax({
		type:"post",//post方法
		url:"HandelTempFileServlet",
		data:{"type":"exportMaterials"},
		timeout : 15000,
		//ajax成功的回调函数
		success:function(returnData){
			if(returnData.length>1){
				window.location.href="FileDownServlet?type=loadmaterials&filePath="+returnData;
			}else{
				//失败
				initdiglog2("提示信息", "没有数据！");
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
			loading=!loading;
		}
	});
}
/******
 * 导出客户/供应商资料到excel
 */
function loadDownCustomer(customer_type){
	if(loading){
		return;
	}
	loading=!loading;
	$.ajax({
		type:"post",//post方法
		url:"HandelTempFileServlet",
		data:{"type":"exportCustomer","customer_type":customer_type},
		timeout : 15000,
		//ajax成功的回调函数
		success:function(returnData){
			if(returnData.length>1){
				window.location.href="FileDownServlet?type=loadcustomer&filePath="+returnData+"&customer_type="+customer_type;
			}else{
				//失败
				initdiglog2("提示信息", "没有数据！");
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
			loading=!loading;
		}
	});
}
function showToolTip(parent){
	var x=10;
	var y=20;
	var jq_obj=parent?parent.find(".tooltip_div"):$(".tooltip_div");
	var w_h=window.innerHeight;//窗口高度
	jq_obj.mouseover(function(e){
		var srcElmt = event.srcElement;
	    if ( srcElmt && srcElmt.tagName ){
	        if ( srcElmt.clientWidth < srcElmt.scrollWidth ){
	            if ( !srcElmt.__title ){
	                if ( srcElmt.title == srcElmt.innerText ){
	                    return;
	                }
	                if ( srcElmt.title ){
	                    srcElmt.__title = srcElmt.title;
	                    
	                }
	            }
	            else{
	                return;
	            }
	            if ( srcElmt.__title ){
	                srcElmt.title = StringHelper.Format(format, srcElmt.__title, srcElmt.innerText);
	            }
	            else{
	                srcElmt.title = srcElmt.innerText;
	            }
		        srcElmt.myTitle=srcElmt.innerHTML;//防止log.jsp——>operation无法从innerText获取<br/>
		        srcElmt.title="";
				var tooltip="<div id='tooltip_div'>"+srcElmt.myTitle+"</div>"; //创建DIV元素
				$(this).append(tooltip); //追加到文档中
				//$("#tooltip_div").css({"top": (e.pageY+y) + "px","left": (e.pageX+x) + "px"}).show();	//设置X Y坐标， 并且显示
				var tooltip_h=$("#tooltip_div").height();
				if((w_h-e.clientY-y-20)>tooltip_h){
					$("#tooltip_div").css({"top": (e.clientY+y) + "px","left": (e.clientX+x) + "px"}).show();
				}else{
					$("#tooltip_div").css({"top": (e.clientY-y-tooltip_h-5) + "px","left": (e.clientX+x) + "px"}).show();
				}
	        }
	    }
	}).mouseout(function(){
		var srcElmt = event.srcElement;
	    if ( srcElmt && srcElmt.tagName ){
	        if ( srcElmt.clientWidth >= srcElmt.scrollWidth ){
	            if ( srcElmt.__title ){
	                srcElmt.title = srcElmt.__title;
	                srcElmt.__title = null;
	            }
	            else{
	                if ( srcElmt.title == srcElmt.innerText ){
	                    srcElmt.title = '';
	                }
	            }
	        }
	    }
		srcElmt.myTitle="";
		$("#tooltip_div").remove(); //移除
	}).mousemove(function(e){
		//$("#tooltip_div").css({"top": (e.pageY+y) + "px","left": (e.pageX+x) + "px"});
		var tooltip_h=$("#tooltip_div").height();
		if((w_h-e.clientY-y-20)>tooltip_h){
			$("#tooltip_div").css({"top": (e.clientY+y) + "px","left": (e.clientX+x) + "px"});
		}else{
			$("#tooltip_div").css({"top": (e.clientY-y-tooltip_h-5) + "px","left": (e.clientX+x) + "px"});
		}
	})
}
function showLinkToolTip(parent){
	var x=10;
	var y=20;
	var jq_obj=parent?parent.find(".link_tooltip"):$(".link_tooltip");
	var w_h=window.innerHeight;//窗口高度
	jq_obj.mouseover(function(e){
		this.myTitle=this.title;
		this.title="";
		var tooltip="<div id='link_tooltip'>"+this.myTitle+"</div>"; //创建DIV元素
		$(this).append(tooltip); //追加到文档中
		var tooltip_h=$("#link_tooltip").height();
		if((w_h-e.clientY-y-20)>$("#link_tooltip").height()){
			$("#link_tooltip").css({"top": (e.clientY+y) + "px","left": (e.clientX+x) + "px"}).show();;
		}else{
			$("#link_tooltip").css({"top": (e.clientY-y-tooltip_h-5) + "px","left": (e.clientX+x) + "px"}).show();;
		}
		//$("#link_tooltip").css({"top": (e.pageY+y) + "px","left": (e.pageX+x) + "px"}).show();	//设置X Y坐标， 并且显示
	}).mouseout(function(){
		this.title=this.myTitle;
		$("#link_tooltip").remove(); //移除
	}).mousemove(function(e){
		var tooltip_h=$("#link_tooltip").height();
		if((w_h-e.clientY-y-20)>tooltip_h){
			$("#link_tooltip").css({"top": (e.clientY+y) + "px","left": (e.clientX+x) + "px"});
		}else{
			$("#link_tooltip").css({"top": (e.clientY-y-tooltip_h-5) + "px","left": (e.clientX+x) + "px"});
		}
	})
}
/****
 * 
 * @param other是否改别人
 */
function updatePassword(other){
	initdiglogInput2("修改密码");
	$( "#confirm2" ).click(function() {
		var password=$("#dialog_password" ).val();
		var confirmPass=$("#dialog_confirmPass" ).val();
		//关闭前获取数据
		$( "#twobtndialog" ).dialog( "close" );
		if(password!=""&&password==confirmPass){
			changePassword(password,other);
		}else if(password==""){
			 initdiglog2("提示信息","密码不能为空！");
		}else if(password!=confirmPass){
			 initdiglog2("提示信息","两次密码不一致！");
		}
	});
}
function changePassword(pass,other){
	var type=other?"otherpassword":"password";
	$.ajax({
		type:"post",//post方法
		url:"UserManagerServlet",
		timeout : 5000, //超时时间设置，单位毫秒
		data:{"type":type,"password":pass},
		//ajax成功的回调函数
		success:function(returnData){
			if(returnData==1){
				initdiglog2("提示信息","修改成功！");
			}else{
				initdiglog2("提示信息","修改失败！");
			}
		},
		complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
			if(status=='timeout'){//超时,status还有success,error等值的情况
				initdiglog2("提示信息","请求超时，请重试！");
			}else if(status=='error'){
				initdiglog2("提示信息","网络异常，修改失败！");
			}
		}
	});
}
//生成指定位数的随机密码，包含数字和大小字母（至少包含各一位）
function randomAlphanumeric(charsLength) {
    var chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    var randomChars = "";
    var i=0;
    if(charsLength>2){//至少包含数字，大小写字母各一位
    	charsLength-=3;
    	var chars1 = "abcdefghijklmnopqrstuvwxyz";
	    var chars2 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
	    var chars3 = "0123456789";
    	 i = Math.floor(Math.random() * chars1.length); 
        randomChars += chars1.charAt(i);
        i = Math.floor(Math.random() * chars2.length); 
        randomChars += chars2.charAt(i);
        i = Math.floor(Math.random() * chars3.length); 
        randomChars += chars3.charAt(i);
    }
    for(var x=0; x<charsLength; x++) { 
        var i = Math.floor(Math.random() * chars.length); 
        randomChars += chars.charAt(i);
    }
    var array=randomChars.split("");
    //打乱顺序
    for(var i = 0, len = array.length; i < len; i++){
		var randomIndex = parseInt(Math.random() * i);
		var temp = array[randomIndex];
		array[randomIndex] = array[i];
		array[i]= temp;
	}
    return array.join("");
}
//邮箱验证
function testEmail(str){
	var reg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	return reg.test(str);
}
//格式：2016-10-12
/***
 * 根据时间戳转日期字符串 
 * time 待转换的时间戳，默认为今天
 * index 显示格式，默认到小时
 * separator 分隔符，默认"/"
 * zero是否补0，默认不补
 */
function timeTransLongToStr(time,index,separator,zero){
	var d;
	if(time==0){
		d = new Date();//今天
	}else{
		d = new Date(time);    //根据时间戳生成的时间对象
	}
	var month=d.getMonth() + 1;
	var day=d.getDate();
	var date;
	if(index==1){
		date=d.getFullYear();
	}else if(index==2){
		date=month
	}else if(index==3){
		date=day;
	}else if(index==4){
		date = d.getFullYear() + (separator?separator:"-") +(zero?(month<10?("0"+month):month):month)
			+ (separator?separator:"-") +(zero?(day<10?("0"+day):day):day);
	}else if(index==100){
		var hour=d.getHours();
		var minute=d.getMinutes();
		var second=d.getSeconds();
		date = d.getFullYear() + (separator?separator:"-") +(zero?(month<10?("0"+month):month):month)
		+ (separator?separator:"-") +(zero?(day<10?("0"+day):day):day)+" "+(zero?(hour<10?("0"+hour):hour):hour)
		+":"+(zero?(minute<10?("0"+minute):minute):minute)+":"+(zero?(second<10?("0"+second):second):second);
	}else{
		var hour=d.getHours();
		date = d.getFullYear() + (separator?separator:"-") +(zero?(month<10?("0"+month):month):month)
		+ (separator?separator:"-") +(zero?(day<10?("0"+day):day):day)+" "+(zero?(hour<10?("0"+hour):hour):hour);
	}
	return date;
}
//已弃用，存在浏览器兼容，根据日期字符串转时间戳 格式：2016-10-12 16:28:59-15455455523 加上时差，国际化 用"/"分隔符无需加时间差
function timeTransStrToLong(date){
	return  new Date(date).getTime()+new Date().getTimezoneOffset()*60*1000;
}
//推荐
function timeTransStrToLong2(date){//2016/10/12 必须用"/"分隔符
	return  new Date(date).getTime();
}
//格式2017-01-03
function getTodayStr(){
	var date=new Date();
	var month=date.getMonth() + 1;
	var day=date.getDate();
	return   (date.getFullYear()) + "-" + (month<10?("0"+month):month)+ "-" +(day<10?("0"+day):day);
}
function getNowTime(){
	var date=new Date();
	var month=date.getMonth() + 1;
	var day=date.getDate();
	var hour=date.getHours();
	var minute=date.getMinutes();
	return   (date.getFullYear()) + "-" + (month<10?("0"+month):month)+ "-" +(day<10?("0"+day):day)
			+" "+(hour<10?("0"+hour):hour)+":"+(minute<10?("0"+minute):minute);
}
function transRNToBR(RN){
	if(RN){
		return RN.replace(/\r\n/g, "<br/>").replace(/\n\r/g, "<br/>").replace(/\r/g, "<br/>").replace(/\n/g, "<br/>");
	}
	return "";
}
function  transBRToRN(BR){
	if(BR!=null){
		return BR.replace(/\<br\/>/g, "\n").replace(/\<br>/g, "\n").replace(/\</g, "&lt;");
	}
	return "";
}
/****
 * 款项转大写
 * num{单位（元）}
 * 
 */
var DX = function (num) {
	  var strOutput = "";
	  var strUnit = '仟佰拾亿仟佰拾万仟佰拾元角分';
	  num += "00";
	  var intPos = num.indexOf('.');
	  if (intPos >= 0)
	    num = num.substring(0, intPos) + num.substr(intPos + 1, 2);
	  strUnit = strUnit.substr(strUnit.length - num.length);
	  for (var i=0; i < num.length; i++)
	   strOutput += '零壹贰叁肆伍陆柒捌玖'.substr(num.substr(i,1),1) + strUnit.substr(i,1);
	   return strOutput.replace(/零角零分$/, '整').replace(/零[仟佰拾]/g, '零').replace(/零{2,}/g, '零').replace(/零([亿|万])/g, '$1').replace(/零+元/, '元').replace(/亿零{0,3}万/, '亿').replace(/^元/, "零元");
};

function setCookie(name,value){ //name为cookie的名称,value为name值
    var days = 10; //保存天数,可作为参数传进来
    var expires = new Date(); //建立日期变量
    expires.setTime(expires.getTime() + days * 30 * 24 * 60 * 60 * 1000); //expires过期时间 = 当前时间 +过期时间(秒)
    var str = name + '=' + value +';expires=' + expires.toGMTString(); //将值及过期时间一起保存至cookie中(需以GMT格式表示的时间字符串)
    //var str = name + ‘=’ + escape(value) +’;expires=’ + expires.toGMTString(); 
    document.cookie = str;
}
function getCookie(name){//name为cookie名称
    var strcookie = document.cookie;//获取cookie字符串
    var arr = strcookie.split(';'); //分割cookie
    for(var i = 0;i<arr.length;i++){
            var arrStr = arr[i].split('='); //对各个cookie进行分割
            if(arrStr[0].replace(/^\s*|\s*/g, "") == name) return arrStr[1]; //判断是否存在cookie名称为name并输出
    }
    return ""; //返回
}








/***
 * ajax空请求，防止session过期
 */
var ajax_refresh;
function startAjaxRefresh(){
	ajax_refresh=setTimeout('ajaxRefresh()',8*60*1000);//8分钟
}
function ajaxRefresh(){
	$.ajax({
		type:"get",//post方法
		url:"UserManagerServlet",
		timeout : 10000, //超时时间设置，单位毫秒
		//ajax成功的回调函数
		error : function(XMLHttpRequest,status){ //请求完成后最终执行参数
			startAjaxRefresh();
		}, 
		success:function(returnData){
			startAjaxRefresh();
		}
	});
}
$(function(){
	startAjaxRefresh();
});