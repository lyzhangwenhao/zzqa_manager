package com.zzqa.pojo.aftersales_task;

public class Aftersales_task {
	private int id;//唯一序号
	private String name;//流程名称
	private int project_category;//项目类型 0：发电；1：石化；3：售后项目
	private int product_type;//产品类型 0：CS2000；1：CS2200；2:DS9000；3：DS9100有线版；4：DS9100无线版
	private String project_id;//项目编号
	private String project_name;//项目名称
	private int project_case;//项目情况 0：普项；1：急项
	private int create_id;//创建者id
	private String create_name;//创建者姓名
	private long create_time;//创建时间戳
	private long update_time;//修改时间戳
	private String process;//进度描述
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getProject_category() {
		return project_category;
	}
	public void setProject_category(int project_category) {
		this.project_category = project_category;
	}
	public int getProduct_type() {
		return product_type;
	}
	public void setProduct_type(int product_type) {
		this.product_type = product_type;
	}
	public String getProject_id() {
		return project_id;
	}
	public void setProject_id(String project_id) {
		this.project_id = project_id;
	}
	public String getProject_name() {
		return project_name;
	}
	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}
	public int getProject_case() {
		return project_case;
	}
	public void setProject_case(int project_case) {
		this.project_case = project_case;
	}
	public int getCreate_id() {
		return create_id;
	}
	public void setCreate_id(int create_id) {
		this.create_id = create_id;
	}
	public String getCreate_name() {
		return create_name;
	}
	public void setCreate_name(String create_name) {
		this.create_name = create_name;
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
	public String getProcess() {
		return process;
	}
	public void setProcess(String process) {
		this.process = process;
	}
}
