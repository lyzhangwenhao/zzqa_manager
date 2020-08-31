<%@page import="com.zzqa.util.DataUtil"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page
	import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.pojo.position_user.Position_user"%>
<%
	request.setCharacterEncoding("UTF-8");
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	Position_userManager position_userManager = (Position_userManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("position_userManager");
	if (session.getAttribute("uid") == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	int uid = (Integer) session.getAttribute("uid");
	User mUser = userManager.getUserByID(uid);
	if (mUser == null) {
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
		return;
	}
	String[][] stateTrackArray = DataUtil.getStateTrackArray();
	pageContext.setAttribute("stateTrackArray", stateTrackArray);
%>

<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">

<title>新建状态跟踪流程</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="css/top.css">
<link rel="stylesheet" type="text/css" href="css/flowmanager.css">
<link rel="stylesheet" type="text/css" href="css/create_trackflow.css">
<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
<script src="js/jquery.min.js" type="text/javascript"></script>
<script  type="text/javascript" src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/dialog.js"></script>
<script type="text/javascript" src="js/public.js"></script>
<!--[if IE]>
			<script src="js/html5shiv.min.js" type="text/javascript"></script>
		<![endif]-->
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<script type="text/javascript">
	var stopTop=false;//是否组织监听冒泡
	var stateTrackArray=[
	      <%for(int i=0;i<stateTrackArray.length;i++){
	      if(i!=0){
	    	  out.write(",");
	      }
	      out.write("'"+stateTrackArray[i][1]+"'");
	      }%>
	  ];
	function findStateIndex(text){
		for(var i=0;i<stateTrackArray.length;i++){
			if(stateTrackArray[i]==text){
				return i;
			}
		}
		return -1;
	}
	var stateTemp='';
	$(function(){
		initSelect();
		initTime();
		$(".track_date>div").click(function(){
			if(stopTop){
				stopTop=!stopTop;
				return;
			}
			var index=parseInt($(this).attr('id').replace("date",""))-1;
			if(monthArray[index][1]){
				$(this).css("background","#D1EEFE");
				if($(this).children("select").length==0){
					$(this).children("div:last-child").before('<select>'+stateTemp+'</select>');
					$(this).children("select").val(findStateIndex($(this).children("div:last-child").text()));
				}
				$(this).children("div:last-child").remove();
				blurDate(index);
				$(".track_date select").click(function(event){
					event.stopPropagation();//防止冒泡
				});
			}
		});
	});
	function blurDate(index){
		for(var i=0;i<monthArray.length;i++){
			if(monthArray[i][0]==0){
				break;
			}
			if(i!=index&&$("#date"+(i+1)).children("select").length!=0){
				var stateIndex=parseInt($("#date"+(i+1)).children("select").val());
				var selectValue=stateIndex==-1?'':stateTrackArray[stateIndex];
				$("#date"+(i+1)).children("select").before('<div>'+selectValue+'</div>');
				$("#date"+(i+1)).children("select").remove();
				$("#date"+(i+1)).css("background","#fff");
				break;
			}
		}
	}
	function initSelect(){
		var beginYear=2015;
		var date=new Date();
		var nowMonth=date.getMonth() + 1;
		var nowYear=   date.getFullYear();
		var temp='';
		for(var i=beginYear;i<nowYear+2;i++){
			temp+='<option value="'+i+'" '+(i==nowYear?'selected':'')+'>'+i+'</option>';
		}
		$("#track_year").html(temp);
		temp='';
		for(var i=1;i<13;i++){
			temp+='<option value="'+i+'" '+(i==nowMonth?'selected':'')+'>'+i+'</option>';
		}
		$("#track_month").html(temp);
		if(stateTemp.length==0){
			stateTemp='<option value="-1"></optiot>';
			for(var i=0;i<stateTrackArray.length;i++){
				stateTemp+='<option value="'+i+'">'+stateTrackArray[i]+'</optiot>';
			}
		}
		$("#multi_select").html(stateTemp);
		$(".track_date select").each(function(){//初始化 同意改为div，只有被选中时才显示select
			$(this).before('<div></div>');
			$(this).remove();
		});
	}
	var MonthDNum = new Array(0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	var monthArray;
	function initMonthArray(){
		monthArray=new Array();
		for(var i=0;i<42;i++){
			monthArray[i]=new Array();
			monthArray[i][0]=0;//显示的日期
			monthArray[i][1]=false;//是否为可选日期
			monthArray[i][2]=false;//是否为可选日期中的周末
		}
	}
	function initTime(){
		initMonthArray();
		var year=$("#track_year").val();
		var month=$("#track_month").val();
		var DayNum = (IsLeapYear(year) && month == 2) ? MonthDNum[month] + 1 : MonthDNum[month];
		var lastDayNum=31;//上个月为去年12月
		if(month!=1){//上月为1-11月
			lastDayNum=(IsLeapYear(year) && month == 3) ? MonthDNum[month-1] + 1 : MonthDNum[month-1];
		}
		var date = new Date(year+"-"+month+"-"+1);
		var oneWeekIndex=date.getDay();//当前月份一号为星期几 0-6 周日-周六
		for(var i=0;i<oneWeekIndex;i++){
			//0 1 2 3 4 5 6
			monthArray[oneWeekIndex-i-1][0]=lastDayNum-i;//填充上个月
		}
		for(var i=1;i<=DayNum;i++){
			monthArray[i+oneWeekIndex-1][0]=i;//填充下个月
			monthArray[i+oneWeekIndex-1][1]=true;//本月才可操作
			if((oneWeekIndex+i)%7==0||(oneWeekIndex+i)%7==1){
				monthArray[i+oneWeekIndex-1][2]=true;//可选日期的周末
			}
		}
		if((DayNum+oneWeekIndex)<36){
			//只显示5行
			$("#date36").parent().css("display","none");
			if((DayNum+oneWeekIndex)<29){
				//只显示4行
				$("#date30").parent().css("display","none");
			}
		}else{
			$("#date36").parent().css("display","block");
		}
		date = new Date(year+"-"+month+"-"+DayNum);
		var endWeekIndex=date.getDay();//当前月份最后一天为星期几 0-6 周日-周六
		for(var i=endWeekIndex;i<6;i++){
			monthArray[DayNum+oneWeekIndex+(5-i)][0]=6-i;//填充下个月
		}
		showDate();
	}
	function showDate(){
		for(var i=0;i<monthArray.length;i++){
			$("#date"+(i+1)+" div:eq(0)").text(monthArray[i][0]);
			$("#date"+(i+1)).css("background","#fff");
			if($("#date"+(i+1)+" select").length!=0){
				$("#date"+(i+1)+" select").before('<div></div>');
				$("#date"+(i+1)+" select").remove();
			}
			$("#date"+(i+1)+" div:eq(1)").text("");
			if(monthArray[i][0]!=0){
				if(monthArray[i][1]){
					if(monthArray[i][2]){
						$("#date"+(i+1)+" div:eq(0)").css("color","#FE018F");;
					}else{
						$("#date"+(i+1)+" div:eq(0)").css("color","#000");
					}
					if($(".chk_2").prop("checked")){
						$("#date"+(i+1)+" label").css("visibility","visible");
					}
					$("#date"+(i+1)+">div").css("cursor","pointer");
				}else{
					$("#date"+(i+1)+" div:eq(0)").css("color","#b3b3b3");
					$("#date"+(i+1)+" label").css("visibility","hidden");
					$("#date"+(i+1)+">div").css("cursor","default");
				}
			}else{
				$("#date"+(i+1)+">div").css("cursor","default");
			}
			if($("#date"+(i+1)+" input").prop("checked")){
				$("#date"+(i+1)+" label").click();//全部设为未勾选状态
			}$(".track_date div:eq(1)").val("");
		}
		$(".track_date label").click(function(event){
			stopTop=true;//组织监听冒泡
			event.stopPropagation();//防止冒泡
		});
	}
	/*是否润年*/
	function IsLeapYear(y) {
		if (0 == y % 4 && ((y % 100 != 0) || (y % 400 == 0))) {
			return true;
		} else {
			return false;
		}
	}
	function multiChecked(){
		if($(".chk_2").prop("checked")){
			//多选，显示复选框
			$(".track_date label").css("visibility","visible");
			for(var i=0;i<monthArray.length;i++){
				if(monthArray[i][0]==0){
					break;
				}
				if(monthArray[i][1]){
					$("#date"+(i+1)+" label").css("visibility","visible");
				}else{
					$("#date"+(i+1)+" label").css("visibility","hidden");
				}
			}
			if($(".chk_2").prop("checked")){
				//初始化勾选框
				$(".track_date :checkbox").each(function(){
					if($(this).prop("checked")){
						$(this).parent().children("label").click();
					}
				});
			}
		}else{
			$(".track_date label").css("visibility","hidden");
		}
		$(".track_date label").click(function(event){
			stopTop=true;
			event.stopPropagation();//防止冒泡
		});
	}
	function multiSelect(){
		if($(".chk_2").prop("checked")){
			var selectedState=$("#multi_select").val();
			$(".track_date :checkbox").each(function(){
				if($(this).prop("checked")){
					if($(this).parent().children("select").length==0){
						var selectValue=selectedState==-1?'':stateTrackArray[selectedState];
						$(this).parent().children("div:last-child").text(selectValue);
					}else{
						$(this).parent().children("select").val(selectedState);
					}
				}
			});
		}
	}
	function addTrack(){
		var year=$("#track_year").val();
		var month=$("#track_month").val();
		var data='';//の
		var state_time=timeTransStrToLong2(year+"-"+month+"-1");
		for(var i=0;i<monthArray.length;i++){
			if(monthArray[i][0]==0){
				break;
			}
			if(monthArray[i][1]){
				var state;
				if($("#date"+(i+1)+" select").length==0){
					state=findStateIndex($("#date"+(i+1)+" div:eq(1)").text());
				}else{
					state=$("#date"+(i+1)+" select").val();
				}
				if(state!=-1){
					data+="い"+timeTransStrToLong2(year+"-"+month+"-"+monthArray[i][0])+"の"+state;
				}
			}
		}
		if(data.length==0){
			initdiglog2("提示信息","请选择状态！");
			return;
		}
		$.ajax({
			type:"post",//post方法
			url:"FlowManagerServlet",
			data:{"type":"checkHasSaveThisMonth","state_time":state_time},
			async:false,
			//ajax成功的回调函数
			success:function(returnData){
				if(returnData==0){
					data=data.replace("い","");
					document.flowform.data.value=data;
					document.flowform.submit();
				}else{
					initdiglog2("提示信息","当月的状态表已创建，可直接对其修改！");
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
</script>
</head>

<body>
	<jsp:include page="/top.jsp">
		<jsp:param name="name" value="<%=mUser.getName()%>" />
		<jsp:param name="level" value="<%=mUser.getLevel()%>" />
		<jsp:param name="index" value="1" />
	</jsp:include>
	<div class="div_center">
		<table class="table_center">
			<tr>
				<jsp:include page="/flowmanager/flowTab.jsp">
					<jsp:param name="index" value="3" />
				</jsp:include>
				<td class="table_center_td2_full">
					<form
						action="FlowManagerServlet?type=addtrackflow&operation=0"
						method="post" name="flowform">
						<input type="hidden" name="data">
						<div class="td2_div">
							<div class="td2_div1">现场服务人员状态表</div>
							<div class="track_time">
								<div>
									<select id="track_year" name="track_year" onchange="initTime()">
									</select> 年
								</div>
								<div>
									<select id="track_month" name="track_month" onchange="initTime()">
									</select> 月
								</div>
							</div>
							<div class="track_week">
								<div>周日</div>
								<div>周一</div>
								<div>周二</div>
								<div>周三</div>
								<div>周四</div>
								<div>周五</div>
								<div>周六</div>
							</div>
							<div class="track_date">
								<div id="date1"><input type="checkbox" id="checkbox_a1" class="chk_1" /><label for="checkbox_a1"></label><div></div><div></div></div>
								<div id="date2"><input type="checkbox" id="checkbox_a2" class="chk_1" /><label for="checkbox_a2"></label><div></div><div></div></div>
								<div id="date3"><input type="checkbox" id="checkbox_a3" class="chk_1" /><label for="checkbox_a3"></label><div></div><div></div></div>
								<div id="date4"><input type="checkbox" id="checkbox_a4" class="chk_1" /><label for="checkbox_a4"></label><div></div><div></div></div>
								<div id="date5"><input type="checkbox" id="checkbox_a5" class="chk_1" /><label for="checkbox_a5"></label><div></div><div></div></div>
								<div id="date6"><input type="checkbox" id="checkbox_a6" class="chk_1" /><label for="checkbox_a6"></label><div></div><div></div></div>
								<div id="date7"><input type="checkbox" id="checkbox_a7" class="chk_1" /><label for="checkbox_a7"></label><div></div><div></div></div>
							</div>
							<div class="track_date">
								<div id="date8"><input type="checkbox" id="checkbox_a8" class="chk_1" /><label for="checkbox_a8"></label><div></div><div></div></div>
								<div id="date9"><input type="checkbox" id="checkbox_a9" class="chk_1" /><label for="checkbox_a9"></label><div></div><div></div></div>
								<div id="date10"><input type="checkbox" id="checkbox_a10" class="chk_1" /><label for="checkbox_a10"></label><div></div><div></div></div>
								<div id="date11"><input type="checkbox" id="checkbox_a11" class="chk_1" /><label for="checkbox_a11"></label><div></div><div></div></div>
								<div id="date12"><input type="checkbox" id="checkbox_a12" class="chk_1" /><label for="checkbox_a12"></label><div></div><div></div></div>
								<div id="date13"><input type="checkbox" id="checkbox_a13" class="chk_1" /><label for="checkbox_a13"></label><div></div><div></div></div>
								<div id="date14"><input type="checkbox" id="checkbox_a14" class="chk_1" /><label for="checkbox_a14"></label><div></div><div></div></div>
							</div>
							<div class="track_date">
								<div id="date15"><input type="checkbox" id="checkbox_a15" class="chk_1" /><label for="checkbox_a15"></label><div></div><div></div></div>
								<div id="date16"><input type="checkbox" id="checkbox_a16" class="chk_1" /><label for="checkbox_a16"></label><div></div><div></div></div>
								<div id="date17"><input type="checkbox" id="checkbox_a17" class="chk_1" /><label for="checkbox_a17"></label><div></div><div></div></div>
								<div id="date18"><input type="checkbox" id="checkbox_a18" class="chk_1" /><label for="checkbox_a18"></label><div></div><div></div></div>
								<div id="date19"><input type="checkbox" id="checkbox_a19" class="chk_1" /><label for="checkbox_a19"></label><div></div><div></div></div>
								<div id="date20"><input type="checkbox" id="checkbox_a20" class="chk_1" /><label for="checkbox_a20"></label><div></div><div></div></div>
								<div id="date21"><input type="checkbox" id="checkbox_a21" class="chk_1" /><label for="checkbox_a21"></label><div></div><div></div></div>
							</div>
							<div class="track_date">
								<div id="date22"><input type="checkbox" id="checkbox_a22" class="chk_1" /><label for="checkbox_a22"></label><div></div><div></div></div>
								<div id="date23"><input type="checkbox" id="checkbox_a23" class="chk_1" /><label for="checkbox_a23"></label><div></div><div></div></div>
								<div id="date24"><input type="checkbox" id="checkbox_a24" class="chk_1" /><label for="checkbox_a24"></label><div></div><div></div></div>
								<div id="date25"><input type="checkbox" id="checkbox_a25" class="chk_1" /><label for="checkbox_a25"></label><div></div><div></div></div>
								<div id="date26"><input type="checkbox" id="checkbox_a26" class="chk_1" /><label for="checkbox_a26"></label><div></div><div></div></div>
								<div id="date27"><input type="checkbox" id="checkbox_a27" class="chk_1" /><label for="checkbox_a27"></label><div></div><div></div></div>
								<div id="date28"><input type="checkbox" id="checkbox_a28" class="chk_1" /><label for="checkbox_a28"></label><div></div><div></div></div>
							</div>
							<div class="track_date">
								<div id="date29"><input type="checkbox" id="checkbox_a29" class="chk_1" /><label for="checkbox_a29"></label><div></div><div></div></div>
								<div id="date30"><input type="checkbox" id="checkbox_a30" class="chk_1" /><label for="checkbox_a30"></label><div></div><div></div></div>
								<div id="date31"><input type="checkbox" id="checkbox_a31" class="chk_1" /><label for="checkbox_a31"></label><div></div><div></div></div>
								<div id="date32"><input type="checkbox" id="checkbox_a32" class="chk_1" /><label for="checkbox_a32"></label><div></div><div></div></div>
								<div id="date33"><input type="checkbox" id="checkbox_a33" class="chk_1" /><label for="checkbox_a33"></label><div></div><div></div></div>
								<div id="date34"><input type="checkbox" id="checkbox_a34" class="chk_1" /><label for="checkbox_a34"></label><div></div><div></div></div>
								<div id="date35"><input type="checkbox" id="checkbox_a35" class="chk_1" /><label for="checkbox_a35"></label><div></div><div></div></div>
							</div>
							<div class="track_date">
								<div id="date36"><input type="checkbox" id="checkbox_a36" class="chk_1" /><label for="checkbox_a36"></label><div></div><div></div></div>
								<div id="date37"><input type="checkbox" id="checkbox_a37" class="chk_1" /><label for="checkbox_a37"></label><div></div><div></div></div>
								<div id="date38"><input type="checkbox" id="checkbox_a38" class="chk_1" /><label for="checkbox_a38"></label><div></div><div></div></div>
								<div id="date39"><input type="checkbox" id="checkbox_a39" class="chk_1" /><label for="checkbox_a39"></label><div></div><div></div></div>
								<div id="date40"><input type="checkbox" id="checkbox_a40" class="chk_1" /><label for="checkbox_a40"></label><div></div><div></div></div>
								<div id="date41"><input type="checkbox" id="checkbox_a41" class="chk_1" /><label for="checkbox_a41"></label><div></div><div></div></div>
								<div id="date42"><input type="checkbox" id="checkbox_a42" class="chk_1" /><label for="checkbox_a42"></label><div></div><div></div></div>
							</div>
							<div class="track_bottom_bg"></div>
							<div class="track_bottom">
							<div class="track_bottom_left">
								<div class="track_bottom_left1">
									<div>
										<span><c:out value="${stateTrackArray[0][0]}"></c:out></span><span><c:out
												value="${stateTrackArray[0][1]}"></c:out></span>
									</div>
									<div>
										<span><c:out value="${stateTrackArray[1][0]}"></c:out></span><span><c:out
												value="${stateTrackArray[1][1]}"></c:out></span>
									</div>
									<div>
										<span><c:out value="${stateTrackArray[2][0]}"></c:out></span><span><c:out
												value="${stateTrackArray[2][1]}"></c:out></span>
									</div>
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
									<div>
										<span><c:out value="${stateTrackArray[5][0]}"></c:out></span><span><c:out
												value="${stateTrackArray[5][1]}"></c:out></span>
									</div>
									<div>
										<span><c:out value="${stateTrackArray[6][0]}"></c:out></span><span><c:out
												value="${stateTrackArray[6][1]}"></c:out></span>
									</div>
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
									<div>
										<span><c:out value="${stateTrackArray[9][0]}"></c:out></span><span><c:out
												value="${stateTrackArray[9][1]}"></c:out></span>
									</div>
									<div>
										<span><c:out value="${stateTrackArray[10][0]}"></c:out></span><span><c:out
												value="${stateTrackArray[10][1]}"></c:out></span>
									</div>
								</div>
								</div>
								<div class="track_bottom_right">
									<div class="track_bottom_right1">
										<div onclick="multiSelect()">确定</div>
										<select id="multi_select">
										</select>
										<div onclick="$('.chk_2').click();">多选</div>
										<input type="checkbox" id="multi_checkbox" class="chk_2" onchange="multiChecked()"/><label for="multi_checkbox"></label>
									</div>
									<div class="track_btn" onclick="addTrack()">提交</div>
								</div>
							</div>
						</div>
					</form>
				</td>
			</tr>
		</table>

	</div>
</body>
</html>
