package com.zzqa.dao.impl.work;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.work.IWorkDAO;
import com.zzqa.pojo.task.Task;
import com.zzqa.pojo.work.Work;
@Component("workDAO")
public class WorkDAOImpl implements IWorkDAO {
	private SqlMapClient sqlMapClient;
	public SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

	@Override
	public void insertWork(Work work) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.insert("work.insertWork", work);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public Work getWorkByID(int id) {
		// TODO Auto-generated method stub
		Work work=null;
		try {
			Object object=sqlMapClient.queryForObject("work.getWorkByID", id);
			if(object!=null){
				work=(Work)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return work;
	}

	@Override
	public void updateWork(Work work) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.update("work.updateWork",work);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delWorkByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.delete("work.delWorkByID",id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public int getNewWorkByUID(int create_id) {
		// TODO Auto-generated method stub
		int id=0;
		try {
			Object object=sqlMapClient.queryForObject("work.getNewWorkByUID",create_id);
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
	public List getRunningWork() {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapClient.queryForList("work.getRunningWork");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public Work getWorkByMonthAndUID(long month, int create_id) {
		// TODO Auto-generated method stub
		Work work=new Work();
		work.setWorkmonth(month);
		work.setCreate_id(create_id);
		Work work2=null;
		try {
			Object object=sqlMapClient.queryForObject("work.getWorkByMonthAndUID", work);
			if(object!=null){
				work2=(Work)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return work2;
	}
	@Override
	public List<Work> getWorkByMonths(long starttime,long endtime) {
		// TODO Auto-generated method stub
		List list=null;
		Map map=new HashMap();
		map.put("starttime", starttime);
		map.put("endtime", endtime);
		try {
			list=sqlMapClient.queryForList("work.getWorkByMonths", map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public List getAllUserWidthWork() {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapClient.queryForList("work.getAllUserWidthWork");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public boolean checkNumByLeaderId(int uid) {
		// TODO Auto-generated method stub
		int num=0;
		try {
			Object object=sqlMapClient.queryForObject("work.checkNumByLeaderId",uid);
			if(object!=null){
				num=(Integer)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return num>0;
	}
	public List getAllList(){
		List list = null;
		try {
            list = sqlMapClient.queryForList("work.getAllList");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
	@Override
	public Map getWorkdaysReport(Map map) {
		// TODO Auto-generated method stub
		Map data=null;
		try {
			data=sqlMapClient.queryForMap("work.getWorkdaysReport", map, "uid_pid","hours");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return data;
	}
}
