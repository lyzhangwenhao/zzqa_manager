package com.zzqa.dao.interfaces.vehicle;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.vehicle.Vehicle;

public interface IVehicleDAO {
	public void insertVehicle(Vehicle vehicle);
	//修改
	public void updateVehicle(Vehicle vehicle);
	//通过id查询
	public Vehicle getVehicleByID(int id);
	//通过id删除
	public void delVehicleByID(int id);
	//查询用户最新添加的id
	public int getNewVehicleIDByCreateID(int create_id);
	//查询未完成
	public List<Vehicle> getRunningVehicle();
	public List<Vehicle> getAllList();
}
