package com.zzqa.dao.impl.related_user;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.related_user.IRelated_userDAO;
import com.zzqa.pojo.related_user.Related_user;
@Component("related_userDAO")
public class Related_userDAOImpl implements IRelated_userDAO {
	SqlMapClient sqlMapclient = null;
	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")  
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}

	@Override
	public Related_user getRelated_userByID(int id) {
		// TODO Auto-generated method stub
		Related_user related_user=null;
		try {
			Object object=sqlMapclient.queryForObject("related_user.getRelated_userByID",id);
			if(object!=null){
				related_user=(Related_user)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return related_user;
	}

	@Override
	public void insertRelated_user(Related_user related_user) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("related_user.insertRelated_user", related_user);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delRelated_userByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.delete("related_user.delRelated_userByID", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public List getRelated_userListByCondition(int type, int foreign_id) {
		// TODO Auto-generated method stub
		List list=null;
		Related_user related_user=new Related_user();
		related_user.setType(type);
		related_user.setForeign_id(foreign_id);
		try {
			list=sqlMapclient.queryForList("related_user.getRelated_userListByCondition",related_user);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void delRelated_userByCondition(int type, int foreign_id, int uid) {
		// TODO Auto-generated method stub
		Related_user related_user=new Related_user();
		related_user.setType(type);
		related_user.setForeign_id(foreign_id);
		related_user.setUid(uid);
		try {
			sqlMapclient.delete("related_user.delRelated_userByCondition", related_user);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public int getRelated_userCount(int type, int foreign_id, int uid) {
		// TODO Auto-generated method stub
		Related_user related_user=new Related_user();
		related_user.setUid(uid);
		related_user.setType(type);
		related_user.setForeign_id(foreign_id);
		int num=0;
		try {
			Object object=sqlMapclient.queryForObject("related_user.getRelated_userCount", related_user);
			num=(Integer)object;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return num;
	}

}
