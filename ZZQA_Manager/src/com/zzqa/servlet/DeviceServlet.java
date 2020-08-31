package com.zzqa.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.web.context.support.WebApplicationContextUtils;

import com.zzqa.pojo.circuit_card.Circuit_card;
import com.zzqa.pojo.customer_data.Customer_data;
import com.zzqa.pojo.equipment.Equipment;
import com.zzqa.pojo.equipment_template.Equipment_template;
import com.zzqa.pojo.materials_info.Materials_info;
import com.zzqa.pojo.operation.Operation;
import com.zzqa.pojo.purchase_contract.Purchase_contract;
import com.zzqa.pojo.sales_contract.Sales_contract;
import com.zzqa.pojo.shipping.Shipping;
import com.zzqa.pojo.user.User;
import com.zzqa.pojo.work.Work;
import com.zzqa.service.interfaces.customer_data.Customer_dataManager;
import com.zzqa.service.interfaces.equipment.EquipmentManager;
import com.zzqa.service.interfaces.file_path.File_pathManager;
import com.zzqa.service.interfaces.materials_info.Materials_infoManager;
import com.zzqa.service.interfaces.operation.OperationManager;
import com.zzqa.service.interfaces.product_info.Product_infoManager;
import com.zzqa.service.interfaces.purchase_contract.Purchase_contractManager;
import com.zzqa.service.interfaces.sales_contract.Sales_contractManager;
import com.zzqa.service.interfaces.shipping.ShippingManager;
import com.zzqa.service.interfaces.user.UserManager;
import com.zzqa.service.interfaces.work.WorkManager;

public class DeviceServlet extends HttpServlet{
	
	private static final long serialVersionUID = 1L;
	private Materials_infoManager materials_infoManager;
	private OperationManager operationManager;
	private Customer_dataManager customer_dataManager;
	private Product_infoManager product_infoManager;
	private WorkManager workManager;
	private Sales_contractManager sales_contractManager;
	private Purchase_contractManager purchase_contractManager;
	private ShippingManager shippingManager;
	private UserManager userManager;
	private EquipmentManager equipmentManager;
	private File_pathManager file_pathManager;
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String type = req.getParameter("type");
 		HttpSession session=req.getSession();
 		if(session==null||session.getAttribute("uid")==null){
 			req.getRequestDispatcher("/login.jsp").forward(req, resp);
			return;
 		}
		if("statistical".equals(type)){
			String selecttype = req.getParameter("selecttype");
			if (selecttype == "") {
				req.getRequestDispatcher("/login.jsp").forward(req, resp);
				return;
			}
			int statisticalType = Integer.parseInt(selecttype);
			String pagerow=req.getParameter("pagerow");
			if (statisticalType == 1) {
				resp.sendRedirect("devicemanager/devicemanager.jsp");
			}else if (statisticalType == 2) {
				resp.sendRedirect("devicemanager/travel_report.jsp");
			}else if (statisticalType == 3) {
				resp.sendRedirect("devicemanager/leave_report.jsp");
			}else if (statisticalType == 4) {
				resp.sendRedirect("devicemanager/track_report.jsp");
			}else if (statisticalType == 5) {
				resp.sendRedirect("devicemanager/customer_report.jsp");
				session.setAttribute("pagerow_customer", Integer.parseInt(pagerow));
			}else if (statisticalType == 6) {
				resp.sendRedirect("devicemanager/supplier_report.jsp");
				session.setAttribute("pagerow_supplier", Integer.parseInt(pagerow));
			}else if (statisticalType == 7) {
				resp.sendRedirect("devicemanager/materials_report.jsp");
				session.setAttribute("pagerow_materials", Integer.parseInt(pagerow));
			}else if (statisticalType == 8) {
				resp.sendRedirect("devicemanager/work_report.jsp");
			}else if (statisticalType == 9) {
				resp.sendRedirect("devicemanager/sales_report.jsp");
			}else if (statisticalType == 10) {
				resp.sendRedirect("devicemanager/purchase_report.jsp");
			}else if (statisticalType == 11) {
				resp.sendRedirect("devicemanager/shipping_report.jsp");
			}else if (statisticalType == 12) {
				resp.sendRedirect("devicemanager/performance_report.jsp");
			}else if (statisticalType == 13) {
				resp.sendRedirect("devicemanager/vehicle_report.jsp");
			}else {
				req.getRequestDispatcher("/login.jsp").forward(req, resp);
			}
			return;
		}else if("travelfilter".equals(type)){
			session.setAttribute("year_travel", Integer.parseInt(req.getParameter("year_travel")));
			session.setAttribute("month_travel", Integer.parseInt(req.getParameter("month_travel")));
			resp.sendRedirect("devicemanager/travel_report.jsp");
			return;
		}else if("leavefilter".equals(type)){
			session.setAttribute("year_leave", Integer.parseInt(req.getParameter("year_leave")));
			session.setAttribute("month_leave", Integer.parseInt(req.getParameter("month_leave")));
			resp.sendRedirect("devicemanager/leave_report.jsp");
			return;
		}else if("trackfilter".equals(type)){
			long starttime_track=Long.parseLong(req.getParameter("starttime_track"));
			long endtime_track=Long.parseLong(req.getParameter("endtime_track"));
			session.setAttribute("starttime_track",starttime_track);
			session.setAttribute("endtime_track",endtime_track);
			session.setAttribute("users_track",req.getParameter("users_track"));
			session.setAttribute("keywords_track",req.getParameter("keywords_track"));
			resp.sendRedirect("devicemanager/track_report.jsp");
			return;
		}else if("materialsfilter".equals(type)){
			int nowpage_materials=Integer.parseInt(req.getParameter("nowpage"));
			session.setAttribute("nowpage_materials",nowpage_materials);
			session.setAttribute("keywords_materials",req.getParameter("keywords_materials"));
			resp.sendRedirect("devicemanager/materials_report.jsp");
			return;
		}else if("customerfilter".equals(type)){
			int customer_type=Integer.parseInt(req.getParameter("customer_type"));
			int nowpage_customer=Integer.parseInt(req.getParameter("nowpage"));
			if(customer_type==1){
				session.setAttribute("nowpage_customer",nowpage_customer);
				session.setAttribute("keywords_customer",req.getParameter("keywords_customer"));
				resp.sendRedirect("devicemanager/customer_report.jsp");
			}else if(customer_type==2){
				session.setAttribute("nowpage_supplier",nowpage_customer);
				session.setAttribute("keywords_supplier",req.getParameter("keywords_customer"));
				resp.sendRedirect("devicemanager/supplier_report.jsp");
			}else{
				return;
			}
		}else if("vehiclefilter".equals(type)){
			session.setAttribute("keywords_vehicle",req.getParameter("keywords_vehicle"));
			resp.sendRedirect("devicemanager/vehicle_report.jsp");
		}else if("checkmaterials".equals(type)){
			String model=req.getParameter("model");
			Materials_info materials_info=materials_infoManager.getMaterials_infoByModel(model);
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma", "no-cache");
			resp.setHeader("cache-control", "no-cache");
			PrintWriter out = resp.getWriter();
			out.print(materials_info==null?0:materials_info.getId());
			out.flush();
		}else if("checkcustomer".equals(type)){
			String company_name=req.getParameter("company_name");
			int customer_type=Integer.parseInt(req.getParameter("customer_type"));
			Customer_data customer_data=customer_dataManager.getCustomer_dataByCName(company_name, customer_type);
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma", "no-cache");
			resp.setHeader("cache-control", "no-cache");
			PrintWriter out = resp.getWriter();
			out.print(customer_data==null?0:customer_data.getCustomer_id());
			out.flush();
		}else if("addmaterial".equals(type)){
			String materials_id=req.getParameter("materials_id");
			String model=req.getParameter("model");
			String remark=req.getParameter("remark");
			String unit=req.getParameter("unit");
			Materials_info materials_info=new Materials_info();
			materials_info.setMaterials_id(materials_id);
			materials_info.setRemark(remark);
			materials_info.setModel(model);
			materials_info.setUnit(unit);
			materials_infoManager.insertMaterials_info(materials_info);
			Materials_info materials_info2=materials_infoManager.getMaterials_infoByModel(model);
			Operation operation=new Operation();
			operation.setUid((Integer)session.getAttribute("uid"));
			operation.setCreate_time(System.currentTimeMillis());
			if(materials_info2==null){
				operation.setContent("添加物料失败，型号："+model);
				resp.sendRedirect("login.jsp");
				return;
			}else{
				operation.setContent("添加物料，id："+materials_info2.getId());
				operationManager.insertOperation(operation);
			}
			String keywords=req.getParameter("keywords");
			int num=materials_infoManager.getNumByCondition(keywords);
			int nowpage=(Integer)session.getAttribute("nowpage_materials");
			int pagerow=(Integer)session.getAttribute("pagerow_materials");
			if((nowpage-1)*pagerow>=num){
				nowpage=num==0?1:((num%pagerow==0?0:1)+num/pagerow);
				session.setAttribute("nowpage_materials",nowpage );
			}
			session.setAttribute("keywords_materials", keywords);
			resp.sendRedirect("devicemanager/materials_report.jsp");
		}else if("altermaterial".equals(type)){
			String materials_id=req.getParameter("materials_id");
			String model=req.getParameter("model");
			String remark=req.getParameter("remark");
			String unit=req.getParameter("unit");
			int id=Integer.parseInt(req.getParameter("id"));
			Materials_info materials_info=new Materials_info();
			materials_info.setId(id);
			materials_info.setMaterials_id(materials_id);
			materials_info.setModel(model);
			materials_info.setRemark(remark);
			materials_info.setUnit(unit);
			materials_infoManager.updateMaterials_info(materials_info);
			Operation operation=new Operation();
			operation.setUid((Integer)session.getAttribute("uid"));
			operation.setCreate_time(System.currentTimeMillis());
			operation.setContent("修改物料，id："+id);
			operationManager.insertOperation(operation);
			String keywords=req.getParameter("keywords");
			int num=materials_infoManager.getNumByCondition(keywords);
			int nowpage=(Integer)session.getAttribute("nowpage_materials");
			int pagerow=(Integer)session.getAttribute("pagerow_materials");
			if((nowpage-1)*pagerow>=num){
				nowpage=num==0?1:((num%pagerow==0?0:1)+num/pagerow);
				session.setAttribute("nowpage_materials",nowpage );
			}
			session.setAttribute("keywords_materials", keywords);
			resp.sendRedirect("devicemanager/materials_report.jsp");
		}else if("checkDelMaterials".equals(type)){
			int m_id=Integer.parseInt(req.getParameter("m_id"));
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma", "no-cache");
			resp.setHeader("cache-control", "no-cache");
			PrintWriter out = resp.getWriter();
			out.print(product_infoManager.checkUseMaterials(m_id)?1:0);
			out.flush();
		}else if("delmaterials".equals(type)){
			int id=Integer.parseInt(req.getParameter("id"));
			materials_infoManager.delMaterials_infoByID(id);
			Operation operation=new Operation();
			operation.setUid((Integer)session.getAttribute("uid"));
			operation.setCreate_time(System.currentTimeMillis());
			operation.setContent("删除物料，id："+id);
			operationManager.insertOperation(operation);
			String keywords=req.getParameter("keywords");
			int num=materials_infoManager.getNumByCondition(keywords);
			int nowpage=(Integer)session.getAttribute("nowpage_materials");
			int pagerow=(Integer)session.getAttribute("pagerow_materials");
			if((nowpage-1)*pagerow>=num){
				nowpage=num==0?1:((num%pagerow==0?0:1)+num/pagerow);
				session.setAttribute("nowpage_materials",nowpage );
			}
			session.setAttribute("keywords_materials", keywords);
			resp.sendRedirect("devicemanager/materials_report.jsp");
		}else if("addcustomer".equals(type)){
			int customer_type=Integer.parseInt(req.getParameter("customer_type"));
			String company_name=req.getParameter("company_name");
			String company_address=req.getParameter("company_address");
			String postal_code=req.getParameter("postal_code");
			String law_person=req.getParameter("law_person");
			String entrusted_agent=req.getParameter("entrusted_agent");
			String phone=req.getParameter("phone");
			String fax=req.getParameter("fax");
			String bank=req.getParameter("bank");
			String company_account=req.getParameter("company_account");
			String tariff_item=req.getParameter("tariff_item");
			Customer_data customer_data=new Customer_data();
			customer_data.setType(customer_type);
			customer_data.setCompany_name(company_name);
			customer_data.setCompany_address(company_address);
			customer_data.setPostal_code(postal_code);
			customer_data.setLaw_person(law_person);
			customer_data.setEntrusted_agent(entrusted_agent);
			customer_data.setPhone(phone);
			customer_data.setFax(fax);
			customer_data.setBank(bank);
			customer_data.setCompany_account(company_account);
			customer_data.setTariff_item(tariff_item);
			customer_dataManager.insertCustomer_data(customer_data);
			Customer_data customer_data2=customer_dataManager.getCustomer_dataByCName(company_name, customer_type);
			Operation operation=new Operation();
			operation.setUid((Integer)session.getAttribute("uid"));
			operation.setCreate_time(System.currentTimeMillis());
			if(customer_data2==null){
				operation.setContent("添加"+(customer_type==1?"客户":"供应商")+"资料失败，单位名称："+company_name);
				resp.sendRedirect("login.jsp");
				return;
			}else{
				operation.setContent((customer_type==1?"添加客户":"添加供应商")+"资料，id："+customer_data2.getCustomer_id());
				operationManager.insertOperation(operation);
			}
			String keywords=req.getParameter("keywords");
			int num=customer_dataManager.getNumByCondition(customer_type, keywords);
			int nowpage=1;
			int pagerow=20;
			if(customer_type==1){
				try {
					nowpage=(Integer)session.getAttribute("nowpage_customer");
					pagerow=(Integer)session.getAttribute("pagerow_customer");
				} catch (Exception e) {
					// TODO: handle exception
				}
				if((nowpage-1)*pagerow>=num){
					nowpage=num==0?1:((num%pagerow==0?0:1)+num/pagerow);
					session.setAttribute("nowpage_customer",nowpage );
				}
				session.setAttribute("keywords_customer", keywords);
				resp.sendRedirect("devicemanager/customer_report.jsp");
			}else{
				try {
					nowpage=(Integer)session.getAttribute("nowpage_supplier");
					pagerow=(Integer)session.getAttribute("pagerow_supplier");
				} catch (Exception e) {
					// TODO: handle exception
				}
				if((nowpage-1)*pagerow>=num){
					nowpage=num==0?1:((num%pagerow==0?0:1)+num/pagerow);
					session.setAttribute("nowpage_supplier",nowpage );
				}
				session.setAttribute("keywords_supplier", keywords);
				resp.sendRedirect("devicemanager/supplier_report.jsp");
			}
		}else if("altercustomer".equals(type)){
			int customer_type=Integer.parseInt(req.getParameter("customer_type"));
			String company_name=req.getParameter("company_name");
			String company_address=req.getParameter("company_address");
			String postal_code=req.getParameter("postal_code");
			String law_person=req.getParameter("law_person");
			String entrusted_agent=req.getParameter("entrusted_agent");
			String phone=req.getParameter("phone");
			String fax=req.getParameter("fax");
			String bank=req.getParameter("bank");
			String company_account=req.getParameter("company_account");
			String tariff_item=req.getParameter("tariff_item");
			String customer_id=req.getParameter("customer_id");
			Customer_data customer_data=customer_dataManager.getCustomer_dataByCustomerID(customer_id);
			Operation operation=new Operation();
			operation.setUid((Integer)session.getAttribute("uid"));
			operation.setCreate_time(System.currentTimeMillis());
			if(customer_data==null){
				operation.setContent((customer_type==1?"修改客户":"修改供应商")+"资料失败，id："+customer_id);
				operationManager.insertOperation(operation);
				resp.sendRedirect("login.jsp");
				return;
			}else{
				customer_data.setType(customer_type);
				customer_data.setCompany_name(company_name);
				customer_data.setCompany_address(company_address);
				customer_data.setPostal_code(postal_code);
				customer_data.setLaw_person(law_person);
				customer_data.setEntrusted_agent(entrusted_agent);
				customer_data.setPhone(phone);
				customer_data.setFax(fax);
				customer_data.setBank(bank);
				customer_data.setCompany_account(company_account);
				customer_data.setTariff_item(tariff_item);
				customer_dataManager.updateCustomer_data(customer_data);
				operation.setContent((customer_type==1?"修改客户":"修改供应商")+"资料，id："+customer_data.getCustomer_id());
			}
			operationManager.insertOperation(operation);
			String keywords=req.getParameter("keywords");
			int num=customer_dataManager.getNumByCondition(customer_type,keywords);
			int nowpage=1;
			int pagerow=20;
			if(customer_type==1){
				try {
					nowpage=(Integer)session.getAttribute("nowpage_customer");
					pagerow=(Integer)session.getAttribute("pagerow_customer");
				} catch (Exception e) {
					// TODO: handle exception
				}
				if((nowpage-1)*pagerow>=num){
					nowpage=num==0?1:((num%pagerow==0?0:1)+num/pagerow);
					session.setAttribute("nowpage_customer",nowpage );
				}
				session.setAttribute("keywords_customer", keywords);
				resp.sendRedirect("devicemanager/customer_report.jsp");
			}else{
				try {
					nowpage=(Integer)session.getAttribute("nowpage_supplier");
					pagerow=(Integer)session.getAttribute("pagerow_supplier");
				} catch (Exception e) {
					// TODO: handle exception
				}
				if((nowpage-1)*pagerow>=num){
					nowpage=num==0?1:((num%pagerow==0?0:1)+num/pagerow);
					session.setAttribute("nowpage_supplier",nowpage );
				}
				session.setAttribute("keywords_supplier", keywords);
				resp.sendRedirect("devicemanager/supplier_report.jsp");
			}
		}else if("checkCanDelCustomer".equals(type)){
			int flag=0;//可以删除
			String customer_id=req.getParameter("customer_id");
			if("1".equals(req.getParameter("customer_type"))){
				if(customer_dataManager.checkCustomerInSales(customer_id)){
					flag=1;
				}
			}else{
				if(customer_dataManager.checkCustomerInPurchase(customer_id)){
					flag=1;
				}
			}
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma", "no-cache");
			resp.setHeader("cache-control", "no-cache");
			PrintWriter out = resp.getWriter();
			out.print(flag);
			out.flush();
		}else if("delcustomer".equals(type)){
			String customer_id=req.getParameter("customer_id");
			int customer_type=Integer.parseInt(req.getParameter("customer_type"));
			customer_dataManager.delCustomer_dataByCustomerID(customer_id);
			Operation operation=new Operation();
			operation.setUid((Integer)session.getAttribute("uid"));
			operation.setCreate_time(System.currentTimeMillis());
			operation.setContent((customer_type==1?"删除客户":"删除供应商")+"资料，id："+customer_id);
			operationManager.insertOperation(operation);
			String keywords=req.getParameter("keywords");
			int num=customer_dataManager.getNumByCondition(customer_type,keywords);
			int nowpage=1;
			int pagerow=20;
			if(customer_type==1){
				try {
					nowpage=(Integer)session.getAttribute("nowpage_customer");
					pagerow=(Integer)session.getAttribute("pagerow_customer");
				} catch (Exception e) {
					// TODO: handle exception
				}
				if((nowpage-1)*pagerow>=num){
					nowpage=num==0?1:((num%pagerow==0?0:1)+num/pagerow);
					session.setAttribute("nowpage_customer",nowpage );
				}
				session.setAttribute("keywords_customer", keywords);
				resp.sendRedirect("devicemanager/customer_report.jsp");
			}else{
				try {
					nowpage=(Integer)session.getAttribute("nowpage_supplier");
					pagerow=(Integer)session.getAttribute("pagerow_supplier");
				} catch (Exception e) {
					// TODO: handle exception
				}
				if((nowpage-1)*pagerow>=num){
					nowpage=num==0?1:((num%pagerow==0?0:1)+num/pagerow);
					session.setAttribute("nowpage_supplier",nowpage );
				}
				session.setAttribute("keywords_supplier", keywords);
				resp.sendRedirect("devicemanager/supplier_report.jsp");
			}
		}else if("getWorkByMonths".equals(type)){
			String startmonth=req.getParameter("startmonth");//必为月初
			String endmonth=req.getParameter("endmonth");//不一定为月初
			List<Work> works=workManager.getWorkByMonths(Long.parseLong(startmonth),Long.parseLong(endmonth));
			JSONArray jsonArray=JSONArray.fromObject(works);
			resp.setContentType("text/json");
			resp.setCharacterEncoding("UTF-8");
	        PrintWriter out = resp.getWriter();
	        out.print(jsonArray);
		}else if("getSalesDetailByTime".equals(type)){
			long starttime1=Long.parseLong(req.getParameter("starttime1"));
			long endtime1=Long.parseLong(req.getParameter("endtime1"));
			long starttime2=Long.parseLong(req.getParameter("starttime2"));
			long endtime2=Long.parseLong(req.getParameter("endtime2"));
			List<Sales_contract> sales=sales_contractManager.getSalesDetailByTime(starttime1, endtime1,starttime2, endtime2);
			JSONArray jsonArray=JSONArray.fromObject(sales);
			resp.setContentType("text/json");
			resp.setCharacterEncoding("UTF-8");
	        PrintWriter out = resp.getWriter();
	        out.print(jsonArray);
		}else if("getPurchaseDetailByTime".equals(type)){
			long starttime1=Long.parseLong(req.getParameter("starttime1"));
			long endtime1=Long.parseLong(req.getParameter("endtime1"));
			long starttime2=Long.parseLong(req.getParameter("starttime2"));
			long endtime2=Long.parseLong(req.getParameter("endtime2"));
			List<Purchase_contract> purchase_contracts=purchase_contractManager.getPurchaseDetailByTime(starttime1, endtime1,starttime2, endtime2);
			JSONArray jsonArray=JSONArray.fromObject(purchase_contracts);
			resp.setContentType("text/json");
			resp.setCharacterEncoding("UTF-8");
	        PrintWriter out = resp.getWriter();
	        out.print(jsonArray);
		}else if("getShippingDetailByTime".equals(type)){
			long starttime1=Long.parseLong(req.getParameter("starttime1"));
			long endtime1=Long.parseLong(req.getParameter("endtime1"));
			long starttime2=Long.parseLong(req.getParameter("starttime2"));
			long endtime2=Long.parseLong(req.getParameter("endtime2"));
			List<Shipping> shippings=shippingManager.getShippingDetailByTime(starttime1, endtime1,starttime2, endtime2);
			JSONArray jsonArray=JSONArray.fromObject(shippings);
			resp.setContentType("text/json");
			resp.setCharacterEncoding("UTF-8");
	        PrintWriter out = resp.getWriter();
	        out.print(jsonArray);
		}else if("getDeviceManager".equals(type)){
			String keywords_device=req.getParameter("keywords_device");
			String state_device=req.getParameter("state_device");
			int newtime_device=0;
			long starttime_device=0;
			long endtime_device=0;
			try {
				newtime_device=Integer.parseInt(req.getParameter("newtime_device"));
				starttime_device=Long.parseLong(req.getParameter("starttime_device"));
				endtime_device=Long.parseLong(req.getParameter("endtime_device"));
			} catch (Exception e) {
				// TODO: handle exception
				newtime_device=0;
				starttime_device=0;
				endtime_device=0;
			}
			int isCreater=Integer.parseInt(req.getParameter("isCreater"));
			session.setAttribute("device_pageType", 5);
			session.setAttribute("keywords_device", keywords_device);
			session.setAttribute("state_device", state_device);
			session.setAttribute("newtime_device", newtime_device);
			session.setAttribute("starttime_device", starttime_device);
			session.setAttribute("endtime_device", endtime_device);
			session.setAttribute("isCreater", isCreater);
			int uid=(Integer)session.getAttribute("uid");
			User user=userManager.getUserByID(uid);
			List<Equipment> equipments=equipmentManager.getEquipmentByCondition(keywords_device, state_device, newtime_device, starttime_device, endtime_device, isCreater,user);
			JSONArray jsonArray=JSONArray.fromObject(equipments);
			resp.setContentType("text/json");
			resp.setCharacterEncoding("UTF-8");
	        PrintWriter out = resp.getWriter();
	        out.print(jsonArray);
		}else if("getTempManager".equals(type)){
			session.setAttribute("device_pageType", 1);
			List<Equipment_template> equipment_templates=equipmentManager.getAllEquipment_template();
			JSONArray jsonArray=JSONArray.fromObject(equipment_templates);
			resp.setContentType("text/json");
			resp.setCharacterEncoding("UTF-8");
	        PrintWriter out = resp.getWriter();
	        out.print(jsonArray);
		}else if("addTemp".equals(type)){
			session.setAttribute("device_pageType", 1);
			String temp_json=req.getParameter("temp_json");
			List<Circuit_card> circuit_cards=JSONArray.toList(JSONArray.fromObject(req.getParameter("circuit_cards")),Circuit_card.class);
			Equipment_template equipment_template=(Equipment_template)JSONObject.toBean(JSONObject.fromObject(temp_json), Equipment_template.class);
			Equipment_template equipment_template1=equipmentManager.getTempByAlias(equipment_template.getAlias());
			if(equipment_template1!=null){
				resp.setContentType("application/text;charset=utf-8");
				resp.setCharacterEncoding("UTF-8");
		        PrintWriter out = resp.getWriter();
		        out.print(0);
		        return;
			}
			equipment_template.setCircuit_cards(circuit_cards);
			equipmentManager.insertEquipment_template(equipment_template);
			resp.setContentType("application/text;charset=utf-8");
			resp.setCharacterEncoding("UTF-8");
	        PrintWriter out = resp.getWriter();
	        out.print(equipment_template.getId());
	        Operation operation=new Operation();
	        operation.setContent("添加印制板模板");
	        operation.setUid((Integer)session.getAttribute("uid"));
	        operation.setCreate_time(System.currentTimeMillis());
	        operationManager.insertOperation(operation);
		}else if("updateTemp".equals(type)){
			session.setAttribute("device_pageType", 1);
			String temp_json=req.getParameter("temp_json");
			Equipment_template equipment_template=(Equipment_template)JSONObject.toBean(JSONObject.fromObject(temp_json), Equipment_template.class);
			Equipment_template equipment_template1=equipmentManager.getTempByAlias(equipment_template.getAlias());
			if(equipment_template1!=null&&equipment_template1.getId()!=equipment_template.getId()){
				resp.setCharacterEncoding("UTF-8");
		        PrintWriter out = resp.getWriter();
		        out.print(0);
		        return;
			}
			List<Circuit_card> circuit_cards=JSONArray.toList(JSONArray.fromObject(req.getParameter("circuit_cards")),Circuit_card.class);
			equipment_template.setCircuit_cards(circuit_cards);
			equipmentManager.updateEquipment_template(equipment_template);
			resp.setContentType("application/text;charset=utf-8");
			resp.setCharacterEncoding("UTF-8");
	        PrintWriter out = resp.getWriter();
	        out.print(equipment_template.getId());
	        Operation operation=new Operation();
	        operation.setContent("修改印制板模板");
	        operation.setUid((Integer)session.getAttribute("uid"));
	        operation.setCreate_time(System.currentTimeMillis());
	        operationManager.insertOperation(operation);
		}else if("delTemp".equals(type)){
			session.setAttribute("device_pageType", 1);
			int id=Integer.parseInt(req.getParameter("id"));
			equipmentManager.delEquipment_templateByID(id);
			resp.setContentType("application/text;charset=utf-8");
			resp.setCharacterEncoding("UTF-8");
	        PrintWriter out = resp.getWriter();
	        out.println();
	        Operation operation=new Operation();
	        operation.setContent("删除印制板模板，id："+id);
	        operation.setUid((Integer)session.getAttribute("uid"));
	        operation.setCreate_time(System.currentTimeMillis());
	        operationManager.insertOperation(operation);
		}else if("getMyDevice".equals(type)){
			session.setAttribute("device_pageType", 3);
			int uid=(Integer)session.getAttribute("uid");
			List<Equipment> equipments=equipmentManager.getEquipmentByCreateID(uid);
			JSONArray jsonArray=JSONArray.fromObject(equipments);
			resp.setContentType("text/json");
			resp.setCharacterEncoding("UTF-8");
	        PrintWriter out = resp.getWriter();
	        out.print(jsonArray);
		}else if("addDevice".equals(type)){
			session.setAttribute("device_pageType", 3);
			String device_json=req.getParameter("device_json");
			long save_time=Long.parseLong(req.getParameter("save_time"));
			Equipment equipment=(Equipment)JSONObject.toBean(JSONObject.fromObject(device_json), Equipment.class);
			Equipment equipment1=equipmentManager.getEquipmentByID(equipment.getId());
			if(equipment1!=null){
				resp.setContentType("application/text;charset=utf-8");
				resp.setCharacterEncoding("UTF-8");
		        PrintWriter out = resp.getWriter();
		        out.print(0);
		        return;
			}
			int uid=(Integer)session.getAttribute("uid");
			String circuit_cards_str=req.getParameter("circuit_cards");
			if(circuit_cards_str!=null&&circuit_cards_str.length()>0){
				List<Circuit_card> circuit_cards=JSONArray.toList(JSONArray.fromObject(circuit_cards_str),Circuit_card.class);
				if(circuit_cards!=null&&circuit_cards.size()>0){
					equipment.setCircuit_cards(circuit_cards);
				}
			}
			long nowTime=System.currentTimeMillis();
			equipment.setCreate_id(uid);
			equipment.setUpdate_time(nowTime);
			equipmentManager.insertEquipment(equipment);
			file_pathManager.saveFile(uid, session.getId(), 5, equipment.getId(), 1, 0, save_time);
			resp.setContentType("application/text;charset=utf-8");
			resp.setCharacterEncoding("UTF-8");
	        PrintWriter out = resp.getWriter();
	        out.print(JSONObject.fromObject(equipmentManager.getEquipmentByID(equipment.getId())));
	        Operation operation=new Operation();
	        operation.setContent("添加设备，ID："+equipment.getId());
	        operation.setUid((Integer)session.getAttribute("uid"));
	        operation.setCreate_time(System.currentTimeMillis());
	        operationManager.insertOperation(operation);
		}else if("updateDevice".equals(type)){
			session.setAttribute("device_pageType", 3);
			long save_time=Long.parseLong(req.getParameter("save_time"));
			String device_json=req.getParameter("device_json");
			Equipment equipment=(Equipment)JSONObject.toBean(JSONObject.fromObject(device_json), Equipment.class);
			Equipment equipment1=equipmentManager.getEquipmentByID(equipment.getId());
			if(equipment1!=null&&equipment1.getShip_id()>0){
				resp.setContentType("application/text;charset=utf-8");
				resp.setCharacterEncoding("UTF-8");
		        PrintWriter out = resp.getWriter();
		        out.print(0);
		        return;
			}
			List<Circuit_card> circuit_cards=JSONArray.toList(JSONArray.fromObject(req.getParameter("circuit_cards")),Circuit_card.class);
			int uid=(Integer)session.getAttribute("uid");
			equipment.setCircuit_cards(circuit_cards);
			long nowTime=System.currentTimeMillis();
			equipment.setCreate_id(uid);
			equipment.setUpdate_time(nowTime);
			equipmentManager.updateEquipment(equipment);
			file_pathManager.saveFile(uid, session.getId(), 5, equipment.getId(), 1, 0, save_time);
			resp.setContentType("application/text;charset=utf-8");
			resp.setCharacterEncoding("UTF-8");
	        PrintWriter out = resp.getWriter();
	        out.print(JSONObject.fromObject(equipmentManager.getEquipmentByID(equipment.getId())));
	        Operation operation=new Operation();
	        operation.setContent("修改设备，ID："+equipment.getId());
	        operation.setUid((Integer)session.getAttribute("uid"));
	        operation.setCreate_time(System.currentTimeMillis());
	        operationManager.insertOperation(operation);
		}else if("delDevice".equals(type)){
			session.setAttribute("device_pageType", 3);
			int id=Integer.parseInt(req.getParameter("id"));
			Equipment equipment=equipmentManager.getEquipmentByID(id);
			if(equipment!=null&&equipment.getShip_id()>0){
				resp.setContentType("application/text;charset=utf-8");
				resp.setCharacterEncoding("UTF-8");
		        PrintWriter out = resp.getWriter();
		        out.print(0);
		        return;
			}
			equipmentManager.delEquipmentByID(id);
			resp.setContentType("application/text;charset=utf-8");
			resp.setCharacterEncoding("UTF-8");
	        PrintWriter out = resp.getWriter();
	        out.println(1);
	        Operation operation=new Operation();
	        operation.setContent("删除设备，ID："+id);
	        operation.setUid((Integer)session.getAttribute("uid"));
	        operation.setCreate_time(System.currentTimeMillis());
	        operationManager.insertOperation(operation);
		}else if("getWorkdaysReport".equals(type)){
			long startM=Long.parseLong(req.getParameter("startM"));
			long endM=Long.parseLong(req.getParameter("endM"));
			int startDay=Integer.parseInt(req.getParameter("startDay"));
			int endDay=Integer.parseInt(req.getParameter("endDay"));
			Map<String,Float> map=workManager.getWorkdaysReport(startM, startDay, endM, endDay);
			resp.setContentType("application/text;charset=utf-8");
			resp.setCharacterEncoding("UTF-8");
	        PrintWriter out = resp.getWriter();
	        out.println(JSONObject.fromObject(map));
		}else{
			req.getRequestDispatcher("/login.jsp").forward(req, resp);
		}
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String type = req.getParameter("type");
		HttpSession session=req.getSession();
		if("reset".equals(type)){
			/***
			 * 老版本的设备管理
			 */
			session.setAttribute("keywords_device", "");
			session.setAttribute("nowpage_device", "1");
			session.setAttribute("ID_device","");
			session.setAttribute("material_device", 0);
			session.setAttribute("isFileExist", 1);
			session.setAttribute("state_device","1-1-1-1-1-1");
			session.setAttribute("isQualify", 1);
			session.setAttribute("newtime_device",0);
			resp.sendRedirect("devicemanager/devicemanager.jsp");
			return;
		}else if("resetTrack".equals(type)){
			session.setAttribute("keywords_track", "");
			session.setAttribute("users_track","");
			session.setAttribute("starttime_track", null);
			session.setAttribute("endtime_track",null);
			resp.sendRedirect("devicemanager/track_report.jsp");
			return;
		}else{
			resp.sendRedirect("devicemanager/devicemanager.jsp");
		}
	}
	
	public void init() throws ServletException {
		materials_infoManager=(Materials_infoManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("materials_infoManager");
		operationManager=(OperationManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("operationManager");
		customer_dataManager=(Customer_dataManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("customer_dataManager");
		product_infoManager=(Product_infoManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("product_infoManager");
		workManager=(WorkManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("workManager");
		sales_contractManager=(Sales_contractManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("sales_contractManager");
		purchase_contractManager=(Purchase_contractManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("purchase_contractManager");
		shippingManager=(ShippingManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("shippingManager");
		userManager=(UserManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("userManager");
		equipmentManager=(EquipmentManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("equipmentManager");
		file_pathManager=(File_pathManager)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("file_pathManager");
	};
}
