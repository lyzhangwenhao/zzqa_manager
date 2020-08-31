package com.zzqa.dao.impl.permissions;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.permissions.IPermissionsDAO;
import com.zzqa.pojo.permissions.Permissions;
@Component("permissionsDAO")
public class PermissionsDAOImpl implements IPermissionsDAO {
	SqlMapClient sqlMapclient = null;

	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}
	
	public void insertPermissions(Permissions permissions){
		try {
			sqlMapclient.insert("permissions.insertPermissions", permissions);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void updatePermissions(Permissions permissions){
		try {
			sqlMapclient.insert("permissions.updatePermissions", permissions);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void delPermissionsByID(int id){
		try {
			sqlMapclient.delete("permissions.delPermissionsByID", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public List getPermissionsByPositionID(int position_id){
		List list=null;
		try {
			list=sqlMapclient.queryForList("permissions.getPermissionsByPositionID",position_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public List getPIDsByPositionID(int position_id){
		List list=null;
		try {
			list=sqlMapclient.queryForList("permissions.getPIDsByPositionID",position_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public void delPermissionsByPositionID(int position_id){
		try {
			sqlMapclient.delete("permissions.delPermissionsByPositionID", position_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public boolean checkPermission(int position_id, int permissions_id) {
		// TODO Auto-generated method stub
		boolean flag=false;
		try {
			Map map=new HashMap<String, Integer>();
			map.put("position_id", position_id);
			map.put("permissions_id", permissions_id);
			Object obj=sqlMapclient.queryForObject("permissions.checkPermission", map);
			if(obj!=null&&(Integer)obj>0){
				flag=true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return flag;
	}
	public boolean checkPermissionOrSon(int uid, int permissions_id) {
		// TODO Auto-generated method stub
		boolean flag=false;
		try {
			Map map=new HashMap<String, Integer>();
			map.put("uid", uid);
			map.put("permissions_id", permissions_id);
			Object obj=sqlMapclient.queryForObject("permissions.checkPermissionOrSon", map);
			if(obj!=null&&(Integer)obj>0){
				flag=true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return flag;
	}
}
