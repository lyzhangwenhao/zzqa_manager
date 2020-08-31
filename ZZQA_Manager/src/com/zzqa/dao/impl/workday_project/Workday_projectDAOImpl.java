package com.zzqa.dao.impl.workday_project;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.workday_project.IWorkday_projectDAO;
import com.zzqa.pojo.workday_project.Workday_project;
@Component("workday_projectDAO")
public class Workday_projectDAOImpl implements IWorkday_projectDAO {
	private SqlMapClient sqlMapClient;
	public SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

	@Override
	public void insertWorkday_project(Workday_project workday_project) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.insert("workday_project.insertWorkday_project", workday_project);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public Workday_project getWorkday_projectByID(int id) {
		// TODO Auto-generated method stub
		Workday_project workday_project=null;
		try {
			Object object=sqlMapClient.queryForObject("workday_project.getWorkday_projectByID",id);
			if(object!=null){
				workday_project=(Workday_project)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return workday_project;
	}

	@Override
	public void updateWorkday_project(Workday_project workday_project) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.update("workday_project.updateWorkday_project", workday_project);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delWorkday_projectByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.delete("workday_project.delWorkday_projectByID", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public List<Workday_project> getWorkday_projectsByWDID(int workday_id) {
		// TODO Auto-generated method stub
		List<Workday_project> list=null;
		try {
			list=sqlMapClient.queryForList("workday_project.getWorkday_projectsByWDID",workday_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public void delWorkday_projectByWDID(int workday_id) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.delete("workday_project.delWorkday_projectByWDID", workday_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public boolean checkProjectBind(int project_id) {
		// TODO Auto-generated method stub
		try {
			Object object=sqlMapClient.queryForObject("workday_project.checkProjectBind",project_id);
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
