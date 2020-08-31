<%@page import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page
	import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.pojo.linkman.Linkman"%>
<%@page import="com.zzqa.service.interfaces.position_user.Position_userManager"%>
<%@page import="com.zzqa.service.interfaces.permissions.PermissionsManager"%>
<%@page import="com.zzqa.service.interfaces.work.WorkManager"%>
<%@page import="com.zzqa.pojo.work.Work"%>
<%@page import="com.zzqa.pojo.project.Project"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
	WorkManager workManager=(WorkManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("workManager");
	PermissionsManager permissionsManager=(PermissionsManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("permissionsManager");
	Position_userManager position_userManager=(Position_userManager)WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("position_userManager");
	if (session.getAttribute("uid") == null) {
		response.sendRedirect("../login.jsp");
		return;
	}
	int uid = (Integer) session.getAttribute("uid");
	User mUser = userManager.getUserByID(uid);
	if (mUser == null) {
		response.sendRedirect("../login.jsp");
		return;
	}
	List<Project> projects=workManager.getProjects();
	List<User> users=workManager.getAllUserWidthWork();//添加过工时表的用户
	List<Integer> son_pids=position_userManager.getSonPosition(mUser.getPosition_id());
	if(!("admin".equals(mUser.getName())||permissionsManager.checkPermission(mUser.getPosition_id(), 104))){
		//只能看下属或自己
		Iterator<User> it=users.iterator();
		while(it.hasNext()){
			User user=(User)it.next();
			if(!(son_pids.contains(user.getPosition_id())||uid==user.getId())){
				it.remove();
			}
		}
	}
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>工时统计报表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<link rel="stylesheet" type="text/css" href="css/bootstrap/bootstrap.min-3.2.css">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/work_report.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		<script type="text/javascript" src="js/showdate3.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		
		<script type="text/javascript" src="js/work_report.js"></script>
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
			var flag=0;//0：隐藏
			var selectedType=0;//0：人员；1：项目
			var selectedProject_index=-1;//idいname
			var selectedUser_index=-1;
			var selectedPids="";//人报筛选项目
			var selectedUids="";//项目报筛人员
			var jsonDate;//List<Work>
			var remarkArray;//数组
			var contentArray;//内容
			var pageType=2;
			var uids;//1の2
			var reportJson;
			var projectArray=[
	      			<%for(int i=0,plen=projects.size();i<plen;i++){Project project=projects.get(i);
	      				if(i>0){
	      					out.write(",");
	      				}
	      				out.write("["+project.getId()+",'"+project.getProject_name()+"',"+true+",0]");//项目时间统计
	      			}%>
	      	        ];
			var userArray=[
				<%for(int i=0,ulen=users.size();i<ulen;i++){User user=users.get(i);
					if(i>0){
						out.write(",");
					}
					out.write("["+user.getId()+",'"+user.getTruename()+"',"+true+",0]");//人员时间统计
				}%>
			];
			var starttime;
			var endtime=<%=System.currentTimeMillis()%>;
			var dataArray;//存储的数据栏      [[p_index，data1......]]
			var dateArray;//表格日期栏        时间范围内的所有日期 [[时间戳1，日期1，判断新的一月(需要显示浮窗),周几
			var weekArray=["日","一","二","三","四","五","六"];
			$(function(){
				initTime();
				starttime=0;//第一次强制刷新
				setPage(2);
				var temp='<tr><td>人员/项目</td>';
				$(projectArray).each(function(){
					temp+='<td>'+this[1]+'</td>';
				});
				$("#workstatistics_tab").html(temp+'<td>合计</td></tr>');
		    });
			window.onresize = resize;
			function setPage(index){
				pageType=index;
				if(index==1){
					$("#work_detail_report").css("display","none");
					$("#work_statistics_report").css("display","block");
					$(".td1_div0").text("工时导出");
					var start=new Date($("#time1").val()).getTime();//开始月份为开始月份的1号
					var end=new Date($("#time2").val()).getTime();
					getWorkByMonths(start,end);
				}else{
					$("#work_detail_report").css("display","block");
					$("#work_statistics_report").css("display","none");
					$(".td1_div0").text("工时统计报表");
					getWorkReport();
				}
			}
			/**工时统计报表**/
		    function exportTrack(){
		    	if(pageType==1){//工时导出
		    		if($("#workstatistics_tab tr").length==1){
			    		initdiglog2("提示信息", "没有数据！");
			    		return;
			    	}
			    	var temp='';
			    	$("#workstatistics_tab tr").each(function(){
			    		var rowTemp='';
			    		$(this).find("td").each(function(){
			    			rowTemp+='の'+$(this).text().trim();
				    	});
			    		temp+="い"+rowTemp.replace('の','');
			    	});
			    	temp=temp.replace("い","");
			    	//导出excel
		    		if(loading){
		    			return;
		    		}
		    		loading=!loading;
		    		var data1=$("#time1").val();
		    		data1=data1.replace("/","年").replace("/","月")+"日";
		    		var data2=$("#time2").val();
		    		data2=data2.replace("/","年").replace("/","月")+"日";
		    		var filename="工时统计报表（"+data1+"-"+data2+"）";
		    		$.ajax({
		    			type:"post",//post方法
		    			url:"HandelTempFileServlet",
		    			data:{"type":"exporttrack_out","data":temp},
		    			//ajax成功的回调函数
		    			success:function(returnData){
		    				if(returnData.length>1){
		    					window.location.href="FileDownServlet?type=loadtrackexcel&filePath="+returnData+"&filename="+filename;
		    				}else{
		    					//失败
		    					initdiglog2("提示信息", "导出失败！");
		    				}
		    				loading=!loading;
		    			},
		    			error : function(){
		    				initdiglog2("提示信息","导出失败！");
		    				loading=!loading;
		    			}
		    		});
		    	}else{//工时统计报表
		    		if($("#workreport_tab tr").length==2){
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
			    	$("#workreport_tab tr").each(function(){
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
		    		var filename;
		    		if(selectedType==0){
		    			filename="工时统计报表-"+userArray[selectedUser_index][1];
		    		}else{
		    			filename="工时统计报表-"+projectArray[selectedProject_index][1];
		    		}
		    		$.ajax({
		    			type:"post",//post方法
		    			url:"HandelTempFileServlet",
		    			data:{"type":"exporttrack_out","data":temp},
		    			//ajax成功的回调函数
		    			success:function(returnData){
		    				if(returnData.length>1){
		    					window.location.href="FileDownServlet?type=loadtrackexcel&filePath="+returnData+"&filename="+filename;
		    				}else{
		    					//失败
		    					initdiglog2("提示信息", "导出失败！");
		    				}
		    				loading=!loading;
		    			},
		    			error : function(){
		    				initdiglog2("提示信息","导出失败！");
		    				loading=!loading;
		    			}
		    		});
		    	}
	    	}
		</script>
	</head>

	<body>
		<jsp:include page="/top.jsp" >
	<jsp:param name="index" value="2" />
	</jsp:include>
		<div class="td1_work">
			<div class="device_top_btns">
				<div class="btn-group" role="group" aria-label="...">
				  	<button type="button" class="btn btn-default" onclick="setPage(1)">工时导出</button>
				  	<button type="button" class="btn btn-default" onclick="setPage(2)">工时统计报表</button>
				</div>
				</div>
			<div class="td1_div0">
				工时统计报表
			</div>
			<div class="td2_div3">
				<img src="images/calendar.png" id="img2" onclick="return Calendar('time4');">
				<input type="text" id="time4" class="input-hide-time"><input type="text" id="time2" class="input-show-time"><div>至</div>
				<img src="images/calendar.png" id="img1" onclick="return Calendar('time3');"><input type="text" id="time3" class="input-hide-time">
				<input type="text" id="time1" class="input-show-time">
			</div>
			<div id="work_detail_report">
				<div class="title_top">
					<div class="title_top_name">人员：</div>
					<div class="title_top_value"></div>
					<img title="导出表格" src="images/export_track.png" onclick="exportTrack();" class="title_top_export">
					<div class="title_top_filter" onclick="showFilterDialog()">筛选</div>
					<div class="title_top_search" onclick="showSearchDialog()">查看</div>
					<label><input type="radio" name="selectedType" value="1" onchange="selectTypeChange()"> 项目</label>
					<label><input type="radio" name="selectedType" value="0" onchange="selectTypeChange()" checked>人员</label>
					<div class="clearfloat_div"></div>
				</div>
				<div class="workreport_tab_lefttitle_parent"><div id="workreport_tab_lefttitle" class="workreport_tab_lefttitle"></div><div id="workreport_tab_lefttitle2" class="workreport_tab_lefttitle2"></div></div>
				<div class="workreport_div" id="workreport_div">
					<table class="workreport_tab" id="workreport_tab">
					
					</table>
				</div>
			</div>
			<div id="work_statistics_report">
				<div class="title_top">
					<span style="display:inline-block;height:20px"></span><!-- 将父控件撑开 -->
					<img title="导出表格" src="images/export_track.png" onclick="exportTrack();" class="title_top_export">
					<div class="title_top_search2" onclick="setPage(1)">搜索</div>
				</div>
				<div class="workstatistics_tab_lefttitle_parent"><div id="workstatistics_tab_lefttitle" class="workstatistics_tab_lefttitle"></div><div id="workstatistics_tab_lefttitle2" class="workstatistics_tab_lefttitle2"></div></div>
				<div class="workstatistics_div" id="workstatistics_div">
					<table class="workstatistics_tab" id="workstatistics_tab">
					
					</table>
				</div>
			</div>
		</div>
		<div class="dialog_search" id="dialog_search_user">
			<div class="dialog_close" onclick="closeSearchDialog()"></div>
			<div class="dialog_search_filter"><div onclick="filterByKW()"></div><div></div><input type="text" placeholder="选择人员" oninput="filterByKW()" maxlength="10"></div>
			<div class="dialog_search_row" ></div>
		</div>
		<div class="dialog_search" id="dialog_search_project">
			<div class="dialog_close" onclick="closeSearchDialog()"></div>
			<div class="dialog_search_filter"><div onclick="filterByKW()"></div><div></div><input type="text" placeholder="选择项目" oninput="filterByKW()" maxlength="10"></div>
			<div class="dialog_search_row" ></div>
		</div>
		<div class="dialog_search" id="dialog_filter_user">
			<div class="dialog_close" onclick="closeFilterDialog()"></div>
			<div class="dialog_filter_checkAll">
				<input type="checkbox" class="chk_1" id="filterUserAll" onchange="checkboxChange()" checked>
				<label for="filterUserAll" ></label>
				<div class="dialog_filter_btn1" onclick="filterSelectAll()">全选</div>
				<div class="dialog_filter_btn2" onclick="filterWatch()">查看</div>
			</div>
			<div class="dialog_search_row" ></div>
		</div>
		<div class="dialog_search" id="dialog_filter_project">
			<div class="dialog_close" onclick="closeFilterDialog()"></div>
			<div class="dialog_filter_checkAll">
				<input type="checkbox" class="chk_1" id="filterProjectAll" onchange="checkboxChange()" checked>
				<label for="filterProjectAll"></label>
				<div class="dialog_filter_btn1" onclick="filterSelectAll()">全选</div>
				<div class="dialog_filter_btn2" onclick="filterWatch()">查看</div>
			</div>
			<div class="dialog_search_row" ></div>
		</div>
		<div class="dialog_workday">
		<div class="dialog_workday_title">
			<div title="关闭" onclick="closeWorkSetDialog()"></div>
		</div>
		<div class="dialog_workday_date">
			<div>日期：</div>
			<div>2018-12-11</div>
		</div>
		<div class="dialog_workday_list">
		</div>
		<div class="dialog_workday_content">
			<div>内容：</div>
			<div></div>
		</div>
		<div class="dialog_workday_remark">
			<div>批注：</div>
			<div></div>
		</div>
	</div>
	</body>
</html>
