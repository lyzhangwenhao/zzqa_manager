package com.zzqa.service.interfaces.task;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.task.Task;
import com.zzqa.pojo.user.User;

public interface TaskManager {
	//添加一条分类
	public int insertTask(Task task);
	//修改
	public void updateTask(Task task);
	//修改编辑状态
	public void updateEdited(Task task);
	//通过id查询任务单
	public Task getTaskByID(int id);
	public Task getTaskByID2(int id);
	//通过id删除任务单
	public void delTaskByID(int id);
	//删除用户发布的任务单
	public void delTaskByCreateID(int create_id);
	/****
	 * 查询等待用户操作的任务单
	 * @param uid 用户id
	 * @return
	 */
	public List<Task> getTaskListByUID(User user);
	public List<Task> getStartupTaskListByUID(User user);
	/****
	 * 流程绘制元素
	 * @return
	 */
	public Map<String, String> getTaskFlowForDraw(Task task,Flow flow);
	public Map<String, String> getStartUpTaskFlowForDraw(Task task,Flow flow);
	//销售人员修改备注 传入备注
	public void updateRemarks(Task task);
	//查询已完成的任务单
	public List<Task> getFinishTaskList();
}
