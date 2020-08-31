package com.zzqa.dao.impl.materials_info;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.materials_info.IMaterials_infoDAO;
import com.zzqa.pojo.materials_info.Materials_info;
import com.zzqa.service.interfaces.materials_info.Materials_infoManager;
@Component("materials_infoDAO")
public class Materials_infoDAOImpl implements IMaterials_infoDAO {
	SqlMapClient sqlMapClient = null;

	public SqlMapClient getSqlMapclient() {
		return sqlMapClient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}
	@Override
	public void insertMaterials_info(Materials_info materials_info) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.insert("materials_info.insertMaterials_info", materials_info);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public Materials_info getMaterials_infoByID(int id) {
		// TODO Auto-generated method stub
		Materials_info materials_info=null;
		try {
			Object object = sqlMapClient.queryForObject("materials_info.getMaterials_infoByID", id);
			if(object!=null){
				materials_info=(Materials_info)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return materials_info;
	}
	@Override
	public Materials_info getMaterials_infoByModel(String model) {
		// TODO Auto-generated method stub
		Materials_info materials_info=null;
		try {
			Object object = sqlMapClient.queryForObject("materials_info.getMaterials_infoByModel", model);
			if(object!=null){
				materials_info=(Materials_info)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return materials_info;
	}

	@Override
	public void delMaterials_infoByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.delete("materials_info.delMaterials_infoByID", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public void updateMaterials_info(Materials_info materials_info) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.update("materials_info.updateMaterials_info", materials_info);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public List<Materials_info> getMaterials_infos() {
		// TODO Auto-generated method stub
		List<Materials_info> list=null;
		try {
			list=sqlMapClient.queryForList("materials_info.getMaterials_infos");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public List<Materials_info> getMaterials_infosByCondition(Map map) {
		// TODO Auto-generated method stub
		List<Materials_info> list=null;
		try {
			list=sqlMapClient.queryForList("materials_info.getMaterials_infosByCondition",map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public int getNumByCondition(Map map){
		int num=0;
		try {
			Object object=sqlMapClient.queryForObject("materials_info.getNumByCondition",map);
			if(object!=null){
				num=(Integer)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return num;
	}
	public boolean checkUseMaterials(int m_id){
		try {
			Object object = sqlMapClient.queryForObject("materials_info.checkUseMaterials",m_id);
			if(object!=null){
				if((Integer)object>0){
					return true;
				}
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
}
