package com.zzqa.service.interfaces.outsource_product;

import java.util.List;
import java.util.Map;

import com.zzqa.dao.interfaces.outsource_product.IOutsource_productDAO;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.outsource_product.Outsource_product;
import com.zzqa.pojo.user.User;

public interface Outsource_productManager {
	public void insertOutsource_product(Outsource_product outsource_product);
	public void updateOutsource_product(Outsource_product outsource_product);
	public void delOutsource_productByID(int id);
	public int getOutsource_productCount();
	/******
	 * 传入参数 beginrow rows
	 * @param map
	 * @return
	 */
	public List getOutsource_productList(int beginrow,int rows);
	public Outsource_product getOutsource_productByID(int id);
	public Outsource_product getOutsource_productByID2(int id);
	//查询用户最新添加的外协生产
	public int getNewOutsource_productByUID(int uid);
	/****
	 * 流程绘制元素
	 * @param product_pid
	 * @return
	 */
	public Map<String, String> getOutPFlowForDraw(Outsource_product op,Flow flow);
	//用户待办事项
	public List<Outsource_product> getOutsourceByUID(User user);
}
