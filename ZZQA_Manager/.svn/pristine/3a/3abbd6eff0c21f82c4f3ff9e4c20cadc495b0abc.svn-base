package com.zzqa.service.interfaces.operation;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.operation.Operation;

public interface OperationManager {
	//添加日志
	public void insertOperation(Operation operation);
	/*****
	 * 根据条件查询日志
	 */
	public List getOperationList(String name_log,int newtime_log,String starttime,String endtime,String keywords,int nowpage);
	/*****
	 * 查询日志条数
	 * @param id
	 */
	public int getOperationCount(String name_log,int newtime_log,String starttime,String endtime,String keywords);
	//删除日志
	public void delOperationByID(int id);
	//修改日志
	public void updateOperation(Operation operation);
}
