package com.zzqa.dao.impl.equipment;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.equipment.IEquipmentDAO;
import com.zzqa.pojo.equipment.Equipment;
@Component("equipmentDAO")
public class EquipmentDAOImpl implements IEquipmentDAO {
	@Resource(name="sqlMapClient")
	SqlMapClient sqlMapclient = null;

	@Override
	public void insertEquipment(Equipment equipment) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("equipment.insertEquipment", equipment);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void updateEquipment(Equipment equipment) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update("equipment.updateEquipment", equipment);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void delEquipmentByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.delete("equipment.delEquipmentByID", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public Equipment getEquipmentByID(int id) {
		// TODO Auto-generated method stub
		Equipment equipment=null;
		try {
			Object object=sqlMapclient.queryForObject("equipment.getEquipmentByID",id);
			if(object!=null){
				equipment=(Equipment)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return equipment;
	}

	@Override
	public List getAllEquipment() {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("equipment.getAllEquipment");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List getEquipmentByCondition(Map map) {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("equipment.getEquipmentByCondition",map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List getEquipmentByCreateID(int create_id) {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("equipment.getEquipmentByCreateID",create_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Equipment> getFreedomEquipmentList() {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("equipment.getFreedomEquipmentList");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public List<Equipment> getEquipmentByShipID(int ship_id) {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("equipment.getEquipmentByShipID",ship_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public void updateEquipmentShipID(Map map){
		try {
			sqlMapclient.update("equipment.updateEquipmentShipID", map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
