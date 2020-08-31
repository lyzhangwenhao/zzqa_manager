package com.zzqa.service.impl.product_info;

import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.materials_info.IMaterials_infoDAO;
import com.zzqa.dao.interfaces.product_info.IProduct_infoDAO;
import com.zzqa.pojo.materials_info.Materials_info;
import com.zzqa.pojo.product_info.Product_info;
import com.zzqa.pojo.purchase_note.Purchase_note;
import com.zzqa.service.interfaces.product_info.Product_infoManager;
@Component("product_infoManager")
public class Product_infoManagerImpl implements Product_infoManager {
	@Autowired
	private IProduct_infoDAO product_infoDAO;
	@Autowired
	private IMaterials_infoDAO materials_infoDAO;
	
	@Override
	public void insertProduct_info(Product_info product_info) {
		// TODO Auto-generated method stub
		product_infoDAO.insertProduct_info(product_info);
	}
	@Override
	public void delProduct_infoByID(int id) {
		// TODO Auto-generated method stub
		product_infoDAO.delAProduct_infoByID(id);
	}
	@Override
	public List<Product_info> getProduct_infos(int sales_id) {
		// TODO Auto-generated method stub
		List<Product_info> list=product_infoDAO.getProduct_infos(sales_id);
		if(list!=null){
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy/M/d");
			Iterator< Product_info> iterator=list.iterator();
			while (iterator.hasNext()) {
				Product_info product_info = (Product_info) iterator.next();
				Materials_info materials_info=materials_infoDAO.getMaterials_infoByID(product_info.getM_id());
				if(materials_info!=null){
					product_info.setDelivery_date(sdf.format(product_info.getDelivery_time()));
					product_info.setMaterials_id(materials_info.getMaterials_id());
					product_info.setMaterials_remark(materials_info.getRemark());
					product_info.setModel(materials_info.getModel());
				}else{
					iterator.remove();
				}
			}
		}
		return list;
	}
	@Override
	public Product_info getProduct_infoByID(int id) {
		// TODO Auto-generated method stub
		Product_info product_info=product_infoDAO.getProduct_infoByID(id);
		Materials_info materials_info=materials_infoDAO.getMaterials_infoByID(product_info.getM_id());
		if(materials_info!=null){
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy/M/d");
			product_info.setDelivery_date(sdf.format(product_info.getDelivery_time()));
			product_info.setMaterials_id(materials_info.getMaterials_id());
			product_info.setMaterials_remark(materials_info.getRemark());
			product_info.setModel(materials_info.getModel());
		}else{
			product_info.setDelivery_date("");
		}
		return product_info;
	}
	@Override
	public void updateProduct_info(Product_info product_info) {
		// TODO Auto-generated method stub
		product_infoDAO.updateProduct_info(product_info);
	}
	@Override
	public boolean checkUseMaterials(int m_id) {
		// TODO Auto-generated method stub
		return materials_infoDAO.checkUseMaterials(m_id);
	}
}
