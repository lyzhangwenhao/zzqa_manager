package com.zzqa.dao.impl.purchase_contract;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.purchase_contract.IPurchase_contractDAO;
import com.zzqa.pojo.purchase_contract.Purchase_contract;
import com.zzqa.pojo.sales_contract.Sales_contract;
import com.zzqa.pojo.task.Task;
@Component("purchase_contractDAO")
public class Purchase_contractDAOImpl implements IPurchase_contractDAO {
	SqlMapClient sqlMapClient;
	public SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

	@Override
	public void insertPurchase_contract(Purchase_contract purchase_contract) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.insert("purchase_contract.insertPurchase_contract", purchase_contract);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void updatePurchase_contract(Purchase_contract purchase_contract) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.update("purchase_contract.updatePurchase_contract", purchase_contract);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delPurchase_contractByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.delete("purchase_contract.delPurchase_contractByID",id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public Purchase_contract getPurchase_contractByID(int id) {
		// TODO Auto-generated method stub
		Purchase_contract purchase_contract=null;
		try {
			Object object=sqlMapClient.queryForObject("purchase_contract.getPurchase_contractByID",id);
			if(object!=null){
				purchase_contract=(Purchase_contract)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return purchase_contract;
	}
	
	@Override
	public int getNewIDByCreateID(int create_id) {
		// TODO Auto-generated method stub
		int id=0;
		try {
			Object object = sqlMapClient.queryForObject("purchase_contract.getNewIDByCreateID",create_id);
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
	public List getRunningPurchase() {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapClient.queryForList("purchase_contract.getRunningPurchase");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public List getFinishedPurchase(){
		List list=null ;
		try {
			list=sqlMapClient.queryForList("purchase_contract.getFinishedPurchase");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public boolean checkContract_no(String contract_no, int purchase_id) {
		// TODO Auto-generated method stub
		Map map=new HashedMap();
		map.put("contract_no", contract_no);
		map.put("purchase_id", purchase_id);
		try {
			Object object=sqlMapClient.queryForObject("purchase_contract.checkContract_no",map);
			if(object==null||(Integer)object==0){
				return false;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return true;
	}
	public List getAllList(){
		List list = null;
		try {
            list = sqlMapClient.queryForList("purchase_contract.getAllList");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	@Override
	public List<Purchase_contract> getPurchasesByTime(long starttime1,
			long endtime1, long starttime2, long endtime2) {
		// TODO Auto-generated method stub
		Map map=new HashMap();
		map.put("starttime1", starttime1);
		map.put("endtime1", endtime1);
		map.put("starttime2", starttime2);
		map.put("endtime2", endtime2);
		List<Purchase_contract> list=null;
		try {
			list=sqlMapClient.queryForList("purchase_contract.getPurchasesByTime",map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
}
