package com.zzqa.dao.interfaces.shipping_list;

import com.zzqa.pojo.shipping_list.Shipping_list;

public interface IShipping_listDAO {
	/**
	 * 已发货数量（出货单已完成）
	 * @param product_id
	 * @return
	 */
	int getShippingNumByProduct(int product_id);

	void insertShipping_list(Shipping_list shipping_list);

	void delShipping_listByShipping_id(int shipping_id);

}
