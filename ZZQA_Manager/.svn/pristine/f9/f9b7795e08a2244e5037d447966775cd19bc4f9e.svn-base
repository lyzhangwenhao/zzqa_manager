package com.zzqa.dao.interfaces.notify;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.notify.Notify;

public interface INotifyDAO {
	public Notify getNotifyByID(int id);
	public void insertNotify(Notify notify);
	public void delNotifyByID(int id);
	public  void updateNotify(Notify notify);
	public List getNotifyListByCreateID(Map map);
	public List getNotifyListByYear(Map map);
	public int getNewNotifyIDByCreateID(int create_id);
	/****
	 * map-key:create_id
	 * @param map
	 * @return
	 */
	public List getNotReadReplyNotifyList(Map map);
}
