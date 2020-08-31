package com.zzqa.service.interfaces.sales_contract;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.product_info.Product_info;
import com.zzqa.pojo.sales_contract.Sales_contract;
import com.zzqa.pojo.user.User;

public interface Sales_contractManager {
	public void insertSales_contract(Sales_contract sales_contract);
	public Sales_contract getSales_contractByID2(int id);
	public int getNewSalesIDByCreateID(int create_id);
	public Sales_contract getSales_contractByID(int id);
	public void updateSales_contract(Sales_contract sales_contract);
	public Map<String,String> getSalesFlowForDraw(Sales_contract sales_contract,Flow flow);
	public int getApplyNum(Sales_contract sales_contract);
	public boolean checkCanApply(Sales_contract sales_contract,User user,int operation);
	//当前是否可盖章
	public boolean checkSealManager(Sales_contract sales_contract,User user,int operation);
	public List<Sales_contract> getSalesListByUID(User user);
	/***
	 * 查询已完成销售合同的供应商
	 * @return
	 */
	public List getConmany_name1s();
	/*****
	 * 查询所有已结束的销售合同及其产品信息(绑定的)
	 * @param supplier
	 * @return
	 */
	public List<Sales_contract> getNeedPurchaseProducts();
	//检查合同是否重复
	public boolean checkContract_no(String contract_no,int sales_id);
	/***
	 * 返回产品的详情，包括已采购数量
	 * @param sales_id
	 * @return
	 */
	public List<Product_info> getDetailProduct_infos(int sales_id);
	public List<Sales_contract> getSalesDetailByTime(long starttime1, long endtime1,long starttime2, long endtime2);
	//审批完成的销售合同 发货流程
	public List<Sales_contract> getFinishedSales();
	
}
