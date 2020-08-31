package com.zzqa.dao.interfaces.shipments;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.shipments.Shipments;

public interface IShipmentsDAO {
	public void insertshipments(Shipments shipments);
	public void updateShipments(Shipments shipments);
	public void delShipmentsByID(int id);
	public Shipments getShipmentsByID(int id);
	/******
	 * 传入beginrow ,rows 注：小于0表示获取全部
	 * @param map 
	 * @return
	 */
	public List getShipmentsList(Map map);
	//获取用户最近添加的发货单id
	public int getNewShipmentsByUID(int uid);
	
	public Shipments getShipmentsByTaskID(int task_id);
	/****
	 * 查询为完成的发货流程
	 * @return
	 */
	public List getRunningShipments();
	public List getAllList();
}
