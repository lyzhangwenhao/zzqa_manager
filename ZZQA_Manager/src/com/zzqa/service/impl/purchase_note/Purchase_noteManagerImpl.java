package com.zzqa.service.impl.purchase_note;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zzqa.dao.impl.flow.FlowDAOImpl;
import com.zzqa.dao.interfaces.customer_data.ICustomer_dataDAO;
import com.zzqa.dao.interfaces.flow.IFlowDAO;
import com.zzqa.dao.interfaces.materials_info.IMaterials_infoDAO;
import com.zzqa.dao.interfaces.product_info.IProduct_infoDAO;
import com.zzqa.dao.interfaces.purchase_note.IPurchase_noteDAO;
import com.zzqa.dao.interfaces.sales_contract.ISales_contractDAO;
import com.zzqa.pojo.customer_data.Customer_data;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.materials_info.Materials_info;
import com.zzqa.pojo.product_info.Product_info;
import com.zzqa.pojo.purchase_note.Purchase_note;
import com.zzqa.pojo.sales_contract.Sales_contract;
import com.zzqa.service.interfaces.purchase_note.Purchase_noteManager;
@Component("purchase_noteManager")
public class Purchase_noteManagerImpl implements Purchase_noteManager {
	@Autowired
	private IPurchase_noteDAO purchase_noteDAO;
	@Autowired
	private ISales_contractDAO sales_contractDAO;
	@Autowired
	private IProduct_infoDAO product_infoDAO;
	@Autowired
	private IMaterials_infoDAO materials_infoDAO;
	@Autowired
	private ICustomer_dataDAO customer_dataDAO;
	@Autowired
	private IFlowDAO flowDAO;

	@Override
	public void insertNote(Purchase_note purchase_note) {
		// TODO Auto-generated method stub
		purchase_noteDAO.insertPurchase_note(purchase_note);
	}
	@Override
	public void delNoteByID(int id) {
		// TODO Auto-generated method stub
		purchase_noteDAO.delPurchase_noteByID(id);
	}
	@Override
	public void updateNote(Purchase_note purchase_note) {
		// TODO Auto-generated method stub
		purchase_noteDAO.updatePurchase_note(purchase_note);
	}
	@Override
	public Purchase_note getNoteByID(int id) {
		// TODO Auto-generated method stub
		return purchase_noteDAO.getPurchase_noteByID(id);
	}
	@Override
	public boolean checkProductInPurchase(int product_id) {
		// TODO Auto-generated method stub
		return purchase_noteDAO.checkProductInPurchase(product_id);
	}
	@Override
	public List<Purchase_note> getPurchase_notesByPID(int purchase_id,boolean applyFinished) {
		// TODO Auto-generated method stub
		List<Purchase_note> notes=purchase_noteDAO.getPurchase_notesByPID(purchase_id);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy/M/d");
		Iterator<Purchase_note> iterator=notes.iterator();
		Flow flow=flowDAO.getNewFlowByFID(12, purchase_id);
		if(flow==null){
			return new ArrayList<Purchase_note>();
		}
		int operation=flow.getOperation();
		while (iterator.hasNext()) {
			Purchase_note purchase_note = (Purchase_note) iterator.next();
			purchase_note.setDelivery_date(sdf.format(purchase_note.getDelivery_time()));
			int sales_id=purchase_note.getSales_id();
			if(operation==10||operation==13||operation==12){
				if(purchase_note.getAog_time()==0){
					purchase_note.setAog_date("");
				}else{
					purchase_note.setAog_date(sdf.format(purchase_note.getAog_time()));
				}
				if(operation==10){
					//老版本的已采购数量在num字段
					if(purchase_note.getAog_time()==0){
						purchase_note.setAog_date(sdf.format(flow.getCreate_time()));
						purchase_note.setAog_num(purchase_note.getNum());
					}
				}
			}
			if(sales_id>0){
				Sales_contract sales_contract=sales_contractDAO.getSales_contractByID(purchase_note.getSales_id());
				if(sales_contract==null){
					iterator.remove();
					continue;
				}
				purchase_note.setContract_no(sales_contract.getContract_no());
				purchase_note.setProject_name(sales_contract.getProject_name());
				Customer_data customer_data=customer_dataDAO.getCustomer_dataByCustomerID(sales_contract.getCustomer_id());
				if(customer_data==null){
					iterator.remove();
					continue;
				}
				purchase_note.setCustomer(customer_data.getCompany_name());
			}
			int product_id=purchase_note.getProduct_id();
			if(product_id>0){
				Product_info product_info=product_infoDAO.getProduct_infoByID(product_id);
				if(product_info==null){
					iterator.remove();
					continue;
				}
				purchase_note.setContract_num(product_info.getNum());
				purchase_note.setPredict_costing_taxes(product_info.getPredict_costing_taxes());
				//审批结束计入已采购数量
				purchase_note.setLast_num(purchase_note.getContract_num()-purchase_noteDAO.getCountByProductID(product_id, applyFinished?0:purchase_id));
				Materials_info materials_info=materials_infoDAO.getMaterials_infoByID(product_info.getM_id());
				if(materials_info==null){
					iterator.remove();
					continue;
				}
				purchase_note.setMaterials_id(materials_info.getMaterials_id());
				purchase_note.setModel(materials_info.getModel());
				purchase_note.setMaterials_remark(materials_info.getRemark());
			}else{
				int m_id=purchase_note.getM_id();
				if(m_id>0){
					Materials_info materials_info=materials_infoDAO.getMaterials_infoByID(m_id);
					if(materials_info==null){
						iterator.remove();
						continue;
					}
					purchase_note.setMaterials_id(materials_info.getMaterials_id());
					purchase_note.setModel(materials_info.getModel());
					purchase_note.setMaterials_remark(materials_info.getRemark());
				}
			}
		}
		return notes;
	}
	@Override
	public int getCountByProductID(int product_id, int purchase_id) {
		// TODO Auto-generated method stub
		return purchase_noteDAO.getCountByProductID(product_id, purchase_id);
	}
	public int getFinishedCountByProductID(int product_id){
		return purchase_noteDAO.getFinishedCountByProductID(product_id);
	}
	@Override
	public List<Integer> getPurchase_noteIDsByPID(int purchase_id) {
		// TODO Auto-generated method stub
		return purchase_noteDAO.getPurchase_noteIDsByPID(purchase_id);
	}
	@Override
	public void reSetHasBuyNum(int purchase_id) {
		// TODO Auto-generated method stub
		purchase_noteDAO.reSetHasBuyNum(purchase_id);
	}
	
}
