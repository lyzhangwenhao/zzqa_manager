package com.zzqa.pojo.comments;

import java.io.Serializable;
import java.util.List;

import com.zzqa.pojo.reply.Reply;
/*****
 * 评论表
 * @author louph
 *
 */
public class Comments implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5992293221336643771L;
	private int id;
	private int type;//1:建议；2：反馈；3：通知
	private int foreign_id;
	private String content;//评论内容
	private int agree;//点赞数
	private boolean isagree;//我是否点赞
	private int create_id;
	private String create_name;
	private long create_time;
	private long update_time;
	private String update_date;
	private List<Reply> replyList;
	public boolean isIsagree() {
		return isagree;
	}
	public void setIsagree(boolean isagree) {
		this.isagree = isagree;
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
	public List<Reply> getReplyList() {
		return replyList;
	}
	public void setReplyList(List<Reply> replyList) {
		this.replyList = replyList;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
