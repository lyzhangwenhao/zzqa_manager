package com.zzqa.service.interfaces.task_conflict;

import com.zzqa.pojo.task_conflict.Task_conflict;

public interface Task_conflictManager {
	//修改
	public void updateTask_conflict(Task_conflict task_conflict);
	//通过id查询对比任务单
	public Task_conflict getTask_conflictByTaskID(int task_id);
	//查询是否保存对比任务单
	public boolean checkTask_conflict(int task_id);
	//删除对比任务单
	public void delTask_conflictByID(int task_id);
	//对比任务单
	public boolean[] checkConflict(int task_id);
}
