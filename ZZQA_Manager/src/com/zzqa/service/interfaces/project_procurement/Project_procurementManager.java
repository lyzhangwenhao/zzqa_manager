package com.zzqa.service.interfaces.project_procurement;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.project_procurement.Project_procurement;
import com.zzqa.pojo.user.User;

public interface Project_procurementManager {
	public void insertProject_procurement(Project_procurement project_procurement);
	public void updateProject_procurement(Project_procurement project_procurement);
	public void delProject_procurementByID(int id);
	public int getProject_procurementCount();
	/******
	 * 传入参数 beginrow rows
	 * @param map
	 * @return
	 */
	public List<Project_procurement> getProject_procurementList(int beginrow,int rows);
	public Project_procurement getProject_procurementByID(int id);
	public Project_procurement getProject_procurementByID2(int id);
	//查询用户最新添加的项目采购单
	public int getNewProject_procurementByUID(int create_id);
	/****
	 * 流程绘制元素
	 * @param prodject_pid
	 * @return
	 */
	public Map<String, String> getProjectPFlowForDraw(Project_procurement project_procurement,Flow flow);
	//等待用户操作的生产流程
	public List<Project_procurement> getProject_procurementListByUID(User user);
	//查询已经审批结束的项目预算单
	public List<Project_procurement> getAllApplyedProjectList(int create_id);
	//查询绑定的采购流程
	public List<Project_procurement> getProject_procurementListByTaskID(int task_id);
}
