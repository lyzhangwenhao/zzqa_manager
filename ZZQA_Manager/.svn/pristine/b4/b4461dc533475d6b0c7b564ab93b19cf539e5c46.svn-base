package com.zzqa.servlet;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import org.springframework.web.context.support.WebApplicationContextUtils;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import com.zzqa.pojo.aftersales_task.Aftersales_task;
import com.zzqa.pojo.deliver.Deliver;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.leave.Leave;
import com.zzqa.pojo.manufacture.Manufacture;
import com.zzqa.pojo.outsource_product.Outsource_product;
import com.zzqa.pojo.product_procurement.Product_procurement;
import com.zzqa.pojo.project_procurement.Project_procurement;
import com.zzqa.pojo.purchase_contract.Purchase_contract;
import com.zzqa.pojo.resumption.Resumption;
import com.zzqa.pojo.sales_contract.Sales_contract;
import com.zzqa.pojo.seal.Seal;
import com.zzqa.pojo.shipments.Shipments;
import com.zzqa.pojo.shipping.Shipping;
import com.zzqa.pojo.task.Task;
import com.zzqa.pojo.track.Track;
import com.zzqa.pojo.travel.Travel;
import com.zzqa.pojo.user.User;
import com.zzqa.pojo.vehicle.Vehicle;
import com.zzqa.service.interfaces.aftersales_task.Aftersales_taskManager;
import com.zzqa.service.interfaces.deliver.DeliverManager;
import com.zzqa.service.interfaces.flow.FlowManager;
import com.zzqa.service.interfaces.leave.LeaveManager;
import com.zzqa.service.interfaces.manufacture.ManufactureManager;
import com.zzqa.service.interfaces.outsource_product.Outsource_productManager;
import com.zzqa.service.interfaces.product_procurement.Product_procurementManager;
import com.zzqa.service.interfaces.project_procurement.Project_procurementManager;
import com.zzqa.service.interfaces.purchase_contract.Purchase_contractManager;
import com.zzqa.service.interfaces.resumption.ResumptionManager;
import com.zzqa.service.interfaces.sales_contract.Sales_contractManager;
import com.zzqa.service.interfaces.seal.SealManager;
import com.zzqa.service.interfaces.shipments.ShipmentsManager;
import com.zzqa.service.interfaces.shipping.ShippingManager;
import com.zzqa.service.interfaces.task.TaskManager;
import com.zzqa.service.interfaces.track.TrackManager;
import com.zzqa.service.interfaces.travel.TravelManager;
import com.zzqa.service.interfaces.user.UserManager;
import com.zzqa.service.interfaces.vehicle.VehicleManager;
import com.zzqa.util.DataUtil;
import com.zzqa.util.SendMessage;
import com.zzqa.util.XmlUtil;

public class DelayEmailServlet extends HttpServlet{
	public static Map<String,Integer> delayMap=new HashMap<String,Integer>();
	private UserManager userManager;
	private FlowManager flowManager;
	private TaskManager taskManager;
	private Product_procurementManager product_procurementManager;
	private Project_procurementManager project_procurementManager;
	private Outsource_productManager outsource_productManager;
	private ManufactureManager manufactureManager;
	private ShipmentsManager shipmentsManager;
	private TravelManager travelManager;
	private LeaveManager leaveManager;
	private ResumptionManager resumptionManager;
	private TrackManager trackManager;
	private Sales_contractManager sales_contractManager;
	private Purchase_contractManager purchase_contractManager;
	private Aftersales_taskManager aftersales_taskManager;
	private SealManager sealManager;
	private VehicleManager vehicleManager;
	private ShippingManager shippingManager;
	private DeliverManager deliverManager;
	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		userManager=(UserManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("userManager");
		flowManager=(FlowManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("flowManager");
		taskManager=(TaskManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("taskManager");
		product_procurementManager=(Product_procurementManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("product_procurementManager");
		project_procurementManager=(Project_procurementManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("project_procurementManager");
		outsource_productManager=(Outsource_productManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("outsource_productManager");
		manufactureManager=(ManufactureManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("manufactureManager");
		shipmentsManager=(ShipmentsManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("shipmentsManager");
		travelManager=(TravelManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("travelManager");
		leaveManager=(LeaveManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("leaveManager");
		resumptionManager=(ResumptionManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("resumptionManager");
		trackManager=(TrackManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("trackManager");
		sales_contractManager=(Sales_contractManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("sales_contractManager");
		purchase_contractManager=(Purchase_contractManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("purchase_contractManager");
		aftersales_taskManager=(Aftersales_taskManager)WebApplicationContextUtils	.getRequiredWebApplicationContext(getServletContext()).getBean("aftersales_taskManager");
		sealManager=(SealManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("sealManager");
		vehicleManager=(VehicleManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("vehicleManager");
		shippingManager=(ShippingManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("shippingManager");
		deliverManager=(DeliverManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("deliverManager");
		Thread thread_overdueMail=new Thread(new OverdueMail(),"setOverdueMail");
		thread_overdueMail.start();//待办事项过期每隔7天邮件提醒功能
	}
	private static String address="<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;内网链接：http://10.100.0.2/ZZQA_Manager<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;外网链接：http://oa.windit.com.cn";
	private static void sendMail(String tomail,String msg){
		String title="OA办公系统邮件提醒";
		SendMessage sendMessage=new SendMessage(title,msg,tomail);
		new Thread(sendMessage).start();
	}
	private void getDelayFlow(int day){
		List<User> userList=userManager.getAllUserNoLeave();
		for (User user:userList) {
			//一周只发一次
			if(user.getLevel()==0&&user.getId()%5==day){
				int num=0;
				long lasttime=System.currentTimeMillis();//算最小值即最早的日期，初始不可为0
				List list1=taskManager.getTaskListByUID(user);
				if(list1!=null&&list1.size()>0){
					Task task=(Task)list1.get(list1.size()-1);//逆序排，最晚的排在list最后
					if(task!=null){
						Flow flow= flowManager.getNewFlowByFID(1, task.getId());
						if(flow!=null){
							lasttime=Math.min(lasttime,flow.getCreate_time());
							num+=list1.size();
						}
					}
					list1.clear();
				}
				list1=taskManager.getStartupTaskListByUID(user);
				if(list1!=null&&list1.size()>0){
					Task task=(Task)list1.get(list1.size()-1);
					if(task!=null){
						Flow flow= flowManager.getNewFlowByFID(17, task.getId());
						if(flow!=null){
							lasttime=Math.min(lasttime,flow.getCreate_time());
							num+=list1.size();
						}
					}
					list1.clear();
				}
				list1=product_procurementManager.getProduct_procurementListByUID(user);
				if(list1!=null&&list1.size()>0){
					Product_procurement pp=(Product_procurement)(list1.get(list1.size()-1));
					if(pp!=null){
						Flow flow= flowManager.getNewFlowByFID(2, pp.getId());
						if(flow!=null){
							lasttime=Math.min(lasttime,flow.getCreate_time());
							num+=list1.size();
						}
					}
					list1.clear();
				}
				list1=project_procurementManager.getProject_procurementListByUID(user);
				if(list1!=null&&list1.size()>0){
					Project_procurement pp=(Project_procurement)list1.get(list1.size()-1);
					if(pp!=null){
						Flow flow= flowManager.getNewFlowByFID(3, pp.getId());
						if(flow!=null){
							lasttime=Math.min(lasttime,flow.getCreate_time());
							num+=list1.size();
						}
					}
					list1.clear();
				}
				list1=outsource_productManager.getOutsourceByUID(user);
				if(list1!=null&&list1.size()>0){
					Outsource_product op=(Outsource_product)list1.get(list1.size()-1);
					if(op!=null){
						Flow flow= flowManager.getNewFlowByFID(4, op.getId());
						if(flow!=null){
							lasttime=Math.min(lasttime,flow.getCreate_time());
							num+=list1.size();
						}
					}
					list1.clear();
				}
				/*list1=manufactureManager.getManufactureListByUID(user);
				if(list1!=null&&list1.size()>0){
					Manufacture mf=(Manufacture)list1.get(list1.size()-1);
					if(mf!=null){
						Flow flow= flowManager.getNewFlowByFID(5, mf.getId());
						if(flow!=null){
							lasttime=Math.min(lasttime,flow.getCreate_time());
							num+=list1.size();
						}
						list1.clear();
					}
				}*/
				list1=shipmentsManager.getShipmentsListByUID(user);
				if(list1!=null&&list1.size()>0){
					Shipments shipments=(Shipments)list1.get(list1.size()-1);
					if(shipments!=null){
						Flow flow= flowManager.getNewFlowByFID(6, shipments.getId());
						if(flow!=null){
							lasttime=Math.min(lasttime,flow.getCreate_time());
							num+=list1.size();
						}
					}
					list1.clear();
				}
				list1=travelManager.getTravelListByUID(user);
				if(list1!=null&&list1.size()>0){
					Travel travel=(Travel)list1.get(list1.size()-1);
					if(travel!=null){
						Flow flow= flowManager.getNewFlowByFID(7, travel.getId());
						if(flow!=null){
							lasttime=Math.min(lasttime,flow.getCreate_time());
							num+=list1.size();
						}
					}
					list1.clear();
				}
				list1=leaveManager.getLeaveListByUID(user);
				if(list1!=null&&list1.size()>0){
					Leave leave=(Leave)list1.get(list1.size()-1);
					if(leave!=null){
						Flow flow= flowManager.getNewFlowByFID(8,leave.getId());
						if(flow!=null){
							lasttime=Math.min(lasttime,flow.getCreate_time());
							num+=list1.size();
						}
					}
					list1.clear();
				}
				list1=resumptionManager.getResumptionListByUID(user);
				if(list1!=null&&list1.size()>0){
					Resumption resumption=(Resumption)list1.get(list1.size()-1);
					Flow flow= flowManager.getNewFlowByFID(9, resumption.getId());
					if(flow!=null){
						lasttime=Math.min(lasttime,flow.getCreate_time());
						num+=list1.size();
					}
					list1.clear();
				}
				list1=trackManager.getTrackListByUID(user);
				if(list1!=null&&list1.size()>0){
					Track track=(Track)list1.get(list1.size()-1);
					Flow flow= flowManager.getNewFlowByFID(10, track.getId());
					if(flow!=null){
						lasttime=Math.min(lasttime,flow.getCreate_time());
						num+=list1.size();
					}
					list1.clear();
				}
				list1=sales_contractManager.getSalesListByUID(user);
				if(list1!=null&&list1.size()>0){
					Sales_contract sales_contract=(Sales_contract)list1.get(list1.size()-1);
					Flow flow= flowManager.getNewFlowByFID(11, sales_contract.getId());
					if(flow!=null){
						lasttime=Math.min(lasttime,flow.getCreate_time());
						num+=list1.size();
					}
					list1.clear();
				}
				list1=purchase_contractManager.getPurchaseListByUID(user);
				if(list1!=null&&list1.size()>0){
					Purchase_contract purchase_contract=(Purchase_contract)list1.get(list1.size()-1);
					Flow flow= flowManager.getNewFlowByFID(12, purchase_contract.getId());
					if(flow!=null){
						lasttime=Math.min(lasttime,flow.getCreate_time());
						num+=list1.size();
					}
					list1.clear();
				}
				list1=aftersales_taskManager.getAftersales_taskByUID(user);
				if(list1!=null&&list1.size()>0){
					Aftersales_task aftersales_task=(Aftersales_task)list1.get(list1.size()-1);
					Flow flow= flowManager.getNewFlowByFID(13, aftersales_task.getId());
					if(flow!=null){
						lasttime=Math.min(lasttime,flow.getCreate_time());
						num+=list1.size();
					}
					list1.clear();
				}
				list1=sealManager.getSealByUID(user);
				if(list1!=null&&list1.size()>0){
					Seal seal=(Seal)list1.get(list1.size()-1);
					Flow flow= flowManager.getNewFlowByFID(14, seal.getId());
					if(flow!=null){
						lasttime=Math.min(lasttime,flow.getCreate_time());
						num+=list1.size();
					}
					list1.clear();
				}
				list1=vehicleManager.getVehicleByUID(user);
				if(list1!=null&&list1.size()>0){
					Vehicle vehicle=(Vehicle)list1.get(list1.size()-1);
					Flow flow= flowManager.getNewFlowByFID(15, vehicle.getId());
					if(flow!=null){
						lasttime=Math.min(lasttime,flow.getCreate_time());
						num+=list1.size();
					}
					list1.clear();
				}
				list1=shippingManager.getShippingListByUID(user);
				if(list1!=null&&list1.size()>0){
					Shipping shipping=(Shipping)list1.get(list1.size()-1);
					Flow flow= flowManager.getNewFlowByFID(18, shipping.getId());
					if(flow!=null){
						lasttime=Math.min(lasttime,flow.getCreate_time());
						num+=list1.size();
					}
					list1.clear();
				}
				list1=deliverManager.getDeliverListByUID(user);
				if(list1!=null&&list1.size()>0){
					Deliver deliver=(Deliver)list1.get(list1.size()-1);
					Flow flow= flowManager.getNewFlowByFID(20, deliver.getId());
					if(flow!=null){
						lasttime=Math.min(lasttime,flow.getCreate_time());
						num+=list1.size();
					}
					list1.clear();
				}
				
				lasttime=(System.currentTimeMillis()-lasttime)/604800000;//周数 有超过一周的才计算
				if(num>0&&lasttime>0){
					StringBuilder sbBuilder=new StringBuilder();
					sbBuilder.append(user.getTruename()).append(" 您好：").append("<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
					.append("您有").append(num).append("个待办事项需要处理，其中最长的已超过").append(lasttime).append("周，请及时处理");
					sendMail(user.getEmail(),sbBuilder.append(address).toString());
				}
			}
		}
	}
	private void handelHoliday(){
		try {
			String path=getServletContext().getRealPath("");
			Element root = XmlUtil.readXML(path + "/holiday.xml");
			NodeList years = root.getElementsByTagName("year");
			String[][] yearArray=new String[years.getLength()][12];
			for (int i = 0; i < years.getLength(); i++) {
				String[] mongthArray=new String[]{"","","","","","","","","","","",""};
				if(years.item(i)==null){
					System.err.println("节假日月份不完整!");
				}else{
					Element year = (Element) years.item(i);
					NodeList months = year.getElementsByTagName("month");
					int len=months.getLength();
					for (int k = 0; k < 12; k++) {
						if(months.getLength()>k&&months.item(k)!=null){
							Element month=(Element)months.item(k);
							mongthArray[k]="-"+month.getFirstChild().getNodeValue().replaceAll("[^0-9-]","")+"-";//过滤数字和"-"以外的字符，方便已"-1-" 判断1号是否为非工作日
						}
					}
				}
				yearArray[i]=mongthArray;
			}
			DataUtil.setHoliday(yearArray);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			System.err.println("节假日XML读取失败!");
		}
	}
	class OverdueMail implements Runnable{
		@Override
		public void run() {
			handelHoliday();
			while (true) {
				try {
					Thread.sleep(86400000);//一天发一次，一个用户已在工作日收到
					Calendar calendar=Calendar.getInstance();
					int day=calendar.get(Calendar.DAY_OF_WEEK)-2;//周日->周六   1->7 day：-1~5
					if(day>-1&&day<5){
						//周末不发邮件
						getDelayFlow(day);
					}
					if(calendar.get(Calendar.DAY_OF_MONTH)==calendar.getActualMaximum(Calendar.DAY_OF_MONTH)-2){
						//月底前三天提醒填考核
						if(!userManager.getMass_email()){
							flowManager.sendMail(147,20,null,"已经到月底了，上传下考核吧。",false);
						}else{
							StringBuilder stringBuilder=new StringBuilder();
							stringBuilder.append("各位同事：<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;已经到月底了，大家上传下考核吧。<br/>注：本邮件为群发邮件，若您无需填考核或已上传，请忽略。").append(address);
							sendMail(userManager.getPublic_email(), stringBuilder.toString());
						}
					}
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					System.out.println("Thread=>OverdueMail异常InterruptedException");
				}
			}
		}
	}
}
