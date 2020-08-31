package com.zzqa.service.impl.shipping;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ibatis.common.jdbc.SimpleDataSource;
import com.zzqa.dao.interfaces.customer_data.ICustomer_dataDAO;
import com.zzqa.dao.interfaces.flow.IFlowDAO;
import com.zzqa.dao.interfaces.material.IMaterialDAO;
import com.zzqa.dao.interfaces.materials_info.IMaterials_infoDAO;
import com.zzqa.dao.interfaces.permissions.IPermissionsDAO;
import com.zzqa.dao.interfaces.product_info.IProduct_infoDAO;
import com.zzqa.dao.interfaces.sales_contract.ISales_contractDAO;
import com.zzqa.dao.interfaces.shipping.IShippingDAO;
import com.zzqa.dao.interfaces.shipping_list.IShipping_listDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.pojo.customer_data.Customer_data;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.materials_info.Materials_info;
import com.zzqa.pojo.product_info.Product_info;
import com.zzqa.pojo.product_procurement.Product_procurement;
import com.zzqa.pojo.sales_contract.Sales_contract;
import com.zzqa.pojo.shipping.Shipping;
import com.zzqa.pojo.shipping_list.Shipping_list;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.shipping.ShippingManager;
import com.zzqa.util.DataUtil;
@Service("shippingManager")
public class ShippingManagerImpl implements ShippingManager {
	@Autowired
	private IShipping_listDAO shipping_listDAO;
	@Autowired
	private IShippingDAO shippingDAO;
	@Autowired
	private ISales_contractDAO sales_contractDAO;
	@Autowired
	private IProduct_infoDAO product_infoDAO;
	@Autowired
	private ICustomer_dataDAO customer_dataDAO;
	@Autowired
	private IMaterials_infoDAO materials_infoDAO;
	@Autowired
	private IUserDAO userDAO;
	@Autowired
	private IFlowDAO flowDAO;
	@Autowired
	private IPermissionsDAO permissionsDAO;
	@Override
	public Shipping getNeedShippingBySale(int sales_id) {
		// TODO Auto-generated method stub
		Shipping shipping=new Shipping();
		Sales_contract sales_contract=sales_contractDAO.getSales_contractByID(sales_id);
		if(sales_contract!=null){
			String project_name=sales_contract.getProject_name();
			if(project_name==null){
				shipping.setProject_name("");
			}else{
				shipping.setProject_name(project_name);
			}
			shipping.setContract_no(sales_contract.getContract_no());
			Customer_data customer_data=customer_dataDAO.getCustomer_dataByCustomerID(sales_contract.getCustomer_id());
			if(customer_data==null){
				shipping.setCustomer_name("");
			}else{
				shipping.setCustomer_name(customer_data.getCompany_name());
			}
			String saler=sales_contract.getSaler();
			if(saler==null){
				shipping.setSaler("");
			}else{
				shipping.setSaler(saler);
			}
			List<Product_info> product_infos=product_infos=product_infoDAO.getProduct_infos(sales_id);
			List<Shipping_list> shipping_lists=new ArrayList<Shipping_list>();
			if(product_infos!=null&&product_infos.size()>0){
				for (Product_info product_info: product_infos) {
					//已发货数量
					int hasshipping_num=shipping_listDAO.getShippingNumByProduct(product_info.getId());
					int contract_num=product_info.getNum();
					if(contract_num>hasshipping_num){
						Shipping_list shipping_list=new Shipping_list();
						shipping_list.setLast_num(contract_num-hasshipping_num);
						shipping_list.setContract_num(contract_num);
						shipping_list.setProduct_id(product_info.getId());
						shipping_list.setM_id(product_info.getM_id());
						shipping_list.setUnit_price((float)product_info.getUnit_price_taxes());
						Materials_info materials_info=materials_infoDAO.getMaterials_infoByID(product_info.getM_id());
						shipping_list.setMaterials_id(materials_info.getMaterials_id());
						shipping_list.setName(materials_info.getRemark());
						shipping_list.setModel(materials_info.getModel());
						shipping_list.setUnit(materials_info.getUnit());
						shipping_lists.add(shipping_list);
					}
				}
			}
			shipping.setShipping_lists(shipping_lists);
		}
		return shipping;
	}
	
	@Override
	public void updateShipping(Shipping shipping){
		shippingDAO.updateShipping(shipping);
	}
	
	@Override
	public int insertShipping(Shipping shipping) {
		// TODO Auto-generated method stub
		return shippingDAO.insertShipping(shipping);
	}
	@Override
	public void insertShipping_list(Shipping_list shipping_list) {
		// TODO Auto-generated method stub
		shipping_listDAO.insertShipping_list(shipping_list);
	}
	@Override
	public Shipping getShippingById(int shipping_id) {
		return shippingDAO.getShippingById(shipping_id);
	}
	@Override
	public Shipping getShippingDetailById(int shipping_id) {
		// TODO Auto-generated method stub
		Shipping shipping=shippingDAO.getShippingDetailById(shipping_id);
		if(shipping!=null){
			userDAO.getUserNameByID(shipping.getCreate_id());
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd");
			shipping.setCreate_date(sdf.format(shipping.getCreate_time()));
			shipping.setPutout_date(sdf.format(shipping.getPutout_time()));
			shipping.setShip_date(sdf.format(shipping.getShip_time()));
			shipping.setDepart(DataUtil.getdepartment()[shipping.getDepartment()]);
			Sales_contract sales_contract=sales_contractDAO.getSales_contractByID(shipping.getSales_id());
			if(sales_contract!=null){
				shipping.setSaler(sales_contract.getSaler());
				String project_name=sales_contract.getProject_name();
				if(project_name==null){
					shipping.setProject_name("");
				}else{
					shipping.setProject_name(project_name);
				}
				shipping.setContract_no(sales_contract.getContract_no());
				Customer_data customer_data=customer_dataDAO.getCustomer_dataByCustomerID(sales_contract.getCustomer_id());
				if(customer_data==null){
					shipping.setCustomer_name("");
				}else{
					shipping.setCustomer_name(customer_data.getCompany_name());
				}
				shipping.setCreate_name(userDAO.getUserNameByID(shipping.getCreate_id()));
			}
			List<Shipping_list> shipping_lists=shipping.getShipping_lists();
			if(shipping_lists!=null){
				for (Shipping_list shipping_list : shipping_lists) {
					int product_id=shipping_list.getProduct_id();
					if(shipping_list.getUnit()==null){
						shipping_list.setUnit("");
					}
					if(product_id>0){
						Product_info product_info=product_infoDAO.getProduct_infoByID(product_id);
						if(product_info!=null){
							//已发货数量
							int hasshipping_num=shipping_listDAO.getShippingNumByProduct(product_id);
							int contract_num=product_info.getNum();
							shipping_list.setContract_num(contract_num);
							shipping_list.setLast_num(contract_num>hasshipping_num?(contract_num-hasshipping_num):0);
							shipping_list.setM_id(product_info.getM_id());
							shipping_list.setUnit_price((float)product_info.getUnit_price_taxes());
							Materials_info materials_info=materials_infoDAO.getMaterials_infoByID(product_info.getM_id());
							if(materials_info!=null){
								shipping_list.setMaterials_id(materials_info.getMaterials_id());
								shipping_list.setName(materials_info.getRemark());
								shipping_list.setModel(materials_info.getModel());
							}
						}
					}else{
						Materials_info materials_info=materials_infoDAO.getMaterials_infoByID(shipping_list.getM_id());
						if(materials_info!=null){
							shipping_list.setMaterials_id(materials_info.getMaterials_id());
							shipping_list.setName(materials_info.getRemark());
							shipping_list.setModel(materials_info.getModel());
						}
					}
				}
				shipping.setShipping_lists(shipping_lists);
			}
		}
		return shipping;
	}
	@Override
	public List<Shipping> getShippingListByUID(User user) {
		// TODO Auto-generated method stub
		List<Shipping> shippings=shippingDAO.getRunningShipping();//查询所有未完成的生产流程
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		String[] flowArray18=DataUtil.getFlowArray(18);
		List<Shipping> list=new ArrayList<Shipping>();
		for(Shipping shipping:shippings){
			User userByID = userDAO.getUserByID(shipping.getCreate_id());
			if(userByID==null || userByID.getPosition_id()==56){
				continue;
			}
			Flow flow=flowDAO.getNewFlowByFID(18, shipping.getId());//查询最新流程
			if(flow!=null&&checkMyOperation(flow.getOperation(),user,shipping)){
				Sales_contract sales_contract=sales_contractDAO.getSales_contractByID(shipping.getSales_id());
				if(sales_contract==null){
					continue;
				}
				shipping.setContract_no(sales_contract.getContract_no());
				Customer_data customer_data=customer_dataDAO.getCustomer_dataByCustomerID(sales_contract.getCustomer_id());
				if(customer_data==null){
					shipping.setName("");
				}else{
					shipping.setName(customer_data.getCompany_name());
				}
				String process=sdf.format(flow.getCreate_time())+flowArray18[flow.getOperation()];
				shipping.setProcess(process);
				shipping.setCreate_name(userByID.getTruename());
				list.add(shipping);
			}
		}
		return list;
	}
	public boolean checkMyOperation(int operation,User user,Shipping shipping){
		boolean flag=false;
		switch (operation) {
		case 1:
			flag=permissionsDAO.checkPermission(user.getPosition_id(), 127);
			break;
		case 2:
			flag=permissionsDAO.checkPermission(user.getPosition_id(), 128);
			break;
		case 3:
			flag=shipping.getCreate_id()==user.getId();
			break;
		case 4:
			flag=permissionsDAO.checkPermission(user.getPosition_id(), 129);
			break;
		case 5:
			flag=permissionsDAO.checkPermission(user.getPosition_id(), 129);
			break;
		default:
			break;
		}
		return flag;
		
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
	public Map<String, String> getShippingFlowForDraw(Shipping shipping,
			Flow flow) {
		// TODO Auto-generated method stub
		int operation=flow.getOperation();
		Map<String, String> map=new HashMap<String, String>();
		List<Flow> flowList=flowDAO.getFlowListByCondition(18,shipping.getId());
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd#HH:mm:ss");
		String title1_flow=null;
		String title2_flow=null;
		String title3_flow=null;
		String color1=null;
		String color2=null;
		String color3=null;
		String color4=null;
		String color5=null;
		String img1=null;
		String img2=null;
		String img3=null;
		String img4=null;
		String img5=null;
		String time1=null;
		String time2=null;
		String time3=null;
		String time4=null;
		String time5=null;
		String bg_color1=null;
		String bg_color2=null;
		String bg_color3=null;
		String bg_color4=null; 
		if(operation==1){
			title1_flow="title1_flow1";
			title2_flow="title2_flow1";
			title3_flow="title3_flow1";
			color1="color_did";
			color2="color_nodid";
			color3="color_nodid";
			color4="color_nodid";
			color5="color_nodid";
			img1="pass.png";
			img2="go.png";
			img3="notdid.png";
			img4="notdid.png";
			img5="notdid.png";
			bg_color1="background_color_did";
			bg_color2="background_color_nodid";
			bg_color3="background_color_nodid";
			bg_color4="background_color_nodid";
			time1=sdf.format(shipping.getCreate_time()).replace("#", "<br/>");
		}else if(operation==2){
			title1_flow="title1_flow1";
			title2_flow="title2_flow1";
			title3_flow="title3_flow1";
			color1="color_did";
			color2="color_did";
			color3="color_nodid";
			color4="color_nodid";
			color5="color_nodid";
			img1="pass.png";
			img2="pass.png";
			img3="go.png";
			img4="notdid.png";
			img5="notdid.png";
			bg_color1="background_color_did";
			bg_color2="background_color_did";
			bg_color3="background_color_nodid";
			bg_color4="background_color_nodid";
			time1=sdf.format(shipping.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
		}else if(operation==3){
			title1_flow="title1_flow1";
			title2_flow="title2_flow1";
			title3_flow="title3_flow1";
			color1="color_did";
			color2="color_error";
			color3="color_nodid";
			color4="color_nodid";
			color5="color_nodid";
			img1="pass.png";
			img2="error.png";
			img3="notdid.png";
			img4="notdid.png";
			img5="notdid.png";
			bg_color1="background_color_error";
			bg_color2="background_color_nodid";
			bg_color3="background_color_nodid";
			bg_color4="background_color_nodid";
			time1=sdf.format(shipping.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
		}else if(operation==4){
			title1_flow="title1_flow1";
			title2_flow="title2_flow1";
			title3_flow="title3_flow1";
			color1="color_did";
			color2="color_did";
			color3="color_did";
			color4="color_nodid";
			color5="color_nodid";
			img1="pass.png";
			img2="pass.png";
			img3="pass.png";
			img4="go.png";
			img5="notdid.png";
			bg_color1="background_color_did";
			bg_color2="background_color_did";
			bg_color3="background_color_did";
			bg_color4="background_color_nodid";
			time1=sdf.format(shipping.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(2,flowList)).replace("#", "<br/>");
			time3=sdf.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
		}else if(operation==5){
			title1_flow="title1_flow1";
			title2_flow="title2_flow1";
			title3_flow="title3_flow1";
			color1="color_did";
			color2="color_did";
			color3="color_did";
			color4="color_did";
			color5="color_nodid";
			img1="pass.png";
			img2="pass.png";
			img3="pass.png";
			img4="pass.png";
			img5="go.png";
			bg_color1="background_color_did";
			bg_color2="background_color_did";
			bg_color3="background_color_did";
			bg_color4="background_color_did";
			time1=sdf.format(shipping.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(2,flowList)).replace("#", "<br/>");
			time3=sdf.format(lastFlowTime(4,flowList)).replace("#", "<br/>");
			time4=sdf.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
		}else if(operation==6){
			title1_flow="title1_flow1";
			title2_flow="title2_flow1";
			title3_flow="title3_flow1";
			color1="color_did";
			color2="color_did";
			color3="color_did";
			color4="color_did";
			color5="color_did";
			img1="pass.png";
			img2="pass.png";
			img3="pass.png";
			img4="pass.png";
			img5="pass.png";
			bg_color1="background_color_did";
			bg_color2="background_color_did";
			bg_color3="background_color_did";
			bg_color4="background_color_did";
			time1=sdf.format(shipping.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(2,flowList)).replace("#", "<br/>");
			time3=sdf.format(lastFlowTime(4,flowList)).replace("#", "<br/>");
			time4=sdf.format(lastFlowTime(5,flowList)).replace("#", "<br/>");
			time5=sdf.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
		}else if(operation==7){
			title1_flow="title1_flow0";
			title2_flow="title2_flow0";
			title3_flow="title3_flow0";
			color1="color_did";
			color5="color_error";
			img1="pass.png";
			img5="error.png";
			bg_color4="background_color_error";
			time1=sdf.format(shipping.getCreate_time()).replace("#", "<br/>");
			time5=sdf.format(lastFlowTime(operation,flowList)).replace("#", "<br/>");
		}
		map.put("title1_flow", title1_flow);
		map.put("title2_flow", title2_flow);
		map.put("title3_flow", title3_flow);
		map.put("color1", color1);
		map.put("color2", color2);
		map.put("color3", color3);
		map.put("color4", color4);
		map.put("color5", color5);
		map.put("img1", img1);
		map.put("img2", img2);
		map.put("img3", img3);
		map.put("img4", img4);
		map.put("img5", img5);
		map.put("time1", time1);
		map.put("time2", time2);
		map.put("time3", time3);
		map.put("time4", time4);
		map.put("time5", time5);
		map.put("bg_color1", bg_color1);
		map.put("bg_color2", bg_color2);
		map.put("bg_color3", bg_color3);
		map.put("bg_color4", bg_color4);
		return map;
	}

	@Override
	public void delShipping_listByShipping_id(int shipping_id) {
		// TODO Auto-generated method stub
		shipping_listDAO.delShipping_listByShipping_id(shipping_id);
	}

	@Override
	public List<Shipping> getShippingDetailByTime(long starttime1,
			long endtime1, long starttime2, long endtime2) {
		// TODO Auto-generated method stub
		Map map=new HashMap();
		map.put("starttime1", starttime1);
		map.put("endtime1", endtime1);
		map.put("starttime2", starttime2);
		map.put("endtime2", endtime2);
		List<Integer> shippingIDs=shippingDAO.getShippingDetailByTime(map);
		List<Shipping> shippings=new ArrayList<Shipping>();
		for (Integer shipping_id : shippingIDs) {
			Shipping shipping=getShippingDetailById(shipping_id);
			shippings.add(shipping);
		}
		return shippings;
	}

	@Override
	public List<Map> getAllNoShippingSale() {
		// TODO Auto-generated method stub
		List<Sales_contract> sales_contracts=sales_contractDAO.getFinishedSales();
		if(sales_contracts==null){
			return null;
		}
		List<Map> list=new ArrayList<Map>();
		for (Sales_contract sales_contract : sales_contracts) {
			List<Product_info> product_infos=product_infos=product_infoDAO.getProduct_infos(sales_contract.getId());
			List<Shipping_list> shipping_lists=new ArrayList<Shipping_list>();
			if(product_infos==null||product_infos.size()==0){
				continue;
			}
			boolean hasshipping=false;
			for (Product_info product_info: product_infos) {
				//已发货数量
				int hasshipping_num=shipping_listDAO.getShippingNumByProduct(product_info.getId());
				int contract_num=product_info.getNum();
				if(contract_num>hasshipping_num){
					hasshipping=true;
					Shipping_list shipping_list=new Shipping_list();
					shipping_list.setLast_num(contract_num-hasshipping_num);
					shipping_list.setContract_num(contract_num);
					shipping_list.setProduct_id(product_info.getId());
					shipping_list.setM_id(product_info.getM_id());
					shipping_list.setUnit_price((float)product_info.getUnit_price_taxes());
					Materials_info materials_info=materials_infoDAO.getMaterials_infoByID(product_info.getM_id());
					shipping_list.setMaterials_id(materials_info.getMaterials_id());
					shipping_list.setName(materials_info.getRemark());
					shipping_list.setModel(materials_info.getModel());
					shipping_list.setUnit(materials_info.getUnit());
					shipping_lists.add(shipping_list);
				}
			}
			if(!hasshipping){
				//全部已发货
				continue;
			}
			Map map=new HashMap();
			map.put("id", sales_contract.getId());
			map.put("contract_no", sales_contract.getContract_no());
			map.put("saler", sales_contract.getSaler());
			map.put("shipping_lists", shipping_lists);
			Customer_data customer_data=customer_dataDAO.getCustomer_dataByCustomerID(sales_contract.getCustomer_id());
			if(customer_data==null){
				map.put("customer_name", "");
			}else{
				map.put("customer_name", customer_data.getCompany_name());
			}
			list.add(map);
		}
		return list;
	}
}
