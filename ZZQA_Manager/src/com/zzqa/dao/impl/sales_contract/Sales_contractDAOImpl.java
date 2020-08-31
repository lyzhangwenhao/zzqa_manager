package com.zzqa.dao.impl.sales_contract;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.sales_contract.ISales_contractDAO;
import com.zzqa.pojo.sales_contract.Sales_contract;
import com.zzqa.pojo.task.Task;
@Component("sales_contractDAO")
public class Sales_contractDAOImpl implements ISales_contractDAO {
	SqlMapClient sqlMapClient=null;
	public SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

	@Override
	public void insertSales_contract(Sales_contract sales_contract) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.insert("sales_contract.insertSales_contract", sales_contract);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void updateSales_contract(Sales_contract sales_contract) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.update("sales_contract.updateSales_contract", sales_contract);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delSales_contractByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.delete("sales_contract.delSales_contractByID", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public Sales_contract getSales_contractByID(int id) {
		// TODO Auto-generated method stub
		Sales_contract sales_contract=null;
		try {
			Object object=sqlMapClient.queryForObject("sales_contract.getSales_contractByID",id);
			if(object!=null){
				sales_contract=(Sales_contract)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return sales_contract;
	}
	
	@Override
	public int getNewSalesIDByCreateID(int create_id) {
		// TODO Auto-generated method stub
		int id=0;
		try {
			Object object=sqlMapClient.queryForObject("sales_contract.getNewSalesIDByCreateID",create_id);
			if(object!=null){
			id=(Integer)object;	
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return id;
	}
	@Override
	public List getRunningSales() {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapClient.queryForList("sales_contract.getRunningSales");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public List getConmany_name1s() {
		List<String> list=null ;
		try {
			list=sqlMapClient.queryForList("sales_contract.getConmany_name1s");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	public List getFinishedSales(){
		List list=null ;
		try {
			list=sqlMapClient.queryForList("sales_contract.getFinishedSales");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public boolean checkContract_no(String contract_no, int sales_id) {
		// TODO Auto-generated method stub
		Map map=new HashedMap();
		map.put("contract_no", contract_no);
		map.put("sales_id", sales_id);
		try {
			Object object=sqlMapClient.queryForObject("sales_contract.checkContract_no",map);
			if(object==null||(Integer)object==0){
				return false;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return true;
	}
	@Override
	public List<Sales_contract> getSalesByTime(long starttime1, long endtime1,long starttime2, long endtime2) {
		// TODO Auto-generated method stub
		Map map=new HashMap();
		map.put("starttime1", starttime1);
		map.put("endtime1", endtime1);
		map.put("starttime2", starttime2);
		map.put("endtime2", endtime2);
		List<Sales_contract> list=null;
		try {
			list=sqlMapClient.queryForList("sales_contract.getSalesByTime",map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public List getAllList(){
		List list = null;
		try {
            list = sqlMapClient.queryForList("sales_contract.getAllList");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
}
