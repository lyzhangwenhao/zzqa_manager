$("<link>")
    .attr({ rel: "stylesheet",
        type: "text/css",
        href: "css/dialog.css"
    })
    .appendTo("body");
    $("<link>")
    .attr({ rel: "stylesheet",
        type: "text/css",
        href: "css/dialog.css"
    })
    .appendTo("head");
//确认对话框 弹出对话框，背景变色且不可点击
function initdiglog2(title,content,callback){
	var callback=arguments.length>2&&callback;
	$("#onebtndialog").remove();
	if(!document.getElementById("zzjs_net")){
		var temp1='<div id="zzjs_net" style="position: fixed;top: 0;left: 0;width: 100%;height: 100%;opacity:0.3;filter:alpha(opacity=0.3);background-color:#000000;z-index:2;left:0px;display:none;"></div>';
		$("body").append(temp1);
	}
	var temp='<div id="onebtndialog" title="'+title+'" style="text-align:center">'+
				'<p style="font-family: microsoft yahei;font-size: 15px;margin-top: 20px;">'+content+'</p><p style="margin-top: 25px;"><img id="confirm1" src="./images/dialog_ok.png" style="cursor:pointer" tabindex="1"/></p></div>';
	$("body").append(temp);
	locking();
	$( "#onebtndialog" ).dialog({
 		autoOpen: true,
 		position:{
 			using:function(pos){
 				$(this).css('top',$(document).scrollTop()+200);
 				$(this).css('left',pos.left);
 			}
 		},
 		close: function(){
 			Lock_CheckForm();
 			$("#onebtndialog").remove();
 			if(callback){
 				doNext();
 			}
 		}
	});
    $( "#confirm1" ).click(function() {
		$( "#onebtndialog" ).dialog( "close" );
	});
    $('#confirm1').bind('keydown',function(event){
	    if(event.keyCode == "13") $('#confirm1').click();
	});
}

//确认对话框 弹出对话框，背景变色且不可点击，内容左对齐
function initdiglog4(title,content,btnname){
	$("#onebtndialog").remove();
	if(!document.getElementById("zzjs_net")){
		var temp1='<div id="zzjs_net" style="position: fixed;top: 0;left: 0;width: 100%;height: 100%;opacity:0.3;filter:alpha(opacity=0.3);background-color:#000000;z-index:2;left:0px;display:none;"></div>';
		$("body").append(temp1);
	}
	var temp='<div id="onebtndialog" title="'+title+'" style="text-align:center">'+
				'<div style="font-family: microsoft yahei;font-size: 15px;text-align:left;margin-top: 20px;">'+content+'</div><p style="margin-top: 25px;"><img id="confirm1" src="./images/dialog_ok.png" style="cursor:pointer" tabindex="1"/></p></div>';
	$("body").append(temp);
	locking();
	$( "#onebtndialog" ).dialog({
 		autoOpen: true,
 		width:'auto',
 		height:'auto',
 		position:{
 			using:function(pos){
 				$(this).css('top',$(document).scrollTop()+200);
 				$(this).css('left',pos.left);
 			}
 		},
 		close: function(){
 			Lock_CheckForm();
 			$("#onebtndialog").remove();
 		}
	});
	$( "#confirm1" ).click(function() {
		$( "#onebtndialog" ).dialog( "close" );
	});
	$('#confirm1').bind('keydown',function(event){
	    if(event.keyCode == "13") $('#confirm1').click();
	});
}
//选择对话框 弹出对话框，背景变色且不可点击
function initdiglogtwo2(title,content){
	$("#twobtndialog").remove();
	if(!document.getElementById("zzjs_net")){
		var temp1='<div id="zzjs_net" style="position: fixed;top: 0;left: 0;width: 100%;height: 100%;opacity:0.3;filter:alpha(opacity=0.3);background-color:#000000;z-index:2;left:0px;display:none;"></div>';
		$("body").append(temp1);
	}
	var temp='<div id="twobtndialog" title="'+title+'" style="text-align:center;">'+
			'<p style="font-family: microsoft yahei;font-size: 15px;margin-top: 20px;">'+content+'</p><p style="margin-top: 25px;"><img id="confirm2" src="./images/dialog_ok.png" style="cursor:pointer" tabindex="1"/><img id="cancelbtn" style="margin-left:20px;cursor:pointer" src="./images/dialog_cancel.png"/></p></div>';
	$("body").append(temp);
	$( "#twobtndialog" ).dialog({
 		autoOpen: true,
 		position:{
 			using:function(pos){
 				$(this).css('top',$(document).scrollTop()+200);
 				$(this).css('left',pos.left);
 			}
 		},
 		close: function(){
 			Lock_CheckForm();
 			$("#twobtndialog").remove();
 		}
	});
	locking();
	$( "#cancelbtn" ).click(function() {
		$( "#twobtndialog" ).dialog( "close" );
	});
	$('#confirm2').bind('keydown',function(event){
	    if(event.keyCode == "13") $('#confirm2').click();
	});
}
//选择对话框 弹出对话框，背景变色且不可点击,cancelBack对话框销毁后的回调方法
function initdiglogtwo3(title,content){
	$("#twobtndialog").remove();
	if(!document.getElementById("zzjs_net")){
		var temp1='<div id="zzjs_net" style="position: fixed;top: 0;left: 0;width: 100%;height: 100%;opacity:0.3;filter:alpha(opacity=0.3);background-color:#000000;z-index:2;left:0px;display:none;"></div>';
		$("body").append(temp1);
	}
	var temp='<div id="twobtndialog" title="'+title+'" style="text-align:center">'+
			'<p style="font-family: microsoft yahei;font-size: 15px;margin-top: 20px;">'+content+'</p><p style="margin-top: 25px;"><img id="confirm2" src="./images/dialog_ok.png" style="cursor:pointer" tabindex="1"/><img id="cancelbtn" style="margin-left:20px;cursor:pointer" src="./images/dialog_cancel.png"/></p></div>';
	$("body").append(temp);
	$( "#twobtndialog" ).dialog({
 		autoOpen: true,
 		position:{
 			using:function(pos){
 				$(this).css('top',$(document).scrollTop()+200);
 				$(this).css('left',pos.left);
 			}
 		},
 		close: function(){
 			Lock_CheckForm();
 			cancelBack();
 			$("#twobtndialog").remove();
 		}
	});
	locking();
	$( "#cancelbtn" ).click(function() {
		$( "#twobtndialog" ).dialog( "close" );
	});
	$('#confirm2').bind('keydown',function(event){
	    if(event.keyCode == "13") $('#confirm2').click();
	});
}
//选择对话框 弹出对话框，背景变色且不可点击
function initdiglogInput2(title){
	$("#twobtndialog").remove();
	if(!document.getElementById("zzjs_net")){
		var temp1='<div id="zzjs_net" style="position: fixed;top: 0;left: 0;width: 100%;height: 100%;opacity:0.3;filter:alpha(opacity=0.3);background-color:#000000;z-index:2;left:0px;display:none;"></div>';
		$("body").append(temp1);
	}
	var temp='<div id="twobtndialog" title="'+title+'" style="text-align:center;font-size:14px;font-family: microsoft yahei;">'+
			'<div style="margin-top:25px;">密&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp码:&nbsp&nbsp&nbsp<input type="password" id="dialog_password" onkeydown="if(event.keyCode==32) return false;" style="padding:0px 5px;width:150px;height:25px;font-size:13px;" maxlength="35"></div>'+
			'<div style="margin-top:10px;">确认密码:&nbsp&nbsp&nbsp<input type="password" id="dialog_confirmPass" onkeydown="if(event.keyCode==32) return false;" style="padding:0px 5px;height:25px;width:150px;font-size:13px;" maxlength="35"></div>'+
			'<p style="margin-top: 25px;"><img id="confirm2" src="./images/dialog_ok.png" style="cursor:pointer" tabindex="1"/><img id="cancelbtn" style="margin-left:20px;cursor:pointer" src="./images/dialog_cancel.png" /></p></div>';
	$("body").append(temp);
	$( "#twobtndialog" ).dialog({
 		autoOpen: true,
 		position:{
 			using:function(pos){
 				$(this).css('top',$(document).scrollTop()+200);
 				$(this).css('left',pos.left);
 			}
 		},
 		close: function(){
 			Lock_CheckForm();
 			$("#twobtndialog").remove();
 		}
	});
	locking();
	$( "#cancelbtn" ).click(function() {
		$( "#twobtndialog" ).dialog( "close" );
	});
	$('#confirm2').bind('keydown',function(event){
	    if(event.keyCode == "13") $('#confirm2').click();
	});
}
//弹出对话框，背景变色且不可点击
function locking(){
	document.all.zzjs_net.style.display="block";
}	
function Lock_CheckForm(){
	document.all.zzjs_net.style.display='none';
}	

jQuery.extend(jQuery, {
  // jQuery UI confirm弹出确认提示
  jqconfirm: function(text, title, fn1, fn2) {
    	$("#twobtndialog").remove();
		if(!document.getElementById("zzjs_net")){
			var temp1='<div id="zzjs_net" style="position: fixed;top: 0;left: 0;width: 100%;height: 100%;opacity:0.3;filter:alpha(opacity=0.3);background-color:#000000;z-index:2;left:0px;display:none;"></div>';
			$("body").append(temp1);
		}
		var temp='<div id="twobtndialog" title="'+title+'" style="text-align:center">'+
				'<p style="font-family: microsoft yahei;font-size: 15px;margin-top: 20px;">'+text+'</p><p style="margin-top: 25px;"><img id="confirm2" src="./images/dialog_ok.png" style="cursor:pointer" tabindex="1"/><img id="cancelbtn" style="margin-left:20px;cursor:pointer" src="./images/dialog_cancel.png"/></p></div>';
		$("body").append(temp);
		var flag=0;
		var dlg="";
		$( "#twobtndialog" ).dialog({
			autoOpen: true,
			close: function(){
				Lock_CheckForm();
				if(flag==1){
					fn1 && fn1.call(dlg, true);
				}else{
					fn2 && fn2(dlg, false);
				}
			}
		});
		locking();
		$( "#cancelbtn" ).click(function() {
			dlg = $( "#twobtndialog" ).dialog( "close" );
		});
	    $( "#confirm2" ).click(function() {
	    	flag=1;
			dlg = $( "#twobtndialog" ).dialog( "close" );
		})

  },
  // jQuery UI 弹出iframe窗口
  jqopen: function(url, options) {
    var html =
    '<div class="dialog" id="dialog-window" title="提示信息">' +
    ' <iframe src="' + url + '" frameBorder="0" style="border: 0; " scrolling="auto" width="100%" height="100%"></iframe>' +
    '</div>';
    return $(html).dialog($.extend({
      modal: true,
      closeOnEscape: false,
      draggable: false,
      resizable: false,
      close: function(event, ui) {
        $(this).dialog("destroy"); // 关闭时销毁
      }
    }, options));
  },
  // jQuery UI confirm提示
  confirm: function(evt,title, text) {
    evt = $.event.fix(evt);
    var me = evt.target;
    if (me.confirmResult) {
      me.confirmResult = false;
      return true;
    }
    jQuery.jqconfirm(text, title, function(e) {
      me.confirmResult = true;
      if (e) {
        if (me.href && $.trim(me.href).indexOf("javascript:") == 0) {
          $.globalEval(me.href);
          me.confirmResult = false;
          return;
        }
        var t = me.type && me.type.toLowerCase();
        if (t && me.name && (t == "image" || t == "submit" || t == "button")) {
          __doPostBack(me.name, "");
          me.confirmResult = false;
          return;
        }
        if (me.click) me.click(evt);
      }
      return false;
    });
    return false;
  }
});