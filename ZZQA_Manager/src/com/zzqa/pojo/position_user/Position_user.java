package com.zzqa.pojo.position_user;

import java.io.Serializable;

public class Position_user implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -1922383790740092352L;
	private int id;
	private int uid;// 用户id
	/***
	 * 职位 1:销售人员;2:商务助理；3：项目主管；4:销售经理；5：生产主管； 6：采购人员；7运行总监；:8：仓库管理员
	 */
	private int position_id;
	private String position_name;// 职位名称
	private int parent;// 上级职位

	public String getPosition_name() {
		return position_name;
	}

	public void setPosition_name(String position_name) {
		this.position_name = position_name;
	}

	public int getParent() {
		return parent;
	}

	public void setParent(int parent) {
		this.parent = parent;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}

	public int getPosition_id() {
		return position_id;
	}

	public void setPosition_id(int position_id) {
		this.position_id = position_id;
	}
}
