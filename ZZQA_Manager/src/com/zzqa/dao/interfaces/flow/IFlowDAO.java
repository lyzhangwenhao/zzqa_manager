package com.zzqa.dao.interfaces.flow;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.flow.Flow;

public interface IFlowDAO {
	//添加流程
	public void insertFlow(Flow flow);
	//查询流程
	public List<Flow> getFlowListByCondition(int type,int foreign_id);
	//删除流程
	public void  deleteByCondition(int type,int foreign_id);
	//移除最近的特定步骤
	public void  deleteRecentOperat(int type,int foreign_id,int operation);
	//
	public List<Flow> getReasonList(int type,int foreign_id);
	//修改理由
	public void updateFlow(Flow flow);
	//获取最新的流程 传入参数 type和foreign
	public Flow getNewFlowByFID(int type,int foreign_id);
	//查询所有最新的流程的foreign_id
	public List<Flow> getFIDsByType(int type);
	/****
	 * 查询所有流程的最新步骤
	 * @return
	 */
	public List<Flow> getAllFlowList();
	/****
	 * 传入 type foreign_id operation
	 * @param flow
	 * @return 操作时间
	 */
	public long getFlowTimeByFlow(Flow flow);
	//判断用户是否参与该流程 需传入type foreign_id uid
	public boolean checkIsJoin(Flow flow);
	//查询该出差是否延时 必须为考勤备案后的
	public boolean checkTravelDelay(int foreign_id);
	//返回某一步骤流程 需传入type foreign_id operation
	public Flow getFlowByOperation(Flow flow);
	/**删除某时间段内的流程**/
	public void delSomeFlow(Map map);
	/***查询某时间段内的流程***/
	public List<Flow> getSomeFlow(Map map);
	public List<Flow> getParentAllFlowList(int position_id,int uid);
	////查看权限内全部记录和自己参与的流程记录
	public List<Flow> getJoinPermissionFlowList(List<Integer> flowTypes,List<Integer> fidList, List<Integer> foidList,long time);
	//查看自己参与过的流程记录
	public List<Flow> getAllJoinableFlowList(List<Integer> fidList);
	//查看权限记录但是自己没有参与过的记录
	public List<Flow> getAllPermissionFlowList(List<Integer> flowTypes,List<Integer> foidList,int uid,long time);
	//没有查看权限只能看自己记录和所属人员考核记录
	public List<Flow> getJoinFlowwerFlowList(List<Integer> fidList, List<Integer> foidList,long time);
	//根据uid查询flow表中参与过的流程
	public List<Integer> getForeignIDByUid(int uid);
	public List<Integer> getFidByPositionID(int position_id);
	public void deleteByPerformanceOP(int foreign_id);
	public void updateFlowOperation(Flow flow);
	public void updateFlowOperationByFid(int id);

	/**
	 * 通过foreign_id查询所有流程中相关的人
	 * @param foreign_id
	 * @return
	 */
	public List<Integer> getUidByForeign(int foreign_id);
}
