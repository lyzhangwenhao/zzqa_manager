package com.zzqa.pojo.work;

import java.util.ArrayList;
import java.util.List;

import com.zzqa.pojo.work_day.Work_day;

/****
 * 工时统计表
 * @author louph
 *
 */
public class Work {
	private int id;
	private long workmonth;//工时统计的月份
	private long create_time;//创建时间
	private long update_time;	
	private int create_id;
	private String create_name;
	private int operation;//当前流程进度
	private List<Work_day> list=new ArrayList<Work_day>();
	private String name;//流程名称
	private String process;//流程进度
	public int getOperation() {
		return operation;
	}
	public void setOperation(int operation) {
		this.operation = operation;
	}
	public List<Work_day> getList() {
		return list;
	}
	public void setList(List<Work_day> list) {
		this.list = list;
	}
	public String getCreate_name() {
		return create_name;
	}
	public void setCreate_name(String create_name) {
		this.create_name = create_name;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public long getWorkmonth() {
		return workmonth;
	}
	public void setWorkmonth(long workmonth) {
		this.workmonth = workmonth;
	}
	public long getCreate_time() {
		return create_time;
	}
	public void setCreate_time(long create_time) {
		this.create_time = create_time;
	}
	public long getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(long update_time) {
		this.update_time = update_time;
	}
	public int getCreate_id() {
		return create_id;
	}
	public void setCreate_id(int create_id) {
		this.create_id = create_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getProcess() {
		return process;
	}
	public void setProcess(String process) {
		this.process = process;
	}
}
