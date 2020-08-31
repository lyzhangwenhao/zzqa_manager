package com.zzqa.pojo.deliver;

import java.util.List;

import com.zzqa.pojo.deliver_content.Deliver_content;
import com.zzqa.pojo.flow.Flow;

/***
 * 出库表
 * @author Administrator
 *
 */
public class Deliver {
	private int id;
	private String project_name;
	private String project_id;
	private int material_type;
	private int department_index;
	private int create_id;
	private String create_name;
	private long create_time;
	private long update_time;
	private String name;
	private String process;
	private int operation;
	private List<Deliver_content> items=null;
	private List<Flow> flows=null;
	private boolean leader;
	private boolean keeper;

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
	public long getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(long update_time) {
		this.update_time = update_time;
	}
	public String getCreate_name() {
		return create_name;
	}
	public void setCreate_name(String create_name) {
		this.create_name = create_name;
	}
	public List<Flow> getFlows() {
		return flows;
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
	public void setFlows(List<Flow> flows) {
		this.flows = flows;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getProject_name() {
		return project_name;
	}
	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}
	public String getProject_id() {
		return project_id;
	}
	public void setProject_id(String project_id) {
		this.project_id = project_id;
	}
	public int getMaterial_type() {
		return material_type;
	}
	public void setMaterial_type(int material_type) {
		this.material_type = material_type;
	}
	public int getDepartment_index() {
		return department_index;
	}
	public void setDepartment_index(int department_index) {
		this.department_index = department_index;
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
	public List<Deliver_content> getItems() {
		return items;
	}
	public void setItems(List<Deliver_content> items) {
		this.items = items;
	}
}
