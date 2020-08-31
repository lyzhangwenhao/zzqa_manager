package com.zzqa.pojo.vehicle;

public class Vehicle {
	private int id;
	private String name;//流程名称 如：用车申请表-2015.08.31
	private int approver;
	private String approve_name;
	private int executor;
	private String executor_name;
	private int apply_department;
	private String address;
	private String initial_address;//用车起始地
	private String vehicle_person;//乘用人员
	private long starttime;
	private String startdate;
	private long endtime;
	private String enddate;
	private String start_driver_date;
	private Long start_driver_time;//出发时间
	private String end_driver_date;
	private Long end_driver_time;//结束时间
	private String start_mail;
	private String end_mail;
	private String reason;
	private String remark;
	private int cost_attributable;
	private String mileage_used;
	private long create_time;
	private String create_date;
	private long update_time;
	private String update_date;
	private int create_id;
	private String create_name;
	private String process;//进度
	private int operation;//当前进度
	private String car_info;//车辆信息
	private int driver;//指定司机
	private String driverName;//司机姓名
	
	public String getDriverName() {
		return driverName;
	}
	public void setDriverName(String driverName) {
		this.driverName = driverName;
	}
	public Long getStart_driver_time() {
		return start_driver_time;
	}
	public void setStart_driver_time(Long start_driver_time) {
		this.start_driver_time = start_driver_time;
	}
	public Long getEnd_driver_time() {
		return end_driver_time;
	}
	public void setEnd_driver_time(Long end_driver_time) {
		this.end_driver_time = end_driver_time;
	}
	public String getStart_driver_date() {
		return start_driver_date;
	}
	public void setStart_driver_date(String start_driver_date) {
		this.start_driver_date = start_driver_date;
	}
	public String getEnd_driver_date() {
		return end_driver_date;
	}
	public void setEnd_driver_date(String end_driver_date) {
		this.end_driver_date = end_driver_date;
	}
	public String getStart_mail() {
		return start_mail;
	}
	public void setStart_mail(String start_mail) {
		this.start_mail = start_mail;
	}
	public String getEnd_mail() {
		return end_mail;
	}
	public void setEnd_mail(String end_mail) {
		this.end_mail = end_mail;
	}
	public String getCar_info() {
		return car_info;
	}
	public void setCar_info(String car_info) {
		this.car_info = car_info;
	}
	public int getDriver() {
		return driver;
	}
	public void setDriver(int driver) {
		this.driver = driver;
	}
	public int getOperation() {
		return operation;
	}
	public void setOperation(int operation) {
		this.operation = operation;
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
	public int getApprover() {
		return approver;
	}
	public void setApprover(int approver) {
		this.approver = approver;
	}
	public String getApprove_name() {
		return approve_name;
	}
	public void setApprove_name(String approve_name) {
		this.approve_name = approve_name;
	}
	public int getExecutor() {
		return executor;
	}
	public void setExecutor(int executor) {
		this.executor = executor;
	}
	public String getExecutor_name() {
		return executor_name;
	}
	public void setExecutor_name(String executor_name) {
		this.executor_name = executor_name;
	}
	public int getApply_department() {
		return apply_department;
	}
	public void setApply_department(int apply_department) {
		this.apply_department = apply_department;
	}
	public String getInitial_address() {
		return initial_address;
	}
	public void setInitial_address(String initial_address) {
		this.initial_address = initial_address;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getVehicle_person() {
		return vehicle_person;
	}
	public void setVehicle_person(String vehicle_person) {
		this.vehicle_person = vehicle_person;
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
	public long getEndtime() {
		return endtime;
	}
	public void setEndtime(long endtime) {
		this.endtime = endtime;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public int getCost_attributable() {
		return cost_attributable;
	}
	public void setCost_attributable(int cost_attributable) {
		this.cost_attributable = cost_attributable;
	}
	public String getMileage_used() {
		return mileage_used;
	}
	public void setMileage_used(String mileage_used) {
		this.mileage_used = mileage_used;
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
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
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
	public String getProcess() {
		return process;
	}
	public void setProcess(String process) {
		this.process = process;
	}
}
