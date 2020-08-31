package com.zzqa.dao.interfaces.materials_info;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.materials_info.Materials_info;

public interface IMaterials_infoDAO {
	public void insertMaterials_info(Materials_info materials_info);
	public Materials_info getMaterials_infoByModel(String model);
	public Materials_info getMaterials_infoByID(int id);
	public void delMaterials_infoByID(int id);
	public void updateMaterials_info(Materials_info materials_info);
	/****
	 *  
	 * @param map
	 * @return
	 */
	public List<Materials_info> getMaterials_infosByCondition(Map map);
	public int getNumByCondition(Map map);
	public List<Materials_info> getMaterials_infos();
	/****
	 * 检查该物料是否被绑定
	 * @param m_id 物料表id
	 * @return
	 */
	public boolean checkUseMaterials(int m_id);
}
