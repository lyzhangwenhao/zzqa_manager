package com.zzqa.dao.impl.shipments;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.shipments.IShipmentsDAO;
import com.zzqa.pojo.shipments.Shipments;
import com.zzqa.pojo.task.Task;
@Component("shipmentsDAO")
public class ShipmentsDAOImpl implements IShipmentsDAO{
	public SqlMapClient sqlMapclient;
	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}
	public void delShipmentsByID(int id) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.delete("shipments.delShipmentsByID",id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public Shipments getShipmentsByID(int id) {
		// TODO Auto-generated method stub
		Shipments shipments=null;
		try {
			Object object=sqlMapclient.queryForObject("shipments.getShipmentsByID",id);
			if(object!=null){
				shipments=(Shipments)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return shipments;
	}
	
	public Shipments getShipmentsByTaskID(int task_id) {
		// TODO Auto-generated method stub
		Shipments shipments=null;
		try {
			Object object=sqlMapclient.queryForObject("shipments.getShipmentsByTaskID",task_id);
			if(object!=null){
				shipments=(Shipments)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return shipments;
	}

	public List getShipmentsList(Map map) {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("shipments.getShipmentsList",map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	public List getRunningShipments() {
		// TODO Auto-generated method stub
		List list=null;
		try {
			list=sqlMapclient.queryForList("shipments.getRunningShipments");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	public void insertshipments(Shipments shipments) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("shipments.insertshipments", shipments);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void updateShipments(Shipments shipments) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.insert("shipments.updateShipments", shipments);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public int getNewShipmentsByUID(int uid){
		int id=0;
		try {
			Object object=sqlMapclient.queryForObject("shipments.getNewShipmentsByUID", uid);
			if(object!=null){
				id=(Integer)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return id;
	}
	public List getAllList(){
		List list = null;
		try {
            list = sqlMapclient.queryForList("shipments.getAllList");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
	}
}
