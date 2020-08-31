package com.zzqa.dao.interfaces.sales_contract;

import java.util.List;

import com.zzqa.pojo.sales_contract.Sales_contract;

public interface ISales_contractDAO {
	public void insertSales_contract(Sales_contract sales_contract);
	public void updateSales_contract(Sales_contract sales_contract);
	public void delSales_contractByID(int id);
	public Sales_contract getSales_contractByID(int id);
	public int getNewSalesIDByCreateID(int create_id);
	public List getRunningSales();
	/***
	 * 已完成销售合同的供应商
	 * @return
	 */
	public List getConmany_name1s();
	/***
	 * 根据供应商筛选已完成的供应商
	 * @param company_name1
	 * @return
	 */
	public List getFinishedSales();
	public boolean checkContract_no(String contract_no,int sales_id);
	public List<Sales_contract> getSalesByTime(long starttime1, long endtime1,long starttime2, long endtime2);
	public List getAllList();
}
