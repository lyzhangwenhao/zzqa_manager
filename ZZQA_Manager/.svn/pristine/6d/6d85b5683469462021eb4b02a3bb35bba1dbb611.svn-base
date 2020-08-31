package com.zzqa.service.interfaces.device;

import java.util.List;

import com.zzqa.pojo.device.Device;
import com.zzqa.pojo.user.User;

public interface DeviceManager {
	public void insertDevice(Device device);
	public void delDeviceByID(int id);
	public void delDeviceByDeviceID(int m_id);
	public List getDeviceList(int m_id);
	public Device getDeviceByID(int id);
	public void updateDevice(Device device);
	//返回最新添加的设备id
	public int getNewDeviceByUpID(int update_id);
	/***
	 * 绑定发货
	 * @param device
	 */
	public void updateDeviceOnShip(Device device);
	/****
	 * 返回所有未生产完成且未发货的设备
	 * @return
	 */
	public List getFreedomDeviceList();

	public List<Device> getDeviceListByCondition(String keywords_devic,int material_device,String sn1_device,
			String sn2_device,String sn3_device,String sn4_device,String sn5_device,String sn6_device,
			int isFileExist,String state_device,int isQualify,int newtime_device,String starttime_device,String endtime_device,User user);
	/***
	 * 查询某发货流程下的设备
	 * @param m_id
	 * @return
	 */
	public List getDeviceListByShipID(int ship_id);
}
