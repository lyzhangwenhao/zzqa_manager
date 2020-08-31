package com.zzqa.dao.impl.product_info;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.product_info.IProduct_infoDAO;
import com.zzqa.pojo.product_info.Product_info;
@Component("product_infoDAO")
public class Product_infoDAOImpl implements IProduct_infoDAO {
	SqlMapClient sqlMapclient = null;
	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}

	@Override
	public Product_info getProduct_infoByID(int id) {
		// TODO Auto-generated method stub
		Product_info product_info=null;
		try {
			Object object=sqlMapclient.queryForObject("product_info.getProduct_infoByID",id);
			if(object!=null){
				product_info=(Product_info)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return product_info;
	}

	@Override
	public void updateProduct_info(Product_info product_info) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("product_info.updateProduct_info", product_info);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public void insertProduct_info(Product_info product_info) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("product_info.insertProduct_info", product_info);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public void delAProduct_infoByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.delete("product_info.delProduct_infoByID", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public List<Product_info> getProduct_infos(int sales_id) {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("product_info.getProduct_infos",sales_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
}
