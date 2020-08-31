package com.zzqa.service.interfaces.work;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.project.Project;
import com.zzqa.pojo.user.User;
import com.zzqa.pojo.work.Work;
import com.zzqa.pojo.work_day.Work_day;
import com.zzqa.pojo.workday_project.Workday_project;

public interface WorkManager {
	public List getWorkByUID(User user);
	public int insertWork(Work work);
	public Work getWorkByID(int id);
	public void updateWork(Work work);
	public void delWorkByID(int id);
	public Work getWorkByMonthAndUID(long month, int create_id);
	//不包含工时日详情
	public Work getWorkByMonthAndUID2(long month, int create_id);
	public List<Work> getWorkByMonths(long starttime,long endtime);
	//查询所有添加过工时统计的用户
	public List<User> getAllUserWidthWork();
	public boolean checkNumByLeaderId(int uid);
	public int insertWork_day(Work_day work_day);
	public Work_day getWork_dayByID(int id);
	public Work_day getWork_dayByWIDAndWD(int work_id,int workday);
	public void updateWork_day(Work_day work_day);
	public void delWork_dayByID(int id);
	public List<Work_day> getWork_daysByWID(int word_id);
	public void updateStatus(int id, int status);
	
	public void insertWorkday_project(Workday_project workday_project);
	public Workday_project getWorkday_projectByID(int id);
	public void updateWorkday_project(Workday_project workday_project);
	public void delWorkday_projectByID(int id);
	public void delWorkday_projectByWDID(int workday_id);
	
	public int insertProject(Project project);
	public Project getProjectByID(int id);
	public void updateProject(Project project);
	/****
	 * 
	 * @param id
	 * @return true：删除失败，已被绑定；true：删除成功
	 */
	public boolean delProjectByID(int id);
	public List<Project> getProjects();
	//检查项目是否重复
	public boolean checkProjectByPName(String project_name,int id);
	public Map getWorkdaysReport(long startM,int startDay,long endM,int endDay);
}
