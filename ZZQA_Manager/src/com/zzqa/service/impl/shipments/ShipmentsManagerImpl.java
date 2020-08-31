package com.zzqa.service.impl.shipments;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.circuit_card.ICircuit_cardDAO;
import com.zzqa.dao.interfaces.equipment.IEquipmentDAO;
import com.zzqa.dao.interfaces.file_path.IFile_pathDAO;
import com.zzqa.dao.interfaces.flow.IFlowDAO;
import com.zzqa.dao.interfaces.permissions.IPermissionsDAO;
import com.zzqa.dao.interfaces.position_user.IPosition_userDAO;
import com.zzqa.dao.interfaces.shipments.IShipmentsDAO;
import com.zzqa.dao.interfaces.task.ITaskDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.pojo.equipment.Equipment;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.manufacture.Manufacture;
import com.zzqa.pojo.outsource_product.Outsource_product;
import com.zzqa.pojo.position_user.Position_user;
import com.zzqa.pojo.project_procurement.Project_procurement;
import com.zzqa.pojo.shipments.Shipments;
import com.zzqa.pojo.task.Task;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.shipments.ShipmentsManager;
import com.zzqa.servlet.DelayEmailServlet;
import com.zzqa.util.DataUtil;
@Component("shipmentsManager")
public class ShipmentsManagerImpl implements ShipmentsManager {
	@Resource(name="shipmentsDAO")
	private IShipmentsDAO shipmentsDAO;
	@Resource(name="flowDAO")
	private IFlowDAO flowDAO;
	@Resource(name="position_userDAO")
	private IPosition_userDAO position_userDAO;
	@Resource(name="taskDAO")
	private ITaskDAO taskDAO;
	@Resource(name="userDAO")
	private IUserDAO userDAO;
	@Resource(name="permissionsDAO")
	private IPermissionsDAO permissionsDAO;
	@Resource(name="equipmentDAO")
	private IEquipmentDAO equipmentDAO;
	@Resource(name="circuit_cardDAO")
	private ICircuit_cardDAO circuit_cardDAO;
	@Resource(name="file_pathDAO")
	private IFile_pathDAO file_pathDAO;

	public void delShipmentsByID(int id) {
		// TODO Auto-generated method stub
		shipmentsDAO.delShipmentsByID(id);
	}

	public Shipments getShipmentsByID(int id) {
		// TODO Auto-generated method stub
		Shipments shipments=shipmentsDAO.getShipmentsByID(id);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		shipments.setAog_date(shipments.getAog_time()==0?"":sdf.format(shipments.getAog_time()));
		Flow flow=new Flow();
		flow.setOperation(4);
		flow.setForeign_id(shipments.getId());
		flow.setType(6);
		long ship_time=flowDAO.getFlowTimeByFlow(flow);
		shipments.setShip_date(ship_time==0?"":sdf.format(ship_time));
		shipments.setCreate_name(userDAO.getUserNameByID(shipments.getCreate_id()));
		return shipments;
	}
	
	public Shipments getShipmentsByID2(int id) {
		// TODO Auto-generated method stub
		Shipments shipments=shipmentsDAO.getShipmentsByID(id);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		Flow flow=flowDAO.getNewFlowByFID(6, id);//查询最新流程
		String process=sdf.format(flow.getCreate_time())+DataUtil.getFlowArray(6)[flow.getOperation()];
		shipments.setName("发货单-"+taskDAO.getTask2ByID(shipments.getTask_id()).getProject_name());
		shipments.setProcess(process);
		shipments.setCreate_name(userDAO.getUserNameByID(shipments.getCreate_id()));
		return shipments;
	}
	public Shipments getShipmentsDetailByID(int id) {
		Shipments shipments=shipmentsDAO.getShipmentsByID(id);
		if(shipments!=null){
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			shipments.setAog_date(shipments.getAog_time()==0?"":sdf.format(shipments.getAog_time()));
			Flow flow=new Flow();
			flow.setOperation(4);
			flow.setForeign_id(shipments.getId());
			flow.setType(6);
			long ship_time=flowDAO.getFlowTimeByFlow(flow);
			shipments.setShip_date(ship_time==0?"":sdf.format(ship_time));
			shipments.setCreate_name(userDAO.getUserNameByID(shipments.getCreate_id()));
			List<Equipment> equipments=equipmentDAO.getEquipmentByShipID(id);
			if(equipments!=null){
				SimpleDateFormat sdf_eq=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				for (Equipment equipment : equipments) {
					equipment.setCircuit_cards(circuit_cardDAO.getCircuit_cardListFromDevice(equipment.getId()));
					equipment.setUpdate_date(sdf_eq.format(equipment.getUpdate_time()));
					equipment.setFile_path(file_pathDAO.getNewFileByFID(equipment.getId()));
				}
			}
			shipments.setEquipments(equipments);
		}
		return shipments;
	}
	public List getShipmentsList(int beginrow, int rows) {
		// TODO Auto-generated method stub
		Map map=new HashMap();
		map.put("beginrow", beginrow);
		map.put("rows", rows);
		List<Shipments> shipList=shipmentsDAO.getShipmentsList(map);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		/*for(Shipments ship:shipList){
			Flow flow=flowDAO.getNewFlowByFID(6, ship.getId());//查询最新流程
			String process=sdf.format(ship.getCreate_time())+" "+DataUtil.getFlowArray6()[flow.getOperation()];
			ship.setName("发货单-"+taskDAO.getTask2ByID(ship.getTask_id()).getProject_name());
			ship.setProcess(process);
		}*/
		return shipList;
	}

	public void insertshipments(Shipments shipments) {
		// TODO Auto-generated method stub
		shipmentsDAO.insertshipments(shipments);
	}

	public void updateShipments(Shipments shipments) {
		// TODO Auto-generated method stub
		shipmentsDAO.updateShipments(shipments);
	}
	public int getNewShipmentsByUID(int uid){
		return shipmentsDAO.getNewShipmentsByUID(uid);
	}

	public List<Shipments> getShipmentsListByUID(User user) {
		// TODO Auto-generated method stub
		List<Shipments> shipList=shipmentsDAO.getRunningShipments();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		String[] flowArray6=DataUtil.getFlowArray(6);
		Iterator<Shipments> iterator=shipList.iterator();
		while (iterator.hasNext()) {
			Shipments shipments = (Shipments) iterator.next();
			User userByID = userDAO.getUserByID(shipments.getCreate_id());
			if(userByID==null || userByID.getPosition_id()==56){
				iterator.remove();
				continue;
			}
			Flow flow=flowDAO.getNewFlowByFID(6, shipments.getId());//查询最新流程
			Task task=taskDAO.getTask2ByID(shipments.getTask_id());
			if(flow!=null&&checkMyOperation(flow.getOperation(),user,shipments)&&task!=null){
				String process=sdf.format(flow.getCreate_time())+flowArray6[flow.getOperation()];
				shipments.setName(DataUtil.getFlowNameArray()[6]+"-"+task.getProject_name());
				shipments.setProcess(process);
				shipments.setCreate_name(userByID.getTruename());
			}else{
				iterator.remove();
			}
		}
		return shipList;
	}
	public boolean checkMyOperation(int operation,User user,Shipments shipments){
		boolean flag=false;
		int position_id=user.getPosition_id();
		switch (operation) {
		case 1:
			flag=permissionsDAO.checkPermission(position_id, 23);
			break;
		case 2:
			flag=permissionsDAO.checkPermission(position_id, 154);
			break;
		case 7:
			flag=user.getId()==shipments.getCreate_id();
			break;
		case 3:
			flag=permissionsDAO.checkPermission(position_id, 27);
			break;
		case 4:
			flag=permissionsDAO.checkPermission(user.getPosition_id(), 27);//由发货人填写
			break;
		case 5:
			flag=permissionsDAO.checkPermission(user.getPosition_id(), 27);//由发货人填写回执单
			break;
		default:
			break;
		}
		return flag;
	}

	public Map<String, String> getShipFlowForDraw(Shipments ship,Flow flow) {
		// TODO Auto-generated method stub
		int operation=flow.getOperation();
		Map<String, String> map=new HashMap<String, String>();
		List<Flow> flowList=flowDAO.getFlowListByCondition(6,ship.getId());
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
		String class24="";
		String class255="";
		String class256="";
		String class26="";
		if(operation==1){
			class11="td2_div11_nodid";
			class12="td2_div12_nodid";
			class13="td2_div13_nodid";
			class14="td2_div14_nodid";
			class15="td2_div15_nodid";
			img1="go.png";
			img2="notdid.png";
			img3="notdid.png";
			img4="notdid.png";
			img5="notdid.png";
			time1="";
			time2="";
			time3="";
			time4="";
			time5="";
			class22="td2_div2_nodid";
			class24="td2_div2_nodid";
			class255="td2_div2_nodid_c";
			class256="td2_div2_nodid_c";
			class26="td2_div2_nodid";
		}else if(operation==2||operation==7){
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
			time1=dft.format(ship.getCreate_time()).replace("*", "<br/>");
			time2="";
			time3="";
			time4="";
			time5="";
			class22="td2_div2_agree";
			class24="td2_div2_nodid";
			class255="td2_div2_nodid_c";
			class256="td2_div2_nodid_c";
			class26="td2_div2_nodid";
		}else if(operation==3){
			class11="td2_div11_pass";
			class12="td2_div12_pass";
			class13="td2_div13_nodid";
			class14="td2_div14_nodid";
			class15="td2_div15_nodid";
			img1="pass.png";
			img2="pass.png";
			img3="go.png";
			img4="notdid.png";
			img5="notdid.png";
			time1=dft.format(ship.getCreate_time()).replace("*", "<br/>");
			time2=dft.format(lastFlowTime(3,flowList)).replace("*", "<br/>");
			time3="";
			time4="";
			time5="";
			class22="td2_div2_agree";
			class24="td2_div2_agree";
			class255="td2_div2_nodid_c";
			class256="td2_div2_nodid_c";
			class26="td2_div2_nodid";
		}else if(operation==4){
			class11="td2_div11_pass";
			class12="td2_div12_pass";
			class13="td2_div13_pass";
			class14="td2_div14_nodid";
			class15="td2_div15_nodid";
			img1="pass.png";
			img2="pass.png";
			img3="pass.png";
			img4="notdid.png";
			img5="notdid.png";
			time1=dft.format(ship.getCreate_time()).replace("*", "<br/>");
			time2=dft.format(lastFlowTime(3,flowList)).replace("*", "<br/>");
			time3=dft.format(lastFlowTime(4,flowList)).replace("*", "<br/>");
			time4="";
			time5="";
			class22="td2_div2_agree";
			class24="td2_div2_agree";
			class255="td2_div2_agree_c";
			class256="td2_div2_nodid_c";
			class26="td2_div2_nodid";
		}else if(operation==5){
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
			time1=dft.format(ship.getCreate_time()).replace("*", "<br/>");
			time2=dft.format(lastFlowTime(3,flowList)).replace("*", "<br/>");
			time3=dft.format(lastFlowTime(4,flowList)).replace("*", "<br/>");
			time4=dft.format(lastFlowTime(5,flowList)).replace("*", "<br/>");
			time5="";
			class22="td2_div2_agree";
			class24="td2_div2_agree";
			class255="td2_div2_agree_c";
			class256="td2_div2_agree_c";
			class26="td2_div2_agree";
		}else if(operation==6){
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
			time1=dft.format(ship.getCreate_time()).replace("*", "<br/>");
			time2=dft.format(lastFlowTime(3,flowList)).replace("*", "<br/>");
			time3=dft.format(lastFlowTime(4,flowList)).replace("*", "<br/>");
			time4=dft.format(lastFlowTime(5,flowList)).replace("*", "<br/>");
			time5=dft.format(lastFlowTime(6,flowList)).replace("*", "<br/>");
			class22="td2_div2_agree";
			class24="td2_div2_agree";
			class255="td2_div2_agree_c";
			class256="td2_div2_agree_c";
			class26="td2_div2_agree";
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
		map.put("class24", class24);
		map.put("class255", class255);
		map.put("class256", class256);
		map.put("class26", class26);
		return map;
	}
	public long lastFlowTime(int operation,List<Flow> flowList){
		Flow flow=null;
		int len=flowList.size();
		for (int i = 0; i < len; i++) {
			if(flowList.get(len-i-1).getOperation()==operation){
				return flowList.get(len-i-1).getCreate_time();
			}
		}
		return 0;
	}
}
