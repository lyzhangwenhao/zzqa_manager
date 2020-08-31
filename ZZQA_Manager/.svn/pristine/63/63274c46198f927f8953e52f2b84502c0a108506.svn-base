package com.zzqa.service.impl.device;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.device.IDeviceDAO;
import com.zzqa.dao.interfaces.file_path.IFile_pathDAO;
import com.zzqa.dao.interfaces.flow.IFlowDAO;
import com.zzqa.dao.interfaces.manufacture.IManufactureDAO;
import com.zzqa.dao.interfaces.material.IMaterialDAO;
import com.zzqa.dao.interfaces.position_user.IPosition_userDAO;
import com.zzqa.dao.interfaces.shipments.IShipmentsDAO;
import com.zzqa.dao.interfaces.task.ITaskDAO;
import com.zzqa.pojo.device.Device;
import com.zzqa.pojo.equipment.Equipment;
import com.zzqa.pojo.file_path.File_path;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.manufacture.Manufacture;
import com.zzqa.pojo.material.Material;
import com.zzqa.pojo.shipments.Shipments;
import com.zzqa.pojo.task.Task;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.device.DeviceManager;
import com.zzqa.util.DataUtil;
@Component("deviceManager")
public class DeviceManagerImpl implements DeviceManager {
	@Resource(name="deviceDAO")
	private IDeviceDAO deviceDAO;
	@Resource(name="file_pathDAO")
	private IFile_pathDAO file_pathDAO;
	@Resource(name="manufactureDAO")
	private IManufactureDAO manufactureDAO;
	@Resource(name="materialDAO")
	private IMaterialDAO materialDAO;
	@Resource(name="shipmentsDAO")
	private IShipmentsDAO shipmentsDAO;
	@Resource(name="taskDAO")
	private ITaskDAO taskDAO;
	@Resource(name="flowDAO")
	private IFlowDAO flowDAO;
	@Resource(name="position_userDAO")
	private IPosition_userDAO position_userDAO;

	public void delDeviceByDeviceID(int m_id) {
		// TODO Auto-generated method stub
		deviceDAO.delDeviceByDeviceID(m_id);
	}

	public void delDeviceByID(int id) {
		// TODO Auto-generated method stub
		deviceDAO.delDeviceByID(id);
	}

	public Device getDeviceByID(int id) {
		// TODO Auto-generated method stub
		Device device=deviceDAO.getDeviceByID(id);
		if(device==null){
			return device;
		}
		File_path file_path=file_pathDAO.getNewFileByFID(id);
		device.setIdStr(DataUtil.TransformDID(id));
		if(file_path!=null){
			device.setFile_path(file_path);
		}
		return device;
	}

	public List getDeviceList(int m_id) {
		// TODO Auto-generated method stub
		List<Device> list=deviceDAO.getDeviceList(m_id);
		for(Device device:list){
			File_path file_path=file_pathDAO.getNewFileByFID(device.getId());
			device.setFile_path(file_path);
			device.setIdStr(DataUtil.TransformDID(device.getId()));
		}
		return list;
	}

	public void insertDevice(Device device) {
		// TODO Auto-generated method stub
		deviceDAO.insertDevice(device);
	}

	public void updateDevice(Device device) {
		// TODO Auto-generated method stub
		deviceDAO.updateDevice(device);
	}

	public int getNewDeviceByUpID(int update_id) {
		// TODO Auto-generated method stub
		return deviceDAO.getNewDeviceByUpID(update_id);
	}

	public List getFreedomDeviceList() {
		// TODO Auto-generated method stub
		List<Device> list=deviceDAO.getFreedomDeviceList();
		for(Device device:list){
			device.setIdStr(DataUtil.TransformDID(device.getId()));
		}
		return list;
	}

	public void updateDeviceOnShip(Device device) {
		// TODO Auto-generated method stub
		deviceDAO.updateDeviceOnShip(device);
	}
	public List getDeviceListByShipID(int ship_id){
		List<Device> deviceList=deviceDAO.getDeviceListByShipID(ship_id);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for(Device device:deviceList){
			device.setFile_path(file_pathDAO.getNewFileByFID(device.getId()));
			device.setMaterList(materialDAO.getMaterialList(device.getId()));
			device.setCreate_date(sdf.format(device.getUpdate_time()));
			device.setIdStr(DataUtil.TransformDID(device.getId()));
		}
		return deviceList;
	}

	@Override
	public List<Device> getDeviceListByCondition(String keywords_device,int material_device, String sn1_device,
			String sn2_device, String sn3_device, String sn4_device,
			String sn5_device, String sn6_device, int isFileExist,
			String state_device, int isQualify, int newtime_device,
			String starttime_device, String endtime_device, User user) {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String,Object>();
		SimpleDateFormat sdf1=new SimpleDateFormat("yyyy-MM-dd");
		map.put("isQualify", isQualify);
		map.put("isFileExist", isFileExist);
		long starttime=0l;
		long endtime=0l;
		String[] stateArray=state_device.split("-");
		try {
			if(newtime_device!=0){
				starttime=sdf1.parse(starttime_device).getTime();
				endtime=sdf1.parse(endtime_device).getTime()+24*3600*1000;//结束时间包括当天
			}
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ArrayList<Device>();
		}
		map.put("starttime", starttime);
		map.put("endtime", endtime);
		List<Device> deviceList=deviceDAO.getDeviceListByCondition(map);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd*HH:mm:ss");
		int uid=user.getId();
		int position_id=user.getPosition_id();
		Iterator<Device> iterator=deviceList.iterator();
		while (iterator.hasNext()) {
			Device device = (Device) iterator.next();
			device.setFile_path(file_pathDAO.getNewFileByFID(device.getId()));
			device.setMaterList(materialDAO.getMaterialList(device.getId()));
			device.setCreate_date(sdf.format(device.getUpdate_time()).replace("*", "<br/>"));
			Flow flow1=new Flow();
			flow1.setOperation(4);
			flow1.setForeign_id(device.getM_id());
			flow1.setType(5);
			long putintime=flowDAO.getFlowTimeByFlow(flow1);
			device.setPutin_date(putintime==0?"":sdf.format(putintime).replace("*", "<br/>"));
			int state=1;
			Flow flow2=flowDAO.getNewFlowByFID(5, device.getM_id());
			if(flow2==null){
				iterator.remove();
				continue;
			}
			int opera=flow2.getOperation();
			if(opera==3){
				state=2;
			}else if(opera==4){
				state=3;
			}
			if(device.getShip_id()!=0){
				Shipments shipments=shipmentsDAO.getShipmentsByID(device.getShip_id());
				Task task=taskDAO.getTask2ByID(shipments.getTask_id());
				if(task==null){
					iterator.remove();
					continue;
				}
				device.setProject_id(task.getProject_id());
				device.setProject_name(task.getProject_name());
				device.setAddress(shipments.getAddress()!=null?shipments.getAddress():"");
				Flow flow=new Flow();
				flow.setOperation(4);
				flow.setForeign_id(shipments.getId());
				flow.setType(6);
				long ship_time=flowDAO.getFlowTimeByFlow(flow);
				device.setShip_date(ship_time==0?"":sdf.format(ship_time).replace("*", "<br/>"));
				flow.setOperation(5);
				flow.setForeign_id(shipments.getId());
				flow.setType(6);
				long aog_time=flowDAO.getFlowTimeByFlow(flow);
				device.setAog_date(aog_time==0?"":sdf.format(shipments.getAog_time()).replace("*", "<br/>"));
				int operation=flowDAO.getNewFlowByFID(6, shipments.getId()).getOperation();
				if(operation>1&&operation<4){
					state=4;
				}else if(operation==4){
					state=5;
				}else if(operation>4){
					state=6;
				}
			}else{
				device.setProject_id("");
				device.setProject_name("");
				device.setAog_date("");
				device.setShip_date("");
				device.setAddress("");
			}
			device.setIdStr(DataUtil.TransformDID(device.getId()));
			device.setState(state);
			if(device.getIdStr().contains(keywords_device)||device.getSn().contains(keywords_device)||device.getProject_id().contains(keywords_device)
					||device.getProject_name().contains(keywords_device)||device.getAddress().contains(keywords_device)){
				if("1".equals(stateArray[device.getState()-1])){
					if(material_device==1){

						List<Material> materialList=device.getMaterList();
						if(materialList.get(0).getSn().contains(sn1_device)
								&&materialList.get(1).getSn().contains(sn2_device)
								&&materialList.get(2).getSn().contains(sn3_device)
								&&materialList.get(3).getSn().contains(sn4_device)
								&&materialList.get(4).getSn().contains(sn5_device)){
							//为保证试运行的.2数据库不删档，兼容之前的5个版子
							if(materialList.size()>5){
								if(!materialList.get(5).getSn().contains(sn6_device)){
									iterator.remove();
									continue;
								}
							}else{
								//只有5个版子时，自动过滤6号版子搜索条件
								if(sn6_device.length()!=0){
									iterator.remove();
									continue;
								}
							}
						}else{
							iterator.remove();
							continue;
						}
					
					}
				}else{
					iterator.remove();
					continue;
				}
			}else{
				iterator.remove();
				continue;
			}
		}
		return deviceList;
	}

}
