package com.zzqa.pojo.procurement;

import java.io.Serializable;

public class Procurement implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -479564608558000678L;
	private int id;
	/***************************************************************************
	 * 关联外表 type=1 生产采购表；type=2 项目采购表；type=3 外协生产；
	 */
	private int type;
	private int foreign_id;
	private String name;// 产品名称
	private String agent;// 品牌/代理商
	private String model;// 规格/型号
	private int num;// 数量
	private String unit;// 单位
	private float pass_percent=-1;// 合格率 默认为-1
	private String percent;
	private int state;//状态 0：未采购；1：采购中；2：到货；3：完成验货
	private String materials_code;//物料编码
	public String getMaterials_code() {
		return materials_code;
	}

	public void setMaterials_code(String materials_code) {
		this.materials_code = materials_code;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getPercent() {
		return percent;
	}

	public void setPercent(String percent) {
		this.percent = percent;
	}

	private long predict_time;
	private String predict_date;// 预计到货时间
	private long aog_time;
	public long getPredict_time() {
		return predict_time;
	}

	public void setPredict_time(long predict_time) {
		this.predict_time = predict_time;
	}

	public long getAog_time() {
		return aog_time;
	}

	public void setAog_time(long aog_time) {
		this.aog_time = aog_time;
	}

	private String aog_date;// 实际到货时间

	public String getPredict_date() {
		return predict_date;
	}

	public void setPredict_date(String predict_date) {
		this.predict_date = predict_date;
	}

	public String getAog_date() {
		return aog_date;
	}

	public void setAog_date(String aog_date) {
		this.aog_date = aog_date;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAgent() {
		return agent;
	}

	public void setAgent(String agent) {
		this.agent = agent;
	}

	public String getModel() {
		return model;
	}

	public void setModel(String model) {
		this.model = model;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public float getPass_percent() {
		return pass_percent;
	}

	public void setPass_percent(float pass_percent) {
		this.pass_percent = pass_percent;
	}
}
