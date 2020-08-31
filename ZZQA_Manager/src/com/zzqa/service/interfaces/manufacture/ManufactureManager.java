package com.zzqa.service.interfaces.manufacture;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.manufacture.Manufacture;
import com.zzqa.pojo.user.User;

public interface ManufactureManager {
	public void insertManufacture(Manufacture manufacture);
	public void delManufactureByID(int id);
	public Manufacture getManufactureByID(int id);
	public Manufacture getManufactureByID2(int id);
	public void updateManufacture(Manufacture manufacture);
	//查询用户最新添加的生产流程
	public int getNewManufactureByUID(int create_id);
	/*****
	 * beginrow 开始查询位置
	 * rows 查询条数
	 */
	public List<Manufacture> getManyfactureList(int beginrow,int rows);
	//流程绘制元素
	public Map<String, String> getManufactureFlowForDraw(Manufacture manufacture,Flow flow);
	//等待用户操作的生产流程
	public List getManufactureListByUID(User user);
}
