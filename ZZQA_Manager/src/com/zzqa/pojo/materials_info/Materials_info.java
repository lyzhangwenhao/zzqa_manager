package com.zzqa.pojo.materials_info;

public class Materials_info {
	private int id;
	private String unit;//单位
	private String model;//型号 主键
	private String materials_id;//物料编码
	private String remark;//产品描述 设备名称
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getMaterials_id() {
		return materials_id;
	}
	public void setMaterials_id(String materials_id) {
		this.materials_id = materials_id;
	}
}
