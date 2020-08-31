package com.zzqa.pojo.user;

import java.util.ArrayList;
import java.util.List;

import com.zzqa.pojo.performance.Performance;
import com.zzqa.pojo.position_user.Position_user;

public class User implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7385497255579820693L;
	private int id;
	private String name;//用户名
	private String password;
	private String truename;//真实姓名 自己不能改
	private String email;
	private int level;
	private long create_time;
	private long update_time;
	private int position_id;//职位id
	private String sendEmail;//type1;type2;type3        0：发邮件；1：不发邮件，默认发
	private List<Position_user> pList=new ArrayList<Position_user>();
	private List<Performance> performances=null;
	private String position_name;//职位名称

	public List<Performance> getPerformances() {
		return performances;
	}
	public void setPerformances(List<Performance> performances) {
		this.performances = performances;
	}
	public String getSendEmail() {
		return sendEmail;
	}
	public void setSendEmail(String sendEmail) {
		this.sendEmail = sendEmail;
	}
	public String getPosition_name() {
		return position_name;
	}
	public void setPosition_name(String position_name) {
		this.position_name = position_name;
	}
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
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getTruename() {
		return truename;
	}
	public void setTruename(String truename) {
		this.truename = truename;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
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
	public List<Position_user> getPList() {
		return pList;
	}
	public void setPList(List<Position_user> list) {
		pList = list;
	}
	public int getPosition_id() {
		return position_id;
	}
	public void setPosition_id(int position_id) {
		this.position_id = position_id;
	}
	public List<Position_user> getpList() {
		return pList;
	}
	public void setpList(List<Position_user> pList) {
		this.pList = pList;
	}
}
