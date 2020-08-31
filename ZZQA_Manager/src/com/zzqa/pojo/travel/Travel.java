package com.zzqa.pojo.travel;

import java.io.Serializable;

/*****
 * 出差表
 * 
 * @author FPGA
 * 
 */
public class Travel implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7757501030546934037L;
	private int id;
	private int financial_id;// 财务备案人id
	private String financial_name;// 财务备案人姓名
	private int attendance_id;// 考勤备案人id
	private String attendance_name;// 考勤备案人姓名
	private int department;// 部门index
	private String department_name;// 部门名称
	private String address;// 出差地
	private String reason;// 出差事由
	private long starttime;// 开始时间
	private long endtime;// 结束时间
	private int halfDay1;// 0：上午，1：下午
	private int halfDay2;// 0：上午，1：下午
	private String startDate;// 2016/08/08
	private String endDate;
	private int create_id;// 创建者
	private String create_name;// 创建者姓名
	private long create_time;// 创建时间
	private String name;// 流程名称 如：出差单-2016.08.29或出差单-2016.8.6日上午到2016年8月7日下午
	private String process;// 进度
	private String alldays;// 出差天数
	private boolean ifDelay;//是否延时
	private boolean ifResumption;//是否有销假
	private boolean canBack;//可以考勤备案
	public boolean isCanBack() {
		return canBack;
	}

	public void setCanBack(boolean canBack) {
		this.canBack = canBack;
	}

	public boolean isIfDelay() {
		return ifDelay;
	}

	public void setIfDelay(boolean ifDelay) {
		this.ifDelay = ifDelay;
	}

	public boolean isIfResumption() {
		return ifResumption;
	}

	public void setIfResumption(boolean ifResumption) {
		this.ifResumption = ifResumption;
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
	public String getAlldays() {
		return alldays;
	}

	public void setAlldays(String alldays) {
		this.alldays = alldays;
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

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAttendance_name() {
		return attendance_name;
	}

	public void setAttendance_name(String attendance_name) {
		this.attendance_name = attendance_name;
	}

	public int getFinancial_id() {
		return financial_id;
	}

	public void setFinancial_id(int financial_id) {
		this.financial_id = financial_id;
	}

	public String getFinancial_name() {
		return financial_name;
	}

	public void setFinancial_name(String financial_name) {
		this.financial_name = financial_name;
	}

	public int getAttendance_id() {
		return attendance_id;
	}

	public void setAttendance_id(int attendance_id) {
		this.attendance_id = attendance_id;
	}

	public int getDepartment() {
		return department;
	}

	public void setDepartment(int department) {
		this.department = department;
	}

	public String getDepartment_name() {
		return department_name;
	}

	public void setDepartment_name(String department_name) {
		this.department_name = department_name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
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

	public long getEndtime() {
		return endtime;
	}

	public void setEndtime(long endtime) {
		this.endtime = endtime;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
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
}
