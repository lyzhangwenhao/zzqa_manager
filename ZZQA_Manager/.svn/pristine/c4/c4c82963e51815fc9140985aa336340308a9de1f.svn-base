package com.zzqa.dao.impl.read_user;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.read_user.IRead_userDAO;
import com.zzqa.pojo.read_user.Read_user;
@Component("read_userDAO")
public class Read_userDAOImpl implements IRead_userDAO {
	private SqlMapClient sqlMapclient;
	
	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}

	@Override
	public Read_user getRead_userByID(int id) {
		// TODO Auto-generated method stub
		Read_user read_user=null;
		try {
			Object object=sqlMapclient.queryForObject("read_user.getRead_userByID",id);
			if(object!=null){
				read_user=(Read_user)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return read_user;
	}

	@Override
	public void insertRead_user(Read_user read_user) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("read_user.insertRead_user",read_user);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delRead_userByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.delete("read_user.delRead_userByID", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void updateRead_userByCondition(Read_user read_user) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("read_user.updateRead_userByCondition",read_user);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public void updateRead_user(Read_user read_user) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("read_user.updateRead_user",read_user);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public void delRead_userByCondition(int type, int foreign_id, int uid) {
		// TODO Auto-generated method stub
		Read_user read_user=new Read_user();
		read_user.setType(type);
		read_user.setForeign_id(foreign_id);
		read_user.setUid(uid);
		try {
			sqlMapclient.delete("read_user.delRead_userByCondition", read_user);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public int getRead_userIDByCondition(int type, int foreign_id, int uid,long update_time) {
		// TODO Auto-generated method stub
		int id=0;
		Read_user read_user=new Read_user();
		read_user.setType(type);
		read_user.setForeign_id(foreign_id);
		read_user.setUid(uid);
		read_user.setUpdate_time(update_time);
		try {
			Object object=sqlMapclient.queryForObject("read_user.getRead_userIDByCondition", read_user);
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
	public long getRead_userTimeByCondition(int type, int foreign_id, int uid) {
		// TODO Auto-generated method stub
		long time=0l;
		Read_user read_user=new Read_user();
		read_user.setType(type);
		read_user.setForeign_id(foreign_id);
		read_user.setUid(uid);
		try {
			Object object=sqlMapclient.queryForObject("read_user.getRead_userTimeByCondition",read_user);
			if(object!=null){
				time=(Long)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return time;
	}

}
