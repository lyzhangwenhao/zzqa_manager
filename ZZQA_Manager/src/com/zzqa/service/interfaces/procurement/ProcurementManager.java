package com.zzqa.service.interfaces.procurement;

import java.util.List;

import com.zzqa.pojo.procurement.Procurement;

public interface ProcurementManager {
	//添加
	public void insertProcurement(Procurement procurement);
	//更新
	public void updateProcurement(Procurement procurement);
	//根据条件查询记录条数
	public int getProcurementCountLimit(int type,int foreign_id);
	//根据条件查询
	public List<Procurement> getProcurementListLimit(int type,int foreign_id);
	//根据条件查询
	public List getProcurementList(int type,int foreign_id);
	//通过id查找
	public Procurement getProcurementByID(int id);
	//根据条件删除
	public void deleteProcurementLimit(int type,int foreign_id);
}
