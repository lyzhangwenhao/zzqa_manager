package com.zzqa.dao.interfaces.operation;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.operation.Operation;
import com.zzqa.service.interfaces.operation.OperationManager;

public interface IOperationDAO {
	//添加日志
	public void insertOperation(Operation operation);
	//根据条件查询日志 传入 keywords starttime endtime
	public List getOperationList(Map map);
	//根据条件查询日志条数 传入 keywords starttime endtime
	public int getOperationCount(Map map);
	//删除日志
	public void delOperationByID(int id);
	//修改日志
	public void updateOperation(Operation operation);
}
