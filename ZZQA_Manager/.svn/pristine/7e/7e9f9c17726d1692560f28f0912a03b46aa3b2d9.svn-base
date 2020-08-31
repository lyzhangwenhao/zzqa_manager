package com.zzqa.service.impl.customer_data;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.customer_data.ICustomer_dataDAO;
import com.zzqa.pojo.customer_data.Customer_data;
import com.zzqa.pojo.materials_info.Materials_info;
import com.zzqa.service.interfaces.customer_data.Customer_dataManager;
@Component("customer_dataManager")
public class Customer_dataManagerImpl implements Customer_dataManager {
	@Resource(name="customer_dataDAO")
	private ICustomer_dataDAO customer_dataDAO;

	@Override
	public void insertCustomer_data(Customer_data customer_data) {
		// TODO Auto-generated method stub
		customer_dataDAO.insertCustomer_data(customer_data);
	}

	@Override
	public List<Customer_data> getCustomer_datas(int type) {
		// TODO Auto-generated method stub
		return customer_dataDAO.getCustomer_datas(type);
	}
	@Override
	public List<String> getCompany_names(int type) {
		// TODO Auto-generated method stub
		return customer_dataDAO.getCompany_names(type);
	}
	@Override
	public Customer_data getCustomer_dataByCName(String company_name, int type) {
		// TODO Auto-generated method stub
		return customer_dataDAO.getCustomer_dataByCName(company_name, type);
	}

	@Override
	public Customer_data getCustomer_dataByCustomerID(String customer_id) {
		// TODO Auto-generated method stub
		return customer_dataDAO.getCustomer_dataByCustomerID(customer_id);
	}

	@Override
	public void delCustomer_dataByCustomerID(String customer_id){
		// TODO Auto-generated method stub
		customer_dataDAO.delCustomer_dataByCustomerID(customer_id);
	}

	@Override
	public void updateCustomer_data(Customer_data customer_data) {
		// TODO Auto-generated method stub
		customer_dataDAO.updateCustomer_data(customer_data);
	}
	@Override
	public List<Customer_data> getCustomerByCondition(int type,
			String keywords, int nowpage, int pagerow) {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("type",type);
		map.put("keywords",keywords);
		map.put("nowrow",nowpage*pagerow-pagerow);
		map.put("pagerow",pagerow);
		return customer_dataDAO.getCustomerByCondition(map);
	}
	@Override
	public int getNumByCondition(int type, String keywords) {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("type",type);
		map.put("keywords",keywords);
		return customer_dataDAO.getNumByCondition(map);
	}
	@Override
	public boolean checkCustomerInSales(String customer_id) {
		// TODO Auto-generated method stub
		return customer_dataDAO.checkCustomerInSales(customer_id);
	}
	@Override
	public boolean checkCustomerInPurchase(String supplier) {
		// TODO Auto-generated method stub
		return customer_dataDAO.checkCustomerInPurchase(supplier);
	}

}
