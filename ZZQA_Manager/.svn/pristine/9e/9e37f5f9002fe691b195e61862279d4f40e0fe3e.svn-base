package com.zzqa.dao.interfaces.outsource_product;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.outsource_product.Outsource_product;

public interface IOutsource_productDAO {
	public void insertOutsource_product(Outsource_product outsource_product);
	public void updateOutsource_product(Outsource_product outsource_product);
	public void delOutsource_productByID(int id);
	public int getOutsource_productCount();
	/******
	 * 传入参数 beginrow rows
	 * @param map
	 * @return
	 */
	public List getOutsource_productList(Map map);
	public Outsource_product getOutsource_productByID(int id);
	//查询用户最新添加的外协生产
	public int getNewOutsource_productByUID(int uid);
	/****
	 * 查询未完成的外协生产流程
	 * @return
	 */
	public List getRunningOutsource_product();
	public List getAllList();
}
