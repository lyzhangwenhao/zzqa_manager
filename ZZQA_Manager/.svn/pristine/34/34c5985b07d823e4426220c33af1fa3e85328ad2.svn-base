package com.zzqa.dao.interfaces.device;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.device.Device;

public interface IDeviceDAO {
	public void insertDevice(Device device);
	public void delDeviceByID(int id);
	public void delDeviceByDeviceID(int m_id);
	/*****
	 * 查询某生产流程下的设备
	 * @param m_id
	 * @return
	 */
	public List getDeviceList(int m_id);
	/****
	 * 返回所有未生产完成且未发货的设备
	 * @return
	 */
	public List getFreedomDeviceList();
	public Device getDeviceByID(int id);
	/***
	 * 绑定发货
	 * @param device
	 */
	public void updateDeviceOnShip(Device device);
	
	public void updateDevice(Device device);
	//返回最新添加的设备id
	public int getNewDeviceByUpID(int update_id);
	/**
	 * 搜索全部的字段用于查询
	 */
	public List getDeviceSN();
	/***
	 * 查询某发货流程下的设备
	 * @param m_id
	 * @return
	 */
	public List getDeviceListByShipID(int ship_id);
	//返回所有设备
	public List getAllDeviceList();
	/****
	 * 查询设备
	 * @param map
	 * @return
	 */
	public List<Device> getDeviceListByCondition(Map map);
	
}
