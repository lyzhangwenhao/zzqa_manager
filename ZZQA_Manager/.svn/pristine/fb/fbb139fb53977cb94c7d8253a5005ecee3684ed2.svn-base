<%@page import="com.zzqa.util.FormTransform"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.service.interfaces.file_path.File_pathManager"%>
<%@page import="com.zzqa.pojo.file_path.File_path"%>
<%@page import="com.zzqa.pojo.notify.Notify"%>
<%@page import="com.zzqa.pojo.comments.Comments"%>
<%@page import="com.zzqa.pojo.reply.Reply"%>
<%@page import="com.zzqa.service.interfaces.communicate.CommunicateManager"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%@page import="java.text.DecimalFormat"%>
<%request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	CommunicateManager communicateManager=(CommunicateManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("communicateManager");
	File_pathManager file_pathManager=(File_pathManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("file_pathManager");
	PermissionsManager permissionsManager=(PermissionsManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("permissionsManager");
	if (session.getAttribute("uid") == null) {
		response.sendRedirect("login.jsp");
		return;
	}
	int uid = (Integer) session.getAttribute("uid");
	User mUser = userManager.getUserByID(uid);
	if (mUser == null) {
		response.sendRedirect("../login.jsp");
		return;
	}
	if(session.getAttribute("notify_id")==null){
		response.sendRedirect("../login.jsp");
		return;
	}
	int notify_id=(Integer)session.getAttribute("notify_id");
	Notify notify=communicateManager.getNotifyByID(notify_id);
	if(notify==null){
		response.sendRedirect("../login.jsp");
		return;
	}
	List<File_path> filList=file_pathManager.getAllFileByCondition(23, notify_id, 1, 0);
	List<Comments> commentsList=communicateManager.getCommentsListByCondition(3, notify_id, uid);
	boolean permission43=permissionsManager.checkPermission(mUser.getPosition_id(), 43);
	FormTransform ftf=new FormTransform();
	if(session.getAttribute("notify_index")==null){
		response.sendRedirect("../login.jsp");
		return;
	}
	int notify_index=(Integer)session.getAttribute("notify_index");
	communicateManager.updateRead_user(3, notify_id, uid);
%>

<!DOCTYPE HTML>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>通知详情</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/communicate.css">
		<link rel="stylesheet" type="text/css" href="css/mynotify.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
			var permission43=<%=permission43%>;
			function publish_comment(){
				var content=$("#comment_textarea").val();
				if(content.replace(/\s/g,'').length==0){
					initdiglog2("提示信息", "评论内容不能为空");
					return;
				}
				$.ajax({
					type:"post",//post方法
					url:"CommunicateServlet",
					data:{"type":"addComment","c_type":3,"foreign_id":<%=notify_id%>,"content":content},
					//ajax成功的回调函数
					success:function(returnData){
						if(returnData){
							initdiglog2("提示信息","添加成功！");
							$("#comment_textarea").val("");
							$(".comment_list").append(getCommentStr(returnData,content));
						}else{
							initdiglog2("提示信息","添加失败！");
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
			function getCommentStr(comments_id,content){
				var todate=getNowTime();//2017-01-03 12:35
				var comm='<div class="comment_item" id="comment_item'+comments_id+'">'
					+'<div class="comment_title"><div class="comment_name">'+"<%=mUser.getTruename()%>"+'</div><div class="comment_time">'+todate+'</div></div>'
				+'<div class="comment_content">'+transRNToBR(content)+'</div>'
				+'<div class="comment_handel" >'
				+'<a href="javascript:updatecomment('+comments_id+')">编辑</a><div></div><a href="javascript:delcomment('+comments_id+')">删除</a><div></div>'
				+(permission43?('<a href="javascript:addReplyToComment('+comments_id+')">回复</a><div></div>'):'')
				+'<a href="javascript:agree('+comments_id+',2,false,0)" id="comment_agree'+comments_id+'">赞同 </a>'
				+'</div>'
				+'<div class="reply_list"></div></div>';
				return comm;
			}
			function getReplyStr(comments_id,reply_id,content,reply_name){
				var todate=getNowTime();//2017-01-03 12:35
				var comm='<div class="reply_item" id="reply_item'+reply_id+'">'
				+'<div class="reply_title"><div class="reply_name"><span><%=mUser.getTruename()%></span>回复<span>'+reply_name+'</span></div><div class="reply_time">'+todate+'</div></div>'
				+'<div class="reply_content">'+transRNToBR(content)+'</div>'
				+'<div class="reply_handel" >'
				+'<a href="javascript:updateReply('+comments_id+','+reply_id+')">编辑</a><div></div><a href="javascript:delReply('+comments_id+','+reply_id+')">删除</a><div></div>'
				+(permission43?('<a href="javascript:addReplyToReply('+comments_id+','+reply_id+')">回复</a><div></div>'):'')
				+'<a href="javascript:agree('+reply_id+',3,false,0)" id="reply_agree'+reply_id+'">赞同 </a>'
				+'</div>';
				return comm;
			}
			function updatecomment(id){
				var area=$(".notify_reply_areatext_div");
				if(area.length==0||area.prop("id")!=("updatecomment"+id)){//已打开的不变
					clearReplyArea();
					var replyname=$("#comment_item"+id).find(".comment_name").text();
					var content=$("#comment_item"+id).find(".comment_content").html();
					var temp='<div class="notify_reply_areatext_div" id="updatecomment'+id+'"><textarea class="notify_reply_areatext" maxlength="2000" placeholder="回复 '+replyname+'：">'+transBRToRN(content)+'</textarea><div class="notify_reply_btn_div"><div onclick="updatecommentcontent('+id+')">确认修改</div><div onclick="clearReplyArea();">取消修改</div></div></div>';
					$("#comment_item"+id).append(temp);
					$(".notify_reply_areatext").focus();
				}
			}
			function updatecommentcontent(id){
				var content=$(".notify_reply_areatext").val();
				if(content.replace(/\s/g,"").length>0){
					$.ajax({
						type:"post",//post方法
						url:"CommunicateServlet",
						data:{"type":"updateComments","comments_id":id,"content":content},
						timeout : 15000, 
						//ajax成功的回调函数
						success:function(returnData){
							//删除成功
							initdiglog2("提示信息","修改成功！");
							$("#comment_item"+id).find(".comment_content").html(transRNToBR(content));
							var todate=getNowTime();//2017-01-03 12:35
							$("#comment_item"+id).find(".comment_time").text(todate);
							clearReplyArea();
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
				}else{
					initdiglog2("提示信息","回复内容不能为空");
				}
			}
			function addReplyToComment(id){
				var area=$(".notify_reply_areatext_div");
				if(area.length==0||area.prop("id")!=("addtocomment"+id)){//已打开的不变
					clearReplyArea();
					var replyname=$("#comment_item"+id).find(".comment_name").text();
					var temp='<div class="notify_reply_areatext_div" id="addtocomment'+id+'"><textarea class="notify_reply_areatext" maxlength="2000" placeholder="回复 '+replyname+'："></textarea><div class="notify_reply_btn_div"><div onclick="addReplyToCommentContent('+id+')">确认回复</div><div onclick="clearReplyArea();">取消回复</div></div></div>';
					$("#comment_item"+id).append(temp);
					$(".notify_reply_areatext").focus();
				}
			}
			function addReplyToCommentContent(id){
				var content=$(".notify_reply_areatext").val();
				if(content.replace(/\s/g,"").length>0){
					$.ajax({
						type:"post",//post方法
						url:"CommunicateServlet",
						data:{"type":"addReply","comments_id":id,"reply_id":0,"content":content},
						timeout : 15000, 
						//ajax成功的回调函数
						success:function(returnData){
							//删除成功
							initdiglog2("提示信息","发送成功！");
							clearReplyArea();
							$("#comment_item"+id).find(".reply_list").append(getReplyStr(id,returnData, content,$("#comment_item"+id).find(".comment_name").text()));
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
				}else{
					initdiglog2("提示信息","回复内容不能为空");
				}
			}
			function updateReply(cid,rid){
				var area=$(".notify_reply_areatext_div");
				if(area.length==0||area.prop("id")!=("updatereply"+rid)){//已打开的不变
					clearReplyArea();
					var replyname=$("#reply_item"+rid).find(".reply_name span:eq(1)").text();
					var content=$("#reply_item"+rid).find(".reply_content").html();
					var temp='<div class="notify_reply_areatext_div" id="updatereply'+rid+'"><textarea class="notify_reply_areatext" maxlength="2000" placeholder="回复 '+replyname+'：">'+transBRToRN(content)+'</textarea><div class="notify_reply_btn_div"><div onclick="updateReplyContent('+rid+')">确认修改</div><div onclick="clearReplyArea();">取消修改</div></div></div>';
					$("#comment_item"+cid).append(temp);
					$(".notify_reply_areatext").focus();
				}
			}
			function updateReplyContent(id){
				var content=$(".notify_reply_areatext").val();
				if(content.replace(/\s/g,"").length>0){
					$.ajax({
						type:"post",//post方法
						url:"CommunicateServlet",
						data:{"type":"updateReply","reply_id":id,"content":content},
						timeout : 15000, 
						//ajax成功的回调函数
						success:function(returnData){
							//删除成功
							initdiglog2("提示信息","修改成功！");
							$("#reply_item"+id).find(".reply_content").html(transRNToBR(content));
							var todate=getNowTime();//2017-01-03 12:35
							$("#reply_item"+id).find(".reply_time").text(todate);
							clearReplyArea();
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
				}else{
					initdiglog2("提示信息","回复内容不能为空");
				}
			}
			function addReplyToReply(cid,rid){
				var area=$(".notify_reply_areatext_div");
				if(area.length==0||area.prop("id")!=("addtoreply"+rid)){//已打开的不变
					clearReplyArea();
					var replyname=$("#reply_item"+rid).find(".reply_name span:eq(0)").text();
					var temp='<div class="notify_reply_areatext_div" id="addtoreply'+rid+'"><textarea class="notify_reply_areatext" maxlength="2000" placeholder="回复 '+replyname+'："></textarea><div class="notify_reply_btn_div"><div onclick="addReplyToReplyContent('+cid+','+rid+')">确认回复</div><div onclick="clearReplyArea();">取消回复</div></div></div>';
					$("#comment_item"+cid).append(temp);
					$(".notify_reply_areatext").focus();
				}
			}
			function addReplyToReplyContent(cid,rid){
				var content=$(".notify_reply_areatext").val();
				if(content.replace(/\s/g,"").length>0){
					$.ajax({
						type:"post",//post方法
						url:"CommunicateServlet",
						data:{"type":"addReply","comments_id":cid,"reply_id":rid,"content":content},
						timeout : 15000, 
						//ajax成功的回调函数
						success:function(returnData){
							//删除成功
							initdiglog2("提示信息","发送成功！");
							clearReplyArea();
							var replyname=$("#reply_item"+rid).find(".reply_name span:eq(0)").text();
							$("#reply_item"+rid).parent().append(getReplyStr(cid,returnData, content,replyname));
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
				}else{
					initdiglog2("提示信息","回复内容不能为空");
				}
			}
			//删除回复框
			function clearReplyArea(){
				$(".notify_reply_areatext_div").remove();
			}
			function delcomment(id){
				initdiglogtwo2("提示信息","你确定要删除该条评论吗？");
		   		$( "#confirm2" ).click(function() {
					$( "#twobtndialog" ).dialog( "close" );
					Lock_CheckForm();
					$.ajax({
						type:"post",//post方法
						url:"CommunicateServlet",
						data:{"type":"delComments","comments_id":id},
						timeout : 15000, 
						//ajax成功的回调函数
						success:function(returnData){
							//删除成功
							initdiglog2("提示信息","删除成功！");
							$("#comment_item"+id).remove();
							clearReplyArea();
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
		   		});
			}
			function delReply(id){
				initdiglogtwo2("提示信息","你确定要删除该条回复吗？");
		   		$( "#confirm2" ).click(function() {
					$( "#twobtndialog" ).dialog( "close" );
					Lock_CheckForm();
					$.ajax({
						type:"post",//post方法
						url:"CommunicateServlet",
						data:{"type":"delReply","reply_id":id},
						timeout : 15000, 
						//ajax成功的回调函数
						success:function(returnData){
							//删除成功
							initdiglog2("提示信息","删除成功！");
							$("#reply_item"+id).remove();
							clearReplyArea();
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
		   		});
			}
			function agree(id,relate_type,isagree,num){
				if(isagree){
					num--;
				}else {
					num++;
				}
				var temp;
				if(relate_type==2){
					if(num>0){
						temp='<a href="javascript:agree('+id+',2,'+!isagree+','+num+')" id="comment_agree'+id+'">'+(isagree?'赞同':'已赞同')+'（+'+num+'）</a>';
					}else {
						temp='<a href="javascript:agree('+id+',2,false,0)" id="comment_agree'+id+'">赞同</a>';
					}
					var parent=$("#comment_agree"+id).parent();
					$("#comment_agree"+id).remove();
					temp=$.trim(parent.html().replace(/[\r\n]/g,""))+$.trim(temp.replace(/[\r\n]/g,""));
					parent.html(temp);
				}else{
					if(num>0){
						temp='<a href="javascript:agree('+id+',3,'+!isagree+','+num+')" id="reply_agree'+id+'">'+(isagree?'赞同':'已赞同')+'（+'+num+'）</a>';
					}else {
						temp='<a href="javascript:agree('+id+',3,false,0)" id="reply_agree'+id+'">赞同</a>';
					}
					var parent=$("#reply_agree"+id).parent();
					$("#reply_agree"+id).remove();
					temp=$.trim(parent.html().replace(/[\r\n]/g,""))+$.trim(temp.replace(/[\r\n]/g,""));
					parent.html(temp);
				}
				$.ajax({
					type:"post",//post方法
					url:"CommunicateServlet",
					data:{"type":"handelagree","foreign_id":id,"isagree":isagree,"relate_type":relate_type},
					timeout : 15000, 
					//ajax成功的回调函数
					success:function(returnData){
						//initdiglog2("提示信息", "已同步");
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
			function closeNotify(){
				document.jumpform.submit();
			}
		</script>
	</head>

	<body>
		<jsp:include page="/top.jsp" >
	<jsp:param name="name" value="<%=mUser.getName() %>" />
	<jsp:param name="level" value="<%=mUser.getLevel() %>" />
	<jsp:param name="index" value="4" />
	</jsp:include>
		<div class="div_center">
			<jsp:include page="/communicate/communicateTab.jsp">
			<jsp:param name="index" value="0" />
			</jsp:include>
			<div class="div_center_right">
				<div class="del_notify_div_img" onclick="closeNotify()"></div>
					<div class="div_title2">
					<%=notify.getTitle() %>
					</div>
					<div class="div_dashed1"></div>
					<div class="notify_detail_content">
					<%=ftf.transRNToBR(notify.getContent())%>
					</div>
					<div class="notify_detail_bottom_div">
						<div class="notify_detail_bottom">
						<div>
						<%=notify.getPublisher() %>
						</div>
						<div>
						<%=notify.getUpdate_date() %>
						</div>
					</div>
					</div>
					<div class="notify_file_num">附件<%=filList.size()>0?("：（"+filList.size()+"个）"):"" %></div>
					<div class="filist_img">
						<%for(File_path file_path:filList){ %>
						<div><a href="javascript:fileDown(<%=file_path.getId() %>);this.blur();"><%=file_path.getFile_name() %></a></div>
						<%} %>
					</div>
					<div class="cut_line"></div>
					<%if(permission43){ %>
					<textarea class="notify_comment_areatext" id="comment_textarea" placeholder="畅所欲言" maxlength="2000"></textarea>
					<div class="notify_comment_btn_div"><div onclick="publish_comment()">评 论</div></div>
					<%} %>
					<div class="comment_list">
					<%for(Comments comments:commentsList) { %>
						<div class="comment_item" id="comment_item<%=comments.getId()%>">
							<div class="comment_title"><div class="comment_name"><%=comments.getCreate_name() %></div><div class="comment_time"><%=comments.getUpdate_date() %></div></div>
							<div class="comment_content"><%=ftf.transRNToBR(comments.getContent()) %></div>
							<div class="comment_handel" >
								<%if(uid==comments.getCreate_id()){ %><a href="javascript:updatecomment(<%=comments.getId()%>)">编辑</a><div></div><a href="javascript:delcomment(<%=comments.getId()%>)">删除</a><div></div><%}if(permission43){ %><a href="javascript:addReplyToComment(<%=comments.getId()%>)">回复</a><div></div><%} %><a href="javascript:agree(<%=comments.getId()%>,2,<%=comments.isIsagree()%>,<%=comments.getAgree()%>)" id="comment_agree<%=comments.getId()%>"><%=comments.getAgree()==0?"赞同":((comments.isIsagree()?"已赞同":"赞同")+"（+"+comments.getAgree()+"）")%> </a>
							</div>
							<div class="reply_list">
							<%for(Reply reply:comments.getReplyList()) {%>
								<div class="reply_item" id="reply_item<%=reply.getId()%>">
									<div class="reply_title"><div class="reply_name"><span><%=reply.getCreate_name()%></span>回复<span><%=reply.getReply_name() %></span></div><div class="reply_time"><%=reply.getUpdate_date() %></div></div>
									<div class="reply_content"><%=ftf.transRNToBR(reply.getContent()) %></div>
									<div class="reply_handel" >
										<%if(uid==reply.getCreate_id()){ %><a href="javascript:updateReply(<%=comments.getId()%>,<%=reply.getId()%>)">编辑</a><div></div><a href="javascript:delReply(<%=reply.getId()%>)">删除</a><div></div><%}if(permission43){ %><a href="javascript:addReplyToReply(<%=comments.getId()%>,<%=reply.getId()%>)">回复</a><div></div><%} %><a href="javascript:agree(<%=reply.getId()%>,3,<%=reply.isIsagree()%>,<%=reply.getAgree()%>)" id="reply_agree<%=reply.getId()%>"><%=reply.getAgree()==0?"赞同":((reply.isIsagree()?"已赞同":"赞同")+"（+"+reply.getAgree()+"）")%> </a>
									</div>
								</div>
							<%} %>
							</div>
						</div>
					<%} %>
					</div>
			</div>
		</div>
		<form action="CommunicateServlet" name="jumpform" method="post" >
			<input type="hidden" name="type" value="jumpUrl">
			<input type="hidden" name="jumpType" value="<%=notify_index%>">
			<input type="hidden" name="jumpID">
		</form>
	</body>
</html>
