package com.zzqa.service.interfaces.customer_data;

import java.util.List;

import com.zzqa.pojo.customer_data.Customer_data;

public interface Customer_dataManager {
	public void insertCustomer_data(Customer_data customer_data);
	/*****
	 * 
	 * @param type -1表示所有
	 * @return
	 */
	public List<Customer_data> getCustomer_datas(int type);
	public List<String> getCompany_names(int type);
	/****
	 * 根据公司名称
	 * @param company_name
	 * @param type -1表示所有
	 * @return
	 */
	public Customer_data getCustomer_dataByCName(String company_name,int type);
	public Customer_data getCustomer_dataByCustomerID(String customer_id);
	public void delCustomer_dataByCustomerID(String customer_id);
	public void updateCustomer_data(Customer_data customer_data);
	public List<Customer_data> getCustomerByCondition(int type,String keywords,int nowpage,int pagerow);
	public int getNumByCondition(int type,String keywords);
	public boolean checkCustomerInSales(String customer_id);
	public boolean checkCustomerInPurchase(String supplier);
}
