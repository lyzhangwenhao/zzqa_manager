package com.zzqa.dao.impl.device;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.zzqa.dao.interfaces.device.IDeviceDAO;
import com.zzqa.pojo.device.Device;
@Component("deviceDAO")
public class DeviceDAOImpl implements IDeviceDAO{
	SqlMapClient sqlMapclient = null;

	public SqlMapClient getSqlMapclient() {
		return sqlMapclient;
	}
	@Resource(name="sqlMapClient")
	public void setSqlMapclient(SqlMapClient sqlMapclient) {
		this.sqlMapclient = sqlMapclient;
	}
	public void delDeviceByDeviceID(int m_id) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.delete("device.delDeviceByDeviceID", m_id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public void delDeviceByID(int id) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.delete("device.delDeviceByID", id);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}
	public List getAllDeviceList(){
		List<Device> list = null;
		try {
			list=sqlMapclient.queryForList("device.getAllDeviceList");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
			return new ArrayList<Device>();
		}
		return list;
	}
	public Device getDeviceByID(int id) {
		// TODO Auto-generated method stub
		Device device = null;
		try {
			Object obj = sqlMapclient.queryForObject(
					"device.getDeviceByID", id);
			if (obj != null) {
				device = (Device) obj;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return device;
	}

	public List getDeviceList(int m_id) {
		// TODO Auto-generated method stub
		List<Device> list = null;
		try {
			list = sqlMapclient.queryForList("device.getDeviceList",m_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public List getDeviceListByShipID(int ship_id) {
		// TODO Auto-generated method stub
		List<Device> list = null;
		try {
			list = sqlMapclient.queryForList("device.getDeviceListByShipID",ship_id);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	public void insertDevice(Device device) {
		// TODO Auto-generated method stub
		try {
            sqlMapclient.insert("device.insertDevice", device);
        } catch (SQLException e) {
            e.printStackTrace();
        }
	}

	public void updateDevice(Device device) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update(
					"device.updateDevice",device);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public int getNewDeviceByUpID(int update_id){
		int id=0;
		try {
			Object object=sqlMapclient.queryForObject("device.getNewDeviceByUpID", update_id);
			if(object!=null){
				id=(Integer)object;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return id;
	}
	
	public List getDeviceSN(){
		List<String> list=null;
		try {
			list=sqlMapclient.queryForList("device.getDeviceSN");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public List getFreedomDeviceList() {
		// TODO Auto-generated method stub
		List<Device> list = null;
		try {
			list = sqlMapclient.queryForList("device.getFreedomDeviceList");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	public void updateDeviceOnShip(Device device) {
		// TODO Auto-generated method stub
		try {
			sqlMapclient.update(
					"device.updateDeviceOnShip",device);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Device> getDeviceListByCondition(Map map) {
		// TODO Auto-generated method stub
		List<Device> list = null;
		try {
			list = sqlMapclient.queryForList("device.getDeviceListByCondition",map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

}
