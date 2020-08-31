package com.zzqa.dao.impl.purchase_note;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.purchase_note.IPurchase_noteDAO;
import com.zzqa.pojo.purchase_note.Purchase_note;
@Component("purchase_noteDAO")
public class Purchase_noteDAOImpl implements IPurchase_noteDAO {
	SqlMapClient sqlMapclient = null;

	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}
	@Override
	public void delPurchase_noteByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.delete("purchase_note.delPurchase_noteByID", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void insertPurchase_note(Purchase_note purchase_note) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("purchase_note.insertPurchase_note", purchase_note);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void updatePurchase_note(Purchase_note purchase_note) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("purchase_note.updatePurchase_note", purchase_note);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public Purchase_note getPurchase_noteByID(int id) {
		// TODO Auto-generated method stub
		Purchase_note purchase_note=null;
		try {
			Object object=sqlMapclient.queryForObject("purchase_note.getPurchase_noteByID",id);
			if(object!=null){
				purchase_note=(Purchase_note)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return purchase_note;
	}
	public int getCountByProductID(int product_id,int purchase_id){
		int num=0;
		Map map=new HashedMap();
		map.put("product_id", product_id);
		map.put("purchase_id", purchase_id);
		try {
			Object object=sqlMapclient.queryForObject("purchase_note.getCountByProductID",map);
			if(object!=null){
				num=(Integer)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return num;
	}
	public int getFinishedCountByProductID(int product_id){
		int num=0;
		try {
			Object object=sqlMapclient.queryForObject("purchase_note.getFinishedCountByProductID",product_id);
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
	public List<Integer> getPurchase_noteIDsByPID(int purchase_id) {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("purchase_note.getPurchase_noteIDsByPID",purchase_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public List<Purchase_note> getPurchase_notesByPID(int purchase_id) {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("purchase_note.getPurchase_notesByPID",purchase_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public boolean checkProductInPurchase(int product_id) {
		// TODO Auto-generated method stub
		try {
			Object object=sqlMapclient.queryForObject("purchase_note.checkProductInPurchase",product_id);
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
	public void reSetHasBuyNum(int purchase_id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("purchase_note.reSetHasBuyNum",purchase_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public List<Purchase_note> getPurchase_notesByProductID(int product_id) {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("purchase_note.getPurchase_notesByProductID",product_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public void updateHasbuy_numFromNum(int purchase_id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("purchase_note.updateHasbuy_numFromNum", purchase_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
