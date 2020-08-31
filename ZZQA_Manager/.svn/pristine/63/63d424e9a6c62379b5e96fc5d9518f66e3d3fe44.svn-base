package com.zzqa.dao.interfaces.product_procurement;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.product_procurement.Product_procurement;

public interface IProduct_procurementDAO {
	public void insertProduct_procurement(Product_procurement product_procurement);
	public void updateProduct_procurement(Product_procurement product_procurement);
	public void delProduct_procurementByID(int id);
	public int getProduct_procurementCount();
	/******
	 * 传入参数 beginrow rows
	 * @param map
	 * @return
	 */
	public List getProduct_procurementList(Map map);
	public Product_procurement getProduct_procurementByID(int id);
	//查询用户最新添加的生产流程
	public int getNewProduct_procurementByUID(int create_id);
	//查询已完成的生产采购
	public List getFinishedProduct_procurement();
	//查询需要代办的生成流程
	public List getRunningProduct_procurement();
	public List getAllList();
}
