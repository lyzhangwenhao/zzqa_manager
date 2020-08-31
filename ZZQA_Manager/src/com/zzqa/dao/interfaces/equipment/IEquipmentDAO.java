package com.zzqa.dao.interfaces.equipment;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.equipment.Equipment;

public interface IEquipmentDAO {
	public void insertEquipment(Equipment equipment);
	public void updateEquipment(Equipment equipment);
	public void delEquipmentByID(int id);
	public Equipment getEquipmentByID(int id);
	public List getAllEquipment();
	public List getEquipmentByCondition(Map map);
	public List getEquipmentByCreateID(int create_id);
	public List<Equipment> getFreedomEquipmentList();
	public List<Equipment> getEquipmentByShipID(int ship_id);
	public void updateEquipmentShipID(Map map);
}
