package com.zzqa.dao.interfaces.aftersales_task;

import java.util.List;

import com.zzqa.pojo.aftersales_task.Aftersales_task;

/****
 * 售后任务单
 * @author louph
 *
 */
public interface IAftersales_taskDAO {
	public void insertAlterSales_Task(Aftersales_task aftersales_task);
	//修改
	public void updateAlterSales_Task(Aftersales_task aftersales_task);
	//通过id查询任务单
	public Aftersales_task getAlterSales_TaskByID(int id);
	//通过id删除任务单
	public void delAlterSales_TaskByID(int id);
	//查询用户最新添加的任务单 
	public int getNewAlterSales_TaskIDByCreateID(int create_id);
	//查询未完成任务单
	public List getRunningAlterSales_Task();
	public List getAllList();
}
