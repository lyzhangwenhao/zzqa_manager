package com.zzqa.service.impl.purchase_contract;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

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
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.purchase_contract.Purchase_contractManager;
import com.zzqa.util.DataUtil;
@Component("purchase_contractManager")
public class Purchase_contractManagerImpl implements Purchase_contractManager {
	@Autowired
	private IPurchase_contractDAO purchase_contractDAO;
	@Autowired
	private IProduct_infoDAO product_infoDAO;
	@Autowired
	private ISales_contractDAO sales_contractDAO;
	@Autowired
	private IFlowDAO flowDAO;
	@Autowired
	private IPurchase_noteDAO purchase_noteDAO;
	@Autowired
	private IUserDAO userDAO;
	@Autowired
	private IPermissionsDAO permissionsDAO;
	@Autowired
	private ICustomer_dataDAO customer_dataDAO;
	@Autowired
	private IMaterials_infoDAO materials_infoDAO;
	
	@Override
	public int insertPurchase_contract(Purchase_contract purchase_contract) {
		// TODO Auto-generated method stub
		purchase_contractDAO.insertPurchase_contract(purchase_contract);
		return purchase_contractDAO.getNewIDByCreateID(purchase_contract.getCreate_id());
	}
	@Override
	public void updatePurchase_contract(Purchase_contract purchase_contract) {
		// TODO Auto-generated method stub
		purchase_contractDAO.updatePurchase_contract(purchase_contract);
	}
	@Override
	public Purchase_contract getPurchase_contractByID(int id) {
		// TODO Auto-generated method stub
		Purchase_contract purchase_contract=purchase_contractDAO.getPurchase_contractByID(id);
		if(purchase_contract!=null){
			Customer_data customer_data=customer_dataDAO.getCustomer_dataByCustomerID(purchase_contract.getSupplier());
			if(customer_data!=null){
				purchase_contract.setCompany_name2(customer_data.getCompany_name());
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy/M/d");
				purchase_contract.setSign_date(sdf.format(purchase_contract.getSign_time()));
			}else{
				purchase_contract.setCompany_name2("该供应商不存在");
			}
		}
		return purchase_contract;
	}
	@Override
	public List<Purchase_contract> getPurchaseListByUID(User user) {
		// TODO Auto-generated method stub
		List<Purchase_contract> purchaseList=purchase_contractDAO.getRunningPurchase();
		SimpleDateFormat format = new SimpleDateFormat( "yyyy.MM.dd" );
		String[] flowArray=DataUtil.getFlowArray(12);
		Iterator<Purchase_contract> iterator=purchaseList.iterator();
		while (iterator.hasNext()) {
			Purchase_contract purchase_contract=(Purchase_contract)iterator.next();
			User userByID = userDAO.getUserByID(purchase_contract.getCreate_id());
			if(userByID==null || userByID.getPosition_id()==56){
				iterator.remove();
				continue;
			}
			Flow flow=flowDAO.getNewFlowByFID(12, purchase_contract.getId());//查询最新流程
			if(flow!=null&&checkMyOperation(flow.getOperation(),user,purchase_contract)){
				String process=format.format(flow.getCreate_time())+flowArray[flow.getOperation()];
				purchase_contract.setProcess(process);
				purchase_contract.setCreate_name(userByID.getTruename());
				Customer_data customer_data=customer_dataDAO.getCustomer_dataByCustomerID(purchase_contract.getSupplier());
				if(customer_data==null){
					iterator.remove();
				}else{
					purchase_contract.setName(customer_data.getCompany_name());
				}
			}else{
				iterator.remove();
			}
		}
		return purchaseList;
	}
	
	private boolean checkMyOperation(int operation,User user,Purchase_contract purchase_contract){
		int purchase_type=purchase_contract.getType();
		int applyNum=getPurchaseApplyNum(purchase_contract);
		switch (operation) {
		case 1:
			return permissionsDAO.checkPermission(user.getPosition_id(), 72);
		case 2:
			return permissionsDAO.checkPermission(user.getPosition_id(), 73);
		case 3:
			return user.getId()==purchase_contract.getCreate_id();
		case 4:
			if(applyNum>2){
				return permissionsDAO.checkPermission(user.getPosition_id(), 74);
			}else{
				return permissionsDAO.checkPermission(user.getPosition_id(), 118);
			}
		case 5:
			return user.getId()==purchase_contract.getCreate_id();
		case 6:
			if(applyNum>3){
				return permissionsDAO.checkPermission(user.getPosition_id(), 75);
			}else if(applyNum==3){
				return permissionsDAO.checkPermission(user.getPosition_id(), 118);
			}
			break;
		case 7:
			return user.getId()==purchase_contract.getCreate_id();
		case 8:
			return permissionsDAO.checkPermission(user.getPosition_id(), 118);
		case 9:
			return user.getId()==purchase_contract.getCreate_id();
		case 12:
			return permissionsDAO.checkPermission(user.getPosition_id(), 119);
		case 13:
			return permissionsDAO.checkPermission(user.getPosition_id(), 120);
		}
		return false;
	}
	@Override
	public int getPurchaseApplyNum(Purchase_contract purchase_contract) {
		// TODO Auto-generated method stub
		int moxa=purchase_contract.getMoxa();//0:为moxa厂家；1：预付款；2：不需要
		if(moxa==1){
			return 3;//预付款（moxa厂家没有预付款选项）
		}
		List<Purchase_note> noteList=purchase_noteDAO.getPurchase_notesByPID(purchase_contract.getId());
		float all_prices=0.0f;//不含税金额总和
		for (Purchase_note purchase_note : noteList) {
			all_prices+=purchase_note.getUnit_price_taxes()*purchase_note.getNum();
		}
		all_prices/=1.17f;
		/****
		 * moxa 是   运营总监：50w<不含税金额<=80w ;总经理：不含税金额>80w
		 * 			  否	运营总监：不含税金额>20w||不需要预付款
		 */
		if(moxa==0){
			if(all_prices>800000){
				return 4;
			}else if(all_prices<500000){
				return 2;
			}else{
				return 3;
			}
		}else{
			return all_prices>200000?3:2;
		}
	}
	@Override
	public Purchase_contract getPurchase_contractByID2(int id) {
		// TODO Auto-generated method stub
		Purchase_contract purchase_contract = purchase_contractDAO.getPurchase_contractByID(id);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		Flow flow = flowDAO.getNewFlowByFID(12, id);// 查询最新流程
		String process = sdf.format(flow.getCreate_time())
				+ DataUtil.getFlowArray(12)[flow.getOperation()];
		int op=flow.getOperation();
		purchase_contract.setName(DataUtil.getNameByTime(12,
				flow.getCreate_time()));
		purchase_contract.setProcess(process);
		purchase_contract.setCreate_name(userDAO.getUserNameByID(purchase_contract.getCreate_id()));
		return purchase_contract;
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
	public Map getPurchaseFlowForDraw(Purchase_contract purchase_contract,
			Flow flow) {
		// TODO Auto-generated method stub
		int operation=flow.getOperation();
		Map<String, String> map=new HashMap<String, String>();
		List<Flow> flowList=flowDAO.getFlowListByCondition(12,purchase_contract.getId());
		int applyNum=getPurchaseApplyNum(purchase_contract);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd#HH:mm:ss");
		boolean stock_up=purchase_contract.getType()==2;//是否备货
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
			if(applyNum==2){
				title1_flow="title1_flow1";
				title2_flow="title2_flow1";
				title3_flow="title3_flow1";
				color1="color_did";
				color2="color_nodid";
				color3="color_nodid";
				color8=color7=color6="color_nodid";
				img1="pass.png";
				img2="go.png";
				img3="notdid.png";
				img8=img7=img6="notdid.png";
				bg_color1="background_color_did";
				bg_color2="background_color_nodid";
				bg_color7=bg_color6=bg_color5="background_color_nodid";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
			}else if(applyNum==3){
				title1_flow="title1_flow2";
				title2_flow="title2_flow2";
				title3_flow="title3_flow2";
				color1="color_did";
				color2="color_nodid";
				color3="color_nodid";
				color4="color_nodid";
				color8=color7=color6="color_nodid";
				img1="pass.png";
				img2="go.png";
				img3="notdid.png";
				img4="notdid.png";
				img8=img7=img6="notdid.png";
				bg_color1="background_color_did";
				bg_color2="background_color_nodid";
				bg_color3="background_color_nodid";
				bg_color7=bg_color6=bg_color5="background_color_nodid";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
			}else{
				title1_flow="title1_flow3";
				title2_flow="title2_flow3";
				title3_flow="title3_flow3";
				color1="color_did";
				color2="color_nodid";
				color3="color_nodid";
				color4="color_nodid";
				color5="color_nodid";
				color8=color7=color6="color_nodid";
				img1="pass.png";
				img2="go.png";
				img3="notdid.png";
				img4="notdid.png";
				img5="notdid.png";
				img8=img7=img6="notdid.png";
				bg_color1="background_color_did";
				bg_color2="background_color_nodid";
				bg_color3="background_color_nodid";
				bg_color4="background_color_nodid";
				bg_color7=bg_color6=bg_color5="background_color_nodid";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
			}
		}else if(operation==2){
			if(applyNum==2){
				title1_flow="title1_flow1";
				title2_flow="title2_flow1";
				title3_flow="title3_flow1";
				color1="color_did";
				color2="color_did";
				color3="color_nodid";
				color8=color7=color6="color_nodid";
				img1="pass.png";
				img2="pass.png";
				img3="go.png";
				img8=img7=img6="notdid.png";
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color7=bg_color6=bg_color5="background_color_nodid";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			}else if(applyNum==3){
				title1_flow="title1_flow2";
				title2_flow="title2_flow2";
				title3_flow="title3_flow2";
				color1="color_did";
				color2="color_did";
				color3="color_nodid";
				color4="color_nodid";
				color8=color7=color6="color_nodid";
				img1="pass.png";
				img2="pass.png";
				img3="go.png";
				img4="notdid.png";
				img8=img7=img6="notdid.png";
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color3="background_color_nodid";
				bg_color7=bg_color6=bg_color5="background_color_nodid";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			}else{
				title1_flow="title1_flow3";
				title2_flow="title2_flow3";
				title3_flow="title3_flow3";
				color1="color_did";
				color2="color_did";
				color3="color_nodid";
				color4="color_nodid";
				color5="color_nodid";
				color8=color7=color6="color_nodid";
				img1="pass.png";
				img2="pass.png";
				img3="go.png";
				img4="notdid.png";
				img5="notdid.png";
				img8=img7=img6="notdid.png";
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color3="background_color_nodid";
				bg_color4="background_color_nodid";
				bg_color7=bg_color6=bg_color5="background_color_nodid";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			}
		}else if(operation==3){
			if(applyNum==2){
				title1_flow="title1_flow1";
				title2_flow="title2_flow1";
				title3_flow="title3_flow1";
				color1="color_did";
				color2="color_error";
				color3="color_nodid";
				color8=color7=color6="color_nodid";
				img1="pass.png";
				img2="error.png";
				img3="notdid.png";
				img8=img7=img6="notdid.png";
				bg_color1="background_color_error";
				bg_color2="background_color_nodid";
				bg_color7=bg_color6=bg_color5="background_color_nodid";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			}else if(applyNum==3){
				title1_flow="title1_flow2";
				title2_flow="title2_flow2";
				title3_flow="title3_flow2";
				color1="color_did";
				color2="color_error";
				color3="color_nodid";
				color4="color_nodid";
				color8=color7=color6="color_nodid";
				img1="pass.png";
				img2="error.png";
				img3="notdid.png";
				img4="notdid.png";
				img8=img7=img6="notdid.png";
				bg_color1="background_color_error";
				bg_color2="background_color_nodid";
				bg_color3="background_color_nodid";
				bg_color7=bg_color6=bg_color5="background_color_nodid";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			}else{
				title1_flow="title1_flow3";
				title2_flow="title2_flow3";
				title3_flow="title3_flow3";
				color1="color_did";
				color2="color_error";
				color3="color_nodid";
				color4="color_nodid";
				color5="color_nodid";
				color8=color7=color6="color_nodid";
				img1="pass.png";
				img2="error.png";
				img3="notdid.png";
				img4="notdid.png";
				img5="notdid.png";
				img8=img7=img6="notdid.png";
				bg_color1="background_color_error";
				bg_color2="background_color_nodid";
				bg_color3="background_color_nodid";
				bg_color4="background_color_nodid";
				bg_color7=bg_color6=bg_color5="background_color_nodid";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			}
		}else if(operation==4){
			if(applyNum==2){
				title1_flow="title1_flow1";
				title2_flow="title2_flow1";
				title3_flow="title3_flow1";
				color1="color_did";
				color2="color_did";
				color3="color_did";
				color8=color7=color6="color_nodid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img6="go.png";
				img8=img7="notdid.png";
				bg_color1="background_color_did";
				bg_color5=bg_color2="background_color_did";
				bg_color7=bg_color6="background_color_nodid";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			}else if(applyNum==3){
				title1_flow="title1_flow2";
				title2_flow="title2_flow2";
				title3_flow="title3_flow2";
				color1="color_did";
				color2="color_did";
				color3="color_did";
				color4="color_nodid";
				color8=color7=color6="color_nodid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="go.png";
				img8=img7=img6="notdid.png";
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color3="background_color_did";
				bg_color7=bg_color6=bg_color5="background_color_nodid";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			}else{
				title1_flow="title1_flow3";
				title2_flow="title2_flow3";
				title3_flow="title3_flow3";
				color1="color_did";
				color2="color_did";
				color3="color_did";
				color4="color_nodid";
				color5="color_nodid";
				color8=color7=color6="color_nodid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="go.png";
				img5="notdid.png";
				img8=img7=img6="notdid.png";
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color3="background_color_did";
				bg_color4="background_color_nodid";
				bg_color7=bg_color6=bg_color5="background_color_nodid";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			}
		}else if(operation==5){
			if(applyNum==2){
				title1_flow="title1_flow1";
				title2_flow="title2_flow1";
				title3_flow="title3_flow1";
				color1="color_did";
				color2="color_did";
				color3="color_error";
				color8=color7=color6="color_nodid";
				img1="pass.png";
				img2="pass.png";
				img3="error.png";
				img8=img7=img6="notdid.png";
				bg_color1="background_color_did";
				bg_color2="background_color_error";
				bg_color7=bg_color6=bg_color5="background_color_nodid";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			}else if(applyNum==3){
				title1_flow="title1_flow2";
				title2_flow="title2_flow2";
				title3_flow="title3_flow2";
				color1="color_did";
				color2="color_did";
				color3="color_error";
				color4="color_nodid";
				color8=color7=color6="color_nodid";
				img1="pass.png";
				img2="pass.png";
				img3="error.png";
				img4="notdid.png";
				img8=img7=img6="notdid.png";
				bg_color1="background_color_did";
				bg_color2="background_color_error";
				bg_color3="background_color_nodid";
				bg_color7=bg_color6=bg_color5="background_color_nodid";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			}else{
				title1_flow="title1_flow3";
				title2_flow="title2_flow3";
				title3_flow="title3_flow3";
				color1="color_did";
				color2="color_did";
				color3="color_error";
				color4="color_nodid";
				color5="color_nodid";
				color8=color7=color6="color_nodid";
				img1="pass.png";
				img2="pass.png";
				img3="error.png";
				img4="notdid.png";
				img5="notdid.png";
				img8=img7=img6="notdid.png";
				bg_color1="background_color_did";
				bg_color2="background_color_error";
				bg_color3="background_color_nodid";
				bg_color4="background_color_nodid";
				bg_color7=bg_color6=bg_color5="background_color_nodid";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			}
		}else if(operation==6){
			if(applyNum==3){
				title1_flow="title1_flow2";
				title2_flow="title2_flow2";
				title3_flow="title3_flow2";
				color1="color_did";
				color2="color_did";
				color3="color_did";
				color4="color_did";
				color6="color_did";
				color8=color7="color_nodid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img6="go.png";
				img8=img7="notdid.png";
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color3="background_color_did";
				bg_color5="background_color_did";
				bg_color7=bg_color6="background_color_nodid";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
				time4=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			}else{
				title1_flow="title1_flow3";
				title2_flow="title2_flow3";
				title3_flow="title3_flow3";
				color1="color_did";
				color2="color_did";
				color3="color_did";
				color4="color_did";
				color5="color_nodid";
				color8=color7=color6="color_nodid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img5="go.png";
				img8=img7=img6="notdid.png";
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color3="background_color_did";
				bg_color4="background_color_did";
				bg_color7=bg_color6=bg_color5="background_color_nodid";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
				time4=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			}
		}else if(operation==7){
			if(applyNum==3){
				title1_flow="title1_flow2";
				title2_flow="title2_flow2";
				title3_flow="title3_flow2";
				color1="color_did";
				color2="color_did";
				color3="color_did";
				color4="color_error";
				color8=color7=color6="color_nodid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="error.png";
				img8=img7=img6="notdid.png";
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color3="background_color_error";
				bg_color7=bg_color6=bg_color5="background_color_nodid";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
				time4=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			}else{
				title1_flow="title1_flow3";
				title2_flow="title2_flow3";
				title3_flow="title3_flow3";
				color1="color_did";
				color2="color_did";
				color3="color_did";
				color4="color_error";
				color5="color_nodid";
				color8=color7=color6="color_nodid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="error.png";
				img5="notdid.png";
				img8=img7=img6="notdid.png";
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color3="background_color_error";
				bg_color4="background_color_nodid";
				bg_color7=bg_color6=bg_color5="background_color_nodid";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
				time4=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			}
		}else if(operation==8){
			if(applyNum==4){
				title1_flow="title1_flow3";
				title2_flow="title2_flow3";
				title3_flow="title3_flow3";
				color1="color_did";
				color2="color_did";
				color3="color_did";
				color4="color_did";
				color6=color5="color_did";
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
				bg_color5=bg_color4="background_color_did";
				bg_color7=bg_color6="background_color_nodid";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
				time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
				time5=sdf.format(lastFlowTime(8, flowList)).replace("#", "<br/>");
			}
		}else if(operation==9){
			title1_flow="title1_flow3";
			title2_flow="title2_flow3";
			title3_flow="title3_flow3";
			color1="color_did";
			color2="color_did";
			color3="color_did";
			color4="color_did";
			color5="color_error";
			color8=color7=color6="color_nodid";
			img1="pass.png";
			img2="pass.png";
			img3="pass.png";
			img4="pass.png";
			img5="error.png";
			img8=img7=img6="notdid.png";
			bg_color1="background_color_did";
			bg_color2="background_color_did";
			bg_color3="background_color_did";
			bg_color4="background_color_error";
			bg_color7=bg_color6=bg_color5="background_color_nodid";
			time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
			time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
			time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
			time5=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}else if(operation==10){
			if(applyNum==2){
				title1_flow="title1_flow1";
				title2_flow="title2_flow1";
				title3_flow="title3_flow1";
				color1="color_did";
				color2="color_did";
				color3="color_did";
				color8=color7=color6="color_did";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img8=img7=img6="pass.png";
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color7=bg_color6=bg_color5="background_color_did";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
				time6=sdf.format(lastFlowTime(12, flowList)).replace("#", "<br/>");
				time7=sdf.format(lastFlowTime(13, flowList)).replace("#", "<br/>");
				time8=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			}else if(applyNum==3){
				title1_flow="title1_flow2";
				title2_flow="title2_flow2";
				title3_flow="title3_flow2";
				color1="color_did";
				color2="color_did";
				color3="color_did";
				color4="color_did";
				color8=color7=color6="color_did";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img8=img7=img6="pass.png";
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color3="background_color_did";
				bg_color7=bg_color6=bg_color5="background_color_did";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
				time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
				time6=sdf.format(lastFlowTime(12, flowList)).replace("#", "<br/>");
				time7=sdf.format(lastFlowTime(13, flowList)).replace("#", "<br/>");
				time8=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			}else{
				title1_flow="title1_flow3";
				title2_flow="title2_flow3";
				title3_flow="title3_flow3";
				color1="color_did";
				color2="color_did";
				color3="color_did";
				color4="color_did";
				color5="color_did";
				color8=color7=color6="color_did";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img5="pass.png";
				img8=img7=img6="pass.png";
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color3="background_color_did";
				bg_color4="background_color_did";
				bg_color7=bg_color6=bg_color5="background_color_did";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
				time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
				time5=sdf.format(lastFlowTime(8, flowList)).replace("#", "<br/>");
				time6=sdf.format(lastFlowTime(12, flowList)).replace("#", "<br/>");
				time7=sdf.format(lastFlowTime(13, flowList)).replace("#", "<br/>");
				time8=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			}
		}else if(operation==11){
			title1_flow="title1_flow0";
			title2_flow="title2_flow0";
			title3_flow="title3_flow0";
			color1="color_did";
			color8="color_error";
			img1="pass.png";
			img8="error.png";
			bg_color7="background_color_error";
			time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
			time8=sdf.format(lastFlowTime(11, flowList)).replace("#", "<br/>");
		}else if(operation==12){
			if(applyNum==2){
				title1_flow="title1_flow1";
				title2_flow="title2_flow1";
				title3_flow="title3_flow1";
				color1="color_did";
				color6=color3=color2="color_did";
				color7="color_nodid";
				color8="color_nodid";
				img1="pass.png";
				img2="pass.png";
				img6=img3="pass.png";
				img7="go.png";
				img8="notdid.png";
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color6=bg_color5="background_color_did";
				bg_color7="background_color_nodid";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
				time6=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			}else if(applyNum==3){
				title1_flow="title1_flow2";
				title2_flow="title2_flow2";
				title3_flow="title3_flow2";
				color1="color_did";
				color2="color_did";
				color3="color_did";
				color4="color_did";
				color6="color_did";
				color8=color7="color_nodid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img6="pass.png";
				img7="go.png";
				img8="notdid.png";
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color3="background_color_did";
				bg_color6=bg_color5="background_color_did";
				bg_color7="background_color_nodid";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
				time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
				time6=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
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
				bg_color6=bg_color5="background_color_did";
				bg_color7="background_color_nodid";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
				time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
				time5=sdf.format(lastFlowTime(8, flowList)).replace("#", "<br/>");
				time6=sdf.format(lastFlowTime(12, flowList)).replace("#", "<br/>");
			}
		}else if(operation==13){
			if(applyNum==2){
				title1_flow="title1_flow1";
				title2_flow="title2_flow1";
				title3_flow="title3_flow1";
				color1="color_did";
				color6=color3=color2="color_did";
				color7="color_did";
				color8="color_nodid";
				img1="pass.png";
				img2="pass.png";
				img6=img3="pass.png";
				img7="pass.png";
				img8="go.png";
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color6=bg_color5="background_color_did";
				bg_color7="background_color_did";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
				time6=sdf.format(lastFlowTime(12, flowList)).replace("#", "<br/>");
				time7=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			}else if(applyNum==3){
				title1_flow="title1_flow2";
				title2_flow="title2_flow2";
				title3_flow="title3_flow2";
				color1="color_did";
				color2="color_did";
				color3="color_did";
				color4="color_did";
				color6="color_did";
				color7="color_did";
				color8="color_nodid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img6="pass.png";
				img7="pass.png";
				img8="go.png";
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color3="background_color_did";
				bg_color5="background_color_did";
				bg_color6="background_color_did";
				bg_color7="background_color_did";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
				time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
				time6=sdf.format(lastFlowTime(12, flowList)).replace("#", "<br/>");
				time7=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			}else{
				title1_flow="title1_flow3";
				title2_flow="title2_flow3";
				title3_flow="title3_flow3";
				color1="color_did";
				color2="color_did";
				color3="color_did";
				color4="color_did";
				color5="color_did";
				color7=color6="color_did";
				color8="color_nodid";
				img1="pass.png";
				img2="pass.png";
				img3="pass.png";
				img4="pass.png";
				img5="pass.png";
				img7=img6="pass.png";
				img8="go.png";
				bg_color1="background_color_did";
				bg_color2="background_color_did";
				bg_color3="background_color_did";
				bg_color4="background_color_did";
				bg_color7=bg_color6=bg_color5="background_color_did";
				time1=sdf.format(purchase_contract.getCreate_time()).replace("#", "<br/>");
				time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
				time3=sdf.format(lastFlowTime(4, flowList)).replace("#", "<br/>");
				time4=sdf.format(lastFlowTime(6, flowList)).replace("#", "<br/>");
				time5=sdf.format(lastFlowTime(8, flowList)).replace("#", "<br/>");
				time6=sdf.format(lastFlowTime(12, flowList)).replace("#", "<br/>");
				time7=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			}
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
		map.put("time1", time1);
		map.put("time2", time2);
		map.put("time3", time3);
		map.put("time4", time4);
		map.put("time5", time5);
		map.put("time6", time6);
		map.put("time7", time7);
		map.put("time8", time8);
		map.put("bg_color1", bg_color1);
		map.put("bg_color2", bg_color2);
		map.put("bg_color3", bg_color3);
		map.put("bg_color4", bg_color4);
		map.put("bg_color5", bg_color5);
		map.put("bg_color6", bg_color6);
		map.put("bg_color7", bg_color7);
		return map;
	}
	@Override
	public boolean checkCanBuy(Purchase_contract purchase_contract,
			User mUser, int operation) {
		int applyNum=getPurchaseApplyNum(purchase_contract);
		if(operation==4){
			return applyNum==2&&permissionsDAO.checkPermission(mUser.getPosition_id(), 118);
		}else if(operation==6){
			return applyNum==3&&permissionsDAO.checkPermission(mUser.getPosition_id(), 118);
		}else if(operation==8){
			return applyNum>3&&permissionsDAO.checkPermission(mUser.getPosition_id(), 118);
		}
		return false;
	}
	@Override
	public boolean checkCanApply(Purchase_contract purchase_contract,
			User mUser, int operation) {
		// TODO Auto-generated method stub
		int applyNum;
		switch (operation) {
			case 1:
				return permissionsDAO.checkPermission(mUser.getPosition_id(), 72);
			case 2:
				return permissionsDAO.checkPermission(mUser.getPosition_id(), 73);
			case 3:
				return permissionsDAO.checkPermission(mUser.getPosition_id(), 72);
			case 4:
				applyNum=getPurchaseApplyNum(purchase_contract);
				if(applyNum>2){
					return permissionsDAO.checkPermission(mUser.getPosition_id(), 74);
				}
				break;
			case 5:
				return permissionsDAO.checkPermission(mUser.getPosition_id(), 73);
			case 6:
				applyNum=getPurchaseApplyNum(purchase_contract);
				if(applyNum>3){
					return permissionsDAO.checkPermission(mUser.getPosition_id(), 75);
				}
				break;
			case 7:
				return permissionsDAO.checkPermission(mUser.getPosition_id(), 74);
			case 9:
				return permissionsDAO.checkPermission(mUser.getPosition_id(), 75);
		}
		return false;
	}
	@Override
	public boolean checkContract_no(String contract_no, int purchase_id) {
		// TODO Auto-generated method stub
		return purchase_contractDAO.checkContract_no(contract_no, purchase_id);
	}
	@Override
	public void updateHasbuy_numFromNum(int purchase_id) {
		// TODO Auto-generated method stub
		purchase_noteDAO.updateHasbuy_numFromNum(purchase_id);
	}
	/****
	 * var stateArray=["待批复","已批复","被拒","撤销中"];
	 */
	@Override
	public List<Purchase_contract> getPurchaseDetailByTime(long starttime1,
			long endtime1, long starttime2, long endtime2) {
		// TODO Auto-generated method stub
		List<Purchase_contract> purchase_contracts=purchase_contractDAO.getPurchasesByTime(starttime1, endtime1,starttime2, endtime2);
		Flow flow=new Flow();
		flow.setType(12);
		flow.setOperation(11);
		for (Purchase_contract purchase_contract : purchase_contracts) {
			List<Purchase_note> notes=purchase_contract.getNotes();
			List<Purchase_note> notes2=new ArrayList<Purchase_note>();
			int operation=purchase_contract.getPurchaseState();
			if(operation==10){
				//已入库
				purchase_contract.setPurchaseState(4);
			}else if(operation==8||operation==12||operation==13){
				//已批复
				purchase_contract.setPurchaseState(1);
			}else if(operation==3||operation==5||operation==7||operation==9){
				//被拒
				purchase_contract.setPurchaseState(3);
			}else{
				flow.setForeign_id(purchase_contract.getId());
				if(flowDAO.getFlowByOperation(flow)==null){
					int applyNum=getPurchaseApplyNum(purchase_contract);
					if((operation==4&&applyNum==2)||(applyNum==3&&operation==6)||(applyNum>3&&operation==8)){
						//已批复
						purchase_contract.setPurchaseState(1);
					}else{
						//待批复
						purchase_contract.setPurchaseState(0);
					}
				}else{
					//撤销中
					purchase_contract.setPurchaseState(3);
				}
			}
			for (Purchase_note purchase_note : notes) {
				int sales_id=purchase_note.getSales_id();
				if(operation==10||operation==13||operation==12){
					if(operation==10){
						//老版本的已采购数量在num字段
						if(purchase_note.getAog_time()==0){
							purchase_note.setAog_time(purchase_contract.getUpdate_time());
							purchase_note.setAog_num(purchase_note.getNum());
						}
					}
				}else{
					purchase_note.setAog_time(0);
					purchase_note.setAog_num(0);
				}
				if(sales_id>0){
					Sales_contract sales_contract=sales_contractDAO.getSales_contractByID(purchase_note.getSales_id());
					if(sales_contract==null){
						purchase_note.setContract_no("");
						purchase_note.setProject_name("");
						purchase_note.setCustomer("");
					}else{
						purchase_note.setContract_no(sales_contract.getContract_no());
						purchase_note.setProject_name(sales_contract.getProject_name());
						Customer_data customer_data=customer_dataDAO.getCustomer_dataByCustomerID(sales_contract.getCustomer_id());
						if(customer_data==null){
							purchase_note.setCustomer("");
						}else{
							purchase_note.setCustomer(customer_data.getCompany_name());
						}
					}
				}
				int product_id=purchase_note.getProduct_id();
				if(product_id>0){
					Product_info product_info=product_infoDAO.getProduct_infoByID(product_id);
					if(product_info==null){
						purchase_note.setContract_num(0);
						purchase_note.setPredict_costing_taxes(0);
						purchase_note.setMaterials_id("");
						purchase_note.setModel("");
						purchase_note.setMaterials_remark("");
					}else{
						purchase_note.setContract_num(product_info.getNum());
						purchase_note.setSale_unit_price_taxes(product_info.getUnit_price_taxes());
						purchase_note.setPredict_costing_taxes(product_info.getPredict_costing_taxes());
						Materials_info materials_info=materials_infoDAO.getMaterials_infoByID(product_info.getM_id());
						if(materials_info==null){
							purchase_note.setMaterials_id("");
							purchase_note.setModel("");
							purchase_note.setMaterials_remark("");
						}else{
							purchase_note.setMaterials_id(materials_info.getMaterials_id());
							purchase_note.setModel(materials_info.getModel());
							purchase_note.setMaterials_remark(materials_info.getRemark());
						}
					}
				}else{
					int m_id=purchase_note.getM_id();
					if(m_id>0){
						Materials_info materials_info=materials_infoDAO.getMaterials_infoByID(m_id);
						if(materials_info==null){
							purchase_note.setMaterials_id("");
							purchase_note.setModel("");
							purchase_note.setMaterials_remark("");
						}else{
							purchase_note.setMaterials_id(materials_info.getMaterials_id());
							purchase_note.setModel(materials_info.getModel());
							purchase_note.setMaterials_remark(materials_info.getRemark());
						}
					}
				}
				notes2.add(purchase_note);
			}
			purchase_contract.setNotes(notes2);
		}
		return purchase_contracts;
	}
}
