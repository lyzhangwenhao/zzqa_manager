package com.zzqa.service.interfaces.vehicle;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.vehicle.Vehicle;
import com.zzqa.pojo.user.User;

public interface VehicleManager {
	public int insertVehicle(Vehicle vehicle);
	//修改
	public void updateVehicle(Vehicle vehicle);
	//通过id查询
	public Vehicle getVehicleByID(int id);
	public Vehicle getVehicleByID2(int id);
	//待办事项
	public List<Vehicle> getVehicleByUID(User user);
	public Map<String, String> getVehicleFlowForDraw(Vehicle vehicle,Flow flow);
	//查询未完成
	public List<Vehicle> getRunningVehicle();
	//查询所有
	public List<Vehicle> getAllVehicle();
	public List<Vehicle> getAllKeyList(String keywords);
}
