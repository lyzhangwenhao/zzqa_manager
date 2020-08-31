package com.zzqa.pojo.leave;

import java.io.Serializable;

public class Leave implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1135547308054386415L;
	private int id;
	private int attendance_id;//考勤备案人id
	private String attendance_name;//考勤备案人姓名
	private int department;//部门index
	private String department_name;//部门名称
	private int leave_type;//请假类型
	private String reason;//请假事由
	private long starttime;//开始时间
	private long endtime;//结束时间
	private String startDate;//2016/08/08 上午
	private String endDate;
	private int create_id;//创建者
	private String create_name;//创建者姓名
	private long create_time;//创建时间
	private String name;//流程名称
	private long update_time;//最后更新时间
	private String leaveType_name;//请假类型
	private int operation;
	private String process;//进度
	private boolean canBack;//可以考勤备案
	public void setCanBack(boolean canBack) {
		this.canBack = canBack;
	}
	public boolean isCanBack() {
		return canBack;
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
	public String getLeaveType_name() {
		return leaveType_name;
	}
	public void setLeaveType_name(String leaveType_name) {
		this.leaveType_name = leaveType_name;
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
	private String alldays;//请假天数
	public String getAlldays() {
		return alldays;
	}
	public void setAlldays(String alldays) {
		this.alldays = alldays;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getAttendance_id() {
		return attendance_id;
	}
	public void setAttendance_id(int attendance_id) {
		this.attendance_id = attendance_id;
	}
	public String getAttendance_name() {
		return attendance_name;
	}
	public void setAttendance_name(String attendance_name) {
		this.attendance_name = attendance_name;
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
	public int getLeave_type() {
		return leave_type;
	}
	public void setLeave_type(int leave_type) {
		this.leave_type = leave_type;
	}
}
