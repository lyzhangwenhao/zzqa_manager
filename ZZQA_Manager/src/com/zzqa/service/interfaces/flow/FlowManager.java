package com.zzqa.service.interfaces.flow;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.leave.Leave;
import com.zzqa.pojo.task.Task;
import com.zzqa.pojo.travel.Travel;
import com.zzqa.pojo.user.User;

public interface FlowManager {
	//添加流程
	public void insertFlow(Flow flow);
	public void insertFlow2(Flow flow);
	//删除流程
	public void  deleteByCondition(int type,int foreign_id);
	//移除最近的特定步骤
	public void  deleteRecentOperat(int type,int foreign_id,int operation);
	//查询流程
	public List<Flow> getFlowListByCondition(int type,int foreign);
	//返回某一步骤流程 需传入type foreign_id operation
	public Flow getFlowByOperation(int type,int foreign_id,int operation);
	//修改理由
	public void updateFlow(Flow flow);
	//判断角色是否为下一步的审核人 
	public boolean checkCanDo(int type,User user,int operation);
	//(项目任务单)判断角色是否为下一步的审核人 project_case=0:1表示项目任务单的普项和急项
	public boolean checkTaskCanDo(int create_id, int project_type,int project_category,int project_case,int Product_type,User user,int operation);
	//项目采购流程
	public boolean checkProjectPurchaseCanDo(Task task,User user,int operation);
	/****
	 * 获取最新进度
	 * @param type
	 * @param foreign_id
	 * @return
	 */
	public Flow getNewFlowByFID(int type ,int foreign_id);
	/****
	 * 获取进度留言
	 * @param type
	 * @param foreign_id
	 * @return
	 */
	public List<Flow> getReasonList(int type ,int foreign_id);
	/****
	 * 完成任务单
	 * @param type
	 * @param foreign_id
	 * @return
	 */
	public void finishFlow(int type ,int foreign_id);
	/********
	 * 下载文件权限
	 * @param fileID
	 * @param uid
	 * @return
	 */
	public int checkLoadFilePermission(int fileID,int uid);
	/****
	 * 发送邮件提醒下一步操作的用户
	 * @param permissions_id
	 * @param content
	 * @param flag true表示发送给创建者，permissions_id为uid
	 */
	public void sendMail(int permissions_id,int type,User user,String content,boolean flag);
	/****
	 * 
	 */
	public Map<String,Object> getFlowPaging(int nowpage,String keywords,int newtime_flows,int nowtime_flows,
			String type_flows,String starttime1_flows,String endtime1_flows,String starttime2_flows,
			String endtime2_flows,int isjoin,int process,int handUp,int stage,User user);
	public void deleteByPerformanceOP(int id);
	public void updateFlowOperation(Flow flow);
	public void updateFlowOperationByFid(int id);
	public void alertTaskProjectFileSendEmail(int task_id);
	public void alertRemarksSendEmail(int uid,int task_id,String project_name);//任务单完成之后 修改备注信息需要发送消息给审核人

	/**
	 * 根据foreign_id获取所有流程中所有相关的人
	 * @param foreign_id project_procurement的主键
	 * @return
	 */
	public List<Integer> getUidByForeignId(int foreign_id);
}