package com.zzqa.dao.impl.material;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.material.IMaterialDAO;
import com.zzqa.pojo.device.Device;
import com.zzqa.pojo.material.Material;
import com.zzqa.pojo.operation.Operation;
@Component("materialDAO")
public class MaterialDAOImpl implements IMaterialDAO {
	SqlMapClient sqlMapclient = null;

	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}

	public void delMaterialByDeviceID(int device_id) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.delete("material.delMaterialByDeviceID", device_id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public void delMaterialByID(int id) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.delete("material.delMaterialByID", id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public Material getMaterialByID(int id) {
		// TODO Auto-generated method stub
		Material material = null;
		try {
			Object obj = sqlMapclient.queryForObject(
					"material.getMaterialByID", id);
			if (obj != null) {
				material = (Material) obj;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return material;
	}

	public List getMaterialList(int device_id) {
		// TODO Auto-generated method stub
		List<Material> list = null;
		try {
			list = sqlMapclient.queryForList("material.getMaterialList", device_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public void insertMaterial(Material material) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.insert("material.insertMaterial", material);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}
	
	public List getSNByType(int type){
		List<String> list=null;
		try {
			list=sqlMapclient.queryForList("material.getSNByType", type);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	public List getModelByType(int type){
		List<String> list=null;
		try {
			list=sqlMapclient.queryForList("material.getModelByType", type);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
}
