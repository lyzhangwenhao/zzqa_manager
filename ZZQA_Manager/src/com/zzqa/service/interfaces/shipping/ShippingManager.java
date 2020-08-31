package com.zzqa.service.interfaces.shipping;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.sales_contract.Sales_contract;
import com.zzqa.pojo.shipping.Shipping;
import com.zzqa.pojo.shipping_list.Shipping_list;
import com.zzqa.pojo.user.User;

public interface ShippingManager {
	/***
	 * 根据销售合同拉取产品
	 * @param sales_id
	 * @return
	 */
	public Shipping getNeedShippingBySale(int sales_id);

	public int insertShipping(Shipping shipping);
	public void updateShipping(Shipping shipping);

	public void insertShipping_list(Shipping_list shipping_list);
	public Shipping getShippingDetailById(int shipping_id);
	public Shipping getShippingById(int shipping_id);
	public List<Shipping> getShippingListByUID(User user);
	public Map<String,String> getShippingFlowForDraw(Shipping shipping,Flow flow);

	public void delShipping_listByShipping_id(int shipping_id);

	public List<Shipping> getShippingDetailByTime(long starttime1,
			long endtime1, long starttime2, long endtime2);
	/**
	 * 返回所有未出货明细(拉取销售合同并封装成Shipping对象返回)
	 */
	public List<Map> getAllNoShippingSale();
}
