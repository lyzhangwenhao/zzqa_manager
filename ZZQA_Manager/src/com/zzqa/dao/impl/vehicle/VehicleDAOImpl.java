package com.zzqa.dao.impl.vehicle;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.vehicle.IVehicleDAO;
import com.zzqa.pojo.vehicle.Vehicle;
@Component("vehicleDAO")
public class VehicleDAOImpl implements IVehicleDAO {
	private SqlMapClient sqlMapClient;
	public SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

	@Override
	public void insertVehicle(Vehicle vehicle) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.insert("vehicle.insertVehicle", vehicle);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public void updateVehicle(Vehicle vehicle) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.update("vehicle.updateVehicle", vehicle);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public Vehicle getVehicleByID(int id) {
		// TODO Auto-generated method stub
		Vehicle vehicle=null;
		try {
			Object object=sqlMapClient.queryForObject("vehicle.getVehicleByID", id);
			if(object!=null){
				vehicle=(Vehicle)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return vehicle;
	}
	
	@Override
	public void delVehicleByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapClient.delete("vehicle.delVehicleByID", id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public int getNewVehicleIDByCreateID(int create_id) {
		// TODO Auto-generated method stub
		int id=0;
		try {
			Object object=sqlMapClient.queryForObject("vehicle.getNewVehicleIDByCreateID", create_id);
			if(object!=null){
				id=(Integer)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return id;
	}

	@Override
	public List<Vehicle> getRunningVehicle() {
		// TODO Auto-generated method stub
		List<Vehicle> list=null;
		try {
			list=sqlMapClient.queryForList("vehicle.getRunningVehicle");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public List<Vehicle> getAllList(){
		List<Vehicle> list = null;
		try {
            list = sqlMapClient.queryForList("vehicle.getAllList");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
}
