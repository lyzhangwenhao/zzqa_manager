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

		<title>销售合同明细表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<meta name="rendere" content="webkit|ie-comp|ie-stand">
		<link rel="stylesheet" type="text/css" href="css/top.css">
		<link rel="stylesheet" type="text/css" href="css/sales_report.css">
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
		var stateArray=["待批复","已批复","被拒","部分采购","已采购","撤销中","已撤销"];
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
			getSalesDetailByTime();
			$("#kw").keydown(function(e){
				if(e.keyCode==13){
					getSalesDetailByTime();
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
		//endtime2+1 签订时间取的是0点，搜索结束时间不能加86400000
		function getSalesDetailByTime(){
			if(!changeTime){
				filterTable();
				return;
			}
			$.ajax({
				type:"post",//post方法
				url:"DeviceServlet",
				data:{"type":"getSalesDetailByTime","timeType":$("input[pname='timeType']").val(),
					"starttime1":starttime1,"endtime1":endtime1+86400000	,
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
				var sign_date= timeTransLongToStr(this.sign_time,4,"/");
				var saler=this.saler;
				var contract_no=this.contract_no;
				var state=stateArray[this.purchaseState];
				var project_name=this.project_name;
				var customer=this.company_name2;
				var payment=getPayment_modth(this.payment_method,this.payment_value);
				//-预估含税成本总和
				var all_pvt=0.0;
				//不含税单价总和
				var all_prices=0.0;
				$.each(this.product_infos,function(i){
					all_prices+=this.unit_price_taxes*this.num;
					all_pvt+=this.predict_costing_taxes*this.num;
					
					var unit_price=Math.round(this.unit_price_taxes/0.0117)/100;//不含税单价
					var price_taxes=Math.round(this.unit_price_taxes*this.num*100)/100;
					var price=Math.round(price_taxes/0.0117)/100;//不含税金额
					TRs+='<tr class="tab_tr2"><td>'+sign_date+'</td><td>'+saler+'</td><td>'+customer+'</td><td>'+project_name+'</td><td>'+contract_no+'</td>'
						+'<td>'+state+'</td><td>'+this.purchase_num+'</td><td>いのののの</td><td>'+(i+1)+'</td><td>'+this.materials_id+'</td>'
						+'<td>'+this.materials_remark+'</td><td>'+this.model+'</td><td>'+this.num+'</td><td>'+this.unit_price_taxes+'</td>'
						+'<td>'+unit_price+'</td><td>'+price_taxes+'</td><td>'+price+'</td><td>'+this.predict_costing_taxes+'</td>'
						+'<td>'+timeTransLongToStr(this.delivery_time,4,"/")+'</td><td>'+this.remark+'</td><td>'+payment+'</td></tr>';
				});
				//いのののの：标记整单毛利
				//整单毛利=（不含税金额总和-预估含税成本总和/1.17）/不含税金额总和 约掉1.17
				var gross_profit=Math.round((all_prices-all_pvt)/all_prices*10000)/100+"%";
				TRs=TRs.replace(/いのののの/g,gross_profit);
				$(".device_tab").append(TRs);
			});
			$(".device_tab tr:gt(0) td").attr("class","tooltip_div");
			filterTable();
			showToolTip($(".device_tab"));
		}
		function getPayment_modth(type,values){
			if(type==1){
				var array=values.split("の");
				return "合同签订后"+array[0]+"个工作日内， 需方支付合同总额的"+array[1]+"%预付款后合同生效；发货前支付合同总额的"+array[2]+"%， 款到3个工作内发货；到货后支付合同总额的"+array[3]+"%作为到货款；合同总额的"+array[4]+"%，作为质保金在质保期满七天内付清。";
			}else if(type==2){
				return "发货前支付全款，款到后供方发货并开具合同全额发票（17%增值税专用发票）。";
			}else if(type==3){
				return "货到票到"+values+"天内以电汇方式支付合同全款（17%增值税专用发票）。";
			}
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
			var filename="销售合同明细表";
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
				销售合同明细表
			</div>
			<div class="td2_div3">
				<img src="images/calendar.png" onclick="return Calendar('time2');">
				<input type="text" id="time2" class="input-show-time">
				<div>至</div>
				<img src="images/calendar.png" onclick="return Calendar('time1');">
				<input type="text" id="time1" class="input-show-time">
				<label>按创建时间</label>
			</div>
			<div class="td2_div3">
				<img src="images/calendar.png" onclick="return Calendar('time4');">
				<input type="text" id="time4" class="input-show-time">
				<div>至</div>
				<img src="images/calendar.png" onclick="return Calendar('time3');">
				<input type="text" id="time3" class="input-show-time">
				<label>按签订时间</label>
			</div>
			<div class="td1_div4">
				<img title="导出表格" src="images/export_track.png" id="img_export" onclick="exportSales();" class="exportSales">
				<img title="搜索" src="images/user_search.gif" id="searchSales" 
					onclick="getSalesDetailByTime();" class="searchSales">
				<input type="text" id="kw"  maxlength="30" placeholder="" 
					onkeydown="if(event.keyCode==32) return false">
			</div>
			<table class="device_tab">
				<tr class="tab_tr1">
					<td style="width:60px">
						签订时间
					</td>
					<td>
						销售
					</td>
					<td>
						客户名称
					</td>
					<td>
						项目名称
					</td>
					<td>
						合同编号
					</td>
					<td>
						合同状态
					</td>
					<td>
						已采购数量
					</td>
					<td>
						整单毛利
					</td>
					<td style="width:20px">
						序号
					</td>
					<td>
						物料编码
					</td>
					<td>
						产品描述
					</td>
					<td>
						型号
					</td>
					<td>
						数量
					</td>
					<td>
						含税销售单价
					</td>
					<td style="width:60px;">
						不含税销售单价
					</td>
					<td>
						含税金额
					</td>
					<td>
						不含税金额
					</td>
					<td>
						预计含税成本
					</td>
					<td style="width:60px">
						交货期
					</td>
					<td>
						备注
					</td>
					<td>
						付款方式
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>
