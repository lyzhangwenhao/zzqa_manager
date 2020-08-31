package com.zzqa.service.interfaces.equipment;

import java.util.List;

import com.zzqa.pojo.device.Device;
import com.zzqa.pojo.equipment.Equipment;
import com.zzqa.pojo.equipment_template.Equipment_template;
import com.zzqa.pojo.user.User;

public interface EquipmentManager {
	public void insertEquipment_template(Equipment_template equipment_template);
	public void updateEquipment_template(Equipment_template equipment_template);
	public void delEquipment_templateByID(int id);
	public Equipment_template getEquipment_templateByID(int id);
	public List getAllEquipment_template();
	
	public void insertEquipment(Equipment equipment);
	public void updateEquipment(Equipment equipment);
	public void delEquipmentByID(int id);
	public Equipment getEquipmentByID(int id);
	public List getAllEquipment();
	public List getEquipmentByCreateID(int create_id);
	public List getFreedomEquipmentList();
	/****
	 * 
	 * @param state_device
	 * @param newtime_device
	 * @param starttime_device
	 * @param endtime_device
	 * * @param isCreater 0：所有；大于0：该用户创建(==create_id)；小于0：其他用户(!=create_id)
	 * @param user
	 * @return
	 */
	public List<Equipment> getEquipmentByCondition(String keywords_device,String state_device,
			int newtime_device,long starttime_device,long endtime_device,int isCreater,User user);
	public Equipment_template getTempByAlias(String alias);
	public void updateEquipmentShipID(int deviceID, int ship_id);
}
