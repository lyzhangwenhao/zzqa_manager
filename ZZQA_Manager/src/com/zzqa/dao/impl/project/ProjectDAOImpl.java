package com.zzqa.dao.impl.project;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.project.IProjectDAO;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.project.Project;
import com.zzqa.pojo.project_procurement.Project_procurement;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.project_procurement.Project_procurementManager;
@Component("projectDAO")
public class ProjectDAOImpl implements IProjectDAO {
	private SqlMapClient sqlMapClient; 
	public SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}
	@Override
	public void insertProject(Project project) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.insert("project.insertProject", project);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public Project getProjectByID(int id) {
		// TODO Auto-generated method stub
		Project project=null;
		try {
			Object object=sqlMapClient.queryForObject("project.getProjectByID",id);
			if(object!=null){
				project=(Project)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return project;
	}
	@Override
	public void updateProject(Project project) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.update("project.updateProject", project);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public void delProjectByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.delete("project.delProjectByID", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public List<Project> getProjects() {
		// TODO Auto-generated method stub
		List<Project> list=null;
		try {
			list=sqlMapClient.queryForList("project.getProjects");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public int getNewProject() {
		// TODO Auto-generated method stub
		int id=0;
		try {
			Object object=sqlMapClient.queryForObject("project.getNewProject");
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
	public boolean checkProjectByPName(String project_name,int id) {
		// TODO Auto-generated method stub
		try {
			Object object=sqlMapClient.queryForObject("project.checkProjectByPName",project_name);
			if(object!=null&&(Integer)object!=id){
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

}
