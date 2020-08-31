package com.zzqa.pojo.departePuchase_content;

public class DepartePuchase_content {
	private int id;
	private int departePuchase_id;//
	private String material_id;//庆安物料编码
	private String material_name;//物料名称
	private String model;//型号
	private String processMaterial;//工艺材料/封装
	private int num;//数量
	private String involveProject;//涉及项目
	private String remark;//特殊要求
	private long predict_time;
	private String predict_date;// 预计到货时间
	private long aog_time;
	private String aog_date;// 实际到货时间
//	private float estimatePrice;//预估单价
	
	public int getId() {
		return id;
	}
	public long getPredict_time() {
		return predict_time;
	}
	public void setPredict_time(long predict_time) {
		this.predict_time = predict_time;
	}
	public String getPredict_date() {
		return predict_date;
	}
	public void setPredict_date(String predict_date) {
		this.predict_date = predict_date;
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
	public void setId(int id) {
		this.id = id;
	}
	public int getDepartePuchase_id() {
		return departePuchase_id;
	}
	public void setDepartePuchase_id(int departePuchase_id) {
		this.departePuchase_id = departePuchase_id;
	}
	public String getMaterial_id() {
		return material_id;
	}
	public void setMaterial_id(String material_id) {
		this.material_id = material_id;
	}
	public String getMaterial_name() {
		return material_name;
	}
	public void setMaterial_name(String material_name) {
		this.material_name = material_name;
	}
	public String getModel() {
		return model;
	}
	public void setModel(String model) {
		this.model = model;
	}
	public String getProcessMaterial() {
		return processMaterial;
	}
	public void setProcessMaterial(String processMaterial) {
		this.processMaterial = processMaterial;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getInvolveProject() {
		return involveProject;
	}
	public void setInvolveProject(String involveProject) {
		this.involveProject = involveProject;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
//	public float getEstimatePrice() {
//		return estimatePrice;
//	}
//	public void setEstimatePrice(float estimatePrice) {
//		this.estimatePrice = estimatePrice;
//	}
}
