package com.zzqa.service.impl.equipment;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.circuit_card.ICircuit_cardDAO;
import com.zzqa.dao.interfaces.equipment.IEquipmentDAO;
import com.zzqa.dao.interfaces.equipment_template.IEquipment_templateDAO;
import com.zzqa.dao.interfaces.file_path.IFile_pathDAO;
import com.zzqa.dao.interfaces.flow.IFlowDAO;
import com.zzqa.dao.interfaces.shipments.IShipmentsDAO;
import com.zzqa.dao.interfaces.task.ITaskDAO;
import com.zzqa.pojo.circuit_card.Circuit_card;
import com.zzqa.pojo.equipment.Equipment;
import com.zzqa.pojo.equipment_template.Equipment_template;
import com.zzqa.pojo.file_path.File_path;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.shipments.Shipments;
import com.zzqa.pojo.task.Task;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.equipment.EquipmentManager;
import com.zzqa.util.DataUtil;
@Component("equipmentManager")
public class EquipmentManagerImpl implements EquipmentManager {
	@Autowired
	private IEquipment_templateDAO equipment_templateDAO;
	@Autowired
	private IEquipmentDAO equipmentDAO;
	@Autowired
	private ICircuit_cardDAO circuit_cardDAO;
	@Autowired
	private IFile_pathDAO file_pathDAO;
	@Autowired
	private IShipmentsDAO shipmentsDAO;
	@Autowired
	private ITaskDAO taskDAO;
	@Autowired
	private IFlowDAO flowDAO;
	@Override
	public void insertEquipment_template(Equipment_template equipment_template) {
		// TODO Auto-generated method stub
		List<Circuit_card> circuit_cards=equipment_template.getCircuit_cards();
		if(circuit_cards!=null){
			equipment_templateDAO.insertEquipment_template(equipment_template);
			int device_id=equipment_template.getId();
			for (Circuit_card circuit_card : circuit_cards) {
				circuit_card.setType(1);
				circuit_card.setDevice_id(device_id);
				circuit_cardDAO.insertCircuit_card(circuit_card);
			}
		}
	}
	@Override
	public void updateEquipment_template(Equipment_template equipment_template){
		List<Circuit_card> circuit_cards=equipment_template.getCircuit_cards();
		if(circuit_cards!=null){
			equipment_templateDAO.delEquipment_templateByID(equipment_template.getId());//方便排序，每次修改都删除原来的
			circuit_cardDAO.delCircuit_cardByTempID(equipment_template.getId());
			equipment_templateDAO.insertEquipment_template(equipment_template);
			int device_id=equipment_template.getId();
			for (Circuit_card circuit_card : circuit_cards) {
				circuit_card.setType(1);
				circuit_card.setDevice_id(device_id);
				circuit_cardDAO.insertCircuit_card(circuit_card);
			}
		}
	}
	@Override
	public void delEquipment_templateByID(int id) {
		// TODO Auto-generated method stub
		circuit_cardDAO.delCircuit_cardByTempID(id);
		equipment_templateDAO.delEquipment_templateByID(id);
	}
	@Override
	public Equipment_template getEquipment_templateByID(int id) {
		// TODO Auto-generated method stub
		return equipment_templateDAO.getEquipment_templateByID(id);
	}
	@Override
	public List getAllEquipment_template() {
		// TODO Auto-generated method stub
		List<Equipment_template> equipment_templates=equipment_templateDAO.getAllEquipment_template();
		for (Equipment_template equipment_template : equipment_templates) {
			equipment_template.setCircuit_cards(circuit_cardDAO.getCircuit_cardListFromTemp(equipment_template.getId()));
		}
		return equipment_templates;
	}
	@Override
	public void insertEquipment(Equipment equipment) {
		// TODO Auto-generated method stub
		List<Circuit_card> circuit_cards=equipment.getCircuit_cards();
		if(circuit_cards!=null){
			equipmentDAO.insertEquipment(equipment);
			int device_id=equipment.getId();
			for (Circuit_card circuit_card : circuit_cards) {
				circuit_card.setType(0);
				circuit_card.setDevice_id(device_id);
				circuit_cardDAO.insertCircuit_card(circuit_card);
			}
		}
	}
	@Override
	public void updateEquipment(Equipment equipment) {
		// TODO Auto-generated method stub
		List<Circuit_card> circuit_cards=equipment.getCircuit_cards();
		if(circuit_cards!=null){
			circuit_cardDAO.delCircuit_cardByDeviceID(equipment.getId());
			int device_id=equipment.getId();
			for (Circuit_card circuit_card : circuit_cards) {
				circuit_card.setType(0);
				circuit_card.setDevice_id(device_id);
				circuit_cardDAO.insertCircuit_card(circuit_card);
			}
			equipmentDAO.updateEquipment(equipment);
		}
	}
	@Override
	public void delEquipmentByID(int id) {
		// TODO Auto-generated method stub
		circuit_cardDAO.delCircuit_cardByDeviceID(id);
		Map map=new HashMap();
		map.put("type", 5);
		map.put("foreign_id", id);
		file_pathDAO.delAllFileByCondition(map);
		equipmentDAO.delEquipmentByID(id);
	}
	@Override
	public Equipment getEquipmentByID(int id) {
		// TODO Auto-generated method stub
		Equipment equipment=equipmentDAO.getEquipmentByID(id);
		if(equipment!=null){
			equipment.setFile_path(file_pathDAO.getNewFileByFID(equipment.getId()));
			equipment.setCircuit_cards(circuit_cardDAO.getCircuit_cardListFromDevice(equipment.getId()));
			equipment.setUpdate_date(new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(equipment.getUpdate_time()));
		}
		return equipment;
	}
	@Override
	public List getAllEquipment() {
		// TODO Auto-generated method stub
		return equipmentDAO.getAllEquipment();
	}
	@Override
	public List getEquipmentByCreateID(int create_id){
		List<Equipment> equipments=equipmentDAO.getEquipmentByCreateID(create_id);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		for (Equipment equipment : equipments) {
			List<Circuit_card> circuit_cards=circuit_cardDAO.getCircuit_cardListFromDevice(equipment.getId());
			equipment.setCircuit_cards(circuit_cards);
			equipment.setFile_path(file_pathDAO.getNewFileByFID(equipment.getId()));
			equipment.setUpdate_date((equipment.getUpdate_time()==0?"":sdf.format(equipment.getUpdate_time())));
		}
		return equipments;
	}
	public List getFreedomEquipmentList(){
		List<Equipment> equipments=equipmentDAO.getFreedomEquipmentList();
		return equipments;
	}
	@Override
	public List<Equipment> getEquipmentByCondition(String keywords_device,String state_device,
			int newtime_device,long starttime_device,long endtime_device,int isCreater,User user){
		Map<String,Object> map=new HashMap<String,Object>();
		map.put("usetime", newtime_device);
		map.put("starttime", starttime_device);
		map.put("endtime", endtime_device);
		map.put("isCreater", isCreater);
		map.put("create_id", user.getId());
		List<Equipment> equipments=equipmentDAO.getEquipmentByCondition(map);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd*HH:mm:ss");
		int uid=user.getId();
		int position_id=user.getPosition_id();
		Iterator<Equipment> iterator=equipments.iterator();
		while (iterator.hasNext()) {
			Equipment equipment = (Equipment) iterator.next();
			//var stateArray = ["入库","出库","发货","到货"];
			int state=0;
			if(equipment.getShip_id()!=0){
				Shipments shipments=shipmentsDAO.getShipmentsByID(equipment.getShip_id());
				if(shipments==null){
					iterator.remove();
					continue;
				}
				Task task=taskDAO.getTask2ByID(shipments.getTask_id());
				if(task==null){
					iterator.remove();
					continue;
				}
				equipment.setProject_id(task.getProject_id());
				equipment.setProject_name(task.getProject_name());
				equipment.setAddress(shipments.getAddress()!=null?shipments.getAddress():"");
				Flow flow=new Flow();
				flow.setOperation(4);
				flow.setForeign_id(shipments.getId());
				flow.setType(6);
				long ship_time=flowDAO.getFlowTimeByFlow(flow);
				equipment.setShip_date(ship_time==0?"":sdf.format(ship_time).replace("*", "<br/>"));
				flow.setOperation(5);
				flow.setForeign_id(shipments.getId());
				flow.setType(6);
				long aog_time=flowDAO.getFlowTimeByFlow(flow);
				equipment.setAog_date(aog_time==0?"":sdf.format(shipments.getAog_time()).replace("*", "<br/>"));
				flow=flowDAO.getNewFlowByFID(6, shipments.getId());
				if(flow==null){
					iterator.remove();
					continue;
				}
				int operation=flow.getOperation();
				if((operation>1&&operation<4)||operation==7){
					state=1;
				}else if(operation==4){
					state=2;
				}else if(operation>4){
					state=3;
				}
				equipment.setState(state);
			}else{
				equipment.setProject_id("");
				equipment.setProject_name("");
				equipment.setAog_date("");
				equipment.setShip_date("");
				equipment.setAddress("");
			}
			if(state_device.charAt(equipment.getState())!='1'){
				iterator.remove();
				continue;
			}
			boolean finished=false;//false:删除,不满足条件
			List<Circuit_card> circuit_cards=circuit_cardDAO.getCircuit_cardListFromDevice(equipment.getId());
			equipment.setCircuit_cards(circuit_cards);
			for (Circuit_card circuit_card : circuit_cards) {
				if(circuit_card.getName().contains(keywords_device)||circuit_card.getSn().contains(keywords_device)){
					finished=true;
				}
			}
			File_path file_path=file_pathDAO.getNewFileByFID(equipment.getId());
			equipment.setFile_path(file_path);
			if(finished||equipment.getIdStr().contains(keywords_device)||equipment.getSn().contains(keywords_device)||equipment.getProject_id().contains(keywords_device)
					||equipment.getProject_name().contains(keywords_device)||equipment.getAddress().contains(keywords_device)){
				
			}else{
				iterator.remove();
				continue;
			}
			equipment.setUpdate_date(sdf.format(equipment.getUpdate_time()).replace("*", "<br/>"));
		}
		return equipments;
	}
	@Override
	public Equipment_template getTempByAlias(String alias) {
		// TODO Auto-generated method stub
		return equipment_templateDAO.getTempByAlias(alias);
	}
	@Override
	public void updateEquipmentShipID(int deviceID, int ship_id) {
		// TODO Auto-generated method stub
		Map map=new HashMap();
		map.put("id", deviceID);
		map.put("ship_id", ship_id);
		equipmentDAO.updateEquipmentShipID(map);
	}
}
