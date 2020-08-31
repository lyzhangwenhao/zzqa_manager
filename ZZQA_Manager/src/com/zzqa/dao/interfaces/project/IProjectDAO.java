package com.zzqa.dao.interfaces.project;

import java.util.List;

import com.zzqa.pojo.project.Project;

public interface IProjectDAO {
	public void insertProject(Project project);
	public Project getProjectByID(int id);
	public int getNewProject();
	public void updateProject(Project project);
	public void delProjectByID(int id);
	public List<Project> getProjects();
	//检查项目是否重复
	public boolean checkProjectByPName(String project_name,int id);
}
