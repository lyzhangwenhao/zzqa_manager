package com.zzqa.dao.impl.equipment_template;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.equipment_template.IEquipment_templateDAO;
import com.zzqa.pojo.equipment_template.Equipment_template;
@Component("equipment_templateDAO")
public class Equipment_templateDAOImpl implements IEquipment_templateDAO {
	@Resource(name="sqlMapClient")
	SqlMapClient sqlMapclient = null;
	@Override
	public void insertEquipment_template(Equipment_template equipment_template) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("equipment_template.insertEquipment_template", equipment_template);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public void updateEquipment_template(Equipment_template equipment_template){
		try {
			sqlMapclient.update("equipment_template.updateEquipment_template", equipment_template);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@Override
	public void delEquipment_templateByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.delete("equipment_template.delEquipment_templateByID", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public Equipment_template getEquipment_templateByID(int id) {
		// TODO Auto-generated method stub
		Equipment_template equipment_template=null;
		try {
			Object object=sqlMapclient.queryForObject("equipment_template.getEquipment_templateByID", id);
			if(object!=null){
				equipment_template=(Equipment_template)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return equipment_template;
	}

	@Override
	public List getAllEquipment_template() {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("equipment_template.getAllEquipment_template");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public Equipment_template getTempByAlias(String alias) {
		// TODO Auto-generated method stub
		Equipment_template equipment_template=null;
		try {
			Object object=sqlMapclient.queryForObject("equipment_template.getTempByAlias",alias);
			if(object!=null){
				equipment_template=(Equipment_template)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return equipment_template;
	}

}
