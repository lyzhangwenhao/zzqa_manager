package com.zzqa.dao.impl.task_updateflow;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.task_updateflow.ITask_updateflowDAO;
import com.zzqa.pojo.task_updateflow.Task_updateflow;

@Component("task_updateflowDAO")
public class Task_updateflowDAOImpl implements ITask_updateflowDAO{

	SqlMapClient sqlMapclient = null;

	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}
	@Override
	public int insertTask_updateflow(Task_updateflow task_updateflow) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("task_updateflow.insertTask_updateflow", task_updateflow);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return task_updateflow.getId();
	}
	@Override
	public Task_updateflow getTask_updateflowById(int id) {
		// TODO Auto-generated method stub
		Task_updateflow task_updateflow=null;
		try {
			Object obj=sqlMapclient.queryForObject("task_updateflow.getTask_updateflowById",id);
			if(obj!=null){
				task_updateflow=(Task_updateflow)obj;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return task_updateflow;
	}
	@Override
	public List<Task_updateflow> getRunningTask_updateflow() {
		// TODO Auto-generated method stub
		List<Task_updateflow> list = null;
		try {
            list = sqlMapclient.queryForList("task_updateflow.getRunningTask_updateflow");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	@Override
	public List<Task_updateflow> getAllList() {
		// TODO Auto-generated method stub
		List<Task_updateflow> list = null;
		try {
            list = sqlMapclient.queryForList("task_updateflow.getAllList");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	@Override
	public Task_updateflow getTask_updateflowByTaskId(int forignId) {
		// TODO Auto-generated method stub
		Task_updateflow task_updateflow=null;
		try {
			Object obj=sqlMapclient.queryForObject("task_updateflow.getTask_updateflowByTaskId",forignId);
			if(obj!=null){
				task_updateflow=(Task_updateflow)obj;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return task_updateflow;
	}
	@Override
	public void updateTask_updateflowCount(int task_id) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.update("task_updateflow.updateTask_updateflowCount", task_id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

}
