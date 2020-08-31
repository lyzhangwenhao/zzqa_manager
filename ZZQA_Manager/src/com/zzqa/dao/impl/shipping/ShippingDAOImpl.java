package com.zzqa.dao.impl.shipping;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.shipping.IShippingDAO;
import com.zzqa.pojo.shipping.Shipping;
@Repository("shippingDAO")
public class ShippingDAOImpl implements IShippingDAO {
	@Resource(name="sqlMapClient")
	SqlMapClient sqlMapclient = null;

	@Override
	public int insertShipping(Shipping shipping) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("shipping.insertShipping", shipping);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return 0;
		}
		return shipping.getId();
	}
	@Override
	public Shipping getShippingDetailById(int shipping_id) {
		// TODO Auto-generated method stub
		Shipping shipping=null; 
		try {
			Object object=sqlMapclient.queryForObject("shipping.getShippingDetailById",shipping_id);
			if(object!=null){
				shipping=(Shipping)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return shipping;
	}

	@Override
	public Shipping getShippingById(int shipping_id) {
		// TODO Auto-generated method stub
		Shipping shipping=null; 
		try {
			Object object=sqlMapclient.queryForObject("shipping.getShippingById",shipping_id);
			if(object!=null){
				shipping=(Shipping)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return shipping;
	}

	@Override
	public List<Shipping> getRunningShipping() {
		// TODO Auto-generated method stub
		List<Shipping> list=null;
		try {
			list=sqlMapclient.queryForList("shipping.getRunningShipping");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Shipping> getAllList() {
		// TODO Auto-generated method stub
		List<Shipping> list=null;
		try {
			list=sqlMapclient.queryForList("shipping.getAllList");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public void updateShipping(Shipping shipping) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("shipping.updateShipping", shipping);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public List<Integer> getShippingDetailByTime(Map map) {
		// TODO Auto-generated method stub
		List<Integer> ids=null;
		try {
			ids=sqlMapclient.queryForList("shipping.getShippingDetailByTime",map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ids;
	}
	
}
