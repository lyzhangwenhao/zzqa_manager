package com.zzqa.dao.interfaces.travel;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.travel.Travel;

/******
 * 出差
 * @author FPGA
 *
 */
public interface ITravelDAO {
	public void updateTravel(Travel travel);
	public void insertTravel(Travel travel);
	public Travel getTravelByID(int id);
	public void delTravelByID(int id);
	public Travel getNewTravelByCreateID(int create_id);
	public List getAllTravelList();
	/****
	 * 审核通过的出差单
	 * @param create_id
	 * @return
	 */
	public List getTravelListAfterApproval(int create_id);
	/****
	 * 查询为完成的流程
	 * @return
	 */
	public List getRunningTravel();
	
	public List getTravelListReport(Map map) ;
	/*****
	 * 
	 * key starttime endtime create_id
	 */
	public boolean checkTravelInScope(Map map) ;
	public List getAllList();
}
