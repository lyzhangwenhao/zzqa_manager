package com.zzqa.service.impl.product_procurement;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.file_path.IFile_pathDAO;
import com.zzqa.dao.interfaces.flow.IFlowDAO;
import com.zzqa.dao.interfaces.permissions.IPermissionsDAO;
import com.zzqa.dao.interfaces.position_user.IPosition_userDAO;
import com.zzqa.dao.interfaces.procurement.IProcurementDAO;
import com.zzqa.dao.interfaces.product_procurement.IProduct_procurementDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.procurement.Procurement;
import com.zzqa.pojo.product_procurement.Product_procurement;
import com.zzqa.pojo.task.Task;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.product_procurement.Product_procurementManager;
import com.zzqa.servlet.DelayEmailServlet;
import com.zzqa.util.DataUtil;
@Component("product_procurementManager")
public class Product_procurementManagerImpl implements
		Product_procurementManager {
	@Autowired
	private IProduct_procurementDAO product_procurementDAO;
	@Autowired
	private IProcurementDAO procurementDAO;
	@Autowired
	private IUserDAO userDAO;
	@Autowired
	private IPosition_userDAO position_userDAO;
	@Autowired
	private IFile_pathDAO file_pathDAO;
	@Autowired
	private IFlowDAO flowDAO;
	@Autowired
	private IPermissionsDAO permissionsDAO;
	
	public void insertProcurement(Procurement procurement) {
		// TODO Auto-generated method stub
		procurementDAO.insertProcurement(procurement);
	}
	public void insertProduct_procurement(
			Product_procurement product_procurement) {
		// TODO Auto-generated method stub
		product_procurementDAO.insertProduct_procurement(product_procurement);
	}
	public int getNewProduct_procurementByUID(int create_id) {
		// TODO Auto-generated method stub
		return product_procurementDAO.getNewProduct_procurementByUID(create_id);
	}
	public int insertProduct(Product_procurement product_procurement) {
		// TODO Auto-generated method stub
		product_procurementDAO.insertProduct_procurement(product_procurement);
		return product_procurementDAO.getNewProduct_procurementByUID(product_procurement.getCreate_id());
	}
	public List getProduct_procurementList(int beginrow,int rows) {
		// TODO Auto-generated method stub
		Map map=new HashMap();
		map.put("beginrow", beginrow);
		map.put("rows", rows);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		List<Product_procurement> product_procurementList=product_procurementDAO.getProduct_procurementList(map);
		List<Product_procurement> pList=new ArrayList<Product_procurement>();
		String[] flowArray2=DataUtil.getFlowArray(2);
		for(Product_procurement product_procurement:product_procurementList){
			Flow flow=flowDAO.getNewFlowByFID(2, product_procurement.getId());//查询最新流程
			if(flow!=null){
				String process=sdf.format(product_procurement.getCreate_time())+flowArray2[flow.getOperation()];
				product_procurement.setProcess(process);
				product_procurement.setName(DataUtil.getNameByTime(2, product_procurement.getCreate_time()));
				pList.add(product_procurement);
			}
			
		}
		return pList;
	}
	public Product_procurement getProduct_procurementByID(int id) {
		// TODO Auto-generated method stub
		Product_procurement pp=product_procurementDAO.getProduct_procurementByID(id);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		if(pp!=null){
			pp.setCreate_date(sdf.format(pp.getCreate_time()));
		    pp.setCreate_name(userDAO.getUserNameByID(pp.getCreate_id()));
		    pp.setReceive_name(userDAO.getUserNameByID(pp.getReceive_id()));
		    pp.setPredict_date(pp.getPredict_time()==0?"":sdf.format(pp.getPredict_time()));
		    pp.setAog_date(pp.getAog_time()==0?"":sdf.format(pp.getAog_time()));
		    pp.setCheck_name(userDAO.getUserNameByID(pp.getCheck_id()));
		    pp.setPutin_name(userDAO.getUserNameByID(pp.getPutin_id()));
		    pp.setName(DataUtil.getNameByTime(2,pp.getCreate_time()));
		}
		return pp;
	}
	public Product_procurement getProduct_procurementByID2(int id) {
		// TODO Auto-generated method stub
		Product_procurement pp=product_procurementDAO.getProduct_procurementByID(id);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		Flow flow=flowDAO.getNewFlowByFID(2,id);//查询最新流程
		String process=sdf.format(flow.getCreate_time())+DataUtil.getFlowArray(2)[flow.getOperation()];
		pp.setProcess(process);
		pp.setName(DataUtil.getNameByTime(2,pp.getCreate_time()));
		pp.setCreate_name(userDAO.getUserNameByID(pp.getCreate_id()));
		return pp;
	}
	public long lastFlowTime(int operation,List<Flow> flowList){
		int len=flowList.size();
		for (int i = 0; i < len; i++) {
			if(flowList.get(len-i-1).getOperation()==operation){
				return flowList.get(len-i-1).getCreate_time();
			}
		}
		return 0;
	}
	public Map<String, String> getProductPFlowForDraw(Product_procurement product_procurement,Flow flow) {
		// TODO Auto-generated method stub
		int operation=flow.getOperation();
		Map<String, String> map=new HashMap<String, String>();
		List<Flow> flowList=flowDAO.getFlowListByCondition(2,product_procurement.getId());
		SimpleDateFormat dft=new SimpleDateFormat("yyyy-MM-dd*HH:mm:ss");
		String class11="";
		String class12="";
		String class13="";
		String class15="";
		String class16="";
		String img1="pass.png";
		String img2="pass.png";
		String img3="pass.png";
		String img5="pass.png";
		String img6="pass.png";
		String time1="";
		String time2="";
		String time3="";
		String time5="";
		String time6="";
		String class22="";
		String class24="";
		String class245="";
		String class255="";
		String class28="";
		if(operation==1){
			//创建
			 class11="td2_div11_pass";
			 class12="td2_div12_nodid";
			 class13="td2_div13_nodid";
			 class15="td2_div15_nodid";
			 class16="td2_div16_nodid";
			 img1="pass.png";
			 img2="go.png";
			 img3="notdid.png";
			 img5="notdid.png";
			 img6="notdid.png";
			 time1=dft.format(product_procurement.getCreate_time()).replace("*", "<br/>");
			 time2="";
			 time3="";
			 time5="";
			 time6="";
			 class22="td2_div2_agree";
			 class24="td2_div2_nodid";
			 class245="td2_div2_nodid_c";
			 class255="td2_div2_nodid_c";
			 class28="td2_div2_nodid";
		}else if(operation==2){
			//运营总监审核通过
			 class11="td2_div11_pass";
			 class12="td2_div12_pass";
			 class13="td2_div13_nodid";
			 class15="td2_div15_nodid";
			 class16="td2_div16_nodid";
			 img1="pass.png";
			 img2="pass.png";
			 img3="go.png";
			 img5="notdid.png";
			 img6="notdid.png";
			 time1=dft.format(product_procurement.getCreate_time()).replace("*", "<br/>");
			 time2=dft.format(lastFlowTime(operation,flowList)).replace("*", "<br/>");
			 time3="";
			 time5="";
			 time6="";
			 class22="td2_div2_agree";
			 class24="td2_div2_agree";
			 class245="td2_div2_nodid_c";
			 class255="td2_div2_nodid_c";
			 class28="td2_div2_nodid";
		}else if(operation==3){
			//运营总监审核未通过
			 class11="td2_div11_pass";
			 class12="td2_div12_nopass";
			 class13="td2_div13_nodid";
			 class15="td2_div15_nodid";
			 class16="td2_div16_nodid";
			 img1="pass.png";
			 img2="error.png";
			 img3="notdid.png";
			 img5="notdid.png";
			 img6="notdid.png";
			 time1=dft.format(product_procurement.getCreate_time()).replace("*", "<br/>");
			 time2=dft.format(lastFlowTime(operation,flowList)).replace("*", "<br/>");
			 time3="";
			 time5="";
			 time6="";
			 class22="td2_div2_disagree";
			 class24="td2_div2_nodid";
			 class245="td2_div2_nodid_c";
			 class255="td2_div2_nodid_c";
			 class28="td2_div2_nodid";
		}else if(operation==4){
			//采购人员已确认
			 class11="td2_div11_pass";
			 class12="td2_div12_pass";
			 class13="td2_div13_pass";
			 class15="td2_div15_nodid";
			 class16="td2_div16_nodid";
			 img1="pass.png";
			 img2="pass.png";
			 img3="pass.png";
			 img5="notdid.png";
			 img6="notdid.png";
			 time1=dft.format(product_procurement.getCreate_time()).replace("*", "<br/>");
			 time2=dft.format(lastFlowTime(2,flowList)).replace("*", "<br/>");
			 time3=dft.format(lastFlowTime(operation,flowList)).replace("*", "<br/>");
			 time5="";
			 time6="";
			 class22="td2_div2_agree";
			 class24="td2_div2_agree";
			 class245="td2_div2_agree_c";
			 class255="td2_div2_nodid_c";
			 class28="td2_div2_nodid";
		}else if(operation==5){
			//完成采购
			 class11="td2_div11_pass";
			 class12="td2_div12_pass";
			 class13="td2_div13_pass";
			 class15="td2_div15_nodid";
			 class16="td2_div16_nodid";
			 img1="pass.png";
			 img2="pass.png";
			 img3="pass.png";
			 img5="go.png";
			 img6="notdid.png";
			 time1=dft.format(product_procurement.getCreate_time()).replace("*", "<br/>");
			 time2=dft.format(lastFlowTime(2,flowList)).replace("*", "<br/>");
			 time3=dft.format(lastFlowTime(4,flowList)).replace("*", "<br/>");
			 time5="";
			 time6="";
			 class22="td2_div2_agree";
			 class24="td2_div2_agree";
			 class245="td2_div2_agree_c";
			 class255="td2_div2_agree_c";
			 class28="td2_div2_nodid";
		}else if(operation==7){
			//验货
			 class11="td2_div11_pass";
			 class12="td2_div12_pass";
			 class13="td2_div13_pass";
			 class15="td2_div15_pass";
			 class16="td2_div16_nodid";
			 img1="pass.png";
			 img2="pass.png";
			 img3="pass.png";
			 img5="pass.png";
			 img6="go.png";
			 time1=dft.format(product_procurement.getCreate_time()).replace("*", "<br/>");
			 time2=dft.format(lastFlowTime(2,flowList)).replace("*", "<br/>");
			 time3=dft.format(lastFlowTime(4,flowList)).replace("*", "<br/>");
			 time5=dft.format(lastFlowTime(7,flowList)).replace("*", "<br/>");
			 time6="";
			 class22="td2_div2_agree";
			 class24="td2_div2_agree";
			 class245="td2_div2_agree_c";
			 class255="td2_div2_agree_c";
			 class28="td2_div2_agree";
		}else if(operation==8){
			//入库
			 class11="td2_div11_pass";
			 class12="td2_div12_pass";
			 class13="td2_div13_pass";
			 class15="td2_div15_pass";
			 class16="td2_div16_pass";
			 img1="pass.png";
			 img2="pass.png";
			 img3="pass.png";
			 img5="pass.png";
			 img6="pass.png";
			 time1=dft.format(product_procurement.getCreate_time()).replace("*", "<br/>");
			 time2=dft.format(lastFlowTime(2,flowList)).replace("*", "<br/>");
			 time3=dft.format(lastFlowTime(4,flowList)).replace("*", "<br/>");
			 time5=dft.format(lastFlowTime(7,flowList)).replace("*", "<br/>");
			 time6=dft.format(lastFlowTime(8,flowList)).replace("*", "<br/>");
			 class22="td2_div2_agree";
			 class24="td2_div2_agree";
			 class245="td2_div2_agree_c";
			 class255="td2_div2_agree_c";
			 class28="td2_div2_agree";
		}
		map.put("class11", class11);
		map.put("class12", class12);
		map.put("class13", class13);
		map.put("class15", class15);
		map.put("class16", class16);
		
		map.put("img1", img1);
		map.put("img2", img2);
		map.put("img3", img3);
		map.put("img5", img5);
		map.put("img6", img6);
		
		map.put("time1", time1);
		map.put("time2", time2);
		map.put("time3", time3);
		map.put("time5", time5);
		map.put("time6", time6);
		
		map.put("class22", class22);
		map.put("class24", class24);
		map.put("class245", class245);
		map.put("class255", class255);
		map.put("class28", class28);
		return map;
	}
	public void updateProduct_procurement(
			Product_procurement product_procurement) {
		// TODO Auto-generated method stub
		product_procurementDAO.updateProduct_procurement(product_procurement);
	}
	public List<Product_procurement> getProduct_procurementListByUID(User user) {
		// TODO Auto-generated method stub
		List<Product_procurement> product_procurementList=product_procurementDAO.getRunningProduct_procurement();//查询所有未完成的生产流程
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		String[] flowArray2=DataUtil.getFlowArray(2);
		Iterator<Product_procurement> iterator=product_procurementList.iterator();
		while (iterator.hasNext()) {
			Product_procurement product_procurement = (Product_procurement) iterator.next();
			User userByID = userDAO.getUserByID(product_procurement.getCreate_id());
			if(userByID==null || userByID.getPosition_id()==56){
				iterator.remove();
				continue;
			}
			Flow flow=flowDAO.getNewFlowByFID(2, product_procurement.getId());//查询最新流程
			if(flow!=null&&checkMyOperation(flow.getOperation(),user,product_procurement)){
				String process=sdf.format(flow.getCreate_time())+flowArray2[flow.getOperation()];
				product_procurement.setProcess(process);
				product_procurement.setName(DataUtil.getNameByProductNameAndTime(product_procurement.getProduct_name(),2,product_procurement.getCreate_time()));
				product_procurement.setCreate_name(userByID.getTruename());
			}else{
				iterator.remove();
			}
		}
		return product_procurementList;
	}
	public boolean checkMyOperation(int operation,User user,Product_procurement product_procurement){
		boolean flag=false;
		switch (operation) {
		case 1:
//			flag=permissionsDAO.checkPermission(user.getPosition_id(), 17);
			flag=permissionsDAO.checkPermission(user.getPosition_id(), 182);
			break;
		case 2:
			flag=permissionsDAO.checkPermission(user.getPosition_id(), 21);
			break;
		case 3:
			flag=product_procurement.getCreate_id()==user.getId();
			break;
		case 4:
			flag=permissionsDAO.checkPermission(user.getPosition_id(), 21);/*||product_procurement.getCreate_id()==user.getId()*/
			break;
		case 5:
			flag=permissionsDAO.checkPermission(user.getPosition_id(), 22);
			break;
		case 7:
			flag=permissionsDAO.checkPermission(user.getPosition_id(), 23);
			break;
		default:
			break;
		}
		return flag;
		
	}
	public List getFinishedProduct_procurement() {
		// TODO Auto-generated method stub
		List<Product_procurement> ppList=product_procurementDAO.getFinishedProduct_procurement();
		for(Product_procurement pp:ppList){
			pp.setName(DataUtil.getNameBySecond(2,pp.getCreate_time()));
		}
		return ppList;
	}
}
