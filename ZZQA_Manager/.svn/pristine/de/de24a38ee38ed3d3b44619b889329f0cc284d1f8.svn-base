package com.zzqa.service.impl.material;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.manufacture.IManufactureDAO;
import com.zzqa.dao.interfaces.material.IMaterialDAO;
import com.zzqa.pojo.manufacture.Manufacture;
import com.zzqa.pojo.material.Material;
import com.zzqa.service.interfaces.manufacture.ManufactureManager;
import com.zzqa.service.interfaces.material.MaterialManager;
@Component("materialManager")
public class MaterialManagerImpl implements MaterialManager {
	@Resource(name="materialDAO")
	private IMaterialDAO materialDAO;

	public void delMaterialByDeviceID(int device_id) {
		// TODO Auto-generated method stub
		materialDAO.delMaterialByDeviceID(device_id);
	}

	public void delMaterialByID(int id) {
		// TODO Auto-generated method stub
		materialDAO.delMaterialByID(id);
	}

	public Material getMaterialByID(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	public List getMaterialList(int device_id) {
		// TODO Auto-generated method stub
		return materialDAO.getMaterialList(device_id);
	}

	public void insertMaterial(Material material) {
		// TODO Auto-generated method stub
		materialDAO.insertMaterial(material);
	}

	

}
