package com.zzqa.service.interfaces.purchase_note;

import java.util.List;

import com.zzqa.pojo.purchase_note.Purchase_note;


public interface Purchase_noteManager {
	public void insertNote(Purchase_note purchase_note);
	public void delNoteByID(int id);
	public void updateNote(Purchase_note purchase_note);
	public Purchase_note getNoteByID(int id);
	/****
	 * 已采购，除当前合同purchase_id外,其他采购合同（未撤销）已绑定的数量
	 * @param product_id
	 * @param purchase_id
	 * @return
	 */
	public int getCountByProductID(int product_id,int purchase_id);
	/***
	 * 审批结束的采购合同中已采购的数量
	 * @param product_id
	 * @param purchase_id
	 * @return
	 */
	public int getFinishedCountByProductID(int product_id);
	public List<Integer> getPurchase_noteIDsByPID(int purchase_id);
	/****
	 * 
	 * @param purchase_id
	 * @param isFinished 该采购合同审批结束，未采购数量减少
	 * @return
	 */
	public List<Purchase_note> getPurchase_notesByPID(int purchase_id,boolean isFinished);
	/****
	 * 检查产品是否被采购合同绑定
	 * @param product_id
	 * @return
	 */
	public boolean checkProductInPurchase(int product_id);
	public void reSetHasBuyNum(int purchase_id);
}
