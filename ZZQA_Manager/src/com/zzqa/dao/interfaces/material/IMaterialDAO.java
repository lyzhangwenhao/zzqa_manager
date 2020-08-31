package com.zzqa.dao.interfaces.material;

import java.util.List;

import com.zzqa.pojo.material.Material;

public interface IMaterialDAO {
	public void insertMaterial(Material material);
	public void delMaterialByID(int id);
	public void delMaterialByDeviceID(int device_id);
	public List getMaterialList(int device_id);
	public Material getMaterialByID(int id);
	/****
	 * 搜索字段的所有值用于查询
	 * @param type
	 * @return
	 */
	public List getSNByType(int type);
	public List getModelByType(int type);
}
