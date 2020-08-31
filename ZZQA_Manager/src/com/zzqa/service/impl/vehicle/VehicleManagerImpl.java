package com.zzqa.service.impl.vehicle;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.flow.IFlowDAO;
import com.zzqa.dao.interfaces.permissions.IPermissionsDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.dao.interfaces.vehicle.IVehicleDAO;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.user.User;
import com.zzqa.pojo.vehicle.Vehicle;
import com.zzqa.service.interfaces.vehicle.VehicleManager;
import com.zzqa.util.DataUtil;
@Component("vehicleManager")
public class VehicleManagerImpl implements VehicleManager {
	@Autowired
	private IVehicleDAO vehicleDAO;
	@Autowired
	private IUserDAO userDAO;
	@Autowired
	private IFlowDAO flowDAO;
	@Autowired
	private IPermissionsDAO permissionsDAO;
	
	@Override
	public int insertVehicle(Vehicle vehicle) {
		// TODO Auto-generated method stub
		vehicleDAO.insertVehicle(vehicle);
		return vehicleDAO.getNewVehicleIDByCreateID(vehicle.getCreate_id());
	}

	@Override
	public void updateVehicle(Vehicle vehicle) {
		// TODO Auto-generated method stub
		vehicleDAO.updateVehicle(vehicle);
	}

	@Override
	public Vehicle getVehicleByID(int id) {
		// TODO Auto-generated method stub
		Vehicle vehicle=vehicleDAO.getVehicleByID(id);
		if(vehicle!=null){
			vehicle.setCreate_name(userDAO.getUserNameByID(vehicle.getCreate_id()));
			vehicle.setApprove_name(userDAO.getUserNameByID(vehicle.getApprover()));
			vehicle.setExecutor_name(userDAO.getUserNameByID(vehicle.getExecutor()));
		}
		return vehicle;
	}

	@Override
	public Vehicle getVehicleByID2(int id) {
		// TODO Auto-generated method stub
		Vehicle vehicle=vehicleDAO.getVehicleByID(id);
		if(vehicle!=null){
			SimpleDateFormat format = new SimpleDateFormat( "yyyy.MM.dd" );
			Flow flow=flowDAO.getNewFlowByFID(15, vehicle.getId());
			String process=format.format(flow.getCreate_time())+DataUtil.getFlowArray(15)[flow.getOperation()];
			vehicle.setName(DataUtil.getNameByTime(15,vehicle.getCreate_time()));
			vehicle.setProcess(process);
			vehicle.setCreate_name(userDAO.getUserNameByID(vehicle.getCreate_id()));
		}
		return vehicle;
	}

	@Override
	public List<Vehicle> getVehicleByUID(User user) {
		// TODO Auto-generated method stub
		List<Vehicle> vehicleList=vehicleDAO.getRunningVehicle();
		if(vehicleList!=null&&vehicleList.size()>0){
			SimpleDateFormat format = new SimpleDateFormat( "yyyy.MM.dd" );
			String[] flowArray=DataUtil.getFlowArray(15);
			Iterator<Vehicle> iterator=vehicleList.iterator();
			while (iterator.hasNext()) {
				Vehicle vehicle=(Vehicle)iterator.next();
				User userByID = userDAO.getUserByID(vehicle.getCreate_id());
				if(userByID==null || userByID.getPosition_id()==56){
					iterator.remove();
					continue;
				}
				Flow flow=flowDAO.getNewFlowByFID(15, vehicle.getId());//查询最新流程
				if(flow!=null&&checkMyOperation(flow.getOperation(),user,vehicle)){
					String process=format.format(flow.getCreate_time())+flowArray[flow.getOperation()];
					vehicle.setProcess(process);
					vehicle.setName(DataUtil.getNameByTime(15,vehicle.getCreate_time()));
					vehicle.setCreate_name(userByID.getTruename());
				}else{
					iterator.remove();
				}
			}
		}
		return vehicleList;
	}
	private boolean checkMyOperation(int operation,User user,Vehicle vehicle){
		boolean flag=false;
		int position_id=user.getPosition_id();
 		switch (operation) {
		case 1:
			flag=permissionsDAO.checkPermission(position_id, 82);
			break;
		case 2:
			flag=user.getId()==vehicle.getCreate_id();
			break;
		case 3:
			flag=user.getId()==vehicle.getCreate_id();
			break;
		case 10:
			flag=user.getId()==vehicle.getDriver();
			break;
		case 4:
			flag=permissionsDAO.checkPermission(position_id, 83);
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
	public Map<String, String> getVehicleFlowForDraw(Vehicle vehicle, Flow flow) {
		// TODO Auto-generated method stub
		int operation=flow.getOperation();
		Map<String, String> map=new HashMap<String, String>();
		List<Flow> flowList=flowDAO.getFlowListByCondition(15,vehicle.getId());
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd#HH:mm:ss");
		String title1_flow="title1_flow1";
		String title2_flow="title2_flow1";
		String title3_flow="title3_flow1";
		String color1=null;
		String color2=null;
		String color3=null;
		String color4=null;
		String img1=null;
		String img2=null;
		String img3=null;
		String img4=null;
		String time1=null;
		String time2=null;
		String time3=null;
		String time4=null;
		String bg_color1=null;
		String bg_color2=null;
		String bg_color3=null;
		String bg_color4=null;
		if(operation==1){
			color1="color_did";
			color2="color_nodid";
			color3="color_nodid";
			color4="color_nodid";
			img1="pass.png";
			img2="go.png";
			img3="notdid.png";
			img4="notdid.png";
			bg_color1="background_color_did";
			bg_color2="background_color_nodid";
			bg_color3="background_color_nodid";
			bg_color4="background_color_nodid";
			time1=sdf.format(vehicle.getCreate_time()).replace("#", "<br/>");
		}else if(operation==2 || operation==10){
			color1="color_did";
			color2="color_did";
			color3="color_nodid";
			color4="color_nodid";
			img1="pass.png";
			img2="pass.png";
			img3="notdid.png";
			img4="notdid.png";
			bg_color1="background_color_did";
			bg_color2="background_color_did";
			bg_color3="background_color_nodid";
			bg_color4="background_color_nodid";
			time1=sdf.format(vehicle.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}else if(operation==3){
			color1="color_did";
			color2="color_error";
			color3="color_nodid";
			color4="color_nodid";
			img1="pass.png";
			img2="error.png";
			img3="notdid.png";
			img4="notdid.png";
			bg_color1="background_color_error";
			bg_color2="background_color_nodid";
			bg_color3="background_color_nodid";
			bg_color4="background_color_nodid";
			time1=sdf.format(vehicle.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}else if(operation==4){
			color1="color_did";
			color2="color_did";
			color3="color_nodid";
			color4="color_nodid";
			img1="pass.png";
			img2="pass.png";
			img3="go.png";
			img4="notdid.png";
			bg_color1="background_color_did";
			bg_color2="background_color_did";
			bg_color3="background_color_did";
			bg_color4="background_color_nodid";
			time1=sdf.format(vehicle.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
			if(time2.contains("1970-01-01")){
				time2=sdf.format(lastFlowTime(10, flowList)).replace("#", "<br/>");
			}
		}else if(operation==5){
			color1="color_did";
			color2="color_did";
			color3="color_did";
			color4="color_did";
			img1="pass.png";
			img2="pass.png";
			img3="pass.png";
			img4="pass.png";
			bg_color1="background_color_did";
			bg_color2="background_color_did";
			bg_color3="background_color_did";
			bg_color4="background_color_did";
			time1=sdf.format(vehicle.getCreate_time()).replace("#", "<br/>");
			time2=sdf.format(lastFlowTime(2, flowList)).replace("#", "<br/>");
			if(time2.contains("1970-01-01")){
				time2=sdf.format(lastFlowTime(10, flowList)).replace("#", "<br/>");
			}
			time3=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
			time4=time3;
		}else if(operation==6){
			title1_flow="title1_flow0";
			title2_flow="title2_flow0";
			title3_flow="title3_flow0";
			color1="color_did";
			color4="color_error";
			img1="pass.png";
			img4="error.png";
			bg_color4="background_color_error";
			time1=sdf.format(vehicle.getCreate_time()).replace("#", "<br/>");
			time4=sdf.format(lastFlowTime(operation, flowList)).replace("#", "<br/>");
		}
		map.put("title1_flow", title1_flow);
		map.put("title2_flow", title2_flow);
		map.put("title3_flow", title3_flow);
		map.put("color1", color1);
		map.put("color2", color2);
		map.put("color3", color3);
		map.put("color4", color4);
		map.put("img1", img1);
		map.put("img2", img2);
		map.put("img3", img3);
		map.put("img4", img4);
		map.put("time1", time1);
		map.put("time2", time2);
		map.put("time3", time3);
		map.put("time4", time4);
		map.put("bg_color1", bg_color1);
		map.put("bg_color2", bg_color2);
		map.put("bg_color3", bg_color3);
		map.put("bg_color4", bg_color4);
		return map;
	
	}
	@Override
	public List<Vehicle> getRunningVehicle() {
		// TODO Auto-generated method stub
		List<Vehicle> vehicles=vehicleDAO.getRunningVehicle();
		for (Vehicle vehicle : vehicles) {
			vehicle.setCreate_name(userDAO.getUserNameByID(vehicle.getCreate_id()));
		}
		return vehicles;
	}

	@Override
	public List<Vehicle> getAllKeyList(String keywords) {
		// TODO Auto-generated method stub
		Map<String,String> map=new HashMap<String,String>();
		map.put("keywords",keywords);
		List<Vehicle> vehicles=vehicleDAO.getAllList();
		
		if(vehicles!=null&&vehicles.size()>0){
			SimpleDateFormat format = new SimpleDateFormat( "yyyy-MM-dd:HH" );
			String[] flowArray=DataUtil.getFlowArray(15);
			Iterator<Vehicle> iterator=vehicles.iterator();
			String[] departmentArray = DataUtil.getdepartment();
			List<Integer> list = new ArrayList<Integer>();
			for (int i=0; i<departmentArray.length;i++) {
				if(departmentArray[i].contains(keywords)){
					list.add(i);
				}
			}
			while (iterator.hasNext()) {
				Vehicle vehicle=(Vehicle)iterator.next();
				User userByID = userDAO.getUserByID(vehicle.getCreate_id());
				if(userByID==null || userByID.getPosition_id()==56){
					iterator.remove();
					continue;
				}
				Flow flow=flowDAO.getNewFlowByFID(15, vehicle.getId());//查询最新流程
				if(flow!=null){
					String process=format.format(flow.getCreate_time())+flowArray[flow.getOperation()];
					vehicle.setProcess(process);
					if(vehicle.getStart_driver_time()==null){
						vehicle.setStart_driver_date("");
					}else{
						vehicle.setStart_driver_date(format.format(vehicle.getStart_driver_time()));
					}
					if(vehicle.getEnd_driver_time()==null){
						vehicle.setEnd_driver_date("");
					}else {
						vehicle.setEnd_driver_date(format.format(vehicle.getEnd_driver_time()));
					}
					vehicle.setCreate_name(userByID.getTruename());
					if(vehicle.getDriver()==0){
						vehicle.setDriverName("");
					}else{
						vehicle.setDriverName(userDAO.getUserNameByID(vehicle.getDriver()));
					}
					if(keywords.equals("") || process.contains(keywords) 
							|| (vehicle.getStart_driver_date()!=null&&vehicle.getStart_driver_date().contains(keywords))
							|| (vehicle.getEnd_driver_date()!=null && vehicle.getEnd_driver_date().contains(keywords)) 
							|| (list.size()>0 && list.contains(vehicle.getApply_department()))
							|| (vehicle.getDriverName()!=null&&vehicle.getDriverName().contains(keywords))
							|| (vehicle.getCreate_name()!=null&&vehicle.getCreate_name().contains(keywords))
							|| (vehicle.getInitial_address()!=null&&vehicle.getInitial_address().contains(keywords))
							|| (vehicle.getAddress()!=null&&vehicle.getAddress().contains(keywords))
							|| (vehicle.getCar_info()!=null&&vehicle.getCar_info().contains(keywords))
							|| (vehicle.getMileage_used()!=null&&vehicle.getMileage_used().contains(keywords))){
					}else {
						iterator.remove();
					}
				}else{
					iterator.remove();
				}
			}
		}
		return vehicles;
	}
	
	@Override
	public List<Vehicle> getAllVehicle() {
		// TODO Auto-generated method stub
		List<Vehicle> vehicles=vehicleDAO.getAllList();
		
		if(vehicles!=null&&vehicles.size()>0){
			SimpleDateFormat format = new SimpleDateFormat( "yyyy-MM-dd:HH" );
			String[] flowArray=DataUtil.getFlowArray(15);
			Iterator<Vehicle> iterator=vehicles.iterator();
			while (iterator.hasNext()) {
				Vehicle vehicle=(Vehicle)iterator.next();
				User userByID = userDAO.getUserByID(vehicle.getCreate_id());
				if(userByID==null || userByID.getPosition_id()==56){
					iterator.remove();
					continue;
				}
				Flow flow=flowDAO.getNewFlowByFID(15, vehicle.getId());//查询最新流程
				if(flow!=null){
					String process=format.format(flow.getCreate_time())+flowArray[flow.getOperation()];
					vehicle.setProcess(process);
					if(vehicle.getStart_driver_time()==null){
						vehicle.setStart_driver_date("");
					}else{
						vehicle.setStart_driver_date(format.format(vehicle.getStart_driver_time()));
					}
					if(vehicle.getEnd_driver_time()==null){
						vehicle.setEnd_driver_date("");
					}else {
						vehicle.setEnd_driver_date(format.format(vehicle.getEnd_driver_time()));
					}
					vehicle.setCreate_name(userByID.getTruename());
					if(vehicle.getDriver()==0){
						vehicle.setDriverName("");
					}else{
						vehicle.setDriverName(userDAO.getUserNameByID(vehicle.getDriver()));
					}
				}else{
					iterator.remove();
				}
			}
		}
		return vehicles;
	}

}
