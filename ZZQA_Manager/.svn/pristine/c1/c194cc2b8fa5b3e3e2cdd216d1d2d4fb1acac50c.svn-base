package com.zzqa.dao.impl.departPuchase_content;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.departePuchase_content.IDepartPuchaseContentDao;
import com.zzqa.pojo.departePuchase_content.DepartePuchase_content;

@Component("departPuchaseContentDao")
public class DepartPuchaseContentDaoImpl implements IDepartPuchaseContentDao {
	SqlMapClient sqlMapclient = null;

	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}
	@Override
	public void delDepartPuchaseContent(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.delete("departPuchase_content.delDepartPuchaseContent",id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Override
	public void updateDepartPuchaseContent(
			DepartePuchase_content departePuchase_content) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("departPuchase_content.updateDepartPuchaseContent",departePuchase_content);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void insertDepartPuchaseContent(
			DepartePuchase_content departePuchase_content) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("departPuchase_content.insertDepartPuchaseContent",departePuchase_content);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<DepartePuchase_content> getItemsByDid(int departePuchase_id) {
		// TODO Auto-generated method stub
		List<DepartePuchase_content> list=null;
		try {
			list=sqlMapclient.queryForList("departPuchase_content.getItemsByDid",departePuchase_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public void updateDepartPuchaseContentTime(
			DepartePuchase_content departePuchase_content) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("departPuchase_content.updateDepartPuchaseContentTime",departePuchase_content);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
