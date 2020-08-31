<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="com.zzqa.service.interfaces.user.UserManager"%>
<%@page import="com.zzqa.pojo.user.User"%>
<%@page import="com.zzqa.util.DataUtil"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	UserManager userManager = (UserManager) WebApplicationContextUtils
			.getRequiredWebApplicationContext(getServletContext())
			.getBean("userManager");
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
%>

<!DOCTYPE html>
<html>
	<head>
		<base href="<%=basePath%>">

		<title>出货明细表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="rendere" content="webkit|ie-comp|ie-stand">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/shipping_report.css">
		<link rel="stylesheet" type="text/css" href="css/jquery-ui.min.css">
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<script type="text/javascript" src="js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="js/dialog.js"></script>
		<script type="text/javascript" src="js/showdate3.js"></script>
		<script type="text/javascript" src="js/public.js"></script>
		
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<script type="text/javascript">
		var starttime1;
		var endtime1=<%=System.currentTimeMillis()%>;
		var starttime2;
		var endtime2;
		var changeTime=true;//判断时间是否变动，向后台请求数据
		var jsonDate;
		$(function(){
			var nowDate=new Date(endtime1);
			var date1=nowDate.getFullYear()+"/"+(nowDate.getMonth()+1)+"/1";
			var date2=nowDate.getFullYear()+"/"+(nowDate.getMonth()+1)+"/"+nowDate.getDate();
			starttime1=new Date(date1).getTime();
			endtime1=new Date(date2).getTime();
			starttime2=starttime1;
			endtime2=endtime1;
			$("#time1").val(date1);
			$("#time2").val(date2);
			$("#time3").val(date1);
			$("#time4").val(date2);
			$("#time1").prop("readonly","readonly");
			$("#time2").prop("readonly","readonly");
			$("#time3").prop("readonly","readonly");
			$("#time4").prop("readonly","readonly");
			getShippingDetailByTime();
			$("#kw").keydown(function(e){
				if(e.keyCode==13){
					getShippingDetailByTime();
				}
			});
		});
		function setTime(time,obj){
			if(obj==document.getElementById("time1")){
				var time1=new Date(time).getTime();
				var time2=new Date($("#time2").val()).getTime();
				//修改time1的时间
		    	if(time1<=time2){
		    		if(time1!=starttime1){
		    			changeTime=true;
		    			obj.value=time;//time3
		    			starttime1=time1;
		    		}
		    	}else{
		    		initdiglog2("提示信息","开始时间必须早于结束时间！");
		    	}
			}else if(obj==document.getElementById("time2")){
				//修改time2的时间
				var time1=new Date($("#time1").val()).getTime();
				var time2=new Date(time).getTime();
		    	if(time1<=time2){
		    		if(time2!=endtime1){
		    			changeTime=true;
		    			obj.value=time;
			    		endtime1=time2;
		    		}
		    	}else{
		    		initdiglog2("提示信息","结束时间必须晚于开始时间！");
		    	}
			}else  if(obj==document.getElementById("time3")){
				var time3=new Date(time).getTime();
				var time4=new Date($("#time4").val()).getTime();
				//修改time1的时间
		    	if(time3<=time4){
		    		if(time3!=starttime2){
		    			changeTime=true;
		    			obj.value=time;//time3
			    		starttime2=time3;
		    		}
		    	}else{
		    		initdiglog2("提示信息","开始时间必须早于结束时间！");
		    	}
			}else if(obj==document.getElementById("time4")){
				//修改time2的时间
				var time3=new Date($("#time3").val()).getTime();
				var time4=new Date(time).getTime();
		    	if(time3<=time4){
		    		if(time2!=endtime2){
		    			changeTime=true;
		    			obj.value=time;
			    		endtime2=time4;
		    		}
		    	}else{
		    		initdiglog2("提示信息","结束时间必须晚于开始时间！");
		    	}
			}
		}
		//endtime2+1 发货时间取的是0点，搜索结束时间不能加86400000
		function getShippingDetailByTime(){
			if(!changeTime){
				filterTable();
				return;
			}
			$.ajax({
				type:"post",//post方法
				url:"DeviceServlet",
				data:{"type":"getShippingDetailByTime","timeType":$("input[pname='timeType']").val(),
					"starttime1":starttime1,"endtime1":endtime1+86400000,
					"starttime2":starttime2,"endtime2":endtime2+1},
				timeout : 15000,
				dataType:'json',
				success:function(returnData){
					changeTime=false;
					jsonDate=returnData;
					showData();
				},
				complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
					if(status!='success'){//超时,status还有success,error等值的情况
						if(status=='timeout'){
							initdiglog2("提示信息","请求超时！");
						}else{
							initdiglog2("提示信息","操作异常,请重试！");
						}
					}
					$(".dialog_work_bg").css("display","none");
				}
			});
		}
		function filterTable(){
			var kw=$("#kw").val();
			$(".device_tab tr:gt(0)").each(function(){
				if($(this).text().indexOf(kw)!=-1){
					$(this).attr("showTR",1);//0：不显示，1：显示
				}else{
					$(this).attr("showTR",0);//0：不显示，1：显示
				}
			});
			$("tr[showTR=1]").css("display","table-row");
			$("tr[showTR=0]").css("display","none");
		}
		function showData(){
			$(".device_tab tr:gt(0)").remove();
			$.each(jsonDate,function(){
				var TRs='';
				var create_date= this.create_date;
				var customer_name=this.customer_name;
				var contract_no=this.contract_no;
				var customer_contract_no=this.customer_contract_no;
				var saler=this.saler;
				var address=this.address+'&nbsp;'+this.linkman+'&nbsp;'+this.linkman_phone;
				var ship_date=this.ship_date;
				var logistics_num=this.logistics_num;
				var logistics_company=this.logistics_company;
				var orderId=this.orderId;
				$.each(this.shipping_lists,function(i){
					var materials_id=this.materials_id;
					var name=this.name;
					var model=this.model;
					var unit=this.unit;
					var contract_num=this.contract_num;
					var unit_price=this.unit_price;
					var last_num=this.last_num;
					var num=this.num;
					var price=num*unit_price;
					var remark=this.remark;
					var logistics_demand=this.logistics_demand;
					TRs+='<tr class="tab_tr2"><td>'+create_date+'</td><td>'+customer_name+'</td><td>'+contract_no+'</td><td>'+customer_contract_no+'</td>'
						+'<td>'+(i+1)+'</td><td>'+saler+'</td><td>'+materials_id+'</td><td>'+name+'</td><td>'+model+'</td><td>'+unit+'</td>'
						+'<td>'+contract_num+'</td><td>'+unit_price+'</td><td>'+last_num+'</td><td>'+num+'</td>'
						+'<td>'+price+'</td><td>'+remark+'</td><td>'+logistics_demand+'</td><td>'+address+'</td>'
						+'<td>'+ship_date+'</td><td>'+logistics_num+'</td><td>'+logistics_company+'</td><td>'+orderId+'</td></tr>';
				});
				$(".device_tab").append(TRs);
			});
			$(".device_tab tr:gt(0) td").attr("class","tooltip_div");
			filterTable();
			showToolTip($(".device_tab"));
		}
		function exportSales(){
			var data="";
			$(".device_tab tr[showtr!=0]").each(function(i){
				if(i>0){
					data+="い";
				}
				$(this).find("td").each(function(k){
					if(k>0){
						data+="の";
					}
					data+=$(this).text().trim();
				});
			});
			var filename="出货明细表";
			$.ajax({
				type:"post",//post方法
				url:"HandelTempFileServlet",
				data:{"type":"exporttrack_out","data":data},
				//ajax成功的回调函数
				success:function(returnData){
					if(returnData.length>1){
						window.location.href="FileDownServlet?type=loadtrackexcel&filePath="+returnData+"&filename="+filename;
					}else{
						//失败
						initdiglog2("提示信息", "导出失败！");
					}
				},
				complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
					if(status!='success'){//超时,status还有success,error等值的情况
						initdiglog2("提示信息","导出失败！");
					}
				}
			});
		}
		</script>
	</head>

	<body>
		<jsp:include page="/top.jsp" >
	<jsp:param name="name" value="<%=mUser.getName() %>" />
	<jsp:param name="level" value="<%=mUser.getLevel() %>" />
	<jsp:param name="index" value="2" />
	</jsp:include>
		<div class="td1_sales">
			<div class="td1_div3">
				出货明细表
			</div>
			<div class="td2_div3">
				<img src="images/calendar.png" onclick="return Calendar('time2');">
				<input type="text" id="time2" class="input-show-time">
				<div>至</div>
				<img src="images/calendar.png" onclick="return Calendar('time1');">
				<input type="text" id="time1" class="input-show-time">
				<label>按申请时间</label>
			</div>
			<div class="td2_div3">
				<img src="images/calendar.png" onclick="return Calendar('time4');">
				<input type="text" id="time4" class="input-show-time">
				<div>至</div>
				<img src="images/calendar.png" onclick="return Calendar('time3');">
				<input type="text" id="time3" class="input-show-time">
				<label>按发货时间</label>
			</div>
			<div class="td1_div4">
				<img title="导出表格" src="images/export_track.png" id="img_export" onclick="exportSales();" class="exportSales">
				<img title="搜索" src="images/user_search.gif" id="searchSales" 
					onclick="getShippingDetailByTime();" class="searchSales">
				<input type="text" id="kw"  maxlength="30" placeholder="" 
					onkeydown="if(event.keyCode==32) return false">
			</div>
			<table class="device_tab">
				<tr class="tab_tr1">
					<td style="width:60px">
						申请时间
					</td>
					<td>
						客户名称
					</td>
					<td>
						中自合同号
					</td>
					<td>
						客户合同号
					</td>
					<td style="width:20px">
						序号
					</td>
					<td>
						销售人员
					</td>
					<td>
						物料号
					</td>
					<td>
						设备名称
					</td>
					<td>
						型号
					</td>
					<td>
						单位
					</td>
					<td>
						合同数量
					</td>
					<td>
						单价
					</td>
					<td>
						未发货数量
					</td>
					<td>
						本次发货数量
					</td>
					<td>
						本次发货金额
					</td>
					<td>
						备注
					</td>
					<td>
						物流要求
					</td>
					<td>
						发货地址
					</td>
					<td style="width:60px">
						实际发货时间
					</td>
					<td>
						件数
					</td>
					<td>
						物流公司
					</td>
					<td>
						物流单号
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
