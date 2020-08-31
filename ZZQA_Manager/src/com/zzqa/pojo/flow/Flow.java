package com.zzqa.pojo.flow;

import java.io.Serializable;
import java.rmi.server.UID;

public class Flow implements Serializable {
	private int id;
	private String flowcode;//流程编号
	private String flowname;//流程名称
	private String username;
	private int type;//1:任务单；2：采购；3：生产；4：外协生产流程；5：发货
	private int foreign_id;//其他表主键id
	/****
	 * type=1任务单操作类型 1:等待或修改，商务助理签字；2：新建或修改,等待销售经理签字；3：商务助理通过，等待项目主管审核；
	 * 		4：项目主管通过，等待销售经理审核； 5：销售经理通过，发给生产主管；6：销售经理通过，等待项目主管审核；
	 * 		7：项目主管通过，等待商务助理审核；8：商务助理通过，发给生产主管；9：商务助理不通过；10：项目中心经理不通过；
	 * 		11：销售经理不通过；（后续的流程再加）
	 * 
	 * type=2生产采购操作类型 1:生产主管创建生产采购需求表；2：运行总监审批通过；3：运行总监审批未通过；
	 * 		4：采购人员采购单审核；5：采购人员填写预计到货时间（采购和到货之间）:6：生产主管确认到货；
	 * 		7：生产主管验货，并完成统计；8：仓库管理员确认入库
	 * type=3项目采购操作类型 1:生产主管新建,提交项目预算表；2：项目经理审核预算通过；3：项目经理审核未通过；
	 * 		4:生产主管创建生产采购需求表；5：运行总监审批通过；6：运行总监审批未通过；7 ：采购人员采购单审核；
	 * 		8：采购人员填写预计到货时间（采购和到货之间）:9：生产主管确认到货；10：生产主管验货，并完成统计；
	 * 		11：仓库管理员确认入库
	 * type=4外协生产操作类型 1:生产主管创建外协生产单，关联生产采购，提交外协生产需求表；2：出库，采购确认发货；
	 * 		3：采购人员预计外协品到货时间；4:生产主管确认到货时间；9：生产主管验货，并完成统计；
	 * 		10：仓库管理员确认入库
	 * type=5生产测试类型1：新建；2：备料；3：出库；4：生产；5：生产完毕；6：入库
	 *
	 * type=6发货流程1：新建；2：出库；3：发货单据；4：发货；5：到货；6：完成
	 * 
	 */
	private int operation;
	private int uid;//操作者id
	private int driver;//type=15  （专有）司机
	private String reason;//理由
	private long create_time;//操作时间
	private String create_date;//操作时间
	private long jump_id;//跳转所需的参数
	
	public int getDriver() {
		return driver;
	}
	public void setDriver(int driver) {
		this.driver = driver;
	}
	public long getJump_id() {
		return jump_id;
	}
	public void setJump_id(long jump_id) {
		this.jump_id = jump_id;
	}
	public String getFlowcode() {
		return flowcode;
	}
	public void setFlowcode(String flowcode) {
		this.flowcode = flowcode;
	}
	public String getFlowname() {
		return flowname;
	}
	public void setFlowname(String flowname) {
		this.flowname = flowname;
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
	public int getOperation() {
		return operation;
	}
	public void setOperation(int operation) {
		this.operation = operation;
	}
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
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
	
	
}
