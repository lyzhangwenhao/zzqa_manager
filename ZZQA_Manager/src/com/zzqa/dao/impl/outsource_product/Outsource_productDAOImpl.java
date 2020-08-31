package com.zzqa.dao.impl.outsource_product;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.outsource_product.IOutsource_productDAO;
import com.zzqa.pojo.outsource_product.Outsource_product;
import com.zzqa.pojo.product_procurement.Product_procurement;
import com.zzqa.pojo.task.Task;
@Component("outsource_productDAO")
public class Outsource_productDAOImpl implements IOutsource_productDAO {
	SqlMapClient sqlMapclient = null;

	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}

	public void delOutsource_productByID(int id) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.delete("outsource_product.delOutsource_productByID", id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public Outsource_product getOutsource_productByID(int id) {
		// TODO Auto-generated method stub
		Outsource_product outsource_product = null;
		try {
			Object obj = sqlMapclient.queryForObject(
					"outsource_product.getOutsource_productByID", id);
			if (obj != null) {
				outsource_product = (Outsource_product) obj;
			} else {
				outsource_product = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return outsource_product;
	}

	public int getOutsource_productCount() {
		// TODO Auto-generated method stub
		int num = 0;
		try {
			Object obj = sqlMapclient.queryForObject("outsource_product.getOutsource_productCount");
			if (obj != null) {
				num = (Integer) obj;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return num;
	}

	public List getOutsource_productList(Map map) {
		// TODO Auto-generated method stub
		List<Outsource_product> list = null;
        try {
            list = sqlMapclient.queryForList("outsource_product.getOutsource_productList",map);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	public List getRunningOutsource_product() {
		// TODO Auto-generated method stub
		List<Outsource_product> list = null;
        try {
            list = sqlMapclient.queryForList("outsource_product.getRunningOutsource_product");

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}

	public void insertOutsource_product(Outsource_product outsource_product) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.insert("outsource_product.insertOutsource_product", outsource_product);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public void updateOutsource_product(Outsource_product outsource_product) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.update("outsource_product.updateOutsource_product", outsource_product);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public int getNewOutsource_productByUID(int uid) {
		// TODO Auto-generated method stub
		int num = 0;
		try {
			Object obj = sqlMapclient.queryForObject("outsource_product.getNewOutsource_productByUID",uid);
			if (obj != null) {
				num = (Integer) obj;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return num;
	}
	public List getAllList(){
		List list = null;
		try {
            list = sqlMapclient.queryForList("outsource_product.getAllList");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
}
