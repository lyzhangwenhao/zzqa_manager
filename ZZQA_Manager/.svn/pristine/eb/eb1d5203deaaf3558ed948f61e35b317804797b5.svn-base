package com.zzqa.dao.interfaces.manufacture;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.manufacture.Manufacture;

public interface IManufactureDAO {
	public void insertManufacture(Manufacture manufacture);
	public void delManufactureByID(int id);
	public Manufacture getManufactureByID(int id);
	public void updateManufacture(Manufacture manufacture);
	public int getNewManufactureByUID(int create_id);
	/******
	 * 传入参数 beginrow rows
	 * @param map
	 * @return
	 */
	public List getManufactureList(Map map);
	/******
	 * 查询未完成的
	 * @return
	 */
	public List getRunningManufacture();
	public List getAllList();
}
