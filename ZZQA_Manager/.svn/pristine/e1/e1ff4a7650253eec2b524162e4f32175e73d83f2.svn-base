package com.zzqa.dao.interfaces.permissions;

import java.util.List;

import com.zzqa.pojo.permissions.Permissions;

public interface IPermissionsDAO {
	public void insertPermissions(Permissions permissions);
	public void updatePermissions(Permissions permissions);
	/****
	 * 删除权限
	 * @param id
	 */
	public void delPermissionsByID(int id);
	/****
	 * 获取职位关联的所有权限
	 * @param position_id
	 * @return
	 */
	public List getPermissionsByPositionID(int position_id);
	public List getPIDsByPositionID(int position_id);
	/***
	 * 删除职位的所有权限
	 * @param position_id
	 */
	public void delPermissionsByPositionID(int position_id);
	/******
	 * 检查职位是否有指定属性
	 * @param position_id
	 * @param permission_id
	 * @return
	 */
	public boolean checkPermission(int position_id,int permissions_id);
	public boolean checkPermissionOrSon(int uid, int permissions_id);
}
