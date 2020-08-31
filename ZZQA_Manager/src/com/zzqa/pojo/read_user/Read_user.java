package com.zzqa.pojo.read_user;

import java.io.Serializable;
/*******
 * 用户已读关联表
 * @author louph
 *
 */
public class Read_user implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 4136872499552540057L;
	private int id;
	private int type;//1:建议；:2：反馈；3：通知
	private int foreign_id;
	private int uid;
	private long update_time;
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
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public long getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(long update_time) {
		this.update_time = update_time;
	}
}
