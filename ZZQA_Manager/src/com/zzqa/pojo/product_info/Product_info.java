package com.zzqa.pojo.product_info;

import com.zzqa.util.DataUtil;

public class Product_info {
	private int id;
	private int sales_id;//销售合同id
	private int m_id;// 物料表的外键
	private int num;//数量
	private int purchase_num;//已采购数量
	private int last_num;//未采购数量
	private String model;
	private String materials_remark;
	private String materials_id;
	private double unit_price_taxes;//含税单价
	private String unit_price_taxes_str;//含税单价
	private double predict_costing_taxes;//预估含税成本
	private String predict_costing_taxes_str;//预估含税成本
	private long delivery_time;//交货期
	private String delivery_date;
	private String remark;//备注
	public int getPurchase_num() {
		return purchase_num;
	}
	public void setPurchase_num(int purchase_num) {
		this.purchase_num = purchase_num;
	}
	public String getUnit_price_taxes_str() {
		return unit_price_taxes_str;
	}
	public void setUnit_price_taxes_str(String unit_price_taxes_str) {
		this.unit_price_taxes_str = unit_price_taxes_str;
	}
	public String getPredict_costing_taxes_str() {
		return predict_costing_taxes_str;
	}
	public void setPredict_costing_taxes_str(String predict_costing_taxes_str) {
		this.predict_costing_taxes_str = predict_costing_taxes_str;
	}
	public int getLast_num() {
		return last_num;
	}
	public void setLast_num(int last_num) {
		this.last_num = last_num;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getMaterials_remark() {
		return materials_remark;
	}
	public void setMaterials_remark(String materials_remark) {
		this.materials_remark = materials_remark;
	}
	public String getMaterials_id() {
		return materials_id;
	}
	public void setMaterials_id(String materials_id) {
		this.materials_id = materials_id;
	}
	public int getSales_id() {
		return sales_id;
	}
	public void setSales_id(int sales_id) {
		this.sales_id = sales_id;
	}
	public int getM_id() {
		return m_id;
	}
	public void setM_id(int m_id) {
		this.m_id = m_id;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public double getUnit_price_taxes() {
		return unit_price_taxes;
	}
	public void setUnit_price_taxes(double unit_price_taxes) {
		this.unit_price_taxes = unit_price_taxes;
		setUnit_price_taxes_str(DataUtil.fixed(unit_price_taxes, 2));
	}
	public double getPredict_costing_taxes() {
		return predict_costing_taxes;
	}
	public void setPredict_costing_taxes(double predict_costing_taxes) {
		this.predict_costing_taxes = predict_costing_taxes;
		setPredict_costing_taxes_str(DataUtil.fixed(predict_costing_taxes, 2));
	}
	public long getDelivery_time() {
		return delivery_time;
	}
	public void setDelivery_time(long delivery_time) {
		this.delivery_time = delivery_time;
	}
	public String getDelivery_date() {
		return delivery_date;
	}
	public void setDelivery_date(String delivery_date) {
		this.delivery_date = delivery_date;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
}
