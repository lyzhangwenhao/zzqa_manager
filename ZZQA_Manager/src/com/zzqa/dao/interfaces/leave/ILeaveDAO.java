package com.zzqa.dao.interfaces.leave;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.leave.Leave;

public interface ILeaveDAO {
	public void insertLeave(Leave leave);
	public void updateLeave(Leave leavel);
	public Leave getLeaveByID(int id);
	public List getAllLeaveList();
	/*****
	 * 审核通过的请假单（这里包含只有一次审核通过的，个别请假单需要分管领导审批的在manager中二次过滤）
	 * @param create_id
	 * @return
	 */
	public List getLeaveListAfterApproval(int create_id);
	/****
	 * 查询未完成的请假流程
	 * @return
	 */
	public List getRunningLeave();
	
	public List getLeaveListReport(Map map);
	
	/*****
	 * 
	 * key starttime endtime create_id
	 */
	public List checkLeaveInScope(Map map);
	public List getAllList();
}
