package com.zzqa.dao.impl.product_procurement;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.product_procurement.IProduct_procurementDAO;
import com.zzqa.pojo.outsource_product.Outsource_product;
import com.zzqa.pojo.product_procurement.Product_procurement;
import com.zzqa.pojo.task.Task;
@Component("product_procurementDAO")
public class Product_procurementDAOImpl implements IProduct_procurementDAO {
	SqlMapClient sqlMapclient = null;

	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}

	public void delProduct_procurementByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.delete(
					"product_procurement.delProduct_procurementByID", id);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public int getProduct_procurementCount() {
		// TODO Auto-generated method stub
		int num = 0;
		try {
			Object obj = sqlMapclient
					.queryForObject("product_procurement.getProduct_procurementCount");
			if (obj != null) {
				num = (Integer) obj;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return num;
	}
	public int getNewProduct_procurementByUID(int create_id) {
		// TODO Auto-generated method stub
		int num = 0;
		try {
			Object obj = sqlMapclient
					.queryForObject("product_procurement.getNewProduct_procurementByUID",create_id);
			if (obj != null) {
				num = (Integer) obj;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return num;
	}
	
	public List getProduct_procurementList(Map map) {
		// TODO Auto-generated method stub
		List<Product_procurement> list = null;
		try {
			list = sqlMapclient.queryForList(
					"product_procurement.getProduct_procurementList", map);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public void insertProduct_procurement(
			Product_procurement product_procurement) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert(
					"product_procurement.insertProduct_procurement",
					product_procurement);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void updateProduct_procurement(
			Product_procurement product_procurement) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update(
					"product_procurement.updateProduct_procurement",
					product_procurement);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public Product_procurement getProduct_procurementByID(int id) {
		// TODO Auto-generated method stub
		Product_procurement product_procurement = null;
		try {
			Object obj = sqlMapclient.queryForObject(
					"product_procurement.getProduct_procurementByID", id);
			if (obj != null) {
				product_procurement = (Product_procurement) obj;
			} else {
				product_procurement = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return product_procurement;
	}

	public List getFinishedProduct_procurement() {
		// TODO Auto-generated method stub
		List<Product_procurement> list = null;
		try {
			list = sqlMapclient.queryForList(
					"product_procurement.getFinishedProduct_procurement");

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List getRunningProduct_procurement() {
		// TODO Auto-generated method stub
		List<Product_procurement> list = null;
		try {
			list = sqlMapclient.queryForList(
					"product_procurement.getRunningProduct_procurement");

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	public List getDelayProduct_procurement() {
		// TODO Auto-generated method stub
		List<Product_procurement> list = null;
		try {
			list = sqlMapclient.queryForList(
					"product_procurement.getDelayProduct_procurement");

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	public List getAllList(){
		List list = null;
		try {
            list = sqlMapclient.queryForList("product_procurement.getAllList");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	
}
