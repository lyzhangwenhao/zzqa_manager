package com.zzqa.service.interfaces.leave;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.leave.Leave;
import com.zzqa.pojo.travel.Travel;
import com.zzqa.pojo.user.User;
/*****
 * 请假单
 * @author FPGA
 *
 */
public interface LeaveManager {
	public void insertLeave(Leave leave);
	public void updateLeave(Leave leave);
	public Leave getLeaveByID(int id);
	//流程列表
	public Leave getLeaveByID2(int id);
	public List<Leave> getAllLeaveList();
	public List<Leave> getLeaveListByUID(User user);
	/******
	 * 描绘
	 * @param leave_id
	 * @return
	 */
	public Map<String, String>getLeaveFlowForDraw(Leave leave,Flow flow);
	//检查是否可以审批
	public boolean checkLeaveCan(int operation,Leave leave,User user);
	//检查是否可以备案
	public boolean checkLeaveBackUp(int operation,Leave leave,User user);
	/*****
	 * 审核通过的请假单（这里包含只有一次审核通过的，个别请假单需要分管领导审批的在manager中二次过滤,超过7的且有两级以上领导的总经理审批）
	 * @param create_id
	 * @return
	 */
	public List<Leave> getLeaveListAfterApproval(int uid);
	/****
	 * 查询请假月报表
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	public List<Leave> getLeaveListReport(int year,int month);
	public boolean checkLeaveInScope(long starttime,long endtime,int create_id);
}
