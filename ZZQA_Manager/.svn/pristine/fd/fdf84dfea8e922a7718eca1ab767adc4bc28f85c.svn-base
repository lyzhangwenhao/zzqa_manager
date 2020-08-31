package com.zzqa.dao.impl.work_day;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.work_day.IWork_dayDAO;
import com.zzqa.pojo.work_day.Work_day;
@Component("work_dayDAO")
public class Work_dayDAOImpl implements IWork_dayDAO {
	private SqlMapClient sqlMapClient;
	public SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

	@Override
	public void insertWork_day(Work_day work_day) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.insert("work_day.insertWork_day",work_day);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public Work_day getWork_dayByID(int id) {
		// TODO Auto-generated method stub
		Work_day work_day=null;
		try {
			Object object=sqlMapClient.queryForObject("work_day.getWork_dayByID",id);
			if(object!=null){
				work_day=(Work_day)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return work_day;
	}

	@Override
	public void updateWork_day(Work_day work_day) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.update("work_day.updateWork_day",work_day);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delWork_dayByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.delete("work_day.delWork_dayByID", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public List<Work_day> getWork_daysByWID(int word_id) {
		// TODO Auto-generated method stub
		List<Work_day> list=null;
		try {
			list=sqlMapClient.queryForList("work_day.getWork_daysByWID", word_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public Work_day getWork_dayByWIDAndWD(int work_id, int workday) {
		// TODO Auto-generated method stub
		Work_day work_day=null;
		Work_day work_day2=new Work_day();
		work_day2.setWork_id(work_id);
		work_day2.setWorkday(workday);
		try {
			Object object=sqlMapClient.queryForObject("work_day.getWork_dayByWIDAndWD",work_day2);
			if(object!=null){
				work_day=(Work_day)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return work_day;
	}
	public void updateStatus(int id,int status){
		Work_day work_day=new Work_day();
		work_day.setId(id);
		work_day.setStatus(status);
		try {
			sqlMapClient.update("work_day.updateStatus", work_day);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
