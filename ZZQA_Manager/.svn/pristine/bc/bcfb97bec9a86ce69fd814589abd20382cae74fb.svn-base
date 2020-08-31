package com.zzqa.dao.impl.project_procurement;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.project_procurement.IProject_procurementDAO;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.linkman.Linkman;
import com.zzqa.pojo.product_procurement.Product_procurement;
import com.zzqa.pojo.project_procurement.Project_procurement;
import com.zzqa.pojo.task.Task;
@Component("project_procurementDAO")
public class Project_procurementDAOImpl implements IProject_procurementDAO{
	SqlMapClient sqlMapclient = null;

	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}

	public void delProject_procurementByID(int id) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.delete("project_procurement.delProject_procurementByID", id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public Project_procurement getProject_procurementByID(int id) {
		// TODO Auto-generated method stub
		Project_procurement project_procurement=null;
		 try {
	        	Object obj=sqlMapclient.queryForObject("project_procurement.getProject_procurementByID", id);
	        	if(obj!=null){
	        		project_procurement=(Project_procurement)obj;
	        	}else{
	        		project_procurement=null;
	        	}
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return project_procurement;
	}

	public int getProject_procurementCount() {
		// TODO Auto-generated method stub
		int num = 0;
		try {
			Object obj = sqlMapclient.queryForObject("project_procurement.getProject_procurementCount");
			if (obj != null) {
				num = (Integer) obj;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return num;
	}

	public List getProject_procurementList(Map map) {
		// TODO Auto-generated method stub
		List<Project_procurement> list = null;
        try {
            list = sqlMapclient.queryForList("project_procurement.getProject_procurementList",map);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	public List getRunningProject_procurement() {
		// TODO Auto-generated method stub
		List<Project_procurement> list = null;
        try {
            list = sqlMapclient.queryForList("project_procurement.getRunningProject_procurement");

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	
	public List getAllApplyedProjectList(int create_id) {
		// TODO Auto-generated method stub
		List<Product_procurement> list = null;
		try {
			list = sqlMapclient.queryForList(
					"project_procurement.getAllApplyedProjectList",create_id);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public void insertProject_procurement(
			Project_procurement project_procurement) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.insert("project_procurement.insertProject_procurement", project_procurement);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public void updateProject_procurement(
			Project_procurement project_procurement) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.update("project_procurement.updateProject_procurement", project_procurement);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public int getNewProject_procurementByUID(int create_id) {
		// TODO Auto-generated method stub
		int num = 0;
		try {
			Object obj = sqlMapclient
					.queryForObject("project_procurement.getNewProject_procurementByUID",create_id);
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
            list = sqlMapclient.queryForList("project_procurement.getAllList");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	@Override
	public List<Project_procurement> getProject_procurementListByTaskID(int task_id) {
		// TODO Auto-generated method stub
		List<Project_procurement> list = null;
        try {
            list = sqlMapclient.queryForList("project_procurement.getProject_procurementListByTaskID",task_id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
}
