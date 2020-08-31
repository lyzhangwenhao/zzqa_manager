package com.zzqa.pojo.resumption;

import java.io.Serializable;
/*****
 * 销假单
 * @author louph
 *
 */
public class Resumption implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -4919387261454732483L;
	private int id;
	private String name;//流程名称 如：销假单-2015.08.31
	private int type;//1：关联出差；2：关联请假(注：关联出差单功能已关闭，已关联的不显示)
	private int foreign_id;
	private String reason;//销假理由
	private String foreign_name;//关联单据名称
	private long starttime;//开始时间
	private String startdate;//返回日期 如：2016年8月11日上午
	private long reback_time;//返回时间
	private String reback_date;//返回日期 如：2016年8月12日上午
	private int halfDay1;//0:上午；1:下午
	private int halfDay2;//0:上午；1:下午
	private String minDate;//2016年8月11日上午
	private String maxDate;//最大时间上限，格式如：2016年8月11日下午
	private int create_id;//创建者id
	private String create_name;
	private int check_id;//行政审核者id
	private String check_name;
	private long create_time;
	private String create_date;
	private long update_time;
	private int operation;
	private String process;//进度
	private boolean canBack;//是否可以考勤备案
	public boolean isCanBack() {
		return canBack;
	}
	public void setCanBack(boolean canBack) {
		this.canBack = canBack;
	}
	public long getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(long update_time) {
		this.update_time = update_time;
	}
	public int getOperation() {
		return operation;
	}
	public void setOperation(int operation) {
		this.operation = operation;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public long getStarttime() {
		return starttime;
	}
	public void setStarttime(long starttime) {
		this.starttime = starttime;
	}
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getHalfDay1() {
		return halfDay1;
	}
	public void setHalfDay1(int halfDay1) {
		this.halfDay1 = halfDay1;
	}
	public int getHalfDay2() {
		return halfDay2;
	}
	public void setHalfDay2(int halfDay2) {
		this.halfDay2 = halfDay2;
	}
	public String getMinDate() {
		return minDate;
	}
	public void setMinDate(String minDate) {
		this.minDate = minDate;
	}
	public String getMaxDate() {
		return maxDate;
	}
	public void setMaxDate(String maxDate) {
		this.maxDate = maxDate;
	}
	public String getReback_date() {
		return reback_date;
	}
	public void setReback_date(String reback_date) {
		this.reback_date = reback_date;
	}
	public String getForeign_name() {
		return foreign_name;
	}
	public void setForeign_name(String foreign_name) {
		this.foreign_name = foreign_name;
	}
	public int getCheck_id() {
		return check_id;
	}
	public void setCheck_id(int check_id) {
		this.check_id = check_id;
	}
	public String getCheck_name() {
		return check_name;
	}
	public void setCheck_name(String check_name) {
		this.check_name = check_name;
	}
	public String getProcess() {
		return process;
	}
	public void setProcess(String process) {
		this.process = process;
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
	public long getReback_time() {
		return reback_time;
	}
	public void setReback_time(long reback_time) {
		this.reback_time = reback_time;
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
}
