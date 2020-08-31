$(function(){
	$("body").append('<div id="contract_file_div" style="display:none"><input type="file" name="file_input_contract" id="file_input_contract" multiple="multiple"></div>');
	if($("#newtime_device").prop("checked")){
		$("#starttime_device").val(timeTransLongToStr(starttime_device,4,"-",true));
		$("#endtime_device").val(timeTransLongToStr(endtime_device,4,"-",true));
	}else{
		var end_date=timeTransLongToStr(endtime_device,4,"-",true);
		$("#endtime_device").val(end_date);
		$("#starttime_device").val(end_date.substring(0,8)+"01");
	}
	save_time=new Date().getTime();
	setTimeFilter();
	initPage();
	$('#keywords_device').bind('keydown',function(event){
	    if(event.keyCode == "13"){
	    	pageBegin(true);
	    }
	});
	$('#keywords_mydevice').bind('keydown',function(event){
	    if(event.keyCode == "13"){
	    	getDevice();
	    }
	});
});
function setPage(index){
	if(index!=device_pageType){
		if(device_pageType==1&&index==2){
			showDialog(1);
		}else if(device_pageType==3&&index==4){
			showDialog(1);
		}else{
			device_pageType=index;
			initPage();
		}
	}
}
function initPage(){
	if(device_pageType==4){
		device_pageType=3;
		showDialog(1);
	}
	if(device_pageType==2){
		device_pageType=1;
		showDialog(1);
	}
	if(device_pageType==1){
		if(flag==1){
			adv_search();
		}
		$(".td1_div0").text("模板管理");
		$("#modules_1").css("display","block");
		$("#modules_2").css("display","none");
		$("#modules_4").css("display","none");
		getDevice();
	}else if(device_pageType==3){
		if(flag==1){
			adv_search();
		}
		$(".td1_div0").text("我的产品");
		$("#modules_1").css("display","none");
		$("#modules_2").css("display","block");
		$("#modules_4").css("display","none");
		getDevice();
	}else if(device_pageType==5){
		$(".td1_div0").text("产品管理表");
		$("#modules_1").css("display","none");
		$("#modules_2").css("display","none");
		$("#modules_4").css("display","block");
		var state_temp='状态过滤：';
		$(stateArray).each(function(i){
			state_temp+='<label><input name="stateType" type="checkbox" '
				+(state_device.charAt(i)=='1'?'checked ':'')
				+'onclick="stateFilter('+i+')"/>'+stateArray[i]+'</label>';
		});
		$("#state_parent").html(state_temp);
		getDevice();
	}
}
/***
 * 打开新建对话框
 * @param index{0:详情；1：添加}
 */
function showDialog(index,id){
	if(device_pageType==1){
		//新建模板对话框
		var top_val=$(window).scrollTop()+150+"px";
		$(".temp_dialog").css({"top":top_val,"display":"block"});
		$(".device_dialog_bg").css("display","block");
		if(index==0){
			$(".temp_dialog_btns>img:eq(1)").css("display","inline-block");
			$(tempJson).each(function(){
				if(this.id==id){
					nowTempJson=this;
					return false;
				}
			});
			if(nowTempJson){
				$("#alias").val(nowTempJson.alias);
				var temp='';
				$(nowTempJson.circuit_cards).each(function(){
					temp+='<div><span class="temp_dialog_name1">名称：</span>'
						+'<input type="text" maxlength="50" class="temp_dialog_value1" value="'+this.name+'" style="width: 400px;">'
						+'<span class="glyphicon glyphicon-trash temp_dialog_delbtn" aria-hidden="true" onclick="delCard(this)"></span></div>';
				});
				$(".temp_dialog_content").append(temp);
			}else{
				initdiglog2("提示信息","数据错误");
			}
		}else{
			$(".temp_dialog_btns>img:eq(1)").css("display","none");
			addCard();
		}
	}else if(device_pageType==3){
		if(!tempJson){
			$.ajax({
				type:"post",//post方法
				url:"DeviceServlet",
				data:{"type":"getTempManager"},
				dataType:'json',
				success:function(returnData){
					tempJson=returnData;
					showDialog(index,id);
				},
				error:function(returnData){
					initdiglog2("提示信息","获取异常");
				}
			});
			return;
		}
		var top_val=$(window).scrollTop()+150+"px";
		$(".device_dialog").css({"top":top_val,"display":"block"});
		$(".device_dialog_bg").css("display","block");
		//新建产品对话框
		if(index==0){
			$("#id").remove();
			$("#id_parent").append('<div class="id_div" id="id"></div>');
			$(".device_dialog_btns>img:eq(1)").css("display","inline-block");
			$(myDeviceJson).each(function(){
				if(this.id==id){
					nowDeviceJson=this;
					return false;
				}
			});
			var temp_select='<option value="0">无需填印制板</option>';
			$(tempJson).each(function(){
				temp_select+='<option value="'+this.id+'">'+this.alias+'</option>';
			});
			$("#temp_select").html(temp_select).unbind("change").bind("change",function(){
				changeTemp();
			});
			if(nowDeviceJson){
				$("#id").text(nowDeviceJson.idStr);
				$("#sn").val(nowDeviceJson.sn);
				var temp='';
				$(nowDeviceJson.circuit_cards).each(function(){
					temp+='<div><span class="device_dialog_name1">名称：</span>'
						+'<span class="device_dialog_value1">'+this.name+'</span>'
						+'<span class="device_dialog_name2">批次号：</span>'
						+'<input type="text" maxlength="50" class="device_dialog_value2" value="'+this.sn+'"></div>';
				});
				$(".device_dialog_content").append(temp);
				var file_path=nowDeviceJson.file_path;
				if(file_path){
					$(".device_dialog_filelist").html('<a href="javascript:void(0)" onclick="fileDown('+file_path.id+')">'+file_path.file_name+'</a><a href="javascript:void(0)" onclick="delFile(&quot;'+file_path.file_name+'&quot;'+',$(this))" >删除</a>');
				}
			}else{
				initdiglog2("提示信息","数据错误");
			}
		}else{
			$("#id").remove();
			$("#id_parent").append('<input type="text" maxlength="8" id="id" oninput="checkNum(this)">');
			var temp_select='<option value="0">无需填印制板</option>';
			$(tempJson).each(function(){
				temp_select+='<option value="'+this.id+'">'+this.alias+'</option>';
			});
			$("#temp_select").html(temp_select).unbind("change").bind("change",function(){
				changeTemp();
			});
			$(".device_dialog_btns>img:eq(1)").css("display","none");
		}
	}
}
function closeDialog(index){
	if(device_pageType==1){
		if(index==0){
			//取消
			initDialog();
		}else if(index==1){
			//删除
			initdiglogtwo2("提示信息","你确定要删除该模板吗？");
	   		$( "#confirm2" ).click(function() {
				$( "#twobtndialog" ).dialog( "close" );
				handelDevice(2);
	   		});
		}else if(index==2){
			if(nowTempJson){
				//修改
				handelDevice(0);
			}else{
				//添加
				handelDevice(1);
			}
		}
	}else if(device_pageType==3){
		if(index==0){
			//取消
			initDialog();
		}else if(index==1){
			//删除
			initdiglogtwo2("提示信息","你确定要删除该产品吗？");
	   		$( "#confirm2" ).click(function() {
				$( "#twobtndialog" ).dialog( "close" );
				handelDevice(2);
	   		});
		}else if(index==2){
			if(nowDeviceJson){
				//修改
				handelDevice(0);
			}else{
				//添加
				handelDevice(1);
			}
		}
	}
}
function delCard(obj){
	if(device_pageType==1){
		$(obj).parent().remove();
	}else if(device_pageType==3){
		$(obj).parent().remove();
	}
}
function addCard(){
	if(device_pageType==1){
		var temp='<div><span class="temp_dialog_name1">名称：</span>'
			+'<input type="text" maxlength="50" class="temp_dialog_value1" style="width: 400px;">'
			+'<span class="glyphicon glyphicon-trash temp_dialog_delbtn" aria-hidden="true" onclick="delCard(this)"></span></div>';
		$(".temp_dialog_content").append(temp);
	}else if(device_pageType==3){
		
	}
}
/***
 * 
 * @param index{0:修改；1：添加;2:删除}
 * @returns
 */
function handelDevice(index){
	if(device_pageType==1){
		if(index==0){
			//修改
			var alias=$("#alias").val().trim();
			var temp_json={};
			var circuit_cards=eval('([])');
			if(alias.length<1){
				initdiglog2("提示信息","请输入别名");
				return;
			}
			var error=1;//0:错误
			$(".temp_dialog_content>div").each(function(i){
				var name=$(this).find(".temp_dialog_value1").val().trim();
				if(name.length<1){
					error=0;
					initdiglog2("提示信息","第"+(i+1)+"行名称未输入");
					return false;
				}
				circuit_cards.push({"name":name});
			});
			if(error==0){
				return;
			}
			if(circuit_cards.length==0){
				initdiglog2("提示信息","请添加印制板");
				return false;
			}
			temp_json.alias=alias;
			temp_json.id=nowTempJson.id;
			$.ajax({
				type:"post",//post方法
				url:"DeviceServlet",
				data:{"type":"updateTemp","temp_json":JSON.stringify(temp_json),"circuit_cards":JSON.stringify(circuit_cards)},
				dataType:'json',
				success:function(returnData){
					if(returnData>0){
						temp_json.circuit_cards=circuit_cards;
						if(!tempJson){
							tempJson=eval('([])');
						}
						$(tempJson).each(function(i){
							if(this.id==temp_json.id){
								tempJson.splice(i,1);
								$("tr[temp_id='temp_"+temp_json.id+"']").remove();
								return false;
							}
						});
						temp_json.id=returnData;//id修改
						tempJson.unshift(temp_json);
						var temp='<tr class="tab_tr2 tr_pointer" temp_id="temp_'+temp_json.id+'">'
							+'<td class="tab_tr1_td1">'+temp_json.alias+'</td>';
						var circuit_card='<table class=\'tooltip_table\'>';
						$(temp_json.circuit_cards).each(function(i){
							circuit_card+='<tr><td>名称：</td><td>'+this.name+'</td><td>批次号:</td><td>'+this.sn+'</td><td></tr>';
						});
						circuit_card+='</table>';
						temp+='<td class="tab_tr1_td5"><div id="link"><a class="device_detail link_tooltip" onclick="showDetail(&quot'
							+circuit_card+'&quot);" title="'+circuit_card+'">详细...</a></div></td>';
							+'</tr>';
						$("#tempmanager_tab .tab_tr1").after(temp);
						showLinkToolTip($("#tempmanager_tab .tab_tr2:eq(0)"));
						$("#tempmanager_tab .tab_tr2:eq(0)").click(function(){
							showDialog(0,temp_json.id);
						});
						initdiglog2("提示信息","保存成功");
						initDialog();
					}else{
						initdiglog2("提示信息","别名已存在");
					}
				},
				error:function(returnData){
					initdiglog2("提示信息","获取异常");
				}
			});
		}else if(index==1){
			//添加
			var alias=$("#alias").val().trim();
			var temp_json={};
			var circuit_cards=eval('([])');
			if(alias.length<1){
				initdiglog2("提示信息","请输入别名");
				return;
			}
			var error=1;//0:错误
			$(".temp_dialog_content>div").each(function(i){
				var name=$(this).find(".temp_dialog_value1").val().trim();
				if(name.length<1){
					error=0;
					initdiglog2("提示信息","第"+(i+1)+"行名称未输入");
					return false;
				}
				circuit_cards.push({"name":name});
			});
			if(error==0){
				return;
			}
			if(circuit_cards.length==0){
				initdiglog2("提示信息","请添加印制板");
				return false;
			}
			temp_json.alias=alias;
			$.ajax({
				type:"post",//post方法
				url:"DeviceServlet",
				data:{"type":"addTemp","temp_json":JSON.stringify(temp_json),"circuit_cards":JSON.stringify(circuit_cards)},
				dataType:'json',
				success:function(returnData){
					if(returnData>0){
						temp_json.id=returnData;
						temp_json.circuit_cards=circuit_cards;
						if(!tempJson){
							tempJson=eval('([])');
						}
						tempJson.unshift(temp_json);
						var temp='<tr class="tab_tr2 tr_pointer" temp_id="temp_'+temp_json.id+'">'
							+'<td class="tab_tr1_td1">'+temp_json.alias+'</td>';
						var circuit_card='<table class=\'tooltip_table\'>';
						$(temp_json.circuit_cards).each(function(i){
							circuit_card+='<tr><td>名称：</td><td>'+this.name+'</td></tr>';
						});
						circuit_card+='</table>';
						temp+='<td class="tab_tr1_td5"><div id="link"><a class="device_detail link_tooltip" onclick="showDetail(&quot'
							+circuit_card+'&quot);" title="'+circuit_card+'">详细...</a></div></td>';
							+'</tr>';
						$("#tempmanager_tab .tab_tr1").after(temp);
						showLinkToolTip($("#tempmanager_tab .tab_tr2:eq(0)"));
						$("#tempmanager_tab .tab_tr2:eq(0)").click(function(){
							showDialog(0,temp_json.id);
						});
						initdiglog2("提示信息","保存成功");
						initDialog();
					}else{
						initdiglog2("提示信息","别名已存在");
					}
				},
				error:function(returnData){
					initdiglog2("提示信息","获取异常");
				}
			});
		}else if(index==2){
			var id=nowTempJson.id;
			$.ajax({
				type:"post",//post方法
				url:"DeviceServlet",
				data:{"type":"delTemp","id":id},
				success:function(returnData){
					$(tempJson).each(function(i){
						if(this.id==id){
							tempJson.splice(i,1);
							$("tr[temp_id='temp_"+id+"']").remove();
							return false;
						}
					});
					initdiglog2("提示信息","删除成功");
					initDialog();
				},
				error:function(returnData){
					initdiglog2("提示信息","获取异常");
				}
			});
		}
	}else if(device_pageType==3){
		if(index==0){
			//修改
			var id=$("#id").text().trim();
			var sn=$("#sn").val().trim();
			var device_json={};
			var circuit_cards=eval('([])');
			if(sn.length<1){
				initdiglog2("提示信息","请输入SN");
				return;
			}
			var error=1;//0:错误
			$(".device_dialog_content>div").each(function(i){
				var name=$(this).find(".device_dialog_value1").text().trim();
				var sn=$(this).find(".device_dialog_value2").val().trim();
				if(sn.length<1){
					error=0;
					initdiglog2("提示信息","第"+(i+1)+"行批次号未输入");
					return false;
				}
				circuit_cards.push({"name":name,"sn":sn});
			});
			if(error==0){
				return;
			}
			if(circuit_cards.length==0){
				initdiglog2("提示信息","请输入印制板");
				return false;
			}
			if($(".device_dialog_filelist>a").length<1){
				initdiglog2("提示信息","请上传测试报告");
				return false;
			}
			device_json.id=parseInt(id);
			device_json.sn=sn;
			device_json.circuit_cards=circuit_cards;
			$.ajax({
				type:"post",//post方法
				url:"DeviceServlet",
				data:{"type":"updateDevice","save_time":save_time,"device_json":JSON.stringify(device_json),"circuit_cards":JSON.stringify(circuit_cards)},
				dataType:'json',
				success:function(returnData){
					if(returnData&&returnData.id>0){
						device_json=returnData;
						if(!myDeviceJson){
							myDeviceJson=eval('([])');
						}
						$(myDeviceJson).each(function(i){
							if(this.id==device_json.id){
								myDeviceJson.splice(i,1);
								$("tr[device_id='device_"+device_json.id+"']").remove();
								return false;
							}
						});
						myDeviceJson.unshift(device_json);
						var temp='';
						temp+='<tr class="tab_tr2 tr_pointer" device_id="device_'+device_json.id+'">'
							+'<td class="tab_tr1_td1">'+device_json.idStr+'</td>'
							+'<td class="tab_tr1_td2">'+device_json.sn+'</td>';
						var file_id=device_json.file_path?device_json.file_path.id:0;
						var circuit_card='<table class=\'tooltip_table\'>';
						$(device_json.circuit_cards).each(function(i){
							circuit_card+='<tr><td>名称：</td><td>'+this.name+'</td><td>批次号:</td><td>'+this.sn+'</td><td></tr>';
						});
						circuit_card+='</table>';
						temp+='<td class="tab_tr1_td5"><div id="link"><a class="device_detail link_tooltip" onclick="showDetail(&quot'
							+circuit_card+'&quot);" title="'+circuit_card+'">详细...</a></div>	</td>';
						if(file_id>0){
							temp+='<td class="tab_tr1_td6"><a class="img_a" href="javascript:void()" '
								+'onclick="this.blur();fileDown('+file_id+')">测试报告</a></td>';
						}else{
							temp+='<td class="tab_tr1_td6"></td>';
						}
						temp+='<td class="tab_tr1_td7">合格</td>'
							+'<td class="tab_tr1_td8">'+device_json.update_date+'</td>'
							+'</tr>';
						$("#mydevicemanager_tab .tab_tr1").after(temp);
						if($("#mydevicemanager_tab .tab_tr2:eq(0)").text().indexOf($("#keywords_mydevice").val().trim())!=-1){
							showLinkToolTip($("#mydevicemanager_tab .tab_tr2:eq(0)"));
							$("#mydevicemanager_tab .tab_tr2:eq(0)").click(function(){
								showDialog(0,$(this).attr("device_id").replace("device_",""));
							});
						}else{
							$("#mydevicemanager_tab .tab_tr2:eq(0)").remove();
						}
						initdiglog2("提示信息","修改成功");
						initDialog();
					}else{
						initdiglog2("提示信息","产品已发货，无法修改");
					}
				},
				error:function(returnData){
					initdiglog2("提示信息","获取异常");
				}
			});
		}else if(index==1){
			//添加
			var id=$("#id").val().trim();
			var sn=$("#sn").val().trim();
			var device_json={};
			var circuit_cards=eval('([])');
			if(id.length!=8){
				initdiglog2("提示信息","请输入8位ID");
				return;
			}
			if(sn.length<1){
				initdiglog2("提示信息","请输入SN");
				return;
			}
			var error=1;//0:错误
			$(".device_dialog_content>div").each(function(i){
				var name=$(this).find(".device_dialog_value1").text().trim();
				var sn=$(this).find(".device_dialog_value2").val().trim();
				if(sn.length<1){
					error=0;
					initdiglog2("提示信息","第"+(i+1)+"行批次号未输入");
					return false;
				}
				circuit_cards.push({"name":name,"sn":sn});
			});
			if(error==0){
				return;
			}
			if($(".device_dialog_filelist>a").length<1){
				initdiglog2("提示信息","请上传测试报告");
				return false;
			}
			device_json.id=parseInt(id);
			device_json.sn=sn;
			device_json.circuit_cards=circuit_cards;
			$.ajax({
				type:"post",//post方法
				url:"DeviceServlet",
				data:{"type":"addDevice","save_time":save_time,"device_json":JSON.stringify(device_json),"circuit_cards":JSON.stringify(circuit_cards)},
				dataType:'json',
				success:function(returnData){
					if(returnData&&returnData.id>0){
						device_json=returnData;
						if(!myDeviceJson){
							myDeviceJson=eval('([])');
						}
						myDeviceJson.unshift(device_json);
						
						var temp='';
						temp+='<tr class="tab_tr2 tr_pointer" device_id="device_'+device_json.id+'">'
							+'<td class="tab_tr1_td1">'+device_json.idStr+'</td>'
							+'<td class="tab_tr1_td2">'+device_json.sn+'</td>';
						var file_id=device_json.file_path.id;
						var circuit_card='<table class=\'tooltip_table\'>';
						$(device_json.circuit_cards).each(function(i){
							circuit_card+='<tr><td>名称：</td><td>'+this.name+'</td><td>批次号:</td><td>'+this.sn+'</td><td></tr>';
						});
						circuit_card+='</table>';
						temp+='<td class="tab_tr1_td5"><div id="link"><a class="device_detail link_tooltip" onclick="showDetail(&quot'
							+circuit_card+'&quot);" title="'+circuit_card+'">详细...</a></div>	</td>'
							+'<td class="tab_tr1_td6"><a class="img_a" href="javascript:void()" '
							+'onclick="this.blur();fileDown('+file_id+')">测试报告</a></td>'
							+'<td class="tab_tr1_td7">合格</td>'
							+'<td class="tab_tr1_td8">'+device_json.update_date+'</td>'
							+'</tr>';
						$("#mydevicemanager_tab .tab_tr1").after(temp);
						if($("#mydevicemanager_tab .tab_tr2:eq(0)").text().indexOf($("#keywords_mydevice").val().trim())!=-1){
							showLinkToolTip($("#mydevicemanager_tab .tab_tr2:eq(0)"));
							$("#mydevicemanager_tab .tab_tr2:eq(0)").click(function(){
								showDialog(0,$(this).attr("device_id").replace("device_",""));
							});
						}else{
							$("#mydevicemanager_tab .tab_tr2:eq(0)").remove();
						}
						initdiglog2("提示信息","保存成功");
						initDialog();
						device_change=true;
					}else{
						initdiglog2("提示信息","ID已存在");
					}
				},
				error:function(returnData){
					initdiglog2("提示信息","获取异常");
				}
			});
		}else if(index==2){
			var id=nowDeviceJson.id;
			$.ajax({
				type:"post",//post方法
				url:"DeviceServlet",
				data:{"type":"delDevice","id":id},
				success:function(returnData){
					if(returnData==1){
						$(myDeviceJson).each(function(i){
							if(this.id==id){
								myDeviceJson.splice(i,1);
								$("tr[device_id='device_"+id+"']").remove();
								return false;
							}
						});
						initdiglog2("提示信息","删除成功");
						initDialog();
						device_change=true;
					}else{
						initdiglog2("提示信息","产品已发货，无法删除");
					}
				},
				error:function(returnData){
					initdiglog2("提示信息","获取异常");
				}
			});
		}
	}
}
/*****
 * 
 * @param index:{0:添加；1：取消}
 */
/***
 * 关闭对话框时清空
 */
function initDialog(){
	if(device_pageType==1){
		$("#alias").val("");
		$(".temp_dialog").css("display","none");
		$(".device_dialog_bg").css("display","none");
		$(".temp_dialog_content>div").remove();
		nowTempJson=null;
	}else if(device_pageType==3){
		nowDeviceJson=null;
		$(".device_dialog").css("display","none");
		$(".device_dialog_bg").css("display","none");
		$("#sn").val("");
		$(".device_dialog_content>div").remove();
		$(".device_dialog_filelist").html("");
	}
}
//获取产品管理表信息
function getDevice(){
	if(device_pageType==1){
		if(typeof(tempJson) != "undefined"){
			showDevice();
			return;
		}
		$.ajax({
			type:"post",//post方法
			url:"DeviceServlet",
			data:{"type":"getTempManager"},
			dataType:'json',
			success:function(returnData){
				tempJson=returnData;
				showDevice();
			},
			error:function(returnData){
				initdiglog2("提示信息","获取异常");
			}
		});
	}else if(device_pageType==3){
		if(typeof(myDeviceJson) != "undefined"){
			showDevice();
			return;
		}
		$.ajax({
			type:"post",//post方法
			url:"DeviceServlet",
			data:{"type":"getMyDevice"},
			dataType:'json',
			success:function(returnData){
				myDeviceJson=returnData;
				showDevice();
			},
			error:function(returnData){
				initdiglog2("提示信息","获取异常");
			}
		});
	}else if(device_pageType==5){
		if(typeof(deviceJson) != "undefined"&&!device_change){
			showDevice();
			return;
		}
		device_change=false;
		var keywords=$("#keywords_device").val();
		var newtime_device=$("#newtime_device").prop("checked")?1:0;
		var starttime_device=timeTransStrToLong($("#starttime_device").val());
		var endtime_device=timeTransStrToLong($("#endtime_device").val())+86400000;
		state_device="";
		$("input[name='stateType']").each(function(){
			state_device+=$(this).prop("checked")?1:0;
		});
		$.ajax({
			type:"post",//post方法
			url:"DeviceServlet",
			data:{"type":"getDeviceManager",
				"keywords_device":keywords,
				"state_device":state_device,
				"newtime_device":newtime_device,
				"starttime_device":starttime_device,
				"endtime_device":endtime_device,
				"isCreater":watch_device?0:1
			},
			dataType:'json',
			success:function(returnData){
				deviceJson=returnData;
				$(".device_allnum").text("台数统计："+deviceJson.length+"台");
				showDevice();
			},
			error:function(returnData){
				initdiglog2("提示信息","获取异常");
			}
		});
	}
}
/***
 * 显示产品管理表
 */
function showDevice(){
	if(device_pageType==1){
		$("#tempmanager_tab .tab_tr2").remove();
		var temp='';
		$(tempJson).each(function(i){
			temp+='<tr class="tab_tr2 tr_pointer" temp_id="temp_'+this.id+'">'
				+'<td class="tab_tr1_td1">'+this.alias+'</td>';
			var circuit_card='';
			$(this.circuit_cards).each(function(i){
				circuit_card+='<div><div>名称：'+this.name+'</div></div>';
			});
			temp+='<td class="tab_tr1_td5"><div id="link"><a class="device_detail link_tooltip" onclick="showDetail(&quot'
				+circuit_card+'&quot);" title="'+circuit_card+'">详细...</a></div></td>'
				+'</tr>';
		});
		$("#tempmanager_tab").append(temp);
		showLinkToolTip($("#tempmanager_tab .tab_tr2"));
		$("#tempmanager_tab .tab_tr2").unbind("click").click(function(){
			showDialog(0,$(this).attr("temp_id").replace("temp_",""));
		});
	}else if(device_pageType==3){
		$("#mydevicemanager_tab .tab_tr2").remove();
		var kw=$("#keywords_mydevice").val();
		var temp='';
		$(myDeviceJson).each(function(i){
			temp+='<tr class="tab_tr2 tr_pointer" device_id="device_'+this.id+'">'
				+'<td class="tab_tr1_td1">'+this.idStr+'</td>'
				+'<td class="tab_tr1_td2">'+this.sn+'</td>';
			var file_id=this.file_path?this.file_path.id:0;
			if(this.circuit_cards&&this.circuit_cards.length>0){
				var circuit_card='<table class=\'tooltip_table\'>';
				$(this.circuit_cards).each(function(i){
					circuit_card+='<tr><td>名称：</td><td>'+this.name+'</td><td>批次号:</td><td>'+this.sn+'</td></tr>';
				});
				circuit_card+='</table>';
				temp+='<td class="tab_tr1_td5"><div id="link"><a class="device_detail link_tooltip" onclick="showDetail(&quot'
					+circuit_card+'&quot);" title="'+circuit_card+'">详细...</a></div>	</td>';
			}else{
				temp+='<td class="tab_tr1_td5"></td>';
			}
			if(file_id>0){
				temp+='<td class="tab_tr1_td6"><a class="img_a" href="javascript:void()" '
					+'onclick="this.blur();fileDown('+file_id+')">测试报告</a></td>';
			}else{
				temp+='<td class="tab_tr1_td6"></td>';
			}
			temp+='<td class="tab_tr1_td7">合格</td>'
				+'<td class="tab_tr1_td8">'+this.update_date+'</td>'
				+'</tr>';
		});
		$("#mydevicemanager_tab").append(temp);
		$("#mydevicemanager_tab .tab_tr2").each(function(){
			if($(this).text().indexOf(kw)==-1&&($(this).find("a.link_tooltip").length==0||$(this).find("a.link_tooltip").attr("title").indexOf(kw)==-1)){
				$(this).remove();
			}
		});
		showLinkToolTip($("#mydevicemanager_tab .tab_tr2"));
		$("#mydevicemanager_tab .tab_tr2").unbind("click").click(function(){
			showDialog(0,$(this).attr("device_id").replace("device_",""));
		});
	}else if(device_pageType==5){
		$("#devicemanager_tab .tab_tr2").remove();
		var temp='';
		allpage=Math.ceil(deviceJson.length/pageRow);
		if(nowpage_device>allpage){
			nowpage_device=allpage;
		}
		if(allpage<2){
			nowpage_device=allpage=1;
		}
		var end=nowpage_device*pageRow;
		var start=end-pageRow;
		$(deviceJson).each(function(i){
			if(i>=end){
				return false;
			}
			if(i>=start){
				temp+='<tr class="tab_tr2">'
					+'<td class="tab_tr1_td1">'+this.idStr+'</td>'
					+'<td class="tab_tr1_td2 tooltip_div">'+this.sn+'</td>'
					+'<td class="tab_tr1_td3 tooltip_div">'+this.project_id+'</td>'
					+'<td class="tab_tr1_td4 tooltip_div">'+this.project_name+'</td>';
				var file_id=this.file_path?this.file_path.id:0;
				if(this.circuit_cards&&this.circuit_cards.length>0){
					var circuit_card='<table class=\'tooltip_table\'>';
					$(this.circuit_cards).each(function(i){
						circuit_card+='<tr><td>名称：</td><td>'+this.name+'</td><td>批次号:</td><td>'+this.sn+'</td></tr>';
					});
					circuit_card+='</table>';
					temp+='<td class="tab_tr1_td5"><div id="link"><a class="device_detail link_tooltip" onclick="showDetail(&quot'
						+circuit_card+'&quot);" title="'+circuit_card+'">详细...</a></div>	</td>';
				}else{
					temp+='<td class="tab_tr1_td5"></td>';
				}
				if(file_id>0){
					temp+='<td class="tab_tr1_td6"><a class="img_a" href="javascript:void()" '
						+'onclick="this.blur();fileDown('+file_id+')">测试报告</a></td>';
				}else{
					temp+='<td class="tab_tr1_td6"></td>';
				}
					
				temp+='<td class="tab_tr1_td7">合格</td>'
				+'<td class="tab_tr1_td8">'+this.update_date+'</td>'
				+'<td class="tab_tr1_td10 tooltip_div">'+this.address+'</td>'
				+'<td class="tab_tr1_td11">'+this.ship_date+'</td>'
				+'<td class="tab_tr1_td12">'+this.aog_date+'</td>'
				+'<td class="tab_tr1_td13">'+stateArray[this.state]+'</td>'
				+'</tr>';
			}
		});
		$("#devicemanager_tab").append(temp);
		showToolTip($("#devicemanager_tab .tab_tr2"));
		showLinkToolTip($("#devicemanager_tab .tab_tr2"));
		handlepage();
	}
}
/**
 * 选择模板
 */
function changeTemp(){
	var temp_id=$("#temp_select").val();
	if(temp_id>0){
		$(tempJson).each(function(){
			if(this.id==temp_id){
				var temp='';
				$(this.circuit_cards).each(function(){
					temp+='<div><span class="device_dialog_name1">名称：</span>'
						+'<span class="device_dialog_value1">'+this.name+'</span>'
						+'<span class="device_dialog_name2">批次号：</span>'
						+'<input type="text" maxlength="50" class="device_dialog_value2"></div>';
				});
				$(".device_dialog_content").html(temp);
				return false;
			}
		});
	}else{
		$(".device_dialog_content").html("");
	}
}
//页数
function handlepage(){
	var temp='';
	if(nowpage_device<2){
		temp+='<span class="span_nomal">首页</span><span class="span_nomal">&lt;</span>';
	}else{
		temp+='<span class="span_press" onclick="pageBegin(false);">首页</span><span class="span_press" onclick="pageUP();">&lt;</span>';
	}
	temp+='<span class="span_page">'+nowpage_device+'/'+allpage+'</span>';
	if(nowpage_device<allpage){
		temp+='<span class="span_press" onclick="pageDown();">&gt;</span><span class="span_press" onclick="pageLast();">尾页</span>';
	}else{
		temp+='<span class="span_nomal">&gt;</span><span class="span_nomal">尾页</span>';
	}
	$(".td2_div5").html(temp);
}
function pageBegin(flag){
	if(flag){
		//强制刷新
		device_change=true;
	}else{
		//具体看其它条件
		//device_change=true;
	}
	nowpage_device=1;
	getDevice();
}
function pageUP(){
	if(nowpage_device > 1){
		nowpage_device--;
		getDevice();
	}else{
		initdiglog2("提示信息","已经是首页！");
	}
}
function pageDown(){
	if(nowpage_device < allpage){
		nowpage_device++;
		getDevice();
	}else{
		initdiglog2("提示信息","已经是最后一页！");
	}
}
function pageLast(){
	nowpage_device=allpage;
	getDevice();
}
function resetFilter(){
	device_change=true;
	$("#state_parent input").prop("checked",true);
	if($("#newtime_device").prop("checked")){
		$("#newtime_device").prop("checked",false);
		$("#newtime_div").css({display:"none"});
	}
	getDevice();
}
function adv_search(){
	$("#td2_div2").slideToggle();
	if(flag==0){
		$("#img_adv").attr("title","收起筛选");
		$("#img_adv").attr("src","images/search_normal.jpg");
		flag=1;
	}else{
		$("#img_adv").attr("title","显示筛选");
		$("#img_adv").attr("src","images/search_press.jpg");
		flag=0;
	}
}
function setTimeFilter(){
	if($("#newtime_device").get(0).checked){
		$("#newtime_div").css({display:"block"});
	}else{
		$("#newtime_div").css({display:"none"});
	}
}
function stateFilter(index){
	device_change=true;
	var ifselected=false;
	var stateType= document.getElementsByName("stateType");
	for(var i=0;i<stateType.length;i++){
		if(stateType[i].checked){
			ifselected=true;
		}
	}
	if(!ifselected){
		$("input[name='stateType']").get(index).checked=true;
		initdiglog2("提示信息","请至少选择一个状态作为筛选条件！");
	}
}
function setTime(time,obj){
	if(obj==document.getElementById("starttime_device")){
		//修改time1的时间
    	if(compareTime1(time,$("#endtime_device").val())){
    		obj.value=time;
    		device_change=true;
    	}else{
    		initdiglog2("提示信息","开始时间不能晚于结束时间！");
    	}
	}else{
		//修改time2的时间
    	if(compareTime1($("#starttime_device").val(),time)){
    		obj.value=time;
    		device_change=true;
    	}else{
    		initdiglog2("提示信息","结束时间不能早于开始时间！");
    	}
	}
}
function showDetail(detail){
	initdiglog4("印制板详情",detail);
	event.stopPropagation();
}
$(function(){
	$("body").append('<div id="device_file_parent" style="display:none"><input type="file" name="device_file_div" id="device_file_div" multiple="multiple"></div>');
	
});
function delfile(filename,jq_me){
	$("#device_file_parent a").click();
	$(".device_dialog_filelist").html("");
}
function uploadFileSuccess(filename){
	$(".device_dialog_filelist").html('<span>'+filename+'</span><a href="javascript:void(0)" onclick="delfile(&quot;'+filename+'&quot;'+',$(this))" >删除</a>');
}
function delFile(filename){
	initdiglogtwo2("提示信息","你确定要删除文件<br/>【"+filename+"】吗？");
	$( "#confirm2" ).click(function() {
		$( "#twobtndialog" ).dialog( "close" );
		$(".device_dialog_filelist").html("");
	});
}