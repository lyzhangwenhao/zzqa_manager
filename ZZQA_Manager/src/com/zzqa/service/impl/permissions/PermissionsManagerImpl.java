package com.zzqa.service.impl.permissions;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.permissions.IPermissionsDAO;
import com.zzqa.pojo.permissions.Permissions;
import com.zzqa.service.interfaces.permissions.PermissionsManager;
@Component("permissionsManager")
public class PermissionsManagerImpl implements PermissionsManager{
	@Autowired
	private IPermissionsDAO permissionsDAO;

	@Override
	public void insertPermissions(Permissions permissions) {
		// TODO Auto-generated method stub
		permissionsDAO.insertPermissions(permissions);
	}

	@Override
	public void updatePermissions(Permissions permissions) {
		// TODO Auto-generated method stub
		permissionsDAO.updatePermissions(permissions);
	}

	@Override
	public void delPermissionsByID(int id) {
		// TODO Auto-generated method stub
		permissionsDAO.delPermissionsByID(id);
	}

	@Override
	public List getPermissionsByPositionID(int position_id) {
		// TODO Auto-generated method stub
		return permissionsDAO.getPermissionsByPositionID(position_id);
	}

	@Override
	public void delPermissionsByPositionID(int position_id) {
		// TODO Auto-generated method stub
		permissionsDAO.delPermissionsByPositionID(position_id);
	}

	@Override
	public Map getPermissionsMapByPositionID(int position_id) {
		// TODO Auto-generated method stub
		List<Permissions> list=permissionsDAO.getPermissionsByPositionID(position_id);
		Map<Integer, String> map=new HashMap<Integer, String>();
		for(Permissions permissions:list){
			map.put(permissions.getPermissions_id(), "");//value不为空表示该职位有该权限
		}
		return map;
	}

	@Override
	public boolean checkPermission(int position_id, int permissions_id) {
		// TODO Auto-generated method stub
		return permissionsDAO.checkPermission(position_id, permissions_id);
	}
	
	@Override
	public boolean checkPermissionOrSon(int uid, int permissions_id) {
		// TODO Auto-generated method stub
		return permissionsDAO.checkPermissionOrSon(uid, permissions_id);
	}
}
