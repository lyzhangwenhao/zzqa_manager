package com.zzqa.service.interfaces.aftersales_task;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.aftersales_task.Aftersales_task;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.task.Task;
import com.zzqa.pojo.user.User;

public interface Aftersales_taskManager {
	public int insertAlterSales_Task(Aftersales_task aftersales_task);
	//修改
	public void updateAlterSales_Task(Aftersales_task aftersales_task);
	//通过id查询任务单
	public Aftersales_task getAlterSales_TaskByID(int id);
	public Aftersales_task getAlterSales_TaskByID2(int id);
	//通过id删除任务单
	public void delAlterSales_TaskByID(int id);
	//待办事项
	public List<Aftersales_task> getAftersales_taskByUID(User user);
	public Map<String, String> getTaskFlowForDraw(Aftersales_task aftersales_task,Flow flow);
	public boolean checkCanApply(Aftersales_task aftersales_task,User user,int operation);
}
