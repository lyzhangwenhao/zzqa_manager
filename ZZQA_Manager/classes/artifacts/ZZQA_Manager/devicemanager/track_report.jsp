<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.pojo.linkman.Linkman"%>
<%@page import="com.zzqa.service.interfaces.track.TrackManager"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.pojo.track.Track"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	TrackManager trackManager = (TrackManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("trackManager");
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
		response.sendRedirect("login.jsp");
		return;
	}
	String keywords_track = "";
	if (session.getAttribute("keywords_track") != null) {
		keywords_track = (String) session
				.getAttribute("keywords_track");
	}
	String users_track = "";
	if (session.getAttribute("users_track") != null) {
		users_track = (String) session
				.getAttribute("users_track");
	}
	long starttime_track;
	long endtime_track;
	if(session.getAttribute("starttime_track") == null||session.getAttribute("endtime_track") == null){//默认开始时间，当前月1号0点
		Calendar calendar=Calendar.getInstance();
		calendar.set(Calendar.HOUR_OF_DAY, 23);   
		calendar.set(Calendar.SECOND, 59);   
		calendar.set(Calendar.MINUTE, 59);   
		calendar.set(Calendar.MILLISECOND, 999);//获取第二天0点的时间
		endtime_track=calendar.getTime().getTime();
		calendar.set(Calendar.HOUR_OF_DAY, 0);   
		calendar.set(Calendar.SECOND, 0);   
		calendar.set(Calendar.MINUTE, 0);   
		calendar.set(Calendar.MILLISECOND, 0);//获取第二天0点的时间
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		starttime_track=calendar.getTime().getTime();
	}else{
		starttime_track=(Long)session.getAttribute("starttime_track");
		endtime_track=(Long)session.getAttribute("endtime_track");
	}
	Map<Integer,List<Linkman>> linkMap=null;
	List<User> userList=new ArrayList<User>();
	boolean canWatch="admin".equals(mUser.getName())||permissionsManager.checkPermission(mUser.getPosition_id(), 54);
	if(canWatch){
		linkMap=trackManager.getTrackReport(null, starttime_track, endtime_track, keywords_track);
		userList=userManager.getAllUserOrderByLevel();
		Iterator<User> iterator=userList.iterator();
		while(iterator.hasNext()){
			User user=(User)iterator.next();
			if(!permissionsManager.checkPermission(user.getPosition_id(), 52)){
				//超级管理员可以查看自己
				iterator.remove();
			}
		}
	}else{
		users_track="";
		linkMap=trackManager.getTrackReport(mUser, starttime_track, endtime_track, keywords_track);
		if(("-"+users_track).indexOf(mUser.getId())!=-1){
			users_track+=mUser.getId();
		}
		userList.add(mUser);
	}
	String[][] stateTrackArray=DataUtil.getStateTrackArray();
	pageContext.setAttribute("stateTrackArray", stateTrackArray);
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>人员状态跟踪表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/track_report.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		<script type="text/javascript" src="js/showdate1.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
			var flag=0;//0：隐藏
			var stateTrackArray=[
           	      <%for(int i=0;i<stateTrackArray.length;i++){
           	      if(i!=0){
           	    	  out.write(",");
           	      }
           	      out.write("['"+stateTrackArray[i][0]+"','"+stateTrackArray[i][1]+"']");
           	      }%>
           	  ];
			var userArray=[
			    <%boolean isFirst=false;for(User user:userList){
			    	if(isFirst){
			    		out.write(",");
			    	}else{
			    		isFirst=true;
			    	}
			    	out.write("["+user.getId()+",'"+user.getTruename()+"',"+false+",'"+user.getName()+"']");
			  }%>   
			];
			//[create_id,create_name,data]
			var linkmanArray=[
			    <%
				isFirst=false;
			    for (Map.Entry<Integer, List<Linkman>> entry : linkMap.entrySet()) {
			    	 int create_id=entry.getKey();
			    	 List<Linkman> linkList=entry.getValue();
			    	 int size=linkList.size();
			    	 StringBuilder sBuilder=new StringBuilder();
			    	 for(Linkman linkman:linkList){
			    		 sBuilder.append("い").append(linkman.getLinkman_case()-2).append("の").append(linkman.getCreate_time());
			    	 }
			    	 if(sBuilder.length()>0){
			    		 if(isFirst){
			    			 out.write(",");
			    		 }else{
			    			 isFirst=true;
			    		 }
			    		 out.write("["+create_id+",'"+sBuilder.toString()+"']");
			    	 }
			     }	     
			     %>             
			     ];
			//根据uid找到uname
			function findUserName(uid){
				for(var i=0;i<userArray.length;i++){
					if(userArray[i][0]==uid){
						if(<%=!mUser.getName().equals("admin")%>&&"admin"==userArray[i][3]){
							return -1;//超级管理员只能被自己看到
						}
						return userArray[i][1];
					}
				}
				return "用户"+uid;
			}			
			function adv_search(f){
				if(arguments.length!=0){
					if(f&&$("#td2_div2").css("display")=="none"){
						adv_search();
					}else if(!f&&$("#td2_div2").css("display")=="block"){
						//强制关闭
						adv_search();
					}
				}else{
					event.stopPropagation();//防止冒泡
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
			}
			document.body.onclick =function(){
				adv_search(false);
			};
			$(function(){
				$("#td2_div2").click(function(){
					event.stopPropagation();//防止冒泡
				});
		    	$('#keywords_track').bind('keydown',function(event){
				    if(event.keyCode == "13"){
				    	searchTrack();
				    }
				});
		    	initTime();
		    	initUsers();
		    	initTable();
		    });
			var starttime=<%=starttime_track%>;
			var endtime=<%=endtime_track%>;
			function initTime(){
				var date1=timeTransLongToStr(starttime,4,"/");
				var date2=timeTransLongToStr(endtime,4,"/");
				$("#time1").val(date1);
				$("#time2").val(date2);
				$("#time3").val(date1.replace(/\//g, "-"));
				$("#time4").val(date2.replace(/\//g, "-"));
				$("#time1").prop("readonly","readonly");
				$("#time2").prop("readonly","readonly");
			}
			function initUsers(){
				var selectedUsers="<%=users_track%>";
				var selectedUsers=selectedUsers.length>0?("-"+selectedUsers+"-"):"";
				var num=userArray.length;
				var rows=(num%4==0?0:1)+Math.floor(num/4);
				var temp='';
				for(var i=0;i<rows;i++){
					if((i*4)<num){
						temp+='<div><input type="checkbox" id="user_checkbox'+(i*4)+'" class="chk_2" onchange="userCheckedChange('+i*4+')"/><label for="user_checkbox'+(i*4)+'"></label>'
							+'<div onclick="sameClick('+(i*4)+');" title="'+userArray[i*4][1]+'" id="userdiv'+userArray[i*4][0]+'">'+userArray[i*4][1]+'</div>';
					}
					if((i*4+1)<num){
						temp+='<input type="checkbox" id="user_checkbox'+(i*4+1)+'" class="chk_2" onchange="userCheckedChange('+(i*4+1)+')"/><label for="user_checkbox'+(i*4+1)+'"></label>'
							+'<div onclick="sameClick('+(i*4+1)+');" title="'+userArray[i*4+1][1]+'" id="userdiv'+userArray[i*4+1][0]+'">'+userArray[i*4+1][1]+'</div>';
					}
					if((i*4+2)<num){
						temp+='<input type="checkbox" id="user_checkbox'+(i*4+2)+'" class="chk_2" onchange="userCheckedChange('+(i*4+2)+')"/><label for="user_checkbox'+(i*4+2)+'"></label>'
							+'<div onclick="sameClick('+(i*4+2)+');" title="'+userArray[i*4+2][1]+'" id="userdiv'+userArray[i*4+2][0]+'">'+userArray[i*4+2][1]+'</div>';
					}
					if((i*4+3)<num){
						temp+='<input type="checkbox" id="user_checkbox'+(i*4+3)+'" class="chk_2" onchange="userCheckedChange('+(i*4+3)+')"/><label for="user_checkbox'+(i*4+3)+'"></label>'
							+'<div onclick="sameClick('+(i*4+3)+');" title="'+userArray[i*4+3][1]+'" id="userdiv'+userArray[i*4+3][0]+'">'+userArray[i*4+3][1]+'</div>';
					}
					temp+='</div>';
				}
				$(".td2_div2_usergroup").html(temp);
				var ifAllUser=selectedUsers.length==0;//是否全选
				for(var i=0;i<userArray.length;i++){
					if(ifAllUser||selectedUsers.indexOf(("-"+userArray[i][0]+"-"))!=-1){
						userArray[i][2]=true;
						$("#user_checkbox"+i).click();
					}
				}
			}
			window.onresize = resize;
			var dataArray;//存储的数据栏   
			var dateArray;//表格日期栏
			//初始化表格
			function initTable(){
				var allDayNum=Math.round((endtime-starttime)/86400000);//天数 开始：0点~结束：23:59:59 加一减一抵消
				initDateArray(starttime,allDayNum);
				initDataArray(starttime,allDayNum);
				var userLen=dataArray.length;//用户数
				var temp='<tr><td>日期</td>';
				var keywords=$("#keywords_track").val();
				var temp0='<tr><td>人员</td>';
				for(var i=0;i<allDayNum;i++){//表头
					if(dateArray[i][2]){
						var d = new Date(dateArray[i][0]);    //根据时间戳生成的时间对象
						var month=d.getMonth() + 1;
						var year=d.getFullYear()
						var toolTip='<div class="container"><div>'+year+'年'+month+'月'+'</div><s><i></i></s></div>';
						temp+='<td>'+toolTip+dateArray[i][3]+'</td>';//新的一月
					}else{
						temp+='<td>'+dateArray[i][3]+'</td>';
					}
					temp0+='<td>'+dateArray[i][1]+'</td>';
				}
				temp+='</tr>'+temp0+'</tr>';
				var one=true;//奇数
				for(var i=0;i<userLen;i++){//表内容
					if(checkShow(linkmanArray[i][0])){//用户没用访问权限或不存在
						var userTemp='';
						var userFlag=false;
						for(var j=0;j<allDayNum;j++){
							var state=dataArray[i][j]==-1?"":stateTrackArray[dataArray[i][j]][1];
							one!=one
							if(state.indexOf(keywords)!=-1){//过滤状态
								if(!userFlag){
									userFlag=true;
								}
								userTemp+='<td>'+state+'</td>';
							}else{
								userTemp+='<td></td>';
							}
						}
						if(userFlag){
							//显示该用户
							var t='';
							if(one){
								t=' style="background:#F0F0F0"';
							}
							one=!one;
							var uname=findUserName(linkmanArray[i][0]);
							if(uname!=-1){
								temp+='<tr'+t+'><td>'+uname+'</td>'+userTemp+'</tr>';
							}
						}
					}
				}
				$(".trackreport_tab").html(temp);
				resize();
			}
			var weekArray=["日","一","二","三","四","五","六"];
			//时间范围内的所有日期 [[时间戳1，日期1，判断新的一月,周几],[时间戳2，日期2，判断新的一月,周几]]
			function initDateArray(t1,allDayNum){
				dateArray=new Array(allDayNum);
				var startMonth=$("#time1").val().substring(0,7);//2017/04
				var endMonth=$("#time2").val().substring(0,7);//2017/04
				var onceMonth=startMonth==endMonth;//是否为单月
				var off=new Date(t1).getDay();//0 for Sunday, 1 for Monday, 2 for Tuesday, and so on. 
				for(var i=0;i<allDayNum;i++){
					dateArray[i]=new Array(4);
					dateArray[i][0]=t1;//时间戳
					dateArray[i][1]=timeTransLongToStr(t1,3);//日期
					dateArray[i][2]=false;
					dateArray[i][3]=weekArray[off++%7];
					if(dateArray[i][1]==1||(i==0&&(dateArray[i][1]<20||onceMonth))){//开始为20号前（或不早于20号但不跨月），第一列显示浮窗
						dateArray[i][2]=true;//标记为新的一月,第一个显示月份
					}
					t1+=86400000;//加一天
				}
			}
			//时间范围内的所有日期对应状态 [[状态1，状态2]]
			function initDataArray(t1,allDayNum){
				var userNum=linkmanArray.length;
				dataArray=new Array(userNum);
				for(var j=0;j<userNum;j++){
					dataArray[j]=new Array(allDayNum);
					var dArray=linkmanArray[j][1].replace("い","").split("い");
					for(var i=0;i<allDayNum;i++){
						dataArray[j][i]=-1;
					}
					for(var i=0;i<dArray.length;i++){
						var dArray2=dArray[i].split("の");
						var index=Math.round((parseInt(dArray2[1])-t1)/86400000);
						dataArray[j][index]=parseInt(dArray2[0]);//对应日期的状态
					}
				}
			}
			//判断是否显示该用户
			function checkShow(uid){
				var len=userArray.length;
				for(var i=0;i<len;i++){
					if(userArray[i][0]==uid){
						return userArray[i][2];
					}
				}
				return false;
			}
			function resize() {
				var table=$(".trackreport_tab");
				var table_width=table.css("width").replace("px","");
				var client_width=table.parent().css("width").replace("px","");
				if(parseInt(table_width)<=parseInt(client_width)){
					table.css("width","100%");
				}else{
					table.css("width","auto");
				}
				var title_width=$(".trackreport_tab td:eq(0)").outerWidth();//80px
				var temp='';
				var index=0;
				$(".trackreport_tab tr").each(function(){
					if(index++>1){
						if(index%2==0){
							temp+='<div style="background:#fff">'+$(this).find("td:eq(0)").text()+'</div>';
						}else{
							temp+='<div style="background:#F0F0F0">'+$(this).find("td:eq(0)").text()+'</div>';
						}
					}else{
						temp+='<div>'+$(this).find("td:eq(0)").text()+'</div>';
					}
				});
				$(".trackreport_tab_lefttitle").html(temp);
				$(".trackreport_tab_lefttitle").css("width",title_width+1+"px");
			}
			function searchTrack(){
				var time1=timeTransStrToLong2($("#time1").val());
				var time2=timeTransStrToLong2($("#time2").val())+24*3600*1000-1;
				var users_track='';
				for(var i=0;i<userArray.length;i++){
					if($("#user_checkbox"+i).prop("checked")){
						if(users_track.length>0){
							users_track+="-";
						}
						users_track+=userArray[i][0];
					}
				}
				if(users_track.length==0){
					initdiglog2("提示信息","请至少选择一个用户",true);
					event.stopPropagation();
					return;
				}
				adv_search(false);
				if(time1==starttime&&time2==endtime){
					//时间没变
					initTable();
					return;
				}
				document.trackform.users_track.value=users_track;
				document.trackform.starttime_track.value=time1;
				document.trackform.endtime_track.value=time2;
				document.trackform.submit();
			}
		    function setTime(time,obj){
		    	if(obj==document.getElementById("time3")){
		    		var dates=daysBetween(time,$("#time4").val());//.replace(/\//g, "-")
		    		//修改time1的时间
			    	if(dates>=0){
			    		obj.value=time;//time3
			    		$("#time1").val(time.replace(/-/g, "/"));
			    	}else{
			    		initdiglog2("提示信息","开始时间不能晚于结束时间！");
			    	}
		    	}else{
		    		//修改time2的时间
		    		var dates=daysBetween($("#time3").val(),time);//.replace(/\//g, "-")
			    	if(dates>=0){
			    		obj.value=time;//time3
			    		$("#time2").val(time.replace(/-/g, "/"));
			    	}else{
			    		initdiglog2("提示信息","结束时间不能早于开始时间！");
			    	}
		    	}
		    }
		    function sameClick(id){
		    	event.stopPropagation();//防止冒泡
		    	if($("#user_checkbox"+id).prop("checked")){
		    		var canClick=false;
			    	for(var i=0;i<userArray.length;i++){
			    		if($("#user_checkbox"+i).prop("checked")&&id!=i){
			    			canClick=true;
			    		}
			    	}
			    	if(canClick){
			    		//必须保留一个
			    		$("#user_checkbox"+id).prop("checked",false);
			    		userArray[id][2]=false;
			    	}else{
			    		initdiglog2("提示信息", "请至少选择一个用户")
			    	}
		    	}else{
		    		$("#user_checkbox"+id).prop("checked",true);
		    		userArray[id][2]=true;
		    	}
		    }
		    function userCheckedChange(id){
		    	if($("#user_checkbox"+id).prop("checked")){
		    		userArray[id][2]=true;
		    	}else{
		    		var canClick=false;
			    	for(var i=0;i<userArray.length;i++){
			    		if($("#user_checkbox"+i).prop("checked")&&id!=i){
			    			canClick=true;
			    		}
			    	}
			    	if(canClick){
			    		//必须保留一个
			    		userArray[id][2]=false;
			    	}else{
			    		userArray[id][2]=true;
			    		$("#user_checkbox"+id).prop("checked",true);
			    		initdiglog2("提示信息", "请至少选择一个用户");
			    	}
		    	}
		    }
		    function multiChecked(){
		    	var f=$('.chk_1').prop('checked');
		    	for(var i=0;i<userArray.length;i++){
	    			userArray[i][2]=f;
	    			$("#user_checkbox"+i).prop("checked",f);
		    	}
		    }
		    function resetFilter(){
		    	window.location.href="DeviceServlet?type=resetTrack";
		    }
		    function exportTrack(){
		    	if($(".trackreport_tab tr").length==2){
		    		initdiglog2("提示信息", "没有数据！");
		    		return;
		    	}
		    	var temp='';
		    	var rowTemp='';
		    	for(var i=0;i<dateArray.length;i++){
		    		if(dateArray[i][2]){//显示月份
		    			var d = new Date(dateArray[i][0]);    //根据时间戳生成的时间对象
						var month=d.getMonth() + 1;
						var year=d.getFullYear()
						var time=year+'年'+month+'月';
						rowTemp+='の'+time;
						continue;
		    		}
		    		rowTemp+='の';
		    	}
		    	temp+=rowTemp;
		    	rowTemp='';
		    	$(".trackreport_tab tr").each(function(){
		    		var colTemp='';
		    		$(this).find("td").each(function(){
		    			var text=$(this).html();
		    			colTemp+='の'+(text.indexOf('<div>')!=-1?text.substring(text.lastIndexOf(">")+1):text);
		    		});
		    		rowTemp+="い"+colTemp.replace('の','');
		    	});
		    	temp+=rowTemp;
		    	//导出excel
	    		if(loading){
	    			return;
	    		}
	    		loading=!loading;
	    		$.ajax({
	    			type:"post",//post方法
	    			url:"HandelTempFileServlet",
	    			data:{"type":"exporttrack_out","data":temp},
	    			//ajax成功的回调函数
	    			success:function(returnData){
	    				if(returnData.length>1){
	    					window.location.href="FileDownServlet?type=loadtrackexcel&filePath="+returnData;
	    				}else{
	    					//失败
	    					initdiglog2("提示信息", "导出失败！");
	    				}
	    			}
	    		});
	    		loading=!loading;
	    	}
		    var loading=false;
		    function selectAll(){
		    	var f=!$('.chk_1').prop('checked');
		    	$('.chk_1').prop('checked',f);
		    	var f=$('.chk_1').prop('checked');
		    	for(var i=0;i<userArray.length;i++){
	    			userArray[i][2]=f;
	    			$("#user_checkbox"+i).prop("checked",f);
		    	}
		    }
		</script>
	</head>

	<body>
		<jsp:include page="/top.jsp" >
	<jsp:param name="index" value="2" />
	</jsp:include>
		<div class="td1_track">
			<form action="DeviceServlet?type=trackfilter" method="post"
				name="trackform">
				<input type="hidden" name="users_track">
				<input type="hidden" name="starttime_track">
				<input type="hidden" name="endtime_track">
				<div class="td1_div0">
					人员状态跟踪表
				</div>
				<div class="td2_div3">
					<img src="images/calendar.png" id="img2" onclick="return Calendar('time4');">
					<input type="text" id="time4" class="input-hide-time"><input type="text" id="time2" class="input-show-time"><div>至</div>
					<img src="images/calendar.png" id="img1" onclick="return Calendar('time3');"><input type="text" id="time3" class="input-hide-time">
					<input type="text" id="time1" class="input-show-time">
				</div>
				<div class="td2_div1">
					<img title="导出表格" src="images/export_track.png" id="img_export"
										onclick="exportTrack();" class="serach_img3">
					<img title="显示筛选" src="images/search_press.jpg" id="img_adv"
										onclick="adv_search();" class="serach_img2">
					<img title="搜索" src="images/user_search.gif" id="img_search" 
						onclick="searchTrack();" class="serach_img1">
					<input type="text" name="keywords_track" id="keywords_track"  maxlength="30" placeholder="关键词：人员状态" value="<%=keywords_track%>" 
						onkeydown="if(event.keyCode==32) return false">
					</div>
					<div class="td2_div2_parent">
						<div class="td2_div2" id="td2_div2">
						<div class="td2_div2_btns">
							<input type="checkbox" id="multi_checkbox" class="chk_1" onchange="multiChecked()" checked/><label for="multi_checkbox"></label>
							<div onclick="selectAll();">全选</div>
							<div onclick="resetFilter();">重置</div>
							<div onclick="searchTrack();">筛选</div>
						</div>
						<div class="td2_div2_usergroup">
						</div>
					</div>
				</div>
				<div class="trackreport_tab_lefttitle_parent"><div class="trackreport_tab_lefttitle"></div></div>
				<div class="trackreport_div">
				<%-- <div>防止左侧标题栏随表单一起滚动 --%>
					<table class="trackreport_tab">
					
					</table>
					<!-- </div> -->
				</div>
				<div class="track_bottom_left">
					<div class="track_bottom_left1">
						<div>
							<span><c:out value="${stateTrackArray[0][0]}"></c:out></span><span><c:out
									value="${stateTrackArray[0][1]}"></c:out></span>
						</div>
					</div>
					<div class="track_bottom_left1">
						<div>
							<span><c:out value="${stateTrackArray[1][0]}"></c:out></span><span><c:out
									value="${stateTrackArray[1][1]}"></c:out></span>
						</div>
					</div>
					<div class="track_bottom_left1">
						<div>
							<span><c:out value="${stateTrackArray[2][0]}"></c:out></span><span><c:out
									value="${stateTrackArray[2][1]}"></c:out></span>
						</div>
					</div>
					<div class="track_bottom_left1">
						<div>
							<span><c:out value="${stateTrackArray[3][0]}"></c:out></span><span><c:out
									value="${stateTrackArray[3][1]}"></c:out></span>
						</div>
					</div>
					<div class="track_bottom_left1">
						<div>
							<span><c:out value="${stateTrackArray[4][0]}"></c:out></span><span><c:out
									value="${stateTrackArray[4][1]}"></c:out></span>
						</div>
					</div>
					<div class="track_bottom_left1">
						<div>
							<span><c:out value="${stateTrackArray[5][0]}"></c:out></span><span><c:out
									value="${stateTrackArray[5][1]}"></c:out></span>
						</div>
					</div>
					<div class="track_bottom_left1">
						<div>
							<span><c:out value="${stateTrackArray[6][0]}"></c:out></span><span><c:out
									value="${stateTrackArray[6][1]}"></c:out></span>
						</div>
					</div>
					<div class="track_bottom_left1">
						<div>
							<span><c:out value="${stateTrackArray[7][0]}"></c:out></span><span><c:out
									value="${stateTrackArray[7][1]}"></c:out></span>
						</div>
					</div>
					<div class="track_bottom_left1">
						<div>
							<span><c:out value="${stateTrackArray[8][0]}"></c:out></span><span><c:out
									value="${stateTrackArray[8][1]}"></c:out></span>
						</div>
					</div>
					<div class="track_bottom_left1">
						<div>
							<span><c:out value="${stateTrackArray[9][0]}"></c:out></span><span><c:out
									value="${stateTrackArray[9][1]}"></c:out></span>
						</div>
					</div>
					<div class="track_bottom_left1">
						<div>
							<span><c:out value="${stateTrackArray[10][0]}"></c:out></span><span><c:out
									value="${stateTrackArray[10][1]}"></c:out></span>
						</div>
					</div>
				</div>
			</form>
		</div>
	</body>
</html>
