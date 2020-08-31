package com.zzqa.pojo.departmentPuchase;

import java.util.List;

import com.zzqa.pojo.departePuchase_content.DepartePuchase_content;
import com.zzqa.pojo.flow.Flow;

/***
 * 出库表
 * @author Administrator
 *
 */
public class DepartmentPuchase {
	private int id;
	private String purchaseName;//申购人
	private String purchaseTime;//申购时间
	private String purchaseNum;//申购编号
	private int create_id;//申购人id
	private long create_time;
	private long update_time;
	private String name;
	private String process;
	private int operation;
	private List<DepartePuchase_content> items=null;
	private List<Flow> flows=null;
	private boolean leader;
	private boolean keeper;
	private boolean buyer;
	private boolean checker;
	
	public boolean isChecker() {
		return checker;
	}
	public void setChecker(boolean checker) {
		this.checker = checker;
	}
	public boolean isBuyer() {
		return buyer;
	}
	public void setBuyer(boolean buyer) {
		this.buyer = buyer;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPurchaseName() {
		return purchaseName;
	}
	public void setPurchaseName(String purchaseName) {
		this.purchaseName = purchaseName;
	}
	public String getPurchaseTime() {
		return purchaseTime;
	}
	public void setPurchaseTime(String purchaseTime) {
		this.purchaseTime = purchaseTime;
	}
	public String getPurchaseNum() {
		return purchaseNum;
	}
	public void setPurchaseNum(String purchaseNum) {
		this.purchaseNum = purchaseNum;
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
	public long getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(long update_time) {
		this.update_time = update_time;
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
	public int getOperation() {
		return operation;
	}
	public void setOperation(int operation) {
		this.operation = operation;
	}
	public List<DepartePuchase_content> getItems() {
		return items;
	}
	public void setItems(List<DepartePuchase_content> items) {
		this.items = items;
	}
	public List<Flow> getFlows() {
		return flows;
	}
	public void setFlows(List<Flow> flows) {
		this.flows = flows;
	}
	public boolean isLeader() {
		return leader;
	}
	public void setLeader(boolean leader) {
		this.leader = leader;
	}
	public boolean isKeeper() {
		return keeper;
	}
	public void setKeeper(boolean keeper) {
		this.keeper = keeper;
	}

}
