package com.zzqa.service.interfaces.materials_info;

import java.util.List;

import com.zzqa.pojo.materials_info.Materials_info;

public interface Materials_infoManager {
	public void insertMaterials_info(Materials_info materials_info);
	public List<Materials_info> getMaterials_infosByCondition(String keywords,int nowpage,int pagerow);
	public int getNumByCondition(String keywords);
	public Materials_info getMaterials_infoByID(int id);
	public Materials_info getMaterials_infoByModel(String model);
	public void delMaterials_infoByID(int id);
	public void updateMaterials_info(Materials_info materials_info);
	public List<Materials_info> getMaterials_infos();
}
