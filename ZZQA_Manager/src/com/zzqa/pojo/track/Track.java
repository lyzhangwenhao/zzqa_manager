package com.zzqa.pojo.track;

import java.util.ArrayList;
import java.util.List;

import com.zzqa.pojo.linkman.Linkman;

public class Track {
	private int id;
	private int create_id;
	private String create_name;
	private long create_time;
	private String create_date;
	private long state_time;//状态所属时间 月份
	private String state_date;//  yyyy-MM
	private long update_time;
	private long update_date;
	private String process;
	private String name;
	public long getState_time() {
		return state_time;
	}
	public void setState_time(long state_time) {
		this.state_time = state_time;
	}
	public String getState_date() {
		return state_date;
	}
	public void setState_date(String state_date) {
		this.state_date = state_date;
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
	private List<Linkman> list=new ArrayList<Linkman>();
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	public long getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(long update_time) {
		this.update_time = update_time;
	}
	public long getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(long update_date) {
		this.update_date = update_date;
	}
	public List<Linkman> getList() {
		return list;
	}
	public void setList(List<Linkman> list) {
		this.list = list;
	}
}
