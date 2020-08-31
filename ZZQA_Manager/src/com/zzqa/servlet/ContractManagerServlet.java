package com.zzqa.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import javax.print.attribute.HashAttributeSet;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.aspectj.weaver.tools.Trace;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.zzqa.pojo.customer_data.Customer_data;
import com.zzqa.pojo.device.Device;
import com.zzqa.pojo.file_path.File_path;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.leave.Leave;
import com.zzqa.pojo.linkman.Linkman;
import com.zzqa.pojo.manufacture.Manufacture;
import com.zzqa.pojo.material.Material;
import com.zzqa.pojo.operation.Operation;
import com.zzqa.pojo.outsource_product.Outsource_product;
import com.zzqa.pojo.procurement.Procurement;
import com.zzqa.pojo.product_info.Product_info;
import com.zzqa.pojo.product_procurement.Product_procurement;
import com.zzqa.pojo.project_procurement.Project_procurement;
import com.zzqa.pojo.purchase_contract.Purchase_contract;
import com.zzqa.pojo.purchase_note.Purchase_note;
import com.zzqa.pojo.resumption.Resumption;
import com.zzqa.pojo.sales_contract.Sales_contract;
import com.zzqa.pojo.shipments.Shipments;
import com.zzqa.pojo.shipping.Shipping;
import com.zzqa.pojo.shipping_list.Shipping_list;
import com.zzqa.pojo.task.Task;
import com.zzqa.pojo.task_conflict.Task_conflict;
import com.zzqa.pojo.track.Track;
import com.zzqa.pojo.travel.Travel;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.customer_data.Customer_dataManager;
import com.zzqa.service.interfaces.device.DeviceManager;
import com.zzqa.service.interfaces.file_path.File_pathManager;
import com.zzqa.service.interfaces.flow.FlowManager;
import com.zzqa.service.interfaces.leave.LeaveManager;
import com.zzqa.service.interfaces.linkman.LinkmanManager;
import com.zzqa.service.interfaces.manufacture.ManufactureManager;
import com.zzqa.service.interfaces.material.MaterialManager;
import com.zzqa.service.interfaces.operation.OperationManager;
import com.zzqa.service.interfaces.outsource_product.Outsource_productManager;
import com.zzqa.service.interfaces.position_user.Position_userManager;
import com.zzqa.service.interfaces.procurement.ProcurementManager;
import com.zzqa.service.interfaces.product_info.Product_infoManager;
import com.zzqa.service.interfaces.product_procurement.Product_procurementManager;
import com.zzqa.service.interfaces.project_procurement.Project_procurementManager;
import com.zzqa.service.interfaces.purchase_contract.Purchase_contractManager;
import com.zzqa.service.interfaces.purchase_note.Purchase_noteManager;
import com.zzqa.service.interfaces.resumption.ResumptionManager;
import com.zzqa.service.interfaces.sales_contract.Sales_contractManager;
import com.zzqa.service.interfaces.shipments.ShipmentsManager;
import com.zzqa.service.interfaces.shipping.ShippingManager;
import com.zzqa.service.interfaces.task.TaskManager;
import com.zzqa.service.interfaces.task_conflict.Task_conflictManager;
import com.zzqa.service.interfaces.track.TrackManager;
import com.zzqa.service.interfaces.travel.TravelManager;
import com.zzqa.service.interfaces.user.UserManager;
import com.zzqa.util.DataUtil;
import com.zzqa.util.FileUploadUtil;
import com.zzqa.util.FormTransform;
/***
 * 合同相关
 * @author Administrator
 *
 */
public class ContractManagerServlet extends HttpServlet {
	private Sales_contractManager sales_contractManager;
	private Product_infoManager product_infoManager;
	private Purchase_contractManager purchase_contractManager;
	private Purchase_noteManager purchase_noteManager;
	private Customer_dataManager customer_dataManager;
	private File_pathManager file_pathManager;
	private FlowManager flowManager;
	private OperationManager operationManager;
	private Position_userManager position_userManager;
	private UserManager userManager;
	private ShippingManager shippingManager;
	private static final ReadWriteLock lock11 = new ReentrantReadWriteLock(false);
	private static final ReadWriteLock lock12 = new ReentrantReadWriteLock(false);
	private static final ReadWriteLock lock18 = new ReentrantReadWriteLock(false);
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String type = req.getParameter("type");
		HttpSession session=req.getSession();
		Object uidObject=session.getAttribute("uid");
		if(uidObject==null){
			resp.sendRedirect("login.jsp");
			return;
		}
		String sessionID=session.getId();
		int uid=((Integer)uidObject);
		String time_str=req.getParameter("file_time");
		long save_time=0l;
		if(time_str!=null){
			try {
				save_time=Long.parseLong(time_str);
			} catch (Exception e) {
				// TODO: handle exception
				save_time=0l;
			}
		}
		if("addsales".equals(type)){
			String project_name=req.getParameter("project_name");
			String sign_time=req.getParameter("sign_time");
			String contract_no=req.getParameter("contract_no");
			String saler=req.getParameter("saler");
			int payment_method=Integer.parseInt(req.getParameter("payment_method"));
			String payment_value=req.getParameter("payment_value");
			String shipping_method=req.getParameter("shipping_method");
			String expense_burden=req.getParameter("expense_burden");
			String delivery_points=req.getParameter("delivery_points");
			String inspect_time=req.getParameter("inspect_time");
			String service_promise=req.getParameter("service_promise");
			String company_name1=req.getParameter("company_name1");
			String company_name2=req.getParameter("company_name2");
			Customer_data customer_data=customer_dataManager.getCustomer_dataByCName(company_name2, 1);
			if(customer_data==null){
				req.getRequestDispatcher("/login.jsp").forward(req, resp);
				return;
			}
			String company_address1=req.getParameter("company_address1");
			String company_address2=req.getParameter("company_address2");
			String postal_code1=req.getParameter("postal_code1");
			String postal_code2=req.getParameter("postal_code2");
			String law_person1=req.getParameter("law_person1");
			String law_person2=req.getParameter("law_person2");
			String entrusted_agent1=req.getParameter("entrusted_agent1");
			String entrusted_agent2=req.getParameter("entrusted_agent2");
			String phone1=req.getParameter("phone1");
			String phone2=req.getParameter("phone2");
			String fax1=req.getParameter("fax1");
			String fax2=req.getParameter("fax2");
			String bank1=req.getParameter("bank1");
			String bank2=req.getParameter("bank2");
			String company_account1=req.getParameter("company_account1");
			String company_account2=req.getParameter("company_account2");
			String tariff_item1=req.getParameter("tariff_item1");
			String tariff_item2=req.getParameter("tariff_item2");
			long nowtime=System.currentTimeMillis();
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy/M/d");
			Sales_contract sales_contract=new Sales_contract();
			sales_contract.setProject_name(project_name);
			try {
				sales_contract.setSign_time(sdf.parse(sign_time).getTime());
			} catch (ParseException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
				sales_contract.setSign_time(nowtime);
			}
			sales_contract.setContract_no(contract_no);
			sales_contract.setSaler(saler);
			sales_contract.setPayment_method(payment_method);
			sales_contract.setPayment_value(payment_value);
			sales_contract.setShipping_method(shipping_method);
			sales_contract.setExpense_burden(expense_burden);
			sales_contract.setDelivery_points(delivery_points);
			sales_contract.setInspect_time(inspect_time);
			sales_contract.setService_promise(service_promise);
			sales_contract.setCompany_name1(company_name1);
			sales_contract.setCustomer_id(customer_data.getCustomer_id());
			sales_contract.setCompany_address1(company_address1);
			sales_contract.setCompany_address2(company_address2);
			sales_contract.setPostal_code1(postal_code1);
			sales_contract.setPostal_code2(postal_code2);
			sales_contract.setLaw_person1(law_person1);
			sales_contract.setLaw_person2(law_person2);
			sales_contract.setEntrusted_agent1(entrusted_agent1);
			sales_contract.setEntrusted_agent2(entrusted_agent2);
			sales_contract.setPhone1(phone1);
			sales_contract.setPhone2(phone2);
			sales_contract.setFax1(fax1);
			sales_contract.setFax2(fax2);
			sales_contract.setBank1(bank1);
			sales_contract.setBank2(bank2);
			sales_contract.setCompany_account1(company_account1);
			sales_contract.setCompany_account2(company_account2);
			sales_contract.setTariff_item1(tariff_item1);
			sales_contract.setTariff_item2(tariff_item2);
			sales_contract.setCreate_id(uid);
			sales_contract.setCreate_time(nowtime);
			sales_contract.setUpdate_time(nowtime);
			sales_contract.setContract_file("0".equals(req.getParameter("contract_file"))?0:1);
			sales_contractManager.insertSales_contract(sales_contract);
			int sales_id=sales_contractManager.getNewSalesIDByCreateID(uid);
			String product_infos=req.getParameter("product_infos");
			String[] productArray=product_infos.split("い");
			for (String product_str : productArray) {
				String[] product=product_str.split("の");
				Product_info product_info=new Product_info();
				product_info.setM_id(Integer.parseInt(product[0]));
				product_info.setNum(Integer.parseInt(product[1]));
				product_info.setSales_id(sales_id);
				product_info.setUnit_price_taxes(Double.parseDouble(product[2]));
				product_info.setPredict_costing_taxes(Double.parseDouble(product[3]));
				try {
					product_info.setDelivery_time(sdf.parse(product[4]).getTime());
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					product_info.setDelivery_time(nowtime);
				}
				product_info.setRemark(product[5]);
				product_info.setNum(Integer.parseInt(product[1]));
				product_infoManager.insertProduct_info(product_info);
			}
			Operation operation=new Operation();
			operation.setContent("添加销售合同id："+sales_id);
			operation.setUid(uid);
			operation.setCreate_time(nowtime);
			operationManager.insertOperation(operation);
			Flow flow=new Flow();
			flow.setCreate_time(nowtime);
			flow.setType(11);
			flow.setUid(uid);
			flow.setForeign_id(sales_id);
			if(sales_contract.getContract_file()==0){
				file_pathManager.saveFile(uid, sessionID, 11, sales_id, 1, 0, save_time);
			}
			flow.setOperation(1);
			flowManager.insertFlow(flow);
			session.setAttribute("sales_id", sales_id);
			resp.sendRedirect("flowmanager/salesflow_detail.jsp");
		}else if("sales".equals(type)){
			try {
				lock11.writeLock().lock();
				int sales_id=(Integer)session.getAttribute("sales_id");
				Sales_contract sales_contract=sales_contractManager.getSales_contractByID(sales_id);
				if(sales_contract==null){
					resp.sendRedirect("login.jsp");
					return;
				}
				int opera=Integer.parseInt(req.getParameter("operation"));
				Flow nowFlow=flowManager.getNewFlowByFID(11, sales_id);
				if(opera!=nowFlow.getOperation()){
					resp.sendRedirect("flowmanager/salesflow_detail.jsp");
					return;
				}
				int applyNum=sales_contractManager.getApplyNum(sales_contract);
				boolean hasFile=sales_contract.getContract_file()==0;
				boolean isagree="0".equals(req.getParameter("isagree"));
				String reason=req.getParameter("reason");
				long nowTime=System.currentTimeMillis();
				Flow flow=new Flow();
				flow.setType(11);
				flow.setCreate_time(nowTime);
				flow.setForeign_id(sales_id);
				flow.setUid(uid);
				Operation operation=new Operation();
				operation.setCreate_time(nowTime);
				operation.setUid(uid);
				boolean isFinish=false;
				if(opera==1){
					if(hasFile){
						if(isagree){
							operation.setContent("销售合同单id："+sales_id+"客户合同审批通过。<br/>理由："+reason);
							flow.setOperation(2);
							flow.setReason(reason);
						}else{
							operation.setContent("销售合同单id："+sales_id+"客户合同审批不予通过。<br/>理由："+reason);
							flow.setOperation(3);
							flow.setReason(reason);
						}
					}else{
						if(isagree){
							operation.setContent("销售合同单id："+sales_id+"商务审批通过。<br/>理由："+reason);
							flow.setOperation(4);
							flow.setReason(reason);
						}else{
							operation.setContent("销售合同单id："+sales_id+"商务审批不予通过。<br/>理由："+reason);
							flow.setOperation(5);
							flow.setReason(reason);
						}
					}
				}else if(opera==2){
					if(isagree){
						operation.setContent("销售合同单id："+sales_id+"商务审批通过。<br/>理由："+reason);
						flow.setOperation(4);
						flow.setReason(reason);
					}else{
						operation.setContent("销售合同单id："+sales_id+"商务审批不予通过。<br/>理由："+reason);
						flow.setOperation(5);
						flow.setReason(reason);
					}
				}else if(opera==3){
					if(isagree){
						operation.setContent("销售合同单id："+sales_id+"客户合同审批通过。<br/>理由："+reason);
						flow.setOperation(2);
						flow.setReason(reason);
					}else{
						resp.sendRedirect("flowmanager/salesflow_detail.jsp");
						return;
					}
				}else if(opera==4){
					if(isagree){
						operation.setContent("销售合同单id："+sales_id+"部门经理审批通过。<br/>理由："+reason);
						flow.setOperation(6);
						flow.setReason(reason);
						isFinish=applyNum==1;
					}else{
						operation.setContent("销售合同单id："+sales_id+"部门经理审批不予通过。<br/>理由："+reason);
						flow.setOperation(7);
						flow.setReason(reason);
					}
				}else if(opera==5){
					if(isagree){
						operation.setContent("销售合同单id："+sales_id+"部门经理审批通过。<br/>理由："+reason);
						flow.setOperation(4);
						flow.setReason(reason);
					}else{
						resp.sendRedirect("flowmanager/salesflow_detail.jsp");
						return;
					}
				}else if(opera==6){
					if(applyNum>1){
						if(isagree){
							operation.setContent("销售合同单id："+sales_id+"运营总监审批通过。<br/>理由："+reason);
							flow.setOperation(8);
							flow.setReason(reason);
							isFinish=applyNum==2;
						}else{
							operation.setContent("销售合同单id："+sales_id+"运营总监审批不予通过。<br/>理由："+reason);
							flow.setOperation(9);
							flow.setReason(reason);
						}
					}else{
						//结束
						operation.setContent("销售合同单id："+sales_id+"盖章通过。<br/>理由："+reason);
						flow.setOperation(12);
						flow.setReason(reason);
					}
				}else if(opera==7){
					if(isagree){
						operation.setContent("销售合同单id："+sales_id+"部门经理审批通过。<br/>理由："+reason);
						flow.setOperation(6);
						flow.setReason(reason);
						isFinish=applyNum==1;
					}else{
						resp.sendRedirect("flowmanager/salesflow_detail.jsp");
						return;
					}
				}else if(opera==8){
					if(applyNum>2){
						if(isagree){
							operation.setContent("销售合同单id："+sales_id+"总经理审批通过。<br/>理由："+reason);
							flow.setOperation(10);
							flow.setReason(reason);
							isFinish=true;
						}else{
							operation.setContent("销售合同单id："+sales_id+"总经理审批不予通过。<br/>理由："+reason);
							flow.setOperation(11);
							flow.setReason(reason);
						}
					}else{
						if(applyNum==2){
							operation.setContent("销售合同单id："+sales_id+"盖章通过。<br/>理由："+reason);
							flow.setOperation(12);
							flow.setReason(reason);
						}else{
							resp.sendRedirect("flowmanager/salesflow_detail.jsp");
							return;
						}
					}
				}else if(opera==9){
					if(isagree){
						operation.setContent("销售合同单id："+sales_id+"运营总监审批通过。<br/>理由："+reason);
						flow.setOperation(8);
						isFinish=applyNum==2;
						flow.setReason(reason);
					}else{
						resp.sendRedirect("flowmanager/salesflow_detail.jsp");
						return;
					}
				}else if(opera==10){
					operation.setContent("销售合同单id："+sales_id+"盖章通过。<br/>理由："+reason);
					flow.setOperation(12);
					flow.setReason(reason);
				}else if(opera==11){
					if(isagree){
						operation.setContent("销售合同单id："+sales_id+"总经理审批通过。<br/>理由："+reason);
						flow.setOperation(10);
						flow.setReason(reason);
						isFinish=true;
					}else{
						resp.sendRedirect("flowmanager/salesflow_detail.jsp");
						return;
					}
				}else{
					resp.sendRedirect("flowmanager/salesflow_detail.jsp");
					return;
				}
				flowManager.insertFlow(flow);
				if(isFinish){
					Flow flow13=flowManager.getFlowByOperation(11, sales_id, 13);
					if(flow13!=null){
						flow.setOperation(13);
						flow.setId(3);//标记 3：撤销成功
						flowManager.insertFlow(flow);
					}
				}
				operationManager.insertOperation(operation);
				resp.sendRedirect("flowmanager/salesflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("login.jsp");
			}finally{
				lock11.writeLock().unlock();
			}
		}else if("altersales".equals(type)){
			try {
				lock11.writeLock().lock();
				int sales_id=(Integer)session.getAttribute("sales_id");
				Sales_contract sales_contract=sales_contractManager.getSales_contractByID(sales_id);
				if(sales_contract==null){
					resp.sendRedirect("login.jsp");
					return;
				}
				int opera=Integer.parseInt(req.getParameter("operation"));
				Flow nowFlow=flowManager.getNewFlowByFID(11, sales_id);
				if(opera!=nowFlow.getOperation()){
					resp.sendRedirect("flowmanager/salesflow_detail.jsp");
					return;
				}
				String reason=req.getParameter("reason");
				boolean hasFile="0".equals(req.getParameter("contract_file"));
				int contract_file=sales_contract.getContract_file();
				long nowTime=System.currentTimeMillis();
				Flow flow=new Flow();
				flow.setCreate_time(nowTime);
				flow.setForeign_id(sales_id);
				flow.setUid(uid);
				flow.setType(11);
				Operation operation=new Operation();
				operation.setUid(uid);
				operation.setCreate_time(nowTime);
				String changeFile=req.getParameter("changeFile");
				if(changeFile.length()>0){
					//修改过客户合同
					if("0".equals(changeFile)){
						//添加客户合同，未删除原客户合同
					}else if("-1".equals(changeFile)){
						//将之前已上传的客户合同保存到记录中
						List<File_path> file_paths=file_pathManager.getAllFileByCondition(11,sales_id, 1, 0);
						int op=-1;//未审批过
						if(opera==3){
							op=flowManager.getFlowByOperation(11, sales_id, 3).getId();
						}else if(opera>3||opera==2){
							op=flowManager.getFlowByOperation(11, sales_id, 2).getId();
						}else{
							flow.setReason("未审批的客户合同");
							flow.setOperation(-1);
							flowManager.insertFlow2(flow);
							op=flowManager.getFlowByOperation(11, sales_id,-1).getId();
						}
						for (File_path file_path : file_paths) {
							file_path.setForeign_id(op);
							file_path.setState(1);
							file_path.setCreate_time(nowTime);
							file_pathManager.insertFile(file_path);
							file_pathManager.delFileByID(file_path.getId());
						}
					}else{
						String[] fileIDArray=changeFile.split("の");
						int op=-1;//未审批过
						if(opera==3){
							op=flowManager.getFlowByOperation(11, sales_id, 3).getId();
						}else if(opera>3||opera==2){
							op=flowManager.getFlowByOperation(11, sales_id, 2).getId();
						}else{
							flow.setReason("未审批的客户合同");
							flow.setOperation(-1);
							flowManager.insertFlow2(flow);
							op=flowManager.getFlowByOperation(11, sales_id,-1).getId();
						}
						for (String fileID : fileIDArray) {
							File_path file_path=file_pathManager.getFileByID(Integer.parseInt(fileID));
							operation.setContent("删除客户合同，合同名："+file_path.getFile_name());
							operationManager.insertOperation(operation);
							file_path.setForeign_id(op);
							file_path.setState(1);
							file_path.setCreate_time(nowTime);
							file_pathManager.insertFile(file_path);
							file_pathManager.delFileByID(file_path.getId());
						}
					}
					if(hasFile){
						//上传客户合同
						file_pathManager.saveFile(uid, sessionID, 11, sales_id, 1, 0, save_time);
					}
					flow.setReason(reason);
					flow.setOperation(0);
					flowManager.insertFlow2(flow);
					flow.setOperation(1);
				}else{
					flow.setReason(reason);
					flow.setOperation(0);
					flowManager.insertFlow2(flow);
					//返回最近一个初始步骤，若最近修改后客户合同审批通过，返回到合同审批后，否则回到第一步
					Flow flow1=flowManager.getFlowByOperation(11, sales_id, 1);
					Flow flow2=flowManager.getFlowByOperation(11, sales_id, 2);
					if(contract_file==0&&flow2!=null&&flow1!=null&&flow1.getCreate_time()<flow2.getCreate_time()){
						flow.setOperation(2);
					}else{
						flow.setOperation(1);
					}
				}
				String project_name=req.getParameter("project_name");
				String sign_time=req.getParameter("sign_time");
				String contract_no=req.getParameter("contract_no");
				String saler=req.getParameter("saler");
				int payment_method=Integer.parseInt(req.getParameter("payment_method"));
				String payment_value=req.getParameter("payment_value");
				String shipping_method=req.getParameter("shipping_method");
				String expense_burden=req.getParameter("expense_burden");
				String delivery_points=req.getParameter("delivery_points");
				String inspect_time=req.getParameter("inspect_time");
				
				String service_promise=req.getParameter("service_promise");
				String company_name1=req.getParameter("company_name1");
				String company_name2=req.getParameter("company_name2");
				Customer_data customer_data=customer_dataManager.getCustomer_dataByCName(company_name2, 1);
				if(customer_data==null){
					req.getRequestDispatcher("/login.jsp").forward(req, resp);
					return;
				}
				String company_address1=req.getParameter("company_address1");
				String company_address2=req.getParameter("company_address2");
				String postal_code1=req.getParameter("postal_code1");
				String postal_code2=req.getParameter("postal_code2");
				String law_person1=req.getParameter("law_person1");
				String law_person2=req.getParameter("law_person2");
				String entrusted_agent1=req.getParameter("entrusted_agent1");
				String entrusted_agent2=req.getParameter("entrusted_agent2");
				String phone1=req.getParameter("phone1");
				String phone2=req.getParameter("phone2");
				String fax1=req.getParameter("fax1");
				String fax2=req.getParameter("fax2");
				String bank1=req.getParameter("bank1");
				String bank2=req.getParameter("bank2");
				String company_account1=req.getParameter("company_account1");
				String company_account2=req.getParameter("company_account2");
				String tariff_item1=req.getParameter("tariff_item1");
				String tariff_item2=req.getParameter("tariff_item2");
				long nowtime=System.currentTimeMillis();
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy/M/d");
				sales_contract.setProject_name(project_name);
				try {
					sales_contract.setSign_time(sdf.parse(sign_time).getTime());
				} catch (ParseException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
					sales_contract.setSign_time(nowtime);
				}
				sales_contract.setContract_no(contract_no);
				sales_contract.setSaler(saler);
				sales_contract.setPayment_method(payment_method);
				sales_contract.setPayment_value(payment_value);
				sales_contract.setShipping_method(shipping_method);
				sales_contract.setExpense_burden(expense_burden);
				sales_contract.setDelivery_points(delivery_points);
				sales_contract.setInspect_time(inspect_time);
				sales_contract.setService_promise(service_promise);
				sales_contract.setCompany_name1(company_name1);
				sales_contract.setCustomer_id(customer_data.getCustomer_id());
				sales_contract.setCompany_address1(company_address1);
				sales_contract.setCompany_address2(company_address2);
				sales_contract.setPostal_code1(postal_code1);
				sales_contract.setPostal_code2(postal_code2);
				sales_contract.setLaw_person1(law_person1);
				sales_contract.setLaw_person2(law_person2);
				sales_contract.setEntrusted_agent1(entrusted_agent1);
				sales_contract.setEntrusted_agent2(entrusted_agent2);
				sales_contract.setPhone1(phone1);
				sales_contract.setPhone2(phone2);
				sales_contract.setFax1(fax1);
				sales_contract.setFax2(fax2);
				sales_contract.setBank1(bank1);
				sales_contract.setBank2(bank2);
				sales_contract.setCompany_account1(company_account1);
				sales_contract.setCompany_account2(company_account2);
				sales_contract.setTariff_item1(tariff_item1);
				sales_contract.setTariff_item2(tariff_item2);
				sales_contract.setCreate_id(uid);
				sales_contract.setCreate_time(nowtime);
				sales_contract.setUpdate_time(nowtime);
				sales_contract.setContract_file("0".equals(req.getParameter("contract_file"))?0:1);
				String product_infos=req.getParameter("product_infos");
				String[] productArray=product_infos.split("い");
				List<Product_info> proList=product_infoManager.getProduct_infos(sales_id);
				Set<Integer> productIDSet=new HashSet<Integer>();
				for (String product_str : productArray) {
					String[] product=product_str.split("の");
					Product_info product_info=new Product_info();
					if(product.length==7){//已有的只修改信息，不改变id
						int product_id=Integer.valueOf(product[6]);
						productIDSet.add(Integer.valueOf(product_id));
						product_info=product_infoManager.getProduct_infoByID(product_id);
						if(product_info==null){
							continue;
						}
						product_info.setM_id(Integer.parseInt(product[0]));
						product_info.setNum(Integer.parseInt(product[1]));
						product_info.setSales_id(sales_id);
						product_info.setUnit_price_taxes(Double.parseDouble(product[2]));
						product_info.setPredict_costing_taxes(Double.parseDouble(product[3]));
						try {
							product_info.setDelivery_time(sdf.parse(product[4]).getTime());
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
							product_info.setDelivery_time(nowtime);
						}
						product_info.setRemark(product[5]);
						product_infoManager.updateProduct_info(product_info);
					}else{
						product_info.setM_id(Integer.parseInt(product[0]));
						product_info.setNum(Integer.parseInt(product[1]));
						product_info.setSales_id(sales_id);
						product_info.setUnit_price_taxes(Double.parseDouble(product[2]));
						product_info.setPredict_costing_taxes(Double.parseDouble(product[3]));
						try {
							product_info.setDelivery_time(sdf.parse(product[4]).getTime());
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
							product_info.setDelivery_time(nowtime);
						}
						product_info.setRemark(product[5]);
						product_infoManager.insertProduct_info(product_info);
					}
				}
				//删除未被保留的产品
				for (Product_info product_info:proList) {
					if(!productIDSet.contains(Integer.valueOf(product_info.getId()))){
						product_infoManager.delProduct_infoByID(product_info.getId());
					}
				}
				flow.setReason(null);
				flowManager.insertFlow2(flow);
				sales_contract.setContract_file(hasFile?0:1);
				sales_contract.setUpdate_time(nowTime);
				sales_contractManager.updateSales_contract(sales_contract);
				operation.setContent("修改销售合同id："+sales_id);
				operationManager.insertOperation(operation);
				resp.sendRedirect("flowmanager/salesflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("login.jsp");
			}finally{
				lock11.writeLock().unlock();
			}
			
		}else if("getCustomerByCName".equals(type)){
			String company_name=req.getParameter("company_name");
			int customer_type=Integer.parseInt(req.getParameter("customer_type"));
			Customer_data customer_data=customer_dataManager.getCustomer_dataByCName(company_name, customer_type);
			JSONObject jsonObject=JSONObject.fromObject(customer_data);
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma", "no-cache");
			resp.setHeader("cache-control", "no-cache");
			PrintWriter out = resp.getWriter();
			out.print(jsonObject);
			out.flush();
		}else if("deleteSales".equals(type)){
			try {
				lock11.writeLock().lock();
				int sales_id=(Integer)session.getAttribute("sales_id");
				Sales_contract sales_contract=sales_contractManager.getSales_contractByID(sales_id);
				if(sales_contract==null){
					resp.sendRedirect("login.jsp");
					return;
				}
				int opera=Integer.parseInt(req.getParameter("operation"));
				Flow nowFlow=flowManager.getNewFlowByFID(11, sales_id);
				if(opera!=nowFlow.getOperation()){
					resp.sendRedirect("flowmanager/salesflow_detail.jsp");
					return;
				}
				long nowTime=System.currentTimeMillis();
				Flow flow=new Flow();
				flow.setCreate_time(nowTime);
				flow.setForeign_id(sales_id);
				flow.setUid(uid);
				flow.setType(11);
				Operation operation=new Operation();
				operation.setUid(uid);
				operation.setCreate_time(nowTime);
				operation.setContent("撤销销售合同单id："+sales_id);
				operationManager.insertOperation(operation);
				String reason=req.getParameter("reason");
				flow.setReason(reason);
				int applyNum=sales_contractManager.getApplyNum(sales_contract);
				if(opera==12||(opera==6&&applyNum==1)||(opera==8&&applyNum==2)||(opera==10&&applyNum==3)){
					//已完成的
					flow.setOperation(13);
					flow.setId(1);//标记 1：审批结束后撤销
					flowManager.insertFlow(flow);
					if(sales_contract.getContract_file()==0){
						flow.setOperation(2);
					}else{
						flow.setOperation(1);
					}
					flow.setReason(null);
					flowManager.insertFlow(flow);
				}else{
					//未审批完之前撤销，可直接撤销，通知相关人员
					flow.setId(2);//标记 2：未审批完之前撤销
					flow.setOperation(13);
					flowManager.insertFlow(flow);
				}
				sales_contract.setUpdate_time(nowTime);
				sales_contractManager.updateSales_contract(sales_contract);
				resp.sendRedirect("flowmanager/salesflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("login.jsp");
			}
			finally{
				lock11.writeLock().unlock();
			}
		}else if("delProductOnSales".equals(type)){
			int sales_id=(Integer)session.getAttribute("sales_id");
			int product_id=Integer.parseInt(req.getParameter("product_id"));
			int flag=0;//0:未被采购合同绑定，可删除
			if(purchase_noteManager.checkProductInPurchase(product_id)){
				//采购合同绑定该产品（撤销的采购合同也无法删除）
				flag=1;
			}
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma", "no-cache");
			resp.setHeader("cache-control", "no-cache");
			PrintWriter out = resp.getWriter();
			out.print(flag);
			out.flush();
		}else if("addpurchase".equals(type)){
			int purchase_type=Integer.parseInt(req.getParameter("purchase_type"));
			String data=req.getParameter("data");
			Purchase_contract purchase_contract=new Purchase_contract();
			long nowTime=System.currentTimeMillis();
			purchase_contract.setType(purchase_type);
			purchase_contract.setCreate_id(uid);
			purchase_contract.setUpdate_time(nowTime);
			purchase_contract.setCreate_time(nowTime);
			String supplier=req.getParameter("supplier");
			Customer_data customer_data=customer_dataManager.getCustomer_dataByCName(supplier, 2);
			if(customer_data==null){
				resp.sendRedirect("login.jsp");
				return;
			}
			purchase_contract.setSupplier(customer_data.getCustomer_id());
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy/M/d");
			try {
				purchase_contract.setSign_time(sdf.parse(req.getParameter("sign_time")).getTime());
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				purchase_contract.setSign_time(nowTime);
			}
			purchase_contract.setContract_no(req.getParameter("contract_no"));
			purchase_contract.setMoxa(Integer.parseInt(req.getParameter("moxa")));
			purchase_contract.setPayment_value(req.getParameter("payment_value"));
			purchase_contract.setAog_time_address(req.getParameter("aog_time_address"));
			purchase_contract.setLinkman(req.getParameter("linkman"));
			purchase_contract.setCheckout_time(Integer.parseInt(req.getParameter("checkout_time")));
			purchase_contract.setCompany_name1(req.getParameter("company_name1"));
			purchase_contract.setCompany_address1(req.getParameter("company_address1"));
			purchase_contract.setCompany_address2(req.getParameter("company_address2"));
			purchase_contract.setPostal_code1(req.getParameter("postal_code1"));
			purchase_contract.setPostal_code2(req.getParameter("postal_code2"));
			purchase_contract.setLaw_person1(req.getParameter("law_person1"));
			purchase_contract.setLaw_person2(req.getParameter("law_person2"));
			purchase_contract.setEntrusted_agent1(req.getParameter("entrusted_agent1"));
			purchase_contract.setEntrusted_agent2(req.getParameter("entrusted_agent2"));
			purchase_contract.setPhone1(req.getParameter("phone1"));
			purchase_contract.setPhone2(req.getParameter("phone2"));
			purchase_contract.setFax1(req.getParameter("fax1"));
			purchase_contract.setFax2(req.getParameter("fax2"));
			purchase_contract.setBank1(req.getParameter("bank1"));
			purchase_contract.setBank2(req.getParameter("bank2"));
			purchase_contract.setCompany_account1(req.getParameter("company_account1"));
			purchase_contract.setCompany_account2(req.getParameter("company_account2"));
			purchase_contract.setTariff_item1(req.getParameter("tariff_item1"));
			purchase_contract.setTariff_item2(req.getParameter("tariff_item2"));
			int id=purchase_contractManager.insertPurchase_contract(purchase_contract);
			if(id==0){
				resp.sendRedirect("login.jsp");
				return;
			}
			if(purchase_type==1){
				String[] productArray=data.split("い");
				for (String product : productArray) {
					String[] array=product.split("の");
					int product_id=Integer.parseInt(array[0]);
					Purchase_note purchase_note=new Purchase_note();
					purchase_note.setProduct_id(product_id);
					purchase_note.setSales_id(Integer.parseInt(array[1]));
					if(product_id==0){
						purchase_note.setM_id(Integer.parseInt(array[2]));
						purchase_note.setPredict_costing_taxes(Double.parseDouble(array[4]));
					}
					purchase_note.setNum(Integer.parseInt(array[3]));
					purchase_note.setPurchase_id(id);
					purchase_note.setUnit_price_taxes(Double.parseDouble(array[5]));
					try {
						purchase_note.setDelivery_time(sdf.parse(array[6]).getTime());
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
						purchase_note.setDelivery_time(nowTime);
					}
					purchase_note.setRemark(array[7]);
					purchase_noteManager.insertNote(purchase_note);
				}
			}else{
				String[] productArray=data.split("い");
				for (String product : productArray) {
					String[] array=product.split("の");
					Purchase_note purchase_note=new Purchase_note();
					purchase_note.setProduct_id(0);
					purchase_note.setSales_id(0);
					purchase_note.setM_id(Integer.parseInt(array[0]));
					purchase_note.setNum(Integer.parseInt(array[1]));
					purchase_note.setPredict_costing_taxes(Double.parseDouble(array[2]));
					purchase_note.setUnit_price_taxes(Double.parseDouble(array[3]));
					purchase_note.setPurchase_id(id);
					try {
						purchase_note.setDelivery_time(sdf.parse(array[4]).getTime());
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
						purchase_note.setDelivery_time(nowTime);
					}
					purchase_note.setRemark(array[5]);
					purchase_noteManager.insertNote(purchase_note);
				}
			}
			Flow flow=new Flow();
			flow.setCreate_time(nowTime);
			flow.setForeign_id(id);
			flow.setOperation(1);
			flow.setType(12);
			flow.setUid(uid);
			flowManager.insertFlow(flow);
			Operation operation=new Operation();
			operation.setContent("创建采购合同，id:"+id);
			operation.setCreate_time(nowTime);
			operation.setUid(uid);
			operationManager.insertOperation(operation);
			session.setAttribute("purchase_id", id);
			resp.sendRedirect("flowmanager/purchaseflow_detail.jsp");
		}else if("getNeedPurchaseProducts".equals(type)){
			String supplier=req.getParameter("supplier");
			List<Sales_contract> salesList=sales_contractManager.getNeedPurchaseProducts();
			JSONArray jsonArray=JSONArray.fromObject(salesList);
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma", "no-cache");
			resp.setHeader("cache-control", "no-cache");
			PrintWriter out = resp.getWriter();
			out.print(jsonArray);
			out.flush();
		}else if("purchase".equals(type)){
			try {
				lock12.writeLock().lock();
				int purchase_id=(Integer)session.getAttribute("purchase_id");
				Purchase_contract purchase_contract=purchase_contractManager.getPurchase_contractByID(purchase_id);
				if(purchase_contract==null){
					resp.sendRedirect("login.jsp");
					return;
				}
				int opera=Integer.parseInt(req.getParameter("operation"));
				Flow nowFlow=flowManager.getNewFlowByFID(12, purchase_id);
				if(opera!=nowFlow.getOperation()){
					resp.sendRedirect("flowmanager/purchaseflow_detail.jsp");
					return;
				}
				long nowTime=System.currentTimeMillis();
				Flow flow=new Flow();
				flow.setForeign_id(purchase_id);
				flow.setUid(uid);
				flow.setCreate_time(nowTime);
				flow.setType(12);
				Operation operation=new Operation();
				operation.setCreate_time(nowTime);
				operation.setUid(uid);
				boolean isFinished=false;
				int applyNum=purchase_contractManager.getPurchaseApplyNum(purchase_contract);
				if((opera==4&&applyNum==2)||(opera==6&&applyNum==3)||(opera==8&&applyNum>3)){
					flow.setOperation(12);
					operation.setContent("采购合同id："+purchase_id+"确认采购。");
					flowManager.insertFlow(flow);
					operationManager.insertOperation(operation);	
				}else if(opera==1){
					boolean isagree="0".equals(req.getParameter("isagree"));
					String reason=req.getParameter("reason");
					if(isagree){
						flow.setOperation(2);
						operation.setContent("采购合同id："+purchase_id+"商务审批通过。<br/>理由："+reason);
					}else{
						flow.setOperation(3);
						operation.setContent("采购合同id："+purchase_id+"商务审批不予通过。<br/>理由："+reason);
					}
					flow.setReason(reason);
					flowManager.insertFlow(flow);
					operationManager.insertOperation(operation);
				}else if(opera==2){
					boolean isagree="0".equals(req.getParameter("isagree"));
					String reason=req.getParameter("reason");
					if(isagree){
						flow.setOperation(4);
						isFinished=applyNum==2;
						operation.setContent("采购合同id："+purchase_id+"部门经理审批通过。<br/>理由："+reason);
					}else{
						flow.setOperation(5);
						operation.setContent("采购合同id："+purchase_id+"部门经理审批不予通过。<br/>理由："+reason);
					}
					flow.setReason(reason);
					flowManager.insertFlow(flow);
					operationManager.insertOperation(operation);
				}else if(opera==3){
					boolean isagree="0".equals(req.getParameter("isagree"));
					String reason=req.getParameter("reason");
					if(isagree){
						flow.setOperation(2);
						operation.setContent("采购合同id："+purchase_id+"商务审批通过。<br/>理由："+reason);
					}else{
						resp.sendRedirect("login.jsp");
						return;
					}
					flow.setReason(reason);
					flowManager.insertFlow(flow);
					operationManager.insertOperation(operation);
				}else if(opera==4){
					if(applyNum>2){
						boolean isagree="0".equals(req.getParameter("isagree"));
						String reason=req.getParameter("reason");
						if(isagree){
							flow.setOperation(6);
							operation.setContent("采购合同id："+purchase_id+"运营总监审批通过。<br/>理由："+reason);
							isFinished=applyNum==3;
						}else{
							flow.setOperation(7);
							operation.setContent("采购合同id："+purchase_id+"运营总监审批不予通过。<br/>理由："+reason);
						}
						flow.setReason(reason);
						flowManager.insertFlow(flow);
						operationManager.insertOperation(operation);
					}else{
						resp.sendRedirect("login.jsp");
						return;
					}
				}else if(opera==5){
					boolean isagree="0".equals(req.getParameter("isagree"));
					String reason=req.getParameter("reason");
					if(isagree){
						flow.setOperation(4);
						isFinished=applyNum==2;
						operation.setContent("采购合同id："+purchase_id+"部门经理审批通过。<br/>理由："+reason);
					}else{
						resp.sendRedirect("login.jsp");
						return;
					}
					flow.setReason(reason);
					flowManager.insertFlow(flow);
					operationManager.insertOperation(operation);
				}else if(opera==6){
					if(applyNum>3){
						boolean isagree="0".equals(req.getParameter("isagree"));
						String reason=req.getParameter("reason");
						if(isagree){
							flow.setOperation(8);
							operation.setContent("采购合同id："+purchase_id+"总经理审批通过。<br/>理由："+reason);
							isFinished=true;
						}else{
							flow.setOperation(9);
							operation.setContent("采购合同id："+purchase_id+"总经理审批不予通过。<br/>理由："+reason);
						}
						flow.setReason(reason);
						flowManager.insertFlow(flow);
						operationManager.insertOperation(operation);
					}else{
						resp.sendRedirect("login.jsp");
						return;
					}
				}else if(opera==7){
					boolean isagree="0".equals(req.getParameter("isagree"));
					String reason=req.getParameter("reason");
					if(isagree){
						flow.setOperation(6);
						isFinished=applyNum==3;
						operation.setContent("采购合同id："+purchase_id+"运营总监审批通过。<br/>理由："+reason);
					}else{
						resp.sendRedirect("login.jsp");
						return;
					}
					flow.setReason(reason);
					flowManager.insertFlow(flow);
					operationManager.insertOperation(operation);
				}else if(opera==9){
					boolean isagree="0".equals(req.getParameter("isagree"));
					String reason=req.getParameter("reason");
					if(isagree){
						flow.setOperation(8);
						isFinished=true;
						operation.setContent("采购合同id："+purchase_id+"总经理审批通过。<br/>理由："+reason);
					}else{
						resp.sendRedirect("login.jsp");
						return;
					}
					flow.setReason(reason);
					flowManager.insertFlow(flow);
					operationManager.insertOperation(operation);
				}else if(opera==12){
					String[] productArray=req.getParameter("aogInfos").split("い");
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd");
					for (String product : productArray) {
						//pidのaog_dateのhasbuy_num
						String[] noteArray=product.split("の");
						Purchase_note note=purchase_noteManager.getNoteByID(Integer.parseInt(noteArray[0]));
						note.setAog_time(Long.parseLong(noteArray[1]));
						note.setAog_num(Integer.parseInt(noteArray[2]));
						purchase_noteManager.updateNote(note);
					}
					boolean isagree="0".equals(req.getParameter("isagree"));
					if(isagree){
						//采购完成
						flow.setOperation(13);
						operation.setContent("采购合同id："+purchase_id+"采购完成。");
						flowManager.insertFlow(flow);
						operationManager.insertOperation(operation);
					}else{
						operation.setContent("采购合同id："+purchase_id+"更新采购信息。");
						operationManager.insertOperation(operation);
						resp.getOutputStream().print(0);//更新到货信息成功
						return;
					}
				}else if(opera==13){
					flow.setOperation(10);
					operation.setContent("采购合同id："+purchase_id+"确认入库。");
					flowManager.insertFlow(flow);
					operationManager.insertOperation(operation);
				}else{
					resp.sendRedirect("login.jsp");
					return;
				}
				if(isFinished){
					//审批完成
					Flow flow11=flowManager.getFlowByOperation(12, purchase_id, 11);
					if(flow11!=null){
						flow.setOperation(11);
						flow.setId(3);//标记 3：撤销成功
						flowManager.insertFlow(flow);
					}
					//重置已采购数量
					purchase_noteManager.reSetHasBuyNum(purchase_id);
				}
				purchase_contract.setUpdate_time(nowTime);
				purchase_contractManager.updatePurchase_contract(purchase_contract);
				session.setAttribute("purchase_id", purchase_id);
				resp.sendRedirect("flowmanager/purchaseflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("login.jsp");
				return;
			}finally{
				lock12.writeLock().unlock();
			}
		}else if("alterPurchase".equals(type)){
			try {
				lock12.writeLock().lock();
				int purchase_id=(Integer)session.getAttribute("purchase_id");
				Purchase_contract purchase_contract=purchase_contractManager.getPurchase_contractByID(purchase_id);
				if(purchase_contract==null){
					resp.sendRedirect("login.jsp");
					return;
				}
				int opera=Integer.parseInt(req.getParameter("operation"));
				Flow nowFlow=flowManager.getNewFlowByFID(12, purchase_id);
				if(opera!=nowFlow.getOperation()){
					resp.sendRedirect("flowmanager/purchaseflow_detail.jsp");
					return;
				}
				String data=req.getParameter("data");
				long nowTime=System.currentTimeMillis();
				purchase_contract.setCreate_id(uid);
				purchase_contract.setUpdate_time(nowTime);
				purchase_contract.setCreate_time(nowTime);
				String supplier=req.getParameter("supplier");
				Customer_data customer_data=customer_dataManager.getCustomer_dataByCName(supplier, 2);
				if(customer_data==null){
					resp.sendRedirect("login.jsp");
					return;
				}
				purchase_contract.setSupplier(customer_data.getCustomer_id());
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy/M/d");
				try {
					purchase_contract.setSign_time(sdf.parse(req.getParameter("sign_time")).getTime());
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					purchase_contract.setSign_time(nowTime);
				}
				purchase_contract.setContract_no(req.getParameter("contract_no"));
				purchase_contract.setMoxa(Integer.parseInt(req.getParameter("moxa")));
				purchase_contract.setPayment_value(req.getParameter("payment_value"));
				purchase_contract.setAog_time_address(req.getParameter("aog_time_address"));
				purchase_contract.setLinkman(req.getParameter("linkman"));
				purchase_contract.setCheckout_time(Integer.parseInt(req.getParameter("checkout_time")));
				purchase_contract.setCompany_name1(req.getParameter("company_name1"));
				purchase_contract.setCompany_address1(req.getParameter("company_address1"));
				purchase_contract.setCompany_address2(req.getParameter("company_address2"));
				purchase_contract.setPostal_code1(req.getParameter("postal_code1"));
				purchase_contract.setPostal_code2(req.getParameter("postal_code2"));
				purchase_contract.setLaw_person1(req.getParameter("law_person1"));
				purchase_contract.setLaw_person2(req.getParameter("law_person2"));
				purchase_contract.setEntrusted_agent1(req.getParameter("entrusted_agent1"));
				purchase_contract.setEntrusted_agent2(req.getParameter("entrusted_agent2"));
				purchase_contract.setPhone1(req.getParameter("phone1"));
				purchase_contract.setPhone2(req.getParameter("phone2"));
				purchase_contract.setFax1(req.getParameter("fax1"));
				purchase_contract.setFax2(req.getParameter("fax2"));
				purchase_contract.setBank1(req.getParameter("bank1"));
				purchase_contract.setBank2(req.getParameter("bank2"));
				purchase_contract.setCompany_account1(req.getParameter("company_account1"));
				purchase_contract.setCompany_account2(req.getParameter("company_account2"));
				purchase_contract.setTariff_item1(req.getParameter("tariff_item1"));
				purchase_contract.setTariff_item2(req.getParameter("tariff_item2"));
				purchase_contractManager.updatePurchase_contract(purchase_contract);
				List<Integer> noteIDs=purchase_noteManager.getPurchase_noteIDsByPID(purchase_id);
				int applyNum=purchase_contractManager.getPurchaseApplyNum(purchase_contract);
				boolean applyFinished=opera==10||opera==12||opera==13||(applyNum==2&&opera==4)||(applyNum==3&&opera==6)||(applyNum>3&&opera==8);
				if(purchase_contract.getType()==1){
					//note_idのproduct_idのsales_idのm_idの数量の预计含税成本の含税单价の交货期の备注
					String[] productArray=data.split("い");
					for (String product : productArray) {
						String[] array=product.split("の");
						int note_id=Integer.parseInt(array[0]);
						Purchase_note purchase_note=null;
						if(note_id>0){
							purchase_note=purchase_noteManager.getNoteByID(note_id);
							if(applyFinished){	
								purchase_note.setHasbuy_num(purchase_note.getNum());
							}
							noteIDs.remove(new Integer(note_id));
						}else{
							purchase_note=new Purchase_note();
						}
						int product_id=Integer.parseInt(array[1]);
						purchase_note.setProduct_id(product_id);
						purchase_note.setSales_id(Integer.parseInt(array[2]));
						if(product_id==0){
							purchase_note.setM_id(Integer.parseInt(array[3]));
							purchase_note.setPredict_costing_taxes(Double.parseDouble(array[5]));
						}
						purchase_note.setNum(Integer.parseInt(array[4]));
						purchase_note.setPurchase_id(purchase_id);
						purchase_note.setUnit_price_taxes(Double.parseDouble(array[6]));
						try {
							purchase_note.setDelivery_time(sdf.parse(array[7]).getTime());
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
							purchase_note.setDelivery_time(nowTime);
						}
						purchase_note.setRemark(array[8]);
						if(note_id>0){
							purchase_noteManager.updateNote(purchase_note);
						}else{
							purchase_noteManager.insertNote(purchase_note);
						}
					}
				}else{
					//note_idのm_idの数量の预计含税成本の含税单价の交货期の备注
					String[] productArray=data.split("い");
					for (String product : productArray) {
						String[] array=product.split("の");
						int note_id=Integer.parseInt(array[0]);
						Purchase_note purchase_note=null;
						if(note_id>0){
							purchase_note=purchase_noteManager.getNoteByID(note_id);
							if(applyFinished){	
								purchase_note.setHasbuy_num(purchase_note.getNum());
							}
							noteIDs.remove(new Integer(note_id));
						}else{
							purchase_note=new Purchase_note();
						}
						purchase_note.setProduct_id(0);
						purchase_note.setSales_id(0);
						purchase_note.setM_id(Integer.parseInt(array[1]));
						purchase_note.setNum(Integer.parseInt(array[2]));
						purchase_note.setPredict_costing_taxes(Double.parseDouble(array[3]));
						purchase_note.setUnit_price_taxes(Double.parseDouble(array[4]));
						purchase_note.setPurchase_id(purchase_id);
						try {
							purchase_note.setDelivery_time(sdf.parse(array[5]).getTime());
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
							purchase_note.setDelivery_time(nowTime);
						}
						purchase_note.setRemark(array[6]);
						if(note_id>0){
							purchase_noteManager.updateNote(purchase_note);
						}else{
							purchase_noteManager.insertNote(purchase_note);
						}
					}
				}
				for (Integer note_id : noteIDs) {
					purchase_noteManager.delNoteByID(note_id);
				}
				String reason=req.getParameter("reason");
				Flow flow=new Flow();
				flow.setCreate_time(nowTime);
				flow.setForeign_id(purchase_id);
				flow.setOperation(1);
				flow.setReason(reason);
				flow.setType(12);
				flow.setUid(uid);
				flowManager.insertFlow(flow);
				Operation operation=new Operation();
				operation.setContent("修改采购合同，id:"+purchase_id);
				operation.setCreate_time(nowTime);
				operation.setUid(uid);
				operationManager.insertOperation(operation);
				session.setAttribute("purchase_id", purchase_id);
				resp.sendRedirect("flowmanager/purchaseflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
			}finally{
				lock12.writeLock().unlock();
			}
		}else if("deletePurchase".equals(type)){
			try {
				lock12.writeLock().lock();
				int purchase_id=(Integer)session.getAttribute("purchase_id");
				Purchase_contract purchase_contract=purchase_contractManager.getPurchase_contractByID(purchase_id);
				if(purchase_contract==null){
					resp.sendRedirect("login.jsp");
					return;
				}
				int opera=Integer.parseInt(req.getParameter("operation"));
				Flow nowFlow=flowManager.getNewFlowByFID(12, purchase_id);
				if(opera!=nowFlow.getOperation()){
					resp.sendRedirect("flowmanager/salesflow_detail.jsp");
					return;
				}
				long nowTime=System.currentTimeMillis();
				Flow flow=new Flow();
				flow.setCreate_time(nowTime);
				flow.setForeign_id(purchase_id);
				flow.setUid(uid);
				flow.setType(12);
				Operation operation=new Operation();
				operation.setUid(uid);
				operation.setCreate_time(nowTime);
				operation.setContent("撤销采购合同单id："+purchase_id);
				operationManager.insertOperation(operation);
				String reason=req.getParameter("reason");
				flow.setReason(reason);
				int purchaseApplyNum=purchase_contractManager.getPurchaseApplyNum(purchase_contract);
				if(opera==10||opera==12||opera==13||(purchaseApplyNum==2&&opera==4)||(purchaseApplyNum==3&&opera==6)||(purchaseApplyNum>3&&opera==8)){
					//已完成的
					flow.setOperation(11);
					flow.setId(1);//标记 1：审批结束后撤销
					flowManager.insertFlow(flow);
					flow.setOperation(1);
					flow.setReason(null);
					flowManager.insertFlow(flow);
					purchase_contractManager.updateHasbuy_numFromNum(purchase_id);
				}else{
					//未审批完之前撤销，可直接撤销，通知相关人员
					flow.setId(2);//标记 2：未审批完之前撤销
					flow.setOperation(11);
					flowManager.insertFlow(flow);
				}
				purchase_contract.setUpdate_time(nowTime);
				purchase_contractManager.updatePurchase_contract(purchase_contract);
				resp.sendRedirect("flowmanager/purchaseflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("login.jsp");
			}
			finally{
				lock12.writeLock().unlock();
			}
		}else if("checkContract_no".equals(type)){
			int id=Integer.parseInt(req.getParameter("foreign_id"));
			String contract_no=req.getParameter("contract_no");
			int flag=1;//不重复
			if("1".equals(req.getParameter("contract_type"))){
				if(sales_contractManager.checkContract_no(contract_no,id)){
					flag=2;
				}
			}else{
				if(purchase_contractManager.checkContract_no(contract_no,id)){
					flag=2;
				}
			}
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma", "no-cache");
			resp.setHeader("cache-control", "no-cache");
			PrintWriter out = resp.getWriter();
			out.print(flag);
			out.flush();
		}else if("getAllNoShippingSale".equals(type)){
			//返回所有未出货明细(拉取销售合同并封装成Shipping对象返回)
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma", "no-cache");
			resp.setHeader("cache-control", "no-cache");
			PrintWriter out = resp.getWriter();
			out.println(JSONArray.fromObject(session.getAttribute("salesList")));
			out.flush();
		}else if("getNeedShippingBySale".equals(type)){
			//拉取销售合同并封装成Shipping对象返回
			Shipping shipping=null;
			try {
				int sales_id=Integer.parseInt(req.getParameter("sales_id"));
				shipping=shippingManager.getNeedShippingBySale(sales_id);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma", "no-cache");
			resp.setHeader("cache-control", "no-cache");
			PrintWriter out = resp.getWriter();
			out.println(JSONObject.fromObject(shipping));
			out.flush();
		}else if("addshipping".equals(type)){
			//拉取销售合同并封装成Shipping对象返回
			int shipping_id=0;//大于0正常
			try {
				int sales_id=Integer.parseInt(req.getParameter("sales_id"));
				String customer_contract_no=req.getParameter("customer_contract_no");
				String material_type=req.getParameter("material_type");
				int department=Integer.parseInt(req.getParameter("department"));
				long putout_time=Long.parseLong(req.getParameter("putout_time"));
				String address=req.getParameter("address");
				String linkman=req.getParameter("linkman");
				String linkman_phone=req.getParameter("linkman_phone");
				String shipping_jsonarray=req.getParameter("shipping_jsonarray");
				long nowTime=System.currentTimeMillis();
				Shipping shipping=new Shipping();
				shipping.setCreate_id(uid);
				shipping.setCreate_time(nowTime);
				shipping.setSales_id(sales_id);
				shipping.setCustomer_contract_no(customer_contract_no);
				shipping.setMaterial_type(material_type);
				shipping.setDepartment(department);
				shipping.setPutout_time(putout_time);
				shipping.setAddress(address);
				shipping.setLinkman(linkman);
				shipping.setLinkman_phone(linkman_phone);
				shipping_id=shippingManager.insertShipping(shipping);
				if(shipping_jsonarray!=null&&shipping_jsonarray.length()>0){
					List<Shipping_list> shipping_lists=JSONArray.toList(JSONArray.fromObject(shipping_jsonarray), Shipping_list.class);
					int a=1;
					for (Shipping_list shipping_list : shipping_lists) {
						shipping_list.setShipping_id(shipping_id);
						shippingManager.insertShipping_list(shipping_list);
					}
				}
				Flow flow=new Flow();
				flow.setCreate_time(nowTime);
				flow.setType(18);
				flow.setUid(uid);
				flow.setForeign_id(shipping_id);
				flow.setOperation(1);
				flowManager.insertFlow(flow);
				Operation operation=new Operation();
				operation.setCreate_time(nowTime);
				operation.setUid(uid);
				operation.setContent("添加出货单id："+shipping_id);
			} catch (Exception e) {
				// TODO: handle exception
				shipping_id=0;
			}
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma", "no-cache");
			resp.setHeader("cache-control", "no-cache");
			PrintWriter out = resp.getWriter();
			out.println(shipping_id);
			out.flush();
		}else if("shipping".equals(type)){
			int shipping_id=(Integer)session.getAttribute("shipping_id");
			int nowOpera=Integer.parseInt(req.getParameter("operation"));
			Flow nowFlow=flowManager.getNewFlowByFID(18, shipping_id);
			Shipping shipping=shippingManager.getShippingById(shipping_id);
			if(shipping==null||nowFlow==null||nowFlow.getOperation()!=nowOpera){
				resp.sendRedirect("flowmanager/shippingflow_detail.jsp");
				return;
			}
			long nowTime=System.currentTimeMillis();
			Flow flow=new Flow();
			flow.setCreate_time(nowTime);
			flow.setUid(uid);
			flow.setForeign_id(shipping_id);
			flow.setType(18);
			Operation operation=new Operation();
			operation.setUid(uid);
			operation.setCreate_time(nowTime);
			boolean isFinished=false;
			if(nowOpera==1||nowOpera==3){
				String reason=req.getParameter("reason");
				flow.setReason(reason);
				if("0".equals(req.getParameter("isagree"))){
					operation.setContent("出货单id:" + shipping_id + "部门领导审核通过<br/>理由：" + reason);
					operationManager.insertOperation(operation);
					Flow flow_del=flowManager.getFlowByOperation(18, shipping_id,7);
					if(flow_del!=null){
						flow.setOperation(2);
						flowManager.insertFlow2(flow);
						isFinished=true;
					}else{
						flow.setOperation(2);
						flowManager.insertFlow(flow);
					}
				}else{
					flow.setOperation(3);
					operation.setContent("出货单id:" + shipping_id + "的部门领导审核不予通过<br/>理由：" + reason);
					operationManager.insertOperation(operation);
					flowManager.insertFlow(flow);
				}
			}else if(nowOpera==2){
				flow.setOperation(4);
				operation.setContent("出货单id:" + shipping_id + "领料完成");
				operationManager.insertOperation(operation);
				flowManager.insertFlow(flow);
				shipping.setMaterial_man_id(uid);
				shippingManager.updateShipping(shipping);
			}else if(nowOpera==4){
				flow.setOperation(5);
				operation.setContent("出货单id:" + shipping_id + "已发货");
				operationManager.insertOperation(operation);
				flowManager.insertFlow(flow);
				shipping.setShipper_id(uid);
				shippingManager.updateShipping(shipping);
			}else if(nowOpera==5){
				flow.setOperation(6);
				operation.setContent("出货单id:" + shipping_id + "输入信息反馈，流程结束");
				operationManager.insertOperation(operation);
				flowManager.insertFlow(flow);
				long ship_time=Long.parseLong(req.getParameter("ship_time"));
				String logistics_num=req.getParameter("logistics_num");
				String logistics_company=req.getParameter("logistics_company");
				String orderId=req.getParameter("orderId");
				shipping.setShip_time(ship_time);
				shipping.setLogistics_company(logistics_company);
				shipping.setLogistics_num(logistics_num);
				shipping.setOrderId(orderId);
				shippingManager.updateShipping(shipping);
			}else{
				resp.sendRedirect("login.jsp");
				return;
			}
			if(isFinished){
				//审批完成
				Flow flow18_del=flowManager.getFlowByOperation(18, shipping_id, 7);
				if(flow18_del!=null){
					flow.setReason(null);
					flow.setOperation(7);
					flow.setId(3);//标记 3：撤销成功
					flowManager.insertFlow(flow);
				}
			}
			resp.sendRedirect("flowmanager/shippingflow_detail.jsp");
		}else if("delShipping".equals(type)){
			try {
				lock18.writeLock().lock();
				int shipping_id=(Integer)session.getAttribute("shipping_id");
				int opera=Integer.parseInt(req.getParameter("operation"));
				Flow nowFlow=flowManager.getNewFlowByFID(18, shipping_id);
				if(opera!=nowFlow.getOperation()){
					resp.sendRedirect("flowmanager/shippingflow_detail.jsp");
					return;
				}
				long nowTime=System.currentTimeMillis();
				Flow flow=new Flow();
				flow.setCreate_time(nowTime);
				flow.setForeign_id(shipping_id);
				flow.setUid(uid);
				flow.setType(18);
				Operation operation=new Operation();
				operation.setUid(uid);
				operation.setCreate_time(nowTime);
				operation.setContent("撤销出货单id："+shipping_id);
				operationManager.insertOperation(operation);
				String reason=req.getParameter("reason");
				flow.setReason(reason);
				if(opera==1||opera==3){
					//未审批完之前撤销，可直接撤销，通知相关人员
					flow.setId(2);//标记 2：未审批完之前撤销
					flow.setOperation(7);
					flowManager.insertFlow(flow);
				}else{
					//已完成的
					flow.setReason(reason);
					flow.setOperation(7);
					flow.setId(1);//标记 1：审批结束后撤销
					flowManager.insertFlow(flow);
					flow.setOperation(1);
					flow.setReason(null);
					flowManager.insertFlow(flow);
				}
				resp.sendRedirect("flowmanager/shippingflow_detail.jsp");
			} catch (Exception e) {
				// TODO: handle exception
				resp.sendRedirect("login.jsp");
			}
			finally{
				lock18.writeLock().unlock();
			}
		}else if("updateshipping".equals(type)){
			//拉取销售合同并封装成Shipping对象返回
			int shipping_id=0;//大于0正常
			try {
				shipping_id=(Integer)session.getAttribute("shipping_id");
				Flow nowFlow=flowManager.getNewFlowByFID(18, shipping_id);
				int opera=Integer.parseInt(req.getParameter("operation"));
				if(nowFlow==null||nowFlow.getOperation()!=opera){
					return;
				}
				String reason=req.getParameter("reason");
				int sales_id=Integer.parseInt(req.getParameter("sales_id"));
				String customer_contract_no=req.getParameter("customer_contract_no");
				String material_type=req.getParameter("material_type");
				int department=Integer.parseInt(req.getParameter("department"));
				long putout_time=Long.parseLong(req.getParameter("putout_time"));
				String address=req.getParameter("address");
				String linkman=req.getParameter("linkman");
				String linkman_phone=req.getParameter("linkman_phone");
				String shipping_jsonarray=req.getParameter("shipping_jsonarray");
				long nowTime=System.currentTimeMillis();
				Shipping shipping=shippingManager.getShippingById(shipping_id);
				shipping.setSales_id(sales_id);
				shipping.setCustomer_contract_no(customer_contract_no);
				shipping.setMaterial_type(material_type);
				shipping.setDepartment(department);
				shipping.setPutout_time(putout_time);
				shipping.setAddress(address);
				shipping.setLinkman(linkman);
				shipping.setLinkman_phone(linkman_phone);
				shippingManager.updateShipping(shipping);
				shippingManager.delShipping_listByShipping_id(shipping_id);
				if(shipping_jsonarray!=null&&shipping_jsonarray.length()>0){
					List<Shipping_list> shipping_lists=JSONArray.toList(JSONArray.fromObject(shipping_jsonarray), Shipping_list.class);
					int a=1;
					for (Shipping_list shipping_list : shipping_lists) {
						shipping_list.setShipping_id(shipping_id);
						shippingManager.insertShipping_list(shipping_list);
					}
				}
				Flow flow=new Flow();
				flow.setCreate_time(nowTime);
				flow.setType(18);
				flow.setUid(uid);
				flow.setForeign_id(shipping_id);
				flow.setOperation(0);
				flow.setReason(reason);
				flowManager.insertFlow2(flow);
				flow.setOperation(1);
				flow.setReason(null);
				if(opera==1){
					//未审批直接修改，无需重复发邮件
					flowManager.insertFlow2(flow);
				}else{
					flowManager.insertFlow(flow);
				}
				Operation operation=new Operation();
				operation.setCreate_time(nowTime);
				operation.setUid(uid);
				operation.setContent("修改出货单id："+shipping_id);
			} catch (Exception e) {
				// TODO: handle exception
				shipping_id=0;
			}finally{
				resp.setContentType("application/text;charset=utf-8");
				resp.setHeader("pragma", "no-cache");
				resp.setHeader("cache-control", "no-cache");
				PrintWriter out = resp.getWriter();
				out.println(shipping_id);
				out.flush();
			}
		}else{
			req.getRequestDispatcher("/login.jsp").forward(req, resp);
		}
	}


	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		sales_contractManager=(Sales_contractManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"sales_contractManager");
		purchase_contractManager=(Purchase_contractManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"purchase_contractManager");
		purchase_noteManager=(Purchase_noteManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"purchase_noteManager");
		customer_dataManager=(Customer_dataManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"customer_dataManager");
		file_pathManager = (File_pathManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"file_pathManager");
		flowManager = (FlowManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"flowManager");
		operationManager = (OperationManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"operationManager");
		position_userManager = (Position_userManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"position_userManager");
		userManager = (UserManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"userManager");
		product_infoManager=(Product_infoManager)WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"product_infoManager");
		shippingManager=(ShippingManager)WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"shippingManager");
	}

	
}
