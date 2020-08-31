package com.zzqa.dao.interfaces.purchase_contract;

import java.util.List;

import com.zzqa.pojo.purchase_contract.Purchase_contract;

public interface IPurchase_contractDAO {
	public void insertPurchase_contract(Purchase_contract purchase_contract);
	public void updatePurchase_contract(Purchase_contract purchase_contract);
	public void delPurchase_contractByID(int id);
	public Purchase_contract getPurchase_contractByID(int id);
	public int getNewIDByCreateID(int create_id);
	public List getRunningPurchase();
	public List getFinishedPurchase();
	public boolean checkContract_no(String contract_no, int purchase_id);
	public List getAllList();
	public List<Purchase_contract> getPurchasesByTime(long starttime1,
			long endtime1, long starttime2, long endtime2);
}
