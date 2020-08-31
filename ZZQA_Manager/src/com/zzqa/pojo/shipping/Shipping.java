package com.zzqa.pojo.shipping;

import java.io.Serializable;
import java.util.List;

import com.zzqa.pojo.shipping_list.Shipping_list;

public class Shipping implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 4867157715578566451L;
	private int id;
	private int sales_id;
	private long create_time;
	private String project_name;//项目名称
	private String customer_name;//客户名称
	private String saler;//销售人员
	private String contract_no;//销售合同编号
	private String customer_contract_no;//客户号
	private String create_date;
	private int create_id;
	private String create_name;
	private int material_man_id;
	private String material_man_name;//领料人
	private int shipper_id;//发货执行人
	private String shipper_name;
	private long putout_time;//出库时间
	private String material_type;//领料类型
	private int department;//领料部门（索引）
	private String depart;//领料部门
	private String putout_date;
	private String address;//发货地址
	private String linkman;//
	private String linkman_phone;//联系方式
	private long ship_time;//实际发货时间
	private String ship_date;//实际发货时间
	private String logistics_num;//件数
	private String logistics_company;//物流公司
	private String orderId;//订单号
	private String name;//流程名称
	private String process;//进度
	private List<Shipping_list> shipping_lists=null;

	public String getSaler() {
		return saler;
	}
	public void setSaler(String saler) {
		this.saler = saler;
	}
	public long getPutout_time() {
		return putout_time;
	}
	public String getDepart() {
		return depart;
	}
	public void setDepart(String depart) {
		this.depart = depart;
	}
	public void setPutout_time(long putout_time) {
		this.putout_time = putout_time;
	}
	public String getMaterial_type() {
		return material_type;
	}
	public void setMaterial_type(String material_type) {
		this.material_type = material_type;
	}
	public int getDepartment() {
		return department;
	}
	public void setDepartment(int department) {
		this.department = department;
	}
	public String getPutout_date() {
		return putout_date;
	}
	public void setPutout_date(String putout_date) {
		this.putout_date = putout_date;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public List<Shipping_list> getShipping_lists() {
		return shipping_lists;
	}
	public void setShipping_lists(List<Shipping_list> shipping_lists) {
		this.shipping_lists = shipping_lists;
	}
	public int getId() {
		return id;
	}
	public String getProject_name() {
		return project_name;
	}
	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}
	public String getCustomer_name() {
		return customer_name;
	}
	public void setCustomer_name(String customer_name) {
		this.customer_name = customer_name;
	}
	public String getContract_no() {
		return contract_no;
	}
	public void setContract_no(String contract_no) {
		this.contract_no = contract_no;
	}
	public String getCustomer_contract_no() {
		return customer_contract_no;
	}
	public void setCustomer_contract_no(String customer_contract_no) {
		this.customer_contract_no = customer_contract_no;
	}
	public String getShip_date() {
		return ship_date;
	}
	public void setShip_date(String ship_date) {
		this.ship_date = ship_date;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSales_id() {
		return sales_id;
	}
	public void setSales_id(int sales_id) {
		this.sales_id = sales_id;
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
	public int getMaterial_man_id() {
		return material_man_id;
	}
	public void setMaterial_man_id(int material_man_id) {
		this.material_man_id = material_man_id;
	}
	public String getMaterial_man_name() {
		return material_man_name;
	}
	public void setMaterial_man_name(String material_man_name) {
		this.material_man_name = material_man_name;
	}
	public int getShipper_id() {
		return shipper_id;
	}
	public void setShipper_id(int shipper_id) {
		this.shipper_id = shipper_id;
	}
	public String getShipper_name() {
		return shipper_name;
	}
	public void setShipper_name(String shipper_name) {
		this.shipper_name = shipper_name;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getLinkman() {
		return linkman;
	}
	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}
	public String getLinkman_phone() {
		return linkman_phone;
	}
	public void setLinkman_phone(String linkman_phone) {
		this.linkman_phone = linkman_phone;
	}
	public long getShip_time() {
		return ship_time;
	}
	public void setShip_time(long ship_time) {
		this.ship_time = ship_time;
	}
	public String getLogistics_num() {
		return logistics_num;
	}
	public void setLogistics_num(String logistics_num) {
		this.logistics_num = logistics_num;
	}
	public String getLogistics_company() {
		return logistics_company;
	}
	public void setLogistics_company(String logistics_company) {
		this.logistics_company = logistics_company;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getProcess() {
		return process;
	}
	public void setProcess(String process) {
		this.process = process;
	}
}
