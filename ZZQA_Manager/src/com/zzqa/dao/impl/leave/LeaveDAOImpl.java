package com.zzqa.dao.impl.leave;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.leave.ILeaveDAO;
import com.zzqa.pojo.leave.Leave;
import com.zzqa.pojo.task.Task;
@Component("leaveDAO")
public class LeaveDAOImpl implements ILeaveDAO {
	SqlMapClient sqlMapclient = null;
	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}
	@Override
	public void insertLeave(Leave leave) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("leave.insertLeave", leave);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void updateLeave(Leave leave) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("leave.updateLeave", leave);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public Leave getLeaveByID(int id) {
		// TODO Auto-generated method stub
		Leave leave=null;
		try {
			Object obj=sqlMapclient.queryForObject("leave.getLeaveByID", id);
			leave=(Leave)obj;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return leave;
	}

	@Override
	public List getAllLeaveList() {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("leave.getAllLeaveList");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public List getRunningLeave() {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("leave.getRunningLeave");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List getLeaveListAfterApproval(int create_id) {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("leave.getLeaveListAfterApproval",create_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public List getLeaveListReport(Map map) {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("leave.getLeaveListReport",map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public List checkLeaveInScope(Map map) {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("leave.checkLeaveInScope",map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public List getAllList(){
		List list = null;
		try {
            list = sqlMapclient.queryForList("leave.getAllList");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
}
