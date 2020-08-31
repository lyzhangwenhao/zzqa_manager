package com.zzqa.service.impl.sales_contract;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.customer_data.ICustomer_dataDAO;
import com.zzqa.dao.interfaces.flow.IFlowDAO;
import com.zzqa.dao.interfaces.materials_info.IMaterials_infoDAO;
import com.zzqa.dao.interfaces.permissions.IPermissionsDAO;
import com.zzqa.dao.interfaces.product_info.IProduct_infoDAO;
import com.zzqa.dao.interfaces.purchase_contract.IPurchase_contractDAO;
import com.zzqa.dao.interfaces.purchase_note.IPurchase_noteDAO;
import com.zzqa.dao.interfaces.sales_contract.ISales_contractDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.pojo.customer_data.Customer_data;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.materials_info.Materials_info;
import com.zzqa.pojo.product_info.Product_info;
import com.zzqa.pojo.purchase_contract.Purchase_contract;
import com.zzqa.pojo.purchase_note.Purchase_note;
import com.zzqa.pojo.sales_contract.Sales_contract;
import com.zzqa.pojo.track.Track;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.customer_data.Customer_dataManager;
import com.zzqa.service.interfaces.purchase_contract.Purchase_contractManager;
import com.zzqa.service.interfaces.sales_contract.Sales_contractManager;
import com.zzqa.util.DataUtil;
@Component("sales_contractManager")
public class Sales_contractManagerImpl implements Sales_contractManager {
	@Autowired
	private ISales_contractDAO sales_contractDAO;
	@Autowired
	private ICustomer_dataDAO customer_dataDAO;
	@Autowired
	private IUserDAO userDAO;
	@Autowired
	private IFlowDAO flowDAO;
	@Autowired
	private IProduct_infoDAO product_infoDAO;
	@Autowired
	private IPermissionsDAO permissionsDAO;
	@Autowired
	private IPurchase_noteDAO purchase_noteDAO;
	@Autowired
	private IMaterials_infoDAO materials_infoDAO;
	@Autowired
	private Purchase_contractManager purchase_contractManager;
	
	@Override
	public void insertSales_contract(Sales_contract sales_contract) {
		// TODO Auto-generated method stub
		sales_contractDAO.insertSales_contract(sales_contract);
	}
	@Override
	public int getNewSalesIDByCreateID(int create_id) {
		// TODO Auto-generated method stub
		return sales_contractDAO.getNewSalesIDByCreateID(create_id);
	}
	@Override
	public Sales_contract getSales_contractByID(int id) {
		// TODO Auto-generated method stub
		Sales_contract sales_contract=sales_contractDAO.getSales_contractByID(id);
		if(sales_contract!=null){
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy/M/d");
			Customer_data customer_data=customer_dataDAO.getCustomer_dataByCustomerID(sales_contract.getCustomer_id());
			sales_contract.setCompany_name2(customer_data.getCompany_name());
			long sign_time=sales_contract.getSign_time();
			sales_contract.setSign_date(sign_time==0?"":sdf.format(sign_time));
			sales_contract.setCreate_name(userDAO.getUserNameByID(sales_contract.getCreate_id()));
		}
		return sales_contract;
	}
	@Override
	public void updateSales_contract(Sales_contract sales_contract) {
		// TODO Auto-generated method stub
		sales_contractDAO.updateSales_contract(sales_contract);
	}
	private long lastFlowTime(int operation,List<Flow> flowList){
		int len=flowList.size();
		for (int i = 0; i < len; i++) {
			if(flowList.get(len-i-1).getOperation()==operation){
				return flowList.get(len-i-1).getCreate_time();
			}
		}
		return 0;//没有就返回0
	}
	@Override
	public Map<String, String> getSalesFlowForDraw(
			Sales_contract sales_contract, Flow flow) {
		// TODO Auto-generated method stub
		int operation=flow.getOperation();
		Map<String, String> map=new HashMap<String, String>();
		List<Flow> flowList=flowDAO.getFlowListByCondition(11,sales_contract.getId());
		int applyNum=getApplyNum(sales_contract);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd#HH:mm:ss");
		boolean hasFile=sales_contract.getContract_file()==0;//是否有客户合同
		String title1_flow=null;
		String title2_flow=null;
		String title3_flow=null;
		String color1=null;
		String color2=null;
		String color3=null;
		String color4=null;
		String color5=null;
		String color6=null;
		String color7=null;
		String color8=null;
		String img1=null;
		String img2=null;
		String img3=null;
		String img4=null;
		String img5=null;
		String img6=null;
		String img7=null;
		String img8=null;
		String time1=null;
		String time2=null;
		String time3=null;
		String time4=null;
		String time5=null;
		String time6=null;
		String time7=null;
		String time8=null;
		String bg_color1=null;
		String bg_color2=null;
		String bg_color3=null;
		String bg_color4=null;
		String bg_color5=null;
		String bg_color6=null;
		String bg_color7=null;
		if(operation==1){
			if(hasFile){
				if(applyNum==1){
					title1_flow="title1_flow1";
					title2_flow="title2_flow1";
					title3_flow="title3_flow1";
					color1="color_did";
					color2="color_nodid";
					color3="color_nodid";
					color4="color_nodid";
					color7="color_nodid";
					color8="color_nodid";
					img1="pass.png";
					img2="go.png";
					img3="notdid.png";
					img4="notdid.png";
					img7="notdid.png";
					img8="notdid.png";
					bg_color1="background_color_did";
					bg_color2="background_color_nodid";
					bg_color3="background_color_nodid";
					bg_color6="background_color_nodid";
					bg_color7="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time2=null;
					time3=null;
					time4=null;
					time7=null;
				}else if(applyNum==2){
					title1_flow="title1_flow2";
					title2_flow="title2_flow2";
					title3_flow="title3_flow2";
					color1="color_did";
					color2="color_nodid";
					color3="color_nodid";
					color4="color_nodid";
					color5="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img2="go.png";
					img3="notdid.png";
					img4="notdid.png";
					img5="notdid.png";
					img8=img7="notdid.png";
					bg_color1="background_color_did";
					bg_color2="background_color_nodid";
					bg_color3="background_color_nodid";
					bg_color4="background_color_nodid";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time2=null;
					time3=null;
					time4=null;
					time5=null;
					time7=null;
				}else{
					title1_flow="title1_flow3";
					title2_flow="title2_flow3";
					title3_flow="title3_flow3";
					color1="color_did";
					color2="color_nodid";
					color3="color_nodid";
					color4="color_nodid";
					color5="color_nodid";
					color6="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img2="go.png";
					img3="notdid.png";
					img4="notdid.png";
					img5="notdid.png";
					img6="notdid.png";
					img8=img7="notdid.png";
					bg_color1="background_color_did";
					bg_color2="background_color_nodid";
					bg_color3="background_color_nodid";
					bg_color4="background_color_nodid";
					bg_color5="background_color_nodid";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time2=null;
					time3=null;
					time4=null;
					time5=null;
					time6=null;
					time7=null;
				}
			}else{
				if(applyNum==1){
					title1_flow="title1_flow4";
					title2_flow="title2_flow4";
					title3_flow="title3_flow4";
					color1="color_did";
					color3="color_nodid";
					color4="color_nodid";
					color7=color8="color_nodid";
					img1="pass.png";
					img3="go.png";
					img4="notdid.png";
					img8=img7="notdid.png";
					bg_color2="background_color_did";
					bg_color3="background_color_nodid";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time3=null;
					time4=null;
					time7=null;
				}else if(applyNum==2){
					title1_flow="title1_flow5";
					title2_flow="title2_flow5";
					title3_flow="title3_flow5";
					color1="color_did";
					color3="color_nodid";
					color5=color4="color_nodid";
					color7=color8="color_nodid";
					img1="pass.png";
					img3="go.png";
					img5=img4="notdid.png";
					img8=img7="notdid.png";
					bg_color2="background_color_did";
					bg_color4=bg_color3="background_color_nodid";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time3=null;
					time4=null;
					time7=null;
				}else{
					title1_flow="title1_flow6";
					title2_flow="title2_flow6";
					title3_flow="title3_flow6";
					color1="color_did";
					color3="color_nodid";
					color4="color_nodid";
					color5="color_nodid";
					color6="color_nodid";
					color7="color_nodid";
					color8="color_nodid";
					img1="pass.png";
					img3="go.png";
					img4="notdid.png";
					img5="notdid.png";
					img6="notdid.png";
					img7="notdid.png";
					img8="notdid.png";
					bg_color2="background_color_did";
					bg_color3="background_color_nodid";
					bg_color4="background_color_nodid";
					bg_color5="background_color_nodid";
					bg_color6="background_color_nodid";
					bg_color7="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time3=null;
					time4=null;
					time5=null;
					time6=null;
					time7=null;
				}
			}
		}else if(operation==2){
			if(applyNum==1){
				title1_flow="title1_flow1";
				title2_flow="title2_flow1";
				title3_flow="title3_flow1";
				color1="color_did";
				color2="color_did";
				color3="color_nodid";
				color4="color_nodid";
				color5="color_nodid";
				color6="color_nodid";
				color8=color7="color_nodid";
				img1="pass.png";
				img2="pass.png";
				img3="go.png";
				img4="notdid.png";
				img5="notdid.png";
				img6="notdid.png";
				img8=img7="notdid.png";
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color3="background_color_nodid";
				bg_color4="background_color_nodid";
				bg_color5="background_color_nodid";
				bg_color7=bg_color6="background_color_nodid";
				time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
				time3=null;
				time4=null;
				time5=null;
				time6=null;
				time7=null;
			}else if(applyNum==2){
				title1_flow="title1_flow2";
				title2_flow="title2_flow2";
				title3_flow="title3_flow2";
				color1="color_did";
				color2="color_did";
				color3="color_nodid";
				color4="color_nodid";
				color5="color_nodid";
				color6="color_nodid";
				color8=color7="color_nodid";
				img1="pass.png";
				img2="pass.png";
				img3="go.png";
				img4="notdid.png";
				img5="notdid.png";
				img6="notdid.png";
				img8=img7="notdid.png";
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color3="background_color_nodid";
				bg_color4="background_color_nodid";
				bg_color5="background_color_nodid";
				bg_color7=bg_color6="background_color_nodid";
				time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");;
				time3=null;
				time4=null;
				time5=null;
				time6=null;
				time7=null;
			}else{
				title1_flow="title1_flow3";
				title2_flow="title2_flow3";
				title3_flow="title3_flow3";
				color1="color_did";
				color2="color_did";
				color3="color_nodid";
				color4="color_nodid";
				color5="color_nodid";
				color6="color_nodid";
				color7="color_nodid";
				color8="color_nodid";
				img1="pass.png";
				img2="pass.png";
				img3="go.png";
				img4="notdid.png";
				img5="notdid.png";
				img6="notdid.png";
				img7="notdid.png";
				img8="notdid.png";
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color3="background_color_nodid";
				bg_color4="background_color_nodid";
				bg_color5="background_color_nodid";
				bg_color6="background_color_nodid";
				bg_color7="background_color_nodid";
				time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");;
				time3=null;
				time4=null;
				time5=null;
				time6=null;
				time7=null;
			}
		}else if(operation==3){
			if(applyNum==1){
				title1_flow="title1_flow1";
				title2_flow="title2_flow1";
				title3_flow="title3_flow1";
				color1="color_did";
				color2="color_error";
				color3="color_nodid";
				color4="color_nodid";
				color5="color_nodid";
				color6="color_nodid";
				color8=color7="color_nodid";
				img1="pass.png";
				img2="error.png";
				img3="notdid.png";
				img4="notdid.png";
				img5="notdid.png";
				img6="notdid.png";
				img8=img7="notdid.png";
				bg_color1="background_color_error";
				bg_color2="background_color_nodid";
				bg_color3="background_color_nodid";
				bg_color4="background_color_nodid";
				bg_color5="background_color_nodid";
				bg_color7=bg_color6="background_color_nodid";
				time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");;
				time3=null;
				time4=null;
				time5=null;
				time6=null;
				time7=null;
			}else if(applyNum==2){
				title1_flow="title1_flow2";
				title2_flow="title2_flow2";
				title3_flow="title3_flow2";
				color1="color_did";
				color2="color_error";
				color3="color_nodid";
				color4="color_nodid";
				color5="color_nodid";
				color6="color_nodid";
				color8=color7="color_nodid";
				img1="pass.png";
				img2="error.png";
				img3="notdid.png";
				img4="notdid.png";
				img5="notdid.png";
				img6="notdid.png";
				img8=img7="notdid.png";
				bg_color1="background_color_error";
				bg_color2="background_color_nodid";
				bg_color3="background_color_nodid";
				bg_color4="background_color_nodid";
				bg_color5="background_color_nodid";
				bg_color7=bg_color6="background_color_nodid";
				time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");;
				time3=null;
				time4=null;
				time5=null;
				time6=null;
				time7=null;
			}else{
				title1_flow="title1_flow3";
				title2_flow="title2_flow3";
				title3_flow="title3_flow3";
				color1="color_did";
				color2="color_error";
				color3="color_nodid";
				color4="color_nodid";
				color5="color_nodid";
				color6="color_nodid";
				color8=color7="color_nodid";
				img1="pass.png";
				img2="error.png";
				img3="notdid.png";
				img4="notdid.png";
				img5="notdid.png";
				img6="notdid.png";
				img8=img7="notdid.png";
				bg_color1="background_color_error";
				bg_color2="background_color_nodid";
				bg_color3="background_color_nodid";
				bg_color4="background_color_nodid";
				bg_color5="background_color_nodid";
				bg_color7=bg_color6="background_color_nodid";
				time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");;
				time3=null;
				time4=null;
				time5=null;
				time6=null;
				time7=null;
			}
		}else if(operation==4){
			if(hasFile){
				if(applyNum==1){
					title1_flow="title1_flow1";
					title2_flow="title2_flow1";
					title3_flow="title3_flow1";
					color1="color_did";
					color2="color_did";
					color3="color_did";
					color4="color_nodid";
					color5="color_nodid";
					color6="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img2="pass.png";
					img3="pass.png";
					img4="go.png";
					img5="notdid.png";
					img6="notdid.png";
					img8=img7="notdid.png";
					bg_color1="background_color_did";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color4="background_color_nodid";
					bg_color5="background_color_nodid";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time4=null;
					time5=null;
					time6=null;
					time7=null;
				}else if(applyNum==2){
					title1_flow="title1_flow2";
					title2_flow="title2_flow2";
					title3_flow="title3_flow2";
					color1="color_did";
					color2="color_did";
					color3="color_did";
					color4="color_nodid";
					color5="color_nodid";
					color6="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img2="pass.png";
					img3="pass.png";
					img4="go.png";
					img5="notdid.png";
					img6="notdid.png";
					img8=img7="notdid.png";
					bg_color1="background_color_did";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color4="background_color_nodid";
					bg_color5="background_color_nodid";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time4=null;
					time5=null;
					time6=null;
					time7=null;
				}else{
					title1_flow="title1_flow3";
					title2_flow="title2_flow3";
					title3_flow="title3_flow3";
					color1="color_did";
					color2="color_did";
					color3="color_did";
					color4="color_nodid";
					color5="color_nodid";
					color6="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img2="pass.png";
					img3="pass.png";
					img4="go.png";
					img5="notdid.png";
					img6="notdid.png";
					img8=img7="notdid.png";
					bg_color1="background_color_did";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color4="background_color_nodid";
					bg_color5="background_color_nodid";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time4=null;
					time5=null;
					time6=null;
					time7=null;
				}
			}else{
				if(applyNum==1){
					title1_flow="title1_flow4";
					title2_flow="title2_flow4";
					title3_flow="title3_flow4";
					color1="color_did";
					color3="color_did";
					color4="color_nodid";
					color5="color_nodid";
					color6="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img3="pass.png";
					img4="go.png";
					img5="notdid.png";
					img6="notdid.png";
					img8=img7="notdid.png";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color4="background_color_nodid";
					bg_color5="background_color_nodid";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time4=null;
					time7=null;
				}else if(applyNum==2){
					title1_flow="title1_flow5";
					title2_flow="title2_flow5";
					title3_flow="title3_flow5";
					color1="color_did";
					color3="color_did";
					color5=color4="color_nodid";
					color7=color8="color_nodid";
					img1="pass.png";
					img3="pass.png";
					img4="go.png";
					img8=img7=img5="notdid.png";
					bg_color3=bg_color2="background_color_did";
					bg_color4="background_color_nodid";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time4=null;
					time7=null;
				}else{
					title1_flow="title1_flow6";
					title2_flow="title2_flow6";
					title3_flow="title3_flow6";
					color1="color_did";
					color3="color_did";
					color4="color_nodid";
					color5="color_nodid";
					color6="color_nodid";
					color7="color_nodid";
					color8="color_nodid";
					img1="pass.png";
					img3="pass.png";
					img4="go.png";
					img5="notdid.png";
					img6="notdid.png";
					img7="notdid.png";
					img8="notdid.png";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color4="background_color_nodid";
					bg_color5="background_color_nodid";
					bg_color6="background_color_nodid";
					bg_color7="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time4=null;
					time5=null;
					time6=null;
					time7=null;
				}
			}
		}else if(operation==5){
			if(hasFile){
				if(applyNum==1){
					title1_flow="title1_flow1";
					title2_flow="title2_flow1";
					title3_flow="title3_flow1";
					color1="color_did";
					color2="color_did";
					color3="color_error";
					color4="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img2="pass.png";
					img3="error.png";
					img4="notdid.png";
					img8=img7="notdid.png";
					bg_color1="background_color_did";
					bg_color2="background_color_error";
					bg_color3="background_color_nodid";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time4=null;
					time7=null;
				}else if(applyNum==2){
					title1_flow="title1_flow2";
					title2_flow="title2_flow2";
					title3_flow="title3_flow2";
					color1="color_did";
					color2="color_did";
					color3="color_error";
					color4="color_nodid";
					color5="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img2="pass.png";
					img3="error.png";
					img4="notdid.png";
					img5="notdid.png";
					img8=img7="notdid.png";
					bg_color1="background_color_did";
					bg_color2="background_color_error";
					bg_color3="background_color_nodid";
					bg_color4="background_color_nodid";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time4=null;
					time5=null;
					time7=null;
				}else{
					title1_flow="title1_flow3";
					title2_flow="title2_flow3";
					title3_flow="title3_flow3";
					color1="color_did";
					color2="color_did";
					color3="color_error";
					color4="color_nodid";
					color5="color_nodid";
					color6="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img2="pass.png";
					img3="error.png";
					img4="notdid.png";
					img5="notdid.png";
					img6="notdid.png";
					img8=img7="notdid.png";
					bg_color1="background_color_did";
					bg_color2="background_color_error";
					bg_color3="background_color_nodid";
					bg_color4="background_color_nodid";
					bg_color5="background_color_nodid";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time4=null;
					time5=null;
					time6=null;
					time7=null;
				}
			}else{
				if(applyNum==1){
					title1_flow="title1_flow4";
					title2_flow="title2_flow4";
					title3_flow="title3_flow4";
					color1="color_did";
					color3="color_error";
					color4="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img3="error.png";
					img4="notdid.png";
					img8=img7="notdid.png";
					bg_color2="background_color_error";
					bg_color3="background_color_nodid";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time4=null;
					time7=null;
				}else if(applyNum==2){
					title1_flow="title1_flow5";
					title2_flow="title2_flow5";
					title3_flow="title3_flow5";
					color1="color_did";
					color3="color_error";
					color4="color_nodid";
					color5="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img3="error.png";
					img4="notdid.png";
					img5="notdid.png";
					img8=img7="notdid.png";
					bg_color2="background_color_error";
					bg_color3="background_color_nodid";
					bg_color4="background_color_nodid";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time4=null;
					time5=null;
					time7=null;
				}else{
					title1_flow="title1_flow6";
					title2_flow="title2_flow6";
					title3_flow="title3_flow6";
					color1="color_did";
					color3="color_error";
					color4="color_nodid";
					color5="color_nodid";
					color6="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img3="error.png";
					img4="notdid.png";
					img5="notdid.png";
					img6="notdid.png";
					img8=img7="notdid.png";
					bg_color2="background_color_error";
					bg_color3="background_color_nodid";
					bg_color4="background_color_nodid";
					bg_color5="background_color_nodid";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time4=null;
					time5=null;
					time6=null;
					time7=null;
				}
			}
		}else if(operation==6){
			if(hasFile){
				if(applyNum==1){
					title1_flow="title1_flow1";
					title2_flow="title2_flow1";
					title3_flow="title3_flow1";
					color1="color_did";
					color2="color_did";
					color3="color_did";
					color4="color_did";
					color8=color7="color_nodid";
					img1="pass.png";
					img2="pass.png";
					img3="pass.png";
					img4="pass.png";
					img7="go.png";
					img8="notdid.png";
					bg_color1="background_color_did";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color6="background_color_did";
					bg_color7="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time7=null;
				}else if(applyNum==2){
					title1_flow="title1_flow2";
					title2_flow="title2_flow2";
					title3_flow="title3_flow2";
					color1="color_did";
					color2="color_did";
					color3="color_did";
					color4="color_did";
					color5="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img2="pass.png";
					img3="pass.png";
					img4="pass.png";
					img5="go.png";
					img8=img7="notdid.png";
					bg_color1="background_color_did";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color4="background_color_did";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time5=null;
					time7=null;
				}else{
					title1_flow="title1_flow3";
					title2_flow="title2_flow3";
					title3_flow="title3_flow3";
					color1="color_did";
					color2="color_did";
					color3="color_did";
					color4="color_did";
					color5="color_nodid";
					color6="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img2="pass.png";
					img3="pass.png";
					img4="pass.png";
					img5="go.png";
					img6="notdid.png";
					img8=img7="notdid.png";
					bg_color1="background_color_did";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color4="background_color_did";
					bg_color5="background_color_nodid";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time5=null;
					time6=null;
					time7=null;
				}
			}else{
				if(applyNum==1){
					title1_flow="title1_flow4";
					title2_flow="title2_flow4";
					title3_flow="title3_flow4";
					color1="color_did";
					color3="color_did";
					color4="color_did";
					color8=color7="color_nodid";
					img1="pass.png";
					img3="pass.png";
					img4="pass.png";
					img7="go.png";
					img8="notdid.png";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color6="background_color_did";
					bg_color7="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time7=null;
				}else if(applyNum==2){
					title1_flow="title1_flow5";
					title2_flow="title2_flow5";
					title3_flow="title3_flow5";
					color1="color_did";
					color3="color_did";
					color4="color_did";
					color5="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img3="pass.png";
					img4="pass.png";
					img5="go.png";
					img8=img7="notdid.png";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color4="background_color_did";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time5=null;
					time7=null;
				}else{
					title1_flow="title1_flow6";
					title2_flow="title2_flow6";
					title3_flow="title3_flow6";
					color1="color_did";
					color3="color_did";
					color4="color_did";
					color5="color_nodid";
					color6="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img3="pass.png";
					img4="pass.png";
					img5="go.png";
					img6="notdid.png";
					img8=img7="notdid.png";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color4="background_color_did";
					bg_color5="background_color_nodid";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time5=null;
					time6=null;
					time7=null;
				}
			}
		}else if(operation==7){
			if(hasFile){
				if(applyNum==1){
					title1_flow="title1_flow1";
					title2_flow="title2_flow1";
					title3_flow="title3_flow1";
					color1="color_did";
					color2="color_did";
					color3="color_did";
					color4="color_error";
					color8=color7="color_nodid";
					img1="pass.png";
					img2="pass.png";
					img3="pass.png";
					img4="error.png";
					img8=img7="notdid.png";
					bg_color1="background_color_did";
					bg_color2="background_color_did";
					bg_color3="background_color_error";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time7=null;
				}else if(applyNum==2){
					title1_flow="title1_flow2";
					title2_flow="title2_flow2";
					title3_flow="title3_flow2";
					color1="color_did";
					color2="color_did";
					color3="color_did";
					color4="color_error";
					color5="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img2="pass.png";
					img3="pass.png";
					img4="error.png";
					img5="notdid.png";
					img8=img7="notdid.png";
					bg_color1="background_color_did";
					bg_color2="background_color_did";
					bg_color3="background_color_error";
					bg_color4="background_color_nodid";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time5=null;
					time7=null;
				}else{
					title1_flow="title1_flow3";
					title2_flow="title2_flow3";
					title3_flow="title3_flow3";
					color1="color_did";
					color2="color_did";
					color3="color_did";
					color4="color_error";
					color5="color_nodid";
					color6="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img2="pass.png";
					img3="pass.png";
					img4="error.png";
					img5="notdid.png";
					img6="notdid.png";
					img8=img7="notdid.png";
					bg_color1="background_color_did";
					bg_color2="background_color_did";
					bg_color3="background_color_error";
					bg_color4="background_color_nodid";
					bg_color5="background_color_nodid";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time5=null;
					time6=null;
					time7=null;
				}
			}else{
				if(applyNum==1){
					title1_flow="title1_flow4";
					title2_flow="title2_flow4";
					title3_flow="title3_flow4";
					color1="color_did";
					color3="color_did";
					color4="color_error";
					color8=color7="color_nodid";
					img1="pass.png";
					img3="pass.png";
					img4="error.png";
					img8=img7="notdid.png";
					bg_color2="background_color_did";
					bg_color3="background_color_error";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time7=null;
				}else if(applyNum==2){
					title1_flow="title1_flow5";
					title2_flow="title2_flow5";
					title3_flow="title3_flow5";
					color1="color_did";
					color3="color_did";
					color4="color_error";
					color5="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img3="pass.png";
					img4="error.png";
					img5="notdid.png";
					img8=img7="notdid.png";
					bg_color2="background_color_did";
					bg_color3="background_color_error";
					bg_color4="background_color_nodid";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time5=null;
					time7=null;
				}else{
					title1_flow="title1_flow6";
					title2_flow="title2_flow6";
					title3_flow="title3_flow6";
					color1="color_did";
					color3="color_did";
					color4="color_error";
					color5="color_nodid";
					color6="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img3="pass.png";
					img4="error.png";
					img5="notdid.png";
					img6="notdid.png";
					img8=img7="notdid.png";
					bg_color2="background_color_did";
					bg_color3="background_color_error";
					bg_color4="background_color_nodid";
					bg_color5="background_color_nodid";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time5=null;
					time6=null;
					time7=null;
				}
			}
		}else if(operation==8){
			if(hasFile){
				if(applyNum==2){
					title1_flow="title1_flow2";
					title2_flow="title2_flow2";
					title3_flow="title3_flow2";
					color1="color_did";
					color2="color_did";
					color3="color_did";
					color4="color_did";
					color5="color_did";
					color8=color7="color_nodid";
					img1="pass.png";
					img2="pass.png";
					img3="pass.png";
					img4="pass.png";
					img5="pass.png";
					img7="go.png";
					img8="notdid.png";
					bg_color1="background_color_did";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color4="background_color_did";
					bg_color6="background_color_did";
					bg_color7="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
					time5=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time7=null;
				}else{
					title1_flow="title1_flow3";
					title2_flow="title2_flow3";
					title3_flow="title3_flow3";
					color1="color_did";
					color2="color_did";
					color3="color_did";
					color4="color_did";
					color5="color_did";
					color6="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img2="pass.png";
					img3="pass.png";
					img4="pass.png";
					img5="pass.png";
					img6="go.png";
					img8=img7="notdid.png";
					bg_color1="background_color_did";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color4="background_color_did";
					bg_color5="background_color_did";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
					time5=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time6=null;
					time7=null;
				}
			}else{
				if(applyNum==2){
					title1_flow="title1_flow5";
					title2_flow="title2_flow5";
					title3_flow="title3_flow5";
					color1="color_did";
					color3="color_did";
					color4="color_did";
					color5="color_did";
					color8=color7="color_nodid";
					img1="pass.png";
					img3="pass.png";
					img4="pass.png";
					img5="pass.png";
					img7="go.png";
					img8="notdid.png";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color4="background_color_did";
					bg_color6="background_color_did";
					bg_color7="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
					time5=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time7=null;
				}else{
					title1_flow="title1_flow6";
					title2_flow="title2_flow6";
					title3_flow="title3_flow6";
					color1="color_did";
					color3="color_did";
					color4="color_did";
					color5="color_did";
					color6="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img3="pass.png";
					img4="pass.png";
					img5="pass.png";
					img6="go.png";
					img8=img7="notdid.png";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color4="background_color_did";
					bg_color5="background_color_did";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
					time5=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time6=null;
					time7=null;
				}
			}
		}else if(operation==9){
			if(hasFile){
				if(applyNum==2){
					title1_flow="title1_flow2";
					title2_flow="title2_flow2";
					title3_flow="title3_flow2";
					color1="color_did";
					color2="color_did";
					color3="color_did";
					color4="color_did";
					color5="color_error";
					color8=color7="color_nodid";
					img1="pass.png";
					img2="pass.png";
					img3="pass.png";
					img4="pass.png";
					img5="error.png";
					img8=img7="notdid.png";
					bg_color1="background_color_did";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color4="background_color_error";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
					time5=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time7=null;
				}else{
					title1_flow="title1_flow3";
					title2_flow="title2_flow3";
					title3_flow="title3_flow3";
					color1="color_did";
					color2="color_did";
					color3="color_did";
					color4="color_did";
					color5="color_error";
					color6="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img2="pass.png";
					img3="pass.png";
					img4="pass.png";
					img5="error.png";
					img6="notdid.png";
					img8=img7="notdid.png";
					bg_color1="background_color_did";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color4="background_color_error";
					bg_color5="background_color_nodid";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
					time5=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time6=null;
					time7=null;
				}
			}else{
				if(applyNum==2){
					title1_flow="title1_flow5";
					title2_flow="title2_flow5";
					title3_flow="title3_flow5";
					color1="color_did";
					color3="color_did";
					color4="color_did";
					color5="color_error";
					color8=color7="color_nodid";
					img1="pass.png";
					img3="pass.png";
					img4="pass.png";
					img5="error.png";
					img8=img7="notdid.png";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color4="background_color_error";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
					time5=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time7=null;
				}else{
					title1_flow="title1_flow6";
					title2_flow="title2_flow6";
					title3_flow="title3_flow6";
					color1="color_did";
					color3="color_did";
					color4="color_did";
					color5="color_error";
					color6="color_nodid";
					color8=color7="color_nodid";
					img1="pass.png";
					img3="pass.png";
					img4="pass.png";
					img5="error.png";
					img6="notdid.png";
					img8=img7="notdid.png";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color4="background_color_error";
					bg_color5="background_color_nodid";
					bg_color7=bg_color6="background_color_nodid";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
					time5=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
					time6=null;
					time7=null;
				}
			}
		}else if(operation==10){
			if(hasFile){
				title1_flow="title1_flow3";
				title2_flow="title2_flow3";
				title3_flow="title3_flow3";
				color1="color_did";
				color2="color_did";
				color3="color_did";
				color4="color_did";
				color5="color_did";
				color6="color_did";
				color8=color7="color_nodid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img5="pass.png";
				img6="pass.png";
				img7="go.png";
				img8="notdid.png";
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color3="background_color_did";
				bg_color4="background_color_did";
				bg_color5="background_color_did";
				bg_color6="background_color_did";
				bg_color7="background_color_nodid";
				time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
				time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
				time5=sdf.format(lastFlowTime(8, flowList)).replace("#", "<br/>");
				time6=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
				time7=null;
			}else{
				title1_flow="title1_flow6";
				title2_flow="title2_flow6";
				title3_flow="title3_flow6";
				color1="color_did";
				color3="color_did";
				color4="color_did";
				color5="color_did";
				color6="color_did";
				color8=color7="color_nodid";
				img1="pass.png";
				img3="pass.png";
				img4="pass.png";
				img5="pass.png";
				img6="pass.png";
				img7="go.png";
				img8="notdid.png";
				bg_color2="background_color_did";
				bg_color3="background_color_did";
				bg_color4="background_color_did";
				bg_color5="background_color_did";
				bg_color6="background_color_did";
				bg_color7="background_color_nodid";
				time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
				time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
				time5=sdf.format(lastFlowTime(8, flowList)).replace("#", "<br/>");
				time6=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
				time7=null;
			}
		}else if(operation==11){
			if(hasFile){
				title1_flow="title1_flow3";
				title2_flow="title2_flow3";
				title3_flow="title3_flow3";
				color1="color_did";
				color2="color_did";
				color3="color_did";
				color4="color_did";
				color5="color_did";
				color6="color_error";
				color8=color7="color_nodid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img5="pass.png";
				img6="error.png";
				img8=img7="notdid.png";
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color3="background_color_did";
				bg_color4="background_color_did";
				bg_color5="background_color_error";
				bg_color7=bg_color6="background_color_nodid";
				time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
				time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
				time5=sdf.format(lastFlowTime(8, flowList)).replace("#", "<br/>");
				time6=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
				time7=null;
			}else{
				title1_flow="title1_flow6";
				title2_flow="title2_flow6";
				title3_flow="title3_flow6";
				color1="color_did";
				color3="color_did";
				color4="color_did";
				color5="color_did";
				color6="color_error";
				color8=color7="color_nodid";
				img1="pass.png";
				img3="pass.png";
				img4="pass.png";
				img5="pass.png";
				img6="error.png";
				img8=img7="notdid.png";
				bg_color2="background_color_did";
				bg_color3="background_color_did";
				bg_color4="background_color_did";
				bg_color5="background_color_error";
				bg_color7=bg_color6="background_color_nodid";
				time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
				time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
				time5=sdf.format(lastFlowTime(8, flowList)).replace("#", "<br/>");
				time6=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
				time7=null;
			}
		}else if(operation==12){
			if(hasFile){
				if(applyNum==1){
					title1_flow="title1_flow1";
					title2_flow="title2_flow1";
					title3_flow="title3_flow1";
					color1="color_did";
					color2="color_did";
					color3="color_did";
					color4="color_did";
					color8=color7="color_did";
					img1="pass.png";
					img2="pass.png";
					img3="pass.png";
					img4="pass.png";
					img8=img7="pass.png";
					bg_color1="background_color_did";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color7=bg_color6="background_color_did";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
					time8=time7=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
				}else if(applyNum==2){
					title1_flow="title1_flow2";
					title2_flow="title2_flow2";
					title3_flow="title3_flow2";
					color1="color_did";
					color2="color_did";
					color3="color_did";
					color4="color_did";
					color5="color_did";
					color8=color7="color_did";
					img1="pass.png";
					img2="pass.png";
					img3="pass.png";
					img4="pass.png";
					img5="pass.png";
					img8=img7="pass.png";
					bg_color1="background_color_did";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color4="background_color_did";
					bg_color7=bg_color6="background_color_did";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
					time5=sdf.format(lastFlowTime(8, flowList)).replace("#", "<br/>");
					time8=time7=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
				}else{
					title1_flow="title1_flow3";
					title2_flow="title2_flow3";
					title3_flow="title3_flow3";
					color1="color_did";
					color2="color_did";
					color3="color_did";
					color4="color_did";
					color5="color_did";
					color6="color_did";
					color8=color7="color_did";
					img1="pass.png";
					img2="pass.png";
					img3="pass.png";
					img4="pass.png";
					img5="pass.png";
					img6="pass.png";
					img8=img7="pass.png";
					bg_color1="background_color_did";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color4="background_color_did";
					bg_color5="background_color_did";
					bg_color7=bg_color6="background_color_did";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
					time5=sdf.format(lastFlowTime(8, flowList)).replace("#", "<br/>");
					time6=sdf.format(lastFlowTime(10, flowList)).replace("#", "<br/>");
					time8=time7=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
				}
			}else{
				if(applyNum==1){
					title1_flow="title1_flow4";
					title2_flow="title2_flow4";
					title3_flow="title3_flow4";
					color1="color_did";
					color3="color_did";
					color4="color_did";
					color8=color7="color_did";
					img1="pass.png";
					img3="pass.png";
					img4="pass.png";
					img8=img7="pass.png";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color7=bg_color6="background_color_did";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
					time8=time7=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
				}else if(applyNum==2){
					title1_flow="title1_flow5";
					title2_flow="title2_flow5";
					title3_flow="title3_flow5";
					color1="color_did";
					color3="color_did";
					color4="color_did";
					color5="color_did";
					color8=color7="color_did";
					img1="pass.png";
					img3="pass.png";
					img4="pass.png";
					img5="pass.png";
					img8=img7="pass.png";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color4="background_color_did";
					bg_color7=bg_color6="background_color_did";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
					time5=sdf.format(lastFlowTime(8, flowList)).replace("#", "<br/>");
					time8=time7=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
				}else{
					title1_flow="title1_flow6";
					title2_flow="title2_flow6";
					title3_flow="title3_flow6";
					color1="color_did";
					color3="color_did";
					color4="color_did";
					color5="color_did";
					color6="color_did";
					color8=color7="color_did";
					img1="pass.png";
					img3="pass.png";
					img4="pass.png";
					img5="pass.png";
					img6="pass.png";
					img8=img7="pass.png";
					bg_color2="background_color_did";
					bg_color3="background_color_did";
					bg_color4="background_color_did";
					bg_color5="background_color_did";
					bg_color7=bg_color6="background_color_did";
					time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
					time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
					time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
					time5=sdf.format(lastFlowTime(8, flowList)).replace("#", "<br/>");
					time6=sdf.format(lastFlowTime(10, flowList)).replace("#", "<br/>");
					time8=time7=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
				}
			}
		}else if(operation==13){
			title1_flow="title1_flow0";
			title2_flow="title2_flow0";
			title3_flow="title3_flow0";
			color1="color_did";
			color8="color_error";
			img1="pass.png";
			img8="error.png";
			bg_color7="background_color_error";
			time1=sdf.format(sales_contract.getCreate_time()).replace("#", "<br/>");
			time8=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}
		map.put("title1_flow", title1_flow);
		map.put("title2_flow", title2_flow);
		map.put("title3_flow", title3_flow);
		
		map.put("color1", color1);
		map.put("color2", color2);
		map.put("color3", color3);
		map.put("color4", color4);
		map.put("color5", color5);
		map.put("color6", color6);
		map.put("color7", color7);
		map.put("color8", color8);
		
		map.put("img1", img1);
		map.put("img2", img2);
		map.put("img3", img3);
		map.put("img4", img4);
		map.put("img5", img5);
		map.put("img6", img6);
		map.put("img7", img7);
		map.put("img8", img8);
		
		map.put("bg_color1", bg_color1);
		map.put("bg_color2", bg_color2);
		map.put("bg_color3", bg_color3);
		map.put("bg_color4", bg_color4);
		map.put("bg_color5", bg_color5);
		map.put("bg_color6", bg_color6);
		map.put("bg_color7", bg_color7);
		
		map.put("time1", time1);
		map.put("time2", time2);
		map.put("time3", time3);
		map.put("time4", time4);
		map.put("time5", time5);
		map.put("time6", time6);
		map.put("time7", time7);
		map.put("time8", time8);
		
		return map;
	}
	@Override
	public int getApplyNum(Sales_contract sales_contract) {
		// TODO Auto-generated method stub
		List<Product_info> product_infos=product_infoDAO.getProduct_infos(sales_contract.getId());
		final float prices=500000.0f;//不含税金额50w
		final float gross_profit=0.12f;//整单毛利12%
		int days=0;//账期
		int payment_method=sales_contract.getPayment_method();
		String payment_value= sales_contract.getPayment_value();
		if(payment_method==1){
			days=Integer.parseInt(payment_value.split("の")[0]);
		}else if(payment_method==3){
			days=Integer.parseInt(payment_value);
		}
		if(days>90){
			return 3;
		}
		float all_prices=0.0f;//不含税金额总和
		float all_gross_profit=0.0f;//整单毛利
		float all_pvt=0.0f;//预计含税金额总和
		for (Product_info product_info : product_infos) {
			int num=product_info.getNum();
			all_prices+=product_info.getUnit_price_taxes()*num;
			all_pvt+=product_info.getPredict_costing_taxes()*num;
		}
		all_prices/=1.17f;
		all_gross_profit=(all_prices-all_pvt/1.17f)/all_prices;
		if(all_prices>prices||all_gross_profit<gross_profit){
			return 3;
		}else if(days>=60||all_prices>prices||all_gross_profit<=gross_profit){
			return 2;
		}
		return 1;
	}
	@Override
	public Sales_contract getSales_contractByID2(int id) {
		// TODO Auto-generated method stub
		Sales_contract sales_contract = sales_contractDAO.getSales_contractByID(id);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		Flow flow = flowDAO.getNewFlowByFID(11, id);// 查询最新流程
		String process = sdf.format(flow.getCreate_time())
				+ DataUtil.getFlowArray(11)[flow.getOperation()];
		sales_contract.setName(DataUtil.getNameByTime(11,flow.getCreate_time()));
		sales_contract.setProcess(process);
		sales_contract.setCreate_name(userDAO.getUserNameByID(sales_contract.getCreate_id()));
		return sales_contract;
	}
	
	public boolean checkSealManager(Sales_contract sales_contract, User user,
			int operation) {
		if(operation==6||operation==8||operation==10){
			int applyNum=getApplyNum(sales_contract);
			boolean permisssion117=permissionsDAO.checkPermission(user.getPosition_id(), 117);
			if(operation==6){
				return permisssion117&&applyNum==1;
			}else if(operation==8){
				return permisssion117&&applyNum==2;
			}else if(operation==10){
				return permisssion117&&applyNum==3;
			}
			return false;
		}else{
			return false;
		}
	}
	@Override
	public boolean checkCanApply(Sales_contract sales_contract, User user,
			int operation) {
		// TODO Auto-generated method stub
		int applyNum=getApplyNum(sales_contract);
		boolean hasFile=sales_contract.getContract_file()==0;
		switch (operation) {
		case 1:
			if(hasFile){
				return permissionsDAO.checkPermission(user.getPosition_id(), 58);
			}else{
				return permissionsDAO.checkPermission(user.getPosition_id(), 59);
			}
		case 2:
			return permissionsDAO.checkPermission(user.getPosition_id(), 59);
		case 3:
			return permissionsDAO.checkPermission(user.getPosition_id(), 58);
		case 4:
			return permissionsDAO.checkPermission(user.getPosition_id(), 60);
		case 5:
			return permissionsDAO.checkPermission(user.getPosition_id(), 59);
		case 6:
			if(applyNum>1){
				return permissionsDAO.checkPermission(user.getPosition_id(), 61);
			}
			break;
		case 7:
			return permissionsDAO.checkPermission(user.getPosition_id(), 60);
		case 8:
			if(applyNum>2){
				return permissionsDAO.checkPermission(user.getPosition_id(), 62);
			}
			break;
		case 9:
			return permissionsDAO.checkPermission(user.getPosition_id(), 61);
		case 11:
			return permissionsDAO.checkPermission(user.getPosition_id(), 62);
		}
		return false;
	}
	@Override
	public List<Sales_contract> getSalesListByUID(User user) {
		// TODO Auto-generated method stub
		List<Sales_contract> salesList=sales_contractDAO.getRunningSales();
		SimpleDateFormat format = new SimpleDateFormat( "yyyy.MM.dd" );
		String[] flowArray=DataUtil.getFlowArray(11);
		Iterator<Sales_contract> iterator=salesList.iterator();
		while (iterator.hasNext()) {
			Sales_contract sales_contract=(Sales_contract)iterator.next();
			User userByID = userDAO.getUserByID(sales_contract.getCreate_id());
			if(userByID==null || userByID.getPosition_id()==56){
				iterator.remove();
				continue;
			}
			Flow flow=flowDAO.getNewFlowByFID(11, sales_contract.getId());//查询最新流程
			if(flow!=null&&checkMyOperation(flow.getOperation(),user,sales_contract)){
				String process=format.format(flow.getCreate_time())+flowArray[flow.getOperation()];
				sales_contract.setProcess(process);
				sales_contract.setCreate_name(userByID.getTruename());
				Customer_data customer_data=customer_dataDAO.getCustomer_dataByCustomerID(sales_contract.getCustomer_id());
				if(customer_data==null){
					iterator.remove();
				}else{
					sales_contract.setName(customer_data.getCompany_name());
				}
			}else{
				iterator.remove();
			}
		}
		return salesList;
	}
	private boolean checkMyOperation(int operation,User user,Sales_contract sales_contract){
		int applyNum=getApplyNum(sales_contract);
		boolean hasFile=sales_contract.getContract_file()==0;
		switch (operation) {
		case 1:
			if(hasFile){
				return permissionsDAO.checkPermission(user.getPosition_id(), 58);
			}else{
				return permissionsDAO.checkPermission(user.getPosition_id(), 59);
			}
		case 2:
			return permissionsDAO.checkPermission(user.getPosition_id(), 59);
		case 3:
			return user.getId()==sales_contract.getCreate_id();
		case 4:
			return permissionsDAO.checkPermission(user.getPosition_id(), 60);
		case 5:
			return user.getId()==sales_contract.getCreate_id();
		case 6:
			if(applyNum>1){
				return permissionsDAO.checkPermission(user.getPosition_id(), 61);
			}else{
				return permissionsDAO.checkPermission(user.getPosition_id(),117);
			}
		case 7:
			return user.getId()==sales_contract.getCreate_id();
		case 8:
			if(applyNum>2){
				return permissionsDAO.checkPermission(user.getPosition_id(), 62);
			}else if(applyNum==2){
				return permissionsDAO.checkPermission(user.getPosition_id(),117);
			}
			break;
		case 9:
			return user.getId()==sales_contract.getCreate_id();
		case 10:
			return permissionsDAO.checkPermission(user.getPosition_id(),117);
		case 11:
			return user.getId()==sales_contract.getCreate_id();
		default:
			break;
		}
		return false;
	}
	@Override
	public List getConmany_name1s() {
		// TODO Auto-generated method stub
		return sales_contractDAO.getConmany_name1s();
	}
	@Override
	public List<Sales_contract> getNeedPurchaseProducts() {
		// TODO Auto-generated method stub
		List<Sales_contract> finishedSales=sales_contractDAO.getFinishedSales();
		Iterator<Sales_contract> iterator=finishedSales.iterator();
		Map<Integer,Integer> applyNumMap=new ConcurrentHashMap<Integer, Integer>();//缓存采购合同的审批次数
		while (iterator.hasNext()) {
			Sales_contract sales_contract=(Sales_contract)iterator.next();
			Customer_data customer_data=customer_dataDAO.getCustomer_dataByCustomerID(sales_contract.getCustomer_id());
			if(customer_data!=null){
				sales_contract.setCompany_name2(customer_data.getCompany_name());
			}else{
				iterator.remove();
				continue;
			}
			List<Product_info> product_infos=product_infoDAO.getProduct_infos(sales_contract.getId());
			Iterator<Product_info> iterator2=product_infos.iterator();
			while (iterator2.hasNext()) {
				Product_info product_info=(Product_info)iterator2.next();
				product_info.setPurchase_num(getPurchaseNum(product_info.getId(),applyNumMap));
				product_info.setLast_num(product_info.getNum()-product_info.getPurchase_num());
				Materials_info materials_info=materials_infoDAO.getMaterials_infoByID(product_info.getM_id());
				if(materials_info!=null&&product_info.getLast_num()>0){
					product_info.setModel(materials_info.getModel());
				}else{
					iterator2.remove();
					continue;
				}
			}
			if(product_infos.size()>0){
				sales_contract.setProduct_infos(product_infos);
			}else{
				iterator.remove();
			}
		}
		return finishedSales;
	}
	@Override
	public boolean checkContract_no(String contract_no, int sales_id) {
		// TODO Auto-generated method stub
		return sales_contractDAO.checkContract_no(contract_no,sales_id);
	}
	@Override
	public List<Product_info> getDetailProduct_infos(int sales_id) {
		// TODO Auto-generated method stub
		Map<Integer,Integer> applyNumMap=new ConcurrentHashMap<Integer, Integer>();//缓存采购合同的审批次数
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
					//最近已完成的采购合同中的已采购数量（撤销中或在完成后再修改但没审批结束，显示之前审批完成时的已采购数量，已撤销不计算数量）
					product_info.setPurchase_num(getPurchaseNum(product_info.getId(),applyNumMap));
				}else{
					iterator.remove();
				}
			}
		}
		return list;
	}
	private int getPurchaseNum(int product_id,Map<Integer,Integer> applyNumMap){
		int purchase_num=0;
		List<Purchase_note> purchase_notes=purchase_noteDAO.getPurchase_notesByProductID(product_id);
		for (Purchase_note purchase_note : purchase_notes) {
			//最近已完成的采购合同中的已采购数量（撤销中或在完成后再修改但没审批结束，显示之前审批完成时的已采购数量，已撤销不计算数量）
			int op=purchase_note.getOperation();
			if(op==8||op==10||op==12||op==13){
				purchase_num+=purchase_note.getNum();
			}else if(op==4||op==6) {
				int applyNum=0;
				if(applyNumMap.containsKey(purchase_note.getPurchase_id())){
					applyNum=applyNumMap.get(purchase_note.getPurchase_id());
				}else{
					Purchase_contract purchase_contract=purchase_contractManager.getPurchase_contractByID(purchase_note.getPurchase_id());
					if(purchase_contract!=null){
						applyNum=purchase_contractManager.getPurchaseApplyNum(purchase_contract);
					}
				}
				if((applyNum==2&&op==4)||(applyNum==3&&op==6)){
					purchase_num+= purchase_note.getNum();
				}else{
					purchase_num+= purchase_note.getHasbuy_num();
				}
			}else{
				purchase_num+= purchase_note.getHasbuy_num();
			}
		}
		return purchase_num;
	}
	@Override//["待批复","已批复","被拒","部分采购","已采购","撤销中","已撤销"];
	public List<Sales_contract> getSalesDetailByTime(long starttime1, long endtime1,long starttime2, long endtime2) {
		// TODO Auto-generated method stub
		Map<Integer,Integer> applyNumMap=new ConcurrentHashMap<Integer, Integer>();//缓存采购合同的审批次数
		List<Sales_contract> sales=sales_contractDAO.getSalesByTime(starttime1, endtime1,starttime2, endtime2);
		Flow flow=new Flow();
		flow.setType(11);
		flow.setOperation(13);
		for(int i=0,sLen=sales.size();i<sLen;i++){
			Sales_contract sales_contract=sales.get(i);
			int sales_id=sales_contract.getId();
			//List<Product_info> product_infos=product_infoDAO.getProduct_infos(sales_id);
			List<Product_info> product_infos=sales_contract.getProduct_infos();
			Customer_data customer_data=customer_dataDAO.getCustomer_dataByCustomerID(sales_contract.getCustomer_id());
			if(customer_data!=null){
				sales_contract.setCompany_name2(customer_data.getCompany_name());
			}else{
				sales_contract.setCompany_name2("");
			}
			int opera=sales_contract.getPurchaseState();//销售合同流程
			int applyNum=getApplyNum(sales_contract);
			if(opera==12||(applyNum==1&&opera==6)||(applyNum==2&&opera==8)||(applyNum==3&&opera==10)){
				int purchaseState=-1;
				for(int j=0,pLen=product_infos.size();j<pLen;j++){
					Product_info product_info=product_infos.get(j);
					Materials_info materials_info=materials_infoDAO.getMaterials_infoByID(product_info.getM_id());
					if(materials_info!=null){
						product_info.setMaterials_id(materials_info.getMaterials_id());
						product_info.setModel(materials_info.getModel());
						product_info.setMaterials_remark(materials_info.getRemark());
					}else{
						product_info.setMaterials_id("");
						product_info.setModel("");
						product_info.setMaterials_remark("");
					}
					product_info.setPurchase_num(getPurchaseNum(product_info.getId(),applyNumMap));
					//1:"已批复",3:"部分采购",4:"已采购"
					if(product_info.getPurchase_num()==0){
						if(purchaseState==3||purchaseState==4){
							purchaseState=3;
						}else{
							purchaseState=1;
						}
					}else if(product_info.getPurchase_num()<product_info.getNum()){
						purchaseState=3;
					}else{
						if(purchaseState==-1||purchaseState==4){
							purchaseState=4;
						}else{
							purchaseState=3;
						}
					}
				}
				sales_contract.setPurchaseState(purchaseState);
			}else{
				flow.setForeign_id(sales_id);
				Flow flow13=flowDAO.getFlowByOperation(flow);
				if(flow13!=null){//撤销中
					sales_contract.setPurchaseState(5);
				}else{
					 if(opera==5||opera==7||opera==9||opera==11){
						 sales_contract.setPurchaseState(2);
					}else{
						sales_contract.setPurchaseState(0);
					}
				}
				for(int j=0,pLen=product_infos.size();j<pLen;j++){
					Product_info product_info=product_infos.get(j);
					Materials_info materials_info=materials_infoDAO.getMaterials_infoByID(product_info.getM_id());
					if(materials_info!=null){
						product_info.setMaterials_id(materials_info.getMaterials_id());
						product_info.setModel(materials_info.getModel());
						product_info.setMaterials_remark(materials_info.getRemark());
					}else{
						product_info.setMaterials_id("");
						product_info.setModel("");
						product_info.setMaterials_remark("");
					}
					product_info.setPurchase_num(getPurchaseNum(product_info.getId(),applyNumMap));
				}
			}
			sales_contract.setProduct_infos(product_infos);
		}
		return sales;
	}
	public List<Sales_contract> getFinishedSales(){
		return sales_contractDAO.getFinishedSales();
	}
	
}
