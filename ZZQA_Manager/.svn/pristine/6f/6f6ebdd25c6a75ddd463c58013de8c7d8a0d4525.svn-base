package com.zzqa.dao.interfaces.work;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.work.Work;

public interface IWorkDAO {
	public void insertWork(Work work);
	public Work getWorkByID(int id);
	public void updateWork(Work work);
	public void delWorkByID(int id);
	public int getNewWorkByUID(int create_id);
	/******
	 * 传入参数 beginrow rows
	 * @param map
	 * @return
	 */
	//public List getWorkList(Map map);
	/******
	 * 查询未完成的
	 * @return
	 */
	public List getRunningWork();
	public Work getWorkByMonthAndUID(long month,int create_id);
	public List<Work> getWorkByMonths(long starttime,long endtime);
	//查询所有添加过工时统计的用户
	public List getAllUserWidthWork();
	public boolean checkNumByLeaderId(int uid);
	public List getAllList();
	public Map getWorkdaysReport(Map map);
}
