package com.zzqa.dao.impl.seal;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.seal.ISealDAO;
import com.zzqa.pojo.seal.Seal;
import com.zzqa.pojo.task.Task;
@Component("sealDAO")
public class SealDAOImpl implements ISealDAO {
	private SqlMapClient sqlMapClient;
	public SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

	@Override
	public void insertSeal(Seal seal) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.insert("seal.insertSeal", seal);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void updateSeal(Seal seal) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.update("seal.updateSeal", seal);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public Seal getSealByID(int id) {
		// TODO Auto-generated method stub
		Seal seal=null;
		try {
			Object object=sqlMapClient.queryForObject("seal.getSealByID",id);
			if(object!=null){
				seal=(Seal)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return seal;
	}
	
	@Override
	public void delSealByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.delete("seal.delSealByID",id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public int getNewSealIDByCreateID(int create_id) {
		// TODO Auto-generated method stub
		int id=0;
		try {
			Object object=sqlMapClient.queryForObject("seal.getNewSealIDByCreateID",create_id);
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
	public List getRunningSeal() {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapClient.queryForList("seal.getRunningSeal");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public List getAllList(){
		List list = null;
		try {
            list = sqlMapClient.queryForList("seal.getAllList");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}

}
