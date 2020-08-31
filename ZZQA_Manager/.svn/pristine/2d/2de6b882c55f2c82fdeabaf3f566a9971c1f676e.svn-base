package com.zzqa.service.interfaces.travel;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.travel.Travel;
import com.zzqa.pojo.user.User;

public interface TravelManager {
	public void updateTravel(Travel travel);
	public void insertTravel(Travel travel);
	public Travel getTravelByID(int id);
	public Travel getNewTravelByCreateID(int create_id);
	public List<Travel> getAllTravelList();
	/****
	 * 流程绘制元素
	 * @param travel_id
	 * @return
	 */
	public Map<String, String> getTravelFlowForDraw(Travel travel,Flow flow);
	//待办事项
	public List<Travel> getTravelListByUID(User user);
	/****
	 * 查询用户审批通过的出差单 老版本用于关联销假单，新版本不关联,已弃用，可删除
	 * @param uid
	 * @return
	 */
	public List<Travel> getTravelListAfterApproval(int uid);
	/****
	 * 查询出差月报表
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	public List<Travel> getTravelListReport(int year,int month);
	public void delTravelByID(int id);
	/****
	 * 判断该用户在该时间段内申请过出差单（撤销除外）
	 * @param starttime
	 * @param endtime
	 * @param create_id
	 */
	public boolean checkTravelInScope(long  starttime,long endtime,int create_id);
}
