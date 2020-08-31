package com.zzqa.pojo.operation;

import java.io.Serializable;

public class Operation implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4779015864400913753L;
	private int id;
	private String content;//操作日志
	private int uid;//操作者
	private int position_index;//职位编号
	private int position_id;//职位id
	public int getPosition_id() {
		return position_id;
	}
	public void setPosition_id(int position_id) {
		this.position_id = position_id;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	private String positionName;//职位名称
	private String username;//操作者姓名
	private long create_time;//操作时间戳
	private String create_date;//操作时间
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public long getCreate_time() {
		return create_time;
	}
	public void setCreate_time(long create_time) {
		this.create_time = create_time;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	public int getPosition_index() {
		return position_index;
	}
	public void setPosition_index(int position_index) {
		this.position_index = position_index;
	}
	public String getPositionName() {
		return positionName;
	}
	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}
	
}
