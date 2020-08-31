package com.zzqa.service.impl.materials_info;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;
import org.springframework.web.context.ContextLoader;

import com.zzqa.dao.impl.materials_info.Materials_infoDAOImpl;
import com.zzqa.dao.interfaces.materials_info.IMaterials_infoDAO;
import com.zzqa.pojo.materials_info.Materials_info;
import com.zzqa.service.interfaces.materials_info.Materials_infoManager;
@Component("materials_infoManager")
public class Materials_infoManagerImpl implements Materials_infoManager {
	@Resource(name="materials_infoDAO")
	private IMaterials_infoDAO materials_infoDAO;

	
	@Override
	public void insertMaterials_info(Materials_info materials_info) {
		// TODO Auto-generated method stub
		materials_infoDAO.insertMaterials_info(materials_info);
	}

	@Override
	public Materials_info getMaterials_infoByID(int id) {
		// TODO Auto-generated method stub
		return materials_infoDAO.getMaterials_infoByID(id);
	}

	@Override
	public void delMaterials_infoByID(int id) {
		// TODO Auto-generated method stub
		materials_infoDAO.delMaterials_infoByID(id);
	}

	@Override
	public void updateMaterials_info(Materials_info materials_info) {
		// TODO Auto-generated method stub
		materials_infoDAO.updateMaterials_info(materials_info);
	}
	@Override
	public List<Materials_info> getMaterials_infosByCondition(String keywords,int nowpage,int pagerow) {
		// TODO Auto-generated method stub
		Map map=new HashMap();
		map.put("keywords",keywords);
		map.put("nowrow",nowpage*pagerow-pagerow);
		map.put("pagerow",pagerow);
		return materials_infoDAO.getMaterials_infosByCondition(map);
	}
	public int getNumByCondition(String keywords){
		Map map=new HashMap();
		map.put("keywords",keywords);
		return materials_infoDAO.getNumByCondition(map);
	}
	@Override
	public List<Materials_info> getMaterials_infos() {
		// TODO Auto-generated method stub
		return materials_infoDAO.getMaterials_infos();
	}
	@Override
	public Materials_info getMaterials_infoByModel(String model) {
		// TODO Auto-generated method stub
		return materials_infoDAO.getMaterials_infoByModel(model);
	}

}
