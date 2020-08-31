package com.zzqa.pojo.work_day;

import java.util.ArrayList;
import java.util.List;

import com.zzqa.pojo.workday_project.Workday_project;

/****
 * 工时日表
 * @author louph
 *
 */
public class Work_day {
	private int id;
	private int work_id;//工时统计表id
	private int workday;//工时统计的日期
	private String job_content;//工作内容
	/****
	 * 旧版 0：未审批；1：通过；2：不通过
	 * 新版 0：未读；1、2已读 ；3：有未读评语（读完改回状态1）
	 */
	private int status;
	private String remark;//批注
	private List<Workday_project> list=new ArrayList<Workday_project>();
	public List<Workday_project> getList() {
		return list;
	}
	public void setList(List<Workday_project> list) {
		this.list = list;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getWork_id() {
		return work_id;
	}
	public void setWork_id(int work_id) {
		this.work_id = work_id;
	}
	public int getWorkday() {
		return workday;
	}
	public void setWorkday(int workday) {
		this.workday = workday;
	}
	public String getJob_content() {
		return job_content;
	}
	public void setJob_content(String job_content) {
		this.job_content = job_content;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
}
