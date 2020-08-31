var successUploadFileNum1=0;
var successUploadFileNum2=0;
var successUploadFileNum3=0;
var successUploadFileNum4=0;
var successUploadFileNum5=0;
$(document).ready(function(){
    var body = $(document.body),
        filer_default_opts = {
            changeInput2: '<div class="jFiler-input-dragDrop"><div class="jFiler-input-inner"><div class="jFiler-input-icon"><i class="icon-jfi-cloud-up-o"></i></div><div class="jFiler-input-text"><h3>Drag&Drop files here</h3> <span style="display:inline-block; margin: 15px 0">or</span></div><a class="jFiler-input-choose-btn blue-light">Browse Files</a></div></div>',
            limit: null,
            templates: {
                box: '<ul class="jFiler-items-list jFiler-items-grid"></ul>',
                item: '<li class="jFiler-item" style="width: 49%">\
                            <div class="jFiler-item-container">\
                                <div class="jFiler-item-inner">\
                                    <div class="jFiler-item-thumb">\
                                        <div class="jFiler-item-status"></div>\
                                        <div class="jFiler-item-info">\
                                            <span class="jFiler-item-title"><b title="{{fi-name}}">{{fi-name | limitTo: 25}}</b></span>\
                                            <span class="jFiler-item-others">{{fi-size2}}</span>\
                                        </div>\
                                        {{fi-image}}\
                                    </div>\
                                    <div class="jFiler-item-assets jFiler-row">\
                                        <ul class="list-inline pull-left">\
                                            <li>{{fi-progressBar}}</li>\
                                        </ul>\
                                        <ul class="list-inline pull-right">\
                                            <li><a class="icon-jfi-trash jFiler-item-trash-action"></a></li>\
                                        </ul>\
                                    </div>\
                                </div>\
                            </div>\
                        </li>',
                itemAppend: '<li class="jFiler-item" style="width: 49%">\
                                <div class="jFiler-item-container">\
                                    <div class="jFiler-item-inner">\
                                        <div class="jFiler-item-thumb">\
                                            <div class="jFiler-item-status"></div>\
                                            <div class="jFiler-item-info">\
                                                <span class="jFiler-item-title"><b title="{{fi-name}}">{{fi-name | limitTo: 25}}</b></span>\
                                                <span class="jFiler-item-others">{{fi-size2}}</span>\
                                            </div>\
                                            {{fi-image}}\
                                        </div>\
                                        <div class="jFiler-item-assets jFiler-row">\
                                            <ul class="list-inline pull-left">\
                                                <li><span class="jFiler-item-others">{{fi-icon}}</span></li>\
                                            </ul>\
                                            <ul class="list-inline pull-right">\
                                                <li><a class="icon-jfi-trash jFiler-item-trash-action"></a></li>\
                                            </ul>\
                                        </div>\
                                    </div>\
                                </div>\
                            </li>',
                progressBar: '<div class="bar"></div>',
                itemAppendToEnd: false,
                removeConfirmation: true,
                _selectors: {
                    list: '.jFiler-items-list',
                    item: '.jFiler-item',
                    progressBar: '.bar',
                    remove: '.jFiler-item-trash-action'
                }
            },
            uploadFile: {
               
            },
            onRemove: function(itemEl, file, id, listEl, boxEl, newInputEl, inputEl){
                var file = file.name;
                
            },
        };
    
    //Run PrettyPrint
    prettyPrint();
    
    //Pre Collapse
    $('.pre-collapse').on("click", function(e){
        var collapse_class = 'collapsed',
            title = ["<i class=\"fa fa-code pull-left\"></i> + Show the source code", "<i class=\"fa fa-code pull-left\"></i> - Hide the source code"],
            $parent = $(this).closest('.pre-box'),
            $pre = $parent.find('pre').first();
        
        if($parent.hasClass(collapse_class)){
            $pre.slideDown("fast", function(){
                $parent.removeClass(collapse_class);
            });
            $(this).html(title[1]);
        }else{
            $pre.slideUp("fast", function(){
                $parent.addClass(collapse_class);
            });
            $(this).html(title[0]);
        }
    });
/***limit:1表示同时只能上传1个文件，servlet读取的表单位name字段，大于1时，name字段后面加“[]”**/
	$('#file_input1').filer({
    	limit: 1,
        maxSize: 40,
    	showThumbs: true,
	    templates: {
	        progressBar: '<div class="bar"></div>',
	        itemAppendToEnd: true,
	        removeConfirmation: true,
	        _selectors: {
	            list: '.jFiler-items-list',
	            item: '.jFiler-item',
	            progressBar: '.bar',
	            remove: '.jFiler-item-trash-action'
	        }
	    },
	    uploadFile: {
	        url: "HandelTempFileServlet?type=upload&file_type=1",
	        data: null,
	        type: 'POST',
	        enctype: 'multipart/form-data',
	        beforeSend: function(){},
	        success: function(data, el){
	            if(data==1){
	        		successUploadFileNum1++;//上传成功
		            var parent = el.find(".jFiler-jProgressBar").parent();
		            el.find(".jFiler-jProgressBar").fadeOut("slow", function(){
		                $("<div class=\"jFiler-item-others text-success\"><i class=\"icon-jfi-check-circle\"></i> Success</div>").hide().appendTo(parent).fadeIn("slow");    
		            });
	        	}else{
	        		var parent = el.find(".jFiler-jProgressBar").parent();
		            el.find(".jFiler-jProgressBar").fadeOut("slow", function(){
		                $("<div class=\"jFiler-item-others text-error\" style=\"color:#ff0000\"><i class=\"icon-jfi-minus-circle\"></i> Error</div>").hide().appendTo(parent).fadeIn("slow");    
		            });
	        	}
	        },
	        error: function(el){
	            var parent = el.find(".jFiler-jProgressBar").parent();
	            el.find(".jFiler-jProgressBar").fadeOut("slow", function(){
	                $("<div class=\"jFiler-item-others text-error\" style=\"color:#ff0000\"><i class=\"icon-jfi-minus-circle\"></i> Error</div>").hide().appendTo(parent).fadeIn("slow");    
	            });
	        },
	        statusCode: null,
	        onProgress: null,
	        onComplete: null
	    },
	    onRemove: function(itemEl, file){
	        var file = file.name;
	        //$.post('HandelTempFileServlet?type=delete&file_type=1', {file: file});
			$.ajax({
				type:"post",//post方法
				url:"HandelTempFileServlet",
				data:{"type":"delete","file_type":1,"file":file},
				//ajax成功的回调函数
				success:function(returnData){
					if(returnData==1){
						successUploadFileNum1--;//删除之前上传成功的文件）
					}
				}
			});
	    }
    });
	$('#file_input2').filer({
       limit: 1,
        maxSize: 40,
    	showThumbs: true,
	    templates: {
	        progressBar: '<div class="bar"></div>',
	        itemAppendToEnd: true,
	        removeConfirmation: true,
	        _selectors: {
	            list: '.jFiler-items-list',
	            item: '.jFiler-item',
	            progressBar: '.bar',
	            remove: '.jFiler-item-trash-action'
	        }
	    },
	    uploadFile: {
	        url: "HandelTempFileServlet?type=upload&file_type=2",
	        data: null,
	        type: 'POST',
	        enctype: 'multipart/form-data',
	        beforeSend: function(){},
	        success: function(data, el){
	            if(data==1){
	        		successUploadFileNum2++;//上传成功
		            var parent = el.find(".jFiler-jProgressBar").parent();
		            el.find(".jFiler-jProgressBar").fadeOut("slow", function(){
		                $("<div class=\"jFiler-item-others text-success\"><i class=\"icon-jfi-check-circle\"></i> Success</div>").hide().appendTo(parent).fadeIn("slow");    
		            });
	        	}else{
	        		var parent = el.find(".jFiler-jProgressBar").parent();
		            el.find(".jFiler-jProgressBar").fadeOut("slow", function(){
		                $("<div class=\"jFiler-item-others text-error\" style=\"color:#ff0000\"><i class=\"icon-jfi-minus-circle\"></i> Error</div>").hide().appendTo(parent).fadeIn("slow");    
		            });
	        	}
	        },
	        error: function(el){
	            var parent = el.find(".jFiler-jProgressBar").parent();
	            el.find(".jFiler-jProgressBar").fadeOut("slow", function(){
	                $("<div class=\"jFiler-item-others text-error\" style=\"color:#ff0000\"><i class=\"icon-jfi-minus-circle\"></i> Error</div>").hide().appendTo(parent).fadeIn("slow");    
	            });
	        },
	        statusCode: null,
	        onProgress: null,
	        onComplete: null
	    },
	    onRemove: function(itemEl, file){
	    	var file = file.name;
	        //$.post('HandelTempFileServlet?type=delete&file_type=2', {file: file});
			$.ajax({
				type:"post",//post方法
				url:"HandelTempFileServlet",
				data:{"type":"delete","file_type":2,"file":file},
				//ajax成功的回调函数
				success:function(returnData){
					if(returnData==1){
						successUploadFileNum2--;//删除之前上传成功的文件）
					}
				}
			});
	    }
    });
    $('#file_input3').filer({
        limit: 1,
        maxSize: 40,
    	showThumbs: true,
	    templates: {
	        progressBar: '<div class="bar"></div>',
	        itemAppendToEnd: true,
	        removeConfirmation: true,
	        _selectors: {
	            list: '.jFiler-items-list',
	            item: '.jFiler-item',
	            progressBar: '.bar',
	            remove: '.jFiler-item-trash-action'
	        }
	    },
	    uploadFile: {
	        url: "HandelTempFileServlet?type=upload&file_type=3",
	        data: null,
	        type: 'POST',
	        enctype: 'multipart/form-data',
	        beforeSend: function(){},
	        success: function(data, el){
	            if(data==1){
	        		successUploadFileNum3++;//上传成功
		            var parent = el.find(".jFiler-jProgressBar").parent();
		            el.find(".jFiler-jProgressBar").fadeOut("slow", function(){
		                $("<div class=\"jFiler-item-others text-success\"><i class=\"icon-jfi-check-circle\"></i> Success</div>").hide().appendTo(parent).fadeIn("slow");    
		            });
	        	}else{
	        		var parent = el.find(".jFiler-jProgressBar").parent();
		            el.find(".jFiler-jProgressBar").fadeOut("slow", function(){
		                $("<div class=\"jFiler-item-others text-error\" style=\"color:#ff0000\"><i class=\"icon-jfi-minus-circle\"></i> Error</div>").hide().appendTo(parent).fadeIn("slow");    
		            });
	        	}
	        },
	        error: function(el){
	            var parent = el.find(".jFiler-jProgressBar").parent();
	            el.find(".jFiler-jProgressBar").fadeOut("slow", function(){
	                $("<div class=\"jFiler-item-others text-error\" style=\"color:#ff0000\"><i class=\"icon-jfi-minus-circle\"></i> Error</div>").hide().appendTo(parent).fadeIn("slow");    
	            });
	        },
	        statusCode: null,
	        onProgress: null,
	        onComplete: null
	    },
	    onRemove: function(itemEl, file){
	    	var file = file.name;
	        //$.post('HandelTempFileServlet?type=delete&file_type=3', {file: file});
			$.ajax({
				type:"post",//post方法
				url:"HandelTempFileServlet",
				data:{"type":"delete","file_type":3,"file":file},
				//ajax成功的回调函数
				success:function(returnData){
					if(returnData==1){
						successUploadFileNum3--;//删除之前上传成功的文件）
					}
				}
			});
	    }
    });
	$('#file_input4').filer({
        limit: 1,
        maxSize: 40,
    	showThumbs: true,
	    templates: {
	        progressBar: '<div class="bar"></div>',
	        itemAppendToEnd: true,
	        removeConfirmation: true,
	        _selectors: {
	            list: '.jFiler-items-list',
	            item: '.jFiler-item',
	            progressBar: '.bar',
	            remove: '.jFiler-item-trash-action'
	        }
	    },
	    uploadFile: {
	        url: "HandelTempFileServlet?type=upload&file_type=4",
	        data: null,
	        type: 'POST',
	        enctype: 'multipart/form-data',
	        beforeSend: function(){},
	        success: function(data, el){
	            if(data==1){
	        		successUploadFileNum4++;//上传成功
		            var parent = el.find(".jFiler-jProgressBar").parent();
		            el.find(".jFiler-jProgressBar").fadeOut("slow", function(){
		                $("<div class=\"jFiler-item-others text-success\"><i class=\"icon-jfi-check-circle\"></i> Success</div>").hide().appendTo(parent).fadeIn("slow");    
		            });
	        	}else{
	        		var parent = el.find(".jFiler-jProgressBar").parent();
		            el.find(".jFiler-jProgressBar").fadeOut("slow", function(){
		                $("<div class=\"jFiler-item-others text-error\" style=\"color:#ff0000\"><i class=\"icon-jfi-minus-circle\"></i> Error</div>").hide().appendTo(parent).fadeIn("slow");    
		            });
	        	}
	        },
	        error: function(el){
	            var parent = el.find(".jFiler-jProgressBar").parent();
	            el.find(".jFiler-jProgressBar").fadeOut("slow", function(){
	                $("<div class=\"jFiler-item-others text-error\" style=\"color:#ff0000\"><i class=\"icon-jfi-minus-circle\"></i> Error</div>").hide().appendTo(parent).fadeIn("slow");    
	            });
	        },
	        statusCode: null,
	        onProgress: null,
	        onComplete: null
	    },
	    onRemove: function(itemEl, file){
	    	var file = file.name;
	        //$.post('HandelTempFileServlet?type=delete&file_type=4', {file: file});
			$.ajax({
				type:"post",//post方法
				url:"HandelTempFileServlet",
				data:{"type":"delete","file_type":4,"file":file},
				//ajax成功的回调函数
				success:function(returnData){
					if(returnData==1){
						successUploadFileNum4--;//删除之前上传成功的文件）
					}
				}
			});
	    }
    });
    $('#file_input5').filer({
        limit: 10,
        maxSize: 40,
    	showThumbs: true,
	    templates: {
	        progressBar: '<div class="bar"></div>',
	        itemAppendToEnd: true,
	        removeConfirmation: true,
	        _selectors: {
	            list: '.jFiler-items-list',
	            item: '.jFiler-item',
	            progressBar: '.bar',
	            remove: '.jFiler-item-trash-action'
	        }
	    },
	    uploadFile: {
	        url: "HandelTempFileServlet?type=upload&file_type=5",
	        data: null,
	        type: 'POST',
	        enctype: 'multipart/form-data',
	        beforeSend: function(){},
	        success: function(data, el){
	            if(data==1){
	        		successUploadFileNum5++;//上传成功
		            var parent = el.find(".jFiler-jProgressBar").parent();
		            el.find(".jFiler-jProgressBar").fadeOut("slow", function(){
		                $("<div class=\"jFiler-item-others text-success\"><i class=\"icon-jfi-check-circle\"></i> Success</div>").hide().appendTo(parent).fadeIn("slow");    
		            });
	        	}else{
	        		var parent = el.find(".jFiler-jProgressBar").parent();
		            el.find(".jFiler-jProgressBar").fadeOut("slow", function(){
		                $("<div class=\"jFiler-item-others text-error\" style=\"color:#ff0000\"><i class=\"icon-jfi-minus-circle\"></i> Error</div>").hide().appendTo(parent).fadeIn("slow");    
		            });
	        	}
	        },
	        error: function(el){
	            var parent = el.find(".jFiler-jProgressBar").parent();
	            el.find(".jFiler-jProgressBar").fadeOut("slow", function(){
	                $("<div class=\"jFiler-item-others text-error\" style=\"color:#ff0000\"><i class=\"icon-jfi-minus-circle\"></i> Error</div>").hide().appendTo(parent).fadeIn("slow");    
	            });
	        },
	        statusCode: null,
	        onProgress: null,
	        onComplete: null
	    },
	    onRemove: function(itemEl, file){
	    	var file = file.name;
	        //$.post('HandelTempFileServlet?type=delete&file_type=5', {file: file});
			$.ajax({
				type:"post",//post方法
				url:"HandelTempFileServlet",
				data:{"type":"delete","file_type":5,"file":file},
				//ajax成功的回调函数
				success:function(returnData){
					if(returnData==1){
						successUploadFileNum5--;//删除之前上传成功的文件）
					}
				}
			});
	    }
    });
    $('#file_excel').filer({
        limit: 1,
        maxSize: 21,//作为禁用删除对话框的标记，不可改
        extensions: ['xls','xlsx','xlsm','xlsb','xlam','xlt','xltx','xltm','et','ett'],//过滤扩展格式
    	showThumbs: true,
	    templates: {
	        progressBar: '<div class="bar"></div>',
	        itemAppendToEnd: true,
	        removeConfirmation: true,
	        _selectors: {
	            list: '.jFiler-items-list',
	            item: '.jFiler-item',
	            progressBar: '.bar',
	            remove: '.jFiler-item-trash-action'
	        }
	    },
	    uploadFile: {
	        url: "HandelTempFileServlet?type=upload_excel&nowFlow="+(typeof(nowFlow)=="undefined"?"":nowFlow),
	        data: null,
	        type: 'POST',
	        dataType:"json",
	        enctype: 'multipart/form-data',
	        beforeSend: function(){},
	        success: function(data, el){
	        	$("#exportExcel_div a").click();
	        	if(typeof(nowFlow)=="undefined"){
	        		if(data.length>1){
		            	if(eval(data)[0].flag!=0){
		            		importExcel(data);
		            	}else{
		            		initdiglog2("提示信息", "抱歉，不支持该文件格式，请尝试另存为转成 excel 2003 (*.xls)！");
		            	}
		        	}else{
		        		initdiglog2("提示信息", "数据异常，导入失败！");
		        	}
	        	}else if(nowFlow=="material_report"){
	        		var flag=eval(data)[0].flag;
	        		if(flag==0){
	        			initdiglog2("提示信息", "数据异常，导入失败！");
	            	}else if(flag==1){
	            		initdiglog2("提示信息", "导入成功！",true);
	            	}else if(flag==2){
	            		initdiglog2("提示信息", "导入的型号重复，导入失败！");
	            	}else if(flag==3){
	            		initdiglog2("提示信息", "抱歉，不支持该文件格式，请尝试另存为转成 excel 2003 (*.xls)！");
	            	}else{
	            		initdiglog2("提示信息", "没有数据！");
	            	}
	        	}else if(nowFlow=="customer_report"||nowFlow=="supplier_report"){
	        		var flag=eval(data)[0].flag;
	        		if(flag==0){
	        			initdiglog2("提示信息", "数据异常，导入失败！");
	            	}else if(flag==1){
	            		initdiglog2("提示信息", "导入成功！",true);
	            	}else if(flag==2){
	            		initdiglog2("提示信息", "导入的单位名称重复，导入失败！");
	            	}else if(flag==3){
	            		initdiglog2("提示信息", "抱歉，不支持该文件格式，请尝试另存为转成 excel 2003 (*.xls)！");
	            	}else{
	            		initdiglog2("提示信息", "没有数据！");
	            	}
	        	}else{
	        		initdiglog2("提示信息", "未知错误！");
	        	}
	        },
	        error: function(el){
	        	$("#exportExcel_div a").click();
	        	initdiglog2("提示信息", "数据异常，导入失败！");
	        },
	        statusCode: null,
	        onProgress: null,
	        onComplete: null
	    },
	    onRemove: function(itemEl, file){
	    	
	    }
    });
    $('#device_file_div').filer({
    	limit: 1,
        maxSize: 21,//作为禁用删除对话框的标记，不可改
    	showThumbs: true,
	    templates: {
	        progressBar: '<div class="bar"></div>',
	        itemAppendToEnd: true,
	        removeConfirmation: true,
	        _selectors: {
	            list: '.jFiler-items-list',
	            item: '.jFiler-item',
	            progressBar: '.bar',
	            remove: '.jFiler-item-trash-action'
	        }
	    },
	    uploadFile: {
	        url: "HandelTempFileServlet?type=upload_communicate&file_type=1",//对应数据库中的字段file_type，同上，同下
	        data: null,
	        type: 'POST',
	        enctype: 'multipart/form-data',
	        beforeSend: function(){},
	        success: function(data, el){//data为filename
	        	$("#device_file_parent a").click();
	        	 if(data.length>0){
	        		successUploadFileNum1 ++;
	        		uploadFileSuccess(data);
	        	 }else{
	        		 successUploadFileNum1 ++;//统一在删除时减1
	        		 $("[title='"+data+"'].jFiler-item-title").parent().find("a").click();
	        	 }
	        },
	        error: function(el){
	        	$("#device_file_parent a").click();
	        	initdiglog2("提示信息","有一个文件上传失败！");
	        },
	        statusCode: null,
	        onProgress: null,
	        onComplete: null
	    },
	    onRemove: function(itemEl, file){
	    	successUploadFileNum1--;
	    }
    });
});
