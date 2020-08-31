package com.zzqa.service.impl.procurement;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.procurement.IProcurementDAO;
import com.zzqa.pojo.procurement.Procurement;
import com.zzqa.service.interfaces.procurement.ProcurementManager;
@Component("procurementManager")
public class ProcurementManagerImpl implements ProcurementManager {
	@Autowired
	private IProcurementDAO procurementDAO;

	public void insertProcurement(Procurement procurement) {
		// TODO Auto-generated method stub
		procurementDAO.insertProcurement(procurement);
	}

	public int getProcurementCountLimit(int type, int foreign_id) {
		// TODO Auto-generated method stub
		return procurementDAO.getProcurementCountLimit(type, foreign_id);
	}

	public List<Procurement> getProcurementListLimit(int type, int foreign_id) {
		// TODO Auto-generated method stub
		List<Procurement> list=procurementDAO.getProcurementListLimit(type, foreign_id);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		for (Procurement procurement:list) {
			long predict_time=procurement.getPredict_time();
			procurement.setPredict_date(predict_time==0?"":sdf.format(predict_time));
			long aog_time=procurement.getAog_time();
			procurement.setAog_date(aog_time==0?"":sdf.format(aog_time));
			procurement.setPercent(procurement.getPass_percent()>-1?String.valueOf(procurement.getPass_percent()):"");
			int a=1;
		}
		return list;
	}
	
	public List getProcurementList(int type, int foreign_id) {
		// TODO Auto-generated method stub
		return procurementDAO.getProcurementListLimit(type, foreign_id);
	}

	public Procurement getProcurementByID(int id) {
		// TODO Auto-generated method stub
		return procurementDAO.getProcurementByID(id);
	}

	public void updateProcurement(Procurement procurement) {
		// TODO Auto-generated method stub
		procurementDAO.updateProcurement(procurement);
	}

	public void deleteProcurementLimit(int type, int foreign_id) {
		// TODO Auto-generated method stub
		procurementDAO.deleteProcurementLimit(type, foreign_id);
	}
}
