package com.zzqa.dao.impl.notify;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.notify.INotifyDAO;
import com.zzqa.pojo.notify.Notify;
@Component("notifyDAO")
public class NotifyDAOImpl implements INotifyDAO {
	SqlMapClient sqlMapclient = null;
	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")  
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}

	@Override
	public Notify getNotifyByID(int id) {
		// TODO Auto-generated method stub
		Notify notify=null;
		try {
			Object object=sqlMapclient.queryForObject("notify.getNotifyByID", id);
			if(object!=null){
				notify=(Notify)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return notify;
	}

	@Override
	public void insertNotify(Notify notify) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("notify.insertNotify", notify);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delNotifyByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.delete("notify.delNotifyByID", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void updateNotify(Notify notify) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("notify.updateNotify", notify);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public List getNotifyListByCreateID(Map map) {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("notify.getNotifyListByCreateID",map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public int getNewNotifyIDByCreateID(int create_id) {
		// TODO Auto-generated method stub
		int id=0;
			try {
				Object object= sqlMapclient.queryForObject("notify.getNewNotifyIDByCreateID", create_id);
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
	public List getNotifyListByYear(Map map) {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("notify.getNotifyListByYear", map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public List getNotReadReplyNotifyList(Map map) {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("notify.getNotReadReplyNotifyList", map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
}
