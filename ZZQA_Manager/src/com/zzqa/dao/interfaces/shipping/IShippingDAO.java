package com.zzqa.dao.interfaces.shipping;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.shipping.Shipping;

public interface IShippingDAO {

	int insertShipping(Shipping shipping);

	Shipping getShippingDetailById(int shipping_id);
	
	Shipping getShippingById(int shipping_id);
	
	List<Shipping> getRunningShipping();

	List<Shipping> getAllList();
	
	public void updateShipping(Shipping shipping);

	List<Integer> getShippingDetailByTime(Map map);

}
