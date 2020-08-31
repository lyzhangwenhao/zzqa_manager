package com.zzqa.dao.interfaces.purchase_note;

import java.util.List;

import com.zzqa.pojo.purchase_note.Purchase_note;

public interface IPurchase_noteDAO {
	public void delPurchase_noteByID(int id);
	public void insertPurchase_note(Purchase_note purchase_note);
	public void updatePurchase_note(Purchase_note purchase_note);
	public Purchase_note getPurchase_noteByID(int id);
	public List<Purchase_note> getPurchase_notesByPID(int purchase_id);
	public List<Integer> getPurchase_noteIDsByPID(int purchase_id);
	/****
	 * 产品已购数量 不包含当前的采购合同(流程未撤销)所采购的数量  绑定数量
	 * @param product_id
	 * @return
	 */
	public int getCountByProductID(int product_id,int purchase_id);
	public boolean checkProductInPurchase(int product_id);
	/****
	 * 产品已购数量（已批复完成）
	 * @param product_id
	 * @return
	 */
	public int getFinishedCountByProductID(int product_id);
	public void reSetHasBuyNum(int purchase_id);
	/***
	 * 非已撤销的已采购单子
	 * @param product_id
	 * @return
	 */
	public List<Purchase_note> getPurchase_notesByProductID(int product_id);
	/***
	 * 审批完成时撤销，记录之前完成的已采购数量，知道撤销完成，重置数量为0
	 * @param purchase_id
	 */
	public void updateHasbuy_numFromNum(int purchase_id);
}
