package com.zzqa.dao.interfaces.workday_project;

import java.util.List;

import com.zzqa.pojo.workday_project.Workday_project;

public interface IWorkday_projectDAO {
	public void insertWorkday_project(Workday_project workday_project);
	public Workday_project getWorkday_projectByID(int id);
	public void updateWorkday_project(Workday_project workday_project);
	public void delWorkday_projectByID(int id);
	public void delWorkday_projectByWDID(int workday_id);
	public List<Workday_project> getWorkday_projectsByWDID(int workday_id);
	public boolean checkProjectBind(int project_id);
}
