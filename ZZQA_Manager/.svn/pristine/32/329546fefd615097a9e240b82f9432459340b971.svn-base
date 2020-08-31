package com.zzqa.service.impl.outsource_product;

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
import com.zzqa.dao.interfaces.outsource_product.IOutsource_productDAO;
import com.zzqa.dao.interfaces.permissions.IPermissionsDAO;
import com.zzqa.dao.interfaces.position_user.IPosition_userDAO;
import com.zzqa.dao.interfaces.procurement.IProcurementDAO;
import com.zzqa.dao.interfaces.product_procurement.IProduct_procurementDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.outsource_product.Outsource_product;
import com.zzqa.pojo.position_user.Position_user;
import com.zzqa.pojo.project_procurement.Project_procurement;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.outsource_product.Outsource_productManager;
import com.zzqa.servlet.DelayEmailServlet;
import com.zzqa.util.DataUtil;
@Component("outsource_productManager")
public class Outsource_productManagerImpl implements Outsource_productManager {
	@Autowired
	private IOutsource_productDAO outsource_productDAO;
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

	public void delOutsource_productByID(int id) {
		// TODO Auto-generated method stub
		outsource_productDAO.delOutsource_productByID(id);
	}
	public int getNewOutsource_productByUID(int uid) {
		// TODO Auto-generated method stub
		return outsource_productDAO.getNewOutsource_productByUID(uid);
	}
	public Outsource_product getOutsource_productByID(int id) {
		// TODO Auto-generated method stub
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		Outsource_product op=outsource_productDAO.getOutsource_productByID(id);
		op.setPredict_date(op.getPredict_time()==0?"":sdf.format(op.getPredict_time()));
		op.setAog_date(op.getAog_time()==0?"":sdf.format(op.getAog_time()));
		return op;
	}
	public Outsource_product getOutsource_productByID2(int id) {
		// TODO Auto-generated method stub
		Outsource_product op=outsource_productDAO.getOutsource_productByID(id);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		Flow flow=flowDAO.getNewFlowByFID(4, id);//查询最新流程
		String process=sdf.format(flow.getCreate_time())+DataUtil.getFlowArray(4)[flow.getOperation()];
		op.setProcess(process);
		op.setName(DataUtil.getNameByTime(4, op.getCreate_time()));
		op.setCreate_name(userDAO.getUserNameByID(op.getCreate_id()));
		return op;
	}
	
	public int getOutsource_productCount() {
		// TODO Auto-generated method stub
		return outsource_productDAO.getOutsource_productCount();
	}
	public List getOutsource_productList(int beginrow,int rows) {
		// TODO Auto-generated method stub
		Map map=new HashMap();
		map.put("beginrow", beginrow);
		map.put("rows", rows);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		List<Outsource_product> out_pList=outsource_productDAO.getOutsource_productList(map);
		String[] flowArray4=DataUtil.getFlowArray(4);
		for(Outsource_product outsource_product:out_pList){
			Flow flow=flowDAO.getNewFlowByFID(4, outsource_product.getId());//查询最新流程
			if(flow!=null){
				String process=sdf.format(flow.getCreate_time())+flowArray4[flow.getOperation()];
				outsource_product.setProcess(process);
				outsource_product.setName(DataUtil.getNameByTime(4, outsource_product.getCreate_time()));
			}
		}
		return out_pList;
	}
	public void insertOutsource_product(Outsource_product outsource_product) {
		// TODO Auto-generated method stub
		outsource_productDAO.insertOutsource_product(outsource_product);
	}
	public void updateOutsource_product(Outsource_product outsource_product) {
		// TODO Auto-generated method stub
		outsource_productDAO.updateOutsource_product(outsource_product);
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
	public Map<String, String> getOutPFlowForDraw(Outsource_product op,Flow flow) {
		// TODO Auto-generated method stub
		int operation=flow.getOperation();
		Map<String, String> map=new HashMap<String, String>();
		List<Flow> flowList=flowDAO.getFlowListByCondition(4,op.getId());
		SimpleDateFormat dft=new SimpleDateFormat("yyyy-MM-dd*HH:mm:ss");
		String class11="";
		String class12="";
		String class13="";
		String class14="";
		String class15="";
		String img1="pass.png";
		String img2="pass.png";
		String img3="pass.png";
		String img4="pass.png";
		String img5="pass.png";
		String time1="";
		String time2="";
		String time3="";
		String time4="";
		String time5="";
		String class22="";
		String class235="";
		String class245="";
		String class26="";
		String class28="";
		if(operation==1){
			//创建
			 class11="td2_div11_pass";
			 class12="td2_div12_nodid";
			 class13="td2_div13_nodid";
			 class14="td2_div14_nodid";
			 class15="td2_div15_nodid";
			 img1="pass.png";
			 img2="go.png";
			 img3="notdid.png";
			 img4="notdid.png";
			 img5="notdid.png";
			 time1=dft.format(op.getCreate_time()).replace("*", "<br/>");
			 time2="";
			 time3="";
			 time4="";
			 time5="";
			 class22="td2_div2_agree";
			 class235="td2_div2_nodid_c";
			 class245="td2_div2_nodid_c";
			 class26="td2_div2_nodid";
			 class28="td2_div2_nodid";
		}else if(operation==2){
			//出库
			 class11="td2_div11_pass";
			 class12="td2_div12_pass";
			 class13="td2_div13_nodid";
			 class14="td2_div14_nodid";
			 class15="td2_div15_nodid";
			 img1="pass.png";
			 img2="pass.png";
			 img3="notdid.png";
			 img4="notdid.png";
			 img5="notdid.png";
			 time1=dft.format(op.getCreate_time()).replace("*", "<br/>");
			 time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			 time3="";
			 time4="";
			 time5="";
			 class22="td2_div2_agree";
			 class235="td2_div2_nodid_c";
			 class245="td2_div2_nodid_c";
			 class26="td2_div2_nodid";
			 class28="td2_div2_nodid";
		}else if(operation==3){
			//生产中
			 class11="td2_div11_pass";
			 class12="td2_div12_pass";
			 class13="td2_div13_nodid";
			 class14="td2_div14_nodid";
			 class15="td2_div15_nodid";
			 img1="pass.png";
			 img2="pass.png";
			 img3="notdid.png";
			 img4="notdid.png";
			 img5="notdid.png";
			 time1=dft.format(op.getCreate_time()).replace("*", "<br/>");
			 time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			 time3="";
			 time4="";
			 time5="";
			 class22="td2_div2_agree";
			 class235="td2_div2_agree_c";
			 class245="td2_div2_nodid_c";
			 class26="td2_div2_nodid";
			 class28="td2_div2_nodid";
		}else if(operation==4){
			//取回
			 class11="td2_div11_pass";
			 class12="td2_div12_pass";
			 class13="td2_div13_pass";
			 class14="td2_div14_nodid";
			 class15="td2_div15_nodid";
			 img1="pass.png";
			 img2="pass.png";
			 img3="pass.png";
			 img4="go.png";
			 img5="notdid.png";
			 time1=dft.format(op.getCreate_time()).replace("*", "<br/>");
			 time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			 time3=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
			 time4="";
			 time5="";
			 class22="td2_div2_agree";
			 class235="td2_div2_agree_c";
			 class245="td2_div2_agree_c";
			 class26="td2_div2_agree";
			 class28="td2_div2_nodid";
		}else if(operation==5){
			//验货
			 class11="td2_div11_pass";
			 class12="td2_div12_pass";
			 class13="td2_div13_pass";
			 class14="td2_div14_pass";
			 class15="td2_div15_nodid";
			 img1="pass.png";
			 img2="pass.png";
			 img3="pass.png";
			 img4="pass.png";
			 img5="go.png";
			 time1=dft.format(op.getCreate_time()).replace("*", "<br/>");
			 time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			 time3=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
			 time4=dft.format(lastFlowTime(5, flowList)).replace("*", "<br/>");
			 time5="";
			 class22="td2_div2_agree";
			 class235="td2_div2_agree_c";
			 class245="td2_div2_agree_c";
			 class26="td2_div2_agree";
			 class28="td2_div2_agree";
		}else if(operation==6){
			//入库
			 class11="td2_div11_pass";
			 class12="td2_div12_pass";
			 class13="td2_div13_pass";
			 class14="td2_div14_pass";
			 class15="td2_div15_pass";
			 img1="pass.png";
			 img2="pass.png";
			 img3="pass.png";
			 img4="pass.png";
			 img5="pass.png";
			 time1=dft.format(op.getCreate_time()).replace("*", "<br/>");
			 time2=dft.format(lastFlowTime(2, flowList)).replace("*", "<br/>");
			 time3=dft.format(lastFlowTime(4, flowList)).replace("*", "<br/>");
			 time4=dft.format(lastFlowTime(5, flowList)).replace("*", "<br/>");
			 time5=dft.format(lastFlowTime(6, flowList)).replace("*", "<br/>");
			 class22="td2_div2_agree";
			 class235="td2_div2_agree_c";
			 class245="td2_div2_agree_c";
			 class26="td2_div2_agree";
			 class28="td2_div2_agree";
		}
		map.put("class11", class11);
		map.put("class12", class12);
		map.put("class13", class13);
		map.put("class14", class14);
		map.put("class15", class15);
		
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
		
		map.put("class22", class22);
		map.put("class235", class235);
		map.put("class245", class245);
		map.put("class26", class26);
		map.put("class28", class28);
		return map;
	}
	public List<Outsource_product> getOutsourceByUID(User user) {
		// TODO Auto-generated method stub
		List<Outsource_product> out_pList=outsource_productDAO.getRunningOutsource_product();//查询未完成的外协生产流程
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		SimpleDateFormat sdf2=new SimpleDateFormat("yyyy年MM月dd日");
		String[] flowArray4=DataUtil.getFlowArray(4);
		Iterator<Outsource_product> iterator=out_pList.iterator();
		while (iterator.hasNext()) {
			Outsource_product outsource_product = (Outsource_product) iterator.next();
			User userByID = userDAO.getUserByID(outsource_product.getCreate_id());
			if(userByID==null || userByID.getPosition_id()==56){
				iterator.remove();
				continue;
			}
			Flow flow=flowDAO.getNewFlowByFID(4, outsource_product.getId());//查询最新流程
			if(flow!=null&&checkMyOperation(flow.getOperation(),user,outsource_product)){
				String process=sdf.format(flow.getCreate_time())+flowArray4[flow.getOperation()];
				outsource_product.setProcess(process);
				outsource_product.setName(DataUtil.getNameByTime(4, outsource_product.getCreate_time()));
				outsource_product.setCreate_name(userByID.getTruename());
			}else{
				iterator.remove();
			}
		}
		return out_pList;
	}
	public boolean checkMyOperation(int operation,User user,Outsource_product outsource_product){
		boolean flag=false;
		int position_id=user.getPosition_id();
		switch (operation) {
		case 1:
			flag=permissionsDAO.checkPermission(position_id, 23);
			break;
		case 2:
			flag=permissionsDAO.checkPermission(position_id, 21);
			break;
		case 3:
			flag=permissionsDAO.checkPermission(position_id, 22);
			break;
		case 4:
			flag=permissionsDAO.checkPermission(position_id, 22);
			break;
		case 5:
			flag=permissionsDAO.checkPermission(position_id, 23);
			break;
		default:
			break;
		}
		
		return flag;
	}
}
