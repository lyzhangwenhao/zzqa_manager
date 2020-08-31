package com.zzqa.dao.impl.task_conflict;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.task_conflict.ITask_conflictDAO;
import com.zzqa.pojo.task_conflict.Task_conflict;
@Component("task_conflictDAO")
public class Task_conflictDAOImpl implements ITask_conflictDAO {
	SqlMapClient sqlMapclient = null;

	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}

	public boolean checkTask_conflict(int task_id) {
		// TODO Auto-generated method stub
		List<Task_conflict> list = null;
        try {
            list = sqlMapclient.queryForList("task_conflict.checkTask_conflict", task_id);
            if (list.size() < 1) {
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return true;
	}

	public void delTask_conflictByID(int task_id) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.delete("task_conflict.delTask_conflictByID", task_id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public Task_conflict getTask_conflictByTaskID(int task_id) {
		// TODO Auto-generated method stub
		Task_conflict task_conflict=null;
		try {
			Object obj = sqlMapclient.queryForObject("task_conflict.getTask_conflictByTaskID", task_id);
			if (obj != null) {
				task_conflict = (Task_conflict) obj;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return task_conflict;
	}

	public void insertTask_conflict(Task_conflict task_conflict) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.insert("task_conflict.insertTask_conflict", task_conflict);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public void updateTask_conflict(Task_conflict task_conflict) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.update("task_conflict.updateTask_conflict", task_conflict);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}
}	
