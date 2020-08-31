package com.zzqa.pojo.shipping_list;

import java.io.Serializable;
import java.util.List;

public class Shipping_list implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -3924929215606386386L;
	private int id;
	private int shipping_id;
	private int product_id;//产品id
	private int m_id;//物料id
	private String materials_id;//物料编码
	private String name;//设备名称
	private String model;
	private String unit;//单位
	private String quality_no;//质证号
	private int contract_num;//合同数量
	private int last_num;//未发货数量
	private float unit_price;//单价
	private int num;//本次发货数量
	private String remark;//备注
	private String logistics_demand;//物流要求
	public String getQuality_no() {
		return quality_no;
	}
	public void setQuality_no(String quality_no) {
		this.quality_no = quality_no;
	}
	public String getMaterials_id() {
		return materials_id;
	}
	public void setMaterials_id(String materials_id) {
		this.materials_id = materials_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public int getLast_num() {
		return last_num;
	}
	public void setLast_num(int last_num) {
		this.last_num = last_num;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getShipping_id() {
		return shipping_id;
	}
	public void setShipping_id(int shipping_id) {
		this.shipping_id = shipping_id;
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public int getM_id() {
		return m_id;
	}
	public void setM_id(int m_id) {
		this.m_id = m_id;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public int getContract_num() {
		return contract_num;
	}
	public void setContract_num(int contract_num) {
		this.contract_num = contract_num;
	}
	public float getUnit_price() {
		return unit_price;
	}
	public void setUnit_price(float unit_price) {
		this.unit_price = unit_price;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getLogistics_demand() {
		return logistics_demand;
	}
	public void setLogistics_demand(String logistics_demand) {
		this.logistics_demand = logistics_demand;
	}
}
