package com.zzqa.dao.impl.shipping_list;

import java.sql.SQLException;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.shipping_list.IShipping_listDAO;
import com.zzqa.pojo.advise.Advise;
import com.zzqa.pojo.shipping_list.Shipping_list;
@Repository("shipping_listDAO")
public class Shipping_listDAOImpl implements IShipping_listDAO {
	@Resource(name="sqlMapClient")
	SqlMapClient sqlMapclient = null;

	@Override
	public int getShippingNumByProduct(int product_id) {
		// TODO Auto-generated method stub
		int num=0;
		try {
			Object object=sqlMapclient.queryForObject("shipping_list.getShippingNumByProduct",product_id);
			if(object!=null){
				num=(Integer)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return num;
		}
		return num;
	}

	@Override
	public void insertShipping_list(Shipping_list shipping_list) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("shipping_list.insertShipping_list",shipping_list);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delShipping_listByShipping_id(int shipping_id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.delete("shipping_list.delShipping_listByShipping_id",shipping_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
