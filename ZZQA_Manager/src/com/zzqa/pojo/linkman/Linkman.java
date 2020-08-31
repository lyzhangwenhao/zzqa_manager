package com.zzqa.pojo.linkman;

import java.io.Serializable;

public class Linkman implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 583055887969520758L;
	private int id;
	private int type;//100以下为流程对应type 101为邮件重置密码时记录验证信息
	private int foreign_id;//其他表主键id
	private String linkman;//联系人信息
	private String phone;//电话号码
	private int linkman_case;
	/***
	 *  type=1任务单0:当前任务单；1：修改前任务单
	 * type=6发货 无需修改，为0
	 */
	private int state;
	private long create_time;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public int getForeign_id() {
		return foreign_id;
	}
	public void setForeign_id(int foreign_id) {
		this.foreign_id = foreign_id;
	}
	public String getLinkman() {
		return linkman;
	}
	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public int getLinkman_case() {
		return linkman_case;
	}
	public void setLinkman_case(int linkman_case) {
		this.linkman_case = linkman_case;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public long getCreate_time() {
		return create_time;
	}
	public void setCreate_time(long create_time) {
		this.create_time = create_time;
	}
	
}
