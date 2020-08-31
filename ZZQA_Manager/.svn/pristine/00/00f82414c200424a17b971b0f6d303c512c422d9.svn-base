package com.zzqa.service.interfaces.shipments;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.shipments.Shipments;
import com.zzqa.pojo.user.User;

public interface ShipmentsManager {
	public void insertshipments(Shipments shipments);
	public void updateShipments(Shipments shipments);
	public void delShipmentsByID(int id);
	public Shipments getShipmentsByID(int id);
	public Shipments getShipmentsDetailByID(int id);
	public Shipments getShipmentsByID2(int id);
	/******
	 * beginrow :开始行
	 * rows 筛选条数
	 * 注：小于0表示获取全部
	 * @return
	 */
	public List getShipmentsList(int beginrow,int rows);
	//获取用户最新添加的发货单id
	public int getNewShipmentsByUID(int uid);
	//用户待操作的发货流程
	public List<Shipments> getShipmentsListByUID(User user);
	//流程绘制元素
	public Map<String,String> getShipFlowForDraw(Shipments ship,Flow flow);
}
