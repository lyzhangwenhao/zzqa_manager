package com.zzqa.dao.impl.aftersales_task;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.aftersales_task.IAftersales_taskDAO;
import com.zzqa.pojo.aftersales_task.Aftersales_task;
import com.zzqa.pojo.task.Task;
@Component("aftersales_taskDAO")
public class Aftersales_taskDAOImpl implements IAftersales_taskDAO {
	SqlMapClient sqlMapclient = null;
	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}

	@Override
	public void insertAlterSales_Task(Aftersales_task aftersales_task) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("aftersales_task.insertAlterSales_Task", aftersales_task);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void updateAlterSales_Task(Aftersales_task aftersales_task) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("aftersales_task.updateAlterSales_Task", aftersales_task);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public Aftersales_task getAlterSales_TaskByID(int id) {
		// TODO Auto-generated method stub
		Aftersales_task aftersales_task=null;
		try {
			Object object=sqlMapclient.queryForObject("aftersales_task.getAlterSales_TaskByID",id);
			if(object!=null){
				aftersales_task=(Aftersales_task)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return aftersales_task;
	}
	
	@Override
	public void delAlterSales_TaskByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.delete("aftersales_task.delAlterSales_TaskByID", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public int getNewAlterSales_TaskIDByCreateID(int create_id) {
		// TODO Auto-generated method stub
		int id=0;
		try {
			Object object=sqlMapclient.queryForObject("aftersales_task.getNewAlterSales_TaskIDByCreateID", create_id);
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
	public List getRunningAlterSales_Task() {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("aftersales_task.getRunningAlterSales_Task");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public List getAllList(){
		List list = null;
		try {
            list = sqlMapclient.queryForList("aftersales_task.getAllList");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
}
