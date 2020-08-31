package com.zzqa.pojo.device;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import com.zzqa.pojo.file_path.File_path;
import com.zzqa.pojo.material.Material;

public class Device implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 5616644322589530560L;
	private int id;
	private String idStr;//8
	private int m_id;
	private String sn;//批次号
	private int qualify;//状态：0:不合格；1：合格
	private int update_id;//最后操作者id 不能为空
	private long update_time;//最后更新时间戳
	private File_path file_path;//最新附件
	private String project_id;
	private String project_name;
	private String create_date;
	private String putin_date;
	private int ship_id;//绑定发货单 0表示未发货
	private String address;
	private String ship_date;
	private String aog_date;
	private int state;
	private List<Material> materList=new ArrayList<Material>();
	public List<Material> getMaterList() {
		return materList;
	}
	public void setMaterList(List<Material> materList) {
		this.materList = materList;
	}
	public File_path getFile_path() {
		return file_path;
	}
	public void setFile_path(File_path file_path) {
		this.file_path = file_path;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSn() {
		return sn;
	}
	public void setSn(String sn) {
		this.sn = sn;
	}
	public int getQualify() {
		return qualify;
	}
	public void setQualify(int qualify) {
		this.qualify = qualify;
	}
	public int getUpdate_id() {
		return update_id;
	}
	public void setUpdate_id(int update_id) {
		this.update_id = update_id;
	}
	public int getM_id() {
		return m_id;
	}
	public void setM_id(int m_id) {
		this.m_id = m_id;
	}
	public long getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(long update_time) {
		this.update_time = update_time;
	}
	public String getProject_id() {
		return project_id;
	}
	public void setProject_id(String project_id) {
		this.project_id = project_id;
	}
	public String getProject_name() {
		return project_name;
	}
	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	public String getPutin_date() {
		return putin_date;
	}
	public void setPutin_date(String putin_date) {
		this.putin_date = putin_date;
	}
	public String getShip_date() {
		return ship_date;
	}
	public void setShip_date(String ship_date) {
		this.ship_date = ship_date;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	public String getAog_date() {
		return aog_date;
	}
	public void setAog_date(String aog_date) {
		this.aog_date = aog_date;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public int getShip_id() {
		return ship_id;
	}
	public void setShip_id(int ship_id) {
		this.ship_id = ship_id;
	}
	public String getIdStr() {
		return idStr;
	}
	public void setIdStr(String idStr) {
		this.idStr = idStr;
	}
}
