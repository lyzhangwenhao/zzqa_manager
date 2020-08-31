package com.zzqa.dao.impl.customer_data;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.customer_data.ICustomer_dataDAO;
import com.zzqa.pojo.customer_data.Customer_data;
import com.zzqa.pojo.materials_info.Materials_info;
@Component("customer_dataDAO")
public class Customer_dataDAOImpl implements ICustomer_dataDAO {
	SqlMapClient sqlMapClient = null;
	public SqlMapClient getSqlMapclient() {
		return sqlMapClient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

	@Override
	public void insertCustomer_data(Customer_data customer_data) {
		// TODO Auto-generated method stub
		int type=customer_data.getType();
		int id_int=getMaxIDByType(type)+1;
		String num=null;
		if(id_int<10){
			num="00"+id_int;
		}else if(id_int<100){
			num="0"+id_int;
		}else {
			num=String.valueOf(id_int);
		}
		customer_data.setCustomer_id(type==1?("K"+num):("G"+num));
		try {
			sqlMapClient.insert("customer_data.insertCustomer_data", customer_data);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public List<Customer_data> getCustomer_datas(int type) {
		// TODO Auto-generated method stub
		List<Customer_data> list=null;
		try {
			list=sqlMapClient.queryForList("customer_data.getCustomer_datas", type);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public List<String> getCompany_names(int type) {
		// TODO Auto-generated method stub
		List<String> list=null;
		try {
			list=sqlMapClient.queryForList("customer_data.getCompany_names", type);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public Customer_data getCustomer_dataByCName(String company_name, int type) {
		// TODO Auto-generated method stub
		Customer_data customer_data=null;
		Map map=new HashMap();
		map.put("company_name", company_name);
		map.put("type", type);
		try {
			Object object=sqlMapClient.queryForObject("customer_data.getCustomer_dataByCName",map);
			customer_data=(Customer_data)object;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return customer_data;
	}

	@Override
	public Customer_data getCustomer_dataByCustomerID(String customer_id) {
		// TODO Auto-generated method stub
		Customer_data customer_data=null;
		try {
			Object object=sqlMapClient.queryForObject("customer_data.getCustomer_dataByCustomerID",customer_id);
			customer_data=(Customer_data)object;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return customer_data;
	}

	@Override
	public void delCustomer_dataByCustomerID(String customer_id) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.delete("customer_data.delCustomer_dataByCustomerID", customer_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void updateCustomer_data(Customer_data customer_data) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.update("customer_data.updateCustomer_data", customer_data);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public int getMaxIDByType(int type) {
		// TODO Auto-generated method stub
		try {
			Object object=sqlMapClient.queryForObject("customer_data.getMaxIDByType",type);
			if(object!=null){
				return (Integer)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 0;
	}
	@Override
	public List<Customer_data> getCustomerByCondition(Map map) {
		// TODO Auto-generated method stub
		List<Customer_data> list=null;
		try {
			list=sqlMapClient.queryForList("customer_data.getCustomerByCondition",map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public int getNumByCondition(Map map) {
		// TODO Auto-generated method stub
		int num=0;
		try {
			Object object=sqlMapClient.queryForObject("customer_data.getNumByCondition",map);
			if(object!=null){
				num=(Integer)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return num;
	}
	@Override
	public boolean checkCustomerInSales(String customer_id) {
		// TODO Auto-generated method stub
		try {
			Object object=sqlMapClient.queryForObject("customer_data.checkCustomerInSales",customer_id);
			if(object!=null&&(Integer)object>0){
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	@Override
	public boolean checkCustomerInPurchase(String supplier) {
		// TODO Auto-generated method stub
		try {
			Object object=sqlMapClient.queryForObject("customer_data.checkCustomerInPurchase",supplier);
			if(object!=null&&(Integer)object>0){
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

}
