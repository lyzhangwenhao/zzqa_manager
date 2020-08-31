package com.zzqa.dao.interfaces.task;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.task.Task;

public interface ITaskDAO {
	//添加一条分类
	public int insertTask(Task task);
	//修改
	public void updateTask(Task task);
	//销售人员修改备注 传入备注和更新时间
	public void updateRemarks(Task task);
	//修改编辑状态
	public void updateEdited(Task task);
	//通过id查询任务单
	public Task getTaskByID(int id);
	//通过id查询任务单 只取主界面需要的数据
	public Task getTask2ByID(int id);
	//通过id删除任务单
	public void delTaskByID(int id);
	//删除用户发布的任务单
	public void delTaskByCreateID(int create_id);
	//查询用户最新添加的任务单 
	public Task getNewTaskByCreateID(int create_id);
	//查询已完成的任务单
	public List<Task> getFinishTaskList();
	//查询未完成任务单
	public List<Task> getRunningTask();
	public List getRunningStartupTask();
	//检查任务单是否绑定采购或发货  (以及生产)
	public boolean checkTaskBind(int task_id);
	public List getAllList();
}
