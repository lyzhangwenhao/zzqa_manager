package com.zzqa.dao.interfaces.task_updateflow;

import java.util.List;

import com.zzqa.pojo.task_updateflow.Task_updateflow;

public interface ITask_updateflowDAO {
	
	public int insertTask_updateflow(Task_updateflow task_updateflow);

	public Task_updateflow getTask_updateflowById(int foreign_id);

	public List<Task_updateflow> getRunningTask_updateflow();

	public List<Task_updateflow> getAllList();

	public Task_updateflow getTask_updateflowByTaskId(int forignId);

	public void updateTask_updateflowCount(int task_id);

}
