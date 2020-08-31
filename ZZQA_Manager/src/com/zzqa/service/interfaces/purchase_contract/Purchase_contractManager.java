package com.zzqa.service.interfaces.purchase_contract;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.purchase_contract.Purchase_contract;
import com.zzqa.pojo.user.User;

public interface Purchase_contractManager {
	public int insertPurchase_contract(Purchase_contract purchase_contract);
	public void updatePurchase_contract(Purchase_contract purchase_contract);
	public Purchase_contract getPurchase_contractByID(int id);
	public Purchase_contract getPurchase_contractByID2(int id);
	public List<Purchase_contract> getPurchaseListByUID(User user);
	public int getPurchaseApplyNum(Purchase_contract purchase_contract);
	public Map getPurchaseFlowForDraw(Purchase_contract purchase_contract,Flow flow);
	/***
	 * 可以采购
	 * @param purchase_contract
	 * @param mUser
	 * @param operation
	 * @return
	 */
	public boolean checkCanApply(Purchase_contract purchase_contract, User mUser, int operation);
	public boolean checkCanBuy(Purchase_contract purchase_contract, User mUser, int operation);
	public boolean checkContract_no(String contract_no, int purchase_id);
	public void updateHasbuy_numFromNum(int purchase_id);
	public List<Purchase_contract> getPurchaseDetailByTime(long starttime1,
			long endtime1, long starttime2, long endtime2);
}
