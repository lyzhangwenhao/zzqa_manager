package com.zzqa.pojo.project_procurement;

import java.io.Serializable;

public class Project_procurement implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 981102987759868489L;
	private String name;//格式如：项目采购-2016年03月28日
	private int id;
	private int task_id;//关联任务单id
	private int project_pid;//关联预算
	private int create_id;
	private String create_date;
	private String create_name;
	private int receive_id;//接收人id（采购人员）
	private String receive_name;
	private int aog_id;//到货确认人
	private int check_id;//验货人
	private String check_name;
	private int putin_id;//仓库管理员id 入库操作
	private String putin_name;
	private long create_time;
	private long predict_time;//预计到货时间戳
	private String predict_date;
	private long aog_time;//到货时间戳
	private String aog_date;
	private String process;//进度
	public int getId() {
		return id;
	}
	public int getProject_pid() {
		return project_pid;
	}
	public void setProject_pid(int project_pid) {
		this.project_pid = project_pid;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getTask_id() {
		return task_id;
	}
	public void setTask_id(int task_id) {
		this.task_id = task_id;
	}
	public int getCreate_id() {
		return create_id;
	}
	public void setCreate_id(int create_id) {
		this.create_id = create_id;
	}
	public int getReceive_id() {
		return receive_id;
	}
	public void setReceive_id(int receive_id) {
		this.receive_id = receive_id;
	}
	public int getPutin_id() {
		return putin_id;
	}
	public void setPutin_id(int putin_id) {
		this.putin_id = putin_id;
	}
	public long getCreate_time() {
		return create_time;
	}
	public void setCreate_time(long create_time) {
		this.create_time = create_time;
	}
	public long getPredict_time() {
		return predict_time;
	}
	public void setPredict_time(long predict_time) {
		this.predict_time = predict_time;
	}
	public long getAog_time() {
		return aog_time;
	}
	public void setAog_time(long aog_time) {
		this.aog_time = aog_time;
	}
	public int getAog_id() {
		return aog_id;
	}
	public void setAog_id(int aog_id) {
		this.aog_id = aog_id;
	}
	public int getCheck_id() {
		return check_id;
	}
	public void setCheck_id(int check_id) {
		this.check_id = check_id;
	}
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	public String getCreate_name() {
		return create_name;
	}
	public void setCreate_name(String create_name) {
		this.create_name = create_name;
	}
	public String getReceive_name() {
		return receive_name;
	}
	public void setReceive_name(String receive_name) {
		this.receive_name = receive_name;
	}
	public String getPredict_date() {
		return predict_date;
	}
	public void setPredict_date(String predict_date) {
		this.predict_date = predict_date;
	}
	public String getAog_date() {
		return aog_date;
	}
	public void setAog_date(String aog_date) {
		this.aog_date = aog_date;
	}
	public String getProcess() {
		return process;
	}
	public void setProcess(String process) {
		this.process = process;
	}
	public String getCheck_name() {
		return check_name;
	}
	public void setCheck_name(String check_name) {
		this.check_name = check_name;
	}
	public String getPutin_name() {
		return putin_name;
	}
	public void setPutin_name(String putin_name) {
		this.putin_name = putin_name;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}
