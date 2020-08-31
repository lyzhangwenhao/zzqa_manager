package com.zzqa.pojo.purchase_note;

import com.zzqa.util.DataUtil;

/****
 * 采购信息表
 * @author louph
 *
 */
public class Purchase_note {
	private int id;
	private int sales_id;//销售合同id
	private String contract_no;//销售合同号
	private String project_name;//项目名称
	private String customer;//客户名称
	private int purchase_id;//采购合同id;
	private int product_id;//产品id
	private int m_id;//物料id
	private String materials_id;//物料编码
	private String model;//型号
	private int hasbuy_num;//已采购数量 
	private int aog_num;//到货数量 
	private long aog_time;//到货时间
	private String aog_date;
	private int contract_num;//合同数量 
	private int num;
	private int last_num;//未采购数量
	private double sale_unit_price_taxes;//销售含税单价
	private double unit_price_taxes;//含税单价
	private String unit_price_taxes_str;//含税单价
	private double predict_costing_taxes;//预计成本
	private String predict_costing_taxes_str;//预计成本
	private long delivery_time;//交货期
	private String delivery_date;
	private String materials_remark;
	private String remark;
	private int operation;//对应采购合同的进度
	public double getSale_unit_price_taxes() {
		return sale_unit_price_taxes;
	}
	public void setSale_unit_price_taxes(double sale_unit_price_taxes) {
		this.sale_unit_price_taxes = sale_unit_price_taxes;
	}
	public int getOperation() {
		return operation;
	}
	public int getAog_num() {
		return aog_num;
	}
	public void setAog_num(int aog_num) {
		this.aog_num = aog_num;
	}
	public long getAog_time() {
		return aog_time;
	}
	public void setAog_time(long aog_time) {
		this.aog_time = aog_time;
	}
	public String getAog_date() {
		return aog_date;
	}
	public void setAog_date(String aog_date) {
		this.aog_date = aog_date;
	}
	public void setOperation(int operation) {
		this.operation = operation;
	}
	public int getHasbuy_num() {
		return hasbuy_num;
	}
	public void setHasbuy_num(int hasbuy_num) {
		this.hasbuy_num = hasbuy_num;
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
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public int getContract_num() {
		return contract_num;
	}
	public void setContract_num(int contract_num) {
		this.contract_num = contract_num;
	}
	public int getLast_num() {
		return last_num;
	}
	public void setLast_num(int last_num) {
		this.last_num = last_num;
	}
	public String getProject_name() {
		return project_name;
	}
	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}
	public String getCustomer() {
		return customer;
	}
	public void setCustomer(String customer) {
		this.customer = customer;
	}
	public String getContract_no() {
		return contract_no;
	}
	public void setContract_no(String contract_no) {
		this.contract_no = contract_no;
	}
	public int getId() {
		return id;
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
	public int getPurchase_id() {
		return purchase_id;
	}
	public void setPurchase_id(int purchase_id) {
		this.purchase_id = purchase_id;
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
