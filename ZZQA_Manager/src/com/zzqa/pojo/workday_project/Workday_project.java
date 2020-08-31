package com.zzqa.pojo.workday_project;
/****
 * 工时日详情表
 * @author louph
 *
 */
public class Workday_project {
	private int id;
	private int workday_id;//工时日表id
	private int project_id;//项目id
	private float hours;//日工作时间
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getWorkday_id() {
		return workday_id;
	}
	public void setWorkday_id(int workday_id) {
		this.workday_id = workday_id;
	}
	public int getProject_id() {
		return project_id;
	}
	public void setProject_id(int project_id) {
		this.project_id = project_id;
	}
	public float getHours() {
		return hours;
	}
	public void setHours(float hours) {
		this.hours = hours;
	}
}
