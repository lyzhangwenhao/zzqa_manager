package com.zzqa.dao.interfaces.project_procurement;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.project_procurement.Project_procurement;

public interface IProject_procurementDAO {
	public void insertProject_procurement(Project_procurement project_procurement);
	public void updateProject_procurement(Project_procurement project_procurement);
	public void delProject_procurementByID(int id);
	public int getProject_procurementCount();
	/******
	 * 传入参数 beginrow rows
	 * @param map
	 * @return
	 */
	public List<Project_procurement> getProject_procurementList(Map map);
	public Project_procurement getProject_procurementByID(int id);
	//查询用户最新添加的生产流程
	public int getNewProject_procurementByUID(int create_id);
	/****
	 * 查询为完成的流程
	 * @return
	 */
	public List<Project_procurement> getRunningProject_procurement();
	//查询已经审批结束的项目预算单
	public List<Project_procurement> getAllApplyedProjectList(int create_id);
	public List getAllList();
	public List<Project_procurement> getProject_procurementListByTaskID(
			int task_id);
}
