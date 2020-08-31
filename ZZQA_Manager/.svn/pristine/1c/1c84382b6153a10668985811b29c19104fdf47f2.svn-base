package com.zzqa.dao.interfaces.customer_data;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.customer_data.Customer_data;

public interface ICustomer_dataDAO {
	public void insertCustomer_data(Customer_data customer_data);
	/*****
	 * 
	 * @param type 
	 * @return
	 */
	public List<Customer_data> getCustomer_datas(int type);
	public List<String> getCompany_names(int type);
	/****
	 * 根据公司名称
	 * @param company_name
	 * @param type 
	 * @return
	 */
	public Customer_data getCustomer_dataByCName(String company_name,int type);
	public Customer_data getCustomer_dataByCustomerID(String customer_id);
	public void delCustomer_dataByCustomerID(String customer_id);
	public void updateCustomer_data(Customer_data customer_data);
	//获取customer_id的整形部分的最大值
	public int getMaxIDByType(int type);
	public List<Customer_data> getCustomerByCondition(Map map);
	public int getNumByCondition(Map map);
	public boolean checkCustomerInSales(String customer_id);
	public boolean checkCustomerInPurchase(String supplier);
}
