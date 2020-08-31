package com.zzqa.service.interfaces.product_procurement;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.procurement.Procurement;
import com.zzqa.pojo.product_procurement.Product_procurement;
import com.zzqa.pojo.user.User;

public interface Product_procurementManager {
	//添加 采购物料
	public void insertProcurement(Procurement procurement);
	//添加生产采购 并返回id
	public int insertProduct(Product_procurement product_procurement);
	//添加生产采购 
	public void insertProduct_procurement(Product_procurement product_procurement);
	//查询用户最新添加的生产采购流程
	public int getNewProduct_procurementByUID(int create_id);
	//查询生产流程
	public List getProduct_procurementList(int beginrow,int rows);
	//等待用户操作的生产流程
	public List<Product_procurement> getProduct_procurementListByUID(User user);
	public Product_procurement getProduct_procurementByID(int id);
	public Product_procurement getProduct_procurementByID2(int id);
	/****
	 * 流程绘制元素
	 * @param 
	 * @return
	 */
	public Map<String, String> getProductPFlowForDraw(Product_procurement product_procurement,Flow flow);
	public void updateProduct_procurement(Product_procurement product_procurement);
	//查询已完成的生产采购
	public List getFinishedProduct_procurement();
}
