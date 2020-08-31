package com.zzqa.pojo.reply;

import java.io.Serializable;
/******
 * 回复表
 * @author louph
 *
 */
public class Reply implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -1129801810275855866L;
	private int id;
	private int comment_id;//评论id
	private int reply_id;//被回复内容的id
	private boolean isagree;//本人是否点赞
	private int reply_uid;//被回复者id
	private String reply_name;//被回复内容的用户
	private String content;//回复内容
	private int agree;//点赞数
	private int create_id;
	private String create_name;
	private long create_time;
	private long update_time;
	private String update_date;
	public int getReply_uid() {
		return reply_uid;
	}
	public void setReply_uid(int reply_uid) {
		this.reply_uid = reply_uid;
	}
	public String getCreate_name() {
		return create_name;
	}
	public void setCreate_name(String create_name) {
		this.create_name = create_name;
	}
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}
	public boolean isIsagree() {
		return isagree;
	}
	public void setIsagree(boolean isagree) {
		this.isagree = isagree;
	}
	public int getComment_id() {
		return comment_id;
	}
	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}
	public String getReply_name() {
		return reply_name;
	}
	public void setReply_name(String reply_name) {
		this.reply_name = reply_name;
	}
	public long getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(long update_time) {
		this.update_time = update_time;
	}
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
	public int getReply_id() {
		return reply_id;
	}
	public void setReply_id(int reply_id) {
		this.reply_id = reply_id;
	}
	public int getAgree() {
		return agree;
	}
	public void setAgree(int agree) {
		this.agree = agree;
	}
	public int getCreate_id() {
		return create_id;
	}
	public void setCreate_id(int create_id) {
		this.create_id = create_id;
	}
	public long getCreate_time() {
		return create_time;
	}
	public void setCreate_time(long create_time) {
		this.create_time = create_time;
	}

}
